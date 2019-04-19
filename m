Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A8EC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44BD204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tRFstsV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfDSTSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:18:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39575 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfDSTSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:18:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so2931216pfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=htQo5ULp1r9WrGxwNnWzafOVFDLMMLJb0v1Sl5g4wrQ=;
        b=tRFstsV7JsxedOaa21pVSKpbOigtWYRXdjXt0XpHtU1RqL6aHuTepaEbN/vMhlAcuS
         NrjfX1pres/nyK8PozNEdIsGw3Mgjt31Y1EorPozX5ej++FB+Kbf3YDjkPlyZeLVeq8x
         5xaEp0HruLP/wAXFJFVvqSxt54ROSP/Yr1h8xKCCcX6vBi+NbRJMdSTcstU6TmViqliF
         5jS6I624KEkZ/DYFWC8f1E7EcFO+nCZ5GC24hn7EpO1+Njqp5d2u6QrCeypUuBYmlXxl
         CleR7/E0P0gGw5TiOUxUSRRredgPXZkCRiTboZnMXTD9wmXZF8CqnlnYrw7sii1ud23L
         FpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=htQo5ULp1r9WrGxwNnWzafOVFDLMMLJb0v1Sl5g4wrQ=;
        b=Q8N2qvVd5iXy7y9IMsbJ3dQXIsoXo4yuBZZ9fIeEoIwXy/5EIRvmEU7wHOdMh6H4Hj
         JvCOJnEKH3l8QiLDjUfMc9GPEIbVfQDKKoivF0ASlxD153/1+6H/EpBrI82XQ7nIdgv+
         fIcoDJuk9Dty6h7T096SLdVuKMpGoGuPYjxuxhBOX5g83K6V4aM4gRzFKyrswodjNflP
         0MrSdjRd/OsqLDvdBw+UCzP4bnfzxG5IFBr1MsaX8uygcHQUjC+mbsNvAGWZIGDHi5Vx
         jT7xhSq4+voLgIl1o5VLJV1W6ax5xZqMDOKHWv4Urr9S9/q4mL6/30n7cROwC7ujal8d
         1d+w==
X-Gm-Message-State: APjAAAVroe56AVMX3x0g31NS6dmXrvykew82173A8poOmFndWl1ZZzEH
        QI03qBwdyDTIYW2krRD/Yo1xhA==
X-Google-Smtp-Source: APXvYqxjBAA4uqPIpSyZfwreiIjZo/1gxP8H/bj4leRVysHhL45uquM7Adx4dbrM7zqyU0bXnt9DtA==
X-Received: by 2002:a63:f40d:: with SMTP id g13mr5551465pgi.345.1555701503422;
        Fri, 19 Apr 2019 12:18:23 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:6d49:9ddc:13aa:21c9])
        by smtp.googlemail.com with ESMTPSA id g73sm8119521pfd.185.2019.04.19.12.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 12:18:22 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial\@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-riscv\@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver for the SiFive FU540 UART
In-Reply-To: <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com> <7hmukmew5j.fsf@baylibre.com> <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com>
Date:   Fri, 19 Apr 2019 12:18:21 -0700
Message-ID: <7h5zr9dcsi.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atish Patra <atish.patra@wdc.com> writes:

> On 4/18/19 4:22 PM, Kevin Hilman wrote:
>> Hi Paul,
>> 
>> Paul Walmsley <paul.walmsley@sifive.com> writes:
>> 
>>> This series adds a serial driver, with console support, for the
>>> UART IP block present on the SiFive FU540 SoC.  The programming
>>> model is straightforward, but unique.
>>>
>>> Boot-tested on a SiFive FU540 HiFive-U board, using BBL and the
>>> open-source FSBL (with appropriate patches to the DT data).
>>>
>>> This fifth version fixes a bug in the set_termios handler,
>>> found by Andreas Schwab <schwab@suse.de>.
>>>
>>> The patches in this series can also be found, with the PRCI patches,
>>> DT patches, and DT prerequisite patch, at:
>>>
>>> https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v5.1-rc4
>> 
>> I tried this branch, and it doesn't boot on my unleashed board.
>> 
>> Here's the boot log when I pass the DT built from your branch via
>> u-boot: https://termbin.com/rfp3.
>> 
>
> Unfortunately, that won't work. The current DT modifications by OpenSBI.
>
> 1. Change hart status to "masked" from "okay".
> 2. M-mode interrupt masking in PLIC node.
> 3. Add a chosen node for serial access in U-Boot.
>
> You can ignore 3 for your use case. However, if you pass a dtb built 
> from source code, that will have hart0 enabled and M-mode interrupts 
> enabled in DT.

Hmm, so what you're saying is there not currently any way to pass a DT
built from source using OpenSBI + mainline u-boot?

As a short-term workaround, is there a way to make these changes from
the u-boot command-line after loading a DTB built from source into
memory?  If so, I could at least script that part.


> Not sure if we should do these DT modifications in U-Boot as well.

I guess so (and I'd be happy to test the patch.)

Either that, or the upstream DTs (or code) should have those features to
the right settings.

Speaking of which, I tried to patch the DT from Paul's recent series[1]
to make the necessary changes.  I can see where to change cpu0 from
"okay" to "masked", but I'm not so sure how to make the PLIC change.

I was hoping to be able to review/test Paul's DT patches, but now I'm a
bit confused as to how to do that.

> I also noticed that your kernel is booting only 1 hart.
> Just FYI: RISC-V SMP for U-Boot patches are merged in master. So you 
> should be able to boot all cpus. You can ingore FU540_ENABLED_HART_MASK 
> in OpenSBI build as well.

Ah, nice.

I've just updated to u-boot master branch with SMP enabled, and build a
new openSBI (also from master branch) with u-boot payload. Using your
v5.1-rc4_unleashed branch, I see 4 CPUs booting:
https://termbin.com/kg13

Thanks,

Kevin

[1] https://lore.kernel.org/lkml/20190413020111.23400-1-paul.walmsley@sifive.com/T/#m77daa2857b76ec7cbca0672ad03ae286f61ca0e6
