Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD18FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17832084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554322085;
	bh=wLZvqLFb2mqbCiNkhhfs9ysDj66aLkShU9dTVSCzsUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XpIGGrP2/lRvqumUV7X4BayG+F6Aybk2HjPPBlc8VQim6X+vLPJvrV8i0rug33iVQ
	 fDTBOvhtOU2Ahio5siQZ8y8BmTCBI/PVFlAq+lOOhbenQtoF7BiGp/fhFihcSfk93+
	 BjIzYZ7GBMfBxoI17mj7qVxOZ0pn8Y3NLJuZJabY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfDCUIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:08:04 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:45381 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDCUID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:08:03 -0400
Received: by mail-ot1-f54.google.com with SMTP id e5so133323otk.12;
        Wed, 03 Apr 2019 13:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uHKSmpJ6TEB5Q5rJL9DUphvSnMeX0tQN907vAl1IddE=;
        b=hvLHTcuAgVVOsICWnJiewXBqX8y7qnB7xDPF/YK2mYjqXlXKppWDoRp1lR93bjbrRU
         WwcxuImNhdRW4/Qr8XY7UkatMC2hih0JXYnUelM6QXgJZtbz50KlHV2LC9moC7yg8bg6
         KTKNLwZLAj9XPCNjBE45Xga53VxQBT64uVcuQezzmbfHLffAJQXEPpBj7LYsQYSK/zz2
         pSPa++zn8CeQmuThXX/Ch1GlASxitYzLxV35oOb5hAYYLdgv6dhT8lIIr20dh6oC96TV
         P4KLQNgJBUOedkQRy+26gzzD/JCC+FUklAl/BDzXNxFua2fLem/PqAhT5jotD2qo7pPS
         160Q==
X-Gm-Message-State: APjAAAXCBeCt99t5ZPWGjIXWQm8Yz6N7S6eb8ohMIz7JHspt6tC/GoV+
        yZm+tANB3vQ/bkxc99c0QRM=
X-Google-Smtp-Source: APXvYqxNZDUZaOrTjZ05D/QrtkgIbNst4LSaq/eB0gnXEu84xRycUpiIo6WBqP5GHbcu8yNDu8JrZw==
X-Received: by 2002:a9d:600d:: with SMTP id h13mr1326807otj.114.1554322082589;
        Wed, 03 Apr 2019 13:08:02 -0700 (PDT)
Received: from localhost ([130.164.62.212])
        by smtp.gmail.com with ESMTPSA id m124sm7111978oia.3.2019.04.03.13.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 13:08:01 -0700 (PDT)
Date:   Wed, 3 Apr 2019 13:08:00 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Richard Gong <richard.gong@linux.intel.com>,
        linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1] fpga: mgr: add FPGA configuration log
Message-ID: <20190403200800.GE5752@archbook>
References: <1554243943-25507-1-git-send-email-richard.gong@linux.intel.com>
 <20190403142022.GB5752@archbook>
 <ee94981a-6562-9d26-ddc2-967596589599@linux.intel.com>
 <20190403164742.GC5752@archbook>
 <CANk1AXSoF3bhiO=t-XJRLhBH20emWYaZ+2LCPtqJsKyh4b+9KQ@mail.gmail.com>
 <CANk1AXSJ31Q7X3J6NOsqVkQoJkjJz=xka0XiWvuYC36s1HiBuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXSJ31Q7X3J6NOsqVkQoJkjJz=xka0XiWvuYC36s1HiBuA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 01:37:51PM -0500, Alan Tull wrote:
> >
> > it's state, not status for most fpga manager drivers.  It should
> > return 'operating' if everything went well.

Yeah, sorry :)

> > It seems like there's a possible scenario where the FPGA starts up
> > with the FPGA in 'operating' mode and the user messes up early enough
> > that the state doesn't change.

Huh, then we should fix that instead? :)
> >
> > >
> > > Personally not in favor of extra messages, but if we do it we should
> > > change the message to "Sucessfully programmed FPGA".
> > >
> > > I think making it a dbg message is a good trade-off ...
> 
> dbg vs info... On the one hand, it is a usually a message the
> developer wants to see so the developer would turn on debug messages.
> But then again FPGA programming doesn't happen that often and it is a
> kind of significant event since it is your hardware changing i.e. it
> won't add a lot messages, but it is sort of an important one if it
> happens.   If the system crashes after a FPGA reprogramming event, it
> would be good to have this in the log by default.  I don't want to
> argue too powerfully for adding extra messages though.  Is this a case
> where info is worth it since fpga programming is significant?

In the current setup, it doesn't happen often. Going forward people
might have use-cases where this happens a lot more often.

I mean if y'all feel like this is required, sure, I still feel people
shouldn't rely on dmesg output for functional verification :)

I don't wanna guarantee that this message is gonna be there always ...

Cheers,
Moritz
