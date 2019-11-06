Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAFFC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABA12173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iy429A2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfKFOWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:22:40 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34836 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfKFOWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:22:40 -0500
Received: by mail-pl1-f195.google.com with SMTP id s10so668670plp.2;
        Wed, 06 Nov 2019 06:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VZ2YuX9WkVdA2wqZva8TfQh4uDZmSLYmnIZt2JxlnZI=;
        b=iy429A2Ct25xdGd6rSxaImff/6n7BsHMEcJ1elNUhEYMpfsceHyGsLNXGfuTPDayK9
         OFPB5QxinNwR4ztz4fGc0RArA+ldntUVcI17PR4mIv9i9ouOu3OprX0DrvEiucfB3qCe
         ojrGH8Y2Bej9sf4mQc5Zh2KmXMvlI28OK8qX75pVrssia1PGcmimRnnXmalbb7l9ghEF
         aSqhve8jp7NQmQsqhN4U0BZ1UsCxu1GttGQU5Kd7foRsDk3M87j5YFPXTImBlyRdyLPW
         6R37tu0qG1FEROElVWSlVT8h3l2dRpy18ed5l7anPKE2wvGdeGftqxx40ElLgYr6E9Sf
         tiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VZ2YuX9WkVdA2wqZva8TfQh4uDZmSLYmnIZt2JxlnZI=;
        b=DnWNB1KhWQVzMZyR+JdHTsrzjTEnIqqatky1IB3VoR2VRN3K0GdNHH7RzvtJRHrGk3
         gVcNOUdpFQwtOj62HiPubeR/Ti9h66PtThEzRJIQ4vkOVV9H2dhVfGoph1qrXudtiMUd
         DlkiVFmERhnm028S1XzNaJm86Zw0Xhd2bHFA5cE9ZZ7tzhFmMZ1Wqc6nehfyf6NKQG4e
         j2tdjlXUxiVcwsjqlNpOxJtSXKvMBiqr+l8seiNcPXAH7vOJO1gpD7SCrMQlPpZkon5a
         XMfQ6BLSjU8bEWXe25jOS/abHCDVlFRqIaL2fmm8yRJ4MaAONUcV11loI1F1EMj+bIwR
         7Ipw==
X-Gm-Message-State: APjAAAXKVSI21YMaUB4XvFRVb6jqFjVsN0/kwnN0ZsWCoEPSjtELY8ad
        85PVc5sm9RaG/bmh0tZp9pFefk5chklyhA==
X-Google-Smtp-Source: APXvYqwW8FePfs310Sjh8MLuZtyWmpxZSQ7ZkwcJbVr51fSef7+NsmDIBarHxe3GMmwrsHrOOTtxEw==
X-Received: by 2002:a17:902:8343:: with SMTP id z3mr2920223pln.200.1573050158836;
        Wed, 06 Nov 2019 06:22:38 -0800 (PST)
Received: from ?IPv6:2405:4800:58f7:3f8f:27cb:abb4:d0bd:49cb? ([2405:4800:58f7:3f8f:27cb:abb4:d0bd:49cb])
        by smtp.gmail.com with ESMTPSA id c184sm26760638pfc.159.2019.11.06.06.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 06:22:38 -0800 (PST)
Cc:     tranmanphong@gmail.com, 2pi@mok.nu, alex.theissen@me.com,
        andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] usb: appledisplay: fix use-after-free in
 bl_get_brightness
To:     Oliver Neukum <oneukum@suse.com>,
        syzbot+495dab1f175edc9c2f13@syzkaller.appspotmail.com
References: <00000000000042d60805933945b5@google.com>
 <20191105233652.21033-1-tranmanphong@gmail.com>
 <1573040577.3090.22.camel@suse.com>
From:   Phong Tran <tranmanphong@gmail.com>
Message-ID: <d6c628d0-71ad-7343-d80e-1b0cd0795242@gmail.com>
Date:   Wed, 6 Nov 2019 21:22:34 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573040577.3090.22.camel@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/19 6:42 PM, Oliver Neukum wrote:
> Am Mittwoch, den 06.11.2019, 06:36 +0700 schrieb Phong Tran:
>> In context of USB disconnect, the delaywork trigger and calling
>> appledisplay_bl_get_brightness() and the msgdata was freed.
>>
>> add the checking return value of usb_control_msg() and only update the
>> data while the retval is valid.
> 
> Hi,
> 
> I am afraid there are some issues with your patch. First, let me stress
> that you found the right place to fix an issue and you partially fixed
> an issue. But the the fix you applied is incomplete and left another
> issue open.
> 
> Your patch still allows doing IO to a device that may already be bound
> to another driver. That is bad, especially as the buffer is already
> free. Yes, if IO is failing, you have fixed that narrow issue.
> But it need not fail.
> 
> If you look into appledisplay_probe() you will see that it can fail
> because backlight_device_register() fails. The error handling will
> thereupon kill the URB and free memory. But it will not kill an already
> scheduled work. The scheduled work will then call usb_control_msg()
> on pdata->msgdata, which has been freed. If that IO fails, all is well.
> If not, the issue still exists.
> 
Hello Oliver,

argee, there need a cancel workqueue in case error of probe().

> Secondly, your error check is off by 2. You are checking only for
> usb_control_msg() failing. But it can return only one byte instead
> of two. If that happens, the value you return is stale, although
> the buffer is correctly allocated.
> 
> 	Regards
> 		Oliver
> 
> The correct fix for both issues would be:
> 
> #syz test: https://github.com/google/kasan.git e0bd8d79
> 
>  From 2497a62bdbeb9bd94f690c22d96dd1b8cf22861f Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oneukum@suse.com>
> Date: Wed, 6 Nov 2019 12:36:28 +0100
> Subject: [PATCH] appledisplay: fix error handling in the scheduled work
> 
> The work item can operate on
> 
> 1. stale memory left over from the last transfer
> the actual length of the data transfered needs to be checked
> 2. memory already freed
> the error handling in appledisplay_probe() needs
> to cancel the work in that case
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>   drivers/usb/misc/appledisplay.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/appledisplay.c b/drivers/usb/misc/appledisplay.c
> index ac92725458b5..ba1eaabc7796 100644
> --- a/drivers/usb/misc/appledisplay.c
> +++ b/drivers/usb/misc/appledisplay.c
> @@ -164,7 +164,12 @@ static int appledisplay_bl_get_brightness(struct backlight_device *bd)
>   		0,
>   		pdata->msgdata, 2,
>   		ACD_USB_TIMEOUT);
> -	brightness = pdata->msgdata[1];
> +	if (retval < 2) {
> +		if (retval >= 0)
> +			retval = -EMSGSIZE;
> +	} else {
> +		brightness = pdata->msgdata[1];
> +	}

compare with message size (2) can be considered.

if (retval == 2) {
	brightness = pdata->msgdata[1];
} else {
	retval = -EMSGSIZE;
}

Regards,
Phong.

>   	mutex_unlock(&pdata->sysfslock);
>   
>   	if (retval < 0)
> @@ -299,6 +304,7 @@ static int appledisplay_probe(struct usb_interface *iface,
>   	if (pdata) {
>   		if (pdata->urb) {
>   			usb_kill_urb(pdata->urb);
> +			cancel_delayed_work_sync(&pdata->work);
>   			if (pdata->urbdata)
>   				usb_free_coherent(pdata->udev, ACD_URB_BUFFER_LEN,
>   					pdata->urbdata, pdata->urb->transfer_dma);
> 
