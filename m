Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D25C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C2D21479
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391283AbfIIQ4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 12:56:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfIIQ4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:56:38 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 076BD81F0C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2019 16:56:38 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id j3so7637683wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 09:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=b+DYBvL0oEEFzvAdvWpG5+5SFlJp7gZgu0SZ3ZeObvI=;
        b=IEzpI3TofFvWjw7U1aF0A3twLIUBuO3LToNPtdw9RIcdobOYwXuukLTSQNziE1w5OB
         p2SQthr6ZUTGFPFuIJxM4q3G1kRGybL1n3cMATvssdeZzVkghvIMjARV2SGT3VXsKqpv
         TKknbfxLDRJGw76M/U35Xa24curp0H8ErFx0+0y2Lay4yQUrQZGKcH9Mq8FWnRGfJlCS
         CRKeodwkvjsRZwAGpqLBpPJ9rxQRRTNwgX52pUdkO3FRazTBHtZxGQ4VeHCbb21YQnI1
         T7frFT7sAZHCpEtmEDSfAEIx4DQbazkajM4ZRtSv4mNqMqSvqWAHAyeymrDQWyfjIjXb
         irEw==
X-Gm-Message-State: APjAAAWaU/9or5jZuRfx/G1iQUwugLWlgsyYaPOprErY6X2YawZ89ctX
        d/gp8F1xBt+egE46PU37pm1CVZOEKVwUq5RV6BENoFyEAQc68mNqAc3tdvjo44fpKYLELa57ZnW
        mattyrl+hzuHsQtQDR3eq+UQ3
X-Received: by 2002:adf:e342:: with SMTP id n2mr2723309wrj.341.1568048196573;
        Mon, 09 Sep 2019 09:56:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwCDEHfmFTtFBYf4wpg2xKJ2cjZDTuhPEW8XcTtrVh3SrWj7ioRNCGl/I1N77Z+ytfjL6XmFA==
X-Received: by 2002:adf:e342:: with SMTP id n2mr2723289wrj.341.1568048196307;
        Mon, 09 Sep 2019 09:56:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4580:a289:2f55:eec1? ([2001:b07:6468:f312:4580:a289:2f55:eec1])
        by smtp.gmail.com with ESMTPSA id q15sm18613985wrg.65.2019.09.09.09.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 09:56:35 -0700 (PDT)
Subject: Re: [PATCH v2] scsi: virtio_scsi: unplug LUNs when events missed
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Matt Lupfer <mlupfer@ddn.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190905181903.29756-1-mlupfer@ddn.com>
 <20190906085409.GC5900@stefanha-x1.localdomain>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <45d4fc47-cfc2-b7ae-e147-fb993a77e9e5@redhat.com>
Date:   Mon, 9 Sep 2019 18:55:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906085409.GC5900@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pxnQuVbtWYEwmX3SJy3OhOXnAXOYEWRNZ"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pxnQuVbtWYEwmX3SJy3OhOXnAXOYEWRNZ
Content-Type: multipart/mixed; boundary="KlMsZ2txnG2HaPm51dmD2esB01PSzQkME";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Matt Lupfer <mlupfer@ddn.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <45d4fc47-cfc2-b7ae-e147-fb993a77e9e5@redhat.com>
Subject: Re: [PATCH v2] scsi: virtio_scsi: unplug LUNs when events missed
References: <20190905181903.29756-1-mlupfer@ddn.com>
 <20190906085409.GC5900@stefanha-x1.localdomain>
In-Reply-To: <20190906085409.GC5900@stefanha-x1.localdomain>

--KlMsZ2txnG2HaPm51dmD2esB01PSzQkME
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06/09/19 10:54, Stefan Hajnoczi wrote:
> On Thu, Sep 05, 2019 at 06:19:28PM +0000, Matt Lupfer wrote:
>> The event handler calls scsi_scan_host() when events are missed, which=

>> will hotplug new LUNs.  However, this function won't remove any
>> unplugged LUNs.  The result is that hotunplug doesn't work properly wh=
en
>> the number of unplugged LUNs exceeds the event queue size (currently 8=
).
>>
>> Scan existing LUNs when events are missed to check if they are still
>> present.  If not, remove them.
>>
>> Signed-off-by: Matt Lupfer <mlupfer@ddn.com>
>> ---
>>  drivers/scsi/virtio_scsi.c | 33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>=20
> Please include a changelog in future patch revisions.  For example:
>=20
>   Signed-off-by: ...
>   ---
>   v2:
>     * Replaced magic constants with sd.h constants [Michael]
>=20
> Just C and virtio code review, no SCSI specifics:
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


--KlMsZ2txnG2HaPm51dmD2esB01PSzQkME--

--pxnQuVbtWYEwmX3SJy3OhOXnAXOYEWRNZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl12hBQACgkQv/vSX3jH
roNf/QgAmxUxJG1dOWyJiM9cOE05ZHpVBvjYtllR4MHb7M3HkgznPc7bAe3ojMCh
MjjpnhamcSKKTKtx9cgDK1bh8uj8viucaOZ43r0/P+npJO8XsdwwAlzfx5WMQ/Al
qEaNVoX1KUxdWZAEYS1y52JmEvOf+0SlmaeJZMYQOWSJHepaM3d7l2vslFhZMIdt
y054MXFZiJxyEB/AE8R/Xy7LPe9/CHliHqxDBMVjLYRFuUeqtkgAXjKUVsThUsGt
EIKONYmN0aQ+Nl8bphUlxHhVVUgCTZ+YP/OCQqAOWtGKpINsFKBcvipeJeAVj3id
Z7Jdh+v01Bs92VJ3BdQHgIbvvRulCA==
=O1le
-----END PGP SIGNATURE-----

--pxnQuVbtWYEwmX3SJy3OhOXnAXOYEWRNZ--
