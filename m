Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906FFC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D0C208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8H0J62x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfE1NE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:04:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35575 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfE1NE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:04:27 -0400
Received: by mail-qk1-f196.google.com with SMTP id l128so9670005qke.2;
        Tue, 28 May 2019 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=egUCFMOxotUyHIdIWxsbEKKLZ6dJOCt5AUpAksGL1lg=;
        b=J8H0J62x8W8HGq14K2pJGI1+GA51ibXL/47coBaf5N/guzHKGxJEOTEcLlc3YisQM9
         JOadIZe3jD4L4eo3HECB/M9w51QNl1T75+F1ULBk6ITNXXsepWRd9h7mP7CuS9aUtyxV
         abD/7z8EizLvxrceUJfc4gcygvJWW24mLUy/rjCJcoBzarsN3BAwAMk5Xvfs+/BTtD7l
         cbFOw3MxgZqxPqId80CnBtXxbjP6GMPYq1EIR8bkASIn0Mr2aVaEzsK/Ksq3xGG+wcni
         jUmT3ImfsyOlPQN+jDBMPncuaDJC0ho6K69GXtEfDJLWMmG0W981GnFRUY2Tg9zy1LrX
         t+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=egUCFMOxotUyHIdIWxsbEKKLZ6dJOCt5AUpAksGL1lg=;
        b=KJU/hDHo6O7AlHBBzWtT4XSt/CTx8i6YDJVzG1pig2sXRIffPtiblClCmybMMiZJUj
         dW4DIhhsqx2naj570D08eSjR/8KqC98mWZOkoDZ+ezIYO92ZNY1hIp+E82sbF28yAUMN
         Qkt1VDdHFZRqjT7KRGXYtVDfIjan4EOFtrnC12Y/+bvpPC8h42OgVoZPbSHVYdiazaFF
         k4/KIm89z87css6TMP6+8S6uLJ9Qj6AxqZQyq9RwvtMX9SihZtn0+otu2CvicxRm8ZGC
         ZVRDUAOQ73HROMroAhcEKYJ5ASBZRt+hHn2DlYPlz4MORnSBZcZvh/0c2dPBBgxwe8It
         r2KQ==
X-Gm-Message-State: APjAAAV18Yraw+Kp0J8E02FdXa0x6o6/TRLr4lnPyFRhee1uvKI3ituK
        XDFa04FgQvUd0fgQM1OXIZQ=
X-Google-Smtp-Source: APXvYqzbcD2ludIojGHX3Bbl+vGO/Mj/I4IVRYIfy3ktIje4Rx3G5QQNc6a+74tazkHgneOlG6OHnQ==
X-Received: by 2002:ac8:27fb:: with SMTP id x56mr64343242qtx.14.1559048666178;
        Tue, 28 May 2019 06:04:26 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id k5sm1465865qtj.40.2019.05.28.06.04.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 06:04:25 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F1CAE41149; Tue, 28 May 2019 10:04:21 -0300 (-03)
Date:   Tue, 28 May 2019 10:04:21 -0300
To:     Shawn Landden <slandden@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 05/44] perf data: Fix 'strncat may truncate' build
 failure with recent gcc
Message-ID: <20190528130421.GB13830@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
 <20190527223730.11474-6-acme@kernel.org>
 <CA+49okqviNfP087Z34-P4mJuMYc8_PiNJgTPz0xSAxqtp4iM0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+49okqviNfP087Z34-P4mJuMYc8_PiNJgTPz0xSAxqtp4iM0A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 27, 2019 at 05:46:26PM -0500, Shawn Landden escreveu:
> On Mon, May 27, 2019 at 5:38 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > From: Shawn Landden <shawn@git.icu>
> >
> > This strncat() is safe because the buffer was allocated with zalloc(),
> > however gcc doesn't know that. Since the string always has 4 non-null
> > bytes, just use memcpy() here.
> >
> >     CC       /home/shawn/linux/tools/perf/util/data-convert-bt.o
> >   In file included from /usr/include/string.h:494,
> >                    from /home/shawn/linux/tools/lib/traceevent/event-parse.h:27,
> >                    from util/data-convert-bt.c:22:
> >   In function ‘strncat’,
> >       inlined from ‘string_set_value’ at util/data-convert-bt.c:274:4:
> >   /usr/include/powerpc64le-linux-gnu/bits/string_fortified.h:136:10: error: ‘__builtin_strncat’ output may be truncated copying 4 bytes from a string of length 4 [-Werror=stringop-truncation]
> >     136 |   return __builtin___strncat_chk (__dest, __src, __len, __bos (__dest));
> >         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Signed-off-by: Shawn Landden <shawn@git.icu>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Wang Nan <wangnan0@huawei.com>
> > LPU-Reference: 20190518183238.10954-1-shawn@git.icu
> > Link: https://lkml.kernel.org/n/tip-289f1jice17ta7tr3tstm9jm@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/data-convert-bt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
> > index e0311c9750ad..9097543a818b 100644
> > --- a/tools/perf/util/data-convert-bt.c
> > +++ b/tools/perf/util/data-convert-bt.c
> > @@ -271,7 +271,7 @@ static int string_set_value(struct bt_ctf_field *field, const char *string)
> >                                 if (i > 0)
> >                                         strncpy(buffer, string, i);
> >                         }
> > -                       strncat(buffer + p, numstr, 4);
> > +                       memcpy(buffer + p, numstr, 4);
> I took care to have enough context in my patch that you could see what
> was going on. I wonder if there is a way to make that care
> propate when people add Signed-off-by: lines.

I just checked and the patch is the same, the description I only changed
the subject line, so that when one uses:

   git log --oneline

we can know what is the component and what kind of build failure was
that.

- Arnaldo

> >                         p += 3;
> >                 }
> >         }
> > --
> > 2.20.1
> >

-- 

- Arnaldo
