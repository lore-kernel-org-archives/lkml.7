Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4505C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A91218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bY4Til4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbfDXPXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:23:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36682 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730834AbfDXPXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:23:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id b1so14403750wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+cBgF/gjELKIQRS2aft5rWhJUtq8IN8s1bpX+AMfNMA=;
        b=bY4Til4viTb6wSpT4OlYv4QpI9Se07j4RdOTQZ+avLco0Rph+7Af0PlmfZXbwLAfyT
         ZOL4d5Vt8bUNwHyq+Ku8IneIgtUAYuXaJLmE0xYR3NqyxOhWMTm+sn+pDYO5EmguF8wY
         pD1iPPdevBVLO4C9+pSWVI73Nqqk2+HIulVS9dmjSsErOsLBR8rDSqdMeteBXNj+xVG+
         cL401vx5JSPn6BUajU7mZbyxy31Qt1DDGLybvLTI1Sit+PZKomqSV63QMJinSkvNYJHb
         jjnP9hLtnLXbJa3RFOkZwBe69++X8Valj/u4q/gqW3LWrcehcjFCEzPeO5kCkMC4W0ct
         qSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+cBgF/gjELKIQRS2aft5rWhJUtq8IN8s1bpX+AMfNMA=;
        b=EcMNWZP7Ro3KT+EPsd8ijUCxZ27W79Ha0C9mGp3jVZwEySMLRQA5HrJzDJIvlE/scI
         RqBTCNr9MxowRDQpTE3GD7Oau/D9GXOrl0pvWoJNsgcHuxe7DMJGrVWqq+h321ZvEiJa
         1DJzoppwWn3/PZ6JPhRjiuK5mF/Yb/Xbho9uOpbaBxxcm7kJyzgwtoMXtKwBMI0QA8N8
         AkLXNevyajFGoPU43PHd5zOjax/wI/QWv5oVkIEjI1vVCbrpHSU6U+kOlK1Lj4qkp9Sl
         UZyNzMXiFE5XoAk9oe+1UVGj6KbsYLy3Gz8CK9QaciAdXmztMJlzhp6uXEOgRWjA3dru
         u5wA==
X-Gm-Message-State: APjAAAWeJHuOgP9p3RYWNS1ZhGpLs8vd+UtsWveV94OciZS2tamOuvn0
        ejHBBbyqXu/R3XNXPG7045u/Uw==
X-Google-Smtp-Source: APXvYqxiG3iLBKTEY4ulOkjoyONgTuKs542ywpnmlXIO7LvwhLf5eP2oawL9c8uwaZMk6sFX2rEu7A==
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr12785628wrv.79.1556119387967;
        Wed, 24 Apr 2019 08:23:07 -0700 (PDT)
Received: from brauner.io (p4FC0A32E.dip0.t-ipconnect.de. [79.192.163.46])
        by smtp.gmail.com with ESMTPSA id t76sm27103665wmt.8.2019.04.24.08.23.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 08:23:07 -0700 (PDT)
Date:   Wed, 24 Apr 2019 17:23:06 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     keescook@chromium.org, luto@amacapital.net, jannh@google.com,
        linux-kernel@vger.kernel.org, stgraber@ubuntu.com
Subject: Re: SECCOMP_RET_USER_NOTIF: listener improvements
Message-ID: <20190424152305.32znd5t7r3d3hedj@brauner.io>
References: <20190424150423.k3embc2vkho2kixp@brauner.io>
 <20190424152001.GL3758@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424152001.GL3758@cisco>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:20:01AM -0600, Tycho Andersen wrote:
> On Wed, Apr 24, 2019 at 05:04:26PM +0200, Christian Brauner wrote:
> > Hey everyone,
> > 
> > So I was working on making use of the seccomp listener stuff and I
> > stumbled upon a problem. Imagine a scenario where:
> > 
> > 1. Task T1 installs Filter F1 and gets and listener fd for that filter FD1
> > 2. T1 sends FD1 via SCM_RIGHTS to task T2
> >    T2 now holds a reference to the same underlying struct file as FD1 via FD2
> > 3. T2 registers FD2 in an event loop and starts listening for events
> > 4. T1 exits and wipes FD1
> > 
> > Now, T2 still holds a reference to the filter via FD2 which references
> > the same underlying file as FD1 which has the seccomp filter stashed in
> > private_data.
> > So T2 will never get notified that the filter is essentially unused and
> > doesn't know when to exit, i.e. it has no way of telling when T1 and all
> > of its children using the same filter are gone.
> > 
> > I think we should have a way to do this
> 
> Since the only way we ever allow creating a struct file * that points
> to a struct seccomp_filter *, if there is a notifier attached, the
> number of tasks still being monitored by a particular filter should be
> filter->usage - 1 (assuming there is a notifier attached). So we could
> augment __put_seccomp_filter() to check for this and send out a
> message with a SECCOMP_NOTIF_FLAG_DEAD flag or something.
> 
> > *or* alternatively have a way to attach a process to an existing
> > filter.
> 
> I also think this wouldn't be too hard, since the struct file * has a
> reference to the filter. So I guess the question is: which of these
> makes more sense?

Or we do both... But overall I'm very much in favor of the option to
attach a task to an existing filter. Re-creating a seccomp context is
extremely brittle and error-prone. This would take a way a major pain
point.

Christian
