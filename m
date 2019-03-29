Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB5AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BC3218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553897665;
	bh=3jx+6JEPP3W1oSTYbBx7j7/GDfX7eyxt3f59bKlH9h8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1BnNYbT2cHdiR6W/KUAifaebDXguxmD2kDtJ8KTTz3gyLEGZdPGt1/HzvLabzeBbZ
	 PYoi7ySh7wfn5iIq5x52PMi9li1JCl/bKm7x7JC9zxgjLnXdpbGpH9qtp1A2RvVimj
	 OcOWLqQjOQiYxMfeZvs9Sx6gl5ETCDeVtf7yF27E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfC2WOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:14:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37627 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbfC2WOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:14:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id u2so2451575lfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 15:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oEmX8ZCRvQFJipsIScwR8NdKGvI1KivSe6xM2zeqmVE=;
        b=B+RgZnfNDy4RrWItp6jNJSX4I16v6Gwnw9db53AGFybRNXUvc8zvVDC2VyRBl3zNN8
         NZ98ifa6hSOxwPqygC9oVIi/zMOx4iDQubf2J+uM17cjesR6T9aTejOOsE9SVJoHTJpu
         e9WrI/CJHDqKVSkIYPHg1DTz+/Km+akPE2MiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEmX8ZCRvQFJipsIScwR8NdKGvI1KivSe6xM2zeqmVE=;
        b=AziA5Sd5qWKf37d4PBfRdMcwDMJ8VYU38ajmNMb79Z6+d09rnSCImLy1F2/iQw2b1w
         Vm6tkjK8koAl5m5igeKZH2s8N8uFavKbvvSacpyoxhVFOn4DZtUQP3kATLRjauj7WpfB
         CKxILe5QWgGaUrH20cu++EuXw7RNQeJJxEMjUtGlJkFz/WG+tvfKmiS22F8dPlEPOkKy
         qlDPbPxHarXC2Ylprjj4SIj83I5l/HeoeoYu+QEwVPQtUDw1Fsu61XuK98zh4ZVKOhqf
         F/UZZlNGQ6h6Awv6iCNu3xO3mITwVEgTvYoaaMnR6tJKa54S2bLWv5Mh1rjjjSUA9zvY
         clXA==
X-Gm-Message-State: APjAAAVG07z7PBDZStKw18whAC2CHtT/MBjKGe4CF+ixRV6vPotEF2VM
        J27SkxokOKCIa7ItUguSSdhyD3BTBsU=
X-Google-Smtp-Source: APXvYqzt1mrtNtMVdfcC8CtFCUjXEZbV46N1SIXfVeDWJO+YZu4/RlqNkPc8CRiBBACQj3NMknIsvQ==
X-Received: by 2002:ac2:50cb:: with SMTP id h11mr1086787lfm.159.1553897661264;
        Fri, 29 Mar 2019 15:14:21 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id h14sm581088ljg.10.2019.03.29.15.14.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 15:14:20 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id h16so3248815ljg.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 15:14:20 -0700 (PDT)
X-Received: by 2002:a2e:8149:: with SMTP id t9mr27810082ljg.2.1553897659982;
 Fri, 29 Mar 2019 15:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190329193944.GA11609@kroah.com>
In-Reply-To: <20190329193944.GA11609@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Mar 2019 15:14:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wggq+RYy1F1Ym0W3juRNsFAOgAun25uLxziwUpQAmNVPA@mail.gmail.com>
Message-ID: <CAHk-=wggq+RYy1F1Ym0W3juRNsFAOgAun25uLxziwUpQAmNVPA@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core fixes for 5.1-rc3
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 12:39 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> After 5.1-rc1, all of the users of BUS_ATTR() are finally removed, so we
> can now drop this macro from include/linux/device.h so that no more new
> users will be created.

Note that a quick grep shows that it still exists in the Chinese
translation of filesystems/sysfs.txt..

Also mentioned in a comment, but at least there it talks about the "old macro".

              Linus
