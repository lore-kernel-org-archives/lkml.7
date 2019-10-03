Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F686C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D61A2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121368;
	bh=3vz0jGokF/tADKiAtasvrTU/In2SROOiBNXQon2ojrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=epMJVgaTEaSFZYNc+D67noKsakZaKgJh1kBwEO954jVhRPdByE/+huXGnzEigrpe0
	 xTMk7YC5RC6EbzBFybPxYPIDgkt6Yi52iqW2dfCkoNaBCsJx5BFEVHHm/SiX/wIxu4
	 mGn7UWWivvEGUsUZOgNLrMQ4dKZtSBc2Nz1SOWr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405601AbfJCQt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:49:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393067AbfJCQtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:49:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96D82215EA;
        Thu,  3 Oct 2019 16:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121362;
        bh=3vz0jGokF/tADKiAtasvrTU/In2SROOiBNXQon2ojrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMb5BCRvTYsh1W9nVqjRh2s3qAHns1MPv3eFnedgF93NXNYoiLeStfExXe5kEITR3
         MNMC8gpXfdlWgTWUFiZ3Ub+0iEJknLKnrotDNzYYCR5EgowRqzKI8SvhW89VzyzqDN
         sOuEQc1hfOZXlPPc7uTM6GTjDg5YjG8SahtIuZ+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Bortoli <tomasbortoli@gmail.com>,
        syzbot+0522702e9d67142379f1@syzkaller.appspotmail.com,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 223/344] media: ttusb-dec: Fix info-leak in ttusb_dec_send_command()
Date:   Thu,  3 Oct 2019 17:53:08 +0200
Message-Id: <20191003154602.379734889@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Bortoli <tomasbortoli@gmail.com>

[ Upstream commit a10feaf8c464c3f9cfdd3a8a7ce17e1c0d498da1 ]

The function at issue does not always initialize each byte allocated
for 'b' and can therefore leak uninitialized memory to a USB device in
the call to usb_bulk_msg()

Use kzalloc() instead of kmalloc()

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+0522702e9d67142379f1@syzkaller.appspotmail.com
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/ttusb-dec/ttusb_dec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/ttusb-dec/ttusb_dec.c b/drivers/media/usb/ttusb-dec/ttusb_dec.c
index 1d0afa340f47c..3198f9624b7c0 100644
--- a/drivers/media/usb/ttusb-dec/ttusb_dec.c
+++ b/drivers/media/usb/ttusb-dec/ttusb_dec.c
@@ -319,7 +319,7 @@ static int ttusb_dec_send_command(struct ttusb_dec *dec, const u8 command,
 
 	dprintk("%s\n", __func__);
 
-	b = kmalloc(COMMAND_PACKET_SIZE + 4, GFP_KERNEL);
+	b = kzalloc(COMMAND_PACKET_SIZE + 4, GFP_KERNEL);
 	if (!b)
 		return -ENOMEM;
 
-- 
2.20.1



