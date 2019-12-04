Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A49EC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256002086D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482428;
	bh=IDBQpqKVBAOAaxrln5nPfxfusa9Xx5BrmNRQKJ4nojc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cger2yzX3fokYtID8sqBybAmXA+NL3/F+N6+9S6PiEoDN4b9fXXbTmnN9IeiEr4OF
	 9m+WjJ+1anP2AFQ8VL3Aasq0C3wptCzg2B59cgVrcbVVuYlUkuERTON06bZrShR63x
	 G+Z4Ds8gQetzstH1mbYFLT1ZCXo0pKuzFnwdx9Ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfLDSA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:00:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbfLDSAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:00:24 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36F262073B;
        Wed,  4 Dec 2019 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482423;
        bh=IDBQpqKVBAOAaxrln5nPfxfusa9Xx5BrmNRQKJ4nojc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPV/mBTpIkReF30PiAO1LEHrklwbeu8vm35IQcQkqOgxPwTSCmNAqbbjNfHWlV0NJ
         T2pUdwq8wctYurEx/O5vs9dGCdmOgoKsFf8LVZPdwR8j955G3vA8sZeNw/Ud/UY+HS
         iZ4J5iyWdqtfi/a+/7c7IhGf9P6/DPdZgwihvbE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.4 80/92] media: v4l2-ctrl: fix flags for DO_WHITE_BALANCE
Date:   Wed,  4 Dec 2019 18:50:20 +0100
Message-Id: <20191204174335.032162156@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
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
@@ -991,6 +991,7 @@ void v4l2_ctrl_fill(u32 id, const char *
 	case V4L2_CID_FLASH_STROBE_STOP:
 	case V4L2_CID_AUTO_FOCUS_START:
 	case V4L2_CID_AUTO_FOCUS_STOP:
+	case V4L2_CID_DO_WHITE_BALANCE:
 		*type = V4L2_CTRL_TYPE_BUTTON;
 		*flags |= V4L2_CTRL_FLAG_WRITE_ONLY |
 			  V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;


