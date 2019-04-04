Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1296C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FBE2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nuOK4QIf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mf5Suj5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbfDDP6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:58:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54414 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfDDP6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:58:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6EF0B609F3; Thu,  4 Apr 2019 15:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554393520;
        bh=SjYD7LkpZFeudCLIro3RsY4IGzIcPmQiimxjetnOsF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nuOK4QIf1mhFNs6x6avUyh92sUY62yrOMFt+oaO935Y3uExR6tIbWieuhDNJcIMyA
         nlGhmW40li3EdU776BfkKFyc2zb/0Iw2xfRPuVNTf/tTCOEnHOb4Qc9c2cI7TW+zc8
         v4q8ixkhwtlvsCTuyFz3SZsUOn+QzpsziiyKaKCU=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 353116074F;
        Thu,  4 Apr 2019 15:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554393519;
        bh=SjYD7LkpZFeudCLIro3RsY4IGzIcPmQiimxjetnOsF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mf5Suj5vkeIvwNLe81OpMFCfo2l8AwlLe2adU3y66igDGAJxnOIYdAXwMrI66v1CQ
         kyG4lxvqd1gN8LUrEs+g6UgrhZOlBTjhnpyylU9+XrTuS28FSv8WIyrDF7EI467Xnk
         Vgvll5vCMbfv53S7yMAOZqtTV975H1HvwXDfaqLI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 353116074F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 4 Apr 2019 09:58:38 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     swboyd@chromium.org, evgreen@chromium.org,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 03/10] of/irq: document properties for wakeup
 interrupt parent
Message-ID: <20190404155838.GD10883@codeaurora.org>
References: <20190313211844.29416-1-ilina@codeaurora.org>
 <20190313211844.29416-4-ilina@codeaurora.org>
 <20190318174236.072f0a95@why.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190318174236.072f0a95@why.wild-wind.fr.eu.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18 2019 at 11:54 -0600, Marc Zyngier wrote:
>On Wed, 13 Mar 2019 15:18:37 -0600
>Lina Iyer <ilina@codeaurora.org> wrote:
>
>Please do Cc Rob when posting DT related patches.
>
>> Some interrupt controllers in a SoC, are always powered on and have a
>> select interrupts routed to them, so that they can wakeup the SoC from
>> suspend. Add wakeup-parent DT property to refer to these interrupt
>> controllers.
>>
>> If the interrupts routed to the wakeup parent are not sequential, than a
>> map needs to exist to associate the same interrupt line on multiple
>> interrupt controllers. Providing this map in every driver is cumbersome.
>> Let's add this in the device tree and document the properties to map the
>> interrupt specifiers
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>> Changes in v4:
>> 	- Added this documentation
>> ---
>>  .../interrupt-controller/interrupts.txt       | 39 +++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt b/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>> index 8a3c40829899..917b598317f5 100644
>> --- a/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>> @@ -108,3 +108,42 @@ commonly used:
>>  			sensitivity = <7>;
>>  		};
>>  	};
>> +
>> +3) Interrupt wakeup parent
>> +--------------------------
>> +
>> +Some interrupt controllers in a SoC, are always powered on and have a select
>> +interrupts routed to them, so that they can wakeup the SoC from suspend. These
>> +interrupt controllers do not fall into the category of a parent interrupt
>> +controller and can be specified by the "wakeup-parent" property and contain a
>> +single phandle referring to the wakeup capable interrupt controller.
>> +
>> +   Example:
>> +	wakeup-parent = <&pdc_intc>;
>> +
>> +
>> +4) Interrupt mapping
>> +--------------------
>> +
>> +Sometimes interrupts may be detected by more than one interrupt controller
>> +(depending on which controller is active). The interrupt controllers may not
>> +be in hierarchy and therefore the interrupt controller driver is required to
>> +establish the relationship between the same interrupt at different interrupt
>> +controllers. If these interrupts are not sequential then a map needs to be
>> +specified to help identify these interrupts.
>> +
>> +Mapping the interrupt specifiers in the device tree can be done using the
>> +"irqdomain-map" property. The property contains interrupt specifier at the
>> +current interrupt controller followed by the interrupt specifier at the mapped
>> +interrupt controller.
>> +
>> +   irqdomain-map = <incoming-interrupt-specifier mapped-interrupt-specifier>
>> +
>> +The optional properties "irqdomain-map-mask" and "irqdomain-map-pass-thru" may
>> +be provided to help interpret the valid bits of the incoming and mapped
>> +interrupt specifiers respectively.
>> +
>> +   Example:
>> +	irqdomain-map = <22 0 &intc 36 0>, <24 0 &intc 37 0>;
>> +	irqdomain-map-mask = <0xff 0>;
>> +	irqdomain-map-pass-thru = <0 0xff>;
>
>
>This doesn't quite explain how the mask and pass-thru properties are
>used. I guess that the mask is used to define the 'useful bits' on the
>incoming side, but pass-thru puzzles me. In your example, does it mean
>that incoming lines map to outgoing interrupt <0 0>?
>
Sorry about the late reply.

How about this to go with the rest of the documentation -

In the above example, the input interrupt specifier map-mask <0xff 0> applied
on the incoming interrupt specifier of the map <22 0>, <24 0>, returns the
input interrupt 22, 24 etc. The second argument being irq type is immaterial
from the map and is used from the incoming request instead. The pass-thru
specifier parses the output interrupt specifier from the rest of the unparsed
argments from the map <&intc 36 0>, <&intc 37 0> etc to return the output
interrupt 36, 37 etc.


--Lina

