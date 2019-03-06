Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06DDC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB132064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQrwl5Qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfCFIlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:41:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44108 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFIlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:41:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id w2so12365635wrt.11;
        Wed, 06 Mar 2019 00:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SFjuFKpJAnoV7JJnFxeH1by8qnn7Ju7o46cXicNmAH8=;
        b=HQrwl5QodI/FRznoMcdsEvHMsMMdwuQ//2RXltbLPgySHZDWLvbS/a8Bk8PFdxS2qK
         mdw+13kFtdWf56K7ltUCcKf3GSsQgsbxEYgdiONJGMdUIpJGSFh175zOdPuvTuBN2I1y
         9afhj+1s4RHd7ldJGsvt6m29HYcCG5/aGll0LAWojlD0Bh2kQkOwskp472du2YHkUdWq
         my//CB6e+MEVtr5KMnyIBk7VZuHu2cJ1MfHGu9MBp0ygYnNkBY8HRI+F8+JLrhi6vs+h
         6FVVV1d9aSJ0+GKS23zgL0O/eVyPsIzKP8rSSUUyH2H+CrRBL7RIc7CMCcHL3RlDu7Tq
         vf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SFjuFKpJAnoV7JJnFxeH1by8qnn7Ju7o46cXicNmAH8=;
        b=HjExoFOdkfdulT30pgC930SQ997CpnUjEqMkWmd+ZDf6+sVe2YYXt/PnL09EypouqP
         mwJgZb7mT+j+BPLQBizuMFHL9oVHwgl/9CTmlOyqknG4Jl9r+mIq0WMnlcxhbhZAzDkq
         N77d9gnbjsO5XxuoUjyZ/Pk/aeUGnHmbd1cIQ9TikMqwgrXtEG/Xs0hAViOj0eGNEMUj
         /tJctqN21yoLxq8uUCyQ7ap8/urtuv14NALcuIHdpLm2Yr+//hEo8StMUbfYPhKYuui3
         kBr9g84CgoinaPbeNtyAOWPHp9rK7a2OoM3cQSrirnmLxr8JaYcF4Jp8zTIKePS6lI5A
         RjGA==
X-Gm-Message-State: APjAAAXXmvrVOE2wMWiHtt9GYDt8SvLYyTU6UJ9DODFTfryPET6TM29+
        oJRDs5DblF97eKfatcVOD9DyNfIl7ic=
X-Google-Smtp-Source: APXvYqxC22DW068RIb9MFgUV+PRY/lrkAPygp9nzRmr/7aPEHvtjCLFYGDHI2aopnS8r4N1elcvjIw==
X-Received: by 2002:a5d:4903:: with SMTP id x3mr2068411wrq.151.1551861665957;
        Wed, 06 Mar 2019 00:41:05 -0800 (PST)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id v18sm1750713wrr.90.2019.03.06.00.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 00:41:05 -0800 (PST)
Date:   Wed, 6 Mar 2019 08:41:04 +0000
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: fix kernel panic from
 virtio_transport_reset_no_sock
Message-ID: <20190306084104.GA22159@stefanha-x1.localdomain>
References: <20190305180145.27161-1-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20190305180145.27161-1-alazar@bitdefender.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2019 at 08:01:45PM +0200, Adalbert Laz=C4=83r wrote:

Thanks for the patch, Adalbert!  Please add a Signed-off-by tag so your
patch can be merged (see Documentation/process/submitting-patches.rst
Chapter 11 for details on the Developer's Certificate of Origin).

>  static int virtio_transport_reset_no_sock(struct virtio_vsock_pkt *pkt)
>  {
> +	const struct virtio_transport *t;
>  	struct virtio_vsock_pkt_info info =3D {
>  		.op =3D VIRTIO_VSOCK_OP_RST,
>  		.type =3D le16_to_cpu(pkt->hdr.type),
> @@ -680,7 +681,11 @@ static int virtio_transport_reset_no_sock(struct vir=
tio_vsock_pkt *pkt)
>  	if (!pkt)
>  		return -ENOMEM;
> =20
> -	return virtio_transport_get_ops()->send_pkt(pkt);
> +	t =3D virtio_transport_get_ops();
> +	if (!t)
> +		return -ENOTCONN;

pkt is leaked here.  This is an easy mistake to make because the code is
unclear.  The pkt argument is the received packet that we must reply to.
The reply packet is allocated just before line 680 and must be free
explicitly for return -ENOTCONN.

You can avoid the leak and make the code easier to read like this:

  struct virtio_vsock_pkt *reply;

  ...

     ------ avoid reusing 'pkt'
    v
  reply =3D virtio_transport_alloc_pkt(&info, 0, ...);
  if (!reply)
      return -ENOMEM;

  t =3D virtio_transport_get_ops();
  if (!t) {
      virtio_transport_free_pkt(reply); <-- prevent memory leak
      return -ENOTCONN;
  }
  return t->send_pkt(reply);

Stefan

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcf4efAAoJEJykq7OBq3PIkjwIAMq2n+AiAjkQ7wqlpb1kDkHv
b+A8ugno/BLAsZXuNFMgSPmbh6JBJ1B5KEwKLJHOcNlgyYsfjvASDTaL+fb3sHsx
Hoxv/QITZrd5dEDIyuOZFyDcxqhhnweSg/R5ehRBxmM+/beluWKg9/sbCA4CcORZ
zw136cmFZr4NOTzsSPMDKCubtNNLNhKIv+mRAXKJDMAqys0jd6mQVCCbY8CeZH2F
cYZRwyQW7r0sZvS//OFEZtB+crBZz+TzjibD2K82sz4pPzviJkWl30CA4NDFdOT+
jeRb05o1DqalP5HOHuCCfwnSCcdL30TaLvKJv29uBsgX4MmqyQ5QFjBmUyx6cPI=
=SlL5
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
