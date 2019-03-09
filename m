Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A00CC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F2120883
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="RqXVGvhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfCIR0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 12:26:37 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37371 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfCIR0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 12:26:37 -0500
Received: by mail-ed1-f66.google.com with SMTP id m12so641206edv.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 09:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q10lFfhiAz2xaeRrw6ifH2qulzU8x6mTfettzJK6wXo=;
        b=RqXVGvhOBq/xV6p5UuFB59DABzFoHNVtcl1TKONJQsNUC86KpjwpbKaAXpq8/9g5J0
         +6xU5Oa7u39mmg3y15b5xd46CdkV0lEi4Gsf5wVLrSacMPX1xtcLiTELhbkMKEwdcX+a
         YFRcEpxmZZeUQJRVj+greN3Js5ziV71BPIxWq+C1gBq7tDFJcMei7YDpW535RtbKLOUp
         XRvTPlasr5ssZTnVYDcjfzIPRd2HauGaaXmUYLgvduydtnnvtJwU0dcHdNmdPzqcycbg
         ED5aY4SN7W8MrHSzDoa62qf4HnAjJKrVOp5z/6oKO7a2Zo8ZmGNtGQzjwcxuJKDx3S1s
         0j/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q10lFfhiAz2xaeRrw6ifH2qulzU8x6mTfettzJK6wXo=;
        b=osnDKYHfhTQvlAaZwNWWnWxRwyHwBvEWiA3DS+5cw0nq0cV6pq1O0WL8KjKQDZr4Zo
         P3eq1HlqxjI0JuYZM8WhvqR2THNIbJu2NP7GxzsRJFuX9wlu5vE1XflmMD5wDJRHEnsw
         lQUMM5oUmCzZMl8gpqGN3i6jsZkxYuWwmu4RLKlXs3kwLPHUPHbR1Z9baAVe/CZAWGpm
         7YCjkBDSzSZvoVfwnkzswN/U+j+xDv+vRaKoXdl4Aul6cQ45NfnmaCyXR/+HX/wVV9lK
         msWSRmQaajuK/bjVCA2JZeb+mIBggU1q9iJ2rMf2jtFRlGpz1fkuYybgv7Q3vSu1r3On
         q3eg==
X-Gm-Message-State: APjAAAXonQT7uShZ6fzEPgukutDfSzz115n6HRqf+LLz3BuyMuFLjuqa
        SnP28JJ6V6vtSHTFZAf7WmE7hw==
X-Google-Smtp-Source: APXvYqwwG8D1GxG4qZV5hxTqTiGjYtfzxyBKDGWwhQNN3arQVORGaLvUwXCiT1OW2Cv5DFHH8FuRUg==
X-Received: by 2002:a50:b136:: with SMTP id k51mr37743285edd.111.1552152395240;
        Sat, 09 Mar 2019 09:26:35 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:76e:3ddf:44fc:d22b:95ce])
        by smtp.gmail.com with ESMTPSA id n19sm2020140eja.38.2019.03.09.09.26.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 09 Mar 2019 09:26:34 -0800 (PST)
Date:   Sat, 9 Mar 2019 18:26:32 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jann Horn <jannh@google.com>, Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        containers@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH RESEND v5 2/5] namei: O_BENEATH-style path resolution
 flags
Message-ID: <20190309172631.ygfdhrn4rcwkgfmk@brauner.io>
References: <20190306191244.8691-1-cyphar@cyphar.com>
 <20190306191244.8691-3-cyphar@cyphar.com>
 <CAHk-=wgGKWRTgSYKkgMEf1QOg0PZSpmBha+2LCHCBOar0e8cug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgGKWRTgSYKkgMEf1QOg0PZSpmBha+2LCHCBOar0e8cug@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2019 at 09:00:58AM -0800, Linus Torvalds wrote:
> On Wed, Mar 6, 2019 at 11:14 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > This is a refresh of Al's AT_NO_JUMPS patchset[1] (which was a variation
> > on David Drysdale's O_BENEATH patchset[2], which in turn was based on
> > the Capsicum project[3]). Input from Linus and Andy in the AT_NO_JUMPS
> > thread[4] determined most of the API changes made in this refresh.
> 
> So I still think this is likely a good idea...  BUT.
> 
> The absolutely huge BUT here is "are user space people actually
> interested in using it, or do they already have other solutions to
> this anyway?"
> 
> The intent is obviously to make it easy and cheap to to the simple
> pathname lookup in a controlled manner, and then let user space fall
> back to "let's check things much more carefully" for paths that look
> iffy.
> 
> But maybe the people who care already have their own solutions, and/or
> need something more anyway (ie samba looking up all names in user
> space first _anyway_ due to ICASE issues or whatever)?
> 
> So this is easy and straightforward to do in the kernel, and it
> _feels_ like something that can be useful, and I'm not all that
> concerned about the maintenance overhead either because of the trivial
> semantics.
> 
> But I'd still like to actually have some user space person say "yeah,
> we'd actually use this" since quite often non-portable solutions don't

So if I may put my user space hat on. I maintain a container runtime LXC
and Aleksa maintains runC another container runtime. We both have
(horrible) code in our respective projects that tries to ensure that a
given path doesn't escape a given dirfd. Symlink resolution, and then
using crazy things such as mounting through /proc/<pid>/fd/<nr> etc. pp.
It works and we have been living with this state for a long time. But we
would both definitely use this feature. We've been discussing this and
had this on our wishlist for quite a long time and it would be good to
have this patchset.
Aside from that I want to point out that it is non-trivial to do this in
user space. The original code for restricted path resolution in our
codebase was done and is maintained by people like Serge and myself who
are involved in kernel development and it honestly required some pretty
intricate knowledge. I think having this feature work out of the box in
the kernel is a great win for quite a lot projects. Definitely for LXC
and runC.

Christian
