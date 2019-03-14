Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2760C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE75205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfCNJHw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:07:52 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35312 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCNJHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:07:52 -0400
Received: by mail-vs1-f66.google.com with SMTP id e1so1778367vsp.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 02:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+wA7WEdatafTwrBsI9kco+k6FbaaexDv9oaeFWOEIsw=;
        b=fCqhN8Uk71jgcWqf6MqVqJ+ZnE6DB3R7x3Vxqlo4XsGbnPzor46XVBNN4gRAzrqZee
         I8Kga2LAYo9030hpsI0d+IkdS94cpLhCK4bq8XUSoYSQdIybxneJecqr5EtdOyY9eco7
         pwNR8HgcDpf1BjE/y3dRkD5ezb5eJNeHPvRtkqfZTXcJAuPD7GKpptyIYnp0HtPgS4pa
         AaSFwlhfUcauhsYVW0VRLVtdOf7PjTOCISQsVNMFSHAkiHIpESln1JXnu9SIpWzFhIj1
         5JVu22YU9DZl0qJ9SDpS4vIvV1c5jYthuA2bmyqzGNlAKODrITXqydBsbpgn6RLm4TL2
         c1vA==
X-Gm-Message-State: APjAAAXAp4iiLJ6j8+AYV2IY2pvHGsqk+yUsSowqEJQFWXLkA/28US9z
        c5nPLKYC8yIvzuZOk31vTg/WMkGjc6W5DTQHUww=
X-Google-Smtp-Source: APXvYqx9gI/sDuzROvcWnaXWvnAsHFEVFSc03qckgL6Nlo1f+RJ7fkzJ4CPIBEQiW6N+EYl7pncIQjjjeTA8ANtvS5Q=
X-Received: by 2002:a67:ebcd:: with SMTP id y13mr3680960vso.152.1552554471045;
 Thu, 14 Mar 2019 02:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <19432668-ffd3-fbb2-af4f-1c8e48f6cc81@infradead.org>
In-Reply-To: <19432668-ffd3-fbb2-af4f-1c8e48f6cc81@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Mar 2019 10:07:39 +0100
Message-ID: <CAMuHMdUxPv+jjk894j8rLhn+Q7FWHz2LRCKLOyOXOvPd_LXoQg@mail.gmail.com>
Subject: Re: [PATCH -mmotm/-next] fs: fs_parser: fix printk format warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 9, 2019 at 4:21 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix printk format warning (seen on i386 builds) by using ptrdiff
> format specifier (%t):
>
> ../fs/fs_parser.c:413:6: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘int’ [-Wformat=]

Now seen in upstream on all 32-bit platforms, I guess.

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
