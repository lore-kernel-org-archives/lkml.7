Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27492C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56B720857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="K4uKRz91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfCSJZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:25:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53610 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfCSJZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:25:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id e74so15774326wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 02:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Jra424Dp373u9egLT7cs3suTHlRQTxWaaAhBRmIn2rk=;
        b=K4uKRz91md6r9JeM9rv1sYesvETA80w9gQoUtNS5y4wE8bUakbAtHPgPSf9MuSLmbx
         VNmNAzx83GvvJQWVxm8EEt76rkEmYhwIa+eRfUYI89xiYQAtuHeOZYG9qv5Z87yP9Pyt
         LNYqxx40Jtov1Az4Pv+ReQL8OCC/nM535J4FYQX4+vUtvYDB5/DlLG6YYNize8r5Ym3j
         dnoArgRhycF8IW9oBbuqDmfCKGKaWOsKYIv/D3GgMQ7wlVulyleAI5NhH/kQX2Py8J1E
         JzUhvCuKqFbnPiNVc3ejbcEQeN/dhO8KpsuDAffiqAdfAgH5G0+6ca+sZKBnnXZB8a/C
         5d/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Jra424Dp373u9egLT7cs3suTHlRQTxWaaAhBRmIn2rk=;
        b=CurZbdr8HiB+9h3BQ4Je5jkOouTuoiBPN+AOsVqvs7O6E89pY9C/QEjANL7re4Npvd
         w1E2nKXLbNbSnNaIdqK49Teb1t6U0fSwJPsiJgnuZ52Lp9lNB864vaau7xMy3Xx2Cq9j
         HzjqO2JF+1WahcpzaXJ/lM5MPh2hgsFMkqPwUDSh0VRD255WHNvccu52JyjzHKfJe88a
         WwF0UWtB6iiVzpY5KQoXBaK+GC/2T8xCGSBGS5+MQXkcDojJWuJ/RR+/OOJzv8sNDv35
         k1rmw7HxNY+GqPTvu5eVTsH4KzRkNgV2R26+K55mX+VWl4lvHi6kNpoMjrgiURVMelfr
         jTrA==
X-Gm-Message-State: APjAAAXeaHuOZfN5J87Bt77IxLQkDQiRN//FpywL3geiW7YDT64XAKez
        LOHIBZj7/v07DSTvpOjYKyYrUA==
X-Google-Smtp-Source: APXvYqwariR8CHsVd5ZVbR7P4ixzklARO+UrKWAFWXP2pW/zIoxwTXDBKM4QALS78lhLEdAOR7/hHQ==
X-Received: by 2002:a7b:c008:: with SMTP id c8mr2583698wmb.98.1552987551203;
        Tue, 19 Mar 2019 02:25:51 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id f10sm1758721wml.23.2019.03.19.02.25.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 19 Mar 2019 02:25:50 -0700 (PDT)
Message-ID: <f39104322b0ca6ec757d060605fddb43927c6a40.camel@baylibre.com>
Subject: Re: [PATCH v2 6/8] clk: Allow parents to be specified without
 string names
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 19 Mar 2019 10:25:48 +0100
In-Reply-To: <155267021941.20095.16439182841724325601@swboyd.mtv.corp.google.com>
References: <20190226223429.193873-1-sboyd@kernel.org>
         <20190226223429.193873-7-sboyd@kernel.org>
         <3e6aa4c392ccdd3bac76b556645139536e61e5e6.camel@baylibre.com>
         <155267021941.20095.16439182841724325601@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-15 at 10:16 -0700, Stephen Boyd wrote:
> Quoting Jerome Brunet (2019-03-15 03:01:53)
> > On Tue, 2019-02-26 at 14:34 -0800, Stephen Boyd wrote:
> > > ---
> > >  drivers/clk/clk.c            | 260 ++++++++++++++++++++++++++---------
> > >  include/linux/clk-provider.h |  19 +++
> > >  2 files changed, 217 insertions(+), 62 deletions(-)
> > 
> > Sorry for the delay.
> > 
> > With the fix you sent to Jeffrey
> > Tested by porting the aoclk controller of Amlogic g12a SoC.
> > This allowed to test
> >  * hws only table
> >  * parent_data with a mix of hw pointers and fw_name (with different input
> > controllers and also an input that is optional and never provided)
> > 
> > Tested-by: Jerome Brunet <jbrunet@baylibre.com>
> > 
> > With the small comment below
> > 
> > Reviewed-by Jerome Brunet <jbrunet@baylibre.com>
> > 
> 
> Awesome. Thanks! I need to Cc Rob H to hopefully get an ack on the
> concept of relying on DT so I'll resend this series again next week. It
> would also be nice if I can throw in a couple more patches to let
> drivers specify a DT node when registering a clk if they don't have a
> struct device on hand and let drivers lookup with clk_lookups somehow.
> 
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index 937b8d092d17..3d01e8c56400 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -39,6 +39,13 @@ static LIST_HEAD(clk_notifier_list);
> > >  
> > 
> > [...]
> > 
> > >  
> > > +static int clk_cpy_name(const char *dst, const char *src, bool must_exist)
> > > +{
> > > +     if (!src) {
> > > +             if (must_exist)
> > > +                     return -EINVAL;
> > > +             return 0;
> > > +     }
> > > +
> > > +     dst = kstrdup_const(src, GFP_KERNEL);
> > > +     if (!dst)
> > > +             return -ENOMEM;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int clk_core_populate_parent_map(struct clk_core *core)
> > > +{
> > > +     const struct clk_init_data *init = core->hw->init;
> > > +     u8 num_parents = init->num_parents;
> > > +     const char * const *parent_names = init->parent_names;
> > > +     const struct clk_hw **parent_hws = init->parent_hws;
> > > +     const struct clk_parent_data *parent_data = init->parent_data;
> > > +     int i, ret = 0;
> > > +     struct clk_parent_map *parents, *parent;
> > > +
> > > +     if (!num_parents)
> > > +             return 0;
> > > +
> > > +     /*
> > > +      * Avoid unnecessary string look-ups of clk_core's possible parents by
> > > +      * having a cache of names/clk_hw pointers to clk_core pointers.
> > > +      */
> > > +     parents = kcalloc(num_parents, sizeof(*parents), GFP_KERNEL);
> > > +     core->parents = parents;
> > > +     if (!parents)
> > > +             return -ENOMEM;
> > > +
> > > +     /* Copy everything over because it might be __initdata */
> > > +     for (i = 0, parent = parents; i < num_parents; i++, parent++) {
> > > +             if (parent_names) {
> > > +                     /* throw a WARN if any entries are NULL */
> > > +                     WARN(!parent_names[i],
> > > +                             "%s: invalid NULL in %s's .parent_names\n",
> > > +                             __func__, core->name);
> > > +                     ret = clk_cpy_name(parent->name, parent_names[i],
> > > +                                        true);
> > > +             } else if (parent_data) {
> > 
> > While testing, I mistakenly left both parent_names and parent_data. I was
> > surprised that parent_data did not take precedence of parent_names.
> > 
> > Maybe it should ? (... but I understand we are not supposed to provide both)
> 
> I don't think we can. We have a problem where drivers don't initialize
> the init structure properly, opting to just throw it on the stack and
> leave junk in there that they overwrite. We'd have to go through all the
> init structures and initialize them. I suppose we could make a macro for
> that:
> 
> 	DECLARE_CLK_INIT_DATA(init);
> 
> or something like that that does this. We could bury a magic number in
> there under some debug option too so that we can make sure drivers are
> doing this properly. Otherwise we're left to doing these weird tricks
> like I've done here.
> 
> Regardless. I'll have to add a comment to this fact in the code. Thanks.
> 
> > > +                     parent->hw = parent_data[i].hw;
> > > +                     ret = clk_cpy_name(parent->fw_name,
> > > +                                        parent_data[i].fw_name, false);
> > > +                     if (!ret)
> > > +                             ret = clk_cpy_name(parent->name,
> > > +                                                parent_data[i].name,
> > > +                                                false);
> > > +             } else if (parent_hws) {
> > > +                     parent->hw = parent_hws[i];
> > > +             } else {
> > 
> > Maybe there should also some kinda of check to verify if more than one option
> > (among hws, parent_data and parent_names) was provided and throw a warn ?
> > 
> > Could be useful with drivers move away from parent_names ?
> 
> Same thing. It would be nice but we're sort of unable to do so unless we
> do what I suggest above. Should we do it?
> 

I was not thinking about anything complicated:
* Among the 3 pointers, just throw a warn if more than one is not NULL
* In the if/elseif/else, I would have put parent_data before parent_names

Nothing critical about that comment though

