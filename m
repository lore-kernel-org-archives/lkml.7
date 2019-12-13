Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B73FC2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159532077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyMlv/TF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLMWj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 17:39:29 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41418 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMWj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 17:39:29 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so1239202ioo.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 14:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=74v7HiGgbBAHeNKMpHqgEqCmBPHFoyU/JV2AnPu0Ks4=;
        b=FyMlv/TFQVgFTyUG/KC5Ts/sLnkjnrivcYQS/lYuenlqWbDQMh9abPLIksU7zHBfog
         Kyr3qaDPHv35G8ouO/au7hPkIZkCDzv9Z8DvJTFjz47EI2p+rtJ00H+AOLsDyZgDw1+8
         ey8mfhj7+zXm74Yt54z2vlM33gn4kiyJohwGL6J8dV53Kh4aLFjJqtHQv2IbRAKh/Nlf
         amn3d90/Gs1qXATP/z5TSRDTx1AOoqE71/AoFBvuRljl4ufz18VkVubN/tLyYMngSuq2
         QVRMZ/4Ezxj04h36tvgYK3XZvLu07Nrenabo/HzZo/ODrnpbSkbC0cuUXmWtp9kzu3mV
         BCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74v7HiGgbBAHeNKMpHqgEqCmBPHFoyU/JV2AnPu0Ks4=;
        b=S3zg3O+Sqq4HXZbWvK8KVcul+fjUDB2eSo+p2WnX0MmGO+IQrcn5swCv7oH64pLnTh
         eDxOo/mHO/QPmeg+5xRAT49hjAbxLWIagszvyv2oUfRtTXhE810Uli6dVntGKEy1idzk
         Ywpfcf4aLhXT4X1Raa2IqMmRKDoW/kZMIGgllW8D4wMnbUQhWf5ki6/i8jEQGI3FKQTH
         g0e2tVBXKra6DU8n4JRC2GTpMKAbfZWO0ruY+qZoLH/IglYnmQgOfpBQzmI5BGgjT9Pr
         ug95bK6ISZc/SokLuTdwuvK4kWXRWonca65BiuBhXjxUIHGsiDQj/Zi699vWCUPxcD7n
         cHAA==
X-Gm-Message-State: APjAAAXVXCNHpbTo+cemlHx4PaTToP7aua5yhi47FSaW3hggBkl2qHnM
        DXL9+zo8d1tVkVO+sX+zmn0hoZ2KaCcZQQnVSk4JUZA0
X-Google-Smtp-Source: APXvYqz110abgkf5DuKNPQRJsYOsoXz79z+Ilra9uwCaSXuv4YUYfvIOpGNBA/WzyiRVAf+mofqVDym14bQQW2cwJtg=
X-Received: by 2002:a5d:8744:: with SMTP id k4mr9894528iol.227.1576276768696;
 Fri, 13 Dec 2019 14:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20191211174653.4102-1-navid.emamdoost@gmail.com>
 <9a692d27-4654-f1fc-d4c5-c6efba02c8a9@nvidia.com> <20191213142332.d7fafc243291eac302375c32@linux-foundation.org>
In-Reply-To: <20191213142332.d7fafc243291eac302375c32@linux-foundation.org>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Fri, 13 Dec 2019 16:39:17 -0600
Message-ID: <CAEkB2EQ=sm-myT4jgJ+i0Cy5Gv=DH7vvixc1Dpz5V-Zt+P5oMQ@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: Fix memory leak in __gup_benchmark_ioctl
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 4:23 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 13 Dec 2019 13:40:15 -0800 John Hubbard <jhubbard@nvidia.com> wrote:
>
> > On 12/11/19 9:46 AM, Navid Emamdoost wrote:
> > > In the implementation of __gup_benchmark_ioctl() the allocated pages
> > > should be released before returning in case of an invalid cmd. Release
> > > pages via kvfree().
> > >
> > > Fixes: 714a3a1ebafe ("mm/gup_benchmark.c: add additional pinning methods")
> > > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > > ---
> > >  mm/gup_benchmark.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
> > > index 7dd602d7f8db..b160638f647e 100644
> > > --- a/mm/gup_benchmark.c
> > > +++ b/mm/gup_benchmark.c
> > > @@ -63,6 +63,7 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
> > >                                         NULL);
> > >                     break;
> > >             default:
> > > +                   kvfree(pages);
> > >                     return -1;
> > >             }
> > >
> >
> > Hi,
> >
> > The patch is correct, but I would like to second Ira's request for a ret value,
> > and a "goto done" to use a single place to kvfree, if you don't mind.
> >
>
> Fair enough.
>
> And let's make it return -EINVAL rather than -1, which appears to be
> -EPERM.

Sure! patch v2 has been sent.
>
> --- a/mm/gup_benchmark.c~mm-gup-fix-memory-leak-in-__gup_benchmark_ioctl-fix
> +++ a/mm/gup_benchmark.c
> @@ -26,6 +26,7 @@ static int __gup_benchmark_ioctl(unsigne
>         unsigned long i, nr_pages, addr, next;
>         int nr;
>         struct page **pages;
> +       int ret = 0;
>
>         if (gup->size > ULONG_MAX)
>                 return -EINVAL;
> @@ -64,7 +65,8 @@ static int __gup_benchmark_ioctl(unsigne
>                         break;
>                 default:
>                         kvfree(pages);
> -                       return -1;
> +                       ret = -EINVAL;
> +                       goto out;
>                 }
>
>                 if (nr <= 0)
> @@ -86,7 +88,8 @@ static int __gup_benchmark_ioctl(unsigne
>         gup->put_delta_usec = ktime_us_delta(end_time, start_time);
>
>         kvfree(pages);
> -       return 0;
> +out:
> +       return ret;
>  }
>
>  static long gup_benchmark_ioctl(struct file *filep, unsigned int cmd,
> _
>


-- 
Navid.
