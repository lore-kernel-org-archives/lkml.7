Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9B4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E722C2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ji6epuuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387401AbfJUUhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:37:02 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44880 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730238AbfJUUhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:37:02 -0400
Received: by mail-qk1-f195.google.com with SMTP id u22so14067752qkk.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 13:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aN0N6sA3eex62Qq2/1BFeG4qtv64PBbFfLJSss3SQes=;
        b=ji6epuuE1uWhGTvPbRIMw7vMXfJAumXpjbVQmCghtSg7qqpQKEvd5WK7R4owTuAgvv
         LCD8nDwZVWakgikSYqbDnzbn25AHj4kv2KAXTxwVslf2Eygd0C6mWl3b1b9xA7gpTiK4
         ndyw6q6NJnxnIELSNCgJNFLkfC7Rsx+ca920yzv+rsim1k+PxK698ZjVgrwlDJ9hooP1
         wcRm7UFf8lJhk0l3r4w82SHKyLCsBgj57MGYbkHBvlSrQyAiptlOt32bZZaZ3PtYb26b
         b2vL356QQSkm21SBuq+zowOqV1dWzwF7c6Zu79IPW1VjXUM7YmIs7FTFiEuJJz3l0SFH
         +gXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aN0N6sA3eex62Qq2/1BFeG4qtv64PBbFfLJSss3SQes=;
        b=Xh4j3fzctpn0MDNGahzZG/nx1vdy+XZBQIRgAO2WRCO8s6VmKHeoRBuHxth+gL9r20
         Ubgmhj2qdStIhfdCXqsCD/YtQut6onOHP+B92it7ULtIomsgbIdvntu+VYrPu6e87Bfw
         NlFJBRCyG7RKtpp+M1emPJVLu90QFFfiWvb1rmMReXIZ4cR6yw+ReQjW/7xmTfX82IO8
         AdJkgaTnM+xHHzjfrYsi7+xCl1i9z83Y7RsSrijI2eVvWEi+dgP5IZ3cMgvR9lfYACs6
         MJk51TEm8dv9AbauHWR364FWPToBwvdwU0XqVFUWnX1wd//F7iXeCj1suWrRSGR5H3S2
         ulAQ==
X-Gm-Message-State: APjAAAUv2C8HJxsyW8Q9q153s0DWuqrOeuBITn5fIkUKUa3V3cfzHkST
        vOwVgdI3Vln7FlRDUXGdYnFAZoJ7Vw0b7Q==
X-Google-Smtp-Source: APXvYqzbNaipl1JmlJdTHwNCXalWRzmN4A68zuQLbNzqunduFxSdSK/sPim7bzG7SFLKCeX34fMk4g==
X-Received: by 2002:a05:620a:159c:: with SMTP id d28mr13392395qkk.422.1571690219755;
        Mon, 21 Oct 2019 13:36:59 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i185sm8547624qkc.129.2019.10.21.13.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 13:36:59 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v6 3/4] arm64: use both ZONE_DMA and ZONE_DMA32
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <9208de061fe2b9ee7b74206b3cd52cc116e43ac0.camel@suse.de>
Date:   Mon, 21 Oct 2019 16:36:57 -0400
Cc:     f.fainelli@gmail.com, mbrugger@suse.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Rob Herring <robh+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        Robin Murphy <Robin.Murphy@arm.com>, phill@raspberrypi.org,
        will@kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <AA6D37F1-A1B3-4EC4-8620-007095168BC7@lca.pw>
References: <6703f8dab4a21fe4e1049f8f224502e1733bf72c.camel@suse.de>
 <A1A8EEF0-2273-4338-B4D8-D9B1328484B4@lca.pw>
 <9208de061fe2b9ee7b74206b3cd52cc116e43ac0.camel@suse.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 21, 2019, at 1:55 PM, Nicolas Saenz Julienne =
<nsaenzjulienne@suse.de> wrote:
>=20
> On Mon, 2019-10-21 at 13:25 -0400, Qian Cai wrote:
>>> On Oct 21, 2019, at 1:01 PM, Nicolas Saenz Julienne =
<nsaenzjulienne@suse.de>
>>> wrote:
>>>=20
>>> Could you enable CMA debugging to see if anything interesting comes =
out of
>>> it.
>>=20
>> I did but nothing interesting came out. Did you use the same config I =
gave?
>=20
> Yes, aside from enabling ZONE_DMA.
>=20
>> Also, it has those cmdline.
>>=20
>> page_poison=3Don page_owner=3Don numa_balancing=3Denable \
>> systemd.unified_cgroup_hierarchy=3D1 debug_guardpage_minorder=3D1 \
>> page_alloc.shuffle=3D1
>=20
> No luck, still works for me even after adding those extra flags. IIRC =
most of
> them (if not all) are not even parsed by the time CMA is configured.
>=20
> So, can you confirm the zones setup you're seeing is similar to this =
one:
>=20
> [    0.000000][    T0] Zone ranges:
> [    0.000000][    T0]   DMA      [mem =
0x00000000802f0000-0x00000000bfffffff]
> [    0.000000][    T0]   DMA32    [mem =
0x00000000c0000000-0x00000000ffffffff]
> [    0.000000][    T0]   Normal   [mem =
0x0000000100000000-0x00000093fcffffff]
>=20
> Maybe your memory starts between 0xe0000000-0xffffffff. That would be
> problematic (although somewhat unwarranted).

I managed to get more information here,

[    0.000000] cma: dma_contiguous_reserve(limit c0000000)
[    0.000000] cma: dma_contiguous_reserve: reserving 64 MiB for global =
area
[    0.000000] cma: cma_declare_contiguous(size 0x0000000004000000, base =
0x0000000000000000, limit 0x00000000c0000000 alignment =
0x0000000000000000)
[    0.000000] cma: Failed to reserve 512 MiB

Full dmesg:

https://cailca.github.io/files/dmesg.txt=
