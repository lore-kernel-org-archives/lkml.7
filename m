Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B97C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5ED21738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfDDNvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:51:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38408 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDNvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:51:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so3929138wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 06:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CDV151PAc+LErbeV998XAcKvDgV2SQX/eY3YQG0sbKA=;
        b=dcKD7i/8n1TPJU8Uv7f5rh0kj/h0E+bsTIhzvJpXw13uhPdwDO6xm2b10w+S7lCogd
         4Q3rghMCTHMLiegsQ2VpzmLMax5lErT6MhCYSlqOG68ngBSOQY/hSnEBJYw4z/jowKO5
         qUZ3+cppliX40WvOFZtusn5su9m9DTGbgqiVcjJXa0JG/ozCAkgC3Iyw/39SHnD37JrU
         tBVDJTMpoLY6l+qxxH9VG9mprEjF40X9IVcUxMP5FP/+SssIknwhdDF4wBGbmpQ0pmhR
         9nP+ZuhOMsScn96d7gTgBBEAsTw4NyKypAOSY+e9MeTicrZ9f2kA2SlXTjBicbfPRpZn
         MDjw==
X-Gm-Message-State: APjAAAUO2ptnyRKwLGgezZ12dZr497w4xnkfJo+/bMIGQuUH+9oLTEVU
        7j8gXaJjR2A4T2Njcaf/Lb0pag==
X-Google-Smtp-Source: APXvYqzjGcySV/m0niLQP46OI28Sc8RRySSpPaGrWRP4ChnWwG6nZ+SOmONxk/16BK7BH7K7F5WE0g==
X-Received: by 2002:a5d:6682:: with SMTP id l2mr4381423wru.33.1554385878579;
        Thu, 04 Apr 2019 06:51:18 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id z13sm24113918wrw.36.2019.04.04.06.51.17
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 06:51:17 -0700 (PDT)
Subject: Re: [PATCH] drm/nouveau: Remove duplicate ACPI_VIDEO_NOTIFY_PROBE
 definition
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20190404134943.149428-1-helgaas@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e03eeb0f-a95a-97cb-6459-11c3356a0d9d@redhat.com>
Date:   Thu, 4 Apr 2019 15:51:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404134943.149428-1-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04-04-19 15:49, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Commit 3a6536c51d5d ("drm/nouveau: Intercept ACPI_VIDEO_NOTIFY_PROBE")
> added a definition of ACPI_VIDEO_NOTIFY_PROBE because <acpi/video.h> didn't
> supply one.  Later, commit eff4a751cce5 ("ACPI / video: Move
> ACPI_VIDEO_NOTIFY_* defines to acpi/video.h") moved ACPI_VIDEO_NOTIFY_PROBE
> and other definitions to <acpi/video.h>, so the copy in nouveau_display.c
> is now unnecessary.
> 
> Remove the unnecessary definition from nouveau_display.c.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Hans de Goede <hdegoede@redhat.com>

Thank you for cleaning this up:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/gpu/drm/nouveau/nouveau_display.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
> index 55c0fa451163..832da8e0020d 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_display.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_display.c
> @@ -358,15 +358,6 @@ nouveau_display_hpd_work(struct work_struct *work)
>   
>   #ifdef CONFIG_ACPI
>   
> -/*
> - * Hans de Goede: This define belongs in acpi/video.h, I've submitted a patch
> - * to the acpi subsys to move it there from drivers/acpi/acpi_video.c .
> - * This should be dropped once that is merged.
> - */
> -#ifndef ACPI_VIDEO_NOTIFY_PROBE
> -#define ACPI_VIDEO_NOTIFY_PROBE			0x81
> -#endif
> -
>   static int
>   nouveau_display_acpi_ntfy(struct notifier_block *nb, unsigned long val,
>   			  void *data)
> 
