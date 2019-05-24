Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71802C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDAB21880
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389316AbfEXPBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:01:40 -0400
Received: from foss.arm.com ([217.140.101.70]:44812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389057AbfEXPBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:01:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D812980D;
        Fri, 24 May 2019 08:01:39 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D2813F575;
        Fri, 24 May 2019 08:01:38 -0700 (PDT)
Date:   Fri, 24 May 2019 16:01:35 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v1 3/5] dt-bindings: Add depends-on property
Message-ID: <20190524150135.GD15566@lakrids.cambridge.arm.com>
References: <20190524010117.225219-1-saravanak@google.com>
 <20190524010117.225219-4-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524010117.225219-4-saravanak@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 06:01:14PM -0700, Saravana Kannan wrote:
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
> +dependencies with well defined devicetree bindings. 

For clocks, regualtors, and pinctrl, that dependency is already implicit
in the consumer node's properties. We should be able to derive those
dependencies within the kernel.

Can you give an example of where a dependency is not implicit in an
existing binding?

> Also, not all functional
> +dependencies are mandatory as the device might be able to operate in a limited
> +mode without some of the dependencies.

Whether something is a mandatory dependency will depend on the driver
and dynamic runtime details more than it will depend on the hardware.

For example, assume I have an IP block that functions as both a
clocksource and a watchdog that can reset the system, with those two
functions derived from separate input clocks.

I could use the device as just a clocksource, or as just a watchdog, and
neither feature in isolation is necessarily mandatory for the device to
be somewhat useful to the OS.

We need better ways of dynamically providing and managing this
information. For example, if a driver could register its dynamic
dependencies at probe (or some new pre-probe callback), we'd be able to
notify it immediately when its dependencies are available.

Thanks,
Mark.
