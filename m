Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5467C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 12:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9877320692
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 12:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388495AbfINM75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 08:59:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35830 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387448AbfINM75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 08:59:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so16784373pgv.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 05:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6diO6eSUOGmz76ljddxSI/7HgVoh3wlKhuqDW6TPNNI=;
        b=n67P+h87oS0hGPuEbDkHvcND2t9giKxTL58VZsMBNgZtNInUP3yxVEThW79LnlYsyv
         zWuY8mYDiFCjTM+GrFL5K49fjWMEm0EhA7mGBMUVuvJkaih+m+ysutzxBy460nLrmq0r
         Wd/IyjKpaO8//7jmUyz0BpVVlucxnAdLGXrOXYwXue4vIdEf0U4nj/3NyMAHOmFxDgJU
         HtHl+M93g+//mzN2GeTSUKK2lJkJoO84hP/yzrfewGJYlkzFo36e+wsnvnS1MieKvhSO
         MpcMWmMpWXxLotN/2VjqSoa1RZvm145hfcNBaRYZKQbuuOH4Vgv9KpUUJmBqzRWmNA/X
         DsFg==
X-Gm-Message-State: APjAAAUkG8ynYBoxehfDwIr56rJjpTEBdIC+d3E4L4vCK/UVN+Ivvu+N
        94crb95SFASJCrCOUDFrlUgqm530up+8HCMM
X-Google-Smtp-Source: APXvYqynfdYc2ptc0xQfgnYnCNXJTDLZ2JGB3tku+3p+zwrQ53V7lsFNW5DAukBS7j+VSynO3hMqGQ==
X-Received: by 2002:a65:6256:: with SMTP id q22mr2197933pgv.408.1568465996538;
        Sat, 14 Sep 2019 05:59:56 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
        by smtp.gmail.com with ESMTPSA id f27sm24474034pgm.60.2019.09.14.05.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 05:59:55 -0700 (PDT)
Date:   Sat, 14 Sep 2019 05:59:55 -0700 (PDT)
X-Google-Original-Date: Sat, 14 Sep 2019 05:55:05 PDT (-0700)
Subject:     Re: [RFC] buildtar: add case for riscv architecture
In-Reply-To: <X9f9LozkDQUeBwasTsPlPseP6ZT5yJHNY2GcIgoAgNQJPuFAyYimnDXTJUqxfrZ64GOIl5-uPh07NZnD1pi4uWhCpZvbu9khOW6rEq5P4jU=@aurabindo.in>
CC:     Troy Benjegerdes <troy.benjegerdes@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     mail@aurabindo.in
Message-ID: <mhng-ed262582-dc00-41fe-9be5-2487297f2432@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2019 05:54:07 PDT (-0700), mail@aurabindo.in wrote:
>
>
>> None of the available RiscV platforms that I’m aware of use compressed images, unless there are some new bootloaders I haven’t seen yet.
>>
>
> I noticed that default build image is Image.gz, which is why I thought its a good idea to copy it into the tarball. Does such a copy not make sense at this point ?

Image.gz can't be booted directly: it's just Image that's been compressed with 
the standard gzip command.  A bootloader would have to decompress that image 
before loading it into memory, which requires extra bootloader support.  
Contrast that with the zImage style images (which are vmlinuz on x86), which 
are self-extracting and therefor require no bootloader support.  The examples 
for u-boot all use the "booti" command, which expects uncompressed images.  
Poking around I couldn't figure out a way to have u-boot decompress the images, 
but that applies to arm64 as well so I'm not sure if I'm missing something.

If I was doing this, I'd copy over arch/riscv/boot/Image and call it 
"/boot/image-${KERNELRELEASE}", as calling it vmlinuz is a bit confusing to me 
because I'd expect vmlinuz to be a self-extracting compressed executable and 
not a raw gzip file.
