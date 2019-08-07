Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8552FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E122217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oj4RFKJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbfHGIWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:22:21 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50276 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387515AbfHGIWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:22:21 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190807082218euoutp01c590e38de21aa05b4f1ca0dff82ba1c0~4lk_RLoci0916609166euoutp01X
        for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2019 08:22:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190807082218euoutp01c590e38de21aa05b4f1ca0dff82ba1c0~4lk_RLoci0916609166euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565166139;
        bh=TUOJee1KmaVqHr7sp1XDmCcAg4SfEnN4KsZm2vPUxeU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oj4RFKJj6zYexdRMKkDPwRVVzJZjXUghoxAQKcrpIqnPSsfjmMBRz3RP9o8ByWwPA
         ADijWFXnVBQnabpEpEmaHL7oMiAS6eA5VXVOuMPBlg0M36SzF71osAmrIAEp8cm+sW
         yijDFQF+kdMY4fs2bR4y64LiX6SUrV2Af/rV/5Xs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190807082218eucas1p2101e26b7b20195803ee174dea6d6a957~4lk9nU0Cf2777127771eucas1p2y;
        Wed,  7 Aug 2019 08:22:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3C.E9.04374.93A8A4D5; Wed,  7
        Aug 2019 09:22:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190807082217eucas1p1902bf3e6dbdc180efb15dcffd2c569f9~4lk80b8Zj1455014550eucas1p1L;
        Wed,  7 Aug 2019 08:22:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190807082217eusmtrp11a1f46affb6a93550c7ff2bb842e8c37~4lk8mAQtD1982319823eusmtrp1J;
        Wed,  7 Aug 2019 08:22:17 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-85-5d4a8a393be9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9E.44.04166.93A8A4D5; Wed,  7
        Aug 2019 09:22:17 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190807082216eusmtip2ddaf1592eedc20faa8a53d54b471ffc7~4lk8B9sv31759417594eusmtip2X;
        Wed,  7 Aug 2019 08:22:16 +0000 (GMT)
Subject: Re: Odroid-XU4 sound issue after suspend-resume
To:     Jaafar Ali <jaafarkhalaf@gmail.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kgene@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        sam@ravnborg.org, linux-clk@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <24165241-1f65-fafa-0c59-b85cf89bc5bb@samsung.com>
Date:   Wed, 7 Aug 2019 10:22:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAF-0O_4xOQNkX5ZyyVz7zZDAP9XBeUKv65T0cd+oAAV1ahLQ9Q@mail.gmail.com>
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRiGez1nO2fD2evUfDBRGEIoNZOMTiaiEDT7EUoIYUgtd5iWm7L5
        kfZHFKzM8qs0p6SEpNvIwtLUTGym0wTNb8VSUUvLTPMjHIXl8Sj573ru+7m53wdempA+EbjR
        sdpEVqdVxsmEYrK+w9ZzJCD7bNTRt8eZ1i8DBJM7s0Awvb3PKeZnzoSAGWgqEzIPe1vsmGpb
        HQqmFI2GT5Si1nRbqKgsGhIqVms9wshIcaCKjYtNZnW+QZfFMW8yfhAJU/bXlzs6iXRUJs5G
        IhqwPzyYXxFkIzEtxdUICquzKH5YQ2CzlewMqwjMX9eFu5HcvlYhb1QhKOkupDhDihcRmO6H
        cOyEGRheGd8OOOND8Llx1I4LEPgpgrGaFyRnCLEf3G2/hziW4CDoLzcLOCaxF7waWdnWXfAF
        eP/uEcnvOEJXyew2i3A4lC/d3C4msCtkrBkFPHtCZl0pwZUBrqGgdKGB5J99GpbaflE8O8E3
        68sddofuwhySD2QiyHk9TvFDHoJJawXit05Bm7Vvq4LeqvCGZ02+vBwCy+uDiJMBO8DooiP/
        CAcoqC8meFkCt7Kk/LYX/DYV2/HsBndm/5J5SGbYc5phzzmGPecY/vdWINKEXNkkvUbN6o9p
        2RS5XqnRJ2nV8uh4TS3a+j3dm9b1BtTy54oFYRrJ7CVMdmiUVKBM1qdqLAhoQuYsmUjekiQq
        ZWoaq4u/pEuKY/UWdJAmZa6SG/umLkqxWpnIXmPZBFa369rRIrd01CYa83RWB5CZ6Lt7szFM
        Kx1NMc6sDp4Pc/dK66qMnAj2Lxpppn02p6sM5v6IiBNncszR8vzp8I+qcz0iX6x6fKBgSjA/
        edi7S95uqT05XD0n2iBcNqq8ehPCiheo/KFEVWdUVUtobKh3xtUZ84dOb0XQiG2gb44KXJLv
        N3rISH2M0s+H0OmV/wB8zpNVOQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7qWXV6xBmdecVkceHaZ2aL/8Wtm
        i/PnN7BbfOy5x2pxedccNosZ5/cxWaz4uZXRgd1j56y77B6bVnWyeSyZdpXN4/MmuQCWKD2b
        ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MvU3vmAse
        8FR8OHaCuYFxDlcXIyeHhICJRP/FA2xdjFwcQgJLGSU+Nc5j6WLkAEpIScxvUYKoEZb4c60L
        quY1o8Tff3uYQBLCAhYS1z7dZgOxRQTUJZ7uvMEEUsQssJZR4nTPXCaIjiWMEjOXn2cBqWIT
        MJToPdrHCGLzCthJXJq/mhXEZhFQkdh+/RNYXFQgQmLStZ0sEDWCEidnPgGzOQUCJea/b2cH
        sZmBtv2Zd4kZwhaXaPqykhXClpdo3jqbeQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnF
        hnrFibnFpXnpesn5uZsYgdG27djPzTsYL20MPsQowMGoxMM7occzVog1say4MvcQowQHs5II
        770yoBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnAxNBXkm8oamhuYWlobmxubGZhZI4b4fA
        wRghgfTEktTs1NSC1CKYPiYOTqkGRqul3D5u/X4vJ194Wrgko1BxwY7unwyP/uvGTWaUvRyg
        OTc3J2ni/+xj7QkL/69ekfhO8KzGIpkFRdx7JM0YGk+7B9tErWhIZT8xY0PiZ7mvVZVOuw+K
        T2dJ7va6efv/00rtqtvZjluK+vf9FPNLEdG9NTe6RVJhxWLr42WM7HL5W59w2qUGKrEUZyQa
        ajEXFScCAL5kDh/MAgAA
X-CMS-MailID: 20190807082217eucas1p1902bf3e6dbdc180efb15dcffd2c569f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190805133249epcas2p3aea30967f18f03f7fc1ed9dc7cbcb1d5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190805133249epcas2p3aea30967f18f03f7fc1ed9dc7cbcb1d5
References: <CGME20190805133249epcas2p3aea30967f18f03f7fc1ed9dc7cbcb1d5@epcas2p3.samsung.com>
        <CAF-0O_4xOQNkX5ZyyVz7zZDAP9XBeUKv65T0cd+oAAV1ahLQ9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaafar, 

On 8/5/19 15:27, Jaafar Ali wrote:
> Dear All,
> Kernel 5.3-rc1
> OS: ubuntu 18.04
> Hardware: Odroid-XU4
> The sound of Odroid-XU4 after suspend/resume cycle is choppy and slow. 
> I have found a workaround, the I2SMOD register value should be set to 
> zero after resume to force using internal codec clock (cdclkcon bit = 0),
> also the rclk_srcrate which is obtained from the function 
> *clk_get_rate(rclksrc) *inside *hw_params* function is not correct and 
> must be divided by 2 to obtain proper value, i2s_resume function 
> is modified to:
> 
> static int i2s_resume(struct snd_soc_dai *dai)
> {
>         struct samsung_i2s_priv *priv = dev_get_drvdata(dai->dev);
>         priv->suspend_i2smod = 0;//workaround-1 ,
>         return pm_runtime_force_resume(dai->dev);
> 
> }
> 
> inside hw_params function, the rclk_srcrate must be halved to solve 
> unknown problem of clock shift, so before return from hw_params we 
> must insert:
> if(mod == 0){
> 	priv->rclk_srcrate = priv->rclk_srcrate / 2; //workaround-2, 
> }
> 
> With these two workaround sound issue was solved, but I hope we can 
> get concrete fix.
Thank you for the bug report. I spent some time on debugging this and
it turned out that there is a clock mux between EPLL and the audio 
subsystem which looses its configuration during suspend/resume cycle.
So we end up with the I2S controller clocked from the main oscillator
clock (24 MHz) rather than the EPLL (196.608 MHz) after system suspend/
resume. I will post a patch for clk-exynos5420 driver shortly.

-- 
Regards,
Sylwester
