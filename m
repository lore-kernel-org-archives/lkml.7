Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E281EC388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFDA217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569592962;
	bh=0iX2DQr14AlkbvHfRGZNmQ9tlhz8bAWS/7ft6ezd5hQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SlJKaXIq/f+nAUpHm4AH/FfgIDWPBR8N5l58i2PAOkSRbidxdecn2kHM+f2qynsai
	 H3A8oZ4UwJGvKzZ4LYPx3EuPX++bUNy8miJiKnhFAR2PPk9a2DYOcUzc+l7NZDVFQe
	 bU/SKvaANjeZg5QvJjA6TGrgk9S6r1/+q0h87rVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfI0OCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfI0OCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:02:42 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B89221841;
        Fri, 27 Sep 2019 14:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569592961;
        bh=0iX2DQr14AlkbvHfRGZNmQ9tlhz8bAWS/7ft6ezd5hQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C3z6BtTaaOiNNsz6HBsNlvQ3B+zWNyDxBxhPeulzOIBF+rq/QjKp1EGKDfW85ZFHX
         VJDL658WhRuo0IL0WayQIqkpt4Ptdu8kVHfiP433niG3pAKENbLwDmpPJd9i5a7/jG
         7jWMdpi4YnIG9i6LKtaiBiCPsi4TnVX6mW2dk9gc=
Received: by mail-qk1-f181.google.com with SMTP id z67so1993831qkb.12;
        Fri, 27 Sep 2019 07:02:41 -0700 (PDT)
X-Gm-Message-State: APjAAAUrN4qsAlzYOP7ilObIVNGcALkRzVoSlij6REYrjnEe5K2a9QcA
        T/rAeulY4eoRptFV0Yt4OSVPBvnyCefwMaHhlQ==
X-Google-Smtp-Source: APXvYqxAmYw6yeCfngyJGiL6LphzMSZJ1dP2msYl/WdmTNbnA4NSeej6Usxd9ix543VHp9JJ5am1FuuLbDCVN7cEylU=
X-Received: by 2002:a05:620a:7da:: with SMTP id 26mr4432075qkb.119.1569592960143;
 Fri, 27 Sep 2019 07:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190913211349.28245-1-robh@kernel.org> <713b2e5bbab16ddf850245ae1d92be66d9730e02.camel@perches.com>
In-Reply-To: <713b2e5bbab16ddf850245ae1d92be66d9730e02.camel@perches.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 27 Sep 2019 09:02:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLtEM9+LK=3YDLnoZbC1v09R9-qfFNEH-gTWj94FAjnyg@mail.gmail.com>
Message-ID: <CAL_JsqLtEM9+LK=3YDLnoZbC1v09R9-qfFNEH-gTWj94FAjnyg@mail.gmail.com>
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

It's quite rare to see a non git generated diff these days.

> it's easier to read with a single line test like:
>
>                 if ($line =~ m{^\s*create mode\s*\d+\s*Documentation/devicetree/bindings/.*\.txt$}) {
>                         etc...
>                 }

I frequently do 'git show $commit | scripts/checkpatch.pl' and this
doesn't work with that. I really should have a '--pretty=email' in
there, but I just ignore the commit msg warnings. In any case, that
still doesn't help because there's no diffstat. There's probably some
way to turn that on or just use git-format-patch, but really we want
this to work with any git diff.

Rob
