Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4CDC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152F520674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413835;
	bh=Kbrdk6gUhA9oPjNwOJm4QFALTESiSeqyghcvP1iJWYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lMiKhFIJYaOATCp3LsEqVflLr/qc9YNExLFaOPBG6boAxYV3HqBSW6SFtQLDN7XyU
	 m4Th+ItcVnmoldR3LgdVyTY9vT81gZcOMorrDs3aiTao+gOWqPYZ+MLDSzNHGkRass
	 T0pxcDdpTD1LayPf2kHyGVVjYbX49I1gjmYJBIVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfLCW5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:57:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730520AbfLCW5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:57:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C4412053B;
        Tue,  3 Dec 2019 22:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413827;
        bh=Kbrdk6gUhA9oPjNwOJm4QFALTESiSeqyghcvP1iJWYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MfEOpiUnvjPkc0X41rcSUk+glWw7+n6QeFr+ARoEY95PEhBC1wnONPO7geHt9mIc1
         PHsC6UKLj+7LoQ7fElgVwtDluphs2NhshNzToC2TMR9UHpoWqo1IXt8zfspxW1PSot
         FQlkgzzcS8f3sBhC2BEey0AzrmK1Q9c7KN9sjjJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.19 277/321] media: v4l2-ctrl: fix flags for DO_WHITE_BALANCE
Date:   Tue,  3 Dec 2019 23:35:43 +0100
Message-Id: <20191203223441.537425529@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

commit a0816e5088baab82aa738d61a55513114a673c8e upstream.

Control DO_WHITE_BALANCE is a button, with read only and execute-on-write flags.
Adding this control in the proper list in the fill function.

After adding it here, we can see output of v4l2-ctl -L
do_white_balance 0x0098090d (button) : flags=write-only, execute-on-write

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/v4l2-ctrls.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -1145,6 +1145,7 @@ void v4l2_ctrl_fill(u32 id, const char *
 	case V4L2_CID_FLASH_STROBE_STOP:
 	case V4L2_CID_AUTO_FOCUS_START:
 	case V4L2_CID_AUTO_FOCUS_STOP:
+	case V4L2_CID_DO_WHITE_BALANCE:
 		*type = V4L2_CTRL_TYPE_BUTTON;
 		*flags |= V4L2_CTRL_FLAG_WRITE_ONLY |
 			  V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;


