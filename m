Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273A6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20E720863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN414jHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbfCYQqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:46:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37052 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCYQqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:46:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so11004835wrm.4;
        Mon, 25 Mar 2019 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5EXv13zgz9awdVE1sfJydYAP6tyRfZcRZHPg1eXafgU=;
        b=jN414jHktHenpLw3VrcmuB2FN+xMxhVa5Q6nA3aqJocDqwo/X7TJR9tuTx1Q3rqWJY
         BpzDVd4gBi+ee1d0IdAtx1bOfpDte+t3q80SEBSd6JYzfOKi8WPObKO7q4yTKy9yFfXH
         GQ0IZlHSORuqAhC8mtQ/7jG/q2YGZVLDgxxBH9Y6wgzyhiNxRFRKMn9PTEcsxBCCdmlp
         u/TiofQIP44vh5zkyfgE4GMbiQCy0GHFGJQHvIBVjKcanJE4onjzy8Icj0HymWYh5zH/
         ylgUhivO8sKxJ8wUcpM+gSXvvI8j3gH6SnlpVUoaHt1bYHzVliPLqcNmUw3VP7sw9PN7
         EmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5EXv13zgz9awdVE1sfJydYAP6tyRfZcRZHPg1eXafgU=;
        b=R0fRe+8+Si2o7xqWYaamAQIVroxqATJ9ga/f5rnR6C8YLYbVM6PlYqVp/w1hmojKaK
         TqUZrCsBlj11YNnQeVQExi771i3y/QTrbUDHmcxse+KAFnJ/60uvlYKcFQ1rwNkv3nrR
         0AHo9J7R3G3ZTgdNg70sMCKuZpqpOwNGFQcyIFFz4+5T+yshULaHhwgrgnGN6tACDl1x
         9+ChEzUDFsDjVIYmlG9dpzRZwTucrvYsib0cCfW0J3RfxaLXNi/4UM4bfDTbdPwKSPbz
         g4YITW7/35fUr1g5+L37V0oKnkkb+gsVXzexhKKZTWTRFfyX2JydqbvVEfnOQFUTVHOB
         VZTA==
X-Gm-Message-State: APjAAAXQgumNP0sg5JTALG0GM/RKUuhK47xvHDsllcqgMVzAZE27Buma
        YbXJFxvP+goy4zdURRepP58=
X-Google-Smtp-Source: APXvYqxSaGWiIbgtoBdrr54YZN+flkccenR14KnEE8TOvs21B0mOQGYBicNMhPHm0jhzVYb2gftrbQ==
X-Received: by 2002:a5d:5192:: with SMTP id k18mr16710143wrv.171.1553532366166;
        Mon, 25 Mar 2019 09:46:06 -0700 (PDT)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id z1sm7467999wrs.52.2019.03.25.09.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 09:46:04 -0700 (PDT)
Date:   Mon, 25 Mar 2019 16:46:03 +0000
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liang Cunming <cunming.liang@intel.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        Fam Zheng <fam@euphon.net>, Amnon Ilan <ailan@redhat.com>,
        John Ferlan <jferlan@redhat.com>
Subject: Re: your mail
Message-ID: <20190325164603.GB10732@stefanha-x1.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <20190321161352.GA21682@stefanha-x1.localdomain>
 <a4dc67e66cd126892468011311ff516853754cdb.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <a4dc67e66cd126892468011311ff516853754cdb.camel@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2019 at 07:07:38PM +0200, Maxim Levitsky wrote:
> On Thu, 2019-03-21 at 16:13 +0000, Stefan Hajnoczi wrote:
> > On Tue, Mar 19, 2019 at 04:41:07PM +0200, Maxim Levitsky wrote:
> > > Date: Tue, 19 Mar 2019 14:45:45 +0200
> > > Subject: [PATCH 0/9] RFC: NVME VFIO mediated device
> > >=20
> > > Hi everyone!
> > >=20
> > > In this patch series, I would like to introduce my take on the proble=
m of
> > > doing=20
> > > as fast as possible virtualization of storage with emphasis on low la=
tency.
> > >=20
> > > In this patch series I implemented a kernel vfio based, mediated devi=
ce
> > > that=20
> > > allows the user to pass through a partition and/or whole namespace to=
 a
> > > guest.
> > >=20
> > > The idea behind this driver is based on paper you can find at
> > > https://www.usenix.org/conference/atc18/presentation/peng,
> > >=20
> > > Although note that I stared the development prior to reading this pap=
er,=20
> > > independently.
> > >=20
> > > In addition to that implementation is not based on code used in the p=
aper
> > > as=20
> > > I wasn't being able at that time to make the source available to me.
> > >=20
> > > ***Key points about the implementation:***
> > >=20
> > > * Polling kernel thread is used. The polling is stopped after a=20
> > > predefined timeout (1/2 sec by default).
> > > Support for all interrupt driven mode is planned, and it shows promis=
ing
> > > results.
> > >=20
> > > * Guest sees a standard NVME device - this allows to run guest with=
=20
> > > unmodified drivers, for example windows guests.
> > >=20
> > > * The NVMe device is shared between host and guest.
> > > That means that even a single namespace can be split between host=20
> > > and guest based on different partitions.
> > >=20
> > > * Simple configuration
> > >=20
> > > *** Performance ***
> > >=20
> > > Performance was tested on Intel DC P3700, With Xeon E5-2620 v2=20
> > > and both latency and throughput is very similar to SPDK.
> > >=20
> > > Soon I will test this on a better server and nvme device and provide
> > > more formal performance numbers.
> > >=20
> > > Latency numbers:
> > > ~80ms - spdk with fio plugin on the host.
> > > ~84ms - nvme driver on the host
> > > ~87ms - mdev-nvme + nvme driver in the guest
> >=20
> > You mentioned the spdk numbers are with vhost-user-nvme.  Have you
> > measured SPDK's vhost-user-blk?
>=20
> I had lot of measuments of vhost-user-blk vs vhost-user-nvme.
> vhost-user-nvme was always a bit faster but only a bit.
> Thus I don't think it makes sense to benchamrk against vhost-user-blk.

It's interesting because mdev-nvme is closest to the hardware while
vhost-user-blk is closest to software.  Doing things at the NVMe level
isn't buying much performance because it's still going through a
software path comparable to vhost-user-blk.

=46rom what you say it sounds like there isn't much to optimize away :(.

Stefan

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcmQXLAAoJEJykq7OBq3PIc7sIAIYuXgpCWd+RMCuZEacVyF40
Vn3LiQpyPwgDYEY0SY5jvaAEWl/oSSF9zwxg54VvvvVqbeHOvjxKkQ2fUYGdmmGT
uRuNVN+QX01Nw5QYhPeRXIHZhvmk8Hi3REJJ3I5dc1UukGs2h+2fSvuhR9v76OnI
TBFMYL1l3ru8e+YEF8kxHUXMYxMw1284GMK+Up/gtO3I0tkK07tq2ciLTDvVZ1ol
av/82aJio1BDA3/ivMJN8+7J1GwO1n1OiWTGM07rA385A9MeTz2CtvG7fX/dug5m
jgMgJpwZPOJUusRIVsgcwPamQ0OtGwr81Q01weD9JOskdKWtB/2W4KnY1nfRp48=
=YMup
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
