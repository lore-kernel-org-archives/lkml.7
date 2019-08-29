Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCACC41514
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCC523439
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfH2Kvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:51:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59724 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbfH2Kvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:51:46 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5149428D325;
        Thu, 29 Aug 2019 11:51:43 +0100 (BST)
Date:   Thu, 29 Aug 2019 12:51:38 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i3c@lists.infradead.org, bbrezillon@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, Joao.Pinto@synopsys.com
Subject: Re: [PATCH 3/4] dt-bindings: i3c: Make 'assigned-address' valid if
 static address != 0
Message-ID: <20190829125138.4b36b8f6@collabora.com>
In-Reply-To: <9d69c83c7193e377bbc77bea7f1812fc17dafaee.1567071213.git.vitor.soares@synopsys.com>
References: <cover.1567071213.git.vitor.soares@synopsys.com>
        <9d69c83c7193e377bbc77bea7f1812fc17dafaee.1567071213.git.vitor.soares@synopsys.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 12:19:34 +0200
Vitor Soares <Vitor.Soares@synopsys.com> wrote:

> The I3C devices without a static address can require a specific dynamic
> address for priority reasons.
> 
> Let's update the binding document to make the 'assigned-address' property
> valid if static address != 0 and add an example with this use case.

           ^ you mean static address == 0, right?

Yes, it makes sense to support that case and do our best to assign the
requested address after DAA has taken place by explicitly executing
SETDA.

> 
> Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> ---
>  Documentation/devicetree/bindings/i3c/i3c.txt | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i3c/i3c.txt b/Documentation/devicetree/bindings/i3c/i3c.txt
> index ab729a0..c851e75 100644
> --- a/Documentation/devicetree/bindings/i3c/i3c.txt
> +++ b/Documentation/devicetree/bindings/i3c/i3c.txt
> @@ -98,9 +98,7 @@ Required properties
>  
>  Optional properties
>  -------------------
> -- assigned-address: dynamic address to be assigned to this device. This
> -		    property is only valid if the I3C device has a static
> -		    address (first cell of the reg property != 0).
> +- assigned-address: dynamic address to be assigned to this device.

We should probably mention that we don't provide strong guarantees
here. We will try to assign this dynamic address to the device, but if
something fails (like another device owning the address and refusing to
give it up), the actual dynamic address will be different.
This clarification can be done in a separate patch.

>  
>  
>  Example:
> @@ -129,6 +127,15 @@ Example:
>  
>  		/*
>  		 * I3C device without a static I2C address but requiring
> +		 * specific dynamic address.
> +		 */
> +		sensor@0,39200154004 {
> +			reg = <0x0 0x6072 0x303904d2>;
> +			assigned-address = <0xb>;
> +		};
> +
> +		/*
> +		 * I3C device without a static I2C address but requiring
>  		 * resources described in the DT.
>  		 */
>  		sensor@0,39200154004 {

