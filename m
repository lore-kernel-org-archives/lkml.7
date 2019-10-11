Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38C2ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C2321D56
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="i7IIIgkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfJKNCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:02:46 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60252 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbfJKNCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:02:45 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191011130243euoutp02452d8e94e9638bda8f2168b1a081fcc7~MmVXJna0T3058030580euoutp02C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 13:02:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191011130243euoutp02452d8e94e9638bda8f2168b1a081fcc7~MmVXJna0T3058030580euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570798963;
        bh=ujOuHV2I7e1/ftmXN0TUj4a9vime0ZmRbCOCqf92Nlg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=i7IIIgkCglwjq3mzllF72/U++ucDj+yZRtzk2+B5QNZZSSFeCh4Gp222s3YNTr01U
         FmxzwJNjSUBZfUmB+wkE6OFHcwkAx/G5TmcrzMMHZczmBRJZdlYeZV20uum6bKK/1P
         uk1W1JkJoo8cQmZfDH067hPwBnIAI260hcKxzKAE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191011130243eucas1p23abcef4906deba93a3b8f2f4a5a3b51d~MmVWzd2ef1983719837eucas1p2x;
        Fri, 11 Oct 2019 13:02:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 77.3D.04309.37D70AD5; Fri, 11
        Oct 2019 14:02:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191011130243eucas1p22f49283594e3fcd41f2698ad1e2a488b~MmVWfzY_g2901229012eucas1p2n;
        Fri, 11 Oct 2019 13:02:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191011130243eusmtrp1a03d80ed86fa74cdc0cc927cf6a83172~MmVWfN0s92561125611eusmtrp1I;
        Fri, 11 Oct 2019 13:02:43 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-a5-5da07d731c21
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 78.7A.04166.27D70AD5; Fri, 11
        Oct 2019 14:02:43 +0100 (BST)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191011130242eusmtip11519c806a6ec418747196238ff692393~MmVWAYhdh2469024690eusmtip1o;
        Fri, 11 Oct 2019 13:02:42 +0000 (GMT)
Subject: Re: ARM Juno r1 + CONFIG_PROVE_LOCKING=y => boot failure
To:     James Morse <james.morse@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <2bf88cd2-9c4f-11dc-4b70-f717de891cff@samsung.com>
Date:   Fri, 11 Oct 2019 15:02:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7655fb41-cd13-0bc4-e656-040e0875bab8@arm.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djPc7rFtQtiDS7+FbR4v6yH0eL+vuVM
        FpseX2O1uLxrDpvFgaXtLBZvfr9gt1h+ageLRcsdUwcOjzXz1jB6bFrVyeaxeUm9x+dNcgEs
        UVw2Kak5mWWpRfp2CVwZa299ZSrYKFCx4eoD1gbGZbxdjJwcEgImEvMm97KB2EICKxglvs7I
        7mLkArK/MEq0PPvJBOF8ZpRYcGIbK0zHlp9P2CESyxklWruvQFW9ZZT4/G8xWJWwgKNEw/Rb
        zCC2iICXxIIHvxhBipgF3jNKPGk9wg6SYBMwlOh62wW2nFfATmLTnitgDSwCqhJtP+Yygtii
        ArES934cZ4aoEZQ4OfMJC4jNKWAtsfTQQbBlzALyEtvfzmGGsMUlbj2ZD3aRhMAmdolVm5ZB
        3e0i8fVHOwuELSzx6vgWdghbRuL05B4WiIZmRomH59ayQzg9jBKXm2YwQlRZSxw+fhFoEgfQ
        Ck2J9bv0IcKOEnMPnmACCUsI8EnceCsIcQSfxKRt05khwrwSHW1CENVqErOOr4Nbe/DCJeYJ
        jEqzkLw2C8k7s5C8Mwth7wJGllWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiBKej0v+Nf
        djDu+pN0iFGAg1GJh3eG/PxYIdbEsuLK3EOMEhzMSiK8i2bNiRXiTUmsrEotyo8vKs1JLT7E
        KM3BoiTOW83wIFpIID2xJDU7NbUgtQgmy8TBKdXAGPEh7rbKH2HBKf41b+vmOhjbOUXcOJu4
        +8MC2akOmQJXW/vTdPZEePWukdZYeSl5qdmkGi/FE0c3vOhabXjQQJ9hZ69MqKubvHmQWdqh
        uTxb/h2L+jaldVGJ3rYK0TtuET93M8x3nPRJMOVwSMtb4S3LLFm9F89JUT5moz+jfK51zypO
        7aZYJZbijERDLeai4kQAIa889T0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xu7rFtQtiDbpSLd4v62G0uL9vOZPF
        psfXWC0u75rDZnFgaTuLxZvfL9gtlp/awWLRcsfUgcNjzbw1jB6bVnWyeWxeUu/xeZNcAEuU
        nk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbaW1+Z
        CjYKVGy4+oC1gXEZbxcjJ4eEgInElp9P2EFsIYGljBLbr9tAxGUkTk5rYIWwhSX+XOti62Lk
        Aqp5zSixfOpuJpCEsICjRMP0W8wgtoiAl8SCB78YQYqYBd4zSmw8+o4JouMho8T8/plsIFVs
        AoYSXW+7wGxeATuJTXuugHWzCKhKtP2YC9TNwSEqECuxaa8ZRImgxMmZT1hAbE4Ba4mlhw6C
        XcQsYCYxb/NDZghbXmL72zlQtrjErSfzmSYwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55b
        bKhXnJhbXJqXrpecn7uJERhv24793LyD8dLG4EOMAhyMSjy8HxTnxwqxJpYVV+YeYpTgYFYS
        4V00a06sEG9KYmVValF+fFFpTmrxIUZToN8mMkuJJucDU0FeSbyhqaG5haWhubG5sZmFkjhv
        h8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZGjokRax6HlU29mS/n8fCuz7mJT8NuXsqwLrPld7t1
        8dO+FSE9ga3Xjuu/vP5a8b1VWZU6S5rgrRVfG1beDjv4/5DyO6lZV16oLE6+q5l8xaza63Hy
        51IB2Sehr5hZXTr+qt3Rmfx8zhHFQPunUw6uP39xu+bbpTMClkaayjDIz31QLOC+KWJ1txJL
        cUaioRZzUXEiANgB2wXNAgAA
X-CMS-MailID: 20191011130243eucas1p22f49283594e3fcd41f2698ad1e2a488b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b
References: <CGME20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b@eucas1p1.samsung.com>
        <33a83dce-e9f0-7814-923b-763d33e70257@samsung.com>
        <20191011100521.GA5122@bogus> <7655fb41-cd13-0bc4-e656-040e0875bab8@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 11.10.2019 12:38, James Morse wrote:
> Hi guys,
>
> On 11/10/2019 11:05, Sudeep Holla wrote:
>> On Fri, Oct 11, 2019 at 11:26:04AM +0200, Marek Szyprowski wrote:
>>> Recently I've got access to ARM Juno R1 board and did some tests with
>>> current mainline kernel on it. I'm a bit surprised that enabling
>>> CONFIG_PROVE_LOCKING causes a boot failure on this board. After enabling
>>> this Kconfig option, I get no single message from the kernel, although I
>>> have earlycon enabled.
>> I don't have Juno R1 but I tried defconfig + CONFIG_PROVE_LOCKING and
>> it boots fine.
> I just tried this on my r1, v5.4-rc1 with this configuration worked just fine.
>
> My cmdline is:
> | root=/dev/sda6 loglevel=9 earlycon=pl011,0x7ff80000 hugepagesz=2M hugepages=512
> | crashkernel=1G console=ttyAMA0 resume=/dev/sda2 no_console_suspend efi=debug
>
That is a bit strange. Here is a boot log from v5.4-rc1 with pure 
defconfig: https://paste.debian.net/1105851/

The bisect lead me to the commit 
c3bc8fd637a9623f5c507bd18f9677effbddf584 ("tracing: Centralize 
preemptirq tracepoints and unify their usage"), which appeared in 
v4.19-rc1. It cannot be easily reverted, but kernel built from earlier 
versions boots fine here with PROVE_LOCKING enabled. I wonder what I do 
in a different way than You...

>>> I've did my test with default defconfig and current linux-next,
>>> v5.4-rc1, v5.3 and v4.19. In all cases the result is the same. I'm
>>> booting kernel using a precompiled uboot from Linaro release and TFTP
>>> download.
>> OK, I use UEFI+GRUB but I don't think that should cause any issue.
> ... same ... this uboot binary looks like the main difference.
> Is it using u-boots UEFI support? Is it possible to turn that off?
>
> It may that lockdep is just perturbing the size of the binary. It adds an extra 4MB for me.

The size of the kernel binary doesn't matter. I've successfully booted 
larger images, than the once compiled with PROVE_LOCKING enabled.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

