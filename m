Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08032C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF83920815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552155384;
	bh=nqSMDFt99UIHu8LrdBPeqsVJwsG9eB6rSRf+vZtNN7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PufK/pBZW+EPl1kU8fT3B7FToszMMXLDyFFnMIaNjgRJVlqpPg88qCL0rjtlg1ZUL
	 l6Zv8VmWn8Vl2DQOvb+VhNjozdKajPbrWe7cRj2TduzOESTIgx4dIlGMfsUfXHTxZm
	 82wYMgcZnaHPvQ9HAJHNqSEYnRtxPrz0MSok2nGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfCISQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:16:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36224 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCISQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:16:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id 197so612868lfz.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 10:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/PlK7wNBa6EZ0JOE2V9Wm27AX+5iyxV4H0wnT9W3zo=;
        b=AjZmVZkOQcBB9u8SHXCF0UiVkyA8JvvALO4xP76q3B/H0gwxpGHxBEXDnH0GJeuoRW
         3JA/56849O1/kJLAqrJIugjnpi8GuqkM+yPkYSkLiv/LxXp2sr/hNkAzPRt0/UXujkMN
         YFjEahIgbrn+A13I5emBjzJXMzC51MtcVReo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/PlK7wNBa6EZ0JOE2V9Wm27AX+5iyxV4H0wnT9W3zo=;
        b=PUGAXDhxdZsyWY5vA+URGOY+48/I0f4y/LKzQMojEGdLV+S2nTTPRXQ3XwBKOdaufv
         ahnFIKLMDuyI8fOFHFys8N1Hidn15ep7+YHkfz/oZyEzloFmVqmyDqTdiJTPi4exkRdp
         hrfKyH60qoKFI8rBuy+Oc4jq9kk+0hucgR3OMEiGg93vVl0PG7JuNV6QkKn5astwOR8n
         QrgIaWw+8PnJCYcm3uDcRUTV/1ii7DOGL8rxmi5v04Xiy1xY6swMczE/Swg/jF74qwza
         BJxvPhp7aj4IpWhrWOCBRJPjLCTg7mCc8/0bKXDvkRb4debWFFDrbN1TLWtVUsNkxHUf
         GGIg==
X-Gm-Message-State: APjAAAX5kih3MSaCmKSPkxTIwaLk6AZquAClUndGILujemh8p2Q8hjWU
        Cz45adlnA+UiJgb7tXuJ+FKEiArvKpk=
X-Google-Smtp-Source: APXvYqxyGNwDADv/pXzA0k7BNadkBVaDgfn3lY8+MmMt3o+gD3ebKCYaIB/mE5Hrgk5TKIJtk8KzSA==
X-Received: by 2002:a19:5503:: with SMTP id n3mr14354051lfe.35.1552155380080;
        Sat, 09 Mar 2019 10:16:20 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 13sm202695lju.27.2019.03.09.10.16.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 10:16:19 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id h6so618183lfc.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 10:16:19 -0800 (PST)
X-Received: by 2002:ac2:424c:: with SMTP id m12mr14199023lfl.62.1552154904904;
 Sat, 09 Mar 2019 10:08:24 -0800 (PST)
MIME-Version: 1.0
References: <20190306191244.8691-1-cyphar@cyphar.com> <20190306191244.8691-3-cyphar@cyphar.com>
 <CAHk-=wgGKWRTgSYKkgMEf1QOg0PZSpmBha+2LCHCBOar0e8cug@mail.gmail.com> <20190309172631.ygfdhrn4rcwkgfmk@brauner.io>
In-Reply-To: <20190309172631.ygfdhrn4rcwkgfmk@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Mar 2019 10:08:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whMuk-b6rzhbF2=vVNOuEZk8-opRJ1fD07a9ztQ+V97Aw@mail.gmail.com>
Message-ID: <CAHk-=whMuk-b6rzhbF2=vVNOuEZk8-opRJ1fD07a9ztQ+V97Aw@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 2/5] namei: O_BENEATH-style path resolution flags
To:     Christian Brauner <christian@brauner.io>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 9, 2019 at 9:26 AM Christian Brauner <christian@brauner.io> wrote:
>
> Aside from that I want to point out that it is non-trivial to do this in
> user space.

Oh, absolutely agreed. It's easy to do it in the kernel, and doing it
anywhere else ends up having horrible races that the kernel has to
deal with and has long solved anyway.

I've only seen this (2/5) patch, so I won't comment on the other ones,
but this still makes sense to me.

Al, comments?

                  Linus
