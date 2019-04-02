Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F6CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075A0207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gkNxadpW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aTIDo5jD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfDBGEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:04:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36880 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfDBGEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:04:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 85C1A60736; Tue,  2 Apr 2019 06:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554185046;
        bh=j3TaLKILwoojhEa8Hc8x5lk6ssJkj8BCJh364KEsZRI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=gkNxadpWBW43SYXRIMunuNOYMEELnTsj8b94zhWyVUiYif6S9TVPIXns25ZuBOWly
         c7ddQKZ0Tz7RyYzS5/7iOEVTP2F8ZH+faqOMeMc0owSNBgFzmk8qX0KPbTnmf6hZPH
         +CJ9nH/Ho90/WOQJ73E7CjSsraTBh0omSwKqP8co=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93B9D602F2;
        Tue,  2 Apr 2019 06:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554185045;
        bh=j3TaLKILwoojhEa8Hc8x5lk6ssJkj8BCJh364KEsZRI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=aTIDo5jDDRvJDdieKG4cUT//QtMD3eI77S7kit1LnLKhNQWPTdHLg4xOfz2BMU/Q+
         YSi/VicRgWHji1XsW0zTLRCcAezCp3YpDrJMaUlN5ycgD8kT41E2KBIkAE0TF2ZuuL
         +xU4O4abIqIL7lcPJGYmu3vIF9tLSqfIsBobzhO4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93B9D602F2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] Input: uinput - Avoid Use-After-Free with udev lock
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1553767582-15318-1-git-send-email-mojha@codeaurora.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <9d1f5731-aaa1-844e-12a2-439a93356c25@codeaurora.org>
Date:   Tue, 2 Apr 2019 11:34:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553767582-15318-1-git-send-email-mojha@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't consider this patch, i will send v2 of this.


Thanks,
Mukesh

On 3/28/2019 3:36 PM, Mukesh Ojha wrote:
> uinput_destroy_device() gets called from two places. In one place,
> uinput_ioctl_handler() it is protected under a lock udev->mutex
> but same is not true for other place inside uinput_release().
>
> This can result in a race where udev device gets freed while it
> is in use.
>
> [  160.093398] Call trace:
> [  160.093417]  kernfs_get+0x64/0x88
> [  160.093438]  kernfs_new_node+0x94/0xc8
> [  160.093450]  kernfs_create_dir_ns+0x44/0xfc
> [  160.093463]  sysfs_create_dir_ns+0xa8/0x130
> [  160.093479]  kobject_add_internal+0x278/0x650
> [  160.093491]  kobject_add_varg+0xe0/0x130
> [  160.093502]  kobject_add+0x15c/0x1d0
> [  160.093518]  device_add+0x2bc/0xde0
> [  160.093533]  input_register_device+0x5f4/0xa0c
> [  160.093547]  uinput_ioctl_handler+0x1184/0x2198
> [  160.093560]  uinput_ioctl+0x38/0x48
> [  160.093573]  vfs_ioctl+0x7c/0xb4
> [  160.093585]  do_vfs_ioctl+0x9ec/0x2350
> [  160.093597]  SyS_ioctl+0x6c/0xa4
> [  160.093610]  el0_svc_naked+0x34/0x38
> [  160.093621] ---[ end trace bccf0093cda2c538 ]---
> [  160.099041] =============================================================================
> [  160.107459] BUG kernfs_node_cache (Tainted: G S      W  O   ): Object already free
> [  160.115235] -----------------------------------------------------------------------------
> [  160.115235]
> [  160.125151] Disabling lock debugging due to kernel taint
> [  160.130626] INFO: Allocated in __kernfs_new_node+0x8c/0x3c0 age=11 cpu=2 pid=7098
> [  160.138314] 	kmem_cache_alloc+0x358/0x388
> [  160.142445] 	__kernfs_new_node+0x8c/0x3c0
> [  160.146590] 	kernfs_new_node+0x80/0xc8
> [  160.150462] 	kernfs_create_dir_ns+0x44/0xfc
> [  160.154777] 	sysfs_create_dir_ns+0xa8/0x130
> [  160.158416] CPU5: update max cpu_capacity 1024
> [  160.159085] 	kobject_add_internal+0x278/0x650
> [  160.163567] 	kobject_add_varg+0xe0/0x130
> [  160.167606] 	kobject_add+0x15c/0x1d0
> [  160.168452] CPU5: update max cpu_capacity 780
> [  160.171287] 	get_device_parent+0x2d0/0x34c
> [  160.175510] 	device_add+0x240/0xde0
> [  160.178371] CPU6: update max cpu_capacity 916
> [  160.179108] 	input_register_device+0x5f4/0xa0c
> [  160.183686] 	uinput_ioctl_handler+0x1184/0x2198
> [  160.188346] 	uinput_ioctl+0x38/0x48
> [  160.191941] 	vfs_ioctl+0x7c/0xb4
> [  160.195261] 	do_vfs_ioctl+0x9ec/0x2350
> [  160.199111] 	SyS_ioctl+0x6c/0xa4
> [  160.202436] INFO: Freed in kernfs_put+0x2c8/0x434 age=14 cpu=0 pid=7096
> [  160.209230] 	kernfs_put+0x2c8/0x434
> [  160.212825] 	kobject_del+0x50/0xcc
> [  160.216332] 	cleanup_glue_dir+0x124/0x16c
> [  160.220456] 	device_del+0x55c/0x5c8
> [  160.224047] 	__input_unregister_device+0x274/0x2a8
> [  160.228974] 	input_unregister_device+0x90/0xd0
> [  160.233553] 	uinput_destroy_device+0x15c/0x1dc
> [  160.238131] 	uinput_release+0x44/0x5c
> [  160.241898] 	__fput+0x1f4/0x4e4
> [  160.245127] 	____fput+0x20/0x2c
> [  160.248358] 	task_work_run+0x9c/0x174
> [  160.252127] 	do_notify_resume+0x104/0x6bc
> [  160.256253] 	work_pending+0x8/0x14
> [  160.259751] INFO: Slab 0xffffffbf0215ff00 objects=33 used=11 fp=0xffffffc0857ffd08 flags=0x8101
> [  160.268693] INFO: Object 0xffffffc0857ffd08 @offset=15624 fp=0xffffffc0857fefb0
> [  160.268693]
> [  160.277721] Redzone ffffffc0857ffd00: bb bb bb bb bb bb bb bb                          ........
> [  160.286656] Object ffffffc0857ffd08: 00 00 00 00 01 00 00 80 58 a2 37 45 c1 ff ff ff  ........X.7E....
> [  160.296207] Object ffffffc0857ffd18: ae 21 10 0b 90 ff ff ff 20 fd 7f 85 c0 ff ff ff  .!...... .......
> [  160.305780] Object ffffffc0857ffd28: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  160.315342] Object ffffffc0857ffd38: 00 00 00 00 00 00 00 00 7d a3 25 69 00 00 00 00  ........}.%i....
> [  160.324896] Object ffffffc0857ffd48: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  160.334446] Object ffffffc0857ffd58: 80 c0 28 47 c1 ff ff ff 00 00 00 00 00 00 00 00  ..(G............
> [  160.344000] Object ffffffc0857ffd68: 80 4a ce d1 c0 ff ff ff dc 32 01 00 01 00 00 00  .J.......2......
> [  160.353554] Object ffffffc0857ffd78: 11 00 ed 41 00 00 00 00 00 00 00 00 00 00 00 00  ...A............
> [  160.363099] Redzone ffffffc0857ffd88: bb bb bb bb bb bb bb bb                          ........
> [  160.372032] Padding ffffffc0857ffee0: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
> [  160.378299] CPU6: update max cpu_capacity 780
> [  160.380971] CPU: 4 PID: 7098 Comm: syz-executor Tainted: G S  B   W  O    4.14.98+ #1
>
> So, avoid the race by taking a udev lock inside `uinput_release()`.
>
> Change-Id: I3bbb07589b7b6e0e1b3bea572b5eb4f6b09774d6
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> Cc:Gaurav Kohli <gkohli@codeaurora.org>
> Cc:Peter Hutterer <peter.hutterer@who-t.net>
> Cc:Martin Kepplinger <martink@posteo.de>
> Cc:"Paul E. McKenney" <paulmck@linux.ibm.com>
>
> ---
>   drivers/input/misc/uinput.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index 26ec603f..a3fb3b1 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -714,9 +714,15 @@ static __poll_t uinput_poll(struct file *file, poll_table *wait)
>   static int uinput_release(struct inode *inode, struct file *file)
>   {
>   	struct uinput_device *udev = file->private_data;
> +	ssize_t retval;
> +
> +	retval = mutex_lock_interruptible(&udev->mutex);
> +	if (retval)
> +		return retval;
>   
>   	uinput_destroy_device(udev);
>   	kfree(udev);
> +	mutex_unlock(&udev->mutex);
>   
>   	return 0;
>   }
