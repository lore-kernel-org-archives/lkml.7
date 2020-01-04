Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0DFC32767
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7E724649
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578096602;
	bh=d9NUujIqWfkarIJ1UVYE4+Ixa0Pe1GIKYKYTdt/XZ6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NC0Px20mhej99O0rln02ZuEqqDyHeFezZ8OBGBav3bDZC4xE1ZYKIvzWDns9GmbTM
	 siHW6SvUZpe8/jq84mjAbcWo23TzQTg2w8ZBwvycH9NFNr5yLAhCOl+7X+8PSIQuhk
	 PlsbJ7NmeI7PWDOIZMjPwUqhmFaNjxv+vgLciDnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgADAKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:10:02 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37639 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgADAKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:10:01 -0500
Received: by mail-io1-f67.google.com with SMTP id k24so12746544ioc.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XfXHkBnCjci39X5Yh6SUYp5n6eoGbtDoP20HblyPxEY=;
        b=f5P3xoMKgtNOXxmTs3yewSbbZG4GPdOn8dA+hXYmgKTEsu/TCMKg/EaqiFvgDehZb0
         Yq1rHnTwOoQRYw5N0eKFXMUlr+JqaeIKhSjfg+oZNjp8r7ZYvUvIJSNXwg99WUjDQvrE
         RkqxMMEB6vixUsldgtSQRqNC850SlvnUaDfEPu2jUJYMvderTvlaOYHLj7ru5j0mLQYL
         xzi7iZARgUbfzFtkyA9cvkTGSwrAjUFnrxQRG9G2Cf/3wapT2XYmlN/DhWv0gRKJkpQY
         jq2URgt5yy5psSs8mTvLtCYSZtt5fbrZmA4GUGZ0joM0fQp/pLshSG8AiiOReoQhCezk
         wFZA==
X-Gm-Message-State: APjAAAXCqclg0VcHRoo4gn7u659J+BunTunumqxB4QctQFY/G0poissU
        Frrt8FKOc+xKHO7SkWqP17WmlPE=
X-Google-Smtp-Source: APXvYqxNUSb3GtO60GFFhJefsj2x9rjKp892sK/toEgo9bhldYzs673cDe2Ij1jqfCw6SSqAf9O3TA==
X-Received: by 2002:a05:6602:101:: with SMTP id s1mr60384300iot.262.1578096599266;
        Fri, 03 Jan 2020 16:09:59 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t15sm21482731ili.50.2020.01.03.16.09.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:09:58 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a5
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 17:09:57 -0700
Date:   Fri, 3 Jan 2020 17:09:57 -0700
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: display: Add Satoz panel
Message-ID: <20200104000957.GA17750@bogus>
References: <20191224141905.22780-1-miquel.raynal@bootlin.com>
 <20191224141905.22780-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224141905.22780-2-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 03:19:04PM +0100, Miquel Raynal wrote:
> Satoz is a Chinese TFT manufacturer.
> Website: http://www.sat-sz.com/English/index.html
> 
> Add (simple) bindings for its SAT050AT40H12R2 5.0 inch LCD panel.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> 
> Changes since v2:
> * None.
> 
> Changes since v1:
> * New patch
> 
>  .../display/panel/satoz,sat050at40h12r2.yaml  | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/satoz,sat050at40h12r2.yaml

Note that this may become obsolete if we move all simple panels to a 
single schema.

> 
> diff --git a/Documentation/devicetree/bindings/display/panel/satoz,sat050at40h12r2.yaml b/Documentation/devicetree/bindings/display/panel/satoz,sat050at40h12r2.yaml
> new file mode 100644
> index 000000000000..567b32a544f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/satoz,sat050at40h12r2.yaml
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/satoz,sat050at40h12r2#

Missing '.yaml'

Run 'make dt_binding_check' which will check this and other things.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Satoz SAT050AT40H12R2 panel
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +
> +description: |+
> +  LCD 5.0 inch 800x480 RGB panel.

Any public spec for this panel?

> +
> +  This binding is compatible with the simple-panel binding, which is specified
> +  in simple-panel.txt in this directory.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    contains:

Drop 'contains'. It must be exactly the below string, not the below 
string and *any* other strings.

> +      const: satoz,sat050at40h12r2
> +
> +required:
> +  - compatible
> -- 
> 2.20.1
> 
