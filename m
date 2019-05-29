Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3D3C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4062721670
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="V+CQc1Ua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfE2KEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:04:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42669 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfE2KEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:04:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id l2so1278806wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 03:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=EvRHuK8mz2NMxeqe94A9v/S9Mu1WuY4pJlAWP/0yaCU=;
        b=V+CQc1Uawwh7H+49Sc63wT1Z0PeCzOUvhYN0X5juPv/tDrEQfn4viRo7A4giKds037
         FIxwvb6pfHvuaKYB1ogomOuc7GBDUpF1aRTl9Rh6vI3G9TmNKj2wgM1zJQJGQ3YzyxoF
         ROlkb4JfXfnuzYHTXcBmxNyoZRJLBBJGSKJ1fkHk0OOM/VhyxPH1BYYyAUXfpsCFaUaO
         KXcbZuY+nm3NoAJL7VFoswDkS6gCkQaEGHlsfdn0/y8lN7p7PSNgCFeQbaBSc94dMMxW
         MYywOeqF6i0VEmmzgHxhri84uURb59HPScaQVwezeuZbVu7e51kRAGGqHVlYr/u8dOtH
         pt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=EvRHuK8mz2NMxeqe94A9v/S9Mu1WuY4pJlAWP/0yaCU=;
        b=m6sEPMlCPPgsKLkN5IF4IJ7iPESfRNr2hHQxNe0cxkJycUpt965rEvgICoIxv614fn
         YwRCSjf6cKX0JKN+jOfabNPX8zg2Mn4ulyQka0y6Fnl4SaG5eVugUuQafR/Wboknghz9
         zcJdJ7LZa8W65+JiSfJJ1gtfJMuG8oQh7XqFVUcydKmBWtwnel6qqYqIKKhOfNZtZv6K
         M3calrWujE561mReqJOj2RzS/0vqjS0tskDueeQNfeHnhyyHkIm7cGwerI3ep0f8Mx3X
         lOm2DB7IQlTakJ1frdHtSVr/Fd8zFqmAWjahz1aVstfyxMEldSkK/+mzdoPgTR9iMK+i
         TdWA==
X-Gm-Message-State: APjAAAUR4D4FSF2SdNe+bS/rKHy89zAB1+/4Gnjqaj462vCyU+wLZOFM
        hF3koGFlhOw9T5l/7hcY2rwEqQ==
X-Google-Smtp-Source: APXvYqwg+x1MOMT+WmH/pBDUnkvqMWetCPalCNp+MayuVaC4AMRbrLW0huzcYAbqvXQX+V0Si1OQrQ==
X-Received: by 2002:a05:6000:12:: with SMTP id h18mr4283978wrx.29.1559124281873;
        Wed, 29 May 2019 03:04:41 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f197sm5965858wme.39.2019.05.29.03.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 03:04:41 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Atish Patra <atish.patra@wdc.com>,
        Karsten Merker <merker@debian.org>
Cc:     "linux-riscv\@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: Testing the recent RISC-V DT patchsets
In-Reply-To: <081611ea-a0d3-b0c9-3e08-8946513f2174@wdc.com>
References: <alpine.DEB.2.21.9999.1904221705170.18377@viisi.sifive.com> <alpine.DEB.2.21.9999.1905280105110.20842@viisi.sifive.com> <86o93mpqbx.fsf@baylibre.com> <20190528153542.jfkkwycyc3vu6hld@excalibur.cnev.de> <081611ea-a0d3-b0c9-3e08-8946513f2174@wdc.com>
Date:   Wed, 29 May 2019 12:04:39 +0200
Message-ID: <86woi94lvs.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 May 2019 at 00:50, Atish Patra <atish.patra@wdc.com> wrote:

> On 5/28/19 8:36 AM, Karsten Merker wrote:
>> On Tue, May 28, 2019 at 05:10:42PM +0200, Loys Ollivier wrote:
>>> On Tue 28 May 2019 at 01:32, Paul Walmsley <paul.walmsley@sifive.com> wrote:
>>>
>>>> An update for those testing RISC-V patches: here's a new branch of
>>>> riscv-pk/bbl that doesn't try to read or modify the DT data at all, which
>>>> should be useful until U-Boot settles down.
>> [...]
>>>> Here is an Linux kernel branch with updated DT data that can be booted
>>>> with the above bootloader:
>>>>
>>>>     https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.2-rc1-experimental
>>>>
>>>> A sample boot log follows, using a 'defconfig' build from that branch.
>>>
>>> Thanks Paul, I can confirm that it works.
>>>
>>> Something is still unclear to myself.
>>> Using FSBL + riscv-pk/bbl the linux kernel + device tree boots.
>>> Neither FSBL nor riscv-pk/bbl are modifying the DT.
>>>
>>> Using FSBL + OpenSBI + U-Boot the same kernel + device tree hangs on
>>> running /init.
>>>
>>> Would you have any pointer on what riscv-pk does that OpenSBI/U-boot doesn't ?
>>> Or maybe it is the other way around - OpenSBI/U-boot does something that
>>> extra that should not happen.
>> 
>> Hello,
>> 
>> I don't know which version of OpenSBI you are using, but there is
>> a problem with the combination of kernel 5.2-rc1 and OpenSBI
>> versions before commit
>> 
>>    https://github.com/riscv/opensbi/commit/4e2cd478208531c47343290f15b577d40c82649c
>> 
>> that can result in a hang on executing init, so in case you
>> should be using an older OpenSBI build that might be the source
>> of the problem that you are experiencing.
>> 
>> Regards,
>> Karsten
>> 
>
> I verified the updated DT with upstream kernel for the boot flow OpenSBI 
> + U-Boot + Linux or OpenSBI + Linux.
>
> OpenSBI should be compiled for sifive platform with following additional 
> argument
>
> FW_PAYLOAD_FDT_PATH=<linux kernel 
> source>/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dtb
>
> FYI: It will only work when kernel is given a payload to U-Boot/OpenSBI 
> directly.
>

Hum, I am surprised by this statement.
I was able to verify the latest DT patch serie from Paul with:
OpenSBI + U-Boot + Linux & DT.

Following the OpenSBI documentation [0] with U-Boot payload:
FW_PAYLOAD_PATH=<u-boot_build_dir>/u-boot.bin

I get an U-Boot prompt and then I can just load the linux kernel and
device tree from the network.

[0]: https://github.com/riscv/opensbi/blob/master/docs/platform/sifive_fu540.md#building-sifive-fu540-platform

> Network booting is still not working as the clock driver probe doesn't 
> happen because of the updated DT.
>
> -- 
> Regards,
> Atish
