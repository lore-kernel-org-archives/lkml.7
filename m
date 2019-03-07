Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0030C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7C920652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IfVearek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfCGIlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:41:13 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:52561 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfCGIlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:41:12 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190307084108epoutp0284944b6bb1039ecd94a1c5acab708018~JoIuk0S4M0553805538epoutp02l;
        Thu,  7 Mar 2019 08:41:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190307084108epoutp0284944b6bb1039ecd94a1c5acab708018~JoIuk0S4M0553805538epoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551948068;
        bh=tNCPZ/U2qH3g/U1ivb0DsWR77u64LmUQw7nx0kFq41E=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=IfVearekEr8Vo8O36kotgAckXEsm7xfe8wn6RO2dcBhdptVXlsk5ITJ/gx0SQ0IZE
         WLdhR2eh5KZDn4IIqqkEAo001/UO5RUUPtssj0Pfy2gpoy5YnvW40/Hk+6qKd/FWtd
         nm6YRaTYymkpuVjq57o6Qc31rPVRtmx7VAq6SU+k=
Received: from epsmges1p3.samsung.com (unknown [182.195.42.55]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190307084107epcas1p4408e05a224f906528286548b6d21f9cf~JoItfkVWF1986719867epcas1p4z;
        Thu,  7 Mar 2019 08:41:07 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.28.04069.229D08C5; Thu,  7 Mar 2019 17:41:07 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190307084106epcas1p355e4c9b3150f395f0a58f4f1ab052513~JoItG9PMA0113001130epcas1p3s;
        Thu,  7 Mar 2019 08:41:06 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-94-5c80d922c0b6
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.5D.04015.229D08C5; Thu,  7 Mar 2019 17:41:06 +0900 (KST)
Received: from [106.116.147.40] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PNZ00AECMSDW070@mmp1.samsung.com>; Thu, 07 Mar 2019 17:41:06 +0900 (KST)
Subject: Re: [PATCH v4 4/8] drivers: devfreq: add DMC driver for Exynos5422
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     cwchoi00@gmail.com, Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <84c06add-8375-55a6-01d6-ebbc6af011a9@samsung.com>
Date:   Thu, 07 Mar 2019 09:41:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-version: 1.0
In-reply-to: <4bbc0f61-952e-bcdb-4645-2644a122ac99@samsung.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7bCmga7yzYYYg41HmCw2zljPanH9y3NW
        i2dHtS3mHznHatH/+DWzxfnzG9gtzja9Ybe41SBjsenxNVaLy7vmsFl87j3CaDHj/D4mi7VH
        7rJb3G5cwebA57Fz1l12j02rOtk8Ni+p9zj4bg+TR9+WVYwenzfJBbBFcdmkpOZklqUW6dsl
        cGVsXf6ZsaCDreJ07y/2BsYPLF2MnBwSAiYSnw/vALK5OIQEdjBKPJ3/hhXC+c4o8bXrKlzV
        j6WLoKp2M0qsXv6aGcK5zyhxctJmNpAqYQFvibUdy5lBbBEBDYmZf68wghQxC+xlkTg4aR9Y
        EZuAoUTv0T5GEJtXwE5i2aybrCA2i4CqxOVbPWDNogIREu+f7maBqBGU+DH5HpjNKWAv8WnT
        O7B6ZgFNiRdfJrFA2OISx+7fZISw5SU2r3kLdp2EQDu7xP2/a9khfnCReLBtN5DNAWRLS1w6
        agsRrpbYtb0bqr6DUaLlwnZmiIS1xOHjF6GW8Um8+9rDCtHLK9HRJgRhekic2psCCYgJzBIf
        5/9imcAoMwvJ2bOQnDoLyamzkJy6gJFlFaNYakFxbnpqsWGBsV5xYm5xaV66XnJ+7iZGcMLR
        Mt/BuOGczyFGAQ5GJR7eiNP1MUKsiWXFlbmHGCU4mJVEeHcea4gR4k1JrKxKLcqPLyrNSS0+
        xCjNwaIkzrvewTlGSCA9sSQ1OzW1ILUIJsvEwSnVwKjlpXL5xPNJO+0e2ctGbHrQJ1LI6tFs
        ef2H060tepsnca7w7ShW4EjuY429d9HxKF/k98yYVXYMhwoLpG8ufP1A97xe5hFe/8JlVn8Y
        Xzob+329cnNu6RTPcylpCvP37X+SuY3b695+Zmbm91tMFY8ceOp48t3rJ2JxcxN/5UdoXJna
        J3uTp1uJpTgj0VCLuag4EQAKdUrbNAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsVy+t9jAV2lmw0xBr/XKFpsnLGe1eL6l+es
        Fs+OalvMP3KO1aL/8Wtmi/PnN7BbnG16w25xq0HGYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP
        3GW3uN24gs2Bz2PnrLvsHptWdbJ5bF5S73Hw3R4mj74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL
        4MrYuvwzY0EHW8Xp3l/sDYwfWLoYOTkkBEwkfixdBGRzcQgJ7GSUmHl/BRuE85BRYvmfi6wg
        VcIC3hJrO5Yzg9giAhoSM/9eYQQpYhY4yCJxe+Y8ZoiOScwSLUtfg81lEzCU6D3axwhi8wrY
        SSybdRNsEouAqsTlWz1gk0QFIiTuXnzBAlEjKPFj8j0wm1PAXuLTpndA9RxAG9QlpkzJBQkz
        C4hLHLt/kxHClpfYvOYt8wRGgVlIumchdMxC0jELSccCRpZVjJKpBcW56bnFRgWGeanlesWJ
        ucWleel6yfm5mxiBEbXtsFbfDsb7S+IPMQpwMCrx8CZcqo8RYk0sK67MPcQowcGsJMK781hD
        jBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe23nHIoUE0hNLUrNTUwtSi2CyTBycUg2MSuEv5QOn
        f1G9Pj+5cP0mnd/tq7LsmvZf5V4b/HuFceyXsytWsDY2zOKwPcrBcDH2ZLJr5/SD3ZeeaD6Y
        9eeWiMH28MTD/Oe6JNMDpvDWZqa9zfynMPWn2ZW4io0HFi222ba5vtYopeTtnhlCTpwt/nbG
        z9q3qJhJ/DZoW36N9e6Piq8FVmxMSizFGYmGWsxFxYkAXHb2PKQCAAA=
X-CMS-MailID: 20190307084106epcas1p355e4c9b3150f395f0a58f4f1ab052513
CMS-TYPE: 101P
X-CMS-RootMailID: 20190201164720eucas1p13aac6550399d240b261a2cbe489d3dfc
References: <CGME20190201164720eucas1p13aac6550399d240b261a2cbe489d3dfc@eucas1p1.samsung.com>
        <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
        <1549039612-28905-5-git-send-email-l.luba@partner.samsung.com>
        <CAGTfZH0o6dHQj00vHwZBn05AT-Z_oAWHfBX0eATQ12NPmfw4fg@mail.gmail.com>
        <94e169cf-4dc2-82ec-1385-852bc7853931@samsung.com>
        <4bbc0f61-952e-bcdb-4645-2644a122ac99@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 3/7/19 02:10, Chanwoo Choi wrote:
> This patch has the another quetion about the clocks in
> exynos5_dmc_init_clks(). This functions used 'clk_set_parent'
> to make the hierarchy between clocks. I think it is possible to make
> the relation of clocks in DT by using the 'assigned-clocks'.

I'm fine either way, AFAICS it is a matter of setting parent of just
one clock - "mout_mx_mspll_ccore".  The driver needs to get that clock
anyway to enable/disable it as required.  So we will not gain much from
using assigned-clocks I'd say. I don't really have a strong opinion here
as I don't know detailed requirements of the DMC clock configuration
sequence. I'm inclined to keep it in driver as it would be more flexible.

-- 
Regards,
Sylwester
