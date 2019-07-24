Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3793C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924E3217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MT7C+GiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfGXUqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:46:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38234 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfGXUqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:46:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so45801008ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 13:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jchNrpEFta2pR8g8F+xkNJeAvSbMUE7xllhKBLOSK2c=;
        b=MT7C+GiDQsqfC6X4YF7XxqEjuHYQy6MkJXzY4VC0qhnNA7PObwYrofbT0r598vkaqm
         tZd01yPjirtGKecjfAo34GEk7/kG/ltr2AkDz4xEN22dwQQmQ4xTWp+vmZg+uRHb7ACL
         37l+PyATPULqjEz3PWn7dodMVvq3EtqfVP0OHwtsKRWIYMB95cxIP3yBLfwwy5zSPiPa
         H5fQ0tFczUX9E2hmwBqB5Jwios+1t4mTttpb0hKRTQfCEoQXL+PiHvOhsXknjLaMK4Vc
         msC92JHlEnCp9cWJnB2PcX/Afmg3RThj36Nl5GOUvXTPeKvth4kwjALe4x/d6e21L9f6
         Aq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jchNrpEFta2pR8g8F+xkNJeAvSbMUE7xllhKBLOSK2c=;
        b=eVzj9sJb6s6AXaMUJS3pUp6n85ZZIzLMKZvN+AoYYkMzZr4qquuF9FdXbkh6P7VSOl
         loEYrPiK1o+cE/N03UqR0u9ZugS/cHYeyfHkkaMeyITFYLG9/p+i3UqOQeSitv4N3vrf
         P01YNt5GdrifKtbV6DbeFKYfxns0Yz5lf80UQZil1QIWOFqFy/Yi4At3LsqNvueUkx0O
         hYnMP23FETM7VWT9A014feSnAJpq4GO93GSeuUoVC0pjwnr/xxaWbK32ZItFSvPagCNX
         ni1C51rUEOC6ivcxJ3FBWsbXSanbF/82y9KdLQtMmKtWtV6qqCjj49KRtNQkrgjFfm0f
         ngug==
X-Gm-Message-State: APjAAAULhoU9lkm+x9bJoD8PltlZqB0EuzqNQOgnt3n0NzTtWf7UkgXE
        TUf7FqEtozJDEkgQEdiYWWynVVBKN8AS4+oMbw==
X-Google-Smtp-Source: APXvYqws44gRqgHRNLZfmXyFQsmnH97j7fLY7u2xaxMTGUblpGERsrTI10OKVZzx4H5OjfRs/HLBGzdeE07/cNF9yXE=
X-Received: by 2002:a2e:9dc1:: with SMTP id x1mr44291493ljj.0.1564001163840;
 Wed, 24 Jul 2019 13:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190723124951.25713-1-baijiaju1990@gmail.com>
In-Reply-To: <20190723124951.25713-1-baijiaju1990@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 24 Jul 2019 16:45:52 -0400
Message-ID: <CAHC9VhQJwif4NXVydmQkTUXgM8Xnp5rG_zscXmKc5_CSYo-e5w@mail.gmail.com>
Subject: Re: [PATCH] kernel: auditfilter: Fix a possible null-pointer
 dereference in audit_watch_path()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 8:50 AM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> In audit_find_rule(), there is an if statement on line 894 to check
> whether entry->rule.watch is NULL:
>     else if (entry->rule.watch)
>
> If entry->rule.watch is NULL, audit_compare_rule on 910 is called:
>     audit_compare_rule(&entry->rule, &e->rule))
>
> In audit_compare_rule(), a->watch is used on line 720:
>     if (strcmp(audit_watch_path(a->watch), ...)
>
> In this case, a->watch is NULL, and audit_watch_path() will use:
>     watch->path
>
> Thus, a possible null-pointer dereference may occur in this case.
>
> To fix this possible bug, an if statement is added in
> audit_compare_rule() to check a->watch before using a->watch.
>
> This bug is found by a static analysis tool STCheck written by us.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  kernel/auditfilter.c | 2 ++
>  1 file changed, 2 insertions(+)

Thank you for taking the time to analyze the kernel's audit subsystem
and send a report, but I believe this is a false positive.

The only way we can hit the AUDIT_WATCH comparison in
audit_compare_rules is if both rules are AUDIT_WATCH rules, and when
we create the audit_krule entries we ensure that the watch field is
correctly populated for AUDIT_WATCH rules, see the
audit_data_to_entry() and audit_to_watch() functions.

If you disagree with this, please let us know, but as of right now I
don't believe there is a problem here.

> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index b0126e9c0743..b0ad17b14609 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -717,6 +717,8 @@ static int audit_compare_rule(struct audit_krule *a, struct audit_krule *b)
>                                 return 1;
>                         break;
>                 case AUDIT_WATCH:
> +                       if (!a->watch)
> +                               break;
>                         if (strcmp(audit_watch_path(a->watch),
>                                    audit_watch_path(b->watch)))
>                                 return 1;
> --
> 2.17.0

-- 
paul moore
www.paul-moore.com
