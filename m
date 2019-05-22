Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47CFC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 11:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D6B217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 11:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tiq6Kw58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfEVLZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 07:25:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45015 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbfEVLZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 07:25:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id g9so1161871pfo.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 04:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zHCtr3ee893RWzC1W/JdFH2wk8+X49KQQGHhnWLjYbA=;
        b=tiq6Kw58v16c0abfIgnJxwi3MeVuRMAaDpqP1hu30YBxtNu2eC/WUc9s2sP8T40H4y
         0iHve+UworKGHm0/Mbt0MvbN35ubpc//WF423gTzUTmPaOuHA5MIDmr+ckJpoPhKLGkF
         uBCfEWM7CCBWFsOFtD684ORXtWn28N2TC1Y0xzXX/zGL2SbOIh5MoRO5GKOkCLu+eDaV
         oyPwZELyiPZtAVQ/BifaKPKcIjhWdxIegjCwNPtwDYQchvvJJrBVaZ56A5hn+tEogqXM
         JKXfy2I+RIYnxkzc5AC9qVV6jiy6bsORIyM7g488q6qdcUD5B7ok7VKP+HvPPEFK/fd7
         B94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zHCtr3ee893RWzC1W/JdFH2wk8+X49KQQGHhnWLjYbA=;
        b=rDlMt2JtfDVypAfwnkv1bjWz9pvvAmuEJx4WIIfnB3bxLwrD+ITlkX3ttOEKSz0wrf
         E24RficSLMbuysPhYYy9SGFOlFwMm/I2dYMgMqMOITHt6uAmTN/I1FCEvDgQgfCClWB7
         Q2bqsGLN+zbv7XZqJGlOQhj919u5r82lSHdvxP/tI60x5DOxv7Etco63i6vAhJHJz0N0
         3dZRDbc4WtrjHtNgfVDHmuxV91RanjPwNGFYHDanJOCJHclY04WaAg33OlI6CASpo/cT
         rweg578WUGSzVzGf8qW96C2dZpif4meZ/B0U+GTC3oUT+aBjJdLC1cWfQaISfG1pLvPf
         9nwg==
X-Gm-Message-State: APjAAAXrxMpUR5jvgyg0Obh6vopO7sQWolMxCvEfCvWSQgjyBjTgLlYV
        WP0z357SWKgPEIe9c3pfXXpt6Ok7AjAlbA==
X-Google-Smtp-Source: APXvYqx0QGnTATPGJ3rt836ixiWDcvxDqlghfFIHzST/TjgpjKdboa4Jp7tbQ8YUgco6Uo2GaTrNtw==
X-Received: by 2002:a62:4ed8:: with SMTP id c207mr96137226pfb.241.1558524301587;
        Wed, 22 May 2019 04:25:01 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id z4sm29240765pfa.142.2019.05.22.04.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 04:25:00 -0700 (PDT)
Date:   Wed, 22 May 2019 19:24:49 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty_io: Fix a missing-check bug in drivers/tty/tty_io.c
Message-ID: <20190522112449.GA6666@zhanggen-UX430UQ>
References: <20190522014006.GB4093@zhanggen-UX430UQ>
 <abc68141-df99-1ae1-ea51-c83bd4480d92@suse.cz>
 <20190522080656.GA5109@zhanggen-UX430UQ>
 <3a3db304-9725-6a90-65ac-dff09ef31aae@suse.cz>
 <20190522102900.GC2200@localhost>
 <20190522111354.GA5849@zhanggen-UX430UQ>
 <20190522111949.GB568@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522111949.GB568@localhost>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 01:19:49PM +0200, Johan Hovold wrote:
> On Wed, May 22, 2019 at 07:13:54PM +0800, Gen Zhang wrote:
> > On Wed, May 22, 2019 at 12:29:00PM +0200, Johan Hovold wrote:
> > > Where do you see that the kernel is dereferencing tty->dev without
> > > checking for NULL first? If you can find that, then that would indeed be
> > > a bug that needs fixing.
> > Thanks for your reply, Johan!
> > I examined the code but failed to find this situation.
> 
> Ok, so your claim in the commit message was incorrect:
> 
> 	And tty->dev is dereferenced in the following codes.
> 
> > Anyway, checking return value of tty_get_device() is theoritically
> > right. But tty->dev is never dereferenced, so checking is not needed.
> 
> No, sorry, it's not even theoretically correct. Our current code depends
> on tty->dev sometimes being NULL. Your patch would specifically break
> pseudo terminals.
Thanks for your comments. I have to be very proficient in this module
to know this. Of course I am not.
Anyway, appreciate your replies, Johan.
Thanks
Gen
> 
> > However, what if in later kernels tty->dev is dereferenced by some
> > codes? Is it better to apply this check for this reason?
> 
> So for the above reason, no.
> 
> Johan
