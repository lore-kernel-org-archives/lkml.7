Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77756C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 11:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3774724656
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 11:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYN2p7AP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfLNLQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 06:16:33 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46044 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfLNLQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 06:16:33 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so2250623ioi.12;
        Sat, 14 Dec 2019 03:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOWXreM1Eker5pRXUv0eyiXO51QArVEpS3Nl6aWrboI=;
        b=nYN2p7APSUWSG9BiyRr5KNZ8RAqoPCiPPGx6hh1wwsKHwhrrpSOEJ82K6mdQRDCA2g
         PDREK6Lur8VH3OBZ9qwbgDuvpmX2iPSBMCjeVjQu+knhI5qXnY3p4QabIt5cgrBsbNHP
         SyJR0S3S1iPm1SETJ0A1W5T3uS9SyRTCeWKtoQtt5QDqVuZ08tiie85kNR0QpsFisqQd
         6j8qudVhD6Ha9Rd1WoCGX38rGO7zOYz1p7FXQQ198tlOqOXmXcQrj3hv4oRFAzGVlpj6
         mnKln2ExeZDYJwNwYwCyEIv+eeYRzLlPP4e9NX7bpDnPmPCDAVox+VbmSKz6YcNJ7G8P
         whTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOWXreM1Eker5pRXUv0eyiXO51QArVEpS3Nl6aWrboI=;
        b=bi9IbqN6XAhr5Fp1STSg/v4y+a5J0tZTVoT64oZiIf2Oh48hLvEy3cKlecCoRXQ9jt
         wnXKwpAtXaUvEBa9ZolE1imsSZhk9RVX5LwkjY0Sy9Me/pTw48x+lu2zoa6vwNlrvJQe
         43fp8jIq6wvGbhC8fN5a1do3tLqmsmKb5Zy1Y2qkwfK87+uHEP1UCp8cDXBM30VfOBCC
         NGyTZHDUTBUdK37jiS5KyvXsd8P0bkpeFu4Db8wr8rlHd4mza/cXiROJn0EK0pxLJzVN
         Rjvj2oTjChKTHrjdeAxlrOsHWyXcEw5UoPxt6LLIMELOYtH0beXr5gbXG8g3POVZz6FD
         vOag==
X-Gm-Message-State: APjAAAXY0q4pFVIWffxbxn4hNMrVJwBo8RwcO0lu0VnNZRHVmx8nznBI
        gn4I9/wEhoYY0gKf820FAzp/zlircA/h566HKgY=
X-Google-Smtp-Source: APXvYqzHr+YPLOX1WWLc7bTs9855C5opCiJi7zIgAw/iMDTd+ruuUYfm7S2PbuyX8tPE2rjeD+q727hSZghQRDbMdEs=
X-Received: by 2002:a6b:6118:: with SMTP id v24mr9038878iob.73.1576322192347;
 Sat, 14 Dec 2019 03:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20191211160734.18087-1-mmarchini@netflix.com>
In-Reply-To: <20191211160734.18087-1-mmarchini@netflix.com>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Sat, 14 Dec 2019 14:16:21 +0300
Message-ID: <CALYGNiOtYgyCTAZn_Ti4wF+64a-mB=T9JdSb8+pyy7Aavq6Wfw@mail.gmail.com>
Subject: Re: [PATCH] perf map: fix infinite loop on map_groups__fixup_overlappings
To:     Matheus Marchini <mmarchini@netflix.com>
Cc:     linux-perf-users@vger.kernel.org, jkoch@netflix.com,
        =?UTF-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0g0JPQtdC90L3QsNC00YzQtdCy0LjRhyDQpdC70LXQsdC90LjQutC+?=
         =?UTF-8?B?0LI=?= <khlebnikov@yandex-team.ru>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Song Liu <songliubraving@fb.com>,
        John Keeping <john@metanate.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 7:10 PM Matheus Marchini <mmarchini@netflix.com> wrote:
>t
> In some cases, when using perf inject and there are JIT_CODE_MOVE
> records in the jitdump file, perf will end up in an infinite loop on
> map_groups__fixup_overlappings, which will keep allocating memory
> indefinitely. This issue was observed on Node.js (with changes to
> generate JIT_CODE_MOVE records) and on Java.

Could you show what it prints with -vv ?
I suppose map tree could be broken, like there is zero (or negative) size maps.

This should help to catch that

--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -848,13 +848,18 @@ static void __maps__insert(struct maps *maps,
struct map *map)
        const u64 ip = map->start;
        struct map *m;

+       assert((map->start < map->end) || !map->end);
+
        while (*p != NULL) {
                parent = *p;
                m = rb_entry(parent, struct map, rb_node);
-               if (ip < m->start)
+               if (ip < m->start) {
+                       assert(map->end <= m->start);
                        p = &(*p)->rb_left;
-               else
+               } else {
+                       assert(m->end <= map->start);
                        p = &(*p)->rb_right;
+               }
        }

        rb_link_node(&map->rb_node, parent, p);


>
> This issue started to occur after 6a9405b56c274 (perf map:
> Optimize maps__fixup_overlappings()). To prevent it from happening,
> partially revert those changes without losing the optimizations
> introduced in it.
>
> Signed-off-by: Matheus Marchini <mmarchini@netflix.com>
> ---
>  tools/perf/util/map.c | 17 +++++++++++++++++
>  tools/perf/util/map.h |  1 +
>  2 files changed, 18 insertions(+)
>
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 744bfbaf35cf..8918fdb8ddab 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -781,6 +781,21 @@ static void __map_groups__insert(struct map_groups *mg, struct map *map)
>         __maps__insert(&mg->maps, map);
>  }
>
> +int map__overlap(struct map *l, struct map *r)
> +{
> +       if (l->start > r->start) {
> +               struct map *t = l;
> +
> +               l = r;
> +               r = t;
> +       }
> +
> +       if (l->end > r->start)
> +               return 1;
> +
> +       return 0;
> +}
> +
>  int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE *fp)
>  {
>         struct maps *maps = &mg->maps;
> @@ -821,6 +836,8 @@ int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE
>                  */
>                 if (pos->start >= map->end)
>                         break;
> +               if (!map__overlap(map, pos))
> +                       continue;
>
>                 if (verbose >= 2) {
>
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index 5e8899883231..1383571437aa 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -132,6 +132,7 @@ static inline void __map__zput(struct map **map)
>
>  #define map__zput(map) __map__zput(&map)
>
> +int map__overlap(struct map *l, struct map *r);
>  size_t map__fprintf(struct map *map, FILE *fp);
>  size_t map__fprintf_dsoname(struct map *map, FILE *fp);
>  char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
> --
> 2.17.1
>
