Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD84C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C5C218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfCPS7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 14:59:00 -0400
Received: from anholt.net ([50.246.234.109]:40210 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfCPS67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 14:58:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 12CB810A2E99;
        Sat, 16 Mar 2019 11:58:59 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id h-yFMTECmIol; Sat, 16 Mar 2019 11:58:57 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id BBA4F10A277E;
        Sat, 16 Mar 2019 11:58:57 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 56C062FE4653; Sat, 16 Mar 2019 11:58:57 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH 3/3] drm/vc4: Don't liberate the binner BO at runtime suspend
In-Reply-To: <20190315162538.4120-3-paul.kocialkowski@bootlin.com>
References: <20190315162538.4120-1-paul.kocialkowski@bootlin.com> <20190315162538.4120-3-paul.kocialkowski@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Sat, 16 Mar 2019 11:58:55 -0700
Message-ID: <87o96alk7k.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> The binner BO is a pre-requisite to GPU operations, so we must ensure
> that it is always allocated when the GPU is in use.
>
> Because the buffer is allocated from the same pool as other GPU buffers,
> we might run into a situation where we are out of memory at runtime
> resume. This causes the binner BO allocation to fail and results in all
> subsequent operations to fail, resulting in a major hang in userspace.
>
> Now that we allocate the buffer at firstopen and liberate it at
> lastclose, we can just keep it alive during runtime suspend.

I think this needs to be squashed into the previous patch, as otherwise
coming from suspended, a firstopen -> resume -> render will leak a copy
of the bin BO.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyNR28ACgkQtdYpNtH8
nujZCA/+JhiOcpBD5A0ORtq9Csa+MUsoE3qDMT1X7Dc++FSgtskzj+21EXTEd3kb
xLyp8jr7D3xwFsIVi/S8+TXxd6flWepXc9gb5Hjp4ARV1AP2QfzeL3CyhMxSsuWQ
92GsbL79jhQc6v9YoGFtrfRCSAP+fELA7HWvwJFAWVHTRoQB6pb6x5raZ9O5Ho1F
8A/UyF+YCNZh6X2U12kt54MiymBi4JG283sqCfmSpNF3u5IJcvho9H0ldyKP+znH
7010amQfuMMET4OcS53fDez5OnleWNBUvHuoipKyzItg24PpHHGMnsLW+vyT9n8I
NBMIPwreCI8deYVdwrpPLtl9YNA3vPGgd8uZ3Jx6EBVnnR56cjD/2VUpFrgAxG2l
a7CmBp3K3hZf5eIs3DkTN66MUugcs1Krv3rL33KvBBcXkT55acamuKiidv9M20Wn
lhbgR6URxSC0pX3+cE2UGRfzVdWmvbRIUUIzxn3CVJbpjboXQsgyrNdRHZTGlJzE
LCW9XA6SzP8QbXGqy2Dgqx/OwgT6Pfh3bucDVq5xGs32qBPOQiCcR8Csh9QE0sCK
cNAX95GMh5RAmrJMPUGKyLQScQojo5mzB6JkFmlgv2+MeArWvOFCAwrTd22VkIfL
90hSKJww8SACxmN6wh4r7d369fyuNyBAAs+e8jVnAo/hPBZl8cM=
=sVM+
-----END PGP SIGNATURE-----
--=-=-=--
