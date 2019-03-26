Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281DEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4A820856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9AVvwr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbfCZJjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:39:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53543 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfCZJjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:39:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so11811774wmj.3;
        Tue, 26 Mar 2019 02:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9JBOtUryYHSUieR+7qnK45GmPxxQnA5OI7xgwospEDw=;
        b=s9AVvwr+FotJhqfMG0m/yu3n2tRdMtm7u6kHywHkef6RZtf7XT9k+Xq1By/MheobEN
         0R1sgAdC+0P4b9QRaECezRAkyYb+idK3ctFcXCKYIaXIIzzpM2OtyJU65eceKDNeHX6s
         qWDTrLZziaCSJKY93EKYlixgs6WzYeEh0NpG3BJbCr7aP/w8jH/G+H4nbiAx5wYMinp4
         n2N2x03ei5JftlidNJfro4F0cnPLM4h9ErMRYzk9Xr4iLbCihf8U2Jy7pdsGcbh4gFwc
         kgIUIBEdHrj7+CFXyW5f+TGmugdGgfi1Bu4LGaIXphvxSKSCTToTQhb1yIjN21dPy/US
         HgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9JBOtUryYHSUieR+7qnK45GmPxxQnA5OI7xgwospEDw=;
        b=cR7ORxE+sRyUPicdfbgbuBIUM4BV9CH41+28rimBTtcdvcZSoFYmjY4w2BGrNGIXXf
         XC8a/9ioApWjbqabDQiA6GX4ur6iuoJqkcbOkG8hl3GHsj4Q0jbmpKjdZ83tJpY9+LSN
         4YK70jLs2g2cFZIItS3MbtEMhb76yYv4aGbZ4rqreRssKGsHxboKSyAm9xYT/hVmF9Wi
         ZP1InE2ovAxnZxBOCvtDvo2YY1/rbGuWq1Hs7Vfdh6nGaoAeLFs4JjY8f5xKzGmsFqNK
         30WBeZSWZDd5aL6eFuV+Pp3ABnrajiXHO4tkBugSXO/dQShCxkLpOFtnmndh6Jj4Be1L
         RDPw==
X-Gm-Message-State: APjAAAVPRp9jVUZqWBnvg6g+jzbizJ1Ar9nxmYYMXqtInwkaMQYJuWc0
        jS+Y9+SU3bMqW8BwKQYY1Sc=
X-Google-Smtp-Source: APXvYqz03kf5+2JXqxXHcjbHbH1nNjYdCh1UAKKw6zmnOJY0X1BB27StP6W7TAacHFPpRdvym/1PLA==
X-Received: by 2002:a1c:1b10:: with SMTP id b16mr14847262wmb.90.1553593139791;
        Tue, 26 Mar 2019 02:38:59 -0700 (PDT)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id 132sm29989820wmd.30.2019.03.26.02.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 02:38:58 -0700 (PDT)
Date:   Tue, 26 Mar 2019 09:38:58 +0000
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-nvme@lists.infradead.org, Fam Zheng <fam@euphon.net>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, kvm@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang Cunming <cunming.liang@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        John Ferlan <jferlan@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Amnon Ilan <ailan@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/9] RFC: NVME VFIO mediated device [BENCHMARKS]
Message-ID: <20190326093858.GI21018@stefanha-x1.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <d41484848b1832192c6978c7054bec5c326afa6d.camel@redhat.com>
 <dbec1f2bee53ab786bb4f6204f9a930eac279970.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IbA9xpzOQlG26JSn"
Content-Disposition: inline
In-Reply-To: <dbec1f2bee53ab786bb4f6204f9a930eac279970.camel@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IbA9xpzOQlG26JSn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2019 at 08:52:32PM +0200, Maxim Levitsky wrote:
> Hi
>=20
> This is first round of benchmarks.
>=20
> The system is Intel(R) Xeon(R) Gold 6128 CPU @ 3.40GHz
>=20
> The system has 2 numa nodes, but only cpus and memory from node 0 were us=
ed to
> avoid noise from numa.
>=20
> The SSD is Intel=C2=AE Optane=E2=84=A2 SSD 900P Series, 280 GB version
>=20
>=20
> https://ark.intel.com/content/www/us/en/ark/products/123628/intel-optane-=
ssd-900p-series-280gb-1-2-height-pcie-x4-20nm-3d-xpoint.html
>=20
>=20
> ** Latency benchmark with no interrupts at all **
>=20
> spdk was complited with fio plugin in the host and in the guest.
> spdk was first run in the host
> then vm was started with one of spdk,pci passthrough, mdev and inside the
> vm spdk was run with fio plugin.
>=20
> spdk was taken from my branch on gitlab, and fio was complied from source=
 for
> 3.4 branch as needed by the spdk fio plugin.
>=20
> The following spdk command line was used:
>=20
> $WORK/fio/fio \
> 	--name=3Djob --runtime=3D40 --ramp_time=3D0 --time_based \
> 	 --filename=3D"trtype=3DPCIe traddr=3D$DEVICE_FOR_FIO ns=3D1" --ioengine=
=3Dspdk  \
> 	--direct=3D1 --rw=3Drandread --bs=3D4K --cpus_allowed=3D0 \
> 	--iodepth=3D1 --thread
>=20
> The average values for slat (submission latency), clat (completion latenc=
y) and
> its sum (slat+clat) were noted.
>=20
> The results:
>=20
> spdk fio host:=20
> 	573 Mib/s - slat 112.00ns, clat 6.400us, lat 6.52ms
> 	573 Mib/s - slat 111.50ns, clat 6.406us, lat 6.52ms
>=20
>=20
> pci passthough host/
> spdk fio guest
> 	571 Mib/s - slat 124.56ns, clat 6.422us  lat 6.55ms
> 	571 Mib/s - slat 122.86ns, clat 6.410us  lat 6.53ms
> 	570 Mib/s - slat 124.95ns, clat 6.425us  lat 6.55ms
>=20
> spdk host/
> spdk fio guest:
> 	535 Mib/s - slat 125.00ns, clat 6.895us  lat 7.02ms
> 	534 Mib/s - slat 125.36ns, clat 6.896us  lat 7.02ms
> 	534 Mib/s - slat 125.82ns, clat 6.892us  lat 7.02ms
>=20
> mdev host/
> spdk fio guest:
> 	534 Mib/s - slat 128.04ns, clat 6.902us  lat 7.03ms
> 	535 Mib/s - slat 126.97ns, clat 6.900us  lat 7.03ms
> 	535 Mib/s - slat 127.00ns, clat 6.898us  lat 7.03ms
>=20
>=20
> As you see, native latency is 6.52ms, pci passthrough barely adds any lat=
ency,
> while both mdev/spdk added about (7.03/2 - 6.52) - 0.51ms/0.50ms of laten=
cy.

Milliseconds is surprising.  The SSD's spec says 10us read/write
latency.  Did you mean microseconds?

>=20
> In addtion to that I added few 'rdtsc' into my mdev driver to strategical=
ly
> capture the cycle count it takes it to do 3 things:
>=20
> 1. translate a just received command (till it is copied to the hardware
> submission queue)
>=20
> 2. receive a completion (divided by the number of completion received in =
one
> round of polling)
>=20
> 3. deliver an interupt to the guest (call to eventfd_signal)
>=20
> This is not the whole latency as there is also a latency between the poin=
t the
> submission entry is written and till it is visible on the polling cpu, pl=
us
> latency till polling cpu gets to the code which reads the submission entr=
y,
> and of course latency of interrupt delivery, but the above measurements m=
ostly
> capture the latency I can control.
>=20
> The results are:
>=20
> commands translated : avg cycles: 459.844     avg time(usec): 0.135      =
 =20
> commands completed  : avg cycles: 354.61      avg time(usec): 0.104      =
 =20
> interrupts sent     : avg cycles: 590.227     avg time(usec): 0.174
>=20
> avg time total: 0.413 usec
>=20
> All measurmenets done in the host kernel. the time calculated using tsc_k=
hz
> kernel variable.
>=20
> The biggest take from this is that both spdk and my driver are very fast =
and
> overhead is just a  thousand of cpu cycles give it or take.

Nice!

Stefan

--IbA9xpzOQlG26JSn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcmfMyAAoJEJykq7OBq3PIT0MIAJYLZBHOV0P0U3MIboeVwzch
qNEL1zQEm00Y8d1t7MtdTmY7F/6YXZ03yDsfFFdfqbHHAMMJPja9f/nS+gyUfUO6
kKNzXuX6XQy9B+U62mMOQcOLcNQ5cXF0j8/SauJOWC8vle1f4UAi6CBDdCKj58Hi
8Moouk9TRHryTOEdoupLL7aWCzxAo7yic9VLw5+5uaGpnrc/oxOq94jWzQKjRZzv
61KyFMSWopG9AOd2fCEWDTmGKORlGKqSQDnB2vrwkflQxrBrsF+ZNN7f1sOXrvb6
iwa44IC1Tp9hSvxYZJ441uQPVAUOv71rNsVsYADl5mcGxr5sr5NxaGq38U2tQG8=
=C0a6
-----END PGP SIGNATURE-----

--IbA9xpzOQlG26JSn--
