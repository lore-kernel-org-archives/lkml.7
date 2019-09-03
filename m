Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36539C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 02:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F7422CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 02:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W+hzRZTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfICCpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 22:45:43 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:28464 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfICCpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 22:45:42 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190903024539epoutp04f7dcaac3f37331fbbabdbaa412f0c281~AzZvdM-Ho1402914029epoutp04b
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 02:45:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190903024539epoutp04f7dcaac3f37331fbbabdbaa412f0c281~AzZvdM-Ho1402914029epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567478739;
        bh=lb+eKKnigZlYleF+cI9gV267AXQ6iAJhyYQQDIIQYPU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=W+hzRZTx66JDKseY3VPcHO3nBdgmEOGowLcH1HzGSSbdZkqen0PAuXs31gq6JEfQD
         jYsrAHW8iDOKXG+wP5tlN6PA79OhEdaWVl2kTYqVNROQetaV3WLlpFaZzUXjYgqUC6
         17k6bPeRRSE/LOVdX3DlOHOU+EnLCE6P7sVEockQ=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190903024539epcas1p4767abcddff25ba9c7991ddce9311dd26~AzZvETWqn2641626416epcas1p4H;
        Tue,  3 Sep 2019 02:45:39 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46Mrsr0CJfzMqYkb; Tue,  3 Sep
        2019 02:45:36 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.D6.04160.FC3DD6D5; Tue,  3 Sep 2019 11:45:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190903024535epcas1p18e0d59ab814d5ef4cb407aea58fb4ba0~AzZrvGatO1989919899epcas1p1P;
        Tue,  3 Sep 2019 02:45:35 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190903024535epsmtrp2e162e3d4a8c98f13660208d8691b54b3~AzZruWyYO1998819988epsmtrp2-;
        Tue,  3 Sep 2019 02:45:35 +0000 (GMT)
X-AuditID: b6c32a38-b33ff70000001040-28-5d6dd3cf83d1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.45.03638.FC3DD6D5; Tue,  3 Sep 2019 11:45:35 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190903024535epsmtip18ca53379a56ebf0083b5a200472b2f36~AzZrjzn1n0227902279epsmtip1h;
        Tue,  3 Sep 2019 02:45:35 +0000 (GMT)
Subject: Re: [GIT PULL] extcon next for v5.4
To:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <738ed1d9-65d9-2e4a-6d33-26493e8d288d@samsung.com>
Date:   Tue, 3 Sep 2019 11:49:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4c61ce13-69c7-f6ce-ae37-722f370371f4@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0gUURjt7szOzi6t3VatL4vSqYhE03FdG0stKsKwH/Yuw7ZBh9XcVzu7
        Pf8olqn0kohozdSiMjWM1SLFR6xRaW8sUaNSU5QIg9TogdHujpL/zvfdc+75zr0fTWiKqCA6
        02wXbGbeyFAq8n7r8ojwVx2m1MjystVcUddbksu9XkNxHQ1XKO59TgW1lkx0VRZQiS0l1YrE
        s3WVKHHUtTCZTMmKyxD4dMEWLJjTLOmZZkM8k7RNv16vi4lkw9lYbiUTbOZNQjyzYXNy+MZM
        o8eSCT7EGx2eVjIvikxEQpzN4rALwRkW0R7PCNZ0ozXWukLkTaLDbFiRZjGtYiMjo3Qe4v6s
        jLHaWtI6EXhk6NFZIhsN4kKkpAFHw6fyCXkhUtEa/ADBt6ZWhVR8RzCQMySTih8Iqt5UEVOS
        mr6nhHTQhKC/uX5S/w1B34t20svyx2Hwy/nRw6LpAJwJIydl3jaBRXCVTFBeTOFQaBnu8uFZ
        OATe/fyMvFiNE6Aiv8h3DYmXwJObf32cQLwbvve2yiXObGi7PODjKPEaeHa6WyHdPxd6Bkon
        vRZB7r1i36CAn1PQ/9stkxJsgIf1w3IJ+8OXJ3UKCQfB6EgTJeHjcLvtESWJ8xHUtbyeFGih
        5cYFmTcYgZdDTUOE1A6B+j8lSDL2g5Hx03IvBbAa8vM0EmUxdPR+mBxhHlw/VUCdR4xzWhzn
        tAjOaRGc/83KEFmJ5ghW0WQQRNYaPf23Xci3jqHcA9T4crMbYRoxM9XDyJSqkfOHxKMmNwKa
        YALUOxqNqRp1On/0mGCz6G0OoyC6kc7z2kVEUGCaxbPcZrue1UVptVoumo3RsSwzV13+k0vV
        YANvF7IEwSrYpnQyWhmUjW7t0W/d8vdSWXdbsyJc1T40SvV1jvEHEsq+diipQZFUVaou4N4F
        urylPUolXxE9y784tr/z/UVnTO6JD8S5x6X6tq7ae42HX+6NMOyY1+6OKh8YPGM6k7QuZcbw
        Vay9c3D2tW5lVMV8V1g252hadm77rupN648f4O5e25ezc9yvgSHFDJ4NJWwi/w/14MSbpAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSnO75y7mxBgefKVhMvHGFxaJ58Xo2
        i8u75rBZ3G5cwebA4rFpVSebx/65a9g9+rasYvT4vEkugCWKyyYlNSezLLVI3y6BK+PL5s0s
        BX9FK54f6WNuYHwq0MXIySEhYCKx/uEJ5i5GLg4hgd2MEos/f2CDSEhKTLt4FCjBAWQLSxw+
        XAwSFhJ4yygx/w47iC0soCPxc9Y9ZhBbRCBTYmLHFlYQm1mgWOLDw62sEPWTGCXOtzOC2GwC
        WhL7X9wAG88voChx9cdjsDivgJ3Eio6JLCA2i4CKxPFl/8BqRAUiJA7vmAVVIyhxcuYTsBpO
        AXuJ0z032SF2qUv8mXeJGcIWl7j1ZD4ThC0v0bx1NvMERuFZSNpnIWmZhaRlFpKWBYwsqxgl
        UwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgmNES2sH44kT8YcYBTgYlXh4J/zPiRViTSwr
        rsw9xCjBwawkwhu6ByjEm5JYWZValB9fVJqTWnyIUZqDRUmcVz7/WKSQQHpiSWp2ampBahFM
        lomDU6qB0SLvX20u6/XYA+bmh5qmP550lW9CiOeKGRMrGKdfYHsxocj//+wTvOFl/lH5TzpW
        uOX8u/OY5c5P04lFf2+WW/AvvNNgtahfL6WYrTlG9WXH3tQJmy3TbfTuGp3aeveuus6U3NX/
        u6Z+7DvnfkpjcQZbybTQ0DuPjThMUr7O8Tte8OXVl4vqSUosxRmJhlrMRcWJAFDGcGONAgAA
X-CMS-MailID: 20190903024535epcas1p18e0d59ab814d5ef4cb407aea58fb4ba0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190826025109epcas1p2add5354e4989028cd942b2121447dfd8
References: <CGME20190826025109epcas1p2add5354e4989028cd942b2121447dfd8@epcas1p2.samsung.com>
        <4c61ce13-69c7-f6ce-ae37-722f370371f4@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

Gently ping. 

Best Regards,
Chanwoo Choi


On 19. 8. 26. 오전 11:55, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.4. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> 
> Detailed description for this pull request:
> 1. Clean up the and fix the minor issue of extcon provider driver
> - extcon-arizona/max77843 replace the helper function
>   with more correct helper function without operation changes.
> - extcon-fsa9480 supports the FSA880 variant by adding the compatible name.
> - extcon-arizona updates the dt-binding file for the readability.
> - extcon-gpio initializes the interrupt flags according to active-low state.
> - Clean up extcon-sm5502/axp288/adc-jack
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
> 
>   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.4
> 
> for you to fetch changes up to a3fc5723397703a56fb6083b3e2f2ac601d1dfe0:
> 
>   extcon: adc-jack: Remove dev_err() usage after platform_get_irq() (2019-07-31 09:55:46 +0900)
> 
> ----------------------------------------------------------------
> Andy Shevchenko (3):
>       extcon: arizona: Switch to use device_property_count_u32()
>       extcon: axp288: Add missed error check
>       extcon: axp288: Use for_each_set_bit() in axp288_extcon_log_rsi()
> 
> Charles Keepax (1):
>       extcon: arizona: Update binding example to use available defines
> 
> Linus Walleij (2):
>       extcon: fsa9480: Support the FSA880 variant
>       extcon: gpio: Request reasonable interrupts
> 
> Stephen Boyd (1):
>       extcon: adc-jack: Remove dev_err() usage after platform_get_irq()
> 
> Vasyl Gomonovych (1):
>       extcon: sm5502: Add IRQ_ONESHOT
> 
> Wolfram Sang (1):
>       extcon: extcon-max77843: convert to i2c_new_dummy_device
> 
>  .../devicetree/bindings/extcon/extcon-arizona.txt  |  2 +-
>  .../devicetree/bindings/extcon/extcon-fsa9480.txt  |  4 ++-
>  drivers/extcon/extcon-adc-jack.c                   |  4 +--
>  drivers/extcon/extcon-arizona.c                    |  2 +-
>  drivers/extcon/extcon-axp288.c                     | 16 ++++++------
>  drivers/extcon/extcon-fsa9480.c                    |  1 +
>  drivers/extcon/extcon-gpio.c                       | 29 ++++++++++++++--------
>  drivers/extcon/extcon-max77843.c                   |  6 ++---
>  drivers/extcon/extcon-sm5502.c                     |  2 +-
>  9 files changed, 39 insertions(+), 27 deletions(-)
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
