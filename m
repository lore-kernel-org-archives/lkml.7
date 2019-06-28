Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C97C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401B6215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULWQJchS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfF1Sr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 14:47:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34024 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfF1SrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:47:25 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so14694608iot.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 11:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TS6M/Nxme28NPi028YG4VL6UkJsnX87eP23dRyQxlL8=;
        b=ULWQJchSSBGqlKXWeas4g7WIZ8OlQF02e/2fni6ZOZONXYEs3ZCH+r4cic8fiYxfD0
         eHnbXowAwuPBZ89DrfUkpwTDs9b+1pqQrg7eDqxc7WPuE1R1HXMpIVW8H3p/u/Nljjwe
         nGgIWQLRB86Fr5HVwK/7FifYn8quFD54pQ1rcG7vEyBMJiIh++rAIfHCNZoFUDN6/r6F
         e0JJ7ljcCosjh6XyxVdTwFEg+Ryd3//WBaWWOHqgiiJ8CleZ6HuUNXCtKg9lh4/OuQKJ
         R8YskmnppDVe4ergbv2NJAVXObMYFdGbjt93mjBFWt/coimuZTorjdy0ZETQWq8/UYw6
         doXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TS6M/Nxme28NPi028YG4VL6UkJsnX87eP23dRyQxlL8=;
        b=ViMkpBTjlK+GJH1l8Br7xnJxpz2v5wVQrNmMTZt9N0tjbUnWhN++mPeaR0IJf65YqE
         9PRYfYC7TUbvEByD3WaoNCnCos8P8US469zqYpkZRwWPoRxZiQBr6dKP8Ws7HggKYX2E
         Lp2Daeqjgnmi5aUdqlyEUJfzLkHROx7xVLkNhuHQXviTXBCcXQTkXr+VHg53xU6EIV0R
         xe0DODH7YEqCmB+0ltjto/HSwhxTFdHtaZPrKkl29oDAqdfNxCoAv3soG0HMhnGOkA8X
         4OcO7dHNYa9zQw+I8gd9JSkwbfakHT1c0c+oJK0trGPGkY4ug06PaHR5hUTOofLPoHiz
         DVdg==
X-Gm-Message-State: APjAAAX+7xe0o/qm9VqfTpfOCGaF80dywATZ2YHrhJ2O4ebP5+UihE6m
        5cu0pU6M/Xo4nJgQhRCxH93gDtUYozaRd3uB27VJMpFGzBw=
X-Google-Smtp-Source: APXvYqyRJ1W1SO0XpPNJiChAzXB+Zx58pCxRD8I5LkVFmL9E/Q77a50+QGKt5gr4PNYscmP2X/zdh9LHxXJb3l9RHn8=
X-Received: by 2002:a6b:8dcf:: with SMTP id p198mr13241371iod.46.1561747644150;
 Fri, 28 Jun 2019 11:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
 <20190621011941.186255-25-matthewgarrett@google.com> <CALCETrVUwQP7roLnW6kFG80Cc5U6X_T6AW+BTAftLccYGp8+Ow@mail.gmail.com>
 <alpine.LRH.2.21.1906270621080.28132@namei.org> <6E53376F-01BB-4795-BC02-24F9CAE00001@amacapital.net>
 <bce70c8b-9efd-6362-d536-cfbbcf70b0b7@tycho.nsa.gov> <CALCETrXwt43w6rQY6zt0J_3HOaad=+E5PushJNdSOZDBuaYV+Q@mail.gmail.com>
In-Reply-To: <CALCETrXwt43w6rQY6zt0J_3HOaad=+E5PushJNdSOZDBuaYV+Q@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 28 Jun 2019 11:47:12 -0700
Message-ID: <CACdnJuuy7-tkj86njAqtdJ3dUMu-2T8a2y8DC3fMKBK0z9J6ag@mail.gmail.com>
Subject: Re: [PATCH V33 24/30] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>,
        linux-security@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 4:27 PM Andy Lutomirski <luto@kernel.org> wrote:
> They're really quite similar in my mind.  Certainly some things in the
> "integrity" category give absolutely trivial control over the kernel
> (e.g. modules) while others make it quite challenging (ioperm), but
> the end result is very similar.  And quite a few "confidentiality"
> things genuinely do allow all kernel memory to be read.
>
> I agree that finer-grained distinctions could be useful. My concern is
> that it's a tradeoff, and the other end of the tradeoff is an ABI
> stability issue.  If someone decides down the road that some feature
> that is currently "integrity" can be split into a narrow "integrity"
> feature and a "confidentiality" feature then, if the user policy knows
> about the individual features, there's a risk of breaking people's
> systems.  If we keep the fine-grained control, do we have a clear
> compatibility story?

My preference right now is to retain the fine-grained aspect of things
in the internal API, simply because it'll be more annoying to add it
back later if we want to. I don't want to expose it via the Lockdown
user facing API for the reasons you've described, but it's not
impossible that another LSM would find a way to do this reasonably.
Does it seem reasonable to punt this discussion out to the point where
another LSM tries to do something with this information, based on the
implementation they're attempting?
