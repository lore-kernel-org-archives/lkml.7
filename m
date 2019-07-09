Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B5AC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACCF21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562683772;
	bh=vusmqCVy076A9p8TRL+M4eBN5aaT973IjTGR2Wakv8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VFxk0kVfqvFHC9VDXCtEqsKpC+2eOGgjWXhjimIYhAPouYdQFtoeJ1x1epuUpJCDH
	 l5rbBqyldSieWCT9X1aUT+p1/FIIUq7VOigDF97O6FY/sMEkX2qo54x8c07d/bRbCK
	 R28gqMBePKXPK6fd1WRLHssvrmk7glkRJ2nzxXuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfGIOtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:49:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40699 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGIOta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:49:30 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so35503946iom.7;
        Tue, 09 Jul 2019 07:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NBos5KwAP2Y9O9kzC0Y3x26RLLeEVK2uJfPnwG/7Y9E=;
        b=StmxYwMhjDc21JIH84KPdGAgbrz8sQhr+H3pw4QMo9taA6Rn7AbhNstZGMqg2wJJVk
         Qcz2c+jicVLkhJMEAjraMuei182dGWB5Sv9BKk4vCO4xBOGRghuz3kutTsJJq2UT+y26
         7gjbaPwqLIiQK9nyOaD9/gLV6iz+9Vaz4doUPOFhA7ublQcIuAgOf01sluHdZeHAZT6l
         V4PPXqCRvf0e+zVWDFBSym5QhorT06TT7Y4BT7B5f2ZWLE+i68G6W/FkPHvEoJVb+4z5
         Tr1DB1J4DD93M4YWt9Tw6CIyyOD+ft3bJs214bGIQ4Nl7O1h9cOve+s0rD4P3KR2syI/
         0mGA==
X-Gm-Message-State: APjAAAVWc3Q+nHhoe9IjWcwwB3hHlQ3YuxmjoAJFZTiV4YS1Pt5YtoMe
        HA6UScobcPYpaHYS79Ml7A==
X-Google-Smtp-Source: APXvYqyE5RmuWhStelgqyIGOf6PvzmyOg1Fsspjxojnp3v8t3CgCwImQuOBGdwN4EusPvXDRomJhDg==
X-Received: by 2002:a02:230a:: with SMTP id u10mr28541580jau.117.1562683769810;
        Tue, 09 Jul 2019 07:49:29 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id s2sm15034890ioj.8.2019.07.09.07.49.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 07:49:29 -0700 (PDT)
Date:   Tue, 9 Jul 2019 08:49:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: display: Add TCON LCD compatible for
 R40
Message-ID: <20190709144928.GA31407@bogus>
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
 <20190614164324.9427-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614164324.9427-2-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2019 22:13:16 +0530, Jagan Teki wrote:
> Like TCON TV0, TV1 allwinner R40 has TCON LCD0, LCD1 which
> are managed via TCON TOP.
> 
> Add tcon lcd compatible R40, the same compatible can handle
> TCON LCD0, LCD1.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
