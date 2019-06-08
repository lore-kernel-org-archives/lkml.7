Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8AFC468BC
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E1E21537
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994874;
	bh=nEb1zAS/vkvfyNKiFKLlJ8Y5ry0Za8zJnvEN+5NM24k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U1Q/AfNdVD4St8HKnq2TeD8ZDPPxwkLc0B7Kob8+Dyii/nSoyW9A/HSk5lPdw1BI0
	 XEomSVy3XydweR0PFQ4xNM741sdTl6IzQ6SrtIJ+N7LObIs0WJrnVNBQ99xejkvM9q
	 yHrYRqv/lyUVVnWxlrsq+4bgQNdvaB5itpJLeVac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfFHLk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbfFHLkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:40:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 234C1208C0;
        Sat,  8 Jun 2019 11:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994019;
        bh=nEb1zAS/vkvfyNKiFKLlJ8Y5ry0Za8zJnvEN+5NM24k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dBEEWixoDlOzFExFwaIhLVSCdMKc+aS+LKSRDLRVzZKeaYfaPMtnLjamgJgkQscZT
         cU/7doaad60jeQsOJSnhpjym9SWXh5tkoOKSs0Jn30TydqrM7gW/bZnj2r1FdUHCJk
         de8sOc3MI+5petwf3MliCHDS5ukXNVvxMIhA2zas=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 19/70] mISDN: make sure device name is NUL terminated
Date:   Sat,  8 Jun 2019 07:38:58 -0400
Message-Id: <20190608113950.8033-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608113950.8033-1-sashal@kernel.org>
References: <20190608113950.8033-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit ccfb62f27beb295103e9392462b20a6ed807d0ea ]

The user can change the device_name with the IMSETDEVNAME ioctl, but we
need to ensure that the user's name is NUL terminated.  Otherwise it
could result in a buffer overflow when we copy the name back to the user
with IMGETDEVINFO ioctl.

I also changed two strcpy() calls which handle the name to strscpy().
Hopefully, there aren't any other ways to create a too long name, but
it's nice to do this as a kernel hardening measure.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/isdn/mISDN/socket.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
index a14e35d40538..84e1d4c2db66 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -393,7 +393,7 @@ data_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			memcpy(di.channelmap, dev->channelmap,
 			       sizeof(di.channelmap));
 			di.nrbchan = dev->nrbchan;
-			strcpy(di.name, dev_name(&dev->dev));
+			strscpy(di.name, dev_name(&dev->dev), sizeof(di.name));
 			if (copy_to_user((void __user *)arg, &di, sizeof(di)))
 				err = -EFAULT;
 		} else
@@ -676,7 +676,7 @@ base_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			memcpy(di.channelmap, dev->channelmap,
 			       sizeof(di.channelmap));
 			di.nrbchan = dev->nrbchan;
-			strcpy(di.name, dev_name(&dev->dev));
+			strscpy(di.name, dev_name(&dev->dev), sizeof(di.name));
 			if (copy_to_user((void __user *)arg, &di, sizeof(di)))
 				err = -EFAULT;
 		} else
@@ -690,6 +690,7 @@ base_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			err = -EFAULT;
 			break;
 		}
+		dn.name[sizeof(dn.name) - 1] = '\0';
 		dev = get_mdevice(dn.id);
 		if (dev)
 			err = device_rename(&dev->dev, dn.name);
-- 
2.20.1

