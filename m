Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BA6C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A6920709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTvyaCGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLWJAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 04:00:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40295 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfLWJA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 04:00:29 -0500
Received: by mail-lf1-f68.google.com with SMTP id i23so12008535lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 01:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=aa6Dpm6sR/qHUolT0Qp1hv5sK71IVF5Jg8qXnOnpGpA=;
        b=sTvyaCGa2znXHXcZ6qQWQMBzuVtK1jM4XvP0aOFm/iKh48upHNWWE5bj6EP5L65pRp
         eFku/+WIQPUfi8b7BsUixBQ7eRLXwIUZYA3B3+to9dGEFmeSPHMbW/VFSHqd+ESMzJ2X
         JnUXo86OihimbluKAFnVfRJCURkVlrblLwmWEadjobMM/IDPXj+MwSHmrU012zkx2amV
         qIy5gX3preJ9Wt4FHmDH8yrehUyGN9ca4TvszI0GPZtti3jhCsBi5zYXgwyEQ+O2Rmlh
         uBccUt9qGeX/4GbeCx/GgBsdrMQ+xPBrgl9+3TnBJQxQGe8t+19Gq0g5rDiNmBtICFJp
         oqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=aa6Dpm6sR/qHUolT0Qp1hv5sK71IVF5Jg8qXnOnpGpA=;
        b=JTlq+XZJFkIJQTvdwg+MPwnHDEbf04hxpEGgGTpeiBX44Ing1ox4WMXJdbco6ca8Le
         vmRaJruxRAR5+KHBiKOr7aC8BRPNqLVceSh78DpxhPJmaI3CiMn4PyeVZHYTWLeiuqax
         /lCUQjHZTJ7hA635RB3PMasDQ+pSuBhoCQoi+KTLWYLBjRnJMFwX0PX+lcA4l4eILcLg
         BrxgHvzPT4O1nqlj2diGG8Zf6qtrCLjyvoRLiGClH+AO/ir3GdzjjNCdCRhaz0fO1x6H
         ypzNRE6LoTJ/1DlkGZnXslfjaOG8mMqOEmigIbdR323uWHTB/AVAgg8EaUi4wuRcubTv
         pmDg==
X-Gm-Message-State: APjAAAXK3xiOhAKnzkcThuP9nZ8ZLHPUozuCaODrqd20uaIc2TOsDMfF
        8i+tLTpC7Ljx68BxHWm9Y/w=
X-Google-Smtp-Source: APXvYqy4489+nwxlz1EFTjFZy/ab2gVV0cuq1tz8F501j3asrgl8ycX7+kCaxsiFoP5Hc//dj0fLuw==
X-Received: by 2002:ac2:5147:: with SMTP id q7mr16189501lfd.87.1577091626673;
        Mon, 23 Dec 2019 01:00:26 -0800 (PST)
Received: from ferris.localdomain (85-156-247-180.elisa-laajakaista.fi. [85.156.247.180])
        by smtp.gmail.com with ESMTPSA id 138sm8019591lfa.76.2019.12.23.01.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 01:00:26 -0800 (PST)
Date:   Mon, 23 Dec 2019 11:00:15 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, dbueso@suse.de,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Chenfeng \(puck\)" <puck.chen@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kongxinwei \(A\)" <kong.kongxinwei@hisilicon.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: SIGBUS on device disappearance (Re: Warnings in DRM code when
 removing/unbinding a driver)
Message-ID: <20191223110015.0e04ea25@ferris.localdomain>
In-Reply-To: <CAKMK7uHEL3WzSHDM3XdLwOBtQUtygK6x-md8W1MVsAryDDgFog@mail.gmail.com>
References: <07899bd5-e9a5-cff0-395f-b4fb3f0f7f6c@huawei.com>
        <f867543cf5d0fc3fdd0534749326411bcfc5e363.camel@collabora.com>
        <c2e5f5a5-5839-42a9-2140-903e99e166db@huawei.com>
        <fde72f73-d678-2b77-3950-d465f0afe904@huawei.com>
        <CAKMK7uFr03euoB6rY8z9zmRyznP41vwfdaKApZ_0HfYZT4Hq_w@mail.gmail.com>
        <fcca5732-c7dc-6e1d-dcbe-bfd914a4295b@huawei.com>
        <CAKMK7uE+nfR2hv1ybfv1ZApZbGnnX7ZHfjFCv5K72ZaAmdtfug@mail.gmail.com>
        <20191219113151.sytkoi3m7rrxzps2@sirius.home.kraxel.org>
        <CAKMK7uHEL3WzSHDM3XdLwOBtQUtygK6x-md8W1MVsAryDDgFog@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/oSOg+0g8SiapMgx3IUoxrFY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oSOg+0g8SiapMgx3IUoxrFY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Dec 2019 13:42:33 +0100
Daniel Vetter <daniel@ffwll.ch> wrote:

> On Thu, Dec 19, 2019 at 12:32 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > While being at it:  How would a driver cleanup properly cleanup gem
> > objects created by userspace on hotunbind?  Specifically a gem object
> > pinned to vram? =20
>=20
> Two things:
> - the mmap needs to be torn down and replaced by something which will
> sigbus. Probably should have that as a helper (plus vram fault code
> should use drm_dev_enter/exit to plug races).

Hi,

I assume SIGBUS is the traditional way to say "oops, the memory you
mmapped and tried to access no longer exists". Is there nothing
else for this?

I'm asking, because SIGBUS is really hard to handle right in
userspace. It can be caused by any number of wildly different
reasons, yet being a signal means that a userspace process can only
have a single global handler for it. That makes it almost
impossible to use safely in libraries, because you would want to
register independent handlers from multiple libraries in the same
process. Some libraries may also be using threads.

How to handle a SIGBUS completely depends on what triggered it.
Almost always userspace wants it to be a non-fatal error. A Wayland
compositor can hit SIGBUS on accessing wl_shm-based client buffers
(regular mmapped files), and then it just wants to continue with
garbage data as if nothing happened and possibly send a protocol
error to the client provoking it.

I would also imagine that Mesa, when it starts looking into
supporting GPU hotunplug, needs to handle vanished mmaps. I don't
think Mesa can ever install signal handlers, because that would
mess with the applications that may already be using SIGBUS for
handling disappearing mmapped files. It needs to start returning
errors via API calls. I cannot imagine a way to reliably prevent
such SIGBUS either by e.g. ensuring Mesa gets notified of removal
before it actually starts failing.

For now, I'm just looking for a simple "yes" or "no" here for the
something else. If it's "no" like I expect, creating something else
is probably in the order of years to get into a usable state. Does
anyone already have plans towards that?


Thanks,
pq

--Sig_/oSOg+0g8SiapMgx3IUoxrFY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAl4Agh8ACgkQI1/ltBGq
qqcrog//Yo3U/N4JzdLnUqmXy6bf0cwQqwkriI658FNiERT8OtbBwU8JSg90qaMi
4BHz5mE4LFFbhX4f4Tb2g+4ELbNa5K217o8izPC9vAp5jUsaJo6L7z8fZrHzvcWC
WaIwlNEuP27sEeQoyhhKY2lfxIaQJNjPS9IpYHxGi13xdBvOO5CRfjVDpRrY7Fzk
qCHyBgLK1dxaP1dGO5KT63KrMFTdePWYgJ3mS3ZA20GM00gxEgHvlcCR/4LY+Vn8
owwybWTojC8ozFpA4RdQgm5pXRMrEcIb+Z1raDzDs6iYK8lDUAhKocsnVVxpTHmv
OXyqI3faRtmWnIkDa6e8Yge0V18VmKavJc6BRvXO2trVYuXz0mV4HggSmgL5pbcE
bSo7qahDfWL0Td1SgJ6hN3hbmCkENhkZcs6K/oFnq2rOszDB9v8apkQhl/nprNfT
Vl6d+YeIZbLz/vhKFk4qLs03x1xRxvP4tbcCrAcWM15DXkTzYF5w1lBNoC7lu8vY
rJgZBYkv3v4dVpdJKY0sSQ0mY9uDeukaiGItMoJTjejR+XZnkZU5iXf93MOCa+O+
/3tA2VJzsBPfqhf752FMsYkoXaOPGYmEuPhpIukeuGuPGaack0GV8LG5Mq2WJz4m
NZ+4vnkZom83dH9yeLccZEK1GUxJgAZ/CrxQ/8nZygtdmVQjkgU=
=KwQo
-----END PGP SIGNATURE-----

--Sig_/oSOg+0g8SiapMgx3IUoxrFY--
