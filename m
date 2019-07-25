Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D212FC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EC82080C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="T4KUA8XX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfGYKHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:07:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46422 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729763AbfGYKHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:07:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id d4so49723243edr.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3W2fkGpq5UVx3HliVh388tC3kwFiVTE5EefsDDQjcRE=;
        b=T4KUA8XXSy7z7CnjijHypskNZbeFue1MSukNCAgs8ge4dnmdNN+n2Btri6OPz5KHJW
         hM490KZ+2vjrbyfDx1ad+Lc+zlxC+UAxjH4TBlNjb3PBHT8x/EAZ/SFZSJZClB08DtOB
         tTDWXN31bAJN2APCxgr0eR5UdeJTRiUhTUcU35iGZ7aiom1CgJw9AdHAB7qgriFRHFpz
         YxqtfkQ7oAdEhPSLGFMaB/t6aIUeXtSLj5Vs+Ba4RjF/7zPZGQD3Aon8eD4oeIkXjtVK
         M9zhMfYnPWk/3ohRowjqdKbnfDiT7Q6uR/Iydd96wM6gpYDUAz1H/g1hF3LpfsQgMiRn
         QZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3W2fkGpq5UVx3HliVh388tC3kwFiVTE5EefsDDQjcRE=;
        b=mtZQ1q2v2ME3Yi3zeaqP4eMq9Cwwdo8sDZWU6oO8BNMZflX9xtDZ20zWdyAnyfQXdy
         8DFqhxqUOvkDnEnVZFrxG07Odd0RbNJkWL0GzAlQDa+jSGdfQq9933NCtwUOYXne7l6R
         UMydVBLYbqub39AME1DQz6MW/H+VUv+FrvnVdzkX+Gy//UXkIgEuugG67AwnHAXHGMq6
         49Epo453G6sX5RqcO2dOz16ULzCPrEjtgzMxzcA5lct+xTobk0bv1oqdUcCzSL5yde0B
         LhSL74Ll7D4md81oW6t7elFGpPK+VSpGFLtRrnthED/S1onnyQQ9r0KssCgIytQr9r2x
         Pn2w==
X-Gm-Message-State: APjAAAWzq4O60KQT1XiuSE7gXQOG9Bb+Qoa95c22byqyb6HS+IC0lI/s
        YYac91QUO0xL42/9fbgK9xU=
X-Google-Smtp-Source: APXvYqzoqdAaKsrTqRNvYQZKyRGKket10ix5k7Oyq4FLAuIsZW0a3Fvb4Dpi1rUXXGi6o+pOpqAdGg==
X-Received: by 2002:a50:8828:: with SMTP id b37mr75911877edb.266.1564049249888;
        Thu, 25 Jul 2019 03:07:29 -0700 (PDT)
Received: from brauner.io (ip5b40f7ec.dynamic.kabel-deutschland.de. [91.64.247.236])
        by smtp.gmail.com with ESMTPSA id nn19sm8819043ejb.12.2019.07.25.03.07.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:07:29 -0700 (PDT)
Date:   Thu, 25 Jul 2019 12:07:28 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, tglx@linutronix.de,
        tj@kernel.org, dhowells@redhat.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com
Subject: Re: [RFC][PATCH 1/5] exit: kill struct waitid_info
Message-ID: <20190725100727.4ojpf2q53yl2owak@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io>
 <20190724144651.28272-2-christian@brauner.io>
 <20190725094051.GC4707@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190725094051.GC4707@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:40:52AM +0200, Oleg Nesterov wrote:
> On 07/24, Christian Brauner wrote:
> >
> > Note that this changes how struct siginfo is filled in for users of
> > waitid.
> 
> Namely, copy_siginfo_to_user() will nullify the extra SI_EXPANSION_SIZE
> bytes + 2*sizeof(__ARCH_SI_CLOCK_T) from _sigchld (waitid doesn't report
> utime/stime in siginfo).
> 
> Looks correct... even the compat case, but please double-check
> copy_siginfo_to_user32/siginfo_layout. Looks like both SIL_KILL and
> SIL_CHLD cases are fine in that this patch can't add other user-visible
> changes, but I could easily miss something.
> 
> > In case
> > anyone relies on the old behavior we can just revert
> 
> we won't need to rever the whole patch, we can just replace
> copy_siginfo_to_user() with copy_to_user(offsetof(si_utime)).
> 
> I see you are going to update the changelog and resend, feel free to add
> my reviewed-by.

Will do.
Thanks, Oleg!
Christian
