Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148ACC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5C92086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CaFMd9XD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732568AbfHBFKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 01:10:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33101 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732271AbfHBFKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 01:10:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so316716pgn.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 22:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GbN+lyQRwWpMrjAi8gZfqiOdoS1ljZVdsyP197ujcJ8=;
        b=CaFMd9XDgrGq6GKFNCs7UtRYd500b5XGKxJVTb4lP31xTeB221PAKxwE5Rtw9+kf/F
         JqKSBJKeNQBFtXNo5hpTDJHZJ6+5pZXBwMVX1eDW6RT9gvRoFOlCq1ljkXAwZFN1Fap+
         yeAOjBs7P28616iB00784HbRgv2nAqloK9jBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GbN+lyQRwWpMrjAi8gZfqiOdoS1ljZVdsyP197ujcJ8=;
        b=PtAKQ1+qQ9q1JhYP6mm5uMhBhBQ9JlUaqUq4cHOq3HA+A5MgWkD/sBOpCOBpizps33
         py6347pNniQ5iLfrlYWu4f87gDXJ+jmqxFoxc/PR0JWmVlkhAsX3mcmDkTXv2fWR8NJ+
         GyQnS1tn0rVyuixsZ4hpvorClYgQY9ZLFsPlY3C1b0pbBQIQ4VWYY9sgZW5i58vtcDCy
         PRXdC0LjLuzSFQiA3h4fQxtFx4NPG54zcOSgRQ7VglvZdk59PbQQL3/o10RjMGPEhTdZ
         jTMY7VIV/aNH7tfYp/D8he4985S9cu0sjM+K0VEpEu4+E4KEeKBM8dcPOJGHwxSpVzzR
         OOEw==
X-Gm-Message-State: APjAAAXoKPKvJAGhtXiyIG64sEWciOVhUHSTBvbRxVCIh6Z1LL/3yXyF
        3OgM+8CFVSUO28VEUBHwdXLvMQ==
X-Google-Smtp-Source: APXvYqw6EY3sCwRr17Ar8Ens5WlgHGNu+SiJE6WNtnZfFauoEO0hqdBcN+DPrzLGoo3MwDmVHhsOBg==
X-Received: by 2002:a65:6281:: with SMTP id f1mr115552688pgv.400.1564722637707;
        Thu, 01 Aug 2019 22:10:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j6sm64733311pfa.141.2019.08.01.22.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2019 22:10:36 -0700 (PDT)
Date:   Thu, 1 Aug 2019 22:10:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Mark expected switch fall-through
Message-ID: <201908012210.15191EAD5@keescook>
References: <20190802012248.GA22622@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190802012248.GA22622@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 08:22:48PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning (Building: allmodconfig i386):
> 
> drivers/pci/hotplug/ibmphp_res.c: In function ‘update_bridge_ranges’:
> drivers/pci/hotplug/ibmphp_res.c:1943:16: warning: this statement may fall through [-Wimplicit-fallthrough=]
>        function = 0x8;
>        ~~~~~~~~~^~~~~
> drivers/pci/hotplug/ibmphp_res.c:1944:6: note: here
>       case PCI_HEADER_TYPE_MULTIBRIDGE:
>       ^~~~
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/pci/hotplug/ibmphp_res.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/hotplug/ibmphp_res.c b/drivers/pci/hotplug/ibmphp_res.c
> index 5e8caf7a4452..1e1ba66cfd1e 100644
> --- a/drivers/pci/hotplug/ibmphp_res.c
> +++ b/drivers/pci/hotplug/ibmphp_res.c
> @@ -1941,6 +1941,7 @@ static int __init update_bridge_ranges(struct bus_node **bus)
>  						break;
>  					case PCI_HEADER_TYPE_BRIDGE:
>  						function = 0x8;
> +						/* Fall through */
>  					case PCI_HEADER_TYPE_MULTIBRIDGE:
>  						/* We assume here that only 1 bus behind the bridge
>  						   TO DO: add functionality for several:
> -- 
> 2.22.0
> 

-- 
Kees Cook
