Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65D8C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EAA206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vG78SzmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfLIXkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:40:17 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32817 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfLIXkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:40:17 -0500
Received: by mail-pf1-f195.google.com with SMTP id y206so8060171pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 15:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vl02im/rN6crfZYM0xjGCQ9VgZJr5qrqGs7/N7GKCu8=;
        b=vG78SzmWLo36DtbpDPAEr79GTtu6zsyI7LUWkbmM9c4sLQd16bdKsA4M05vEM3fgLX
         gRXhZ4HHPiJq6y3tfxWnnoRBgFDelqfowK50edVtujTEiQ1x/8KMNbTYtFpb+t76OKb+
         yPYsH7sC4O9/w0IDQO+0Kk7DbAallpuT/edxIoZZ256UBEVviTuSKjs6E4zyfQ/rlO+B
         c14IeRSxNt5NTzmxIGX/ueFe3wY4ruPBNDAYJKG1JcDeP4ktq/tQXJ3VhzPdQd/HCwvt
         4THzXgEUxW96st6rWBfxrU5cThkb8y5BuWBVzhEBe/RTmgRq95DeZyE0FdfjT2r/F8w2
         yjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vl02im/rN6crfZYM0xjGCQ9VgZJr5qrqGs7/N7GKCu8=;
        b=Rr+hpZr43JSSchjxjKpQ+IA01koloGmTeU5LX9uJV0/8jMagBbFtUgFrGcEaqoVj7e
         Q0gYafPX9FMGI1e+Nvd9iA427y6w6BNWpLN2i7VP1+nRkPhXvz1tVszIDSE6l12izMQs
         WuY2gFsMHI2uXchy6PHdnTEDu5Fay74IQs1QALSruyyFlJUNw46xkYVfH14boJO26xmd
         QARJXxtXGbqTF5QHeDrg0877ktXkyADfPXaMH8c8VenPc+UCohizpZIHPT7dBqKmjOqM
         Wko54NIHatKiMMIYw7mXqSkulT5sByK5kPogULYYuxtSdlK7RA/XMj8H39XrQJL5/EqK
         Y9OA==
X-Gm-Message-State: APjAAAUP22rPyK0Xml5WjZnpL0fP3OLQnJnVbCljDLQOl9dXIQAPDAMY
        CSC7fN6y0sHDMm5mYREICyQzL5Zqx5NlU71YQkO+PlTTpzA=
X-Google-Smtp-Source: APXvYqwMJdVJ1wR+zJ5xK8rJ0KAxWUjjX34i0zHtAWbe0J69fF4p+2Ap4C+aphdVxZ/GdtoBOYBSOLxwodAo6S5non8=
X-Received: by 2002:a62:174b:: with SMTP id 72mr32322933pfx.185.1575934816254;
 Mon, 09 Dec 2019 15:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20191206020153.228283-1-brendanhiggins@google.com>
 <20191206020153.228283-2-brendanhiggins@google.com> <f217945d-ab64-10cc-bb12-3a4d810ff25a@cambridgegreys.com>
 <CAFd5g45cSKATfw4GKPw6QdhQKDNi=0gcDRjQ7N0T1XrdtSTPrg@mail.gmail.com>
 <20191207012108.GA220741@google.com> <15f048d3-07ab-61c1-c6e0-0712e626dd33@cambridgegreys.com>
In-Reply-To: <15f048d3-07ab-61c1-c6e0-0712e626dd33@cambridgegreys.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 9 Dec 2019 15:40:04 -0800
Message-ID: <CAFd5g448yZ5nSVLnN0gvsv3jLnhWG+dzJgvH1jdV+s2eTq4wxg@mail.gmail.com>
Subject: Re: [RFC v1 1/2] um: drivers: remove support for UML_NET_PCAP
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     johannes.berg@intel.com, Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 7, 2019 at 1:15 AM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
> On 07/12/2019 01:21, Brendan Higgins wrote:
> > On Fri, Dec 06, 2019 at 04:32:34PM -0800, Brendan Higgins wrote:
> >> On Thu, Dec 5, 2019 at 11:23 PM Anton Ivanov
> >> <anton.ivanov@cambridgegreys.com> wrote:
> >> [...]
> >>> 1. There is a proposed patch for the build system to fix it.
> >
> > So I just tried the patch you linked on the cover letter[1], and I am
> > still getting the build error described above:
> >
> > arch/um/drivers/pcap_user.c:35:12: error: conflicting types for =E2=80=
=98pcap_open=E2=80=99
> >   static int pcap_open(void *data)
> >              ^~~~~~~~~
> > In file included from /usr/include/pcap.h:43,
> >                   from arch/um/drivers/pcap_user.c:7:
> > /usr/include/pcap/pcap.h:859:18: note: previous declaration of =E2=80=
=98pcap_open=E2=80=99 was here
> >   PCAP_API pcap_t *pcap_open(const char *source, int snaplen, int flags=
,
> >
> > Looking at the patch, I wouldn't expect it to solve this problem.
> >
> > Are there maybe different conflicting libpcap-dev libraries and I have
> > the wrong one? Or is this just still broken?
> >
> >>> 2. We should be removing all old drivers and replacing them with the
> >>> vector ones.
> >>
> >> Hmm...does this mean you would entertain a patch removing all the
> >> non-vector UML network drivers? I would be happy to see VDE go as
> >> well.
> >>
> >> In any event, it sounds like I should probably drop this patch as it
> >> is currently.
> >>
> >> Thanks!
> >
> > [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D938962#79
> >
> > _______________________________________________
> > linux-um mailing list
> > linux-um@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-um
> >
>
> OK, looks like the pcap.h differs now as well.
>
> I will fix that too. It looks like you need both a pcap fix and a
> library linking fix for this to work.
>
> The patch fixes the issue with the build system which no longer provides
> the means for UML to specify extra libraries (I probably had an older
> pcap version on the machine where I tested this).
>
> IMHO frankly it is no longer necessary.
>
> 5.5-rc1 vector raw now has the facility to add/remove (including at
> runtime) filters compiled with pcap outside UML. It was merged this week.
>
> We now have the following line-up for vector drivers - EoGRE, EoL2TPv3,
> RAW (+/- BPF), TAP and BESS. Speeds are 2.5 to 9Gbit on my machine
> (mid-range Ryzen desktop).
>
> If I figure out a way to get hold of the underlying tap raw sockets the
> same way vhost does, TAP can probably go to 12Gbit or thereabouts. Same
> applies to getting zerocopy working with raw.
>
> As a basis for comparison I get 18Gbit on the same machine using vEth
> and containers. 50% of that is actually a very decent number.
>
> While vector drivers are not 1:1 replacements for the existing drivers,
> you can achieve the same topologies and the same connectivity at much
> higher performance - the old drivers test out in the 500Mbit range on
> the same hardware.
>
> IMHO we should at least mark them as "obsolete" and start preparing to
> remove them.

Alright, I will send a patch out which marks the other network drivers
as "obsolete".

Clarification: Should I mark all UML network devices as "obsolete"
except for NET_VECTOR? Daemon and MCAST looked to me (I am not a
networking expert), like they might not be covered by vector.
