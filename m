Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E75C46470
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35D826233
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="Is1zd4SD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfE3V6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 17:58:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41465 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfE3V6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:58:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id s57so8974315qte.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 14:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xUrEWzZQfNW3Ko2ZWNLxImFggBKxzmBgkihSD1gWgW0=;
        b=Is1zd4SDvd6ZWvtvAYJ67dlcwr8V/61dT3N1tlUOkcZwnsfMcEtreN/4wMWHgkijuJ
         fehIbSV7QgKzRoi8VwUd0W3WoXvOqExCo54m3DUWvZUS4I4JGGA9nNtGyMoFCaqPHUhd
         VxlWr6suY3YYkFaNBvaCCLAgcx4fsNiUjFNkmboSgvURicz+xVee3x2fjbJ/RZaI0fXc
         di/c6A8CiJ9tE3erznkf1k+x25DEYKFnKRAqv7OCt9cZkE4Yo9/znC9IX8mfIklKs7yd
         Gkn4IjHNQ5rZvpyrDAC5jDFha3I65uww7VBZkCmusfLq9q94+NHvcaB9Kal9s6v3VSuv
         Rtdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xUrEWzZQfNW3Ko2ZWNLxImFggBKxzmBgkihSD1gWgW0=;
        b=ZMGD8B51fF7iqrb04/y3f/B0DpUaxP3c+38RiocmGjLB1l7J3No/e390XG0+iVkIqY
         y8JGUFNg6iH+q2nw9EzDvOrLhnqumyerDO6ywDXYB1Jb37er57sPjATwcgGxbAnNMgmS
         CHfqSNYLQRapyTugVHDR2QGji0oMYUYoTbEsBHnNqtwESiB25XXny73PLMemtXeQUI5k
         +gOqnhKqxgwmvz2rsVbWHn0G9dMeWtCR+F7olaNdgapaNW8LOkkdZQYPddSCULZi6O0G
         Z18PNBUg2Ck0kjOt4Nc9A3mQIByelBnZd5stSecjxa7D8cA4VhnAzXyvwaokSHuOAZk7
         jvSw==
X-Gm-Message-State: APjAAAUzIdUCl4Ia5zCxO5o0NrJfOxCffHUToSrmHgQtXOwSBnAmA6xr
        tvipQdfWGYbjVNDskfs/dzPl3g==
X-Google-Smtp-Source: APXvYqw3Gbiesdzd/yRAh8ImxVsYAztosD/Dz/fx+HhBvOt45z0S/5LhH2Nn++H9E2AwV5xsyZZVcQ==
X-Received: by 2002:aed:39e5:: with SMTP id m92mr5818400qte.106.1559251744607;
        Thu, 30 May 2019 14:29:04 -0700 (PDT)
Received: from cisco ([2601:280:6:ca14:840:fa90:7243:7032])
        by smtp.gmail.com with ESMTPSA id d5sm1904111qtj.3.2019.05.30.14.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 14:29:03 -0700 (PDT)
Date:   Thu, 30 May 2019 15:29:00 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        ebiederm@xmission.com, nhorman@tuxdriver.com
Subject: Re: [PATCH ghak90 V6 02/10] audit: add container id
Message-ID: <20190530212900.GC5739@cisco>
References: <cover.1554732921.git.rgb@redhat.com>
 <9edad39c40671fb53f28d76862304cc2647029c6.1554732921.git.rgb@redhat.com>
 <20190529145742.GA8959@cisco>
 <CAHC9VhR4fudQanvZGYWMvCf7k2CU3q7e7n1Pi7hzC3v_zpVEdw@mail.gmail.com>
 <20190529153427.GB8959@cisco>
 <CAHC9VhSF3AjErX37+eeusJ7+XRw8yuPsmqBTRwc9EVoRBh_3Tw@mail.gmail.com>
 <20190529222835.GD8959@cisco>
 <CAHC9VhRS66VGtug3fq3RTGHDvfGmBJG6yRJ+iMxm3cxnNF-zJw@mail.gmail.com>
 <20190530170913.GA16722@mail.hallyn.com>
 <CAHC9VhThLiQzGYRUWmSuVfOC6QCDmA75BDB7Eg7V8HX4x7ymQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhThLiQzGYRUWmSuVfOC6QCDmA75BDB7Eg7V8HX4x7ymQg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 03:29:32PM -0400, Paul Moore wrote:
> 
> [REMINDER: It is an "*audit* container ID" and not a general
> "container ID" ;)  Smiley aside, I'm not kidding about that part.]

This sort of seems like a distinction without a difference; presumably
audit is going to want to differentiate between everything that people
in userspace call a container. So you'll have to support all this
insanity anyway, even if it's "not a container ID".

> I'm not interested in supporting/merging something that isn't useful;
> if this doesn't work for your use case then we need to figure out what
> would work.  It sounds like nested containers are much more common in
> the lxc world, can you elaborate a bit more on this?
> 
> As far as the possible solutions you mention above, I'm not sure I
> like the per-userns audit container IDs, I'd much rather just emit the
> necessary tracking information via the audit record stream and let the
> log analysis tools figure it out.  However, the bigger question is how
> to limit (re)setting the audit container ID when you are in a non-init
> userns.  For reasons already mentioned, using capable() is a non
> starter for everything but the initial userns, and using ns_capable()
> is equally poor as it essentially allows any userns the ability to
> munge it's audit container ID (obviously not good).  It appears we
> need a different method for controlling access to the audit container
> ID.

One option would be to make it a string, and have it be append only.
That should be safe with no checks.

I know there was a long thread about what type to make this thing. I
think you could accomplish the append-only-ness with a u64 if you had
some rule about only allowing setting lower order bits than those that
are already set. With 4 bits for simplicity:

1100         # initial container id
1100 -> 1011 # not allowed
1100 -> 1101 # allowed, but now 1101 is set in stone since there are
             # no lower order bits left

There are probably fancier ways to do it if you actually understand
math :)

Since userns nesting is limited to 32 levels (right now, IIRC), and
you have 64 bits, this might be reasonable. You could just teach
container engines to use the first say N bits for themselves, with a 1
bit for the barrier at the end.

Tycho
