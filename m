Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37716C74A3B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0953620651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562783730;
	bh=bxQwKnqHhWiMpvbPeNTE9Xgl2zH6M9L+S3VxT7aAyOw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=d0sbefr2ICb6rdsME9LLgsp/LGlOvF306jjst/dbr7+mvzkqOydfvIn34uwvSU0z3
	 U0y9g+gAQAIqBHO2g9q8f8vgmOtNWha8B8XzJnE1Fg4Ar0k9AVXOrdol64hlXeD7P+
	 oKhidKWDCWQwQrXNkzU+7GAqoDbr8XvkSiU5PjE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfGJSf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 14:35:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35441 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbfGJSf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 14:35:28 -0400
Received: by mail-lf1-f66.google.com with SMTP id p197so2305073lfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 11:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=59LQqbVb+KQ/BMKWYDi9soPsvc3OIaSci70f6vwiQDg=;
        b=FqoWOUQDI8WMp245xx+rH6pVnDYOUvjDYs15fEQlF6pDz0NP8XsjV31N/mtE4tmezC
         j2UTUlQ1N7GdmP1kf74xSCxvIJJ+DHBtK3c6eKcgoseA+K8AhvGS/ovhJPv6+HASW4G8
         XOZuoCQHXi5bTBX95YG3a2jJFHuWkpZNYqeaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=59LQqbVb+KQ/BMKWYDi9soPsvc3OIaSci70f6vwiQDg=;
        b=e2SEhCSaYfZ0GKJB6JUJT5myHSATZnHQFoRRErVcl4SKI5ShSVJR6l++ZN0AOYpMGt
         IOhD/0w6J0H9oZqHR8PqW9/kUp6887/tWwdGYTLr48RpsOywsGBC2tpGP71uMY7SX84p
         OzdSGnKGrj7RSxWFcwe8OoyxGvI9dpqv5MEPsNUi9yXv1Zx7JtC9E7FBtNj9emHlLZqy
         m6nOWNlnr+U9Rf08+wN+m3thHgAtu943UyEUrvzBkx2ipOUnwyGwIAfoF7WoPTU6oQ3e
         tvlbhawTG6zNm6rJrvsme/LUcklwwPLUulBJ4UFdTTTrtTNmtk3DNw8MU0i1UoF96lrD
         celw==
X-Gm-Message-State: APjAAAWk5KDCeEcCpPKgOAf67tREWFXF81LerjYAMJdZFe+byid7kyHR
        /1Kz/+g3rBS8lQnyNt9vCNBre2OZsgs=
X-Google-Smtp-Source: APXvYqx2xM4QUMtkLJeZc4BkchpGzUiNjQkrlf1K3uO7qMyXTyKSgXa/paERLIBK7m5OelUv+MqSzg==
X-Received: by 2002:ac2:46ef:: with SMTP id q15mr7004658lfo.63.1562783725509;
        Wed, 10 Jul 2019 11:35:25 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id z23sm450939lfq.77.2019.07.10.11.35.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 11:35:24 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id s19so2280370lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 11:35:24 -0700 (PDT)
X-Received: by 2002:a19:641a:: with SMTP id y26mr14803967lfb.29.1562783723934;
 Wed, 10 Jul 2019 11:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <28477.1562362239@warthog.procyon.org.uk>
In-Reply-To: <28477.1562362239@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Jul 2019 11:35:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxoeMJfeBahnWH=9zShKp2bsVy527vo3_y8HfOdhwAAw@mail.gmail.com>
Message-ID: <CAHk-=wjxoeMJfeBahnWH=9zShKp2bsVy527vo3_y8HfOdhwAAw@mail.gmail.com>
Subject: Re: [GIT PULL] Keys: Set 4 - Key ACLs for 5.3
To:     David Howells <dhowells@redhat.com>
Cc:     James Morris James Morris <jmorris@namei.org>,
        keyrings@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        linux-nfs@vger.kernel.org, CIFS <linux-cifs@vger.kernel.org>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 2:30 PM David Howells <dhowells@redhat.com> wrote:
>
> Here's my fourth block of keyrings changes for the next merge window.  They
> change the permissions model used by keys and keyrings to be based on an
> internal ACL by the following means:

It turns out that this is broken, and I'll probably have to revert the
merge entirely.

With this merge in place, I can't boot any of the machines that have
an encrypted disk setup. The boot just stops at

  systemd[1]: Started Forward Password Requests to Plymouth Directory Watch.
  systemd[1]: Reached target Paths.

and never gets any further. I never get the prompt for a passphrase
for the disk encryption.

Apparently not a lot of developers are using encrypted volumes for
their development machines.

I'm not sure if the only requirement is an encrypted volume, or if
this is also particular to a F30 install in case you need to be able
to reproduce. But considering that you have a redhat email address,
I'm sure you can find a F30 install somewhere with an encrypted disk.

David, if you can fix this quickly, I'll hold off on the revert of it
all, but I can wait only so long. I've stopped merging stuff since I
noticed my machines don't work (this merge window has not been
pleasant so far - in addition to this issue I had another entirely
unrelated boot failure which made bisecting this one even more fun).

So if I don't see a quick fix, I'll just revert in order to then
continue to do pull requests later today. Because I do not want to do
further pulls with something that I can't boot as a base.

                 Linus
