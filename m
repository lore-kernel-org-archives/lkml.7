Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFB4C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51112206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559750667;
	bh=Lo7tnf9FZTNHvc1tqXK13IgOoz9XYJY+Hs7siRq6iN8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kpb8YI8hTAuHAwL3UoxFHrK28IKBNbBiXSgEdYUbzByC9QEUAuUeDUwrNTbwMIutV
	 vFiaQYgcgcxik3hDJZw51K5ar/2sfpZuuceLT5DZfxBZYe5qZxSQneRTIrfVDw1snI
	 Y8tafW8UkEj4xGlXgkqwCkZWSCNE7ibVdG9UDLks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfFEQE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbfFEQEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:04:23 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF2AD208E3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2019 16:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559750662;
        bh=Lo7tnf9FZTNHvc1tqXK13IgOoz9XYJY+Hs7siRq6iN8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zCM8dKmIZC/YmQo55O+/z3T0vVxKq9qomamYvlrdyEVwbHhgrjvgxI6vSQM+B/m6U
         lDHcAxKBBswh8qiFQGdR/gEB092MzZtQeI2xIAfM5cn80eb1cEdwoSuc4Z9ACmgXA/
         1T1oOl+4u+MbrT19oCLSCzoOZtL7HZcAhnkrfblE=
Received: by mail-wm1-f48.google.com with SMTP id t5so2879758wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 09:04:21 -0700 (PDT)
X-Gm-Message-State: APjAAAUDByv+0JYDg8y4mh29VuaWOjmCKt8Yp89QlSTRwOoUx/kDs3IY
        7TqJbdjI/twgl6ymz9RDeuFVzNhRyNpTiRIVpjjLFg==
X-Google-Smtp-Source: APXvYqwIrjshcVAwwMvKbnOgH9q2iZcxDjJCMHqdp2gUxGfHHyckcbZBVYnqcPYz05IGUFxNW8Satk5JOWG999hqATM=
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr11012206wmj.79.1559750660137;
 Wed, 05 Jun 2019 09:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <50c2ea19-6ae8-1f42-97ef-ba5c95e40475@schaufler-ca.com>
 <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
 <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com>
 <20192.1559724094@warthog.procyon.org.uk> <e4c19d1b-9827-5949-ecb8-6c3cb4648f58@schaufler-ca.com>
In-Reply-To: <e4c19d1b-9827-5949-ecb8-6c3cb4648f58@schaufler-ca.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 5 Jun 2019 09:04:09 -0700
X-Gmail-Original-Message-ID: <CALCETrVSBwHEm-1pgBXxth07PZ0XF6FD+7E25=WbiS7jxUe83A@mail.gmail.com>
Message-ID: <CALCETrVSBwHEm-1pgBXxth07PZ0XF6FD+7E25=WbiS7jxUe83A@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications [ver #2]
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 7:51 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 6/5/2019 1:41 AM, David Howells wrote:
> > Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> >> I will try to explain the problem once again. If process A
> >> sends a signal (writes information) to process B the kernel
> >> checks that either process A has the same UID as process B
> >> or that process A has privilege to override that policy.
> >> Process B is passive in this access control decision, while
> >> process A is active. In the event delivery case, process A
> >> does something (e.g. modifies a keyring) that generates an
> >> event, which is then sent to process B's event buffer.
> > I think this might be the core sticking point here.  It looks like two
> > different situations:
> >
> >  (1) A explicitly sends event to B (eg. signalling, sendmsg, etc.)
> >
> >  (2) A implicitly and unknowingly sends event to B as a side effect of some
> >      other action (eg. B has a watch for the event A did).
> >
> > The LSM treats them as the same: that is B must have MAC authorisation to send
> > a message to A.
>
> YES!
>
> Threat is about what you can do, not what you intend to do.
>
> And it would be really great if you put some thought into what
> a rational model would be for UID based controls, too.
>
> > But there are problems with not sending the event:
> >
> >  (1) B's internal state is then corrupt (or, at least, unknowingly invalid).
>
> Then B is a badly written program.

Either I'm misunderstanding you or I strongly disagree.  If B has
authority to detect a certain action, and A has authority to perform
that action, then refusing to notify B because B is somehow missing
some special authorization to be notified by A is nuts.  This is just
introducing incorrectness into the design in support of a
not-actually-helpful security idea.

If I can read /proc/self/mounts, I can detect changes to my mount
namespace.  Giving me a faster and nicer way to do this is fine, AS
LONG AS IT ACTUALLY WORKS.  "Works" means it needs to detect all
changes.
