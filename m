Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E9FC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B4D208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfEMKGl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:06:41 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:36228 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbfEMKGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:06:41 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id D154B149B5; Mon, 13 May 2019 11:06:39 +0100 (BST)
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
        <VI1PR04MB5327B425756FA394C51525208B0F0@VI1PR04MB5327.eurprd04.prod.outlook.com>
        <3544eb61-2bd8-338d-8d62-d95a775528ef@samsung.com>
        <VI1PR04MB5327FAC12E4A3D403E8D92128B0F0@VI1PR04MB5327.eurprd04.prod.outlook.com>
        <5d0abe9c-613c-d39b-6746-78e5e5c2bbc5@samsung.com>
Date:   Mon, 13 May 2019 11:06:39 +0100
In-Reply-To: <5d0abe9c-613c-d39b-6746-78e5e5c2bbc5@samsung.com> (Marek
        Szyprowski's message of "Mon, 13 May 2019 12:03:18 +0200")
Message-ID: <yw1xzhnqu0r4.fsf@mansr.com>
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
> On 2019-05-13 11:23, Peter Chen wrote:
>>> On 2019-05-13 11:00, Peter Chen wrote:
>>>>> On 2019-05-10 05:10, Peter Chen wrote:
>>>>>>> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>>>>>>>> Commit 69bec7259853 ("USB: core: let USB device know device node")
>>>>>>>> added support for attaching devicetree node for USB devices. The
>>>>>>>> mentioned commit however identifies the given USB device node only
>>>>>>>> by the
>>>>> 'reg'
>>>>>>>> property in the host controller children nodes. The USB device
>>>>>>>> node however also has to have a 'compatible' property as described
>>>>>>>> in Documentation/devicetree/bindings/usb/usb-device.txt. Lack for
>>>>>>>> the 'compatible' property check might result in assigning a
>>>>>>>> devicetree node, which is not intended to be the proper node for the given
>>> USB device.
>>>>>>>> This is important especially when USB host controller has
>>>>>>>> child-nodes for other purposes. For example, Exynos EHCI and OHCI
>>>>>>>> drivers already define child-nodes for each physical root hub port
>>>>>>>> and assigns respective PHY controller and parameters for them.
>>>>>>>> Those binding predates support for USB devicetree nodes.
>>>>>>>>
>>>>>>>> Checking for the proper compatibility string allows to mitigate
>>>>>>>> the conflict between USB device devicetree nodes and the bindings
>>>>>>>> for USB controllers with child nodes. It also fixes the
>>>>>>>> side-effect of the other commits, like 01fdf179f4b0 ("usb: core:
>>>>>>>> skip interfaces disabled in devicetree"), which incorrectly
>>>>>>>> disables some devices on Exynos based boards.
>>>>>> Hi Marek,
>>>>>>
>>>>>> The purpose of your patch is do not set of_node for device under USB
>>>>>> controller,
>>>>> right?
>>>>>
>>>>> Right.
>>>>>
>>>> Do you mind doing it at function exynos_ehci_get_phy of ehci-exynos.c?
>>> I don't mind fixing it in ehci-exynos, but frankly so far I have no
>>> idea how to do it.  The problem is that newly created USB devices
>>> get of-node pointer pointing to a node which if not intended for
>>> them. How this can be fixed in ehci-exynos?
>>>
>>   
>> Can't be workaround by setting of_node as NULL for EHCI controller or
>> for PHY node at exynos_ehci_get_phy?
>
> Ah, such workaround? I will check, but this will need to be done with 
> care, because have a side effect for other subsystems like regulators or 
> clocks.
>
> BTW, What's wrong with proper, full verification of USB device nodes?

Your approach so far doesn't address the actual problem of a conflict
between the generic USB DT bindings and those for the Exynos host
controller.  If you fix that, the validation issue goes away.

-- 
Måns Rullgård
