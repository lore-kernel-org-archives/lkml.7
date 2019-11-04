Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E925CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 20:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB87B20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 20:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572900400;
	bh=iId+7Mf9N878uMPp7QnhpaRhi2VZhgetrbRgL8S6wjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OxHYy/3K1vohphOkXiZ7NsReZ2sQN5VVp2qaa7x9J5EjAGENkm6o2t8iEPDocSzmW
	 wRyzVON1itMaC6B8O19W66NpsPHj4wQ/tB/P23ATEOyB9KR4SbFqvdKYSbkbJR/vtl
	 NfhNJtjwL8wLAsHRNKbPn4VSh671ilwMdkYzq4rE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfKDUqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 15:46:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728392AbfKDUqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 15:46:39 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E88F020679;
        Mon,  4 Nov 2019 20:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572900398;
        bh=iId+7Mf9N878uMPp7QnhpaRhi2VZhgetrbRgL8S6wjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0c3pb4MjyGgppSaUthsGGhz/HsDyOvxejGnjxLh0lmfgJKM8F4B1RDWenlNBmL01V
         c2jOzeb3e/ko2ZLd59fGrzNyXO7IsZWYJWHD9lPQfXjmHZSA5yzmGf+K5pWe2g+TDP
         jy3intsVPe2j9DXqSZTKPZg96odIi8vtrnaExJXU=
Date:   Mon, 4 Nov 2019 21:46:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: comedi: rewrite macro function with GNU
 extension typeof
Message-ID: <20191104204636.GA2359379@kroah.com>
References: <20191104163331.68173-1-jbi.octave@gmail.com>
 <84a2d50f-a1ac-bdc5-989c-b0294e9dea22@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84a2d50f-a1ac-bdc5-989c-b0294e9dea22@mev.co.uk>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 05:03:04PM +0000, Ian Abbott wrote:
> On 04/11/2019 16:33, Jules Irenge wrote:
> > Rewrite macro function with the GNU extension typeof
> > to remove a possible side-effects of MACRO argument reuse "x".
> >   - Problem could rise if arguments have different types
> > and different use though.
> > 
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > ---
> > v1 - had no full commit log message, with changes not intended to be in the patch
> > v2 - remove some changes not intended to be in this driver
> >       include note of a potential problem
> >   drivers/staging/comedi/comedi.h | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/comedi/comedi.h b/drivers/staging/comedi/comedi.h
> > index 09a940066c0e..a57691a2e8d8 100644
> > --- a/drivers/staging/comedi/comedi.h
> > +++ b/drivers/staging/comedi/comedi.h
> > @@ -1103,8 +1103,10 @@ enum ni_common_signal_names {
> >   /* *** END GLOBALLY-NAMED NI TERMINALS/SIGNALS *** */
> > -#define NI_USUAL_PFI_SELECT(x)	(((x) < 10) ? (0x1 + (x)) : (0xb + (x)))
> > -#define NI_USUAL_RTSI_SELECT(x)	(((x) < 7) ? (0xb + (x)) : 0x1b)
> > +#define NI_USUAL_PFI_SELECT(x)\
> > +	({typeof(x) x_ = (x); (x_ < 10) ? (0x1 + x_) : (0xb + x_); })
> > +#define NI_USUAL_RTSI_SELECT(x)\
> > +	({typeof(x) x_ = (x); (x_ < 7) ? (0xb + x_) : 0x1b; })
> >   /*
> >    * mode bits for NI general-purpose counters, set with
> > 
> 
> I wasn't sure about this the first time around due to the use of GNU
> extensions in uapi header files, but I see there are a few, rare instances
> of this GNU extension elsewhere in other uapi headers (mainly in netfilter
> stuff), so I guess it's OK.  However, it  does mean that user code that uses
> these macros will no longer compile unless GNU extensions are enabled.
> 
> Does anyone know any "best practices" regarding use of GNU extensions in
> user header files under Linux?

We try to never do it if at all possible :)

thanks,

greg k-h
