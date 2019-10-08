Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC185C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C973B218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570557217;
	bh=MwGh36UI/BopOFCDS3wjb/ZJxlTiw6fSQqmuXFC6O3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pc12qgif5k9qAANJeA/ffsR1aHdwNag//cxgzPUfObG6wIOaSfaZlGX+RheIikROj
	 WUkDM6z7TvnIYis0PSlj7XO8i/u/H+MFAQ4h2XN8tkFldl0tlPOZFysLpQ5ybE5MVR
	 CCVB/5kNBSiniV//vZz3lVAOZNdnNkAIeVFefS14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfJHRxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:53:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38915 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfJHRxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:53:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so20477897wrj.6;
        Tue, 08 Oct 2019 10:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=biGUlUHt7gI+lvxrPWTuGpTY989m3mtLcUoswoyT+ig=;
        b=davgj+5BKG+8er/B+LZTJLQTVZ1G4T86SFHNpAuNQDneyi4R3nn9X5z2U7pkOvBuTD
         muikQ7XuoNiKJ7r1cjE6DRydDg3bg2aL/YZZhdZZ1I9hfua3emindWt5uvAxcCAQkG4H
         VyWRb42xKpfRLg/rM6pRzavU/FXcC/RvLj9cJUYlc6wXHkw6sObu1AXqVIANULvfQP3b
         5u4Hfhu+mWaZWFsUOP70rYFrqL1vWo0CSZ+ONgMOsEWPGQOKtPRl5Jqrtv18qKbf5wsk
         IhQ0aj7LTnQL6MkJXeLYVGhYBv1ABBJ207x27fzgSHbVvZ3auf1mdwqRytLyEtluCY56
         Yn4Q==
X-Gm-Message-State: APjAAAVj22rl21sOkhzHAxeYjEUVgh76we8guM4IU8/Eca+BkQ8bZ9aW
        BzCyz7V1usaqVvPp5VIHPIvmtzWd
X-Google-Smtp-Source: APXvYqxcSOUZjtZkaOPACSxR3aFYAuWRL9aDUd0khkLJhPdhJQE9JK92kwvKDqqNrk+Nxg2TFrTmZg==
X-Received: by 2002:adf:eec1:: with SMTP id a1mr25802083wrp.151.1570557214261;
        Tue, 08 Oct 2019 10:53:34 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id r6sm4336796wmh.38.2019.10.08.10.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 10:53:33 -0700 (PDT)
Date:   Tue, 8 Oct 2019 19:53:30 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Lihua Yao <ylhuajnu@outlook.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: s3c64xx: Fix init order of clock providers
Message-ID: <20191008175330.GA28160@kozik-lap>
References: <CGME20191008165931epcas3p2dd2937d851ed06948dd7746e5a2674b4@epcas3p2.samsung.com>
 <20191008165917.23908-1-krzk@kernel.org>
 <ceede424-e4a2-03f1-3ce0-04f405688721@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ceede424-e4a2-03f1-3ce0-04f405688721@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 07:30:50PM +0200, Sylwester Nawrocki wrote:
> On 10/8/19 18:59, Krzysztof Kozlowski wrote:
> > From: Lihua Yao <ylhuajnu@outlook.com>
> > 
> > fin_pll is the parent of clock-controller@7e00f000, specify
> > the dependency to ensure proper initialization order of clock
> > providers.
> 
> > Fixes: 3f6d439f2022 ("clk: reverse default clk provider initialization order in of_clk_init()")
> 
> The patch looks good but I'm not sure above tag points to the right commit.
> That commit is just a regression fix for
> 1771b10d605d26cc "clk: respect the clock dependencies in of_clk_init"
>  
> How about picking some commit touching the dts files itself, e.g.
> a43736deb47d21bd "ARM: dts: Add dts file for S3C6410-based Mini6410 board" ?

As I understood, the mentioned commit "reverse default clk provider"
caused issue to appear, because of reversed order (first version of this
patch played with the order).  Even though that commit was not strictly
the cause, but should come proably with proper DTS change.  Therefore
the fixes points to right moment of backports.

The DTS commit, at that time, was correct with bindings and with driver.

> 
> > Signed-off-by: Lihua Yao <ylhuajnu@outlook.com>
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Thanks!

Best regards,
Krzysztof

