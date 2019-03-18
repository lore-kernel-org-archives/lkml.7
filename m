Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A477C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E807120989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfCRRnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:43:53 -0400
Received: from foss.arm.com ([217.140.101.70]:38906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbfCRRmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:42:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C1A5EBD;
        Mon, 18 Mar 2019 10:42:43 -0700 (PDT)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 221EE3F614;
        Mon, 18 Mar 2019 10:42:40 -0700 (PDT)
Date:   Mon, 18 Mar 2019 17:42:36 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     swboyd@chromium.org, evgreen@chromium.org,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 03/10] of/irq: document properties for wakeup
 interrupt parent
Message-ID: <20190318174236.072f0a95@why.wild-wind.fr.eu.org>
In-Reply-To: <20190313211844.29416-4-ilina@codeaurora.org>
References: <20190313211844.29416-1-ilina@codeaurora.org>
        <20190313211844.29416-4-ilina@codeaurora.org>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 15:18:37 -0600
Lina Iyer <ilina@codeaurora.org> wrote:

Please do Cc Rob when posting DT related patches.

> Some interrupt controllers in a SoC, are always powered on and have a
> select interrupts routed to them, so that they can wakeup the SoC from
> suspend. Add wakeup-parent DT property to refer to these interrupt
> controllers.
> 
> If the interrupts routed to the wakeup parent are not sequential, than a
> map needs to exist to associate the same interrupt line on multiple
> interrupt controllers. Providing this map in every driver is cumbersome.
> Let's add this in the device tree and document the properties to map the
> interrupt specifiers
> 
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> Changes in v4:
> 	- Added this documentation
> ---
>  .../interrupt-controller/interrupts.txt       | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt b/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> index 8a3c40829899..917b598317f5 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> @@ -108,3 +108,42 @@ commonly used:
>  			sensitivity = <7>;
>  		};
>  	};
> +
> +3) Interrupt wakeup parent
> +--------------------------
> +
> +Some interrupt controllers in a SoC, are always powered on and have a select
> +interrupts routed to them, so that they can wakeup the SoC from suspend. These
> +interrupt controllers do not fall into the category of a parent interrupt
> +controller and can be specified by the "wakeup-parent" property and contain a
> +single phandle referring to the wakeup capable interrupt controller.
> +
> +   Example:
> +	wakeup-parent = <&pdc_intc>;
> +
> +
> +4) Interrupt mapping
> +--------------------
> +
> +Sometimes interrupts may be detected by more than one interrupt controller
> +(depending on which controller is active). The interrupt controllers may not
> +be in hierarchy and therefore the interrupt controller driver is required to
> +establish the relationship between the same interrupt at different interrupt
> +controllers. If these interrupts are not sequential then a map needs to be
> +specified to help identify these interrupts.
> +
> +Mapping the interrupt specifiers in the device tree can be done using the
> +"irqdomain-map" property. The property contains interrupt specifier at the
> +current interrupt controller followed by the interrupt specifier at the mapped
> +interrupt controller.
> +
> +   irqdomain-map = <incoming-interrupt-specifier mapped-interrupt-specifier>
> +
> +The optional properties "irqdomain-map-mask" and "irqdomain-map-pass-thru" may
> +be provided to help interpret the valid bits of the incoming and mapped
> +interrupt specifiers respectively.
> +
> +   Example:
> +	irqdomain-map = <22 0 &intc 36 0>, <24 0 &intc 37 0>;
> +	irqdomain-map-mask = <0xff 0>;
> +	irqdomain-map-pass-thru = <0 0xff>;


This doesn't quite explain how the mask and pass-thru properties are
used. I guess that the mask is used to define the 'useful bits' on the
incoming side, but pass-thru puzzles me. In your example, does it mean
that incoming lines map to outgoing interrupt <0 0>?

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
