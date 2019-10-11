Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1FDECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 19:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F47F21835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 19:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570822382;
	bh=uSHigDuoBkOef46f47ltxjTSdcoO9upwPANgWU6/D9E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=og9B7O/vZWk6+quM2ReMs0YlDcWPUkN1H8PIpoX7qwc3oOqBYINSN41vR0UxyCfkt
	 TWApzdE1HJH/tdZXnuoyT9e7aaG7HKDN5KA+V+dLrSRCAAeyfu8Tk/WlFyoTpEK1se
	 XcmdgX1PGnfIQMRQywW3dU6SN9PuPut0JCq43bkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfJKTdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 15:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbfJKTdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 15:33:00 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD62B218AC;
        Fri, 11 Oct 2019 19:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570822379;
        bh=uSHigDuoBkOef46f47ltxjTSdcoO9upwPANgWU6/D9E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0wH7kDliiES45/qF6O+0x/bik1ElV2yR2zkp4ybgHXZ5fXxXB5KNRQO+WOpWVSm0N
         mK8DxNBgbXtqvMsEo8lB6pju+OdYRxlBrDAtkDP/CFGXR+G87Q2PtplnMYjxfIQPsT
         cE4glGu2aoA6KOhz5eNEww4oZ1i0akNm+MqU4MU0=
Received: by mail-qt1-f174.google.com with SMTP id u22so15435281qtq.13;
        Fri, 11 Oct 2019 12:32:58 -0700 (PDT)
X-Gm-Message-State: APjAAAW7RqQqiDglzXd12kLZb9a0aDE0I4nujYW4bvxJKWntA5aGA2N6
        XjXAmGDB6BlSADQ9yDrh/Mn74ZCt5FXn3/JcPA==
X-Google-Smtp-Source: APXvYqwIjsTIx4gE6GsG6zQAJr8JfQ6D5bTKreNB1Ug8rxT51XsikLFA1aNRUj4oItqJYQKqCFfL/6sYmmsielYsPDQ=
X-Received: by 2002:ac8:44d9:: with SMTP id b25mr19411003qto.300.1570822378023;
 Fri, 11 Oct 2019 12:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190913211349.28245-1-robh@kernel.org> <713b2e5bbab16ddf850245ae1d92be66d9730e02.camel@perches.com>
 <CAL_JsqLtEM9+LK=3YDLnoZbC1v09R9-qfFNEH-gTWj94FAjnyg@mail.gmail.com>
 <7672dd2f651bfdcdb1615ab739e36a381b2535b1.camel@perches.com>
 <CAL_JsqKAbP6KYjiJ6dLr=dpFG-j-e4rJPCKZ0+pZrDjsSPAUPQ@mail.gmail.com>
 <CAL_JsqJiV-L14tQte0tZXq+-TRTXGOFW62EsSobu3cFGA8rJDw@mail.gmail.com> <a6933fa81cf1510528ed7a4cfa55f57900800fc6.camel@perches.com>
In-Reply-To: <a6933fa81cf1510528ed7a4cfa55f57900800fc6.camel@perches.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 11 Oct 2019 14:32:45 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+YHDRkPYQwMWAvXM8kPz92AVYuaiLKAbZwhYeufFJQvw@mail.gmail.com>
Message-ID: <CAL_Jsq+YHDRkPYQwMWAvXM8kPz92AVYuaiLKAbZwhYeufFJQvw@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Warn if DT bindings are not in schema format
To:     Joe Perches <joe@perches.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 1:02 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2019-10-11 at 12:56 -0500, Rob Herring wrote:
> > On Fri, Sep 27, 2019 at 10:39 AM Rob Herring <robh@kernel.org> wrote:
> > > On Fri, Sep 27, 2019 at 9:29 AM Joe Perches <joe@perches.com> wrote:
> > > > On Fri, 2019-09-27 at 09:02 -0500, Rob Herring wrote:
> > > > > On Fri, Sep 13, 2019 at 4:48 PM Joe Perches <joe@perches.com> wrote:
> > > > > > On Fri, 2019-09-13 at 16:13 -0500, Rob Herring wrote:
> > > > > > > DT bindings are moving to using a json-schema based schema format
> > > > > > > instead of freeform text. Add a checkpatch.pl check to encourage using
> > > > > > > the schema for new bindings. It's not yet a requirement, but is
> > > > > > > progressively being required by some maintainers.
> > > > > > []
> > > > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > > > []
> > > > > > > @@ -2822,6 +2822,14 @@ sub process {
> > > > > > >                            "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
> > > > > > >               }
> > > > > > >
> > > > > > > +# Check for adding new DT bindings not in schema format
> > > > > > > +             if (!$in_commit_log &&
> > > > > > > +                 ($line =~ /^new file mode\s*\d+\s*$/) &&
> > > > > > > +                 ($realfile =~ m@^Documentation/devicetree/bindings/.*\.txt$@)) {
> > > > > > > +                     WARN("DT_SCHEMA_BINDING_PATCH",
> > > > > > > +                          "DT bindings should be in DT schema format. See: Documentation/devicetree/writing-schema.rst\n");
> > > > > > > +             }
> > > > > > > +
> > > > > >
> > > > > > As this already seems to be git dependent, perhaps
> > > > >
> > > > > It's quite rare to see a non git generated diff these days.
> > > > >
> > > > > > it's easier to read with a single line test like:
> > > > > >
> > > > > >                 if ($line =~ m{^\s*create mode\s*\d+\s*Documentation/devicetree/bindings/.*\.txt$}) {
> > > > > >                         etc...
> > > > > >                 }
> > > > >
> > > > > I frequently do 'git show $commit | scripts/checkpatch.pl' and this
> > > > > doesn't work with that. I really should have a '--pretty=email' in
> > > > > there, but I just ignore the commit msg warnings. In any case, that
> > > > > still doesn't help because there's no diffstat. There's probably some
> > > > > way to turn that on or just use git-format-patch, but really we want
> > > > > this to work with any git diff.
> > > >
> > > > I don't understand your argument against what I proposed at all.
> > >
> > > It is dependent on the commit message rather than the diff itself. I
> > > want it to work with or without a diffstat.
> > >
> > > > and btw:
> > > >
> > > > $ git format-patch -1 --stdout <commit> | ./scripts/checkpatch.pl
> > >
> > > Yes, I stated this was possible. My concern is there are lots of ways
> > > to generate a diff in git. My way works for *all* of them. Yours
> > > doesn't.
> >
> > Joe, are you okay with this?
>
> Sure, Andrew Morton does most of the checkpatch upstreaming, but
> if you want to send your own pull request, I've no objection.

Thanks, I've applied this to the DT tree.

Rob
