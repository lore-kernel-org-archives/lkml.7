Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67332C2BA1D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 01:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D2B20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 01:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhxM/LCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfFGBxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 21:53:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41832 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 21:53:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so480396wrm.8;
        Thu, 06 Jun 2019 18:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HXbPnXaGhtf2NYvX8iWSqIWrGp6VGw0M5oS+kh5tYlw=;
        b=YhxM/LClRdhOXLrXGoyig8gM2kzYsJK3ClPUrSk8fcH08+R/FeaQGN1FzsJ1hEAI8V
         T1vIWi3coyHCm0EGClXmSsRPKJ6+G3iolZ8N0fHCOEMv9cWcTHMc1BrzkKI/ralknloR
         k/5zPimvlBj2OBt220R2UcWK0Mm+zjpX2SJ+U/xQczafReLc2mxhm5dNg016YBqEg79K
         nvgIrZ1hLvrUvDw79HGU/P5PqOecyyLi76Kq7qsux4ttza1LsVLMXbB96s6+OtSS4Rb+
         EOkhBBbnbsntBs24oiEX1Xxv9rlsaipyvWRM0r+qLh3b84RETMzMuxYYwK7qk//72BVV
         ruSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HXbPnXaGhtf2NYvX8iWSqIWrGp6VGw0M5oS+kh5tYlw=;
        b=ZORfoHD30cO27nLyvOMCKzhhRKQvJBRMTNGgG3R3+ggSE6BYRvt2VMZBjRcWvL0Y7k
         2aqxfc7yqh1omdplmMgeioans1+IZiF7eN4dAOjFo7AG4rTIDRsEBAueCzq1W7pwVJxh
         hiIzJtMSaZLgU+OvFHUetQPftb1mVCgGmb3CdENIA3nw/V3uKNjjIHtEb6hh6Web2qgb
         q5vVZ+1XWZJmQ5pm7fiUPTjw3Xem4H8xuDXw4I4xLzLlIt28QrUUkM2eW2g7Uit0Rsjf
         FMNMihqBdkrYqkDMYm0vT+XNrpKtDHy2CAHB7sbwrf2qnLuJaZDlG1mS2t5+IwQORwVb
         y1xg==
X-Gm-Message-State: APjAAAVUB7vV/IS2TFjr+RML/9HnwPTrzEcRdzoovx4S8z5zXB6fmuMZ
        4tixiZQLBH8f/6JL9FMuXH0=
X-Google-Smtp-Source: APXvYqxrKI3cYKI8sa6Aq8nV6jOp2DQ6mq7nGAQXpG2pc6sNmTJDT0osxxNapHChjOID6yvlf9XaCw==
X-Received: by 2002:a5d:4904:: with SMTP id x4mr4866906wrq.337.1559872385508;
        Thu, 06 Jun 2019 18:53:05 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id s63sm544369wme.17.2019.06.06.18.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 18:53:04 -0700 (PDT)
Date:   Fri, 7 Jun 2019 09:52:58 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Jiri Slaby <jslaby@suse.cz>, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: fix a missing-free bug in clk_cpy_name()
Message-ID: <20190607015258.GA2660@zhanggen-UX430UQ>
References: <20190531011424.GA4374@zhanggen-UX430UQ>
 <eb8e2d33-e8f7-93a5-c8bc-98731c0d63b6@suse.cz>
 <20190605160043.GA4351@zhanggen-UX430UQ>
 <20190606201646.B4CC4206BB@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606201646.B4CC4206BB@mail.kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 01:16:45PM -0700, Stephen Boyd wrote:
> Quoting Gen Zhang (2019-06-05 09:00:43)
> > On Wed, Jun 05, 2019 at 08:38:00AM +0200, Jiri Slaby wrote:
> > > On 31. 05. 19, 3:14, Gen Zhang wrote:
> > > > In clk_cpy_name(), '*dst_p'('parent->name'and 'parent->fw_name') and 
> > > > 'dst' are allcoted by kstrdup_const(). According to doc: "Strings 
> > > > allocated by kstrdup_const should be freed by kfree_const". So 
> > > > 'parent->name', 'parent->fw_name' and 'dst' should be freed.
> > > > 
> > > > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > > > ---
> > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > index aa51756..85c4d3f 100644
> > > > --- a/drivers/clk/clk.c
> > > > +++ b/drivers/clk/clk.c
> > > > @@ -3435,6 +3435,7 @@ static int clk_cpy_name(const char **dst_p, const char *src, bool must_exist)
> > > >     if (!dst)
> > > >             return -ENOMEM;
> > > >  
> > > > +   kfree_const(dst);
> > > 
> > > So you are now returning a freed pointer in dst_p?
> > Thanks for your reply. I re-examined the code, and this kfree is 
> > incorrect and it should be deleted.
> > > 
> > > >     return 0;
> > > >  }
> > > >  
> > > > @@ -3491,6 +3492,8 @@ static int clk_core_populate_parent_map(struct clk_core *core)
> > > >                             kfree_const(parents[i].name);
> > > >                             kfree_const(parents[i].fw_name);
> > > >                     } while (--i >= 0);
> > > > +                   kfree_const(parent->name);
> > > > +                   kfree_const(parent->fw_name);
> > > 
> > > Both of them were just freed in the loop above, no?
> > for (i = 0, parent = parents; i < num_parents; i++, parent++)
> > Is 'parent' the same as the one from the loop above?
> 
> Yes. Did it change somehow?
parent++?
> 
> > 
> > Moreover, should 'parents[i].name' and 'parents[i].fw_name' be freed by
> > kfree_const()?
> > 
> 
> Yes? They're allocated with kstrdup_const() in clk_cpy_name(), or
> they're NULL by virtue of the kcalloc and then kfree_const() does
> nothing.
I re-examined clk_cpy_name(). They are the second parameter of 
clk_cpy_name(). The first parameter is allocated, not the second one.
So 'parent->name' and 'parent->fw_name' should be freed, not 
'parents[i].name' or 'parents[i].fw_name'. Am I totally misunderstanding
this clk_cpy_name()? :-(

Thanks
Gen
> 
> I'm having a hard time following what this patch is trying to fix. It
> looks unnecessary though so I'm going to drop it from the clk review
> queue.
> 
