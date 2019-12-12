Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4E4C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D637921655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576159217;
	bh=w6j7nt8EVQhGqeeabig/3mMtxBUSwyE1b0/3qRLnlMY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nriDg5UfADZ252AdjWJutXXbgyWdqw0ibocT0IrNn7RakjfkAWdrY0XuHduZ5ZHB+
	 4A/D93IP9+QoKQkln+Irwp9Jhxxq3ilRK0AW/jPpJPd3Axp3U4D0B32SlvcXpWs/oI
	 I45bXeurF0JWcRVqbous4k2t/GO0UBDr1c3mpVAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfLLOAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729524AbfLLOAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:00:16 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 922A021655;
        Thu, 12 Dec 2019 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576159215;
        bh=w6j7nt8EVQhGqeeabig/3mMtxBUSwyE1b0/3qRLnlMY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rmi1gkkd4I+2394B3wixXdiXO3A3D0r2w2dH7yVZGFDe1Z8I0ja30fsJ2t8IZ+rCh
         Duh2X+pXYS65dQtBq5brAD93r3mic178CAaeGzI1CbWc5IyIJ4BKhxWIqg+jTrDGWr
         HUvkRctVRdbDGf5w3EXNugc6xO4/q/zWl++5AmOk=
Received: by mail-qk1-f173.google.com with SMTP id r14so1618225qke.13;
        Thu, 12 Dec 2019 06:00:15 -0800 (PST)
X-Gm-Message-State: APjAAAWpxBDC38pzafU1+iiYfc2q4ZKd66/w08OALT6gF81m3mqlQhTz
        MTgHxZ5Vg2XRB2MSw7gF2TGcwbP7BhM/0X59WQ==
X-Google-Smtp-Source: APXvYqylVaRXooiFXE5LLn2gb6i2E8GDU2gD9ANvwzpoLnrIk+YG9DZFfJ8BliPuj1AETH76SC8tJJD1gjvt1ijX7t4=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr8219015qkg.152.1576159214753;
 Thu, 12 Dec 2019 06:00:14 -0800 (PST)
MIME-Version: 1.0
References: <1575965693-30395-1-git-send-email-frowand.list@gmail.com>
 <20191211201856.GA21857@bogus> <486ce60c-8a74-7baf-1054-c81c83e79e56@gmail.com>
In-Reply-To: <486ce60c-8a74-7baf-1054-c81c83e79e56@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 12 Dec 2019 08:00:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL_0UUrjPG3G4vzO5fzzREV4tr5Y+ykRxzU+Cqz4_YgdQ@mail.gmail.com>
Message-ID: <CAL_JsqL_0UUrjPG3G4vzO5fzzREV4tr5Y+ykRxzU+Cqz4_YgdQ@mail.gmail.com>
Subject: Re: [PATCH] of: refcount leak when phandle_cache entry replaced
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 5:17 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 12/11/19 2:18 PM, Rob Herring wrote:
> > On Tue, 10 Dec 2019 02:14:53 -0600, frowand.list@gmail.com wrote:
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> of_find_node_by_phandle() does not do an of_node_put() of the existing
> >> node in a phandle cache entry when that node is replaced by a new node.
> >>
> >> Reported-by: Rob Herring <robh+dt@kernel.org>
> >> Fixes: b8a9ac1a5b99 ("of: of_node_get()/of_node_put() nodes held in phandle cache")
> >> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> >> ---
> >>
> >> Checkpatch will warn about a line over 80 characters.  Let me know
> >> if that bothers you.
> >>
> >>  drivers/of/base.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >
> > Applied, thanks.
> >
> > Rob
> >
>
> If the rework patch of the cache that you posted shortly after accepting
> my patch, then my patch becomes not needed and is just extra noise in the
> history.  Once your patch finishes review (I am assuming it probably
> will), then my patch should be reverted.

The question is what to backport: nothing, this patch or mine? My
thought was to apply this mainly to backport. If you're fine with
nothing or mine, then we can drop it. I'm a bit nervous marking mine
for stable.

Rob
