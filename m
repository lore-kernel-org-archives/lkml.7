Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762C6C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5282E21479
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfEVKyk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:54:40 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:44464 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbfEVKyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:54:40 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 4946C17102; Wed, 22 May 2019 11:54:38 +0100 (BST)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@nxp.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 0/5] Exynos EHCI/OHCI: resolve conflict with the generic USB device bindings
References: <CGME20190521120015eucas1p1da2f3f32d6b8af8cb550463686fd4e12@eucas1p1.samsung.com>
        <20190521115849.9882-1-m.szyprowski@samsung.com>
        <yw1xk1ekszo9.fsf@mansr.com>
        <ff3f4b25-cbc0-4195-79b2-c00633f0c79c@samsung.com>
Date:   Wed, 22 May 2019 11:54:38 +0100
In-Reply-To: <ff3f4b25-cbc0-4195-79b2-c00633f0c79c@samsung.com> (Marek
        Szyprowski's message of "Wed, 22 May 2019 08:01:28 +0200")
Message-ID: <yw1x7eaiu5ch.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> Hi Måns
>
> On 2019-05-21 15:30, Måns Rullgård wrote:
>> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>>> Dear All,
>>>
>>> Commit 69bec7259853 ("USB: core: let USB device know device node") added
>>> support for attaching devicetree node for USB devices. Those nodes are
>>> children of their USB host controller. However Exynos EHCI and OHCI
>>> driver bindings already define child-nodes for each physical root hub
>>> port and assigns respective PHY controller and parameters to them. This
>>> leads to the conflict. A workaround for it has been merged as commit
>>> 01d4071486fe ("usb: exynos: add workaround for the USB device bindings
>>> conflict"), but it disabled support for USB device binding for Exynos
>>> EHCI/OHCI controllers.
>>>
>>> This patchset tries to resolve this binding conflict by changing Exynos
>>> EHCI/OHCI bindings: PHYs are moved from the sub-nodes to a standard array
>>> under the 'phys' property. Such solution has been suggested by Måns
>>> Rullgård in the following thread: https://lkml.org/lkml/2019/5/13/228
>>>
>>> To keep everything working during the transitional time, the changes has
>>> been split into 2 steps. First step (patches 1-3) need to be merged before
>>> the second one (patches 4-5). Patches from each step can be merged to
>>> respective trees without any dependencies - the only requirement is that
>>> second step has to be merged after merging all patches from the first one.
>>>
>>> This patchset has been tested on various Exynos4 boards with different
>>> USB host controller configurations (Odroids family: X2, U3, XU3).
>>>
>>> Best regards
>>> Marek Szyprowski
>>> Samsung R&D Institute Poland
>>>
>>> Marek Szyprowski (5):
>>>    dt-bindings: switch Exynos EHCI/OHCI bindings to use array of generic
>>>      PHYs
>>>    ARM: dts: exynos: Add array of generic PHYs to EHCI/OHCI devices
>>>    usb: exynos: add support for getting PHYs from the standard dt array
>>>    ARM: dts: exynos: Remove obsolete port sub-nodes from EHCI/OHCI
>>>      devices
>>>    usb: exynos: Remove support for legacy PHY bindings
>> You could retain compatibility with old devicetrees (which may be
>> useful) by using the "phys" property if it exists and falling back
>> on the old method if it doesn't.  Then you would get this sequence
>> of changes:
>>
>> 1. Update binding definition.
>> 2. Support new binding in driver, with fallback to old.
>> 3. Switch dts files to new binding.
>
> This is exactly what I did in this patchset. Until Patch #5 is applied, 
> Exynos EHCI/OHCI drivers supports both ways of getting PHYs and is fully 
> compatible with existing DTBs. This last patch should be applied at 
> least one release later that the first 3 patches to keep everything 
> working during the -rcX time.

I'm suggesting you keep the fallback in the driver.  It does no harm,
and it's contained in one place.

On the dts side, you're adding the new phys property without removing
the old-style nodes at first.  If you put the driver change first, the
dts could be switched to the new style in one patch without a confusing
hybrid ever existing.

> Compatibility with so called old DTBs is not so important, because there 
> are no boards with Exynos4 and Exynos5 SoCs, which would not update DTB 
> together with the kernel zImage. There have been already some 
> significant compatibility breaks related to those SoCs during last years.

You can't possibly know what's out there.  Besides, isn't the general
policy to not break compatibility without a very good reason?

-- 
Måns Rullgård
