Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503D3C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252B22086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbtfp/Wt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390539AbfHBH4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 03:56:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37697 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390522AbfHBH4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 03:56:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1so2843266pgp.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 00:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5iFHzxMFLCwd1veKrBiPtZe9xQ3zJp+NSk+sdnei7/E=;
        b=bbtfp/Wtk+NNipDBs+/reqbPaMMq+VsfbiUf8D0iNA2VKrCGwobzEo0rCWT5JvpUoq
         frXbeZ/Wq8KwkodpvgSzPNfa4lxFGduAHFC7JHRfaAJsglKbM4RG7ZAOTFm7oYdIII3M
         8wDU8+f6XH6QdGyMQRi+PEKA1FRPF/xY6fq1B12+90+mbY9BW89eDl9QaX5XTSGidUMb
         OkzBQMSaIPyKqJrGt5ex3HFtsJ9QlUfcDBjJ9gqxMiuQSuOrpJ+QnBj2umqGpu7k8ZTS
         /m+L7k6GGLwVXjCe75CL/OTJscQqblC1roQsZ9uMmsSOtV/6FYRxxLe55IjkxQK5+bet
         lpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5iFHzxMFLCwd1veKrBiPtZe9xQ3zJp+NSk+sdnei7/E=;
        b=DzqOoWmNMYmcnMuUhtI2h3bMjgDkK1wKhI6Kh4/4my3/Gaek7RLE9nOIEflpdn9PSn
         pGZ6cgQDj5RbEzbc/b4p6/vzXJBJp1Tp79/OPZDmzGoa5T08BSJPmJvEfkcOXLfR36LG
         iDQbmjPKIUrngQdzRMsQs8xRJhNpsW5FUhV4f5EWn1e5zp+LvJXm2xNZ8US5XNmcNisp
         zfmKXdwTZRgoF+e4Y+ksXtr0CDAbCI3D/m7k1/YXhxEOzPNdJL85Pnaac7ivxmUTRN7V
         9yhO7pu3YPezjY5k9ILHbNDDPeq1R/GtLP2P0e8+wG9JTloae6G8HG+Y8I+8i8PknDrQ
         JNQQ==
X-Gm-Message-State: APjAAAWY+zNszX5BiSLJYst8klIXkkluZwVweykBZgYfh+dj8LEn3snB
        8X2sN8sFl5oNUy3wLRREsyVnnBi9GLUBY8vFpW4=
X-Google-Smtp-Source: APXvYqwqJs9nSVIt9Qbg8EhzV4Pd8dlcyTxULdSsBefvUbrhcJQgS8A5XkPa+ON1cnEr1PHkiwDqepiMKQ3lC2BTqlg=
X-Received: by 2002:a63:6eca:: with SMTP id j193mr47175048pgc.74.1564732562885;
 Fri, 02 Aug 2019 00:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190801192904.41087-1-andriy.shevchenko@linux.intel.com> <98acdfce0da0d7c3b33571528064935c107cbbc5.camel@perches.com>
In-Reply-To: <98acdfce0da0d7c3b33571528064935c107cbbc5.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Aug 2019 10:55:51 +0300
Message-ID: <CAHp75VcjgGymKsxouv_oDcwVnUp8Yc1Pi_rmi09yLnwtMsz4kQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kernel.h: Update comment about simple_strto<foo>() functions
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mans Rullgard <mans@mansr.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 4:47 AM Joe Perches <joe@perches.com> wrote:
> On Thu, 2019-08-01 at 22:29 +0300, Andy Shevchenko wrote:

> >   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> > - * Used as a replacement for the obsolete simple_strtoull. Return code must
> > - * be checked.
> > + * Used as a replacement for the simple_strtoull. Return code must be checked.
>
> Using 'the' here is unnecessary and somewhat confusing.
>
> Perhaps:
>
>  * Preferred over simple_strtoull() unless the end position is required
>  * Return value must be checked

IIRC it simple returns back to the original comment.

-- 
With Best Regards,
Andy Shevchenko
