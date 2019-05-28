Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFA1C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2017E21734
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lJ8xugHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfE1Rjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 13:39:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53110 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfE1Rjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kYTE23wo9xcLeBLAbb9YlbsCXzwUj9Kot4AhQmTrFQ4=; b=lJ8xugHK/Icu64SffdPT/N5bT1
        WjaTrUDz2sC6x4fNPuynUsomQdLR4P9sWspTjefG7VAQZAJgNh7rGBOCMlMpr7YW6ul9IVUWuoqP+
        xXCy8sLOQ0DiC6aMx3PKA6sJXElUeKXliJ1s1Sq+fZCeF0qEFzvmgnSaaueBilcV4b341xk6ljvWC
        4KvMv6yokyDtqexEX5nl661QTbATMi3p+vMOrS3B1Ut+UUNHK0yQxd83p2WnsFJ8DJoo0jmbbJ3wP
        4b+LaciyYVd63I0rs0t3ZntU8v+WjVIePiPmRSHowtm15aSm94CfST/Z2g0a1hCDnmnQBB6jkpNhX
        x3KQNYaQ==;
Received: from [179.97.35.11] (helo=sandy.ghostprotocols.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVg4d-0005xd-6W; Tue, 28 May 2019 17:39:43 +0000
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 26137109; Tue, 28 May 2019 14:39:41 -0300 (BRT)
Date:   Tue, 28 May 2019 14:39:41 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Shawn Landden <slandden@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH 05/44] perf data: Fix 'strncat may truncate' build
 failure with recent gcc
Message-ID: <20190528173941.GC2935@redhat.com>
References: <20190527223730.11474-1-acme@kernel.org>
 <20190527223730.11474-6-acme@kernel.org>
 <CA+49okqviNfP087Z34-P4mJuMYc8_PiNJgTPz0xSAxqtp4iM0A@mail.gmail.com>
 <20190528130421.GB13830@kernel.org>
 <CA+49okqAuPrs679GWQhxjyMn4mMhVSH_71Ww6rBbUjsrm2g-dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+49okqAuPrs679GWQhxjyMn4mMhVSH_71Ww6rBbUjsrm2g-dg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 28, 2019 at 11:59:10AM -0500, Shawn Landden escreveu:
> On Tue, May 28, 2019 at 8:04 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Mon, May 27, 2019 at 05:46:26PM -0500, Shawn Landden escreveu:
> > > On Mon, May 27, 2019 at 5:38 PM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > From: Shawn Landden <shawn@git.icu>
> > > >
> > > > This strncat() is safe because the buffer was allocated with zalloc(),
> > > > however gcc doesn't know that. Since the string always has 4 non-null
> > > > bytes, just use memcpy() here.
> > > >
> > > >     CC       /home/shawn/linux/tools/perf/util/data-convert-bt.o
> > > >   In file included from /usr/include/string.h:494,
> > > >                    from /home/shawn/linux/tools/lib/traceevent/event-parse.h:27,
> > > >                    from util/data-convert-bt.c:22:
> > > >   In function ‘strncat’,
> > > >       inlined from ‘string_set_value’ at util/data-convert-bt.c:274:4:
> > > >   /usr/include/powerpc64le-linux-gnu/bits/string_fortified.h:136:10: error: ‘__builtin_strncat’ output may be truncated copying 4 bytes from a string of length 4 [-Werror=stringop-truncation]
> > > >     136 |   return __builtin___strncat_chk (__dest, __src, __len, __bos (__dest));
> > > >         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >
> > > > Signed-off-by: Shawn Landden <shawn@git.icu>
> > > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > > Cc: Jiri Olsa <jolsa@redhat.com>
> > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > Cc: Wang Nan <wangnan0@huawei.com>
> > > > LPU-Reference: 20190518183238.10954-1-shawn@git.icu
> > > > Link: https://lkml.kernel.org/n/tip-289f1jice17ta7tr3tstm9jm@git.kernel.org
> > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > ---
> > > >  tools/perf/util/data-convert-bt.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
> > > > index e0311c9750ad..9097543a818b 100644
> > > > --- a/tools/perf/util/data-convert-bt.c
> > > > +++ b/tools/perf/util/data-convert-bt.c
> > > > @@ -271,7 +271,7 @@ static int string_set_value(struct bt_ctf_field *field, const char *string)
> > > >                                 if (i > 0)
> > > >                                         strncpy(buffer, string, i);
> > > >                         }
> > > > -                       strncat(buffer + p, numstr, 4);
> > > > +                       memcpy(buffer + p, numstr, 4);
> > > I took care to have enough context in my patch that you could see what
> > > was going on. I wonder if there is a way to make that care
> > > propate when people add Signed-off-by: lines.
> >
> > I just checked and the patch is the same, the description I only changed
> > the subject line, so that when one uses:

> Functionally, yes. However look at how my version has enough context
> that you can immediately know that the patch is correct (instead of
> the default of 5 lines):

Hey, you're talking about the _patch_ context?

I haven't touched that, just applied the patch and then run 'git request-pull',
and that will not consider at all the initial, non-default context the patch
author used when sending upstream :-)

Also, with the patch applied, one can always do:

[acme@quaco perf]$ git log --oneline torvalds/master.. | grep strncat
97acec7df172 perf data: Fix 'strncat may truncate' build failure with recent gcc
[acme@quaco perf]$ git show -U10 97acec7df172
commit 97acec7df172cd1e450f81f5e293c0aa145a2797
Author: Shawn Landden <shawn@git.icu>
Date:   Sat May 18 15:32:38 2019 -0300
<SNIP>
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index e0311c9750ad..9097543a818b 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -264,21 +264,21 @@ static int string_set_value(struct bt_ctf_field *field, const char *string)
 
                        if (!buffer) {
                                buffer = zalloc(i + (len - i) * 4 + 2);
                                if (!buffer) {
                                        pr_err("failed to set unprintable string '%s'\n", string);
                                        return bt_ctf_field_string_set_value(field, "UNPRINTABLE-STRING");
                                }
                                if (i > 0)
                                        strncpy(buffer, string, i);
                        }
-                       strncat(buffer + p, numstr, 4);
+                       memcpy(buffer + p, numstr, 4);
                        p += 3;
                }
        }
 
        if (!buffer)
                return bt_ctf_field_string_set_value(field, string);
        err = bt_ctf_field_string_set_value(field, buffer);
        free(buffer);
        return err;
 }
[acme@quaco perf]$

Go bumping that -U10 value till you get the whole file 8-)

- Arnaldo


> https://www.spinics.net/lists/linux-perf-users/msg08563.html
> 
> >
> >    git log --oneline
> >
> > we can know what is the component and what kind of build failure was
> > that.
> >
> > - Arnaldo
> >
> > > >                         p += 3;
> > > >                 }
> > > >         }
> > > > --
> > > > 2.20.1
> > > >
> >
> > --
> >
> > - Arnaldo
