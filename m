Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF52C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1143A2184B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hxk6PkJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfEVKC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:02:59 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39629 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbfEVKC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:02:58 -0400
Received: by mail-oi1-f196.google.com with SMTP id v2so1136770oie.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 03:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=47TiyBCz41Yx1Bv/NNksDp+zVbcuSGdQexnBZ0Z9rP4=;
        b=Hxk6PkJx0M1SEl/EATamZoo1PbzAmcXNEwVjqmBc+SnUwmrdzF2iuUVjWEjQ6cI+fR
         67M5NTPxRJOcMbUUkAWrsfwRUyL6YyPpbzv89mnmsCa+sRIJGeOnSwS9nyn5CM+vzhGE
         hxE0bbOlNDDP5d+gog20x4heHjwnStDaj7Xy2R2YlPenUJz6iZoqb5Em/Ynp6TUvs/zv
         YVJ21wXJTwNi5pm9CBizLH4TY4HK1XmXxvq2U4kdq8YXhcteZnMwKitwhW4bHxVozsbf
         MM7ZMDCGprZ82beyTbXJh00k98J4Hqp4EDcTqF5Xw91mVShWdm/gvFO3/lYki/81Kgjs
         2jCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47TiyBCz41Yx1Bv/NNksDp+zVbcuSGdQexnBZ0Z9rP4=;
        b=m9gggfBhqHZTvvDBuPYk0kRRVxFXbTcbxf607z7+SD2KbeUmKZB0T4FHBlp0G8LFDW
         oAs4H6DngMfiFHt+LDnOoXax1DWYxvzywsF5IA5FBkZ5EZKUCi4ov44nNNbgbOQOvHhL
         k7sl1dAEyWBz7hNCK2Kv+k06qAC0ZCP3splyryJK6hkHFea0ecWnI2UtY5MKbJnAIuf1
         Fp+0n47KewczHFOhEMcUe/vEoDsc9saT9PFVIOV/5mi9ooyfIqF6TP2/rvH9pkLRPy8j
         QPY31Jm70LF9ciDHUUB62OCpGVaPU/YTz4gpkrYQg3SxU6oQvw0wXaLtCV0cm6SaKJZa
         KUBw==
X-Gm-Message-State: APjAAAUgmhGipDeEjlj5J9Egb4dYjIJoMRquLigqoyAHRCljLaIuMWqN
        UpD/0P9oHHuQ06rvZjutonikzogxSO3pJA+JhkZyVg==
X-Google-Smtp-Source: APXvYqxn2zuZFxT6AuzcL2G2owEvKVqlQddmjBsLX4hBZYveZsSf0+nswnaPVACN+eD/e/rS8IjO6U0C2AmMC7ytPx0=
X-Received: by 2002:aca:e044:: with SMTP id x65mr4232447oig.70.1558519377524;
 Wed, 22 May 2019 03:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190517131046.164100-1-elver@google.com> <201905190408.ieVAcUi7%lkp@intel.com>
 <20190521191050.b8ddb9bb660d13330896529e@linux-foundation.org>
In-Reply-To: <20190521191050.b8ddb9bb660d13330896529e@linux-foundation.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 22 May 2019 12:02:46 +0200
Message-ID: <CANpmjNPYoaE6GFC1WC2m1GsGjqWRLfuxdi86dB+NCFeZ93mtOw@mail.gmail.com>
Subject: Re: [PATCH] mm/kasan: Print frame description for stack bugs
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've sent v3. If possible, please replace current version with v3,
which also includes the fix.

Many thanks,
-- Marco


On Wed, 22 May 2019 at 04:10, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sun, 19 May 2019 04:48:21 +0800 kbuild test robot <lkp@intel.com> wrote:
>
> > Hi Marco,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on v5.1 next-20190517]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> >
> > url:    https://github.com/0day-ci/linux/commits/Marco-Elver/mm-kasan-Print-frame-description-for-stack-bugs/20190519-040214
> > config: xtensa-allyesconfig (attached as .config)
> > compiler: xtensa-linux-gcc (GCC) 8.1.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=8.1.0 make.cross ARCH=xtensa
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
>
> This, I assume?
>
> --- a/mm/kasan/report.c~mm-kasan-print-frame-description-for-stack-bugs-fix
> +++ a/mm/kasan/report.c
> @@ -230,7 +230,7 @@ static void print_decoded_frame_descr(co
>                 return;
>
>         pr_err("\n");
> -       pr_err("this frame has %zu %s:\n", num_objects,
> +       pr_err("this frame has %lu %s:\n", num_objects,
>                num_objects == 1 ? "object" : "objects");
>
>         while (num_objects--) {
> @@ -257,7 +257,7 @@ static void print_decoded_frame_descr(co
>                 strreplace(token, ':', '\0');
>
>                 /* Finally, print object information. */
> -               pr_err(" [%zu, %zu) '%s'", offset, offset + size, token);
> +               pr_err(" [%lu, %lu) '%s'", offset, offset + size, token);
>         }
>  }
>
> _
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20190521191050.b8ddb9bb660d13330896529e%40linux-foundation.org.
> For more options, visit https://groups.google.com/d/optout.
