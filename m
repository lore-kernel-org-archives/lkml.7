Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5810FC7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265BE2083B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJtUCU9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfG0Qos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 12:44:48 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:47041 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfG0Qos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 12:44:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id z23so30101409ote.13
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 09:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxbfUz9YUQxUJQuuEVPnw0FpsyVuxmGe9mWc6z1mpmc=;
        b=NJtUCU9Pg+JecRH5sfC1kTAirRTjO2Syik66f2PE37N4iAxJo4hxAv7EmcmgU1RZIp
         o2qn92hrF7ouBq6NieF6WGvIPE4kFItJ4P3ucLWwDI8rPaAvZTDJMR9qGRkLLphEGIZb
         Ql/HH7aKJQRy3P3hTFbfxVi8mL03iecaVsiID/SedZuict3//YexTVOWWuD4T6wGSvPY
         7zC0W2Vfyixt41DC0e1bhwNVl3iCKw0OMnCxHuLKINQIc7EDSK1zLDveiKogliU+1hJH
         Yuwy9HsIEad86LJxhzE9/+b7O2kyEqiMFhE7FUec4YrsvDsVLmOsAK8VA+kT+ShVaQHN
         NEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxbfUz9YUQxUJQuuEVPnw0FpsyVuxmGe9mWc6z1mpmc=;
        b=TbBYfKbNTvGr768IVNSLfEc+xm+MrxRbooVObYlNr8IW79eZF5lHM4oQmSxkKH1d5M
         6wBesVGAqeIcaWQNOFkKH1/+zvfBjzybA2aZbaNAIz/iJxOJA9p//43HGyLdKzn3Z8DD
         MmTvQBH4/0iLfufzTltcL2uj+UXtHg0ZuiA2iM1xkXB6LNOWRjN/YKkMEkKUHXV/7+tg
         UbXN6JWVyywYWwk7dSre/7Vu1SFYMhClpRMBY/8MqwQOH/ZlPCbohbZ38EpGBF8FTLsR
         JUZz0tYXFm2IPircYQAxcvgMEHvRV65h4Rv91pHpMp3IfipuaoXyOyhWMZ7pTU9bnKrK
         lpWg==
X-Gm-Message-State: APjAAAVYuxBMcMBhPfyEcKWUJH4i/IgGHRDjCQkLbFgfqAmpCVyU7v9T
        1M5wOcXYiZNOGSTDm7nOTo0LrkU2PNCLRbxc5Tk=
X-Google-Smtp-Source: APXvYqyBQgzDnte0g4uHiBAg3nkxHWBNTGbNj3O+BMlRYhSlAlDr3MA3IMQ2aTyB9x2cAnxkaop1dPaVhNEgkny0YLE=
X-Received: by 2002:a9d:67cf:: with SMTP id c15mr8289343otn.326.1564245887547;
 Sat, 27 Jul 2019 09:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190725184253.21160-1-lpf.vector@gmail.com> <20190726072637.GC2739@techsingularity.net>
In-Reply-To: <20190726072637.GC2739@techsingularity.net>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Sun, 28 Jul 2019 00:44:36 +0800
Message-ID: <CAD7_sbHwjN3RY+ofgWvhQFJdxhCC4=gsMs194=wOH3tKV-qSUg@mail.gmail.com>
Subject: Re: [PATCH 00/10] make "order" unsigned int
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        vbabka@suse.cz, Qian Cai <cai@lca.pw>, aryabinin@virtuozzo.com,
        osalvador@suse.de, rostedt@goodmis.org, mingo@redhat.com,
        pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 3:26 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>

Thank you for your comments.

> On Fri, Jul 26, 2019 at 02:42:43AM +0800, Pengfei Li wrote:
> > Objective
> > ----
> > The motivation for this series of patches is use unsigned int for
> > "order" in compaction.c, just like in other memory subsystems.
> >
>
> Why? The series is relatively subtle in parts, particularly patch 5.

Before I sent this series of patches, I took a close look at the
git log for compact.c.

Here is a short history, trouble you to look patiently.

1) At first, "order" is _unsigned int_

The commit 56de7263fcf3 ("mm: compaction: direct compact when a
high-order allocation fails") introduced the "order" in
compact_control and its type is unsigned int.

Besides, you specify that order == -1 is the flag that triggers
compaction via proc.

2) Next, because order equals -1 is special, it causes an error.

The commit 7be62de99adc ("vmscan: kswapd carefully call compaction")
determines if "order" is less than 0.

This condition is always true because the type of "order" is
_unsigned int_.

-               compact_zone(zone, &cc);
+               if (cc->order < 0 || !compaction_deferred(zone))

3) Finally, in order to fix the above error, the type of the order
is modified to _int_

It is done by commit: aad6ec3777bf ("mm: compaction: make
compact_control order signed").

The reason I mention this is because I want to express that the
type of "order" is originally _unsigned int_. And "order" is
modified to _int_ because of the special value of -1.

If the special value of "order" is not a negative number (for
example, -1), but a number greater than MAX_ORDER - 1 (for example,
MAX_ORDER), then the "order" may still be _unsigned int_ now.

> There have been places where by it was important for order to be able to
> go negative due to loop exit conditions.

I think that even if "cc->order" is _unsigned int_, it can be done
with a local temporary variable easily.

Like this,

function(...)
{
    for(int tmp_order = cc->order; tmp_order >= 0; tmp_order--) {
        ...
    }
}

> If there was a gain from this
> or it was a cleanup in the context of another major body of work, I
> could understand the justification but that does not appear to be the
> case here.
>

My final conclusion:

Why "order" is _int_ instead of unsigned int?
  => Because order == -1 is used as the flag.
    => So what about making "order" greater than MAX_ORDER - 1?
      => The "order" can be _unsigned int_ just like in most places.

(Can we only pick -1 as this special value?)

This series of patches makes sense because,

1) It guarantees that "order" remains the same type.

No one likes to see this

__alloc_pages_slowpath(unsigned int order, ...)
 => should_compact_retry(int order, ...)            /* The type changed */
  => compaction_zonelist_suitable(int order, ...)
   => __compaction_suitable(int order, ...)
    => zone_watermark_ok(unsigned int order, ...)   /* The type
changed again! */

2) It eliminates the evil "order == -1".

If "order" is specified as any positive number greater than
MAX_ORDER - 1 in commit 56de7263fcf3, perhaps no int order will
appear in compact.c until now.

> --
> Mel Gorman

Thank you again for your comments, and sincerely thank you for
your patience in reading such a long email.

> SUSE Labs
