Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F41C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 19:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CB2279D1
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 19:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew4O9sKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfFBTxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 15:53:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33080 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfFBTxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 15:53:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id x10so4178977pfi.0;
        Sun, 02 Jun 2019 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RPszV/GKdwFy3mToL64pjta7lqB42YXt0SDnW+O4P0I=;
        b=Ew4O9sKoQaTPwiF/R/eQXH6GMlsgnnt4ZNJ/MmiS7KBX3ym3cm27SsvW7XjjIeB9Yc
         0uMktAJ6HrvekuSlZtisPtAjoCy68VCcW9MPRz1wM/Ci8pPGscDmwiB1ORAjw7rVa44T
         0BJMWcyGhjQSJN51Vx6MXc/XmMlrgZok0/Nps0Oz5HTw6ubW3vfZhAKiJf5gqUO4dn2o
         grlanotuetC+dpmWAUGrLFvQ7dZg1XQvwSK4M7tVEdXTpy0KaM9aAEpTQ7BgdwDjC2Ao
         0xyIxiOdoGK7peexYq63xTWTVEPuUFXa7iKCO9DXRe809lj2a19yOlT2dWC3E5DPg/F7
         Mjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RPszV/GKdwFy3mToL64pjta7lqB42YXt0SDnW+O4P0I=;
        b=D375DnYleTeYKlICRRgO4RPzKx/5rn9l3HlGrQSOVxEtLXuC8T+3Q1VOcHDy40bRY0
         YCcwdrv65779o6L7NJa1iRkqGqAb2W67K8oMvh4zAB13bCgiRV5/lB1SXyZFl7Fz5g6k
         JD7RurpffEj51JnJGW4v01nZr2A8nFlMblhUYzp6B6k8hJrJdMhE8c7Vq+//+GEGxvJu
         zX0VAuRHudE69dIJWy1LsOld0KlpOp+UCVFXF239hrBU4nXLi0P4r4FVtY1+1px+QZWP
         1f8iDE+mO/sjImoxfF7E0bVu+sbOX8zkusZ8vtZVRQP/7UW4nTKmLKvYug59UVQEPNIG
         I25w==
X-Gm-Message-State: APjAAAXvNVTjjK5MlEuQ6C42Tk9HWcV8K6B/P0KUM0Jrpy7DYZgq5VZ+
        XbWPwkZo0J3Qq3mhp0XpKs0=
X-Google-Smtp-Source: APXvYqzSWUgdIEWMG2M0m+OQFYlgX3Aiq3bDcApAnCPJVe3ZGLRAXyfXsrtcH75MImXnQqXeXPD5CQ==
X-Received: by 2002:a17:90a:cb84:: with SMTP id a4mr25028599pju.104.1559505175910;
        Sun, 02 Jun 2019 12:52:55 -0700 (PDT)
Received: from localhost (c-73-222-71-142.hsd1.ca.comcast.net. [73.222.71.142])
        by smtp.gmail.com with ESMTPSA id a16sm7548493pfc.167.2019.06.02.12.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Jun 2019 12:52:54 -0700 (PDT)
Date:   Sun, 2 Jun 2019 12:52:49 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Wingman Kwok <w-kwok2@ti.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 00/10] net: ethernet: ti: netcp: update and
 enable cpts support
Message-ID: <20190602195129.hjx5qyzqxyirdkx7@localhost>
References: <20190601104534.25790-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190601104534.25790-1-grygorii.strashko@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 01, 2019 at 01:45:24PM +0300, Grygorii Strashko wrote:
> The Keystone 2 66AK2HK/E/L 1G Ethernet Switch Subsystems contains The
> Common Platform Time Sync (CPTS) module which is in general compatible with
> CPTS module found on TI AM3/4/5 SoCs. So, the basic support for
> Keystone 2 CPTS is available by default, but not documented and has never been
> enabled inconfig files.
> 
> The Keystone 2 CPTS module supports also some additional features like time
> sync reference (RFTCLK) clock selection through CPTS_RFTCLK_SEL register
> (offset: x08) in CPTS module, which can modelled as multiplexer clock
> (this was discussed some time ago [1]).
> 
> This series adds missed binding documentation for Keystone 2 66AK2HK/E/L
> CPTS module and enables CPTS for TI Keystone 2 66AK2HK/E/L SoCs with possiblity
> to select CPTS reference clock.

For the series:

Acked-by: Richard Cochran <richardcochran@gmail.com>
