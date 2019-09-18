Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B04C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EB2218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787406;
	bh=Yrmf/8Q3o0dao3sNh0zfCYToe0BxGZHFhPymplQQt+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wUkvi9jwvH0RJI4amRsDfT/vGe5Kfac9/G+QOdJ0rAF1ptkhkew11egsEDirvMnGL
	 4YMD4z5gfaVSoG00Jj0UPdtNZr3+J9AjvaNort4YxdNJgJP0NEsAe2yDtYdKNWaZGa
	 wx+iitc0eQ7TjT2yUbbu7nUZBmogX52Q7p6FT9F0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfIRGQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbfIRGQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:16:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7426720678;
        Wed, 18 Sep 2019 06:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787405;
        bh=Yrmf/8Q3o0dao3sNh0zfCYToe0BxGZHFhPymplQQt+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1qpbCEyJTkKm/RO046p3/FT3nK06iQwI4utc74tQk7NLDvxMdvZLnClPyyo8QzMJK
         AUUgSre9MPD4niFi+Nck1MUT/iMXtYgUWVK3Z/+CMcu1jos6ppVbsiYZqevZf4PKj+
         0/zmLhDf6kqERoF8UgLORf8BZU3wBDk1N97AKiFQ=
Date:   Wed, 18 Sep 2019 08:16:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gregory Nowak <greg@gregn.net>
Cc:     devel@driverdev.osuosl.org,
        Simon Dickson <simonhdickson@gmail.com>,
        "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>, linux-kernel@vger.kernel.org,
        John Covici <covici@ccs.covici.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        okash.khawaja@gmail.com
Subject: Re: [HELP REQUESTED from the community] Was: Staging status of
 speakup
Message-ID: <20190918061642.GB1832786@kroah.com>
References: <CAOtcWM0Jzo+wew-uiOmde+eZXEWZ310L8wXscWjJv5OXqXJe6Q@mail.gmail.com>
 <20190909025429.GA4144@gregn.net>
 <CAOtcWM0P=w-iBZzwekVrSpp7t2WO9RA5WP956zgDrNKvzA+4ZA@mail.gmail.com>
 <20190915134300.GA552892@kroah.com>
 <CAOtcWM2MD-Z1tg7gdgzrXiv7y62JrV7eHnTgXpv-LFW7zRApjg@mail.gmail.com>
 <20190916134727.4gi6rvz4sm6znrqc@function>
 <20190916141100.GA1595107@kroah.com>
 <20190916223848.GA8679@gregn.net>
 <20190917080118.GC2075173@kroah.com>
 <20190918010351.GA10455@gregn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918010351.GA10455@gregn.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 06:03:53PM -0700, Gregory Nowak wrote:
> On Tue, Sep 17, 2019 at 10:01:18AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Sep 16, 2019 at 03:38:48PM -0700, Gregory Nowak wrote:
> > > On Mon, Sep 16, 2019 at 04:11:00PM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Sep 16, 2019 at 03:47:28PM +0200, Samuel Thibault wrote:
> > > > > Okash Khawaja, le dim. 15 sept. 2019 19:41:30 +0100, a ecrit:
> > > > > > I have attached the descriptions.
> > > > > 
> > > > > Attachment is missing :)
> > > > 
> > > > I saw it :)
> > > > 
> > > > Anyway, please put the Description: lines without a blank after that,
> > > > with the description text starting on that same line.
> > > > 
> > > > thanks!
> > > > 
> > > > greg k-h
> > > 
> > > It's attached. Hope the indentation is OK.
> > 
> > Alignment is a bit off, you forgot a tab after "Description:"
> > 
> > And you have some trailing whitespace in the document :(
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> I put in the tabs after "Description:" and did the best I could to fix
> the alignment, and to find and get rid of the white space. If the
> alignment is still off, or if there is still white space I missed,
> could someone else please correct that? Thanks.

Extra line between each attribute (before the "What:" line) would be
nice.

Also fixing the TODO items :)

thanks,

greg k-h
