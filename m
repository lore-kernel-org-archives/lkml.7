Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE92CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF3620873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LctBUarB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbfJ1Tbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 15:31:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43987 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbfJ1Tbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 15:31:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id l24so7570258pgh.10;
        Mon, 28 Oct 2019 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=v3kvJXcbFkEV09nvemioGfRfs68Gl22rKf+fp6o5KcY=;
        b=LctBUarBHVK+LJbiZaWPtVv840QdYut23jNX11CEvVa2GTB+Cqj8uGEUiMDecRg3u9
         Oc883co3hZ2QPb/Wk4mFmt8ONSqTXe1eLQmY6B0AQtKRNo6aqM4/heaWD5jH/KwddO35
         e6XwAQnuC1AZyuan2Tjw78hTpfDD92WML2gdaBxgmnoSNWuksWfzCIxjVLfm5XkuENIW
         7kLoxZ/ku/P2/xGOpSWBatIDhCCxhbJRR17gk++qyYgW25Cu+HisQfle1plHYPGBRaxT
         c9YlB+2UJhKJsnzy0aKriViry3erD7kqGmJTFdZ4LPN1Tav43/ZKd6R6XHJXKnLTMRl4
         59Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=v3kvJXcbFkEV09nvemioGfRfs68Gl22rKf+fp6o5KcY=;
        b=I1NhZn934pibWzYQGjHZz3cYaQkhONfvL+OFu52Xr63hNADiJVq6XeYYrvhOiTl8wu
         eK0vYoavfytvwUlIHQu+05qJpeL5XeVmWVULsEWfnA7cv62c7YdV4c9Ntq9wwWfwY4ty
         KzgPwsWiusbnlSJJIhkH/xZM/X2pZZJdVqytnggNkkoTntlWlATu27WSP0B6K3aqFZko
         8CPAi134MpfeA0zdqyG3okcHSprJhVcCFe9VZ0c99BSDqOxTFYorpyOox1FxC3liSAqy
         CbR47i4DPjx3YVzqwyqDGMr83tkSkxKvo9BWoLKNbMD8oTWQwiugdE/pO2lvTyUWS9WJ
         9Z2w==
X-Gm-Message-State: APjAAAUEiBLZLUsn+g4dcmSYgKeUrtbtV/gVSab5+9lI/dyojVv0mZ1m
        VKx3EuBEU695bgKpbCMF5iw=
X-Google-Smtp-Source: APXvYqx7+MIEfdKiVnMEN7PjAvsyZ5OvKzpcY6m0rvve3YkFqyxZZyvnq3JWYwB4Q9IZ5klZwXgZ7w==
X-Received: by 2002:a17:90a:6302:: with SMTP id e2mr1225776pjj.20.1572291107424;
        Mon, 28 Oct 2019 12:31:47 -0700 (PDT)
Received: from saurav ([27.62.167.137])
        by smtp.gmail.com with ESMTPSA id j14sm11884901pfi.168.2019.10.28.12.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 12:31:46 -0700 (PDT)
Date:   Tue, 29 Oct 2019 01:01:40 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] usb: musb: Fix external abort on non-linefetch
Message-ID: <20191028193140.GA27668@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While setting the usb mode from sysfs. Below error came on kernel
version 4.19.

On latest kernel vserion api name changed. Therefore API
name and backtrace API name are different.

    [  821.908066] Backtrace:
    [  821.910695] [<bf078fc0>] (musb_default_readl [musb_hdrc]) from [<bf0af738>] (dsps_musb_set_mode+0x38/0x12c [musb_dsps])
    [  821.922059] [<bf0af700>] (dsps_musb_set_mode [musb_dsps]) from [<bf07899c>] (musb_mode_store+0xc8/0x12c [musb_hdrc])
    [  821.933105]  r7:a0010013 r6:0000000b r5:cd79d200 r4:cb634010
    [  821.939096] [<bf0788d4>] (musb_mode_store [musb_hdrc]) from [<c0425184>] (dev_attr_store+0x20/0x2c)
    [  821.948593]  r7:cd79d200 r6:c5abbf78 r5:00000000 r4:bf0788d4
    [  821.954549] [<c0425164>] (dev_attr_store) from [<c0285b08>] (sysfs_kf_write+0x48/0x4c)
    [  821.962859]  r5:00000000 r4:c0425164
    [  821.966620] [<c0285ac0>] (sysfs_kf_write) from [<c0285274>] (kernfs_fop_write+0xfc/0x1fc)
    [  821.975200]  r5:00000000 r4:cd79d080
    [  821.978966] [<c0285178>] (kernfs_fop_write) from [<c020ec00>] (__vfs_write+0x34/0x120)
    [  821.987280]  r10:00000000 r9:0000000b r8:00000000 r7:0000000b r6:c5abbf78 r5:c0285178
    [  821.995493]  r4:cb67a3c0
    [  821.998160] [<c020ebcc>] (__vfs_write) from [<c020fae8>] (vfs_write+0xa8/0x170)
    [  822.005835]  r9:0000000b r8:00000000 r7:c5abbf78 r6:000def80 r5:cb67a3c0 r4:0000000b
    [  822.013969] [<c020fa40>] (vfs_write) from [<c02108d0>] (SyS_write+0x44/0x98)
    [  822.021371]  r9:0000000b r8:000def80 r7:00000000 r6:00000000 r5:cb67a3c0 r4:cb67a3c0
    [  822.029517] [<c021088c>] (SyS_write) from [<c010d8a0>] (ret_fast_syscall+0x0/0x3c)
    [  822.037467]  r9:c5aba000 r8:c010daa8 r7:00000004 r6:b6f0ad58 r5:000def80 r4:0000000b
    [  822.045599] Code: e1a0c00d e92dd800 e24cb004 e0801001 (e5910000)

    Without pm_runtime_{get,put}_sync calls in place,
    Similar issue come on "mode_show" and "vbus_store" also.

    fix- call pm_runtime_{get,put}_sync before reading/writing
    usb mode/vbus from sysfs.

    As sugguested on commit '2d15f69ed5c1c33f283e77ec161578badde33eaf'
    Merged all the fix which reslove same bug in the same file.
    "
      commit '2d15f69ed5c1c33f283e77ec161578badde33eaf'
      Author: Saurav Girepunje <saurav.girepunje@gmail.com>
      Date:   Thu Aug 8 00:05:03 2019 +0530

      usb: musb: Fix external abort on non-linefetch for vbus_store

      Without pm_runtime_{get,put}_sync calls in place, writing
      vbus value via /sys causes the error

      "Unhandled fault external abort on non-linefetch"

        On Thu, Aug 08, 2019 at 12:11:46AM +0530, Saurav Girepunje wrote:
	> Without pm_runtime_{get,put}_sync calls in place, writing
	> vbus value via /sys causes the error
	>
	> "Unhandled fault external abort on non-linefetch"
	>
	> Signed-off-by: Saurav Girepunje <saurav.girepunje@xxxxxxxxx>

	Thanks for the patch. Can you please merge another two similar patches
	you just sent with this one? They all fix the same bug in the same file
	so could be just in one patch.

	-Bin.
    "

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/usb/musb/musb_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index bd63450af76a..dc7d786feb58 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1723,9 +1723,11 @@ mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 	unsigned long flags;
 	int ret;
 
+	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&musb->lock, flags);
 	ret = sprintf(buf, "%s\n", usb_otg_state_string(musb->xceiv->otg->state));
 	spin_unlock_irqrestore(&musb->lock, flags);
+	pm_runtime_put_sync(dev);
 
 	return ret;
 }
@@ -1738,6 +1740,7 @@ mode_store(struct device *dev, struct device_attribute *attr,
 	unsigned long	flags;
 	int		status;
 
+	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&musb->lock, flags);
 	if (sysfs_streq(buf, "host"))
 		status = musb_platform_set_mode(musb, MUSB_HOST);
@@ -1748,6 +1751,7 @@ mode_store(struct device *dev, struct device_attribute *attr,
 	else
 		status = -EINVAL;
 	spin_unlock_irqrestore(&musb->lock, flags);
+	pm_runtime_put_sync(dev);
 
 	return (status == 0) ? n : status;
 }
@@ -1766,6 +1770,7 @@ vbus_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 	}
 
+	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&musb->lock, flags);
 	/* force T(a_wait_bcon) to be zero/unlimited *OR* valid */
 	musb->a_wait_bcon = val ? max_t(int, val, OTG_TIME_A_WAIT_BCON) : 0 ;
@@ -1773,6 +1778,7 @@ vbus_store(struct device *dev, struct device_attribute *attr,
 		musb->is_active = 0;
 	musb_platform_try_idle(musb, jiffies + msecs_to_jiffies(val));
 	spin_unlock_irqrestore(&musb->lock, flags);
+	pm_runtime_put_sync(dev);
 
 	return n;
 }
-- 
2.20.1

