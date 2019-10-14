Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758B9C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8392089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YY3BCYHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbfJNSaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:30:35 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44239 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbfJNSaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 14:30:35 -0400
Received: by mail-ot1-f66.google.com with SMTP id 21so14616838otj.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 11:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tl4f6x5LaBYnk4O0v99MsRzY3TUmlaFrR8aMs8VHxow=;
        b=YY3BCYHU/puIpC3m1C7ST9z/cleynKgAfruHWL6oXDlKC6WRCZa/wtgFzBUdscWo2D
         +kH+MjVv6Ztu2n2DRbBrgGsyLV61j4t/+Oj4RLwP+/LaWMDDy2P+yIfx+cB0xSb2fSEU
         EcvLBM8vTO1kOprr3LkwP0BsUDZq9Io8o5xLvSY5L17P9NeIWnaql9xRjO68GeyGqWdo
         +HHa0xnhjQ/uGk4hRq116CNqGxl1vBP4Sn2LNV6oEbRaElmLeFODC9Zv9GTJkZAoXOiE
         /H3AXVQq9eNLKSxtsURmb0h6VzQfnmiLlJmzkI91pZpGdYesQp1tl35pgLsL5J+IGf9l
         1mEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tl4f6x5LaBYnk4O0v99MsRzY3TUmlaFrR8aMs8VHxow=;
        b=eLdk9CdzAUsvyxe4f/87vOrkz0gfrSarA430ATOLQZFzRoEx7xqJu1TFhgrD/0mXLN
         xXAUhdHej5D2LpfJ4JSL539d8qKwjQrdJ+B09j1DvL3LAzqJN3BdXxWg9Qc0MFOkpYpS
         2jT4YBOfzemTAJPv/I3F9PqzZ3qLmhD63ooJ3Lo+c65Qi3fAe2JnnOuNJByiXH38GHb0
         f9TvYnToJMCtg0cS6FB5uP/wk0QkDgCMifjavb1IOfEV5w42SbLxRhTYiiGLHWVPZTM2
         oufMJbIHdlm3I4j+ByQXcHZAqR0PV7LXRa/Ep+uaBQcoTmj88DjhLTD3RZ7OqKOo6m3B
         Da9Q==
X-Gm-Message-State: APjAAAUjAV/aqF4wyqujwtq8PlbB9gyemricaBPsQbjDCUlaXL7c62fc
        MfQ3FjA1gGZ/9yB5Jr8OQqz8WTsH3kCzVbFFo+ZvKg==
X-Google-Smtp-Source: APXvYqwCbK8UAY4G8UW8Ik4Aqqfmc0uyc/xOU9otg9ZLSwrBkH5yXF/oWyJq1+PXzp3ELrxauM9OAvX0ZYePUDLj4wo=
X-Received: by 2002:a9d:75d0:: with SMTP id c16mr10238245otl.32.1571077834222;
 Mon, 14 Oct 2019 11:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-2-dancol@google.com>
 <CAG48ez3yOPAC3mTJdQ5_8aARQPe+siid5jaa8U+aMtfj-bUJ2g@mail.gmail.com> <CAKOZuet4VM-P_xm9R7cJO2_f60eUcqt5wHG8+khJedhctfEEhw@mail.gmail.com>
In-Reply-To: <CAKOZuet4VM-P_xm9R7cJO2_f60eUcqt5wHG8+khJedhctfEEhw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 14 Oct 2019 20:30:07 +0200
Message-ID: <CAG48ez1Tdm+iz3-H7OZ2v9-zmWg-73zwEsupDxmnEymZM_C3DA@mail.gmail.com>
Subject: Re: [PATCH 1/7] Add a new flags-accepting interface for anonymous inodes
To:     Daniel Colascione <dancol@google.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 8:16 PM Daniel Colascione <dancol@google.com> wrote:
> On Mon, Oct 14, 2019 at 8:39 AM Jann Horn <jannh@google.com> wrote:
> >
> > On Sat, Oct 12, 2019 at 9:16 PM Daniel Colascione <dancol@google.com> wrote:
> > > Add functions forwarding from the old names to the new ones so we
> > > don't need to change any callers.
> >
> > This patch does more than the commit message says; it also refactors
> > the body of the function. (I would've moved that refactoring over into
> > patch 2, but I guess this works, too.)
> >
> > [...]
> > > -struct file *anon_inode_getfile(const char *name,
> > > -                               const struct file_operations *fops,
> > > -                               void *priv, int flags)
> > > +struct file *anon_inode_getfile2(const char *name,
> > > +                                const struct file_operations *fops,
> > > +                                void *priv, int flags, int anon_inode_flags)
> >
> > (AFAIK, normal kernel style is to slap a "__" prefix in front of the
> > function name instead of appending a digit, but I guess it doesn't
> > really matter.)
>
> I thought prefixing "_" was for signaling "this is an implementation
> detail and you probably don't want to call it unless you know what
> you're doing", not "here's a new version that does a new thing".

Ah, I guess that might be true.
