Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C233C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4682821D56
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rxqOcm44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfJKKV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:21:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52099 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfJKKV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:21:26 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191011102124euoutp01379bf645abc3e4649275fe5044cd399a~MkIgytRc_1194511945euoutp01B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 10:21:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191011102124euoutp01379bf645abc3e4649275fe5044cd399a~MkIgytRc_1194511945euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570789284;
        bh=vVluA6MQRK9yUL5rBCxrD+n/jRYq/J0faE1HgkGlrk8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rxqOcm44PxjnpQuDef5U8r83h/gyBHHw+aE48N4sAWh8aI+wqBP59nik/n3dbyUnK
         mCjsqRXxvtXOnXWWxVbexc9yYo/0+WtxLRLn41h6Xb56bT/akThw+dg7o7QKW9Chku
         gAorYT7/kz4KO28tLDLQMfxLv9JxyeiaS099X57A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191011102124eucas1p28bb3916d080b23951a5a6b7bcb367b36~MkIgfttOp1532615326eucas1p2i;
        Fri, 11 Oct 2019 10:21:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 51.5A.04469.4A750AD5; Fri, 11
        Oct 2019 11:21:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191011102124eucas1p27ebfadf5b16d0b943471129d242728b8~MkIgNOw0e1532715327eucas1p2Y;
        Fri, 11 Oct 2019 10:21:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191011102124eusmtrp231ae2a1dd472626b67267c1f6b5d6b6a~MkIgMhQMc2631826318eusmtrp2q;
        Fri, 11 Oct 2019 10:21:24 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-24-5da057a40cfc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D5.DA.04117.3A750AD5; Fri, 11
        Oct 2019 11:21:24 +0100 (BST)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191011102123eusmtip1ed8d0f667874a637501b5a8d051fe715~MkIf0QRUX1950619506eusmtip1G;
        Fri, 11 Oct 2019 10:21:23 +0000 (GMT)
Subject: Re: ARM Juno r1 + CONFIG_PROVE_LOCKING=y => boot failure
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <d315d99c-ef5d-eae0-86e0-a6d71355ffc1@samsung.com>
Date:   Fri, 11 Oct 2019 12:21:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191011100521.GA5122@bogus>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djPc7pLwhfEGjz7I2LxflkPo8Wmx9dY
        LS7vmsNmcWBpO4vFm98v2C2Wn9rBYtFyx9SB3WPNvDWMHptWdbJ5bF5S7/F5k1wASxSXTUpq
        TmZZapG+XQJXxpt1LxkLvnBXnL+yiqWBcQNnFyMnh4SAicSah23sXYxcHEICKxglvnZ9YIZw
        vjBKHN62iw3C+cwo0bq4nQ2mZcnq/SwgtpDAckaJ3Q+zIYreMkpsa3oPViQs4CjRMP0WM4gt
        IqAuseTsFkaQImaB94wSH9q+soIk2AQMJbredoE18ArYScyevw1sKouAqkTfltdMILaoQKzE
        vR/HmSFqBCVOznwCVsMpoCWxZfc8MJtZQF5i+9s5zBC2uMStJ/OZQJZJCCxjl/h/vZUF4mwX
        ic7ePewQtrDEq+NboGwZif87YRqaGSUenlvLDuH0MEpcbprBCFFlLXH4+EWgszmAVmhKrN+l
        DxF2lJh78AQTSFhCgE/ixltBiCP4JCZtm84MEeaV6GgTgqhWk5h1fB3c2oMXLjFPYFSaheS1
        WUjemYXknVkIexcwsqxiFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITDyn/x3/tIPx66Wk
        Q4wCHIxKPLwz5OfHCrEmlhVX5h5ilOBgVhLhXTRrTqwQb0piZVVqUX58UWlOavEhRmkOFiVx
        3mqGB9FCAumJJanZqakFqUUwWSYOTqkGRlbXI6dMuyaUKthw6npIcK+0OLXqqu5qs+Dd86Q8
        rSxc3v62Lk76KnLi/JR35xjFeiJM5P35FY4fLZdUftrcI7VbTO3u4k8CDNmskU2ztWy3u//2
        75VN84tsEzlY+9L9qrpp0pRZWzoOXmpIYcncOvl3xOVavn87irYUOf8KaojQuDp342RTJZbi
        jERDLeai4kQAgbnZZjgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7pLwhfEGkzUt3i/rIfRYtPja6wW
        l3fNYbM4sLSdxeLN7xfsFstP7WCxaLlj6sDusWbeGkaPTas62Tw2L6n3+LxJLoAlSs+mKL+0
        JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/jzbqXjAVfuCvO
        X1nF0sC4gbOLkZNDQsBEYsnq/SxdjFwcQgJLGSXeXgVxQBIyEienNbBC2MISf651sUEUvWaU
        6D56ACwhLOAo0TD9FjOILSKgLrHk7BZGEJtZ4D2jxLt7khANmxglvh2+BTaVTcBQoustyCRO
        Dl4BO4nZ87eBxVkEVCX6trxm6mLk4BAViJXYtNcMokRQ4uTMJ2AlnAJaElt2z2OBmG8mMW/z
        Q2YIW15i+9s5ULa4xK0n85kmMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2ykV5yYW1ya
        l66XnJ+7iREYZduO/dyyg7HrXfAhRgEORiUe3hny82OFWBPLiitzDzFKcDArifAumjUnVog3
        JbGyKrUoP76oNCe1+BCjKdBvE5mlRJPzgQkgryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpi
        SWp2ampBahFMHxMHp1QDo2JV3ERZrbqsF8YGywVuxcw5ZZI8w2sGZ4LXhwPbq/YIq8pXB/+5
        ncXp53L1w2u+g8F7w1448S+SWn02aXZd5rZ3Kj6Zup8DvlaWq7x1cvqxoS5dyPXCf6Gu3oLW
        A4YayxbV9Z67zvZZZ8PtJfc5epMiTgf3vzW//qtduXat+sbjF/44bUwPUGIpzkg01GIuKk4E
        APyqN8TIAgAA
X-CMS-MailID: 20191011102124eucas1p27ebfadf5b16d0b943471129d242728b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b
References: <CGME20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b@eucas1p1.samsung.com>
        <33a83dce-e9f0-7814-923b-763d33e70257@samsung.com>
        <20191011100521.GA5122@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 11.10.2019 12:05, Sudeep Holla wrote:
> Hi Marek,
>
> On Fri, Oct 11, 2019 at 11:26:04AM +0200, Marek Szyprowski wrote:
>> Hi
>>
>> Recently I've got access to ARM Juno R1 board and did some tests with
>> current mainline kernel on it. I'm a bit surprised that enabling
>> CONFIG_PROVE_LOCKING causes a boot failure on this board. After enabling
>> this Kconfig option, I get no single message from the kernel, although I
>> have earlycon enabled.
>>
> I don't have Juno R1 but I tried defconfig + CONFIG_PROVE_LOCKING and
> it boots fine.
>
> So if you disable CONFIG_PROVE_LOCKING(i.e. defconfig) boots fine ?
> Are you using DTB from the mainline ?

Yes, ARM Juno r1 boots fine with pure defconfig and mainline dtb. 
However a few minutes ago I found that it boots with 
v4.14+PROVE_LOCKING, so I will bisect it and share the results.

>> I've did my test with default defconfig and current linux-next,
>> v5.4-rc1, v5.3 and v4.19. In all cases the result is the same. I'm
>> booting kernel using a precompiled uboot from Linaro release and TFTP
>> download.
>>
> OK, I use UEFI+GRUB but I don't think that should cause any issue.
>
>> Is this a known issue? Other ARM64 boards I have access to (Samsung TM2e
>> and RaspberryPi3) boots fine with the same kernel image.
>>
> Not that I am aware of. If you could send me the bootlog with defconfig
> I can take a look and see if I get any clue.
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

