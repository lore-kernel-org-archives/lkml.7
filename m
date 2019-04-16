Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B884C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4DC2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfrM53bT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfDPLer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:34:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43866 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfDPLeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:34:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id f18so18757496lja.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 04:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tfDPgawIQFWcgD4ufCunSfHody0BftRlWut/FOblLdU=;
        b=VfrM53bT5HoVuV4ZDKMkKAtEUEryvBpH82HvlQA/U0+2/OD49ufv5gZUMqPLerB5iP
         1V4mCpO0F7l2i8v0zlj3npt0sSZ/pg8itGQKbj+2R+4vcl571A0Yb5YrxVtlKPLf0eYV
         mFA/O7H+49890pq2eOunn1CbHd4Hv2fdvDJr+OGsjdYWqE+Dzi+A4Eh5dl8Rm5HTqCyf
         K9EemfX8R+Zx3fxqLuXuiUzK5/sk6k9gKg9xQvJm3EA9NLrCJAuYA7Hg4pn8/XnKqLKC
         4xIlqie2SIiAIGuFHeL/oxM3W1fdx2yA6Uh2VCmFREH/aTAjHyAoOQJDUexpFjpH8nQ2
         1vHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfDPgawIQFWcgD4ufCunSfHody0BftRlWut/FOblLdU=;
        b=f7amcD2jty3hnCONiKK8wHpbMyPDdtICuSnVjFB4gjUAM4XW6GqL2/eyg5nXXqye9x
         dP430OUosH7xFem1IfsLgUbot98TQUkndrMxhJpFp/ospjlqE2TKeeA4no1vfovdU+KU
         YzRqvvgkaGTEkqXUoNEXY3oiv+B0+LTgDx3TzvrNQZAygBJem+IGle3Dm+DozveaWkTc
         idbDRI95wbuALtf1PcZl5CfyZghcywiCZjzzfgvqTZsFicFg35sBTGt3eMdsx37xDYZo
         //NQ0qSpXz1HTID6rJFn51toCq2vX/1edgiEK04RS/07jFNX11UUlxJMfICbDqPHEzpP
         JMdA==
X-Gm-Message-State: APjAAAX2bcR2liyg1BbLhDLE5eJjL77j3NINbcSuHPIo06dw/hNrnDML
        v4YJImOMCr+X7iLBaLgsdudkLYwccvEWHwpJV/1uLw==
X-Google-Smtp-Source: APXvYqyQC7tLUBgmwDhU2b+ww+NzxxzIaas1rWaBsVn6Avs5qgf5YrmuKOxKjsmnKZR3roCnvw//XDSLVSS4xcc7YmU=
X-Received: by 2002:a2e:9682:: with SMTP id q2mr18394706lji.168.1555414484575;
 Tue, 16 Apr 2019 04:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190412154819.oiztq2uf4teuxewn@macpro-scc.lancs.ac.uk>
 <CAJZ5v0hSTVHp43TtK9_yjcy2t2V9jSL6VyPJg9cQHE2SYBOejA@mail.gmail.com>
 <20190415152900.7axwpeczvu7i5kkj@macpro-scc.lancs.ac.uk> <CAJZ5v0gj1p0KNUZkZ3JG2ppK1706GSfY3J12mDNx-E75Y_J3Cg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gj1p0KNUZkZ3JG2ppK1706GSfY3J12mDNx-E75Y_J3Cg@mail.gmail.com>
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
Date:   Tue, 16 Apr 2019 12:34:33 +0100
Message-ID: <CACfOrNe0t0ieWbvwN_zpos-gdpc8qXVxQjHOv4FhMw8cBi5KBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] driver core: fix statics initilisation
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I guess this patch will be ignored. I will drop it then.

Thanks for the discussion.

On Tue, Apr 16, 2019 at 10:50:23am +0200, Rafael J. Wysocki wrote:
> On Mon, Apr 15, 2019 at 5:29 PM Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
> >
> > Thank you for your review.
> >
> > I follow https://kernelnewbies.org/FirstKernelPatch to write this patch.
> > It's not stated that checkpatch.pl is for new patches only. Moreover,
> > https://kernelnewbies.org/FirstKernelPatch#Running_checkpatch.pl suggest to
> > run over the entire file.
>
> I'm not sure about the source of that recommendation.
>
> In any case, running it over the entire file doesn't mean that you
> should or even need to make all of the warnings in that file go away.
>

I understand that, but it was shown as ERROR. There are some other warnings for
long lines that I skip.

> > Also, uninitialised static global variable are initialised to 0 by default.
> > Thus, initialising driver_deferred_probe_enable to false (which is 0) is
> > redundant.
>
> Yes, it is redundant, but it also is harmless AFAICS.
>
> > As my knowledge, initialised global goes to .data section, and uninitialised
> > goes to .bss.
> >
> > What does it mean for the kernel? Is this still hold?
>
> No, I don't think so.
>
> > Are performance or memory footprint of the kernel be affected?
>
> No, they aren't.
>
> The only difference this makes is the removal of redundant
> initialization to 0, which may be regarded as a cleanup, but not as a
> fix IMO.

Ok, will stated as a cleanup in the future.

>
> If that's the only reason you have to change the file in question,
> doing something else instead of that may be a better allocation of
> your time.

Thank you for your advice. I was just having my nose on it while playing with
something else, it wasn't a hide-and-seek game.

>
> Thanks!
