Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E978C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E98206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eo0vU1RB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfKNS2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:28:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20484 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726444AbfKNS2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573756104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vjJIEbtzSQcYXEkUCSsj91u0A3+hVjUm/YmX0koUYYw=;
        b=eo0vU1RB6qX4u3F9PRRHDhI9RFSEkRGhKtF+RiHw+Iq3S+kJzu6u4vPwCoQvTuVLXgt+XB
        uK0t4Zml/itmBlH1V/ZvAcSk//BggDZFMpN5w+Vd//+J2lUNraeBUPCPYbEC7265ReXn+w
        EZ8oIbVJw6gBQKjnXnc+WpdY3ws7DXs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-Vwe-OdpzP3GNeXhYqjWTGA-1; Thu, 14 Nov 2019 13:28:23 -0500
Received: by mail-qv1-f70.google.com with SMTP id i11so4727155qvh.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 10:28:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OTQr4yHzYH7UIs8xwDVjr3FeSsgSC8TnPuchdHTKIfA=;
        b=XzuxpHf8jWAq5U38DL2H2fm/X/v9lt/tOIOemn1JVi1+QuhyprEslE14K/0u2E1m/I
         9RXGrKDCUzgj96JoidY8bpZhVwgaKqqUglqbRHXh6LyeANYq+xSGoOKnKgGJp2sCzJAN
         Fsi0bmZY0zzkhsb9sDo80lHSQFjSoJxluKAme8URSBx16L21Qun9Yy/fkDs9g1uL3dEW
         W1nwBW3AFTvy+A5KnQuFtnVff1C+mEyBvCB6c5zOc9F8FXNpVjSJZ7q65Ub281ioKs5l
         6pN1nxsK/6/XxrceoPwFK/QfghG+WyeY/a9kaeE6qHfJCgG0NBaqt65DWhaaPskpUft2
         J3ow==
X-Gm-Message-State: APjAAAWpwusCtr3kTM47CxJyrqM7PasM2fwi31pEUglsyLPV9ysQjKR2
        4WG/y3kb4Ih/RS4SxbxypLSLQ3eDDnjtAHhpOhrE6x+pNQJQBNLUiZCngB+wmzTREnPjcowp/3s
        S1rxRzCegyZ1jGWmwnZHQVm9ww8N2fHEvk+27m+v0
X-Received: by 2002:ad4:4422:: with SMTP id e2mr9378337qvt.91.1573756102347;
        Thu, 14 Nov 2019 10:28:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqzUYibUnY9tZe7owV9Ya2yG5xOoUZbrIax+rhIjA+u9HPVJbjZuoJ1/62DepjT1rTwfolukWvGl1/jsjL1Sot4=
X-Received: by 2002:ad4:4422:: with SMTP id e2mr9378285qvt.91.1573756101687;
 Thu, 14 Nov 2019 10:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20191114105736.8636-1-lhenriques@suse.com> <cbda3a69d25b04e10332e7b3898064a93b2d04ae.camel@kernel.org>
 <alpine.DEB.2.21.1911141326260.17979@piezo.novalocal>
In-Reply-To: <alpine.DEB.2.21.1911141326260.17979@piezo.novalocal>
From:   Gregory Farnum <gfarnum@redhat.com>
Date:   Thu, 14 Nov 2019 10:28:10 -0800
Message-ID: <CAJ4mKGZVV2dt6qKZGO-KyQt0p81hAUqFGBwRodB6MSdeLh=Tow@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] ceph: safely use 'copy-from' Op on Octopus OSDs
To:     Sage Weil <sweil@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Luis Henriques <lhenriques@suse.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Yan, Zheng" <zyan@redhat.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-MC-Unique: Vwe-OdpzP3GNeXhYqjWTGA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 5:28 AM Sage Weil <sweil@redhat.com> wrote:
>
> On Thu, 14 Nov 2019, Jeff Layton wrote:
> > On Thu, 2019-11-14 at 10:57 +0000, Luis Henriques wrote:
> > > Hi!
> > >
> > > So, after the feedback I got from v1 [1] I've sent out a pull-request
> > > for the OSDs [2] which encodes require_osd_release into the OSDMap
> > > client data.  This allows the client to figure out which ceph release
> > > the OSDs cluster is running and decide whether or not it's safe to us=
e
> > > the copy-from Op for copy_file_range.
> > >
> > > This new patchset I'm sending simply adds enough functionality to the
> > > kernel client so that it can take advantage of this OSD patch:
> > >
> > > 0001 - adds the ability to decode TYPE_MSGR2 addresses.  This is a
> > >        required functionality for enabling SERVER_NAUTILUS in the
> > >        client.  I hope I got the new format right, as I couldn't figu=
re
> > >        out what the hard-coded values (see comments) really mean.
> > >
> >
> > nit: the first 3 patch subject lines should probably be prefixed with
> > "libceph:"
> >
> > > 0002 - allows the client to retrieve the new require_osd_release fiel=
d
> > >        from the OSDMap if available.  This patch also adds SERVER_MIM=
IC,
> > >        SERVER_NAUTILUS and SERVER_OCTOPUS to the supported features,
> > >        which TBH I'm not sure if that's a safe thing to do -- the onl=
y
> > >        issue I've seen was that Nautilus requires the ability to deco=
de
> > >        TYPE_MSGR2 address, but I may have missed others.
> > >
> >
> > Yes, this needs to be done with care. We have to ensure that the server
> > side isn't assuming that the client supports something that it doesn't.
> > I think that means just trawling through the code and verifying whether
> > this is safe.
> >
> > > 0003 - debug code to add require_osd_release to the osdmap debugfs fi=
le.
> > >
> > > 0004 - adds the truncate_{seq,size} fields to the 'copy-from' operati=
on
> > >        if the OSDs are >=3D Octopus.
> > >
> > > Also note that, as suggested by Ilya, I've dropped the patch that wou=
ld
> > > change the default mount options to 'copyfrom'.
> > >
> > > These patches have been tested with the xfstests generic test suite, =
and
> > > with a couple of other (local) tests that exercise the cephfs
> > > copy_file_range syscall.  I didn't saw any issues, but as I said abov=
e,
> > > I'm not really sure if adding the SERVER_* flags to the supported
> > > features have other side effects.
> > >
> > > [1] https://lore.kernel.org/lkml/20191108141555.31176-1-lhenriques@su=
se.com/
> > > [2] https://github.com/ceph/ceph/pull/31611
> > >
> >
> > I'm just getting caught up on the discussion here, but why was it
> > decided to do it this way instead of just adding a new OSD
> > "copy-from-no-truncseq" operation? Once you tried it once and an OSD
> > didn't support it, you could just give up on using it any longer? That
> > seems a lot simpler than trying to monkey with feature bits.
>
> I don't remember the original discussion either, but in retrospect that
> does seem much simpler--especially since hte client is conditioning
> sending this based on the the require_osd_release.  It seems like passing
> a flag to the copy-from op would be more reasonable instead of conditiona=
l
> feature-based behavior.
>
> Greg, do you remember why we ended up here?

Well, I can look it up. We discussed it being a different op in
February ("OSD 'copy-from' operation and truncate_seq value") and...it
looks like that conversation ended with that being the plan?

I can't see why it changed in the making though, and everyone seems to
have forgotten about it at the next pass.
-Greg

>
> sage
>

