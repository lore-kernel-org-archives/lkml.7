Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE325C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A6621721
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="mSPg9yAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfGCCE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:04:26 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:32829 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfGCCE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:04:26 -0400
Received: by mail-qt1-f174.google.com with SMTP id h24so895406qto.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 19:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=D+csHyoXmCSfo36FjRvnFg+jSmMkHBvbr36bQgH7vNk=;
        b=mSPg9yAuCQf0++B9j2eL4h8AxelwNz6s8rBhCtOzR9ETFAzSzwNRwYxfefPE70gqzz
         klH0aVmx7Jo6j39VTbd7/EzqoGJLfp8wdsYfnl3XufZtCPF2MHesQ1i13AK0GbD5eVYH
         2Z7c8hFaBl47V0UVztztD42Y/1BMFlQ9VPhnhZJvggSf6xP9b1N1TnOHITpNOg4ffc8b
         lxumVSZgbKRhzeU68dP8Lz3vDB9TPvgN48fcHHUx4RZKIKMp5610/N3hMavuxlCAb2CV
         G0gQkwMjYFYqfel79Qw2ld0wS43k0OOfpAfMSd6UBif906QBiHGjgEDQA8uFEouzjN9e
         fczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=D+csHyoXmCSfo36FjRvnFg+jSmMkHBvbr36bQgH7vNk=;
        b=BU1r8Ub11j6l7NLNvzmmGR1Y3YDT02wgLkKDN+rNlg53D/mAQhw5QaG465Um/eheZ/
         E4Vx47T5/qymW7E1AhggdVu+U0w5HzncN9m8UiyNAAz4avW7koe71EODZxnnNst8vmqR
         ZrBts2i3upIDCV6I2OC5uieWeyNuGtbyZ1Mn8ChMzkXc6LP9DIbA9M+7n1MSFxOu4BBu
         dRRFE9TZeGPFrYiPIRgz6yAUnQITwLYx2x/py2KB3xSCtMRnseH1R9Kz3tnXdJQ+yFYv
         U9RVVyU7D9TmS8j77wL4z9gN+i6F/Ge256w3r5OpCVieipO5wrF8A7ZY9dhLO5xvzOfi
         Rt6w==
X-Gm-Message-State: APjAAAUXfU2ObTOdFgYS45/RfxLpPJimSPVPdslkBecdUFBcj8W9Ge6n
        aJIrI5tROGxDfY4mdvasc7fP3g==
X-Google-Smtp-Source: APXvYqyNNXeWcpsv07GuG3AuJ6PH8AJPyEjMJU4wwj+LUGZw2xzKqfxmBouRwJ788Gpa2tYTsHOj3g==
X-Received: by 2002:a0c:baa8:: with SMTP id x40mr30028502qvf.168.1562119465176;
        Tue, 02 Jul 2019 19:04:25 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id t2sm433654qth.33.2019.07.02.19.04.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 19:04:25 -0700 (PDT)
Date:   Tue, 2 Jul 2019 19:04:19 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 11/15] ethtool: provide link mode names as a
 string set
Message-ID: <20190702190419.1cb8a189@cakuba.netronome.com>
In-Reply-To: <1e1bf53de26780ecc0e448aa07dc429ef590798a.1562067622.git.mkubecek@suse.cz>
References: <cover.1562067622.git.mkubecek@suse.cz>
        <1e1bf53de26780ecc0e448aa07dc429ef590798a.1562067622.git.mkubecek@suse.cz>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Jul 2019 13:50:34 +0200 (CEST), Michal Kubecek wrote:
> +const char *const link_mode_names[] = {
> +	__DEFINE_LINK_MODE_NAME(10, T, Half),
> +	__DEFINE_LINK_MODE_NAME(10, T, Full),
> +	__DEFINE_LINK_MODE_NAME(100, T, Half),
> +	__DEFINE_LINK_MODE_NAME(100, T, Full),
> +	__DEFINE_LINK_MODE_NAME(1000, T, Half),
> +	__DEFINE_LINK_MODE_NAME(1000, T, Full),
> +	__DEFINE_SPECIAL_MODE_NAME(Autoneg, "Autoneg"),
> +	__DEFINE_SPECIAL_MODE_NAME(TP, "TP"),
> +	__DEFINE_SPECIAL_MODE_NAME(AUI, "AUI"),
> +	__DEFINE_SPECIAL_MODE_NAME(MII, "MII"),
> +	__DEFINE_SPECIAL_MODE_NAME(FIBRE, "FIBRE"),
> +	__DEFINE_SPECIAL_MODE_NAME(BNC, "BNC"),

> +	__DEFINE_LINK_MODE_NAME(10000, T, Full),
> +	__DEFINE_SPECIAL_MODE_NAME(Pause, "Pause"),
> +	__DEFINE_SPECIAL_MODE_NAME(Asym_Pause, "Asym_Pause"),
> +	__DEFINE_LINK_MODE_NAME(2500, X, Full),
> +	__DEFINE_SPECIAL_MODE_NAME(Backplane, "Backplane"),
> +	__DEFINE_LINK_MODE_NAME(1000, KX, Full),
...
> +	__DEFINE_LINK_MODE_NAME(5000, T, Full),
> +	__DEFINE_SPECIAL_MODE_NAME(FEC_NONE, "None"),
> +	__DEFINE_SPECIAL_MODE_NAME(FEC_RS, "RS"),
> +	__DEFINE_SPECIAL_MODE_NAME(FEC_BASER, "BASER"),

Why are port types and FEC params among link mode strings?

> +	__DEFINE_LINK_MODE_NAME(50000, KR, Full),
...
> +	__DEFINE_LINK_MODE_NAME(1000, T1, Full),
> +};
