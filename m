Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37369C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 20:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5962083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 20:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BieFlEea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfFUUF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 16:05:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39646 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUUF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 16:05:56 -0400
Received: by mail-io1-f67.google.com with SMTP id r185so1209524iod.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DypY5fiIicrIoi3ORV0h3vKCopNCu2H79dLHF98Wk1s=;
        b=BieFlEeaOPgi+fafYZbwPJAk/rgzMYgJne9JdDRFRlJ67BByhxNbJeiWxMC9B5y/s9
         Gp8olywbJtE8mi44Ji6k8zEHSqnnACQtDN7I28HDQcTwz/mye1jJMaedbY6/qHdXorLI
         Wfs9/larHy+OePAeGIpWCU4PVYoHRu54s+yDpX0ZYjNvvwg5OXzrDsxcjH6q8d7OOF7j
         48AI5VhQZTNHr+JUkc9MWxW0n/4tx9Kt3taDC+fhcfCafvOZH8dO7US0xim1pWzmY5Eh
         uxPjC59ST8oJkI5UEY7MywS+dGHUEPH7uSwunhiu0xgIfllo0HFRZbPbo7RM3eC4BaAX
         +b3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DypY5fiIicrIoi3ORV0h3vKCopNCu2H79dLHF98Wk1s=;
        b=hwsMnXsS78VlZiWBZnhdWM7BILDXyP5ctTs3hYWqWdiWNebCaIJN1zUbqp3YRvQ7U9
         YBT3FyHGVXJFk99oLlzJsvM8ido0uHPnoG+m2uDWdTjDfBB9L4pkF2wsAeiTMFl2O69T
         zhZOCVKVPtR+AGBcGFQyI/uMpYUnJunkgTZl8lqYiMppMBsOOeNFuv+6ceWD753wMPwF
         6MGWa10SOcSYphbni5qQNTz4572SqMfD0mcD7k0/dAjkXGniiqmz2hpEoa3M3habrpMs
         OU1IdoGEaau9qFXwLNje+D/V3RWDq3kpdp5pxCEXPecU8JxC7u8Fa9fpS++nw7BoVzFd
         FDrg==
X-Gm-Message-State: APjAAAVX4e2X0NvnAluppEpOOjngdGjtDhRrm63mBsa7RFsyNnzEkmzP
        LmxNVlaSiyX+4mEZA10yGNmSYnnAhZxYmxDeOxFS4g==
X-Google-Smtp-Source: APXvYqyvFcTfOyKgeM/UaweMDg4Kki2AkTgmwFItVLQmiTExSzaei2TBGbOswsUQLvi+574xJqn1fxM3Q6bPWu5Kiec=
X-Received: by 2002:a6b:8dcf:: with SMTP id p198mr36640213iod.46.1561147555624;
 Fri, 21 Jun 2019 13:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
 <20190621011941.186255-25-matthewgarrett@google.com> <CALCETrVUwQP7roLnW6kFG80Cc5U6X_T6AW+BTAftLccYGp8+Ow@mail.gmail.com>
In-Reply-To: <CALCETrVUwQP7roLnW6kFG80Cc5U6X_T6AW+BTAftLccYGp8+Ow@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 21 Jun 2019 13:05:44 -0700
Message-ID: <CACdnJuv2sePuGBtTM6UL4S2k1UATcAk517o6vPx2EWF0Uxt8iw@mail.gmail.com>
Subject: Re: [PATCH V33 24/30] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
To:     Andy Lutomirski <luto@kernel.org>
Cc:     James Morris <jmorris@namei.org>, linux-security@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 10:22 PM Andy Lutomirski <luto@kernel.org> wrote:
> On Thu, Jun 20, 2019 at 6:21 PM Matthew Garrett
> <matthewgarrett@google.com> wrote:
> > --- a/security/lockdown/lockdown.c
> > +++ b/security/lockdown/lockdown.c
> > @@ -33,6 +33,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
> >         [LOCKDOWN_INTEGRITY_MAX] = "integrity",
> >         [LOCKDOWN_KCORE] = "/proc/kcore access",
> >         [LOCKDOWN_KPROBES] = "use of kprobes",
> > +       [LOCKDOWN_BPF] = "use of bpf",
> >         [LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>
> The text here says "use of bpf", but what this patch is *really* doing
> is locking down use of BPF to read kernel memory.  If the details
> change, then every LSM needs to get updated, and we risk breaking user
> policies that are based on LSMs that offer excessively fine
> granularity.

The text is descriptive rather than normative, and no changes should
be made that alter the semantics of a reason - it makes more sense to
just add another reason.

> I'd be more comfortable if the LSM only got to see "confidentiality"
> or "integrity".

If LSM authors can be trusted to do the right thing here, then I see
no problem in providing additional data. I'm happy to defer to James
on that.
