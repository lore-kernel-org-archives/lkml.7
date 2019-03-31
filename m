Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2020C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B77F20872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="FJbbbiDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbfCaKjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 06:39:01 -0400
Received: from onstation.org ([52.200.56.107]:35282 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfCaKjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 06:39:01 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 83589456EF;
        Sun, 31 Mar 2019 10:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1554028740;
        bh=tVtMvaZN6PTj/eSz9ZKbQf5y2Hhoa4ew9dlOUUjFyAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FJbbbiDdAHpKplomtvd7KN1qTcLwrkDJsRDQwF/trEGpHPc8278yvCSLjV7dnqlHs
         N0+PA1sYtt/cC5QVhsj1GYX4RhkheI6kAq0PCwGlr9Sq/h8wVJ3O0kdrqMdl0rlbMn
         7ZDlRWKGlzMaaQNHujqiC+RwLWqRvJ3uUYXG3yyg=
Date:   Sun, 31 Mar 2019 06:39:00 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 'reg: property has invalid length' with new JSON-schema bindings
Message-ID: <20190331103900.GA10428@basecamp>
References: <20190331022653.GA8727@basecamp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331022653.GA8727@basecamp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 10:26:53PM -0400, Brian Masney wrote:
> I'm finishing up a patch series that adds device tree support for a
> backlight driver and I made the bindings use the new JSON schema. I'm
> running into a problem with the reg property in the examples and I can
> reproduce the issue by adding an example to the trivial bindings:
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml
> b/Documentation/devicetree/bindings/trivial-devices.yaml
> index d79fb22bde39..bdab6a015db4 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -341,4 +341,10 @@ required:
>    - compatible
>    - reg
>  
> +examples:
> +  - |
> +    isl29028@38 {
> +        compatible = "isil,isl29028";
> +        reg = <0x38>;
> +    };
>  ...
> 
> 'make dt_binding_check' fails with the following error:
> 
>   Documentation/devicetree/bindings/trivial-devices.example.dts:11.5-18:
>     Warning (reg_format): /isl29028@38:reg: property has invalid length
>     (4 bytes) (#address-cells == 1, #size-cells == 1)
>   ...
>   Documentation/devicetree/bindings/trivial-devices.example.dtb:
>     Warning (i2c_bus_reg): Failed prerequisite 'reg_format'

I make the check happy by including an i2c node in my example.

examples:
  - |
    i2c {
        #address-cells = <1>;
        #size-cells = <0>;

        isl29028@38 {
                compatible = "isil,isl29028";
                reg = <0x38>;
        };
    };

Sorry about the noise.

Brian
