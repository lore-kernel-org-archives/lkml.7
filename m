Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2EAC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F30B2186D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574098642;
	bh=1wAh9kbqMjOdhPxSQ0/fkWzL0uQxM7MRFbTp2hqnQWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wn/dy3LeT28YFRHbUY9/iX8JHl7PwfYYOc7f0F1kPoQDNOmAIWdqoryL+iBLHAQ8R
	 pCdzrnQBOagRr0Jmqurt+shPGDwO0gPsqcPfHeSObPnLCskpg+3l/Yt24poDG0ucX1
	 NFgiEVlV0rRh9/5MPw2NGocna73SVgIfrV2MqIvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKRRhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:37:21 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43885 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKRRhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:37:21 -0500
Received: by mail-oi1-f193.google.com with SMTP id l20so16050844oie.10;
        Mon, 18 Nov 2019 09:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7HpWwOCq3UdIb5uimd0JWpieddKu80NlKxRl7WWt83U=;
        b=N+aFSywB9xZbB4PjjiBsu7YH4hNEhycs2RvMabypIORiA8znAnwPFIZ8jb77ZF1/By
         tLMd4PHgSfhmSIz2gduEtuMAM76ajSHcJCccOdQN0Q5JumjPVjlobe8Y+ahL4ju4vg12
         LLJYSXK++XhieyfOQ8E1XWhvvkzsLSy8STGxsnjM24ZpkbMAALbL1IDhGOmtuQ3qQ3fa
         zD1CISsgdUWDh+D3bRe232RLnun7p+bflDNlTR1Og+FzuhmYQYZsG2xMvwQkZO/oLWK2
         D7HhLqxqENHjamH36NAMTx8sHxlroIhtmqOgUJ6jb7lxiSmlUQoAE/sDboVUUu6e915q
         OZ/Q==
X-Gm-Message-State: APjAAAWl+vESutW61MtlipZh6x75Z7QO8d1PuRJ+fdDecfUAedVzJqQX
        NMWU32ulhMtB7hkqHpL8sw==
X-Google-Smtp-Source: APXvYqyM7rx557IcbgsK98dh+RZAHj+ExW+QfMyvmSTGA9rZh5JbIiE2mELex8cLotexulqUiN28Lw==
X-Received: by 2002:a05:6808:48:: with SMTP id v8mr83549oic.71.1574098639960;
        Mon, 18 Nov 2019 09:37:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t10sm3696220otc.65.2019.11.18.09.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 09:37:19 -0800 (PST)
Date:   Mon, 18 Nov 2019 11:37:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benoit Parrot <bparrot@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benoit Parrot <bparrot@ti.com>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [Patch v4 1/3] clk: ti: dra7: add vpe clkctrl data
Message-ID: <20191118173718.GA2603@bogus>
References: <20191112142657.22898-1-bparrot@ti.com>
 <20191112142657.22898-2-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112142657.22898-2-bparrot@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019 08:26:55 -0600, Benoit Parrot wrote:
> Add clkctrl data for VPE.
> 
> Signed-off-by: Benoit Parrot <bparrot@ti.com>
> ---
>  drivers/clk/ti/clk-7xx.c         |  6 ++++++
>  include/dt-bindings/clock/dra7.h | 10 ++++++++++
>  2 files changed, 16 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
