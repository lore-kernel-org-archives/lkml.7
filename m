Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D3BC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E952083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561048191;
	bh=aTPE4/MlVDXLh/bVBjr+tH+7DtK2ze10qXN75K5G0Og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OLzQ5ykKVZqoY8AnStEudZ7AXmvh9xK044JyVcdYNOgP/4itbPNjO0H/pdw41Mv1g
	 SHsgbfqDruQgINFWYTmjiWirYSv2hfP4O3GSNArMYoTwg84T6y3ORxiJhSEyc2gDqy
	 LcK+MMGX/v289Sd4XB724GOUeZC5ulQwRl7n4rSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbfFTQ3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfFTQ3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:29:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA0172064A;
        Thu, 20 Jun 2019 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561048188;
        bh=aTPE4/MlVDXLh/bVBjr+tH+7DtK2ze10qXN75K5G0Og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ktHE00JdENjw6it5sMr7BPX8b2uSgQ+Fu5iXr2GDSsuZIjjo04Qi7T8dkjxtg2wjh
         DBOLyCUD7f1iCk/44OXUqwzI86k4oKQ7Ltqa4527WOz0jQQv72CLkPHITlYsgksrbj
         uBylIw/v2VqxFSNILCjPZtpaD5DbXbnVHnj7BTyE=
Date:   Thu, 20 Jun 2019 18:29:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: Re: [PATCH 04/14] ABI: better identificate tables
Message-ID: <20190620162945.GC23052@kroah.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
 <6bc45c0d5d464d25d4d16eceac48a2f407166944.1560477540.git.mchehab+samsung@kernel.org>
 <20190619125135.GG25248@localhost>
 <20190619105633.7f7315a5@coco.lan>
 <20190619150207.GA19346@kroah.com>
 <20190620120150.GH6241@localhost>
 <20190620125413.GA5170@kroah.com>
 <20190620112034.0d2be447@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620112034.0d2be447@coco.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 11:20:34AM -0300, Mauro Carvalho Chehab wrote:
> Em Thu, 20 Jun 2019 14:54:13 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> 
> > On Thu, Jun 20, 2019 at 02:01:50PM +0200, Johan Hovold wrote:
> > > > I don't know when "Description" and "RST-Description" would be used.
> > > > Why not just parse "Description" like rst text and if things are "messy"
> > > > we fix them up as found, like you did with the ":" here?  It doesn't
> > > > have to be complex, we can always fix them up after-the-fact if new
> > > > stuff gets added that doesn't quite parse properly.
> > > > 
> > > > Just like we do for most kernel-doc formatting :)  
> > > 
> > > But kernel-doc has a documented format, which was sort of the point I
> > > was trying to make. If the new get_abi.pl scripts expects a colon I
> > > think it should be mentioned somewhere (e.g. Documentation/ABI/README).
> > > 
> > > Grepping for attribute entries in linux-next still reveals a number
> > > descriptions that still lack that colon and use varying formatting. More
> > > are bound to be added later, but perhaps that's ok depending on what
> > > you're aiming at here.  
> > 
> > I'm aiming for "good enough" to start with, and then we can work through
> > the exceptions.
> > 
> > But given that Mauro hasn't resent the script that does the conversion
> > of the files, I don't know if that will even matter... {hint}
> 
> It sounds I missed something... are you expecting a new version? 

Yes, the last round of patches didn't have a SPDX header on the script,
so I couldn't add it to the tree :(

thanks,

greg k-h
