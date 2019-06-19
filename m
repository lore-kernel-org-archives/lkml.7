Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B533C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8EA21855
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560956534;
	bh=yfxdDVL/L5lNeV3SeQ7WR171eTNKD9P+ikTOSH+xc1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cBQYNIwH650ff+Y8w6gVR/PnuYwu40clDFKBLyN7VuJ85ZyKuawv2XGQXCF6rBg6p
	 WJsHqWHvtBTHJJBlPUu2E8yXTSiJ/yo4TJ8rJKdoFSKwQh/rx6IyspVRRKtyvGVuSD
	 RgblyrW5pIkLipzQBL8nMNWcldD+PNYFzaukgn7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfFSPCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfFSPCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:02:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3F412183F;
        Wed, 19 Jun 2019 15:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560956530;
        bh=yfxdDVL/L5lNeV3SeQ7WR171eTNKD9P+ikTOSH+xc1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MliQoUrKGz0uikxExyDjZMWCoS7+rjh9EwaO98Jwv+ImdfIwscw8hUsGkEDL4Gx4P
         tYIASjvTrcgRzT9GASiutDMJwIaViXugwlbugykfuW/FNAvla3cgErYjQXEWbZBlui
         Xp3gbNjrxIJtraqotk+fvCHVExeUK/bZvZLfPUxY=
Date:   Wed, 19 Jun 2019 17:02:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: Re: [PATCH 04/14] ABI: better identificate tables
Message-ID: <20190619150207.GA19346@kroah.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
 <6bc45c0d5d464d25d4d16eceac48a2f407166944.1560477540.git.mchehab+samsung@kernel.org>
 <20190619125135.GG25248@localhost>
 <20190619105633.7f7315a5@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619105633.7f7315a5@coco.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 10:56:33AM -0300, Mauro Carvalho Chehab wrote:
> Hi Johan,
> 
> Em Wed, 19 Jun 2019 14:51:35 +0200
> Johan Hovold <johan@kernel.org> escreveu:
> 
> > On Thu, Jun 13, 2019 at 11:04:10PM -0300, Mauro Carvalho Chehab wrote:
> > > From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> > > 
> > > When parsing via script, it is important to know if the script
> > > should consider a description as a literal block that should
> > > be displayed as-is, or if the description can be considered
> > > as a normal text.
> > > 
> > > Change descriptions to ensure that the preceding line of a table
> > > ends with a colon. That makes easy to identify the need of a
> > > literal block.  
> > 
> > In the cover letter you say that the first four patches of this series,
> > including this one, "fix some ABI descriptions that are violating the
> > syntax described at Documentation/ABI/README". This seems a bit harsh,
> > given that it's you that is now *introducing* a new syntax requirement
> > to assist your script.
> 
> Yeah, what's there at the cover letter doesn't apply to this specific
> patch. The thing is that I wrote this series a lot of time ago (2016/17).
> 
> I revived those per a request at KS ML, as we still need to expose the
> ABI content on some book that will be used by userspace people.
> 
> So, I just rebased it on the top of curent Kernel, add a cover letter
> with the things I remembered and re-sent.
> 
> In the specific case of this patch, the ":" there actually makes sense
> for someone that it is reading it as a text file, and it is an easy
> hack to make it parse better.
> 
> > Specifically, this new requirement isn't documented anywhere AFAICT, so
> > how will anyone adding new ABI descriptions learn about it?
> 
> Yeah, either that or provide an alternative to "Description" tag, to be
> used with more complex ABI descriptions.
> 
> One of the things that occurred to me, back on 2017, is that we should
> have a way to to specify that an specific ABI description would have
> a rich format. Something like:
> 
> What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/pyra/roccatpyra<minor>/actual_cpi
> Date:		August 2010
> Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
> RST-Description:
> 		It is possible to switch the cpi setting of the mouse with the
> 		press of a button.
> 		When read, this file returns the raw number of the actual cpi
> 		setting reported by the mouse. This number has to be further
> 		processed to receive the real dpi value:
> 
> 		===== =====
> 		VALUE DPI
> 		===== =====
> 		1     400
> 		2     800
> 		4     1600
> 		===== =====
> 
> With that, the script will know that the description contents will be using
> the ReST markup, and parse it accordingly. Right now, what it does, instead,
> is to place the description on a code-block, e. g. it will produce this
> output for the description:
> 
> ::
> 
> 		It is possible to switch the cpi setting of the mouse with the
> 		press of a button.
> 		When read, this file returns the raw number of the actual cpi
> 		setting reported by the mouse. This number has to be further
> 		processed to receive the real dpi value:
> 
> 		VALUE DPI
> 		1     400
> 		2     800
> 		4     1600
> 
> 
> Greg, 
> 
> what do you think?

I don't know when "Description" and "RST-Description" would be used.
Why not just parse "Description" like rst text and if things are "messy"
we fix them up as found, like you did with the ":" here?  It doesn't
have to be complex, we can always fix them up after-the-fact if new
stuff gets added that doesn't quite parse properly.

Just like we do for most kernel-doc formatting :)

thanks,

greg k-h
