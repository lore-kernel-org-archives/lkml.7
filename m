Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935ADC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683D721841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560529844;
	bh=DFAi12S9oejFOfr4uJyKXfFcIyLycifb9VLgPkuO3AM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tBfwEubDW3CHlF/fIn8EDnYrcHFEKGXBlihtRTAUiIbD+fzydZxoB4DOWbNnp1iJR
	 ttLSp1GgOuvEtqtTG7T5WhSzaVis7d420gR1OzPuWMYJkTjp6gOR9dU5Z+j2XZ1uL4
	 Z2mJX05HTwrVYIkfUA+uHw9nI6b+ys2Y+0OY7nIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfFNQam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:30:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39636 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfFNQam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:30:42 -0400
Received: by mail-qt1-f193.google.com with SMTP id i34so3145702qta.6;
        Fri, 14 Jun 2019 09:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jMjniYLe1gr6/AMUsfiLEF+RmBgBhFISx6JTCsfFayw=;
        b=dylpHzVutdtvz80h4E1MALMrkF9zOCisPlXnDYM9KgCx7i+2LHdHkYBzgFgEJ8dGXF
         UAprhzVtH+tEIJKKWjuQUBEPBLWbjubMFjuWEnVEGzSfZcy5ywQol5zb/0PT/FA3/8nO
         BARpeRjPtzZYf6+9scil6YIUZDHH+ESX2MZSu6HCIWUMbn+fIPglWbXbRdMf+S2oDptM
         h18CtxctbbD74q7yImTnOpvHWJrDAWaJdgpcjHZy2ubt1TdU98VB7tnWCfrXj4/L/fF5
         cJztCXgvrqa8CfeMCzTTmKWlzSEaKllFz22lJmLIWRYnOX+wNPXqlHuf1LpByJSujK68
         n1Pw==
X-Gm-Message-State: APjAAAVyEsBKlw6ZuY9CTXrRtZsfo62mJSEbkVWMuPMSnOvd2TiripqO
        +j8rftSpTyBB9tz2Rfzjqhn5yt4jzg==
X-Google-Smtp-Source: APXvYqyq8hzzFgEGvYC87jNq+3O710Dm+93YPe7JOG/z4/1WC3Xyz09BCnowTVLy+F+fmhIrcXUSQg==
X-Received: by 2002:ac8:2ae8:: with SMTP id c37mr27905229qta.267.1560529840914;
        Fri, 14 Jun 2019 09:30:40 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id s23sm2624864qtj.56.2019.06.14.09.30.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 09:30:40 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:30:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@nxp.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/5] dt-bindings: switch Exynos EHCI/OHCI bindings to use
 array of generic PHYs
Message-ID: <20190614163039.GA24384@bogus>
References: <20190521115849.9882-1-m.szyprowski@samsung.com>
 <CGME20190521120107eucas1p1a56efaa0e7f2117063e70683276edc10@eucas1p1.samsung.com>
 <20190521115849.9882-2-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521115849.9882-2-m.szyprowski@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 01:58:45PM +0200, Marek Szyprowski wrote:
> Commit 69bec7259853 ("USB: core: let USB device know device node") added
> support for attaching devicetree node for USB devices. Those nodes are
> children of their USB host controller. However Exynos EHCI and OHCI
> driver bindings already define child-nodes for each physical root hub
> port and assigns respective PHY controller and parameters to them. This
> leads to the conflict. A workaround for it has been merged as commit
> 01d4071486fe ("usb: exynos: add workaround for the USB device bindings
> conflict"), but it disabled support for USB device binding for Exynos
> EHCI/OHCI controllers.
> 
> To resolve it properly, lets move PHYs from the sub-nodes to a standard
> array under the 'phys' property.
> 
> Suggested-by: Måns Rullgård <mans@mansr.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../devicetree/bindings/usb/exynos-usb.txt    | 41 +++++++------------
>  1 file changed, 14 insertions(+), 27 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

The old way would also conflict with the usb-connector binding as that 
uses the graph binding.

Rob
