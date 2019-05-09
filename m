Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB34DC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8005521479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUHffAlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEIJ1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 05:27:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33968 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfEIJ1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 05:27:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id j24so599523ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 02:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2mpuoShtc3pBXqAPR31rr6ZG0YleTX+5TXGG7hYRLbI=;
        b=VUHffAlgkM6SXmJNVposqrO50IqvChG58Y62PGhoyRXDcZG6nBBOKIVq40yMNrp6NI
         PUw+z90MnPA/taCA18+upPBWK+k82Dw0s4/iRi+PGEg3EHHLcf1ITp7VKXpCbp83rG7J
         MTB9baJNKvT8fPUnQj4NJ7QyEZ64PCO17uBJwXnQIirHKXH1BEqJgiU1ifcv8uMKPm1N
         lK4JGBjaDMFNW4cs0/V6mmkcQ34pTwwBLvMVZ+faphktiWHnx9vokiii0FNVfrBiyC7r
         Irs0O82Bylu8zSv6LTIOnc3tmQj46+kSJsGVLb5tdDXK6ik5E7Nd402zgaNs9Ta1rQXs
         LLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mpuoShtc3pBXqAPR31rr6ZG0YleTX+5TXGG7hYRLbI=;
        b=oQqJls9iPDk0cdtYrdOlbR6vpweIN+I6cP6OuHEaX+taZv3uJAFYG5FM5K86PBmyE7
         xRCsbQW/YzNYrR8b0gQDrETybZfpUUG1gHt3l6AIxDe+J/+PgxWrbrIUfr+xt201tR0d
         +cA7y6BJf5DJ+oXrsXmvQ5XOF3W4bc2hZ1pLXeqxVyRJy+eHd50LuL13+VVQr2kv2kWV
         FgZ1AZQNcxf8THzbYk+2s/FICMCKQfo+G+JeN0gziRQLDn6OgRZMEXIGn8fR7qjSI5l/
         vQrfiusv1TrZ450ZaNmrC0BvlzAq+gcNm4m4XdT7CFAE62+qmvnakackVSD503gYxdfl
         g49Q==
X-Gm-Message-State: APjAAAVqZrR4LNAtjej6SWJaI6bxXL0EbfYlnpiHF+Z/aIh9AXgeATCV
        OutkyIVD3o6QtYA38awP43gMTED07m1FN+cC0yo=
X-Google-Smtp-Source: APXvYqxl3O4j5PsSRke8az8SsOjq03uKzQOxJB1QlGOaWWwsmbhGBar226xhEWRnGW7FkccOOdjYrruEKry3nMpcUaA=
X-Received: by 2002:a2e:88cc:: with SMTP id a12mr1785111ljk.55.1557394031673;
 Thu, 09 May 2019 02:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190509072104.18734-1-borneo.antonio@gmail.com> <3d1911051672d4d84b46dfa229b8c82c4a41813b.camel@perches.com>
In-Reply-To: <3d1911051672d4d84b46dfa229b8c82c4a41813b.camel@perches.com>
From:   Antonio Borneo <borneo.antonio@gmail.com>
Date:   Thu, 9 May 2019 11:26:50 +0200
Message-ID: <CAAj6DX3aZ+_q1Vi7A+fyje9-s27dYO5_MEhZ_EU-DEVSXwNzkw@mail.gmail.com>
Subject: Re: [PATCH v4] checkpatch: add command-line option for TAB size
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 10:03 AM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-05-09 at 09:21 +0200, Antonio Borneo wrote:
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -2224,7 +2229,7 @@ sub string_find_replace {
> >  sub tabify {
> >       my ($leading) = @_;
> >
> > -     my $source_indent = 8;
> > +     my $source_indent = $tabsize;
> >       my $max_spaces_before_tab = $source_indent - 1;
>
> I didn't test this.
>
> Does this work properly if --tab-size=1 ?
> Maybe die if ($tabsize < 2); is necessary?

I have tested it and it works fine, but now that you point it, I
rechecked the code. There is already this in checkpatch
sub tabify {
...
        my $source_indent = $tabsize;
        my $max_spaces_before_tab = $source_indent - 1;
...
        #Remove spaces before a tab
        1 while $leading =~ s@^([\t]*)( {1,$max_spaces_before_tab})\t@$1\t@g;
that works fine.
But we could have in the future some other test in checkpatch that
uses "$tabsize - 1" and does not get the proper validation for
--tab-size=1
Maybe it's safer to put die if ($tabsize < 2) right now, and avoid
future headaches. With a comment to explains this choice.

Antonio
