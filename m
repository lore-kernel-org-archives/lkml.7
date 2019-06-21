Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2777C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771D020B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561101718;
	bh=BEm/q++STfaV62as0+wcSgtLxmizISkWXiUqnVMMcA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KeZoTafXhAKLYWcSNeEQoNNwuetLEeXRQQOzDfAxyu3etbJLhPRnHQdlTAvRJWZu3
	 ZIGhgnGozQFppXMwZiAegsWFuVSbPHjPk7qGmJbwigYDDj1Xed3YbwHlect2V8H0rg
	 zKi7zOxitw9gYHsLYXUfBSnd5obtk+dAfyfAOtsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfFUHV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 03:21:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfFUHV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 03:21:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2A1A206E0;
        Fri, 21 Jun 2019 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561101715;
        bh=BEm/q++STfaV62as0+wcSgtLxmizISkWXiUqnVMMcA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TWKaDNQi0vZQLYHOjm5oSwQZDBExUBu0mcyVTTIIuKM2dcRnN/k5wl3PN+CJ0PYTa
         3/PkfR0ytMUNdyjY8JcoS9yasedMvXB5336kHhrolzA41NbVrRIfXH2fEM2jCQMx0f
         HSxIHzcVBegtI8YwRWqMAJ0jKObS+aICiRmMc3M0=
Date:   Fri, 21 Jun 2019 09:21:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: Re: [PATCH 04/14] ABI: better identificate tables
Message-ID: <20190621072152.GA21300@kroah.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
 <6bc45c0d5d464d25d4d16eceac48a2f407166944.1560477540.git.mchehab+samsung@kernel.org>
 <20190619125135.GG25248@localhost>
 <20190619105633.7f7315a5@coco.lan>
 <20190619150207.GA19346@kroah.com>
 <20190619131408.26b45c3b@coco.lan>
 <20190620112749.5e3fb4e9@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620112749.5e3fb4e9@coco.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 11:27:49AM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 19 Jun 2019 13:14:08 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:
> 
> > Em Wed, 19 Jun 2019 17:02:07 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> > 
> > > On Wed, Jun 19, 2019 at 10:56:33AM -0300, Mauro Carvalho Chehab wrote:  
> > > > Hi Johan,
> > > > 
> > > > Em Wed, 19 Jun 2019 14:51:35 +0200
> > > > Johan Hovold <johan@kernel.org> escreveu:
> > > >     
> > > > > On Thu, Jun 13, 2019 at 11:04:10PM -0300, Mauro Carvalho Chehab wrote:    
> > > > > > From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> > > > > > 
> > > > > > When parsing via script, it is important to know if the script
> > > > > > should consider a description as a literal block that should
> > > > > > be displayed as-is, or if the description can be considered
> > > > > > as a normal text.
> > > > > > 
> > > > > > Change descriptions to ensure that the preceding line of a table
> > > > > > ends with a colon. That makes easy to identify the need of a
> > > > > > literal block.      
> > > > > 
> > > > > In the cover letter you say that the first four patches of this series,
> > > > > including this one, "fix some ABI descriptions that are violating the
> > > > > syntax described at Documentation/ABI/README". This seems a bit harsh,
> > > > > given that it's you that is now *introducing* a new syntax requirement
> > > > > to assist your script.    
> > > > 
> > > > Yeah, what's there at the cover letter doesn't apply to this specific
> > > > patch. The thing is that I wrote this series a lot of time ago (2016/17).
> > > > 
> > > > I revived those per a request at KS ML, as we still need to expose the
> > > > ABI content on some book that will be used by userspace people.
> > > > 
> > > > So, I just rebased it on the top of curent Kernel, add a cover letter
> > > > with the things I remembered and re-sent.
> > > > 
> > > > In the specific case of this patch, the ":" there actually makes sense
> > > > for someone that it is reading it as a text file, and it is an easy
> > > > hack to make it parse better.
> > > >     
> > > > > Specifically, this new requirement isn't documented anywhere AFAICT, so
> > > > > how will anyone adding new ABI descriptions learn about it?    
> > > > 
> > > > Yeah, either that or provide an alternative to "Description" tag, to be
> > > > used with more complex ABI descriptions.
> > > > 
> > > > One of the things that occurred to me, back on 2017, is that we should
> > > > have a way to to specify that an specific ABI description would have
> > > > a rich format. Something like:
> > > > 
> > > > What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/pyra/roccatpyra<minor>/actual_cpi
> > > > Date:		August 2010
> > > > Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
> > > > RST-Description:
> > > > 		It is possible to switch the cpi setting of the mouse with the
> > > > 		press of a button.
> > > > 		When read, this file returns the raw number of the actual cpi
> > > > 		setting reported by the mouse. This number has to be further
> > > > 		processed to receive the real dpi value:
> > > > 
> > > > 		===== =====
> > > > 		VALUE DPI
> > > > 		===== =====
> > > > 		1     400
> > > > 		2     800
> > > > 		4     1600
> > > > 		===== =====
> > > > 
> > > > With that, the script will know that the description contents will be using
> > > > the ReST markup, and parse it accordingly. Right now, what it does, instead,
> > > > is to place the description on a code-block, e. g. it will produce this
> > > > output for the description:
> > > > 
> > > > ::
> > > > 
> > > > 		It is possible to switch the cpi setting of the mouse with the
> > > > 		press of a button.
> > > > 		When read, this file returns the raw number of the actual cpi
> > > > 		setting reported by the mouse. This number has to be further
> > > > 		processed to receive the real dpi value:
> > > > 
> > > > 		VALUE DPI
> > > > 		1     400
> > > > 		2     800
> > > > 		4     1600
> > > > 
> > > > 
> > > > Greg, 
> > > > 
> > > > what do you think?    
> > > 
> > > I don't know when "Description" and "RST-Description" would be used.
> > > Why not just parse "Description" like rst text and if things are "messy"
> > > we fix them up as found, like you did with the ":" here?  It doesn't
> > > have to be complex, we can always fix them up after-the-fact if new
> > > stuff gets added that doesn't quite parse properly.
> > > 
> > > Just like we do for most kernel-doc formatting :)  
> > 
> > Works for me. Yet, I guess I tried that, back on 2017. 
> > 
> > If I'm not mistaken, the initial patchset to solve the broken things 
> > won't be small, and will be require a lot of attention in order to
> > identify what's broken and where.
> > 
> > Btw, one thing is to pass at ReST validation. Another thing is to
> > produce something that people can read. 
> > 
> > Right now, the pertinent logic at the script I wrote (scripts/get_abi.pl)
> > is here:
> > 
> >                 if (!($desc =~ /^\s*$/)) {
> >                         if ($desc =~ m/\:\n/ || $desc =~ m/\n[\t ]+/  || $desc =~ m/[\x00-\x08\x0b-\x1f\x7b-\xff]/) {
> >                                 # put everything inside a code block
> >                                 $desc =~ s/\n/\n /g;
> > 
> >                                 print "::\n\n";
> >                                 print " $desc\n\n";
> >                         } else {
> >                                 # Escape any special chars from description
> >                                 $desc =~s/([\x00-\x08\x0b-\x1f\x21-\x2a\x2d\x2f\x3c-\x40\x5c\x5e-\x60\x7b-\xff])/\\$1/g;
> > 
> >                                 print "$desc\n\n";
> >                         }
> >                 }
> > 
> > If it discovers something weird enough, it just places everything
> > into a comment block. Otherwise, it assumes that it is a plain
> > text and that any special characters should be escaped.
> > 
> > If the above block is replaced by a simple:
> > 
> > 		print "$desc\n\n";
> > 
> > The description content will be handled as a ReST file.
> > 
> > I don't have any time right now to do this change and to handle the
> > warnings that will start to popup.
> > 
> > Btw, a single replace there is enough to show the amount of problems that
> > it will rise, as it will basically break Sphinx build with:
> > 
> > 	reading sources... [  1%] admin-guide/abi-testing
> > 	reST markup error:
> > 	get_abi.pl rest --dir $srctree/Documentation/ABI/testing:45261: (SEVERE/4) Missing matching underline for section title overline.
> > 	
> > 	==========================
> > 	PCIe Device AER statistics
> > 	These attributes show up under all the devices that are AER capable. These
> 
> To be clear here: the problem with the above is that ReST has zero
> tolerance and actually behaves like a crash, if it receives something like:
> 
>    ==========================
>    PCIe Device AER statistics
>    ==========================
> 
> For it to work, it has to have zero spaces before ===..=== line, e. g.:
> 
> ==========================
> PCIe Device AER statistics
> ==========================
> 
> Ok, maybe we could try to teach the parser a way to identify the initial
> spacing of the first description line and remove that amount of 
> spaces/tabs for the following lines, but it may require some heuristics.

Or we can clean this type of thing up by hand :)

Let's see how bad this gets, the documentation in these files should not
be very complex as they _should_ only be one-value-per-file, but as you
have shown in this very example, that rule is violated :(

thanks,

greg k-h
