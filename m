Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941D2C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E81206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="R5b9Hstp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfL3TPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:15:22 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41318 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfL3TPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:15:21 -0500
Received: by mail-ed1-f68.google.com with SMTP id c26so33584043eds.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 11:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmjrGhb+wuiGVK6bOKXUfEcUa7KlDxwgv8e6fd+fEtI=;
        b=R5b9HstpwDK6KvfnJLkNr4KxEgBvgJWFezGyxEVM1/JaRLCRptf9hokCACxVV4ucqZ
         Ge8nllcRFLd7LuS6s0ynOAgl0UWk5ZAGfrHhuvsO+9b4OqRUCyjiS93S9byKtkCKq1Gm
         mG3jN1qMfq8sEykrTJq7CjMphgXQbvV7o78Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmjrGhb+wuiGVK6bOKXUfEcUa7KlDxwgv8e6fd+fEtI=;
        b=tO9Ueje1FvtHM7mShFaC4ohkEZaSKBXaNnOMoQmRMdKKCGgrcyW0+89e5tVoD77OT9
         gyrW2c1H6iKxAl4GF5O4QIWOg1bvtzceKJMQuiaDyukkhWqoryhBAs3sYIP7Hb1yoK+G
         +a8wg7utkuw0P+5qLNxsrPn1LlAMK7qnhmsR73SQGTdUBH+2jjCSKqe3pYSBEUkQlRxj
         x5pIYMiLnVUKN/1As0EpKo8XLS1s6Sk6Q9q/E+qCaT4y/p2Pcdk3O6Q3zx4g89yIubvP
         21U1j9x2BSx6+Ha/khrfKjnYD76iPFvMA6mzboF/UOzTFbX9PFjKSIbz1O9JZzVpglWP
         diww==
X-Gm-Message-State: APjAAAWtE+9pnhTsFw/kWx9HCguo0rZ4Eh54T5rYUjdwQ/JCY+B6d6np
        AwG6YhnD4T6WJHDIx9dxgMHay//b+O3uLWYq+bqt0w==
X-Google-Smtp-Source: APXvYqxw0zHopdQJLkfLOLERsk50/sjepInnBW8P9qW3tmZKHs8MTMCQB6TTPwY7HCuAib3phQnoTZi9LjbpQZMxBGc=
X-Received: by 2002:a05:6402:c9c:: with SMTP id cm28mr72516280edb.88.1577733319891;
 Mon, 30 Dec 2019 11:15:19 -0800 (PST)
MIME-Version: 1.0
References: <20191228014837.GA31774@ircssh-2.c.rugged-nimbus-611.internal>
 <20191228181825.GB6746@cisco> <CAMp4zn91GoB=1eTbc_ux4eNs2-QFm+JocodgFQYUiiXL7H4m9w@mail.gmail.com>
 <20191229001818.GC6746@cisco>
In-Reply-To: <20191229001818.GC6746@cisco>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Mon, 30 Dec 2019 11:14:44 -0800
Message-ID: <CAMp4zn9s1wJyb9xHj4xYL5HTtM=gA07ZfBGTSW5j4ayUzaoZNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] samples, selftests/seccomp: Zero out seccomp_notif
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 4:18 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Sat, Dec 28, 2019 at 07:10:29PM -0500, Sargun Dhillon wrote:
> > On Sat, Dec 28, 2019 at 1:18 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > >
> > >
> > > I know it's unrelated, but it's probably worth sending a patch to fix
> > > this to be sizes.seccomp_notif_resp instead of sizeof(*resp), since if
> > > the kernel is older this will over-zero things. I can do that, or you
> > > can add the patch to this series, just let me know which.
> >
> > I was thinking about this, and initially, I chose to make the smaller
> > change. I think it might make more sense to combine the patch,
> > given that the memset behaviour is "incorrect" if we do it based on
> > sizeof(*req), or sizeof(*resp).
> >
> > I'll go ahead and respin this patch with the change to call memset
> > based on sizes.
>
> I think it would be good to keep it as a separate patch, since it's an
> unrelated bug fix. That way if we have to revert these because of some
> breakage, we won't lose the fix.
>
> Cheers,
>
> Tycho

As I was doing this, I noticed that the self-tests all use hard-coded struct
sizes. When I was playing with extending the API, all of a sudden all the
self-tests started failing (until I recompiled them against newer headers).

Should we also change the self-tests to operate against the seccomp
sizes API, or was it intentional for the self-tests hard-coded the struct
definitions, and locked to the kernel version?
