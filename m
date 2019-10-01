Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AC9C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 05:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9138B2168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 05:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="azESaA0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfJAFbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 01:31:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37975 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfJAFbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 01:31:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id u28so8827190lfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 22:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SaFoYhmwuNCCe0dxD4a30Zl6Go0ZxpMOGqzzubMUHdw=;
        b=azESaA0rdcy9GMB3FE8I4/zNalw7ysfkd8tfzjgj0RmnGawU5l6mzRJjHXNAt4IEyV
         wy9qVNdmmcOgGESFc3PXu9o5lOAVD8PNRdHmmwtMPqkOCowpNOH1ZwnKZ4cMbCKxzWFk
         32kbYx/D+sDYwixF1TtIg0L2ChdH/rsPBcJuO4AlNhlaigIWk68u0LZ4GJiHi35pEaV3
         yUXj0FmfrNF7QeT/p4m119G4iN4IhZq3+oylQ55x8rv4IxA/iKr+DPFlVc5zlSLoU1TJ
         wWeja5LAMc/L+1lHON5BZkGiXmIridIuk4ZepjpHGQpgE85tvZp5HOTo5c8QL0/opDhu
         Bv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SaFoYhmwuNCCe0dxD4a30Zl6Go0ZxpMOGqzzubMUHdw=;
        b=SuFkOALrJfWxOqz62AKi6utv0R656pxjf4JpiFazB3QFBChA56hXM7W7C2GD+qYn81
         HTAPQqDzMrSX1yotJKJT7s4nCN+JAm29zCbpQ18DlbJSfDu9QfOkvW4lz16NZGAoF/YX
         pC/yqTEtgEazpqTm0BwMKGeG5IQeiGTG8vjvpcfvNJYxc/d0adb83OBepg6YdHF8+uWt
         GM6WZ571+39HwgE4VGxjy5e69wK+71VP466kqsIZ4p2UU6CzVf/t1Y4wW081rPn8bgRA
         7d6WCl98vbsTNGpg9UJpjKF6ymZpCX+PzM7LI0wV6fu1bREbJA42iSUP2kTZg0A7ZCeu
         X2eg==
X-Gm-Message-State: APjAAAWb1vZoZsdMV2c86kD7aL3+tW1mYkr67EAw14kbEgIofi6VDC6y
        qDgmcQgnLhGPcuaCa8KFVJDU699FYxVotW/uWsfE
X-Google-Smtp-Source: APXvYqxzu/y3a+l/E1zfJ1GOYAu4oXQyAYURFEX7eRMkz3mjRmcinntM7JzqNurwlxoUk87hd8Bu9ZzmdAjySpJiO8k=
X-Received: by 2002:a05:6512:202:: with SMTP id a2mr13379491lfo.175.1569907890668;
 Mon, 30 Sep 2019 22:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <201909251348.A1542A52@keescook> <CAHC9VhRNmWw1__-haD1ZEekADTho3EJyXQMd6ETpOv4c8Qn9nw@mail.gmail.com>
 <2065829.xbNJnTdZ4q@x2> <201909301128.5951C390@keescook>
In-Reply-To: <201909301128.5951C390@keescook>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Oct 2019 01:31:19 -0400
Message-ID: <CAHC9VhR-3CkARf7mVOCW1vLDgygjspcw_JEcteBBrdpxpdBY7g@mail.gmail.com>
Subject: Re: [PATCH] audit: Report suspicious O_CREAT usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Steve Grubb <sgrubb@redhat.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= 
        <jeremie.galarneau@efficios.com>, s.mesoraca16@gmail.com,
        viro@zeniv.linux.org.uk, dan.carpenter@oracle.com,
        akpm@linux-foundation.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kernel-hardening@lists.openwall.com, linux-audit@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 2:29 PM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Sep 30, 2019 at 09:50:00AM -0400, Steve Grubb wrote:
> > On Thursday, September 26, 2019 11:31:32 AM EDT Paul Moore wrote:
> > > On Wed, Sep 25, 2019 at 5:02 PM Kees Cook <keescook@chromium.org> wro=
te:
> > > > This renames the very specific audit_log_link_denied() to
> > > > audit_log_path_denied() and adds the AUDIT_* type as an argument. T=
his
> > > > allows for the creation of the new AUDIT_ANOM_CREAT that can be use=
d to
> > > > report the fifo/regular file creation restrictions that were introd=
uced
> > > > in commit 30aba6656f61 ("namei: allow restricted O_CREAT of FIFOs a=
nd
> > > > regular files"). Without this change, discovering that the restrict=
ion
> > > > is enabled can be very challenging:
> > > > https://lore.kernel.org/lkml/CA+jJMxvkqjXHy3DnV5MVhFTL2RUhg0WQ-XVFW=
3ngDQO
> > > > dkFq0PA@mail.gmail.com
> > > >
> > > > Reported-by: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficio=
s.com>
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > > This is not a complete fix because reporting was broken in commit
> > > > 15564ff0a16e ("audit: make ANOM_LINK obey audit_enabled and
> > > > audit_dummy_context")
> > > > which specifically goes against the intention of these records: the=
y
> > > > should _always_ be reported. If auditing isn't enabled, they should=
 be
> > > > ratelimited.
> > > >
> > > > Instead of using audit, should this just go back to using
> > > > pr_ratelimited()?
> > >
> > > I'm going to ignore the rename and other aspects of this patch for th=
e
> > > moment so we can focus on the topic of if/when/how these records
> > > should be emitted by the kernel.
> > >
> > > Unfortunately, people tend to get very upset if audit emits *any*
> > > records when they haven't explicitly enabled audit, the significance
> > > of the record doesn't seem to matter, which is why you see patches
> > > like 15564ff0a16e ("audit: make ANOM_LINK obey audit_enabled and
> > > audit_dummy_context").  We could consider converting some records to
> > > printk()s, rate-limited or not, but we need to balance this with the
> > > various security certifications which audit was created to satisfy.
> > > In some cases a printk() isn't sufficient.
> > >
> > > Steve is probably the only one who really keeps track of the various
> > > auditing requirements of the different security certifications; what
> > > say you Steve on this issue with ANOM_CREAT records?
> >
> > Common Criteria and other security standards I track do not call out fo=
r
> > anomoly detection. So, there are no requirements on this. That said, we=
 do
> > have other anomaly detections because they give early warning that some=
thing
> > strange is happening. I think adding this event is a nice improvement a=
s long
> > as it obeys audit_enabled before emitting an event - for example, look =
at the
> > AUDIT_ANOM_ABEND event.
>
> Okay, so the patch is good as-is? (The "report things always" issue I
> will deal with separately. For now I'd just like to gain this anomaly
> detection corner case...)
>
> Paul, what do you see as next steps here?

I'll reply back on the original post so I can more easily comment on
the details of patch.

--=20
paul moore
www.paul-moore.com
