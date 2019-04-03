Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AD8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE7B2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfDCPZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:25:06 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46949 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCPZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:25:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id r25so12007750lfn.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 08:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DePPHxBKVRe9nXoNp1hx43J2IRZmLYJbKxQ/4pxJPkU=;
        b=IfukaMDZk4EczOxiIOt5lckD0AEhUTkVv1a/Cw3VXzUlaLaQt4JCC8tEdPW5T07XQe
         0cb0nraLCnHjbMHGUOyZCntqmzSvSIOLfN2G7uvjQdm7lGTkowqASaeUdIvcEdjWcV8S
         Bt71l3SNcZy4apL084RAzZHmsl6wLNmMxnHmrnRjuddmrvcHmDa6w5g6l+hDkoCqnBuT
         P4w6kvQiuNZ8SAiUVOM1uS6DQmI/oE+OtdOx5gTkpJvIL2vTmunkm6MxcI6tI26rDrkC
         7sclYmHRsWbYRA5pde5s6Ht2rwfrVAQimXGOWenqReACChfozewSlQoUUqNW24oZuc2b
         bLMA==
X-Gm-Message-State: APjAAAXQZe4r6GhL9F2xBmyaZ8CzePlde3n6stHeHGd4I9EoH54tg6DH
        P6wnFtB8FK09NRrZ08hnxPMqTMLs28W7VJ6ChLgBqA==
X-Google-Smtp-Source: APXvYqwhIgn8u0uh17ioR0DHGVAwWtLS7oqva3gSwRd4Aq38GzAWpuHl0LIUnrGejIU1ypnGNNSxZChQu/yfqGqEo4c=
X-Received: by 2002:ac2:4563:: with SMTP id k3mr166053lfm.101.1554305102697;
 Wed, 03 Apr 2019 08:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190328130306.25384-1-mcroce@redhat.com> <20190403140203.qq37rgcikvoawb5f@brauner.io>
In-Reply-To: <20190403140203.qq37rgcikvoawb5f@brauner.io>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Wed, 3 Apr 2019 17:24:26 +0200
Message-ID: <CAGnkfhx+igF579dez6qwAxrtT-JrGSSEn-QmK+92447qBqXPpg@mail.gmail.com>
Subject: Re: [PATCH] kernel/sysctl.c: fix out of bounds access in fs.file-max
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Zev Weiss <zev@bewilderbeest.net>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 4:02 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Thu, Mar 28, 2019 at 02:03:06PM +0100, Matteo Croce wrote:
> > fs.file-max sysctl uses proc_doulongvec_minmax() as proc handler, which
> > accesses *extra1 and *extra2 as unsigned long, but commit 32a5ad9c2285
> > ("sysctl: handle overflow for file-max") assigns &zero, which is an int,
> > to extra1, generating the following KASAN report.
> > Fix this by changing 'zero' to long, which does not need to be duplicated
> > like 'one' and 'one_ul' for two data types.
>
> Yeah, maybe but it still feels cleaner and more obvious to just add:
>
> static long long_zero;
>
> given that most callers actually seem to want an (unsigned) int.
>
> I don't have a strong opinion though so if others feel that it's just a
> waste of space consider it acked.
>

Well, given that the value is zero, in this expectional case we could
avoid duplicating the symbol and save 4 bytes.
What the maintainers think?

Cheers,
-- 
Matteo Croce
per aspera ad upstream
