Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605A7C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352CB207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lY/sopxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfKYNbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:31:12 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35228 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfKYNbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wQ7nNasB5OVBsBnMvb/sZsxt8Jk1ECL1ctS3CZub2Zg=; b=lY/sopxAxAwBWEVTLeQ2JItJ8
        2XaR30iNcp7runLpb7ia0UP8c89/4xH3dbSACFc5tF61uz0OC1WSrwJRcGq44OIArYDRIiJmHLoED
        gcWCxz42QnaWAVzFRVrweB0U8GHYnqjrnQj9bjpyF4mdhEUAB3KylbMYguxVQQVX/dl8WIPJKgM53
        7feLGUI1mLWY5mzcCErRQbT8qwxvRDMIGHApVwmfAZgDA6CVemZRY6fQtzkdvJeH+i7ZAO4T9NY+B
        L0LkcfmjdqYQ+N8NNgMw+hUXktOknDt0aEPyFEwJTC8ZrNBm351WX6Cfkq4gMcDQUakI54TBuDreI
        4hAly6Rgg==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:32784)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iZESG-0007xc-SD; Mon, 25 Nov 2019 13:31:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iZESF-0006ht-IS; Mon, 25 Nov 2019 13:31:03 +0000
Date:   Mon, 25 Nov 2019 13:31:03 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] clk: Add devm_clk_{prepare,enable,prepare_enable}
Message-ID: <20191125133103.GR25745@shell.armlinux.org.uk>
References: <1d7a1b3b-e9bf-1d80-609d-a9c0c932b15a@free.fr>
 <34e32662-c909-9eb3-e561-3274ad0bf3cc@free.fr>
 <20191125125231.GO25745@shell.armlinux.org.uk>
 <45730e3c-efc7-4433-4980-e6aefebdcbff@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45730e3c-efc7-4433-4980-e6aefebdcbff@free.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 02:16:17PM +0100, Marc Gonzalez wrote:
> On 25/11/2019 13:52, Russell King - ARM Linux admin wrote:
> 
> > On Mon, Nov 25, 2019 at 01:46:51PM +0100, Marc Gonzalez wrote:
> > 
> >> On 15/07/2019 17:34, Marc Gonzalez wrote:
> >>
> >>> Provide devm variants for automatic resource release on device removal.
> >>> probe() error-handling is simpler, and remove is no longer required.
> >>>
> >>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> >>> ---
> >>>  Documentation/driver-model/devres.rst |  3 +++
> >>>  drivers/clk/clk.c                     | 24 ++++++++++++++++++++++++
> >>>  include/linux/clk.h                   |  8 ++++++++
> >>>  3 files changed, 35 insertions(+)
> >>>
> >>> diff --git a/Documentation/driver-model/devres.rst b/Documentation/driver-model/devres.rst
> >>> index 1b6ced8e4294..9357260576ef 100644
> >>> --- a/Documentation/driver-model/devres.rst
> >>> +++ b/Documentation/driver-model/devres.rst
> >>> @@ -253,6 +253,9 @@ CLOCK
> >>>    devm_clk_hw_register()
> >>>    devm_of_clk_add_hw_provider()
> >>>    devm_clk_hw_register_clkdev()
> >>> +  devm_clk_prepare()
> >>> +  devm_clk_enable()
> >>> +  devm_clk_prepare_enable()
> >>>  
> >>>  DMA
> >>>    dmaenginem_async_device_register()
> >>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> >>> index c0990703ce54..5e85548357c0 100644
> >>> --- a/drivers/clk/clk.c
> >>> +++ b/drivers/clk/clk.c
> >>> @@ -914,6 +914,18 @@ int clk_prepare(struct clk *clk)
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(clk_prepare);
> >>>  
> >>> +static void unprepare(void *clk)
> >>> +{
> >>> +	clk_unprepare(clk);
> >>> +}
> >>> +
> >>> +int devm_clk_prepare(struct device *dev, struct clk *clk)
> >>> +{
> >>> +	int rc = clk_prepare(clk);
> >>> +	return rc ? : devm_add_action_or_reset(dev, unprepare, clk);
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(devm_clk_prepare);
> >>> +
> >>>  static void clk_core_disable(struct clk_core *core)
> >>>  {
> >>>  	lockdep_assert_held(&enable_lock);
> >>> @@ -1136,6 +1148,18 @@ int clk_enable(struct clk *clk)
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(clk_enable);
> >>>  
> >>> +static void disable(void *clk)
> >>> +{
> >>> +	clk_disable(clk);
> >>> +}
> >>> +
> >>> +int devm_clk_enable(struct device *dev, struct clk *clk)
> >>> +{
> >>> +	int rc = clk_enable(clk);
> >>> +	return rc ? : devm_add_action_or_reset(dev, disable, clk);
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(devm_clk_enable);
> >>> +
> >>>  static int clk_core_prepare_enable(struct clk_core *core)
> >>>  {
> >>>  	int ret;
> >>> diff --git a/include/linux/clk.h b/include/linux/clk.h
> >>> index 3c096c7a51dc..d09b5207e3f1 100644
> >>> --- a/include/linux/clk.h
> >>> +++ b/include/linux/clk.h
> >>> @@ -895,6 +895,14 @@ static inline void clk_restore_context(void) {}
> >>>  
> >>>  #endif
> >>>  
> >>> +int devm_clk_prepare(struct device *dev, struct clk *clk);
> >>> +int devm_clk_enable(struct device *dev, struct clk *clk);
> >>> +static inline int devm_clk_prepare_enable(struct device *dev, struct clk *clk)
> >>> +{
> >>> +	int rc = devm_clk_prepare(dev, clk);
> >>> +	return rc ? : devm_clk_enable(dev, clk);
> >>> +}
> >>> +
> >>>  /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
> >>>  static inline int clk_prepare_enable(struct clk *clk)
> >>>  {
> >>
> >> Thoughts? Comments?
> > 
> > These are part of the clk API rather than the CCF API, and belong in
> > drivers/clk/clk-devres.c.
> 
> I'm totally confused.
> 
> Are you saying that a hypothetical devm_clk_prepare() function should not be
> implemented in the same file as the "raw" clk_prepare() ?

The clk API and CCF are two different things.  I look after the clk API.
The CCF is an implementation of the clk API.  Do not introduce clk API
code in files that are CCF specific.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
