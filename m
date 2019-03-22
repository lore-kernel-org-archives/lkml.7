Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948D6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B546218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258189;
	bh=GaL1qzGgmeeAnuALu0HDCeUgRWikgrYQZRgkUj6fWbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g0Lt6X1n9JD0he0pRod5JHPc/wLtfPIJL7fNv/5dI0LUn+7LejxYz/7gnIowKELDn
	 YxiYpUu3L0bs5Ay7O1P23Ac5QB3pvYFf4uV5piFWlnE+DYffKSIN6Bg8jKdDgxL/Yv
	 EXRvqkOSb81UOLoKFzgBpTdTK6SE2Vqg7WTfAh3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389651AbfCVMg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389287AbfCVMLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:11:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B884F2082C;
        Fri, 22 Mar 2019 12:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256666;
        bh=GaL1qzGgmeeAnuALu0HDCeUgRWikgrYQZRgkUj6fWbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h06OG9+Z6mHjxS9He6owXeRhlBJVy2lFrSQi0hzQa9nE8RSzoUQqYAfO2naYBzAeW
         FA1wt1+cQFF57VIuKaHzH3ZMexmi2zn1DWK51AXNKGM8RNuO/C2Vvp4huhSv3x/zbB
         DAsXcfnLoJfXT0ssR3XlXYWXZEwUeXH8enMia8XM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick French <naf@ou.edu>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Adam Stylinski <kungfujesus06@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 264/280] media: lgdt330x: fix lock status reporting
Date:   Fri, 22 Mar 2019 12:16:57 +0100
Message-Id: <20190322111344.634765469@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: French, Nicholas A <naf@ou.edu>

commit 1b4fd9de6ec7f3722c2b3e08cc5ad171c11f93be upstream.

A typo in code cleanup commit db9c1007bc07 ("media: lgdt330x: do
some cleanups at status logic") broke the FE_HAS_LOCK reporting
for 3303 chips by inadvertently modifying the register mask.

The broken lock status is critial as it prevents video capture
cards from reporting signal strength, scanning for channels,
and capturing video.

Fix regression by reverting mask change.

Cc: stable@vger.kernel.org # Kernel 4.17+
Fixes: db9c1007bc07 ("media: lgdt330x: do some cleanups at status logic")
Signed-off-by: Nick French <naf@ou.edu>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Adam Stylinski <kungfujesus06@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/dvb-frontends/lgdt330x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/dvb-frontends/lgdt330x.c
+++ b/drivers/media/dvb-frontends/lgdt330x.c
@@ -783,7 +783,7 @@ static int lgdt3303_read_status(struct d
 
 		if ((buf[0] & 0x02) == 0x00)
 			*status |= FE_HAS_SYNC;
-		if ((buf[0] & 0xfd) == 0x01)
+		if ((buf[0] & 0x01) == 0x01)
 			*status |= FE_HAS_VITERBI | FE_HAS_LOCK;
 		break;
 	default:


