Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACD7C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E680C26378
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfEaBIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 21:08:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46310 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfEaBIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 21:08:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id l26so6481673lfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 18:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=22GphBC4iQMWrcK9lLTSPr58LtVk4GbbDGfuWv/oHsQ=;
        b=Ce44JVWKG9rNRWgkA2cmi56fCl2QAsWmY08q1qoA/6yFd2MHwPy2tw2A+ndjrCRVKx
         bsioEin+I9jPF6f9b8pp67a1xhWHBSosH4p/kK+GZBSAdQwo4jz9c1j/PSPESAng+7Ms
         9AQZqHcF0F9rb6UjZTYUJ6J4DCoY/5vtheD7jA7In4H+PZ+9qOb2e6S65TxEdGGA+bez
         2b+kd8rUXhMhDvs+dJye0bcG7BXy5JdKYcP9gvlLZG2wzNhVtZs+c6TFHe5KpSf9PES7
         TM+d7SVLX+F0fTtAf/c3MkajMHEKKzSY1lCMRIOUR8hRShxBMK9uIPL7NNTn7Mo4xJfp
         QY9w==
X-Gm-Message-State: APjAAAWy+INNm7vwyyJd+0pt94lk5z0nw3C+Wlf5vCMVKkv4IbmLtdGU
        BTRtw7DBvKUcpG9AHjqySz9jLU1Mb+67JI4OS+4cFQ==
X-Google-Smtp-Source: APXvYqzB0gS98dd3NaWuJgQk0dYOESrlfONczM8v4x74bmiXAtBh2YAlWmz8cDnLHFtBRyBHSIqZdTCxoifEEBWOaxQ=
X-Received: by 2002:a19:ed07:: with SMTP id y7mr4011314lfy.56.1559264930681;
 Thu, 30 May 2019 18:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190530235101.3248-1-mcroce@redhat.com> <685e8554eed17eebc731d62336ef30eb44bd14f7.camel@perches.com>
In-Reply-To: <685e8554eed17eebc731d62336ef30eb44bd14f7.camel@perches.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Fri, 31 May 2019 03:08:14 +0200
Message-ID: <CAGnkfhwYpDOn=dcN-ko1eFn+WTCW+MurcHsLUa3z6xCxs9j6HQ@mail.gmail.com>
Subject: Re: [PATCH] checkpatch.pl: Warn on duplicate sysctl local variable
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 2:55 AM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2019-05-31 at 01:51 +0200, Matteo Croce wrote:
> > Commit 6a33853c5773 ("proc/sysctl: add shared variables for range check")
> > adds some shared const variables to be used instead of a local copy in
> > each source file.
> > Warn when a chunk duplicates one of these values in a ctl_table struct:
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -6639,6 +6639,13 @@ sub process {
> >                                    "unknown module license " . $extracted_string . "\n" . $herecurr);
> >                       }
> >               }
> > +
> > +# check for sysctl duplicate constants
> > +             if ($line =~ /\.extra[12]\s*=\s*&(zero|one|int_max|max_int)\b/) {
> > +                     my $extracted_string = get_quoted_string($line, $rawline);
> > +                     WARN("DUPLICATED_SYSCTL_CONST",
> > +                             "duplicated sysctl range checking value '$1', consider using the shared one in include/linux/sysctl.h" . $extracted_string . "\n" . $herecurr);
> > +             }
>
> why is $extracted_string used here?
>
>

Right, it's always empty. I'm sending a v2.

Regards,
-- 
Matteo Croce
per aspera ad upstream
