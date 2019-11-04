Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D596CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602C52190F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9kqiDQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfKDI1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:27:23 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:43551 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKDI1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 03:27:22 -0500
Received: by mail-il1-f194.google.com with SMTP id j2so11871366ilc.10;
        Mon, 04 Nov 2019 00:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HX4pBaoGeNQiQ+yt/czMAU0I4DAG8i9or/oZi9FPxrA=;
        b=W9kqiDQ9H6TBYA6EcpFgXwkd1ww7ZKsT2zyowkzPMfKN4YVvECqYHFNqcisKcs65Kk
         q5u5OPB/FgY9l1YV1ZSKIUBi3rPU9yIYTDQuCkSZbGymlKTuB2FEviFyZWugv98foIPI
         3x9QkmCNURX4PfLY/HJ1CUUuYZvmQxH5YuPrJ9Aqe/SqFCYweQn84SL9R17UI5R8f5Lx
         1w41qnyT3bMi/5NVlEwuLKRFhng03Ho7Hv1RrClIIepNa6dFYP5ePuUS3Fdc4rhOzmrE
         6944AZzIB5M88aKEDACrSUhxtzbdFw6bf7eVXi0c13JkVKXTQJaWqDZde9NYVcjvsI4t
         69Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HX4pBaoGeNQiQ+yt/czMAU0I4DAG8i9or/oZi9FPxrA=;
        b=Gsih8xBpzdbte0YP93AioRbdN07c1u+urcm79VOehTEdCZn0ckEfRVTHQKCPmxiKcT
         qLUma1wnicWu9lXHJPNgcEoeMNtjMrF+lA9OqeZ2KenBql/qBHRVxLx7Gkyz88ztVig9
         JBNF4KxwVL65FRYbDN5k/Au2I4p9OBgHZPU7KyhTdcyt639JQdC++o5c65frypx8+ELu
         /Sl2YV2NfoGvsFubnpsB1AikvFu49FEmDeZGKNa+rtqY5BRIOA5YCZNniuVzm8xE+iLq
         OR0zmcDDeTIfLeLtCJ0p2Zb1W6Etbew+xbzm8CGHnsWGRC/eGheOV2Msw3Yblg5o2+mN
         8fQQ==
X-Gm-Message-State: APjAAAVmVHbU+GM8warlUAJMbw9bc0D9qeG1iEsaDTWHl71JNj6xyqjL
        2tzg2oDvXOR33IlO7MLFAIwkqEb1EdLqej2bD8E=
X-Google-Smtp-Source: APXvYqyuDJikbS+1zmxs0fj3VNP0HAfX0NYxrm42A9cOVaQnPX48CUpkmsJ+WiHDhDI/Wl8EF5mvTyRVDLJGe7oNJhI=
X-Received: by 2002:a92:b00f:: with SMTP id x15mr26048913ilh.280.1572856041383;
 Mon, 04 Nov 2019 00:27:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad5:4348:0:0:0:0:0 with HTTP; Mon, 4 Nov 2019 00:27:20 -0800 (PST)
In-Reply-To: <s5himo0cbmm.wl-tiwai@suse.de>
References: <CAOzgRdYSaaF6OkXGME2=fn1dfTbpyt_GqEs=10oXH=V6SudfyA@mail.gmail.com>
 <s5himo0cbmm.wl-tiwai@suse.de>
From:   youling 257 <youling257@gmail.com>
Date:   Mon, 4 Nov 2019 16:27:20 +0800
Message-ID: <CAOzgRdYTa-nAa7QV6c2aZs910BACg91vAjcjw4V-Oy8KCZVmmQ@mail.gmail.com>
Subject: Re: ALSA: pcm: use dma_can_mmap() to check if a device supports dma_mmap_*
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Helge Deller <deller@gmx.de>,
        x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, hch@lst.de, gregkh@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/drivers/usb/gadget/function/f_audio_source.c

2019-11-04 16:02 GMT+08:00, Takashi Iwai <tiwai@suse.de>:

> Exactly which driver is hit?  The code path is via hw_support_mmap()
> and it's currently:
>
> static bool hw_support_mmap(struct snd_pcm_substream *substream)
> {
> 	if (!(substream->runtime->hw.info & SNDRV_PCM_INFO_MMAP))
> 		return false;
>
> 	if (substream->ops->mmap ||
> 	    substream->dma_buffer.dev.type != SNDRV_DMA_TYPE_DEV)
> 		return true;
>
> 	return dma_can_mmap(substream->dma_buffer.dev.dev);
> }
>
> so at least the driver has already set the SNDRV_DMA_TYPE_DEV
> explicitly (it's non-zero) and some device object, but the device
> object was invalid for dma_can_mmap() call.
>
> This smells more like a driver-side issue, not in the core side.
>
>
> thanks,
>
> Takashi
>
