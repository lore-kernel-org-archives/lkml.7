Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6834DC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4A82085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561032118;
	bh=DtLPO3zV71wK2O9vSDUw6mUjx3myGPN8NI1sWzdkYcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iahFiWT7e8tkObXnnZ+NN5eY1hyMyBTNCfKHSjt/3DwZLjz2TEfyNZU5VAfUPxAHa
	 eAvYSh8/J44j3ZLNcCPWM0yRZVyvTKvXl+Hfklfns+M1FcaBMb6Lw/gPpAHkgFCVOg
	 KjokKeK+HLQEHPB8o1xdzkmLXMrVfXHwRfAu8SYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbfFTMB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:01:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33481 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfFTMBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:01:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id y17so2270597lfe.0;
        Thu, 20 Jun 2019 05:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BRGVqdDAlLrmPYJXfuZfdTmGIOTEEoz2JXOrA0UxT1o=;
        b=TN/XdLoMmmNXu7GZAcYJr72SuWjGfEd7YhU1EMjupV8W5W8/O21C7i6xNGzI7uBidZ
         VPBYUiGmazOrVJzVjpcAI1xreME0vBk++nULhTuwNEIYY0B7IQfbSiCaJkycm4Hwsvxk
         v5aFZiKoo9FNR2qij4QEm60AaSqfJhYOGdcIujhebWa5/x+y+usC50jtRIq758YPplzn
         mJDfrYNW97X5FqvDHouKZ8Nx5Pbw3mGtetUUpaka8ybQxd75c0d5eMwXuhZuMuXHPJUd
         a0yEt9MdsYy3csFgHCTn1FBIdZoAzVMJDMpANe5hOOkHxLeeCytC3kQwgLgT5gjp2cn2
         eatQ==
X-Gm-Message-State: APjAAAVeMgLvaxD9vVoSa45lRvILc0bmfr3i6Sb/wb2FNLdIEZ36Q9IE
        CM5iZPuq9qAOowpn0TZ7VrY=
X-Google-Smtp-Source: APXvYqxvmNsFmHQ21fVx417L58yVeoMhaT9HFKYJPlm4j+E7olowKhByqoupjYvxAXFzxm+1nsjSMw==
X-Received: by 2002:a19:f20d:: with SMTP id q13mr60842699lfh.65.1561032112276;
        Thu, 20 Jun 2019 05:01:52 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id k82sm3481071lje.30.2019.06.20.05.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 05:01:51 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92)
        (envelope-from <johan@kernel.org>)
        id 1hdvlG-0008CM-9l; Thu, 20 Jun 2019 14:01:50 +0200
Date:   Thu, 20 Jun 2019 14:01:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: Re: [PATCH 04/14] ABI: better identificate tables
Message-ID: <20190620120150.GH6241@localhost>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
 <6bc45c0d5d464d25d4d16eceac48a2f407166944.1560477540.git.mchehab+samsung@kernel.org>
 <20190619125135.GG25248@localhost>
 <20190619105633.7f7315a5@coco.lan>
 <20190619150207.GA19346@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619150207.GA19346@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 05:02:07PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 19, 2019 at 10:56:33AM -0300, Mauro Carvalho Chehab wrote:
> > Hi Johan,
> > 
> > Em Wed, 19 Jun 2019 14:51:35 +0200
> > Johan Hovold <johan@kernel.org> escreveu:
> > 
> > > On Thu, Jun 13, 2019 at 11:04:10PM -0300, Mauro Carvalho Chehab wrote:
> > > > From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> > > > 
> > > > When parsing via script, it is important to know if the script
> > > > should consider a description as a literal block that should
> > > > be displayed as-is, or if the description can be considered
> > > > as a normal text.
> > > > 
> > > > Change descriptions to ensure that the preceding line of a table
> > > > ends with a colon. That makes easy to identify the need of a
> > > > literal block.  
> > > 
> > > In the cover letter you say that the first four patches of this series,
> > > including this one, "fix some ABI descriptions that are violating the
> > > syntax described at Documentation/ABI/README". This seems a bit harsh,
> > > given that it's you that is now *introducing* a new syntax requirement
> > > to assist your script.
> > 
> > Yeah, what's there at the cover letter doesn't apply to this specific
> > patch. The thing is that I wrote this series a lot of time ago (2016/17).

Got it, thanks.

[...]

> > In the specific case of this patch, the ":" there actually makes sense
> > for someone that it is reading it as a text file, and it is an easy
> > hack to make it parse better.

Human readers probably depend on more on tabulation and white space.
When the preceding description wasn't using a colon to begin with (and
you just replace s/\./:/) it can even look weird, but no big deal.

> > > Specifically, this new requirement isn't documented anywhere AFAICT, so
> > > how will anyone adding new ABI descriptions learn about it?
> > 
> > Yeah, either that or provide an alternative to "Description" tag, to be
> > used with more complex ABI descriptions.
> > 
> > One of the things that occurred to me, back on 2017, is that we should
> > have a way to to specify that an specific ABI description would have
> > a rich format. Something like:

[...]

> I don't know when "Description" and "RST-Description" would be used.
> Why not just parse "Description" like rst text and if things are "messy"
> we fix them up as found, like you did with the ":" here?  It doesn't
> have to be complex, we can always fix them up after-the-fact if new
> stuff gets added that doesn't quite parse properly.
> 
> Just like we do for most kernel-doc formatting :)

But kernel-doc has a documented format, which was sort of the point I
was trying to make. If the new get_abi.pl scripts expects a colon I
think it should be mentioned somewhere (e.g. Documentation/ABI/README).

Grepping for attribute entries in linux-next still reveals a number
descriptions that still lack that colon and use varying formatting. More
are bound to be added later, but perhaps that's ok depending on what
you're aiming at here.

Johan
