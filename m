Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF51C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3E1206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbfFLOqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:46:08 -0400
Received: from foss.arm.com ([217.140.110.172]:54956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728707AbfFLOqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:46:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD29D2B;
        Wed, 12 Jun 2019 07:46:06 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E4533F557;
        Wed, 12 Jun 2019 07:46:05 -0700 (PDT)
Date:   Wed, 12 Jun 2019 15:45:59 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RESEND PATCH v1 3/5] dt-bindings: Add depends-on property
Message-ID: <20190612144559.GA21466@e107155-lin>
References: <20190604003218.241354-1-saravanak@google.com>
 <20190604003218.241354-4-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604003218.241354-4-saravanak@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 05:32:16PM -0700, Saravana Kannan wrote:
> The depends-on property is used to list the mandatory functional
> dependencies of a consumer device on zero or more supplier devices.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  .../devicetree/bindings/depends-on.txt        | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/depends-on.txt
> 
> diff --git a/Documentation/devicetree/bindings/depends-on.txt b/Documentation/devicetree/bindings/depends-on.txt
> new file mode 100644
> index 000000000000..1cbddd11cf17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/depends-on.txt
> @@ -0,0 +1,26 @@
> +Functional dependency linking
> +=============================
> +
> +Apart from parent-child relationships, devices (consumers) often have
> +functional dependencies on other devices (suppliers). Common examples of
> +suppliers are clock, regulators, pinctrl, etc. However not all of them are
> +dependencies with well defined devicetree bindings. Also, not all functional
> +dependencies are mandatory as the device might be able to operate in a limited
> +mode without some of the dependencies.
> +
> +The depends-on property allows marking these mandatory functional dependencies
> +between one or more devices. The depends-on property is used by the consumer
> +device to point to all its mandatory supplier devices.
> +
> +Optional properties:
> +- depends-on:	A list of phandles to mandatory suppliers of the device.
> +
> +
> +Examples:
> +Here, the device is dependent on only 2 of the 3 clock providers
> +dev@40031000 {
> +	      compatible = "name";
> +	      reg = <0x40031000 0x1000>;
> +	      clocks = <&osc_1 1>, <&osc_2 7> <&osc_3 5>;
> +	      depends-on = <&osc_1>, <&osc_3>;

Why is this not implicit from clocks property and why is there need for
explicit mention of this ?

What happens if there's a cyclic dependency ? From hardware perspective,
cyclic dependency is quite feasible, so IMO it's hard to define this
property unambiguously.

And being optional, we need to deal with the absence of these, and if we
fallback to marking clock, regulators, pinctrl suppliers as depends-on,
this may end up redundant.

You may need to show examples(preferably with DTs in mainline just to
help understand it quickly and easily) that are beyond these standard
suppliers that are not implicit to add this property.

--
Regards,
Sudeep
