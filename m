Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED54C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253FA214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555608578;
	bh=Vuj0+PqqRe/jlT1t9CTdBgrY2kmDg7/e0+LZ4gRkkeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=chFjP6U+UmEOW/DGOrATO16kSQkep44OumStjzJhLCKGQPpPc4mPKW3Mnuk5hvZvx
	 F5wRyVsoYjwq7VwKekXjA4uXw3lnA2hapAKwSz+ROjKHL8OtsPxjTHP0C3O1g+f/lO
	 qcl1iWbfB3HES7MEpqsgIjDPYf4Z53xU1YJenmb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389730AbfDRR3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:29:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46531 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbfDRR3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:29:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so2571070ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 10:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YmhsJEoMQ7O7UhLq8QSTaOrSH/bZp40uxbN6BHWWNr0=;
        b=UGuLulboTYQEjS/Ciy++8yZxkk06N9LgwABGq73yPHR8a4HZghtA3lleHAr5Nz1QiU
         O2RP1dzE8S0JuxqmjBEN5wIX2l8bbIqpwj2WzHzadE9m4sp2T2rjE5xkNNJ7uD0VDoHi
         nJwQzGEXAEWfIicJIpo9p5CNeqig8ONazGjA4Y8hieJ1T0P3Nvbsura06ESYkiyBUUKM
         PSv9FfQXkkoJGHxozek2u8BSv+EKCaiUgaQo8dzPJLYvm3EPBbbPs2d26KbTwwdSitu4
         csHRNX/nArpIyCXc1T8ge9Y0pYYwc00jEOwMuI0TCWqPHxcvwIhDBxZJZGWdWOUpEgVu
         gtEw==
X-Gm-Message-State: APjAAAWgwQHhjthltIm3QxCJZ65r3/z8PS7lQ3GB8SGprfE2VrwYYc9L
        ZZriC3vyx7Ay/G9A8hXBcT4=
X-Google-Smtp-Source: APXvYqw2jfaKbPowgTt5aFDdiIZxKPMxEvsnvInRSWZND0QS0k2arzWpbPP4mP4edW3pQyAkPRvCaQ==
X-Received: by 2002:a2e:864f:: with SMTP id i15mr4431249ljj.99.1555608574417;
        Thu, 18 Apr 2019 10:29:34 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id t23sm537351ljc.13.2019.04.18.10.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 10:29:33 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hHAr1-0006ar-3T; Thu, 18 Apr 2019 19:29:43 +0200
Date:   Thu, 18 Apr 2019 19:29:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH v3 2/5] soundwire: fix style issues
Message-ID: <20190418172943.GC28269@localhost>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
 <20190414095839.GG28103@vkoul-mobl>
 <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
 <20190417093354.GL775@localhost>
 <200c8e66-4245-967b-b80e-b6f6a63f80c5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200c8e66-4245-967b-b80e-b6f6a63f80c5@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 12:18:22PM -0500, Pierre-Louis Bossart wrote:
> 
> >>>> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> >>>> index 19c8efb9a5ee..84876a74874f 100644
> >>>> --- a/drivers/soundwire/Kconfig
> >>>> +++ b/drivers/soundwire/Kconfig
> >>>> @@ -4,7 +4,7 @@
> >>>>    
> >>>>    menuconfig SOUNDWIRE
> >>>>    	bool "SoundWire support"
> >>>> -	---help---
> >>>> +	help
> >>>
> >>> Not sure if this is a style issue, kernel seems to have 2990 instances
> >>> of this!
> >>
> >> this is reported by checkpatch.pl --strict.
> > 
> > Please don't run checkpatch on code that's already in the kernel, and
> > especially not with the --strict (a.k.a. --subjective) option enabled.
> > 
> > Don't try to fix what isn't broken.
> 
> I would agree in general, but this case is different: the SoundWire code 
> in the upstream kernel is missing parts left and right and isn't fully 
> functional as is. I will soon be posting what's missing, so this cleanup 
> is an opportunity to bring SoundWire to the latest coding standards 
> before adding the missing pieces which will be compliant with --strict. 
> For the record using --strict already exposed 3 major issues in the 
> yet-to-be-released code, so it's not as subjective as you describe it.

It's not just me calling it subjective; --subjective is literally
another name for the same switch which enables checks that are
specifically *not* part of the coding standard.

By all my means use it on your own patches before you submit them if
you agree with all or some of those checks, but I doubt all that
open-parenthesis re-alignment is going to expose any major issues. ;)

It does add noise, and makes code forensic and backports harder though.

Johan 
