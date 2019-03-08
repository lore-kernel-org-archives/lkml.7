Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB9BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA9620661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBLbb4dn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfCHNwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:52:41 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37555 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCHNwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:52:41 -0500
Received: by mail-qt1-f194.google.com with SMTP id a48so21223441qtb.4;
        Fri, 08 Mar 2019 05:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tu8wgpIPngRqfRuzvINFm6+PnEeffLSirIDj1tdDwHo=;
        b=bBLbb4dnfPnSaMaYgV2X1wf9AeEkBTIx6Ow+0xMsi4tntgZxAxUhrF+9ymKpelTqAc
         IgDxv6gGS4J80aBWbJElFivg4M7XObGe+inqNwLteC5a1ngVpBdxI9rgXxwHUZXIbo2F
         xUGzkp15WFZtu0ycs0+pJm8/SeOHv3hCHKSokoAfrgTJyHCU8/vWd6yryTTQOqpF1B2p
         PAma2ibYSUK6ARJD5SodFwWr5Z4r/mCFjnuti0PHL+aPYmJ/mI9tztdpI7TnA6aZhMcj
         oUzIdIjwAoo1+BU2pnhqtg7jWXIC7gq4+ztEukmhNTe2DbF4LrC+4fgVVmekDxqM+hK1
         Fdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tu8wgpIPngRqfRuzvINFm6+PnEeffLSirIDj1tdDwHo=;
        b=j/6MnBUIm/ZXS4xQzVXVEsdnSYouwYzV4vXFSb581vMCKKwoqboJf8kdKbEiSg0ViZ
         wqxGc6j15IzqgLuZMruojQTDkqeCmgX108RTOr3yy0iem5cLzmb0dFlOzBq3tIUeC0gV
         kDJMHCwLIVnkk4uYrM8xi8AeBRdcTI+BomKIURrgBzieWqF3V1JmS8itqWzKHsWq9IfB
         XnhmjP9Pp3lM2D2y5Ilr2YC9YzXkmdnDYH2309QEnkaQK/hY6ZxyVa3JLnoidmwkbJtQ
         nLSTDiySyEP2ymWvuaQpceWsRwKphT76Ir5izsbXLMbEKOOQxDvHAmToKHyC2GLQUsd+
         UE4g==
X-Gm-Message-State: APjAAAU6HBaTCoNm+FDiaDjmc7jj2SCmF7hv5cX418IpicnyjS23BOoW
        afO+WunUCBclRp1eSsqCKICReVJOjNg=
X-Google-Smtp-Source: APXvYqypDuxlBlM0L2zVxWd33HUhIj8qY/XKCRjOs2LfIN3nYykGyYI6rQt3khYnRr0qlrL9BQKGKw==
X-Received: by 2002:a0c:b11a:: with SMTP id q26mr15346295qvc.212.1552053160208;
        Fri, 08 Mar 2019 05:52:40 -0800 (PST)
Received: from quaco.ghostprotocols.net (177-59-154-188.3g.claro.net.br. [177.59.154.188])
        by smtp.gmail.com with ESMTPSA id o5sm4841044qkl.24.2019.03.08.05.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 05:52:39 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 57BF44039C; Fri,  8 Mar 2019 10:52:36 -0300 (-03)
Date:   Fri, 8 Mar 2019 10:52:36 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 05/15] perf tools report: Parse time quantum
Message-ID: <20190308135236.GF26260@kernel.org>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-6-andi@firstfloor.org>
 <20190308134532.GC26260@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308134532.GC26260@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 08, 2019 at 10:45:32AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Mar 05, 2019 at 06:47:48AM -0800, Andi Kleen escreveu:
> > From: Andi Kleen <ak@linux.intel.com>
> > +	if (*end == 0)
> > +		return 0;
> 
> We have tools/include/linux/time64.h, just like the kernel, so please
> use:
> 
> #include <linux/time64.h>

I'll do that this time.

- Arnado
