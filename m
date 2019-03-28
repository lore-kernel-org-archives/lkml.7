Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A525C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6734820823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553802059;
	bh=mGtVIpiPpXWSkH9224tKdkCk5t11v5GfpnqrdoBVCuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uYHyProamIBLmMwsfBWQJZD0f/1N9fD5UzJfBJIksok7yrg3JfpfFoOQFD8t0bT9X
	 BJytiqL9BdzMycABnA0WqIMKtZSImMoFuR+Tl+fjhmVBnT0gP9g0mDOpqHUoGNZctp
	 Vq9/sqCyCcionMYOUiESYdi9IpSuxBIwKOoM/7BA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfC1Tk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:40:57 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43691 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfC1Tk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:40:57 -0400
Received: by mail-ot1-f67.google.com with SMTP id u15so19467195otq.10;
        Thu, 28 Mar 2019 12:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UQaAA6AzrLefSCaq5tdDTasje0E6ZYjhkJmQgQtllxA=;
        b=mGhPeTiMdoetVE7/4EIuWeFSJRROxBien+IedP4M+jGgGNjhlaInzwQf9YI0rbz+wg
         M69Y5PmiaZKj6AZfGxEW2mpMTuqr0IJmyAUElxz9HHLv6zhelNmJEjuzio599tvo9IpL
         rgwEZmYFcdV35uJ9xQ4hMWUCNEOyKzM/Bbg8Ml/dMMYjk97eUwKCeN1dmM2yuNrOBZSg
         uE3GcWnUR2Gcqg1CWio2AvEPGndqNOxKepucV5WW4jgGC3PINEpXijhJggklB50Qvd1y
         z/4lX3G1Z9BoL5jvulYntM+6Edx5DAtwatvJ7BJl5ekeFwIecwUxxDCwq/LkjBoSWMFP
         UiWg==
X-Gm-Message-State: APjAAAUD84n/DWH3lH2B09Si7Pe9omPZIJ4q90DcG6oeNhU3O/O3mCol
        9KGUE0xMZad39RjSD6ECqg==
X-Google-Smtp-Source: APXvYqz/HY1elLxQ+3SRMiYSLKLkSGMB5sF5qg6TXjwmaT6aBowEwmJZPE3CYA7k38kodckEflcXwg==
X-Received: by 2002:a05:6830:1248:: with SMTP id s8mr31122499otp.234.1553802056621;
        Thu, 28 Mar 2019 12:40:56 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v19sm10226146otk.63.2019.03.28.12.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 12:40:55 -0700 (PDT)
Date:   Thu, 28 Mar 2019 14:40:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: property: Document that
 of_graph_get_endpoint_by_regs needs of_node_put
Message-ID: <20190328194055.GA13068@bogus>
References: <20190315092247.7286-1-maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315092247.7286-1-maxime.ripard@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 10:22:47AM +0100, Maxime Ripard wrote:
> The node returned by of_graph_get_endpoint_by_regs has a reference taken,
> and we need to put that reference back when done with the node.
> 
> However, the documentation for that node doesn't mention it, so let's make
> sure it does.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.

Rob
