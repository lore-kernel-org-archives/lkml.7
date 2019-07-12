Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE46C742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5282E20863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562917016;
	bh=xbkZ/Oq5oDy1re5CaXwMMAkzfuy4exkGQY4fFBabPeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yMUw4O+LcV2Dt8w8Y3tXqFNe8lSvCe1jIEHd27GwPDRx8IsjuEbnJ8X5qp74VRMZj
	 yulL8blC/wK1deu447LEGK01gTJ5z/jQF26BcTux7wSWZI3a7Dr1iR1z93nT+u9lmr
	 1ge76S+isUvZ+JhYRLiCV2gPJzMwoED/Pb5FJoGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfGLHgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 03:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfGLHgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:36:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEEA820863;
        Fri, 12 Jul 2019 07:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562917013;
        bh=xbkZ/Oq5oDy1re5CaXwMMAkzfuy4exkGQY4fFBabPeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zZEtnCwnnucMx98snEsSPIkrXlyv9jx/eKYeQlRg5jeC7cOMpBj17tsSoId5UyktT
         naDzHdgOMdifSp6cQaFqELrSDcFMmXkhC4LKMOvkmDleMqJd6RSVvbsZ8bKsloNue5
         CJkdAOHTxwhV3ij9+QNtBVXEN1xbQ0k5Pw7zA9Pc=
Date:   Fri, 12 Jul 2019 09:36:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] Driver core patches for 5.3-rc1
Message-ID: <20190712073650.GB16253@kroah.com>
References: <20190712073623.GA16253@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712073623.GA16253@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 09:36:23AM +0200, Greg KH wrote:
> The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:
> 
>   Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.3-rc1
> 
> for you to fetch changes up to c33d442328f556460b79aba6058adb37bb555389:
> 
>   debugfs: make error message a bit more verbose (2019-07-08 10:44:57 +0200)
> 
> ----------------------------------------------------------------
> Driver Core and debugfs changes for 5.3-rc1
> 
> Here is the "big" driver core and debugfs changes for 5.3-rc1
> 
> It's a lot of different patches, all across the tree due to some api
> changes and lots of debugfs cleanups.  Because of this, there is going
> to be some merge issues with your tree at the moment, I'll follow up
> with the expected resolutions to make it easier for you.

Here's the merge resolution patch that worked for me:


diff --cc drivers/acpi/sleep.c
index fcf4386ecc78,f0fe7c15d657..000000000000
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
diff --cc drivers/misc/mei/debugfs.c
index df6bf8b81936,47cfd5005e1b..000000000000
--- a/drivers/misc/mei/debugfs.c
+++ b/drivers/misc/mei/debugfs.c
@@@ -233,22 -154,46 +154,21 @@@ void mei_dbgfs_deregister(struct mei_de
   *
   * @dev: the mei device structure
   * @name: the mei device name
 - *
 - * Return: 0 on success, <0 on failure.
   */
 -int mei_dbgfs_register(struct mei_device *dev, const char *name)
 +void mei_dbgfs_register(struct mei_device *dev, const char *name)
  {
 -	struct dentry *dir, *f;
 +	struct dentry *dir;
  
  	dir = debugfs_create_dir(name, NULL);
 -	if (!dir)
 -		return -ENOMEM;
 -
  	dev->dbgfs_dir = dir;
  
 -	f = debugfs_create_file("meclients", S_IRUSR, dir,
 -				dev, &mei_dbgfs_meclients_fops);
 -	if (!f) {
 -		dev_err(dev->dev, "meclients: registration failed\n");
 -		goto err;
 -	}
 -	f = debugfs_create_file("active", S_IRUSR, dir,
 -				dev, &mei_dbgfs_active_fops);
 -	if (!f) {
 -		dev_err(dev->dev, "active: registration failed\n");
 -		goto err;
 -	}
 -	f = debugfs_create_file("devstate", S_IRUSR, dir,
 -				dev, &mei_dbgfs_devstate_fops);
 -	if (!f) {
 -		dev_err(dev->dev, "devstate: registration failed\n");
 -		goto err;
 -	}
 -	f = debugfs_create_file("allow_fixed_address", S_IRUSR | S_IWUSR, dir,
 -				&dev->allow_fixed_address,
 -				&mei_dbgfs_allow_fa_fops);
 -	if (!f) {
 -		dev_err(dev->dev, "allow_fixed_address: registration failed\n");
 -		goto err;
 -	}
 -	return 0;
 -err:
 -	mei_dbgfs_deregister(dev);
 -	return -ENODEV;
 +	debugfs_create_file("meclients", S_IRUSR, dir, dev,
- 			    &mei_dbgfs_fops_meclients);
++			    &mei_dbgfs_meclients_fops);
 +	debugfs_create_file("active", S_IRUSR, dir, dev,
- 			    &mei_dbgfs_fops_active);
++			    &mei_dbgfs_active_fops);
 +	debugfs_create_file("devstate", S_IRUSR, dir, dev,
- 			    &mei_dbgfs_fops_devstate);
++			    &mei_dbgfs_devstate_fops);
 +	debugfs_create_file("allow_fixed_address", S_IRUSR | S_IWUSR, dir,
 +			    &dev->allow_fixed_address,
- 			    &mei_dbgfs_fops_allow_fa);
++			    &mei_dbgfs_allow_fa_fops);
  }
- 
diff --cc drivers/misc/vmw_balloon.c
index fdf5ad757226,043eed845246..000000000000
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@@ -1553,15 -1942,26 +1932,24 @@@ static int __init vmballoon_init(void
  	if (x86_hyper_type != X86_HYPER_VMWARE)
  		return -ENODEV;
  
- 	for (page_size = VMW_BALLOON_4K_PAGE;
- 	     page_size <= VMW_BALLOON_LAST_SIZE; page_size++)
- 		INIT_LIST_HEAD(&balloon.page_sizes[page_size].pages);
- 
- 
  	INIT_DELAYED_WORK(&balloon.dwork, vmballoon_work);
  
+ 	error = vmballoon_register_shrinker(&balloon);
+ 	if (error)
+ 		goto fail;
+ 
 -	error = vmballoon_debugfs_init(&balloon);
 -	if (error)
 -		goto fail;
 +	vmballoon_debugfs_init(&balloon);
  
+ 	/*
+ 	 * Initialization of compaction must be done after the call to
+ 	 * balloon_devinfo_init() .
+ 	 */
+ 	balloon_devinfo_init(&balloon.b_dev_info);
+ 	error = vmballoon_compaction_init(&balloon);
+ 	if (error)
+ 		goto fail;
+ 
+ 	INIT_LIST_HEAD(&balloon.huge_pages);
  	spin_lock_init(&balloon.comm_lock);
  	init_rwsem(&balloon.conf_sem);
  	balloon.vmci_doorbell = VMCI_INVALID_HANDLE;
* Unmerged path drivers/hwtracing/coresight/of_coresight.c
