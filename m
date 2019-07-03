Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C91C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2514321873
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="MAVNS178"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfGCCLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:11:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44987 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCCLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:11:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id x47so820565qtk.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 19:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=gfRLnUMpvQF4xvVuNB3lMwbLOVw0h67iy3HrcU5WJts=;
        b=MAVNS178nXOTz84cbWexGGY36D6edM48ZYHVkM5Fv3RtGqu1rPZCT3aHPSg/8crhjS
         YwCStc+teSy9pCCUHViHJJIscKNVQYsvLx2QGSuKDZe8D2Y6qb9lblPS0w13sme2qsxh
         A9bxfFmXVxST14WM8URw4bSaFqxV8lluc+DloTml/EZhVQQ0ELA5R4YB3py91lNs42Pd
         U0FkylavJaiQ5U2erVzCNCRVpBaR22SsbfZtIK0SId0V79dBxO3V43XcNS77EOU1i3gg
         iGw53ybfWG5bj57oWAFrEvqHWzwb+7bkyfDHnMQ19+/9L7T58uNX/v2Rf8IqqHGO+lhg
         mreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=gfRLnUMpvQF4xvVuNB3lMwbLOVw0h67iy3HrcU5WJts=;
        b=HAHNWaYWsYSLC3BJyV2KqJ0xU64u+lVPu+aHmI78WwtyxwV3328f8TyfF7u14o2AfU
         jn/Eix33+tNXdoJ1ziAJq6SlGUJQJE8yCwXnZYJPb6WGDnRJyCpjQtfP157Npk1E4gf4
         4KYYWzlsjaa6tosuoA5jlsap+qESyW8bAo5oXb+pIk8hnj2f84jiTOAY/Lp0j0/Nebu1
         eb3uIBcOaDDY5Y6TmRKs2QW+EnkqTAaGu3axlBIzDHrIqv97xvmOA3cNI5ewnBTBZssT
         AoIp9pknsa0Jk0EUEH6ymBdRZpDVgWgcnojoabAH2apOuFeqKVcnYiYq1NrdUddeRm01
         jz2g==
X-Gm-Message-State: APjAAAVRz6ZONEcZl3SRbQIrQ/FJGUuOXXwjPfLCroCg9TcYaf+7br11
        DcJDKl/88oR7OHkIrLM+hqhFaQ==
X-Google-Smtp-Source: APXvYqw1ToIbfnaYWP+zvspA2rUdGgQ6c/tdGz1YfhNGkfO1j/K5mz5MtxUqvUNCgB605r6Ug8HZmQ==
X-Received: by 2002:ac8:2c35:: with SMTP id d50mr27032789qta.313.1562119889240;
        Tue, 02 Jul 2019 19:11:29 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id z50sm390789qtz.36.2019.07.02.19.11.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 19:11:29 -0700 (PDT)
Date:   Tue, 2 Jul 2019 19:11:24 -0700
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
Message-ID: <20190702191124.259c6628@cakuba.netronome.com>
In-Reply-To: <20190702190419.1cb8a189@cakuba.netronome.com>
References: <cover.1562067622.git.mkubecek@suse.cz>
        <1e1bf53de26780ecc0e448aa07dc429ef590798a.1562067622.git.mkubecek@suse.cz>
        <20190702190419.1cb8a189@cakuba.netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2019 19:04:19 -0700, Jakub Kicinski wrote:
> On Tue,  2 Jul 2019 13:50:34 +0200 (CEST), Michal Kubecek wrote:
> > +const char *const link_mode_names[] = {
> > +	__DEFINE_LINK_MODE_NAME(10, T, Half),
> > +	__DEFINE_LINK_MODE_NAME(10, T, Full),
> > +	__DEFINE_LINK_MODE_NAME(100, T, Half),
> > +	__DEFINE_LINK_MODE_NAME(100, T, Full),
> > +	__DEFINE_LINK_MODE_NAME(1000, T, Half),
> > +	__DEFINE_LINK_MODE_NAME(1000, T, Full),
> > +	__DEFINE_SPECIAL_MODE_NAME(Autoneg, "Autoneg"),
> > +	__DEFINE_SPECIAL_MODE_NAME(TP, "TP"),
> > +	__DEFINE_SPECIAL_MODE_NAME(AUI, "AUI"),
> > +	__DEFINE_SPECIAL_MODE_NAME(MII, "MII"),
> > +	__DEFINE_SPECIAL_MODE_NAME(FIBRE, "FIBRE"),
> > +	__DEFINE_SPECIAL_MODE_NAME(BNC, "BNC"),  
> 
> > +	__DEFINE_LINK_MODE_NAME(10000, T, Full),
> > +	__DEFINE_SPECIAL_MODE_NAME(Pause, "Pause"),
> > +	__DEFINE_SPECIAL_MODE_NAME(Asym_Pause, "Asym_Pause"),
> > +	__DEFINE_LINK_MODE_NAME(2500, X, Full),
> > +	__DEFINE_SPECIAL_MODE_NAME(Backplane, "Backplane"),
> > +	__DEFINE_LINK_MODE_NAME(1000, KX, Full),  
> ...
> > +	__DEFINE_LINK_MODE_NAME(5000, T, Full),
> > +	__DEFINE_SPECIAL_MODE_NAME(FEC_NONE, "None"),
> > +	__DEFINE_SPECIAL_MODE_NAME(FEC_RS, "RS"),
> > +	__DEFINE_SPECIAL_MODE_NAME(FEC_BASER, "BASER"),  
> 
> Why are port types and FEC params among link mode strings?

Ah, FEC for autoneg, but port type?

> > +	__DEFINE_LINK_MODE_NAME(50000, KR, Full),  
> ...
> > +	__DEFINE_LINK_MODE_NAME(1000, T1, Full),
> > +};  

