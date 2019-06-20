Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7F6C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840F62082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561035258;
	bh=mJIzkIy1IkKq1wkFs5xq4C9Jj7aUtzPtSq2EXZZcKIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aS1wIwY3LgHUGvdmy6S5Yd7EVreqNm96MqHLuuZ+QAxqesY5LjC3iYovAPFcu2L2p
	 qZCSeBXs+LHG5G5ubpa/QLO9fgfMklYkoOLeDcWGt5FNuEZeBMI6Qs7U0/UL6K+ktr
	 0e5vijPiGAY9Cf3lypqVGhXke+foEhoJRaYJ/w/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbfFTMyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbfFTMyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:54:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BD4D2080C;
        Thu, 20 Jun 2019 12:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561035256;
        bh=mJIzkIy1IkKq1wkFs5xq4C9Jj7aUtzPtSq2EXZZcKIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WE3TyVQ1U7WjKVqehsGQxiDSfN20lgka+ZYGMYm/MlYieOkq/O40ifRB2PjpQcHS4
         FujD8AVdsSG/qKJoGNlKzL5RK126UmH/KdPe41snhOXBQn+OF/+ZmkO/CTKfBtyRD8
         Ix529taM1ls7ywfQFdzJgXC7/ZP9Z2ZHOvEInXYc=
Date:   Thu, 20 Jun 2019 14:54:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: Re: [PATCH 04/14] ABI: better identificate tables
Message-ID: <20190620125413.GA5170@kroah.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
 <6bc45c0d5d464d25d4d16eceac48a2f407166944.1560477540.git.mchehab+samsung@kernel.org>
 <20190619125135.GG25248@localhost>
 <20190619105633.7f7315a5@coco.lan>
 <20190619150207.GA19346@kroah.com>
 <20190620120150.GH6241@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620120150.GH6241@localhost>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 02:01:50PM +0200, Johan Hovold wrote:
> > I don't know when "Description" and "RST-Description" would be used.
> > Why not just parse "Description" like rst text and if things are "messy"
> > we fix them up as found, like you did with the ":" here?  It doesn't
> > have to be complex, we can always fix them up after-the-fact if new
> > stuff gets added that doesn't quite parse properly.
> > 
> > Just like we do for most kernel-doc formatting :)
> 
> But kernel-doc has a documented format, which was sort of the point I
> was trying to make. If the new get_abi.pl scripts expects a colon I
> think it should be mentioned somewhere (e.g. Documentation/ABI/README).
> 
> Grepping for attribute entries in linux-next still reveals a number
> descriptions that still lack that colon and use varying formatting. More
> are bound to be added later, but perhaps that's ok depending on what
> you're aiming at here.

I'm aiming for "good enough" to start with, and then we can work through
the exceptions.

But given that Mauro hasn't resent the script that does the conversion
of the files, I don't know if that will even matter... {hint}

thanks,

greg k-h
