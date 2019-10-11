Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14211ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21B52089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570805296;
	bh=VZguEQJnMJllBHyICpMc6lELM9gKnqPlcl1g3payhJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mGq2QGYMWI47Bca/OnYV92PS5vCYIUbCO3b1Lto7jOILNoYpzzglY0VFBnHmd2Gix
	 36AS3kcS+RALUi/Xm8fnVJM/awpG33JbtdfOdzmLSdvVePk1EXadcQ126n8KYK+lfJ
	 to8Xj7Cn3pEi2dY1EYjxrHWlCvEr+Tx9NIrudBB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfJKOsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:48:16 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37773 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfJKOsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:48:15 -0400
Received: by mail-ot1-f66.google.com with SMTP id k32so8181656otc.4;
        Fri, 11 Oct 2019 07:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9kELu6s8Xez72s7yjDEZd7hwsCCJDY4gV2VlEWP54QM=;
        b=A1Omp0uwnI0AOwdEtOWKSx2b/m3irUctzOB+KNmI+BpLLDwsjBsXAAoO10lEF3RoeI
         K1fWe0+CR7cCbhU+W9B38osApHFaPxAn2QM0PgbYmCB9Nz+Yxm4Scot09XlhC07B1esF
         yxa6HcvvjJQNNhAjpYok7vnhHs0f4MqlEe/HS9MlC/bb/gj8qos40j80z5Wrd2zg2brz
         ZlNbynBuZWvCHQ2ngWqTp3XLeLwSPLFin3MyLbuN8uaBKJ5iqbW1N9c2z9gFb+Dwd9Gh
         1toC+3VGRw3PDpCV1QfPKDWyV0UZfLvdfFAO8rSR1A1oP5OSJZqu/hG9OuvnZ1HlAHvm
         Xgig==
X-Gm-Message-State: APjAAAVtup4jNyNKXEPgpTB8/EwfD3+xmianbBDKblgs0I/zAJ6S3dAs
        YhOWzZ53pd12YJG6xmnwQw==
X-Google-Smtp-Source: APXvYqxWiF9mlWpmhF4F7i28hJLZ1dDoTA6YcBMy+P+DctntpvAmW5FA4W9ZKMX5tPkbxHvi4IwDcw==
X-Received: by 2002:a9d:6084:: with SMTP id m4mr11834429otj.18.1570805293419;
        Fri, 11 Oct 2019 07:48:13 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o184sm2694641oia.28.2019.10.11.07.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:48:12 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:48:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jamie Lentin <jm@lentin.co.uk>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: power: reset: gpio-poweroff: Add
 'force-mode' property
Message-ID: <20191011144812.GA7239@bogus>
References: <20190930141244.12311-1-oleksandr.suvorov@toradex.com>
 <20190930141244.12311-3-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930141244.12311-3-oleksandr.suvorov@toradex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 02:12:53PM +0000, Oleksandr Suvorov wrote:
> Add 'force-mode' property to allow the driver to load even if
> someone has registered the pm_power_off hook earlier.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> 
> ---
> 
> Changes in v2: None
> 
>  .../devicetree/bindings/power/reset/gpio-poweroff.txt          | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
> index 3e56c1b34a4c..2056e299a472 100644
> --- a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
> +++ b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
> @@ -31,6 +31,9 @@ Optional properties:
>  - inactive-delay-ms: Delay (default 100) to wait after driving gpio inactive
>  - timeout-ms: Time to wait before asserting a WARN_ON(1). If nothing is
>                specified, 3000 ms is used.
> +- force-mode: Force replacing pm_power_off kernel hook.
> +  If this optional property is not specified, the driver will fail to
> +  load if someone has registered the pm_power_off hook earlier.

What if the init order changes?

This is too tied to a specific OS implementation to go in DT.

Rob
