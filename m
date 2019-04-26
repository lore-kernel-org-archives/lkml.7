Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5D9C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC9220873
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdlKa/z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfDZTvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:51:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47047 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDZTvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:51:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so3930823ljk.13;
        Fri, 26 Apr 2019 12:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=W7Eko1srITLoagm5AOEYzT49Ks2nbUdIhy1p1jQ52ic=;
        b=KdlKa/z+qr0ywDldwyabD179jRnY/DhCxQlMSWzD0j0qnJ0gKlXeoIY99pvX+0dCx+
         m63GP0TvzcV6+WPzseQgUNXLm+TNc4V850EO4TQFqZd+7w77ySCRc0Jh/QVGk1q170En
         dnSzmJxJgI6l+Aqd5pDz2ODhdjvmQEGZfL6PO3RAwEvCxzfC3xmJ9L1a8+P1+j9xDpuC
         z+swjRWG9ObvgWKx3E5DxKNNjn3jiid/oCaIVNkGPItvI5PwhvQqMcQuVDltVGWIkcda
         pmWoZkG6lGcfi5iaGbAjRNgSaXRonSkK2p8H5QaigcSMmcrBEUMVbIaQMMzr8XIMmsI6
         RJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=W7Eko1srITLoagm5AOEYzT49Ks2nbUdIhy1p1jQ52ic=;
        b=FJ8WnBa3f25Hjn6/8YCkTKSlBchxlFOgpy35ZZ1WhTDVm3FOuaV36/718rh9gxbcSJ
         hWqnTziNXX+Qn9bzrdNbcaPSDiQOIwqSEGW4RITwRSqBGZ1l/Kafm+WD57VLF1P+B0HS
         eLZscfPO/c9iXGmCW9sD5Kuwe8/YiW1VYPhUeNyeJof5itwQyAQVpoKoIfpaxdQr3dTP
         grWYGGKY9nRLGvh8eXLEyC+/fXpfkuNvBBqk7QNHVMG4UAfg5SuRI9Rj4+D4wzsDxIYs
         BYy+a5yxskpKiIiIfTmlYf0btUy+mWfx1mVMbupBMwT8L5nhhfve3/HqcQcUbO1y6mFf
         wyag==
X-Gm-Message-State: APjAAAV4iBwSIkvQ0oaxze4Vw3IEcz4C79f01tXnE/RHQxwnrfeLwe40
        8cLw8jzqz+6uNq4pC5HNnP8=
X-Google-Smtp-Source: APXvYqx+JnTd5FBVHykchXZ23cx3l66iZ4Zjw27evxYPNBrLhUQk9xEDLSs+jgD3B2zifS+EwwkNzw==
X-Received: by 2002:a2e:9c51:: with SMTP id t17mr25714319ljj.104.1556308268785;
        Fri, 26 Apr 2019 12:51:08 -0700 (PDT)
Received: from [10.17.182.120] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id 63sm5765438lfz.2.2019.04.26.12.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 12:51:08 -0700 (PDT)
Subject: Re: [PATCH] ARM: mach-shmobile: Don't configure ARCH timer if PSCI is
 enabled
To:     Julien Grall <julien.grall@arm.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     horms@verge.net.au, magnus.damm@gmail.com, linux@armlinux.org.uk,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <1555521040-16706-1-git-send-email-olekstysh@gmail.com>
 <1b33dca4-e3ae-4588-05f2-37b23ac8df78@arm.com>
 <8c9a1480-7956-9265-14c8-3fbb472e097d@gmail.com>
 <c08c0d02-37f9-9f53-62b9-e5012097d94a@arm.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <e8798fa4-a0dc-7c85-e294-bdf6dad6ec74@gmail.com>
Date:   Fri, 26 Apr 2019 22:51:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c08c0d02-37f9-9f53-62b9-e5012097d94a@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24.04.19 15:31, Julien Grall wrote:
> Hi,

Hi Julien


>
>>
>> As I answered in a previous email:
>>
>>  > But "#if !defined(CONFIG_ARM_PSCI)" wraps secure_cntvoff_init() 
>> call as
>>  > well, which resets CNTVOFF,
>>
>>  > and this is something I tried to avoid the first from being 
>> executed on
>>  > a CPU, which is in SVC mode (when running on top of Xen).
>>
>> What would be a proper way to avoid calling secure_cntvoff_init() at 
>> runtime?
>>
>> Check that we are already in non-secure mode and/or cntvoff is 
>> already 0?
>
> CNTVOFF is controlled by the hypervisor, so you cannot access it from 
> Dom0.
>
> If none of this code should be necessary when PSCI is enabled, then 
> you can check the presence of PSCI (see psci_smp_available()).


If I am not mistaken, U-Boot resets CNTVOFF before leaving monitor mode 
(switching to non-secure state). This happens if "support for booting in 
non-secure mode" is enabled.

This is a mandatory option for PSCI support as well as for support for 
hardware virtualization.

So the presence of PSCI would be an indicator, if CNTVOFF was configured 
in U-Boot and we don't need to.

 From other hand, Gen2 Linux may be booted in non-secure mode, without 
PSCI support...


I was thinking about checking the presence of "enable-method = psci" in 
CPU node, but probably psci_smp_available() is better option.

Also, there is a specific device-tree property 
"arm,cpu-registers-not-fw-configured" [1], but I am not sure whether it 
is appropriate to use here.


>
> Another solution is to check whether we are running on xen (see 
> xen_domain()).
>
> In any case, I would still surround the two checks because the 
> "armgcnt" should really not be touched by Dom0.

Agree.

I will add two checks in V2.


Thank you!


[1]

https://elixir.bootlin.com/linux/v5.1-rc6/source/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml#L68


>
> Cheers,
>
-- 
Regards,

Oleksandr Tyshchenko

