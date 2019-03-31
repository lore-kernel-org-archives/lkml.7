Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF0BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF78B21873
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014526;
	bh=yTPXzK5I3OuzvNm6hwLnXwzf0NmWyStfw29DcG4q7OA=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=IHpde4SwRaKsOg8FLZIPvtU10Atkyi5xbEYTbPc6uaCZdNfdmDTqajfdB/abt5fXN
	 1uT6Di8+b6CFVSIMap+Yg1mJZPd951juHzbs1dVFoWYnaw0bGHMw5KEbG3SjAQNtnc
	 pMFOobRcG3KPivNCIbX9+Jy7shD7keszV/MTb3Pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbfCaGmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:42:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43005 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731316AbfCaGmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:42:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id cv12so2928937plb.9;
        Sat, 30 Mar 2019 23:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=d0TRJWFYZCcGJ670fuMsFp9fAbg2wXKPZfKVvMZxly8=;
        b=YE481mL7ZdtMsdSXuX0aRxi2whAAyKSAmH3sC2OcLzmLzjUCOZXl6ftXP8GFhKpUfH
         xztiN1oq6IjlHwbbShkJhQ5og/q6OgwOo0nsLBDVW7Fzu1T8GBHEt4qNoFZV3YwwyJsY
         fxC5o+6OzKqctoowcak+mD7AyMy5r66+udctQ+JXqYqMfporce33Rp6Q7/j9CeTdK7GY
         4RrxyvVIeZCn9P0YjKI+wRcN9INc7tovGWOjAncmLvOCeCPOHDCMBOx7t4RE7Pv67tUu
         K8mB8I3DMzGDPi6+0TK+4I+4B5Pma7+Aus9o8na5ipbvvY6gKoEuGUt6L6FjBLE8kzGs
         0hmQ==
X-Gm-Message-State: APjAAAVtZ7wHimXBeVjTwD3HKsax5euNXS5VpN+4/DFp6SpNZREuMn8b
        Tn/2bmH54nQOmC/fkbTduLckNDUZ8w==
X-Google-Smtp-Source: APXvYqzRiC3prxPzPM3O6FxW2EaC71bJfKusE3cQQ2cxyxZYGKFL3imDrezcr3XD+jUQ7m9RBExF5Q==
X-Received: by 2002:a17:902:3283:: with SMTP id z3mr57545248plb.236.1554014520974;
        Sat, 30 Mar 2019 23:42:00 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id o5sm15424069pgc.16.2019.03.30.23.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:42:00 -0700 (PDT)
Message-ID: <5ca06138.1c69fb81.68bd3.106e@mx.google.com>
Date:   Sun, 31 Mar 2019 01:41:58 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 02/14] bus: ti-sysc: Handle missed no-idle property in addition to no-idle-on-init
References: <20190325215849.13182-1-tony@atomide.com> <20190325215849.13182-3-tony@atomide.com>
In-Reply-To: <20190325215849.13182-3-tony@atomide.com>
Cc:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
To:     Tony Lindgren <tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 14:58:37 -0700, Tony Lindgren wrote:
> We have ti,no-idle in use in addition to ti,no-idle-on-init but we're
> missing handling for it in the ti-sysc interconnect target module driver.
> 
> Let's also group the idle defines together and update the binding
> documentation for it.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  Documentation/devicetree/bindings/bus/ti-sysc.txt | 2 ++
>  arch/arm/mach-omap2/omap_hwmod.c                  | 2 ++
>  drivers/bus/ti-sysc.c                             | 5 ++++-
>  include/linux/platform_data/ti-sysc.h             | 5 +++--
>  4 files changed, 11 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

