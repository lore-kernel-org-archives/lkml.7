Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047E1ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02C8207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp7tU3Oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbfJNLxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 07:53:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44289 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730493AbfJNLxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 07:53:10 -0400
Received: by mail-lf1-f65.google.com with SMTP id q12so11567100lfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ffAwOpYyYrijKov93vskz3rGkU2NebUE5qWk+Iqkotc=;
        b=bp7tU3OzDe4CTQbmgPP07OB7D4YSsaiHPA6sa07+XUUV7hdtG4WYf9P8arfVZQlhnA
         vrJvHWIaUPmqZ70WJSSIK8PV2gDAS0RAWDRJGZwuIf6p3jnwHASNK6MO34XslL9TkqAh
         QA/86GDpidMckLw4ZR5aLFDzYKx4ksI4UClAK81tfbOfbwJIggpT2//8hid6C8xO4879
         lRHS2AFFfpre8USlRmOLFsZQ30Xiybm/hLzCVKnCr50spa8WbkWOJf4jPEkD47zm7/d4
         ljQVhuGXwkbjGJIv7cw1oYcQwnJQkiZf08cCcSlWCI+jPP357xq+mUG+usjBQA458KLJ
         KkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffAwOpYyYrijKov93vskz3rGkU2NebUE5qWk+Iqkotc=;
        b=o2e2wcUqvvqDu85bd5IhHoPDFDPbTePh9KZ1anE/LLie+yC7qxwrmWHboJkUBySBRO
         TACCffEIWijFN//hQRB0NtINgXJ+iZvjd8kx5kz9u9oHsbV5aKsy69iZx0wCTYZVpFp7
         pSh7qZSPKqEiLw4zrCmWooVgH5871J0DAIG3LZBAqrD+Q1ojN0wXkPYkq0t3r3SGtndR
         0ngsU3TCDW5x3wnmZpwLia2KIChKj9N5TpiV+IcJ7D78GNp6wNVnKYgLoLwaUs88R/RL
         m6H09Q3eNPHT+dp4IrCCR+BjUyPXq++WImnsSw3tXvH1ZYUDZqo1L5/Zg8UqGqYgOU/X
         hDGg==
X-Gm-Message-State: APjAAAW5x2V2iiBS7fQNuW6d2TWQWiKqHOj8QpaSrSTSpNqittAaNlFz
        m/P2h1iMcFDo5suRd0leQdaLg92S8ffP6WRrG40=
X-Google-Smtp-Source: APXvYqyQfkmDe5HAPPqmXflupWahYj+TJRfGIhzhs0YCH/rYiX5Tsu3NcTIyZ+4PsNnhrmjfgT6yRwVCXpaLts3McDE=
X-Received: by 2002:ac2:51a6:: with SMTP id f6mr3063582lfk.164.1571053988636;
 Mon, 14 Oct 2019 04:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191010230414.647c29f34665ca26103879c4@gmail.com>
 <20191010232030.af6444879413e76a780cd27e@gmail.com> <20191014104717.GA43868@jagdpanzerIV>
In-Reply-To: <20191014104717.GA43868@jagdpanzerIV>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Mon, 14 Oct 2019 13:52:57 +0200
Message-ID: <CAMJBoFOVs-W_RAocRmmFmf=zOwMBODxP7XFkrhcOHDii-aXkuQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] zram: use common zpool interface
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        "Theodore Ts'o" <tytso@thunk.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 12:49 PM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (10/10/19 23:20), Vitaly Wool wrote:
> [..]
> >  static const char *default_compressor = "lzo-rle";
> >
> > +#define BACKEND_PAR_BUF_SIZE 32
> > +static char backend_par_buf[BACKEND_PAR_BUF_SIZE];
>
> We can have multiple zram devices (zram0 .. zramN), I guess it
> would make sense not to force all devices to use one particular
> allocator (e.g. see comp_algorithm_store()).
>
> If the motivation for the patch set is that zsmalloc does not
> perform equally well for various data access patterns, then the
> same is true for any other allocator. Thus, I think, we need to
> have a per-device 'allocator' knob.

We were thinking here in per-SoC terms basically, but this is a valid
point. Since zram has a well-established sysfs per-device
configuration interface, backend choice better be moved there. Agree?

~Vitaly
