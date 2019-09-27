Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF53C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6153B2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfI0O3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:29:34 -0400
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:32830 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727120AbfI0O3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:29:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 6482B182CF668;
        Fri, 27 Sep 2019 14:29:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lunch41_5320358922011
X-Filterd-Recvd-Size: 3127
Received: from XPS-9350 (unknown [113.161.34.234])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 27 Sep 2019 14:29:30 +0000 (UTC)
Message-ID: <7672dd2f651bfdcdb1615ab739e36a381b2535b1.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Warn if DT bindings are not in schema format
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Fri, 27 Sep 2019 07:29:28 -0700
In-Reply-To: <CAL_JsqLtEM9+LK=3YDLnoZbC1v09R9-qfFNEH-gTWj94FAjnyg@mail.gmail.com>
References: <20190913211349.28245-1-robh@kernel.org>
         <713b2e5bbab16ddf850245ae1d92be66d9730e02.camel@perches.com>
         <CAL_JsqLtEM9+LK=3YDLnoZbC1v09R9-qfFNEH-gTWj94FAjnyg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-27 at 09:02 -0500, Rob Herring wrote:
> On Fri, Sep 13, 2019 at 4:48 PM Joe Perches <joe@perches.com> wrote:
> > On Fri, 2019-09-13 at 16:13 -0500, Rob Herring wrote:
> > > DT bindings are moving to using a json-schema based schema format
> > > instead of freeform text. Add a checkpatch.pl check to encourage using
> > > the schema for new bindings. It's not yet a requirement, but is
> > > progressively being required by some maintainers.
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -2822,6 +2822,14 @@ sub process {
> > >                            "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
> > >               }
> > > 
> > > +# Check for adding new DT bindings not in schema format
> > > +             if (!$in_commit_log &&
> > > +                 ($line =~ /^new file mode\s*\d+\s*$/) &&
> > > +                 ($realfile =~ m@^Documentation/devicetree/bindings/.*\.txt$@)) {
> > > +                     WARN("DT_SCHEMA_BINDING_PATCH",
> > > +                          "DT bindings should be in DT schema format. See: Documentation/devicetree/writing-schema.rst\n");
> > > +             }
> > > +
> > 
> > As this already seems to be git dependent, perhaps
> 
> It's quite rare to see a non git generated diff these days.
> 
> > it's easier to read with a single line test like:
> > 
> >                 if ($line =~ m{^\s*create mode\s*\d+\s*Documentation/devicetree/bindings/.*\.txt$}) {
> >                         etc...
> >                 }
> 
> I frequently do 'git show $commit | scripts/checkpatch.pl' and this
> doesn't work with that. I really should have a '--pretty=email' in
> there, but I just ignore the commit msg warnings. In any case, that
> still doesn't help because there's no diffstat. There's probably some
> way to turn that on or just use git-format-patch, but really we want
> this to work with any git diff.

I don't understand your argument against what I proposed at all.

and btw:

$ git format-patch -1 --stdout <commit> | ./scripts/checkpatch.pl


