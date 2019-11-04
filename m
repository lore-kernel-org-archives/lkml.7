Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D86BCA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03694218BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZhgUCwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfKDIc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:32:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33443 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfKDIc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 03:32:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id s1so15974802wro.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 00:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XF7J+DG7tWV9RXyc1r5Ixjph12lPvVDvV5bwthUbBEI=;
        b=FZhgUCwUZX7igZi16yQODx8+KbkHGclBlDJjHYCZxM7KjufVHj1csQ1x5nU3ZRUFHy
         W6P9jDawE7Aci66askzFeHB+6ipqKGEIDPN2Ki1vkVD8jIZdzdVPPYWAaH9cUTuCQGcu
         mtMasHpUeWbSaJ5F7hZ/6NQ574mhrl4uqfRZE8El7uTMrRhF5gbGUZYwLU9a5kvxVE/L
         k4FbZTQzVozpd/OHSfrPOPT/2ZE3nmsKoaKh0pdcsjJFPZUbMDzqQKX+3+8VrIUAWPbz
         Dh2lV4z13F7IEOp8RrfBBB0mXD8VVMXOiUwDIV2Fvb8GQi4ZrkAH1gqu/gdbTfTKb/bR
         gbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XF7J+DG7tWV9RXyc1r5Ixjph12lPvVDvV5bwthUbBEI=;
        b=ln9HUcobiSb5Lt75X9DX4pySZye0vBuK9jG0mInL2gBfp0lUkTqvoh1EaNHBBKUXAw
         A+ek18v2l141t0kY80CymowN6zoxJGDzlxJNuuCj/QXW9ZUi8tOjm4IkiE42ZYWLcoSW
         zEzdshn+NV1dFPHNTSmmN+ep91SiW7KDgKQQZhxv4qJS3cJSZoTezBBQeuvl4loq9Fxd
         m8BRBva2dMkXe46RInhnou4BRn2fr8Ydv0PPkGJ9ItbIYDWQcVqz+Z8qy4rAjPEbr0J9
         V1fCdbjfTr7pAxZyN4R7JhPYDSbU1CFMPcYO5sUAEjPEKcw31jPbZRx7D3VW/EEe4NC2
         Yqkw==
X-Gm-Message-State: APjAAAUqodHaq2wgAF8viTIEQYZ2safgaFKZ4Ii/wHJ0Q9owCXhdg2/X
        VJSL5B2peYNQ5UsRpgnRjKT4+w==
X-Google-Smtp-Source: APXvYqy3vFTV9LTgmQjmmhjTc6kU9Rr4Y6pS3SE6yuds7uL1u/ShsusG3J537rgd9MSMTZj9mf8vxA==
X-Received: by 2002:adf:fd08:: with SMTP id e8mr1452202wrr.42.1572856373332;
        Mon, 04 Nov 2019 00:32:53 -0800 (PST)
Received: from [192.168.86.166] (83-86-89-107.cable.dynamic.v4.ziggo.nl. [83.86.89.107])
        by smtp.gmail.com with ESMTPSA id z13sm17303360wrm.64.2019.11.04.00.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 00:32:52 -0800 (PST)
Subject: Re: ALSA: pcm: use dma_can_mmap() to check if a device supports
 dma_mmap_*
To:     youling 257 <youling257@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc:     linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Helge Deller <deller@gmx.de>,
        x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, hch@lst.de
References: <CAOzgRdYSaaF6OkXGME2=fn1dfTbpyt_GqEs=10oXH=V6SudfyA@mail.gmail.com>
 <s5himo0cbmm.wl-tiwai@suse.de>
 <CAOzgRdYTa-nAa7QV6c2aZs910BACg91vAjcjw4V-Oy8KCZVmmQ@mail.gmail.com>
From:   Greg Kroah-Hartman <gregkh@google.com>
Message-ID: <60ee349a-1fe7-46f0-5161-1dcfcb6fbee9@google.com>
Date:   Mon, 4 Nov 2019 09:32:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAOzgRdYTa-nAa7QV6c2aZs910BACg91vAjcjw4V-Oy8KCZVmmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/19 9:27 AM, youling 257 wrote:
 > This driver 
https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/drivers/usb/gadget/function/f_audio_source.c
 >

The driver is broken and needs to be fixed.  Please feel free to submit
patches to AOSP to do so as you can trigger this easily.

thanks,

greg k-h
