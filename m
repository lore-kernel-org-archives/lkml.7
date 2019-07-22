Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68675C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3825F21901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817737;
	bh=IFPxTgv+/38iCLXEQkCFgDfc3sGgooEMWOxpK/+OA+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RDtXXo6ThkDOZzb47lZaqoLycxnplhIEKQoUm4Rixtck5mdhio40RcpzlQ8zTKH4e
	 jA27JWnYdG/Yrb59Wb01Zpujs/FiCGSuf/dZjjdGETsUU8568QpldP+nyUs4ZXPniT
	 eQCuIsr46wTc/Z0czphAJZMJckdhCB2HB3/+FrzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfGVRs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:48:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46603 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfGVRsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:48:55 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so75768956iol.13;
        Mon, 22 Jul 2019 10:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CxrJ1h1Gj9qffdtw6gn6IuFX9kNT09jtgH+ckcJPTWk=;
        b=CMvB803DUZ1IsKkDomdkjDfaomZ9p/zcCcdDhde2i62lFZ2wOaFo3u+jKPdWd5L9RV
         I3i/gpUmVdOWno601py0CS9BzU9/iEctSNQCabBCvQN8EaZ2zzXG8socZDXqQz9lCJ2C
         /WN2BamGmGw/fwFPljFSaAoLUcGOjNoZsB5BQclura6rRfkA3Pe5NLlmW3YHFpTpEDzE
         dfbDmFiJKRAWhv2W3MIemXsqofWWAHiD4lBJ5CXvD+KC+OLSa58dIUU2o0eoHk8QTX2D
         TRRzPpsfmDCvNwxo5vUN0GmbIs+Pi2brPGEdpxBcGQx47o76dTt3Y64xrTh1lKIphq6M
         Pyfg==
X-Gm-Message-State: APjAAAVT1CznYUZUUaTfl5TkgeBEwbOLERpj2NhBYV8NYTzAlpfEv3lX
        cT2ByzxoWRGqDi0vhpgKiA==
X-Google-Smtp-Source: APXvYqw0FDve9Mw/vkxriVI+KvJ+PlrXuiZ8o2qd7ioxmjQY7NUFYzDL8hVPS4tO0BHR0p8241W5WA==
X-Received: by 2002:a02:90c8:: with SMTP id c8mr75947688jag.22.1563817734501;
        Mon, 22 Jul 2019 10:48:54 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id c81sm62071726iof.28.2019.07.22.10.48.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 10:48:54 -0700 (PDT)
Date:   Mon, 22 Jul 2019 11:48:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] dt-bindings: display: Add max-res property for
 mxsfb
Message-ID: <20190722174853.GA31795@bogus>
References: <1561555938-21595-1-git-send-email-robert.chiras@nxp.com>
 <1561555938-21595-6-git-send-email-robert.chiras@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561555938-21595-6-git-send-email-robert.chiras@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 04:32:13PM +0300, Robert Chiras wrote:
> Add new optional property 'max-res', to limit the maximum supported
> resolution by the MXSFB_DRM driver.

Bindings are for h/w description, not driver config.

> 
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> ---
>  Documentation/devicetree/bindings/display/mxsfb.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mxsfb.txt b/Documentation/devicetree/bindings/display/mxsfb.txt
> index 472e1ea..55e22ed 100644
> --- a/Documentation/devicetree/bindings/display/mxsfb.txt
> +++ b/Documentation/devicetree/bindings/display/mxsfb.txt
> @@ -17,6 +17,12 @@ Required properties:
>  Required sub-nodes:
>    - port: The connection to an encoder chip.
>  
> +Optional properties:
> +- max-res:	an array with a maximum of two integers, representing the
> +		maximum supported resolution, in the form of
> +		<maxX>, <maxY>; if one of the item is <0>, the default
> +		driver-defined maximum resolution for that axis is used

I suppose what you are after is bandwidth limits? IIRC, there's already 
some bindings expressing such limits. Also, wouldn't you need to account 
for bpp and using the 2nd plane (IIRC that there is one).

Rob
