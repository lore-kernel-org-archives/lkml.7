Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A03CC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB82216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561606427;
	bh=0dO2e9dDOv4lvbr1mCKY3vuoEjzBbc2ekCbhR3JLgok=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=XJlIfnA4qpEVuCXzwjJYrgh55LPxBHATsKZAUEu6lbYZmhddoyO1mGG+CC5uVBePY
	 3IFVcgPtUprSLzCQ+wbtESdHnzG+HxG+VMebHt5g4Tjr3BFd46i7CJ4ovSN0BBP4Z9
	 xcXHheSvQ9JC8B6b3EQ4BSA9IfWBSP8quhBeTlAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfF0Ddq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 23:33:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39777 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfF0Ddp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 23:33:45 -0400
Received: by mail-io1-f65.google.com with SMTP id r185so1560272iod.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 20:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XF+G4LWc6yTM0hyPsvbwF5/LSakqPeCeR1RaSYQ/rMM=;
        b=Gtk/s27Nxe/bxqfxezqklb5PLo4t4BYzFBlEZXxwx5hLrBG8QMBJwhXV2kuiXyBl4G
         EPCP12KLE805t0XFmIbOyGfB8KAL0T0thPeyBaseCHIaQA4XpZ4EgVrkMrlHhDRMBihx
         SZeFnEfbuAlYUB1+NtR91+lfPpWqbXcxxeX/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XF+G4LWc6yTM0hyPsvbwF5/LSakqPeCeR1RaSYQ/rMM=;
        b=VJ8BPctbrybkSBB/Ksi2FN4jnhu15LIqpgMGLRm1Qumez3rSMBFU9aBM2oiGIQ/Toh
         WYvJMFZdwnfkuAQPOGjuVRnGNzz+u/U+O8FQVvvyLtnzus8Hi8q+sdXlFlV5kqvQG7Jc
         X4u/0grk2iBOhQ1X0eQqgmkmBKXc4ZUXw5l8ueQ7zKpqY38oRgjj8h3FhQuVndFGB//G
         1fsFcrCkbEyRCWCoFeLN6/2r8cH7b1VcCb3WJ1EY5sn4//rp4HH6SF6i47yUKg8FUpcE
         9Hjo9Dx9/Jb6+vgpclqC+WeNGb6DTORuMg6bsCu/PEHLNP5vbWhWcdsLlzNEpE8hVCgN
         Suag==
X-Gm-Message-State: APjAAAWWyyD5V/hQJFgUx2gJ54aa4gB4hDA6T8YIh/wbxzHCihWAbmKv
        Kq6fTn7d5KJZTwmDOKGVHI3hig==
X-Google-Smtp-Source: APXvYqzAo6yx8WGJzDGlrEkLktFBWHOfEKaDWfKHRUoRoNvEvVme1VLQk7Pg6XOU4F7VA7sj7lFcgA==
X-Received: by 2002:a5d:968b:: with SMTP id m11mr2069612ion.16.1561606424694;
        Wed, 26 Jun 2019 20:33:44 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c17sm778788ioo.82.2019.06.26.20.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 20:33:44 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees][PATCH v2] drm/amdkfd: Fix undefined
 behavior in bit shift
To:     Jiunn Chang <c0d1n61at3@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        oded.gabbay@gmail.com,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20190627010137.5612-3-c0d1n61at3@gmail.com>
 <20190627032532.18374-3-c0d1n61at3@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <59d3169d-4c74-4e75-7a48-93c0e99ae1f2@linuxfoundation.org>
Date:   Wed, 26 Jun 2019 21:33:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627032532.18374-3-c0d1n61at3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/19 9:25 PM, Jiunn Chang wrote:
> Shifting signed 32-bit value by 31 bits is undefined.  Changing most
> significant bit to unsigned.
> 
> Changes included in v2:
>    - use subsystem specific subject lines
>    - CC required mailing lists
> 
> Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
> ---

Move version change lines here.

>   include/uapi/linux/kfd_ioctl.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index dc067ed0b72d..ae5669272303 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -339,7 +339,7 @@ struct kfd_ioctl_acquire_vm_args {
>   #define KFD_IOC_ALLOC_MEM_FLAGS_USERPTR		(1 << 2)
>   #define KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL	(1 << 3)
>   /* Allocation flags: attributes/access options */
> -#define KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE	(1 << 31)
> +#define KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE	(1U << 31)
>   #define KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE	(1 << 30)
>   #define KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC		(1 << 29)
>   #define KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE	(1 << 28)
> 

thanks,
-- Shuah
