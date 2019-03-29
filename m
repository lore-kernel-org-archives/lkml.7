Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC58C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68852184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="N0gav9mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfC2SsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:48:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34031 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbfC2SsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:48:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id k2so3821618qtm.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 11:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=wQJp2D0eARfAvHvIzZAZmPot69GknE3LXgkSCOalxFg=;
        b=N0gav9mzHvRSsg4CrpxotXTEkLKc1PG+t14dj7Lp64/TlEo4pG/mhiNDXv+011eIvi
         kxbGh7QZEbEARwEZGzauCsszbkJQ6E9wih9e0R6BPvA5ZNg0V7Ysg1y3M/S6ELsoQJWK
         9kF2ddrTGzQgFK+zePbtWz68Xs0CtSkPaRwKljXYqYNWF1iQoJtVXYOyFzg6NaDJLDaL
         kgmUc1GJyLKHESoUP1kKr8Wa3OW6KOjXximqcDBMAZO2ALm7xSEQSRw7iuhoAWJo1D4C
         ePoqTfhGmI64mP9cNt8IAoyEYSUgacfpkTN4xqPAQ4J2unZKtB0MnYhVplom2LxyFAq/
         NMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=wQJp2D0eARfAvHvIzZAZmPot69GknE3LXgkSCOalxFg=;
        b=lgBTROGBxlsq1WMRa8jsncxiwjR0OEq+V+2enNLF6xXjUWdoIpQsveiVkly6wLkYFm
         XT4OQ46BrKqgJdsW0vYdFScugyDE9oN+7vJgKEcZsjTOQkvb2EsE76S3NZ9VIuRLHQb4
         8S1FV29a0OkmSM+F+gMa1mgU293NtCYI/mt00nWLPpFAcVShP7oG4T4CNdzlnA9rKdIX
         vvM8CjD5eA36deYzvvE6dPwuY5Y2GD8WVYrnJeF6G4FhX/XdXDHroVk74FULdgQm9Z+R
         H1KfEHZrckOyKb71n+8oKHgCKsZEtuzVeiJm43OTgcme9dwlkQHZH7Q3a45jCvfoneSJ
         c1KQ==
X-Gm-Message-State: APjAAAWfD5vJj2JFVm88vN3DuwOv+lGG1SHDUcZr1s3fKRD6OJCjuX8D
        rnwgXXUbVvucGu3FwBngEJ8r4A==
X-Google-Smtp-Source: APXvYqwgsJH+/WW1tujlHYu/y19umlNMkVZIoLyXs2y9YAkYb1nG/9EIJeAnF51Wjyv+m5AKq11e8A==
X-Received: by 2002:ac8:170d:: with SMTP id w13mr41450399qtj.220.1553885302048;
        Fri, 29 Mar 2019 11:48:22 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id f189sm1522854qkb.79.2019.03.29.11.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 11:48:21 -0700 (PDT)
Date:   Fri, 29 Mar 2019 11:48:17 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Jiri Pirko <jiri@resnulli.us>, David Miller <davem@davemloft.net>,
        netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 13/22] ethtool: provide driver/device
 information in GET_INFO request
Message-ID: <20190329114817.414318a0@cakuba.netronome.com>
In-Reply-To: <20190328224618.GJ26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
        <b7aea4b2642b2fe6f12cfb843a03154f584f3bf6.1553532199.git.mkubecek@suse.cz>
        <20190327201411.GH14297@nanopsycho>
        <20190327222554.GV26076@unicorn.suse.cz>
        <20190328092126.GL14297@nanopsycho>
        <20190328095347.GB26076@unicorn.suse.cz>
        <20190328163439.GP14297@nanopsycho>
        <20190328130904.48905338@cakuba.netronome.com>
        <20190328224618.GJ26076@unicorn.suse.cz>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 23:46:18 +0100, Michal Kubecek wrote:
> On Thu, Mar 28, 2019 at 01:09:04PM -0700, Jakub Kicinski wrote:
> > On Thu, 28 Mar 2019 17:34:39 +0100, Jiri Pirko wrote:  
> > > Thu, Mar 28, 2019 at 10:53:47AM CET, mkubecek@suse.cz wrote:  
> > > >On Thu, Mar 28, 2019 at 10:21:26AM +0100, Jiri Pirko wrote:    
> > > >> Wed, Mar 27, 2019 at 11:25:54PM CET, mkubecek@suse.cz wrote:    
> > > >> >
> > > >> >I'm all for implementing new features which are are related to physical
> > > >> >device (ASIC) rather than network interface only in devlink (at the
> > > >> >level of kernel-userspace interface). But for features already provided
> > > >> >by ethtool (userspace utility) I can't help seeing the state of devlink
> > > >> >support in NIC drivers as a serious blocker.    
> > > >> 
> > > >> What I'm thinking about at for some time now would be en explicit
> > > >> default devlink and devlink_port registration for every netdev for
> > > >> drivers that does not support devlink themselves. I need to think about
> > > >> it more, but it seems doable. Then we can hang appropriate things there
> > > >> and make the ethtoolnl/devlink separation clear. I believe we need to do
> > > >> it.    
> > > >
> > > >That sounds great, such "generic devlink" implementation would be a way
> > > >around. Kernel could then emulate features which are not implemented by
> > > >an actual devlink handler (i.e. "generic devlink" is used or particular
> > > >handler is missing) by falling back to ethtool_ops handler so that
> > > >userspace could rely on devlink API for things like device information,
> > > >various dumps, flashing etc. without losing anything.    
> > > 
> > > Yep. Plan to do that next week.  
> > 
> > The problem with the main part of dev info - fw_version - is that it is
> > often overloaded in drivers and becomes impossible to parse for users.
> > I'd rather we didn't dump that nasty chaos in devlink info and let it
> > die with ethtool IOCTL.  
> 
> If I understand you correctly, what you are suggesting would result in
> "ethtool -i" through netlink not showing firmware version for NICs
> without actual devlink implementation (which is vast majority of NICs at
> the moment). I'm afraid doing that would make sure ioctl ethtool
> wouldn't die any time soon.

I was trying to say that'd be opposed to showing the conglomerate
fw_version from ethtool in devlink.  I'm not opposed to showing it 
in ethnl or having ethnl call into devlink to produce the conglomerate,
but I'd rather not see the legacy of ethtool creeping back into devlink.

> > Flashing can also be handled at user space tool level.  
> 
> I'm not sure how to understand this.

If we want ethnl user space command to provide flashing, it can just
send a devlink CMD behind the scenes.
