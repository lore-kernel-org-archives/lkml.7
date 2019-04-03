Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28361C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E153820663
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzvWKvfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDCUk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:40:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46906 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCUk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:40:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so144888pfj.13;
        Wed, 03 Apr 2019 13:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R6sB+eZv5XDJt4LxJ3FxrEdpApWyYK/s4Yo72IFvtIA=;
        b=DzvWKvfjC+lmj6tAE5Duu2sNOMET62H4Jz5tK92f3HqGS+pnG/sttt8t3jhWXaNjMa
         yvufDGhH7xWMxmH/VzNLQjKOLVgu5nOLeTroJRCFwT9GnqgMTIT+C5h0QF51hnalVUIQ
         /rwwKe+WOmyeD4NLDhSfUdwy/j/TD7OrxIvbImCk9kCcseG3FlGQOGZqsgGvJc3EfjeH
         59y/Cjs5klm9GAQaoLtuPW7cwLWGKyuwytvI4EdLB2LEIc671f7LiJtPQrs2MvUPd9Ey
         Ax+BhYFpPlo5CvZQ0RJ780Wnt/f0zoPIdK5FdJqWkNSjtYuJsHA4lhS2y9deKE8WhHGL
         03cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R6sB+eZv5XDJt4LxJ3FxrEdpApWyYK/s4Yo72IFvtIA=;
        b=r6J1UarRBsQqfpsplJvfZCay9Sh18L4RlfEv00UNiAxrSFEnDoO59hnBXV7WDC1tjA
         WiCVfieCV57UhZ/SCCCN6JFyg8qL+hBdyuEaswCzusCIYgTUS0B7DOyNyfWWbXgdPenf
         aUxBqzmH01NbfxdAqaoi84L0xu7DO0ub9zpotUL6FzeqOjszgU5/DB/QS8X84hfi4e3t
         gE0a6KK/S4O3CU++famfCC0+aSfd8HO0WCBqhn7tLwHvltr+0UicXOhzEeZzBngiRcTy
         BRRSLR9Ko+5q2jt3xRf2XC/qo7JHA0xtC1zVNndP9G92t3PZ5NAMNioReO3y9XB1hByV
         1rlA==
X-Gm-Message-State: APjAAAX5vOHnvVgJCGs7Ow5FrojjGizm8gT/QmKlUG0q95hDdY0H/VOM
        2NHN5y5jITJ23a6TDTPXdOHFKsNkVWZKXg4Sid0=
X-Google-Smtp-Source: APXvYqyiTPFlfAixvte0/t8Ou5Yn87RfiBQ4HY9qP6xIAR5qmWScF581epo0sXdGOdc+AR5evAVDpaqHmTwHOlbSexk=
X-Received: by 2002:a65:6210:: with SMTP id d16mr1745509pgv.110.1554324025035;
 Wed, 03 Apr 2019 13:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190329001135.15847-1-changbin.du@gmail.com> <CAJZ5v0gKX9E+U_9eKfTr7pWGH=jxMLz_Jr850-6BcbG3xBz5qg@mail.gmail.com>
 <CAJZ5v0jbCi3Jgn5YXPCP+zgs-O7z-9_3p3XZGvm40_6RDsJqkQ@mail.gmail.com> <20190403133613.13f3fd75@lwn.net>
In-Reply-To: <20190403133613.13f3fd75@lwn.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 Apr 2019 23:40:13 +0300
Message-ID: <CAHp75VdXffhc+2YcFNOr2XwauTt08Bw75ao2ia7cNvAqhJnUQQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] Include linux ACPI docs into Sphinx TOC tree
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 10:38 PM Jonathan Corbet <corbet@lwn.net> wrote:
> On Tue, 2 Apr 2019 10:25:23 +0200


> Admin guide
>         cppc_sysfs

>         initrd_table_override

> other:
>         dsdt-override: find another home for those five lines

This is similar to initrd_table_override for some particular case, and
sounds like Admin guide, indeed.

-- 
With Best Regards,
Andy Shevchenko
