Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B665C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786232082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054000;
	bh=/NRaRJ0jp8elJzijBdTeELMvF+Ynqa9zz4v4LSQZ5ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XuqIu1R1XAShTZj3u6L66CII4hspOr6mG9qcnsSwgv2aArvGlMd7mREeUu9KZ0p3r
	 FVcjgUDs9s3AjknUOGBMhbP3KX3BhyyN81MDjDo/6ktJ9tRKP/CYFsZGFSATkgX3bB
	 xx9lAhGg6dJgh1WLmC83Lfh5bH55G3j7/+4+lNyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfFTSGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbfFTSGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:06:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D92C3215EA;
        Thu, 20 Jun 2019 18:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053996;
        bh=/NRaRJ0jp8elJzijBdTeELMvF+Ynqa9zz4v4LSQZ5ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQz4kUScaVM6kTbo2j6iWJVv2L4z2WdKcFVD1l+vOs2sPHxmxx0vrvoV6v6m9W3Cm
         43LmDoft3jotNTiF35AnPM21ebuMzl1VZZ2GhIxM4l6IchyAEQAs6b8N6ROv27eGiq
         yR30wGIKhr32tTpxTLQAJPzfwhaPE8/lnUQqEAoA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 099/117] mISDN: make sure device name is NUL terminated
Date:   Thu, 20 Jun 2019 19:57:13 +0200
Message-Id: <20190620174357.769992972@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index f96b8f2bdf74..d7c986fb0b3b 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -394,7 +394,7 @@ data_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			memcpy(di.channelmap, dev->channelmap,
 			       sizeof(di.channelmap));
 			di.nrbchan = dev->nrbchan;
-			strcpy(di.name, dev_name(&dev->dev));
+			strscpy(di.name, dev_name(&dev->dev), sizeof(di.name));
 			if (copy_to_user((void __user *)arg, &di, sizeof(di)))
 				err = -EFAULT;
 		} else
@@ -678,7 +678,7 @@ base_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			memcpy(di.channelmap, dev->channelmap,
 			       sizeof(di.channelmap));
 			di.nrbchan = dev->nrbchan;
-			strcpy(di.name, dev_name(&dev->dev));
+			strscpy(di.name, dev_name(&dev->dev), sizeof(di.name));
 			if (copy_to_user((void __user *)arg, &di, sizeof(di)))
 				err = -EFAULT;
 		} else
@@ -692,6 +692,7 @@ base_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			err = -EFAULT;
 			break;
 		}
+		dn.name[sizeof(dn.name) - 1] = '\0';
 		dev = get_mdevice(dn.id);
 		if (dev)
 			err = device_rename(&dev->dev, dn.name);
-- 
2.20.1



