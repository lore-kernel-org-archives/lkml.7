Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF8DC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C30D2087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jK5cIqgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfEQLTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 07:19:05 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47597 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfEQLTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 07:19:05 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190517111903euoutp02c0e4c298aebc839ce95949d0128087d0~fdF4u4Teq2610926109euoutp02E
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 11:19:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190517111903euoutp02c0e4c298aebc839ce95949d0128087d0~fdF4u4Teq2610926109euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558091943;
        bh=raW73Fmp0SchwvyAcfTJ/aArOV8157rWG22rbQpTcII=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jK5cIqgTZPd/wjeFmVLeZCGs1yBj+jTY2mzN2FD7AKkxkDSTzKyKQWQHkD/UoAWad
         Vnfp0/IsDv5ls3Zb+KCTJHmr7f0J7gtsyOCVaaXNizahlmDutgtG1B4DlpPdB3Edzb
         InzZF8P5FucMalvZNFxaIXeLK2TUoWcIjfXI6skE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190517111903eucas1p1fff781e1b6f397c5e9e5d30dc38f7c36~fdF4KZYiK2057620576eucas1p1O;
        Fri, 17 May 2019 11:19:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F5.EC.04298.6A89EDC5; Fri, 17
        May 2019 12:19:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190517111902eucas1p1f0c52ecf0e0d9aec090f6ad16ca5a7ef~fdF3W56Xo1808118081eucas1p1c;
        Fri, 17 May 2019 11:19:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190517111902eusmtrp10ae81b603f07d628d673ea91d5872b2a~fdF3I6P8c0771307713eusmtrp1S;
        Fri, 17 May 2019 11:19:02 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-5a-5cde98a6e00f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2B.13.04140.6A89EDC5; Fri, 17
        May 2019 12:19:02 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190517111901eusmtip27dc496be6e0e5da702d85878731dd4c7~fdF2tPcl12007820078eusmtip2F;
        Fri, 17 May 2019 11:19:01 +0000 (GMT)
Subject: Re: [PATCH v3] usb: core: verify devicetree nodes for USB devices
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Peter Chen <peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <515ee8df-d186-45ec-698c-f2e68097159d@samsung.com>
Date:   Fri, 17 May 2019 13:18:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <yw1x4l5yvfg1.fsf@mansr.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0iTYRTu3bft+zacvk5lB7WSgYFCmmjxiSJa/hgZYn/6kYNa+uElnbp5
        LTAveFtiqZS2LC1xhpSXsWSJJpl4Sdq8BJq3mtiPhTPIBG9Ibp+W/55znuec5zxwKELcz/Ok
        UpTZjEqpSJPyhdzekW3T2fbGZfm5il1E9zR28ejS1i4+bTZ3k/RMXxOfbjS/59AvdWUEbR3e
        QvSWpYFD7y0v8iIFsvnFezJ9RxVfNvjsNSlbm/hEynrWjRxZjaEDyTb0p+LI68LwRCYtJZdR
        BUbcFCZ3Vo6RmVbv/M2KkCJkkGiQgAIcAm2WEqRBQkqMXyFoXhjgs8UfBMayWg5bbCAoaWnl
        HI1Yvu1wWaIdwZe5DtJOiLENQV1PjB274cugM83y7dgdnwejdsqxlsA6Anaa9Dw7wcdBoLFp
        HCIRjoCxvn7HIi72hYXipQMHivLAcni5cShxhfEnq1w7FmA/qLlf5TiIwKeh9O1TgsUSmF9t
        PjzURMLXiTAWR4Pu8xSPxW7wc9RAstgbJuqrHWEAlyKwmN6QbFGNYKakEbGqMPg4ap+mDhz8
        oKsvkG1HwdpSP8feBuwMczZX9gZnqOttINi2CCrLxaz6DGhHO//ZfpicJh4iqfZYMu2xNNpj
        abT/fVsQtwNJmBx1ehKjDlIyeQFqRbo6R5kUkJCRrkcHPzWxP/rbiDanbw0hTCGpkwhfWZKL
        eYpcdUH6EAKKkLqLun8tyMWiREXBHUaVcUOVk8aoh5AXxZVKRHdPfI8X4yRFNnObYTIZ1RHL
        oQSeRSjM8q4mbvd59NAgHew7kN/iH+6VMPZixClRI9+ODe2Mjyr06Huwohl32XkUXtgj3PXZ
        8JXXzAx7VFWuC/FjnwXZyirkETFetW3uHlUXjan7W1nrs6nleM+lvN41dpLKuuZSbKKV1v5L
        PzTYQFjNxSu2iOCrTGjklu7CSddmKVedrAjyJ1RqxV/DmrKqTwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xe7rLZtyLMfi0mtdi44z1rBbNi9ez
        WZw/v4Hd4vKuOWwWM87vY7JYtKyV2eLlkR+MFj8eTmey+HPvDqsDp8etO/Uem1Z1snnsn7uG
        3ePN6VPsHhvf7WDy6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2Pz
        WCsjUyV9O5uU1JzMstQifbsEvYx1HSfYC17KVHxtN2lg3CLexcjJISFgIvHw/i+WLkYuDiGB
        pYwSSzd8YIRIyEicnNbACmELS/y51sUGYgsJvGaU+NMqCGILC3hJLDt3HSwuImAqsWPWRTaQ
        QcwCy5gljt4+yggx9TOTxM+rq8Gq2AQMJbreQkziFbCTOLFrDzuIzSKgKnG78S4LiC0qECNx
        YuoWdogaQYmTM5+AxTkFNCX6ujuZQGxmATOJeZsfMkPY8hLNW2dD2eISt57MZ5rAKDQLSfss
        JC2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmBsbjv2c8sOxq53wYcYBTgY
        lXh4BXzuxgixJpYVV+YeYpTgYFYS4d3w/naMEG9KYmVValF+fFFpTmrxIUZToOcmMkuJJucD
        00ZeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGnVFiotsj8lqO
        b3/zvefKVSsxw0/rrc8ezBC6s31jmPbs5yWtzx6oJaadeyN+uq2kzLSOY+/r5XVMmRKH5p1+
        vvvQwcwX25ckzVqtfLNx1+Yv/rt3HXd/vKScSfujr5WSAXNth6/UwdZq1TW3jh3i2KV8usRz
        1qR95qvZ5x9V4Z9yes9S8WwzViWW4oxEQy3mouJEAF3HZcnjAgAA
X-CMS-MailID: 20190517111902eucas1p1f0c52ecf0e0d9aec090f6ad16ca5a7ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190509084827eucas1p294962744fe70745c50b69a5349b5de68
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190509084827eucas1p294962744fe70745c50b69a5349b5de68
References: <yw1xpnotufti.fsf@mansr.com>
        <CGME20190509084827eucas1p294962744fe70745c50b69a5349b5de68@eucas1p2.samsung.com>
        <20190509084726.5405-1-m.szyprowski@samsung.com>
        <yw1xlfzfv4ol.fsf@mansr.com>
        <VI1PR04MB5327AD56CA772284DFE663D08B0C0@VI1PR04MB5327.eurprd04.prod.outlook.com>
        <7c5579d2-634a-d705-a451-563939957d57@samsung.com>
        <yw1x4l5yvfg1.fsf@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Måns

On 2019-05-13 12:03, Måns Rullgård wrote:
> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>> Hi Peter,
>>
>> On 2019-05-10 05:10, Peter Chen wrote:
>>>
>>>> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>>>>> Commit 69bec7259853 ("USB: core: let USB device know device node")
>>>>> added support for attaching devicetree node for USB devices. The
>>>>> mentioned commit however identifies the given USB device node only by the 'reg'
>>>>> property in the host controller children nodes. The USB device node
>>>>> however also has to have a 'compatible' property as described in
>>>>> Documentation/devicetree/bindings/usb/usb-device.txt. Lack for the
>>>>> 'compatible' property check might result in assigning a devicetree
>>>>> node, which is not intended to be the proper node for the given USB device.
>>>>>
>>>>> This is important especially when USB host controller has child-nodes
>>>>> for other purposes. For example, Exynos EHCI and OHCI drivers already
>>>>> define child-nodes for each physical root hub port and assigns
>>>>> respective PHY controller and parameters for them. Those binding
>>>>> predates support for USB devicetree nodes.
>>>>>
>>>>> Checking for the proper compatibility string allows to mitigate the
>>>>> conflict between USB device devicetree nodes and the bindings for USB
>>>>> controllers with child nodes. It also fixes the side-effect of the
>>>>> other commits, like 01fdf179f4b0 ("usb: core: skip interfaces disabled
>>>>> in devicetree"), which incorrectly disables some devices on Exynos
>>>>> based boards.
>>> Hi Marek,
>>>
>>> The purpose of your patch is do not set of_node for device under USB
>>> controller, right?
>> Right.
>>
>>> I do not understand how 01fdf179f4b0 affect your boards, some nodes
>>> under the USB controller with status is not "okay", but still want to
>>> be enumerated?
>> Please look at the ehci node in arch/arm/boot/dts/exynos4.dtsi and then
>> at the changes to that node in arch/arm/boot/dts/exynos4412-odroidx.dts.
>> Exynos EHCI controller has 3 subnodes, which matches to the physical
>> ports of it and allows the driver to enable given PHY ports depending on
>> which physical port is used on the particular board. All ports cannot
>> not be enabled by default, because PHY controller has limited resources
>> and shares them between USB host and USB device ports.
> It seems like what's happening is that the Exynos port/phy nodes are
> mistaken for standard USB device nodes attached to the root hub.  The
> problem is that hub port numbering starts at 1 while the Exynos nodes
> start from 0.  This causes attached devices to be associated with the
> wrong DT node.
>
> Ignoring backwards compatibility, I can see a few ways of fixing this:
>
> - Add another child node, along side the port@N nodes, of the host
>    controller to represent the root hub.  Nodes for attached devices
>    would then be descendants of this new node.
>
> - Change the Exynos HCD binding to use a more standard "phys" property
>    and get rid of the child nodes for this purpose.
>
> - Move the port@N nodes below a new dedicated child node of the HCD.
>
> The first is probably the easiest to implement since it doesn't require
> any nasty hacks to avoid breaking existing device trees.

I've posted a patch, which disables creating USB device nodes for Exynos 
HCD devices (by zeroing their of_node pointer). Then I will try to apply 
the second approach from the above list, but merging it to mainline will 
require a few more steps and some time.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

