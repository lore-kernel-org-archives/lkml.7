Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C30DC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0AB20815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552151252;
	bh=1PUuWy4LpGpPsaoR0MKlYeiDvd9QGDPKNtDS4sjakEs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gKhA1aaXwxJmS4r5Ay/p9cyeieX9tIbPImDOrHWgKr9MYNfuSom+sL8OXMmUE0QFL
	 09gMlaLWLTfd4rkhZN/YDzb5JP/xaCs8b9m2HbK9AF9Wnx161hxlR5aUZgK2jfFoAw
	 dhCra1kGXTlrs5080iZMgWBKjwZKX/t5hbjIMSoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfCIRHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 12:07:30 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37973 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCIRHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 12:07:30 -0500
Received: by mail-lf1-f65.google.com with SMTP id k136so541937lfg.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 09:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1PYBIYx91Ep2tFRHYR2pbSt5PwsEKkKmx2LdfQ0lFg=;
        b=TbaEiUxcvmKyQqPo6o9LnG+AwYGNR3jZANISTvxcHxko7EJj/PNm59cag4S8eIKTMY
         /8CWfajtBTcHh4mtJo5k+TDjp6y7cUNhUUmjYzelLPfQ2s6xkhi6LrZxuptaShXv+a1f
         uZKuXodyLX+kQ3OxQaJLt2QU4PgFVzEkM5b6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1PYBIYx91Ep2tFRHYR2pbSt5PwsEKkKmx2LdfQ0lFg=;
        b=RDmAMMytvAqO0GIimonc6j6nJ++2J4bRDUsRNn6Fq5duvvQ0GekJJ83QngM+Z3FvNA
         bwxuFHcnH34JHZ6TlO5Df3yxMOOdvPO2xbzmQWjahu112kK3XLOX9i278A9Himv+pe5s
         +30+3bc7a8WYJ5ZMgs7shfLiFcL8mn3o+xw5sXohUJuCZ6XKBua4JJHeFNc0QS0s9gTF
         ZJB9HBH72io1XYfiNRJ/K7csHqnt16+saeZwk7NbkECQKGUIbokaCvroIDlqjpp64phG
         Zz9t+gKt58bIwKzgRn6amSdLXUbmJGUyEjzYvNxgTt3p/qHUEggvE/kk311UF9iG48k4
         chBg==
X-Gm-Message-State: APjAAAW7OxTA2Y55uFPcGWLOVT6qrJCiQkok1jzq451h+dTnWkcJOL8y
        gmq00szZ4ygZB5jMY6Vqg5FK5Hl2ZE8=
X-Google-Smtp-Source: APXvYqzPBq1X8FIhYi8u+Eflx+9H2EZcnBd6h9L3Z1GjlSspxuveFWb8preJpyulWG8eiuKJoYivSA==
X-Received: by 2002:a19:a417:: with SMTP id q23mr13954649lfc.27.1552151247789;
        Sat, 09 Mar 2019 09:07:27 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id r190sm110252lfe.43.2019.03.09.09.07.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 09:07:27 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id z7so607766lji.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 09:07:27 -0800 (PST)
X-Received: by 2002:a2e:8510:: with SMTP id j16mr5128563lji.2.1552150873803;
 Sat, 09 Mar 2019 09:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20190306191244.8691-1-cyphar@cyphar.com> <20190306191244.8691-3-cyphar@cyphar.com>
In-Reply-To: <20190306191244.8691-3-cyphar@cyphar.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Mar 2019 09:00:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgGKWRTgSYKkgMEf1QOg0PZSpmBha+2LCHCBOar0e8cug@mail.gmail.com>
Message-ID: <CAHk-=wgGKWRTgSYKkgMEf1QOg0PZSpmBha+2LCHCBOar0e8cug@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 2/5] namei: O_BENEATH-style path resolution flags
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 11:14 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> This is a refresh of Al's AT_NO_JUMPS patchset[1] (which was a variation
> on David Drysdale's O_BENEATH patchset[2], which in turn was based on
> the Capsicum project[3]). Input from Linus and Andy in the AT_NO_JUMPS
> thread[4] determined most of the API changes made in this refresh.

So I still think this is likely a good idea...  BUT.

The absolutely huge BUT here is "are user space people actually
interested in using it, or do they already have other solutions to
this anyway?"

The intent is obviously to make it easy and cheap to to the simple
pathname lookup in a controlled manner, and then let user space fall
back to "let's check things much more carefully" for paths that look
iffy.

But maybe the people who care already have their own solutions, and/or
need something more anyway (ie samba looking up all names in user
space first _anyway_ due to ICASE issues or whatever)?

So this is easy and straightforward to do in the kernel, and it
_feels_ like something that can be useful, and I'm not all that
concerned about the maintenance overhead either because of the trivial
semantics.

But I'd still like to actually have some user space person say "yeah,
we'd actually use this" since quite often non-portable solutions don't
really end up being used simply because it's not worth the maintenance
headache in user space..

                     Linus
