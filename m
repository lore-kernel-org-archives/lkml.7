Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6377DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D3E21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="eN2GHGyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389433AbfDRPxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:53:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42368 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388097AbfDRPxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:53:31 -0400
Received: by mail-ed1-f68.google.com with SMTP id u23so1880343eds.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 08:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L53lhPg4hmdfsHP95tEaUBTmkpDsQDuRZ9hE2WocPD4=;
        b=eN2GHGyA902+7w2dL5xBI4Zpi+lQvZNb0DzVLddpCw3nQGKSPjUCunZVvZCbcbB+mP
         K2uDpJ5kbloS8No96Rja/FnyG0CJgRhj/wt+5eTcUngxVTUFYt58qv204VFwLLyjgoz7
         cr+llnXJvjWkWYH6lss5JUCyIDcE/w+mP74W03PwzoUGniTuNeMajLsVzQRx+VINLsK9
         8brSmC/prH4wKlahslgTgrjt81pwg9NcynAz21jOziVdQJs+KSaIPGLmIAOINCrvN+x/
         BvnP1kQC+GEGDYxZHkdUMajxcg4yX9Ab2h4OanL93hgMUm+dLKkvJuqpQp0mY1S/b+0i
         FROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L53lhPg4hmdfsHP95tEaUBTmkpDsQDuRZ9hE2WocPD4=;
        b=pECHrme8a0TCYqctyo4nM2oUZz0eqkFnO3ph5zs0+ovwGKWPRorNJUP5leYNYLJK+R
         EmHS1hBom5kMwS7nmty1wtDuE6qX4UrIjIyDSCsg6PFk04m4Ui6ku26evC45zgi1MsOz
         kNxo1VBSe6fZzm2tSHkaiqhkL9hp9t9sHKk0TmFvwQ/vMfKh8ekC0+qVkQX096HGRUnt
         zEEFioy2lOSmKZirhrqATxbzUcBr7w5+ddPRl/9u7XF/IJlpDRek5q8XstYd/OLEtvkS
         zo7m7PXNsndTIf2sDMZAR9ZTdcin31Xd2IaDaWAlYnIfx8+vn3kccTbJkA1Y9oN+EpET
         xbLA==
X-Gm-Message-State: APjAAAVxuMXrbkJnJNaxwE0YEqPv6Lu2LaiYx0b9pUytf9nyLa9rz8rM
        S5zQ3pI54lGVZTNJUl/1pXje6w==
X-Google-Smtp-Source: APXvYqxKWyW+Pi/g3GDY/FVG5VS12LzOEP+hVcDiQyiDYbtFruq9bFr1y55KFt3OUJDDM89pT3icyQ==
X-Received: by 2002:a50:b6e4:: with SMTP id f33mr31042641ede.2.1555602809196;
        Thu, 18 Apr 2019 08:53:29 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id s11sm450412ejq.59.2019.04.18.08.53.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Apr 2019 08:53:28 -0700 (PDT)
Date:   Thu, 18 Apr 2019 17:53:27 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jann@thejh.net>
Subject: Re: [PATCH v2 3/5] signal: use fdget() since we don't allow O_PATH
Message-ID: <20190418155326.nvjzvrhshi4gbib6@brauner.io>
References: <20190418101841.4476-1-christian@brauner.io>
 <20190418101841.4476-4-christian@brauner.io>
 <CAHk-=whB0A_WsBpr3MFujWKi7WW9XLxUpq=z_uYTv+J7uE0wRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whB0A_WsBpr3MFujWKi7WW9XLxUpq=z_uYTv+J7uE0wRw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 08:37:28AM -0700, Linus Torvalds wrote:
> On Thu, Apr 18, 2019 at 3:19 AM Christian Brauner <christian@brauner.io> wrote:
> >
> >     It's just semantically correct to use fdget()
> > and return an error right from there instead of taking a reference and
> > returning an error later.
> 
> I've applied this one directly, because it ends up affecting the
> existing code, and I'd rather just have the initial release of
> pidfd_send_signal() right.

Perfect! Thank you!

> 
> The other patches I consider to be "future release" material.

Yes, indeed. Jann and I are targeting the 5.2 merge window if that's ok.

Christian
