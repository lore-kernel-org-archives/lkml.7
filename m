Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA91C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 05:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974D820872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 05:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nqk3WRq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfCaFND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 01:13:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35622 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfCaFND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 01:13:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so2938842pfe.2;
        Sat, 30 Mar 2019 22:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0PYqYNJCRo47buFqpEFm5jSGLOOSre7sIa2ON3PXgE8=;
        b=Nqk3WRq0ezPyTpDtpiWvysU7mal4pr36rLw1JnjX1ypBa3vkkG3zLQnWhUpwY7qJaP
         iZeFz4BiHY6cAJJUMZ0VgFJHSJ/iKpWNH+8tRgD46CSSCqpNpDdHvGxWjzY8SerZjo4V
         rLqM6BtgTe0Xabm6wplUj/dz7ssCJqJ7UPN50Lhc35a0z2oCpBpJQFWzKJ8vXrNsr/5N
         uPsDOKA11ALxDXczuY8UB8D1bWD+qpnQlXE9tD1W6fex3F9v7Iyqf3LHUcwxvhIdqaXP
         DIaqEgQDwc5QstusEIgzsf8Ma1iDzodo/D+UbTgZbBdbLv+BNrAaHTWfAIHqXkEoAhHB
         whJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0PYqYNJCRo47buFqpEFm5jSGLOOSre7sIa2ON3PXgE8=;
        b=fo4ekuj0PxxAo7Mm/sT37w12yNg+QSnqt9KNVtf1fk30JQK0Wv2gmfEvdA5Dg+DtlM
         od2i2uLynOGvVbixFEpBnZtTj7vtWVgaURLMqNA4IGGYu63AYP6BIt8Wnb6nLthbwRBy
         8lM1nBc01HDWNHOiTrJ8kCL8cTiQcVGnrcpzm27Bh893D5PLyUkEpq3eYyS6oJ5T7bNG
         WQdqXHWwRBWP/LQh3M59+Kjrb+JrPu52iVNFvWpGe0Lu0ylipW+upuV8O6QrJZ+UnQ/N
         3zsiCge/cKLCXrmM7GdgK3lok/FeDLdQG0WySF/9FS7tfhoIO78O1SOHkZTAPwAowgob
         vq6g==
X-Gm-Message-State: APjAAAVBERYbdv4834Rz/Py5ZhFjiymPsJ1dp8ZA16NpRR60eDaeARUP
        1SvQE0hlgLqOhajVUSwoKjwR4v2cQm0=
X-Google-Smtp-Source: APXvYqwX/22NqGNoCQ0/bSrH0pbcBdfRRUUXnfm/3RPZP7YgMJSjQXcHT6X/z15jd2R/u3dR/uVhhA==
X-Received: by 2002:aa7:884b:: with SMTP id k11mr20835616pfo.49.1554009182739;
        Sat, 30 Mar 2019 22:13:02 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id l5sm14021398pfi.97.2019.03.30.22.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 22:13:01 -0700 (PDT)
Date:   Sun, 31 Mar 2019 05:13:00 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 01/24] Documentation: add Linux ACPI to Sphinx TOC tree
Message-ID: <20190331051258.7f4una2eh7eeyctb@mail.google.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
 <20190329001135.15847-2-changbin.du@gmail.com>
 <CAJZ5v0h=tpzWJrt02ET28EG9hn6eSusLV68FZCV8nnXHDBxHEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h=tpzWJrt02ET28EG9hn6eSusLV68FZCV8nnXHDBxHEQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 10:51:50AM +0100, Rafael J. Wysocki wrote:
> On Fri, Mar 29, 2019 at 1:12 AM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > Add a index.rst for trace subsystem. More docs will be added later.
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  Documentation/acpi/index.rst | 8 ++++++++
> >  Documentation/index.rst      | 1 +
> >  2 files changed, 9 insertions(+)
> >  create mode 100644 Documentation/acpi/index.rst
> >
> > diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
> > new file mode 100644
> > index 000000000000..7241ceb1673c
> > --- /dev/null
> > +++ b/Documentation/acpi/index.rst
> > @@ -0,0 +1,8 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=======================================================
> > +Linux ACPI (Advanced Configuration and Power Interface)
> 
> "Linux ACPI Support", please.
> 
sure.

> > +=======================================================
> > +
> > +.. toctree::
> > +   :maxdepth: 2
> > diff --git a/Documentation/index.rst b/Documentation/index.rst
> > index 80a421cb935e..e3aa28275894 100644
> > --- a/Documentation/index.rst
> > +++ b/Documentation/index.rst
> > @@ -90,6 +90,7 @@ needed).
> >     filesystems/index
> >     vm/index
> >     bpf/index
> > +   acpi/index
> >     misc-devices/index
> >
> >  Architecture-specific documentation
> > --
> > 2.20.1
> >

-- 
Cheers,
Changbin Du
