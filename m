Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7CAC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 04:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749AB2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 04:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8vgyNxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfHNEYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 00:24:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35006 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfHNEYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 00:24:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id k2so23894044wrq.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 21:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y97MxFgoBqjees+drSVKeA6Szdi0VlvTHwvx0CSVO1o=;
        b=Z8vgyNxN1/96cju2HdSvgfCTLSIOfSiDeQdM25KCwud1GJn0mSUuNbobkxEJNSS1my
         QMcH8MW8j3HePQ+3lVx5dtnm1phfslKegw81BTBr46hr5pZC5SSmAI5/7SgPrnOUf73j
         XT5zLFeR7myXlMKWya90DstB4WULDrVqFBqw+N6DFI+NRueyQ8bcYunasX+uM1oEZF17
         ay+fLAuuhmH4J4HcxczCaHU6KW78UIw7xwAPFClxvpRg+k09UIbeDUajvYirLXp+IZck
         u64kJ3KAjiR+XQP0d9W5JvK2PKw/Cxn99GJYhlII+r585WtwZqbHYPHSkZEGZPmnP1lI
         148A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y97MxFgoBqjees+drSVKeA6Szdi0VlvTHwvx0CSVO1o=;
        b=FPiG9a4UmxYGiM+HExl3Kao5ArvmLL6KuFqLAZV/D6uTXHx3CX+2OKxWrk/sAXLbCH
         lFM/ULpUYCQjvWyJv6bXZq9zaM731zjBAUi83B4dvB/R5JXI+kDKrOenzZD+QlbNrLm/
         ZhddfQ8pP3iUOqO1f+ocNbfoslcYiPdqOtTYXrH4ZEr2+kuxkPuqhnE0ahWsH2OQ0Gf6
         E7hcqswRFctFPhstEZQ8JDxO6fOwoTht4yEqSZ9kpQl/KMqega1ALxfVTLS/6esgdHk5
         atjT9y37GCxkBTwObq9FQ2I+TqS4J3qsYB94+rhgkHFCBHYEgRqhnY+C5JkF5rp7Ne78
         JJTA==
X-Gm-Message-State: APjAAAV8E/QFuO3qJcfGPlkXy2i616k12stuKIv6+4C1aokURe/DdH9n
        SkNwje7EUhK5+sAl7P8uiHo=
X-Google-Smtp-Source: APXvYqwQCWsT9X5GSB/vfPatoxfMcZpIswxj18GJjMsqWR17Abi56/0ywNRUwzWqagGutEH97pd76w==
X-Received: by 2002:adf:f206:: with SMTP id p6mr51871123wro.216.1565756670312;
        Tue, 13 Aug 2019 21:24:30 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id j2sm2741135wmh.43.2019.08.13.21.24.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 21:24:29 -0700 (PDT)
Date:   Tue, 13 Aug 2019 21:24:28 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        clang-built-linux@googlegroups.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] soundwire: Don't build sound.o without
 CONFIG_ACPI
Message-ID: <20190814042428.GA125416@archlinux-threadripper>
References: <20190813061014.45015-1-natechancellor@gmail.com>
 <445d16e1-6b00-6797-82df-42a49a5e79e3@linux.intel.com>
 <20190814035947.GS12733@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814035947.GS12733@vkoul-mobl.Dlink>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 09:29:47AM +0530, Vinod Koul wrote:
> On 13-08-19, 09:22, Pierre-Louis Bossart wrote:
> > On 8/13/19 1:10 AM, Nathan Chancellor wrote:
> > > clang warns when CONFIG_ACPI is unset:
> > > 
> > > ../drivers/soundwire/slave.c:16:12: warning: unused function
> > > 'sdw_slave_add' [-Wunused-function]
> > > static int sdw_slave_add(struct sdw_bus *bus,
> > >             ^
> > > 1 warning generated.
> > > 
> > > Before commit 8676b3ca4673 ("soundwire: fix regmap dependencies and
> > > align with other serial links"), this code would only be compiled when
> > > ACPI was set because it was only selected by SOUNDWIRE_INTEL, which
> > > depends on ACPI.
> > > 
> > > Now, this code can be compiled without CONFIG_ACPI, which causes the
> > > above warning. The IS_ENABLED(CONFIG_ACPI) guard could be moved to avoid
> > > compiling the function; however, slave.c only contains three functions,
> > > two of which are static. Only compile slave.o when CONFIG_ACPI is set,
> > > where it will actually be used. bus.h contains a stub for
> > > sdw_acpi_find_slaves so there will be no issues with an undefined
> > > function.
> > > 
> > > This has been build tested with CONFIG_ACPI set and unset in combination
> > > with CONFIG_SOUNDWIRE unset, built in, and a module.
> > 
> > Thanks for the patch. Do you have a .config you can share offline so that we
> > add it to our tests?
> > 
> > > 
> > > Fixes: 8676b3ca4673 ("soundwire: fix regmap dependencies and align with other serial links")
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/637
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >   drivers/soundwire/Makefile | 6 +++++-
> > >   drivers/soundwire/slave.c  | 3 ---
> > >   2 files changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> > > index 45b7e5001653..226090902716 100644
> > > --- a/drivers/soundwire/Makefile
> > > +++ b/drivers/soundwire/Makefile
> > > @@ -4,9 +4,13 @@
> > >   #
> > >   #Bus Objs
> > > -soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
> > > +soundwire-bus-objs := bus_type.o bus.o mipi_disco.o stream.o
> > >   obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
> > > +ifdef CONFIG_ACPI
> > > +soundwire-bus-objs += slave.o
> > > +endif
> > 
> > I am fine with the change, but we might as well rename the file acpi_slave.c
> > then?
> 
> Srini's change add support for DT for the same file, so It does not make
> sense to rename. Yes this patch tries to fix a warn which is there due
> to DT being not supported but with Srini's patches this warn should go
> away as sdw_slave_add() will be invoked by the DT counterpart
> 
> Sorry Nathan, we would have to live with the warn for few more days till
> I apply Srini's changes. So I am not taking this (or v2) patch
> 

That is fine as I can apply this locally. Could you point me to these
patches so that I can take a look at them?

Thanks for the reply!
Nathan
