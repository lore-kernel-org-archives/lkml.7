Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C5AC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA406229F9
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UM+81dBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfGYVSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:18:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37940 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfGYVSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:18:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so52210712wrr.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 14:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oCOvLgRqp/H6p2rloi89lXQefcpHDvjU3XE+e9cLRp8=;
        b=UM+81dBOxoWwDeattozqijuWdhQVri7EW8M8P/xKZaTvSp0Fbk8cG8MimuIzFgWIej
         C/1Q5GKBICG26vm7i7zZ3hiKdN2I3XECd30EpmyTTyoY57lCZojamgNiNO5+JsYcXqrX
         zlS2OjKu6INOchJDfWB68ygUbrtxLI94E24Y8LfbW5HncoOzRAYGbZ2edvQiyFwiStkn
         s6Eqi5Hl43Ncg0lgDZ0Mg5QLhMRNwMPRaRDJ/4y1B5kRpoNMkiDikCGu05BW2ZQrkjg1
         6q3FNmOi2FJaaXmWyD1IlMxeC/ic/9FY3GKX/RVCuS8HACBL+a5W8QvkovKsHSBhnS6e
         9ZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oCOvLgRqp/H6p2rloi89lXQefcpHDvjU3XE+e9cLRp8=;
        b=q4sEdbeSUxiBL1d67Zhuzk70yryueRhxhCbKKAFSncZBJ+H50poRNfXHlNCkb4QI2S
         ht0KzP0+VLMqt73rf65sr9TIaa7iDoJKmnjqRT/kIFVxgZ/1YkeneoUNO4IJ0Gr636KA
         75z+T2TS3bPihmGmbVx1jPyvyOf7YDF5gF6tmccI5zHbpQhsVY4IAQ951eb+L2Yq/ogj
         GL38cGJEQ32pfUBG/7mMuediCuDx6AF/6gI+ixy2k0lav70I429tvC+FXj2ZA2NAYU/M
         yfggwiPKQmKtBZMQW84NKfpuimiSdtBluh9XVRO15eTPezDjoZOjxXuLFR89ZJlqEVeT
         cGkA==
X-Gm-Message-State: APjAAAXQenLsFo7CwvqrpamnRaE148LErq8b9Uo2sBPWsuSu82LzMk8/
        65rdK9H3osHEHuBK9lzGN+ViQ5FXI85a6FnBc46Oyg==
X-Google-Smtp-Source: APXvYqw+tWr/laeClu0YcFAJGZtu0HkVHcXsjlxf4avFfFILIfFOPaayM5TLtekxb2r01tawtXm/6agTNNVr5NCGGOA=
X-Received: by 2002:a5d:6783:: with SMTP id v3mr96274748wru.318.1564089517070;
 Thu, 25 Jul 2019 14:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190724184512.162887-1-nums@google.com> <20190724184512.162887-4-nums@google.com>
 <c256d9b6702b4d37a0c21b93f319b476@AcuMS.aculab.com>
In-Reply-To: <c256d9b6702b4d37a0c21b93f319b476@AcuMS.aculab.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 25 Jul 2019 14:18:25 -0700
Message-ID: <CAP-5=fW4v4NDe-aGS+RNLktTtUK9mHVRKn46XPw=S8Akh6hoyA@mail.gmail.com>
Subject: Re: [PATCH 3/3] Fix insn.c misaligned address error
To:     David Laight <David.Laight@aculab.com>
Cc:     Numfor Mbiziwo-Tiapo <nums@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "mbd@fb.com" <mbd@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eranian@google.com" <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 6:06 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Numfor Mbiziwo-Tiapo
> > Sent: 24 July 2019 19:45
> >
> > The ubsan (undefined behavior sanitizer) version of perf throws an
> > error on the 'x86 instruction decoder - new instructions' function
> > of perf test.
> >
> > To reproduce this run:
> > make -C tools/perf USE_CLANG=1 EXTRA_CFLAGS="-fsanitize=undefined"
> >
> > then run: tools/perf/perf test 62 -v
> >
> > The error occurs in the __get_next macro (line 34) where an int is
> > read from a potentially unaligned address. Using memcpy instead of
> > assignment from an unaligned pointer.
> ...
> >  #define __get_next(t, insn)  \
> > -     ({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
> > +     ({ t r; memcpy(&r, insn->next_byte, sizeof(t)); \
> > +             insn->next_byte += sizeof(t); r; })
>
> Isn't there a get_unaligned_u32() (or similar) that can be used?


memcpy is a compiler intrinsic. get_unaligned_u32 would mean either a
'if (sizeof(t) == sizeof(u32)) get_unaligned_u32(.. ' for all sizes or
changing all call sites of __get_next. Numfor's change feels right as
it is the least invasive.

Thanks,
Ian Rogers
(resent to make plain text)

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
