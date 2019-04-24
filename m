Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8027BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5394B218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8f9LisL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfDXOUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:20:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42416 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfDXOUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:20:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id w23so14807075lfc.9;
        Wed, 24 Apr 2019 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OLcf/MSErvvrE3bJG/rihIFJSAmMyrgPapsSpo9KmaE=;
        b=N8f9LisLDmcx/lUbIR+vStrDtygxhUgU3PZz6qn6PVwbXxSpft0WAQeLczwucGOXly
         Ci3MdEwCb5rmbiyFjzUwVFl8IPirbgmN57fDZYwo7L/w2rSS4b0NYLe1f8ACb7boVIYz
         hdfs5pJZom5k90kTxfFjPPPTEaJzg/XGrwgiPIN4CrIqK7pCNktaDWxt1qnP69R2lVxh
         XRk8wODzBkJ0RQa9sfib8jiRB02ysUMquRjDjdEAD6wI9T4wzXpzeptL+ZUT7eDyQUZL
         Op7AcasloAMALTVlugu0BbNLbXNwB8iLib3M9fzODyfBf/LJjOaZcmppqb2PKz8eAp7J
         sTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OLcf/MSErvvrE3bJG/rihIFJSAmMyrgPapsSpo9KmaE=;
        b=jmBTRJXukk7gIhafO4UrTDnvZdQzwcEFpTA2YkRA5J8Hdd/Gm5ysJxhPAMJRC6o+Mj
         VD7S6Mt0yfHqw8oxfIbaXq9kUjYpfwQbhJLNjBlWNCCIzMTjkGzO2b6fWKHyOdtZOtAL
         Z6+2ZXRWRZi6Q2TmWYZEBA7perzcAE01VCSOwqQzYCSJyCuBgqn3iH9QX0/KtNezNVj1
         oa3cgmwmupYC7oG2DfiDSkqz9P1Bn9Nj0XyYRbYpQVf9etUeBfHjqOQGMWnD5Kq3i8n+
         44K/OsePMoHnIwp935YxcK/rkvYhJe6mAxNzkTQ5Lg3tGpbuBUQ2Jzc+Ju8BHdO65Urt
         k+mw==
X-Gm-Message-State: APjAAAXxBGK/VZ21iJLEqHU9JpdLCq8iYQ7Kdl+yvci70KqOg1zJ1ZDf
        A2cLtpT1gnt0SI4fCrb3SGU=
X-Google-Smtp-Source: APXvYqwJ3uXWd+fEv/YsbYsSoGDjBF+KsjEKZI67imLJM70S+L5DO138c9I3dA7SxKrPlyUIRnEzEQ==
X-Received: by 2002:ac2:5455:: with SMTP id d21mr16970071lfn.60.1556115617156;
        Wed, 24 Apr 2019 07:20:17 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id a2sm4417352lfi.13.2019.04.24.07.20.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 07:20:16 -0700 (PDT)
Date:   Wed, 24 Apr 2019 17:20:14 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Huacai Chen <chenhc@lemote.com>,
        Stefan Agner <stefan@agner.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Juergen Gross <jgross@suse.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] mips: Dump memblock regions for debugging
Message-ID: <20190424142012.rvdfikcsz63pjcgw@mobilestation>
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
 <20190423224748.3765-9-fancer.lancer@gmail.com>
 <20190424134547.GD6278@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424134547.GD6278@rapoport-lnx>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 04:45:47PM +0300, Mike Rapoport wrote:
> On Wed, Apr 24, 2019 at 01:47:44AM +0300, Serge Semin wrote:
> > It is useful to have the whole memblock memory space printed to console
> > when basic memlock initializations are done. It can be performed by
> > ready-to-use method memblock_dump_all(), which prints the available
> > and reserved memory spaces if MEMBLOCK_DEBUG config is enabled.
> 
> Nit: there's no MEMBLOCK_DEBUG config option but rather memblock=debug
> command line parameter ;-)
> 

Right. Thanks. I'll reword the message in the next patchset revision.

-Sergey

> > Lets call it at the very end of arch_mem_init() function, when
> > all memblock memory and reserved regions are defined, but before
> > any serious allocation is performed.
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  arch/mips/kernel/setup.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> > index 2a1b2e7a1bc9..ca493fdf69b0 100644
> > --- a/arch/mips/kernel/setup.c
> > +++ b/arch/mips/kernel/setup.c
> > @@ -824,6 +824,8 @@ static void __init arch_mem_init(char **cmdline_p)
> >  	/* Reserve for hibernation. */
> >  	memblock_reserve(__pa_symbol(&__nosave_begin),
> >  		__pa_symbol(&__nosave_end) - __pa_symbol(&__nosave_begin));
> > +
> > +	memblock_dump_all();
> >  }
> >  
> >  static void __init resource_init(void)
> > -- 
> > 2.21.0
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 
