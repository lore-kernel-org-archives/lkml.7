Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4A1C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B3A208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfEMKEB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:04:01 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:36202 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727690AbfEMKEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:04:00 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 74D29149B5; Mon, 13 May 2019 11:03:58 +0100 (BST)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Peter Chen <peter.chen@nxp.com>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-samsung-soc\@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3] usb: core: verify devicetree nodes for USB devices
References: <yw1xpnotufti.fsf@mansr.com>
        <CGME20190509084827eucas1p294962744fe70745c50b69a5349b5de68@eucas1p2.samsung.com>
        <20190509084726.5405-1-m.szyprowski@samsung.com>
        <yw1xlfzfv4ol.fsf@mansr.com>
        <VI1PR04MB5327AD56CA772284DFE663D08B0C0@VI1PR04MB5327.eurprd04.prod.outlook.com>
        <7c5579d2-634a-d705-a451-563939957d57@samsung.com>
Date:   Mon, 13 May 2019 11:03:58 +0100
In-Reply-To: <7c5579d2-634a-d705-a451-563939957d57@samsung.com> (Marek
        Szyprowski's message of "Fri, 10 May 2019 11:43:41 +0200")
Message-ID: <yw1x4l5yvfg1.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> Hi Peter,
>
> On 2019-05-10 05:10, Peter Chen wrote:
>>
>>> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>>>> Commit 69bec7259853 ("USB: core: let USB device know device node")
>>>> added support for attaching devicetree node for USB devices. The
>>>> mentioned commit however identifies the given USB device node only by the 'reg'
>>>> property in the host controller children nodes. The USB device node
>>>> however also has to have a 'compatible' property as described in
>>>> Documentation/devicetree/bindings/usb/usb-device.txt. Lack for the
>>>> 'compatible' property check might result in assigning a devicetree
>>>> node, which is not intended to be the proper node for the given USB device.
>>>>
>>>> This is important especially when USB host controller has child-nodes
>>>> for other purposes. For example, Exynos EHCI and OHCI drivers already
>>>> define child-nodes for each physical root hub port and assigns
>>>> respective PHY controller and parameters for them. Those binding
>>>> predates support for USB devicetree nodes.
>>>>
>>>> Checking for the proper compatibility string allows to mitigate the
>>>> conflict between USB device devicetree nodes and the bindings for USB
>>>> controllers with child nodes. It also fixes the side-effect of the
>>>> other commits, like 01fdf179f4b0 ("usb: core: skip interfaces disabled
>>>> in devicetree"), which incorrectly disables some devices on Exynos
>>>> based boards.
>> Hi Marek,
>>
>> The purpose of your patch is do not set of_node for device under USB
>> controller, right?
>
> Right.
>
>> I do not understand how 01fdf179f4b0 affect your boards, some nodes
>> under the USB controller with status is not "okay", but still want to
>> be enumerated?
>
> Please look at the ehci node in arch/arm/boot/dts/exynos4.dtsi and then 
> at the changes to that node in arch/arm/boot/dts/exynos4412-odroidx.dts. 
> Exynos EHCI controller has 3 subnodes, which matches to the physical 
> ports of it and allows the driver to enable given PHY ports depending on 
> which physical port is used on the particular board. All ports cannot 
> not be enabled by default, because PHY controller has limited resources 
> and shares them between USB host and USB device ports.

It seems like what's happening is that the Exynos port/phy nodes are
mistaken for standard USB device nodes attached to the root hub.  The
problem is that hub port numbering starts at 1 while the Exynos nodes
start from 0.  This causes attached devices to be associated with the
wrong DT node.

Ignoring backwards compatibility, I can see a few ways of fixing this:

- Add another child node, along side the port@N nodes, of the host
  controller to represent the root hub.  Nodes for attached devices
  would then be descendants of this new node.

- Change the Exynos HCD binding to use a more standard "phys" property
  and get rid of the child nodes for this purpose.

- Move the port@N nodes below a new dedicated child node of the HCD.

The first is probably the easiest to implement since it doesn't require
any nasty hacks to avoid breaking existing device trees.

-- 
Måns Rullgård
