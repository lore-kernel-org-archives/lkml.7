Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB45C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616F3206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568658090;
	bh=8IyPUfCRN/QLC5pcpdeVTQ48MP1WLchF2ec6UBzCt1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W7IFNEl/eSnPbaSbLkAhVWROqFa/KZJFaWTM+5HZBSmTByBe69+U2V7NhwAgk34d6
	 Rmcu7ZmEmW/90u8m5hxzNwQV51QTHG6lsfN1XgK0b6JyoZDMmJnO/0pdXKNM8KF9bI
	 0vZD0f+DSMZo9UgnHr6ZkLteVIKvHbA4ECVIpkA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390312AbfIPSV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:21:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfIPSV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:21:29 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D4CA20830;
        Mon, 16 Sep 2019 18:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568658088;
        bh=8IyPUfCRN/QLC5pcpdeVTQ48MP1WLchF2ec6UBzCt1Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TIFA9D+0FY7r47PzK+20boiwVZ3AsPu9RZyWYl9xUq+SDaTnMswc/v0vBV6AYKfBx
         uNLNgcCwB7n9cJg2nOF4wy2tcqYYpxl4XSqBYe4PVV7Wk0F+GVcO0tUb9v2g4FbuRl
         FrOshidfBdXSZ+mkzaXB/FT1WthzFBW94E9OGWmM=
Received: by mail-qk1-f179.google.com with SMTP id x134so1016647qkb.0;
        Mon, 16 Sep 2019 11:21:28 -0700 (PDT)
X-Gm-Message-State: APjAAAXGCxBFoegekEMh5JGv8M/aLmh3BQka9sc8RSNM4andek6/mvP5
        qE2xKbZbc1toABkpb7T1AxaSt9Tr54tuMeHd8g==
X-Google-Smtp-Source: APXvYqzs9IGqn8hIX6ITeZga7sN+t8uA+PMI17ufxR1sFoU4gv0s8pTjgW3cGVj5k0D2DS8yCwqPomq44hh9Pbzz2u8=
X-Received: by 2002:a37:8905:: with SMTP id l5mr1426930qkd.152.1568658087304;
 Mon, 16 Sep 2019 11:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190913211349.28245-1-robh@kernel.org> <713b2e5bbab16ddf850245ae1d92be66d9730e02.camel@perches.com>
In-Reply-To: <713b2e5bbab16ddf850245ae1d92be66d9730e02.camel@perches.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 16 Sep 2019 13:21:16 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+vZp_C7c4fxwA138D-b=aRmGn=CqCwTQ-biwwahq8K6Q@mail.gmail.com>
Message-ID: <CAL_Jsq+vZp_C7c4fxwA138D-b=aRmGn=CqCwTQ-biwwahq8K6Q@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Warn if DT bindings are not in schema format
To:     Joe Perches <joe@perches.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 4:48 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2019-09-13 at 16:13 -0500, Rob Herring wrote:
> > DT bindings are moving to using a json-schema based schema format
> > instead of freeform text. Add a checkpatch.pl check to encourage using
> > the schema for new bindings. It's not yet a requirement, but is
> > progressively being required by some maintainers.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -2822,6 +2822,14 @@ sub process {
> >                            "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
> >               }
> >
> > +# Check for adding new DT bindings not in schema format
> > +             if (!$in_commit_log &&
> > +                 ($line =~ /^new file mode\s*\d+\s*$/) &&
> > +                 ($realfile =~ m@^Documentation/devicetree/bindings/.*\.txt$@)) {
> > +                     WARN("DT_SCHEMA_BINDING_PATCH",
> > +                          "DT bindings should be in DT schema format. See: Documentation/devicetree/writing-schema.rst\n");
> > +             }
> > +
>
> As this already seems to be git dependent, perhaps
> it's easier to read with a single line test like:
>
>                 if ($line =~ m{^\s*create mode\s*\d+\s*Documentation/devicetree/bindings/.*\.txt$}) {
>                         etc...
>                 }

Okay. I wasn't too concerned about non-git diffs as I rarely see those anymore.

>
> There are ~3500 existing .txt files:
>
> $ git ls-files -- 'Documentation/devicetree/bindings/*.txt' | wc -l
> 3476
>
> Are these going to be converted somehow?

Patches welcome! We're working on it.

>
> What about files like these? (not .txt)
>
> Documentation/devicetree/bindings/timer/st,stih407-lpc
> Documentation/devicetree/bindings/nds32/andestech-boards
> Documentation/devicetree/bindings/media/nokia,n900-ir
> Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
> Documentation/devicetree/bindings/arm/cpu-enable-method/nuvoton,npcm750-smp
> Documentation/devicetree/bindings/arm/cpu-enable-method/marvell,berlin-smp
> Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp
> Documentation/devicetree/bindings/arm/arm-boards

What about them? This check is only for new files and no one runs
checkpatch.pl on binding txt files. If someone submits something
without an extension, then I'll catch that in review. I'm not too
worried about 8 out of 3500 cases.

Rob
