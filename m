Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16640C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6B320652
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="FoZ6oWrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfDSS1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:27:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39571 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfDSS1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:27:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id k45so5014352edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bS374I4hPReV+cSBidVrGvimZy2xqRhn0k6zGoOa+pQ=;
        b=FoZ6oWrwMT/zSRDSDi+xaJA8g5jMq9Gsuky/kXsiqzZNifi2k3EvEE2X+TejDOWmOM
         Qo/6qKPeO2YRqvzQQFx0+Ah5O4pWKmNCUTU0F3K94ZGQn4X7WPR/Cf97RAqFfodMdqmV
         KVlTQZYXU7fTM7EVgYNYvtqea8JIKPWJfM45qw0Rd2azH6Ip97kkviaj7oERkTyAndp7
         0pHWwbIMhQy/sCkSeKtw6uuXZcp1FwHcZTv6nq4x1/bSR9z0RbGpcd5lr2irUhcFyU2n
         AL5vUDsxsIQK7zXopZ9FhDkPSHUoyhtsWH6hWaZLajhRSLwOwRwLD4yd+s+p94m2/fyq
         8SvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bS374I4hPReV+cSBidVrGvimZy2xqRhn0k6zGoOa+pQ=;
        b=pokGCk+lN7ImYPlLOcM/aukGNbejwKt84AGbc0WrcSK/FFHy3CPgdDvu0HZWHn+MEb
         SxI/EmAb0UNUurVxhwQMxkLr6h/KBQsb1MxxIhOWI8UhgeXNC03k5iT6kX+oRSWQVz+J
         EUouw4HRTWY5X53csMGRyQGkvLB0Z949ybzLxk+aMUGzaMNW46dNzViNN+vNC2QIEeaN
         tVcqcdWZrVFxlL7Q9bboVD6xJHOUGXUGOhRZWQWfDhwCEVAeTvr0AYcDyUvKOEAP5BSn
         702O6qnC3Qybzws5u0BekgyE9auUIwdF2dUe2qrxIy3h8V3jDS3uQ0bqU3JOOclGDqNx
         pHog==
X-Gm-Message-State: APjAAAWDyb4S6jvalrZdoeePXRezUF0RLcMltztvpaKDTO4UP5ADcy6j
        I8Dbtv6aYHhK5MQCyw9iJguaZg==
X-Google-Smtp-Source: APXvYqyyorbSn8tpSPBHy9H8C+EuyCsQYLgCgiTWNJ0Wj0WzdNlJGiQG5DKRx6AYMIgr7SZnofOPuQ==
X-Received: by 2002:aa7:dada:: with SMTP id x26mr3017038eds.77.1555691896200;
        Fri, 19 Apr 2019 09:38:16 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id g10sm954517ejb.50.2019.04.19.09.38.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Apr 2019 09:38:15 -0700 (PDT)
Date:   Fri, 19 Apr 2019 18:38:14 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com, luto@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        tglx@linutronix.de, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        joel@joelfernandes.org, dancol@google.com,
        Jann Horn <jann@thejh.net>
Subject: Re: [PATCH v3 4/4] samples: show race-free pidfd metadata access
Message-ID: <20190419163813.okgqwmzahnt24vtm@brauner.io>
References: <20190419120904.27502-1-christian@brauner.io>
 <20190419120904.27502-5-christian@brauner.io>
 <20190419153047.GA12228@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190419153047.GA12228@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 05:30:48PM +0200, Oleg Nesterov wrote:
> On 04/19, Christian Brauner wrote:
> >
> > +int main(int argc, char *argv[])
> > +{
> > +	int ret = EXIT_FAILURE;
> > +	char buf[4096] = { 0 };
> > +	pid_t pid;
> > +	int pidfd, procfd, statusfd;
> 
> I think you need to initialize pidfd = 0 in this version ;) Otherwise,

Yes, you are right. Seems I got saved by the compiler since I compile a
kernel and run a test even when i just change the commit message. :)
Will fix that up and add your Reviewed-by but I think I spare everyone
a v4 for this if that's ok.

> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Thank you!
Christian
