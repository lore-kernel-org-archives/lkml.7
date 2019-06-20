Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26FEC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B4220679
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561040442;
	bh=SEe3n7FjxI5kRbQXaB6LQ1wMYZsE5oO3JDkdBCVx+I4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dz4oP0TjQ+S61G0Nqx+y47/asozx05k8eBCdyZ5Vczv/x5cBVSkoH71mC7Hr6sqx4
	 QCYlU9aEo5nWwLrwTgrgBgr8gxP1jdCA6b3Ek4zvpPYLev6muZHs60RCZKxLLt4k+s
	 l0iAbkB0KjPPSnTJuInHQdmLqRITHayZGpmfSu8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732085AbfFTOUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:20:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41286 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfFTOUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BwRBAuz4S+s3MY4Q44hTgBhxFBOF/+k626a03wrDmOo=; b=CR3aWFX3TkOOIaYVE/VHyTJlh
        Y8KjT8wQ1ZDscCTXgeamIkGCsZZ0FWFvKCVHkZjOtkK7GSpCmRE2retqdck/UmVohMIRM8LgVA+0g
        uBMGuBgkUlw+QgBxFkbMVd9dgZ5f3HaCxK187kQ3M/nSbkYcTcilmhmF1jFHjNcmhC5O7K7eZjK5a
        levepTfwOBuGYehSYdPrPIzMC/9joBLFFSmSr8yucahkSwq025TiN6xW93169GWyh/SuPyQFUTK24
        7aCUn4difJn9RDcI9nf4aVFJKicpTVLbRtQUCLsieCJXS+vwWkOYhBqankvu+vIYeiwOSXNkwEhre
        rQhkD0N4Q==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdxvb-000303-6i; Thu, 20 Jun 2019 14:20:39 +0000
Date:   Thu, 20 Jun 2019 11:20:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: Re: [PATCH 04/14] ABI: better identificate tables
Message-ID: <20190620112034.0d2be447@coco.lan>
In-Reply-To: <20190620125413.GA5170@kroah.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
        <6bc45c0d5d464d25d4d16eceac48a2f407166944.1560477540.git.mchehab+samsung@kernel.org>
        <20190619125135.GG25248@localhost>
        <20190619105633.7f7315a5@coco.lan>
        <20190619150207.GA19346@kroah.com>
        <20190620120150.GH6241@localhost>
        <20190620125413.GA5170@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 20 Jun 2019 14:54:13 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Thu, Jun 20, 2019 at 02:01:50PM +0200, Johan Hovold wrote:
> > > I don't know when "Description" and "RST-Description" would be used.
> > > Why not just parse "Description" like rst text and if things are "messy"
> > > we fix them up as found, like you did with the ":" here?  It doesn't
> > > have to be complex, we can always fix them up after-the-fact if new
> > > stuff gets added that doesn't quite parse properly.
> > > 
> > > Just like we do for most kernel-doc formatting :)  
> > 
> > But kernel-doc has a documented format, which was sort of the point I
> > was trying to make. If the new get_abi.pl scripts expects a colon I
> > think it should be mentioned somewhere (e.g. Documentation/ABI/README).
> > 
> > Grepping for attribute entries in linux-next still reveals a number
> > descriptions that still lack that colon and use varying formatting. More
> > are bound to be added later, but perhaps that's ok depending on what
> > you're aiming at here.  
> 
> I'm aiming for "good enough" to start with, and then we can work through
> the exceptions.
> 
> But given that Mauro hasn't resent the script that does the conversion
> of the files, I don't know if that will even matter... {hint}

It sounds I missed something... are you expecting a new version? 

If so, what changes are you expecting?

Thanks,
Mauro
