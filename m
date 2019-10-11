Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6222ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AEC2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570816629;
	bh=SObEEAc6zI0j5H5m9jLmy2w0NgYlIpfEcaRb3ydotPA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RfwbGrhG/9hJKWYr+VRsdLxYHdbPRdW1zLA43w5LxIobw9Jn8q0FUNq6Jf+SbAnkM
	 3KelJVGRDtLvXIAGDyHNyc+ZRYepf6hpE3OPl+NdvwacE+PK73QGme0Vvm+VZ8+Xbl
	 eXmlBij8R0uDPsygjBBw+8d4QAXkhDg/4EeRLFDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfJKR5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 13:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbfJKR5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:57:07 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C0B521835;
        Fri, 11 Oct 2019 17:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570816626;
        bh=SObEEAc6zI0j5H5m9jLmy2w0NgYlIpfEcaRb3ydotPA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lt/DCW1vRF3k063Akb79j35F8iGpAAtftvFkNFSslSvW1i3mF6lC2JoAUefz+uT3q
         FxdrzYFn44DRnT17XiTwTVDMZkFtTZ5JPfVQVTY5Wg+RgPUq6HY2nyuIZSE5TZDmbD
         tnGQNdrW/aDzpxbNLeARHUn9wG+x1GTj/NjqZOmw=
Received: by mail-qk1-f172.google.com with SMTP id u184so9700002qkd.4;
        Fri, 11 Oct 2019 10:57:06 -0700 (PDT)
X-Gm-Message-State: APjAAAXvjoM5i3GNFEW1v/MP9cyxza84Mybddn3VNuZdyUlXqKDDdEiw
        hlsr0BrjY+exO3AqvNpfSvOOhdJR44/WzPjUaA==
X-Google-Smtp-Source: APXvYqzfirT8CwFQsBvNkzgWwfbtb9jNrANMi1nJuuxFtGGswdD+eerzYcuDeoWIMKhpFN3OKv+AcPBF/srpOGdqoGU=
X-Received: by 2002:a37:9847:: with SMTP id a68mr17321115qke.223.1570816625730;
 Fri, 11 Oct 2019 10:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190913211349.28245-1-robh@kernel.org> <713b2e5bbab16ddf850245ae1d92be66d9730e02.camel@perches.com>
 <CAL_JsqLtEM9+LK=3YDLnoZbC1v09R9-qfFNEH-gTWj94FAjnyg@mail.gmail.com>
 <7672dd2f651bfdcdb1615ab739e36a381b2535b1.camel@perches.com> <CAL_JsqKAbP6KYjiJ6dLr=dpFG-j-e4rJPCKZ0+pZrDjsSPAUPQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKAbP6KYjiJ6dLr=dpFG-j-e4rJPCKZ0+pZrDjsSPAUPQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 11 Oct 2019 12:56:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJiV-L14tQte0tZXq+-TRTXGOFW62EsSobu3cFGA8rJDw@mail.gmail.com>
Message-ID: <CAL_JsqJiV-L14tQte0tZXq+-TRTXGOFW62EsSobu3cFGA8rJDw@mail.gmail.com>
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

On Fri, Sep 27, 2019 at 10:39 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Sep 27, 2019 at 9:29 AM Joe Perches <joe@perches.com> wrote:
> >
> > On Fri, 2019-09-27 at 09:02 -0500, Rob Herring wrote:
> > > On Fri, Sep 13, 2019 at 4:48 PM Joe Perches <joe@perches.com> wrote:
> > > > On Fri, 2019-09-13 at 16:13 -0500, Rob Herring wrote:
> > > > > DT bindings are moving to using a json-schema based schema format
> > > > > instead of freeform text. Add a checkpatch.pl check to encourage using
> > > > > the schema for new bindings. It's not yet a requirement, but is
> > > > > progressively being required by some maintainers.
> > > > []
> > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > []
> > > > > @@ -2822,6 +2822,14 @@ sub process {
> > > > >                            "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
> > > > >               }
> > > > >
> > > > > +# Check for adding new DT bindings not in schema format
> > > > > +             if (!$in_commit_log &&
> > > > > +                 ($line =~ /^new file mode\s*\d+\s*$/) &&
> > > > > +                 ($realfile =~ m@^Documentation/devicetree/bindings/.*\.txt$@)) {
> > > > > +                     WARN("DT_SCHEMA_BINDING_PATCH",
> > > > > +                          "DT bindings should be in DT schema format. See: Documentation/devicetree/writing-schema.rst\n");
> > > > > +             }
> > > > > +
> > > >
> > > > As this already seems to be git dependent, perhaps
> > >
> > > It's quite rare to see a non git generated diff these days.
> > >
> > > > it's easier to read with a single line test like:
> > > >
> > > >                 if ($line =~ m{^\s*create mode\s*\d+\s*Documentation/devicetree/bindings/.*\.txt$}) {
> > > >                         etc...
> > > >                 }
> > >
> > > I frequently do 'git show $commit | scripts/checkpatch.pl' and this
> > > doesn't work with that. I really should have a '--pretty=email' in
> > > there, but I just ignore the commit msg warnings. In any case, that
> > > still doesn't help because there's no diffstat. There's probably some
> > > way to turn that on or just use git-format-patch, but really we want
> > > this to work with any git diff.
> >
> > I don't understand your argument against what I proposed at all.
>
> It is dependent on the commit message rather than the diff itself. I
> want it to work with or without a diffstat.
>
> > and btw:
> >
> > $ git format-patch -1 --stdout <commit> | ./scripts/checkpatch.pl
>
> Yes, I stated this was possible. My concern is there are lots of ways
> to generate a diff in git. My way works for *all* of them. Yours
> doesn't.

Joe, are you okay with this?

Rob
