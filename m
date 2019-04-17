Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319C0C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA3A20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="hfSPhcab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732820AbfDQQJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:09:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42622 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732634AbfDQQJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:09:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id p20so27938190qtc.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=hNTvJdps/sfN1uZ0URpc5eMGab3L7auzqAmVyACQEqM=;
        b=hfSPhcabZ0kBXAsMVEymune6/lbX5SkLQtAg7aN1sCltOjwbav+isi48wEFtpYEatx
         UlIZ+vSwJh6dpBTa8TKSjN5I/D9XQbfx48bPJvwaxMAPORerDvpAg3SDQRuOmoSIiZzt
         TXJmvrCAhNctObEEI2uAXR84qpQm47PcYlXASBTEwFhwYiF2gT1F5gVDdyPVlPxHqbjd
         k/eEpDLDbWMDM8ydUEahu5ubj9+K+UxOj0CQ6dsGhzV0EOPATh+xo14sVAFJ/NRVmzD/
         6j4H6vEp/sYwS+GR7N3TAgf+EAmBX6O+u9XMJfe8l9L14IGyk1iy22cl+1vO3XPn9rMf
         6htQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=hNTvJdps/sfN1uZ0URpc5eMGab3L7auzqAmVyACQEqM=;
        b=ojBqVC893AS/OX01g1RnWI66u+Dag4hiBJflCkKy814GaJmBxAyCrCof2D+99HYR9m
         2eHpKRU+gttVUhLEdkt5KcB9JNgYPTsCJXCYMWWs37EH3tNp6koSly5EAxqfSy5wC32J
         5+6By3rwJCNT5Kt1MV1onswIYeq7f5SBdTXmkZ7FbAIpQyIiIGbaURN+aR+TbYQeDZ8t
         UsOlsWpiPSYFqeyHZ6Sc5/2738G00udGFlGIQe/1oULPOCtbtF2Y1ONsx02IQbVZ4BFT
         5gZ9PRvgXQcZ02xdUBJF4zd1AHzLTfHP9CqUZrJUpIY5peU/pbXL7AC45X4bS/ImTHYX
         f8oQ==
X-Gm-Message-State: APjAAAW2SyJDp/IGj3nMlwxpN5VfxzIi0SPHF++XoNf3nI6avNMWz/Or
        kLReh3YTZw92dR/lN+trkwI21jO3OeI=
X-Google-Smtp-Source: APXvYqz4TkEs65RaQJfjugldAeNsWgoBIZjwf/dhuuALa+k9cqkWnVJ3w4BNoMyO5TzY7WDL8qdyrg==
X-Received: by 2002:ac8:f86:: with SMTP id b6mr71427678qtk.330.1555517375203;
        Wed, 17 Apr 2019 09:09:35 -0700 (PDT)
Received: from tpx230-nicolas.collaboramtl (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id j5sm33424972qtb.30.2019.04.17.09.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 09:09:33 -0700 (PDT)
Message-ID: <02888af8ff23d0325c35d7b9d5c993b8dbe5c1c5.camel@ndufresne.ca>
Subject: Re: [PATCH v4] media: docs-rst: Document m2m stateless video
 decoder interface
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Alexandre Courbot <acourbot@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 17 Apr 2019 12:09:32 -0400
In-Reply-To: <CAPBb6MU4yJVJq_AasQ0p9PPxtUyt73yB-10=ATCudUTsiwKOSg@mail.gmail.com>
References: <20190306080019.159676-1-acourbot@chromium.org>
         <371df0e4ec9e38d83d11171cbd98f19954cbf787.camel@ndufresne.ca>
         <da5aa9ab957923a72e30b169a3c242c4fe6260f1.camel@bootlin.com>
         <c07703459c7e48904bd7fd83be1e675c70eee83c.camel@ndufresne.ca>
         <d81d0112b99feba0a1899f3722077a4aeec9860c.camel@bootlin.com>
         <439b7f57aa3ba2b2ed5b043f961ef87cb83912af.camel@ndufresne.ca>
         <59e23c5ca5bfbadf9441ea06da2e9b9b5898c6d7.camel@bootlin.com>
         <0b495143bb260cf9f8927ee541e7f001842ac5c3.camel@ndufresne.ca>
         <CAPBb6MVG+3jQcw3AuhYDYCZ0YJ0aX=TmEuM5izh12GLw9V6B8Q@mail.gmail.com>
         <0f4775b1bb04e136e3a425df0ba6a201594acdbd.camel@bootlin.com>
         <CAPBb6MU4yJVJq_AasQ0p9PPxtUyt73yB-10=ATCudUTsiwKOSg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-lIOBNaPN4GZo1Y3+jXcR"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lIOBNaPN4GZo1Y3+jXcR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 17 avril 2019 =C3=A0 14:39 +0900, Alexandre Courbot a =C3=A9cri=
t :
> Hi Paul,
>=20
> On Tue, Apr 16, 2019 at 4:55 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > Hi,
> >=20
> > Le mardi 16 avril 2019 =C3=A0 16:22 +0900, Alexandre Courbot a =C3=A9cr=
it :
> >=20
> > [...]
> >=20
> > > Thanks for this great discussion. Let me try to summarize the status
> > > of this thread + the IRC discussion and add my own thoughts:
> > >=20
> > > Proper support for multiple decoding units (e.g. H.264 slices) per
> > > frame should not be an afterthought ; compliance to encoded formats
> > > depend on it, and the benefit of lower latency is a significant
> > > consideration for vendors.
> > >=20
> > > m2m, which we use for all stateless codecs, has a strong assumption
> > > that one OUTPUT buffer consumed results in one CAPTURE buffer being
> > > produced. This assumption can however be overruled: at least the venu=
s
> > > driver does it to implement the stateful specification.
> > >=20
> > > So we need a way to specify frame boundaries when submitting encoded
> > > content to the driver. One request should contain a single OUTPUT
> > > buffer, containing a single decoding unit, but we need a way to
> > > specify whether the driver should directly produce a CAPTURE buffer
> > > from this request, or keep using the same CAPTURE buffer with
> > > subsequent requests.
> > >=20
> > > I can think of 2 ways this can be expressed:
> > > 1) We keep the current m2m behavior as the default (a CAPTURE buffer
> > > is produced), and add a flag to ask the driver to change that behavio=
r
> > > and hold on the CAPTURE buffer and reuse it with the next request(s) =
;
> >=20
> > That would kind of break the stateless idea. I think we need requests
> > to be fully independent of eachother and have some entity that
> > coordinates requests for this kind of things.
>=20
> Side note: the idea that stateless decoders are entirely stateless is
> not completely accurate anyway. When we specify a resolution on the
> OUTPUT queue, we already store some state. What matters IIUC is that
> the *hardware* behaves in a stateless manner. I don't think we should
> refrain from storing some internal driver state if it makes sense.
>=20
> Back to the topic: the effect of this flag would just be that the
> first buffer is the CAPTURE queue is not removed, i.e. the next
> request will work on the same buffer. It doesn't really preserve any
> state - if the next request is the beginning of a different frame,
> then the previous work will be discarded and the driver will behave as
> it should, not considering any previous state.
>=20
> > > 2) We specify that no CAPTURE buffer is produced by default, unless a
> > > flag asking so is specified.
> > >=20
> > > The flag could be specified in one of two ways:
> > > a) As a new v4l2_buffer.flag for the OUTPUT buffer ;
> > > b) As a dedicated control, either format-specific or more common to a=
ll codecs.
> >=20
> > I think we must aim for a generic solution that would be at least
> > common to all codecs, and if possible common to requests regardless of
> > whether they concern video decoding or not.
> >=20
> > I really like the idea of introducing a requests batch/group/queue,
> > which groups requests together and allows marking them done when the
> > whole group is done being decoded. For that, we explicitly mark one of
> > the requests as the final one, so that we can continue adding requests
> > to the batch even when it's already being processed. When all the
> > requests are done being decoded, we can mark them done.
>=20
> I'd need to see this idea more developed (with maybe an example of the
> sequence of IOCTLs) to form an opinion about it. Also would need to be
> given a few examples of where this could be used outside of stateless
> codecs. Then we will have to address what this means for requests:
> your argument against using a "release CAPTURE buffer" flag was that
> requests won't be fully independent from each other anymore, but I
> don't see that situation changing with batches. Then, does the end of
> a batch only means that a CAPTURE buffer should be released, or are
> other actions required for non-codec use-cases? There are lots and
> lots of questions like this one lurking.
>=20
> > With that, we also need some tweaking in the core to look for an
> > available capture buffer that matches the output buffer's timestamp
> > before trying to dequeue the next available capture buffer
>=20
> I don't think that would be strictly necessary, unless we want to be
> able to decode slices from different frames before the first one is
> completed?
>=20
> > This way,
> > the first request of the batch will get any queued capture buffer, but
> > subsequent requests will find the matchung capture buffer by timestamp.
> >=20
> > I think that's basically all we need to handle that and the two aspects
> > (picking by timestamp and requests groups) are rather independent and
> > the latter could probably be used in other situations than video
> > decoding.
> >=20
> > What do you think?
>=20
> At the current point I'd like to avoid over-engineering things.
> Introducing a request batch mechanism would mean more months spent
> before we can set the stateless codec API in stone, and at some point
> we need to settle and release something that people can use. We don't
> even have clear idea of what batches would look like and in which
> cases they would be used. The idea of an extra flag is simple and
> AFAICT would do the job nicely, so why not proceed with this for the
> time being?

I also share this feeling that this might be a bit over-engineered for
what we want to solve. But I also don't fully understand Paul's
proposal.

>=20
> Cheers,
> Alex.

--=-lIOBNaPN4GZo1Y3+jXcR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXLdPvAAKCRBxUwItrAao
HOe3AKCnxAwpm2y+c1oUtNuhjcBKR9dffQCbBsiMrLZ8KWixiVveAXmeivbplvE=
=/TTp
-----END PGP SIGNATURE-----

--=-lIOBNaPN4GZo1Y3+jXcR--

