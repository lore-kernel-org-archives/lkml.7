Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025D0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B982075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/tjpzKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfCKRuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:50:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39077 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfCKRuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:50:04 -0400
Received: by mail-qt1-f195.google.com with SMTP id t28so2419391qte.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bO5BRP6AeToffh106i/NDvE7XLz7hxSlbZ8ruA4sP5k=;
        b=o/tjpzKPPXLKSucTYQlpi1wBlypmwDSvFJiWhSPjBJi2cE4WD43BHpkJB932PHrn37
         ADqU69p7STc6JiWADgPxpy9mZkOOw88qdYKS/xrtElP3rVe6kl15nbMhPdYKMrzBRMFn
         ypuM8e+JlFky8QDiBVhrNw/FU8V2z2pkMOFNnH4WkkgStRtLk4OnkTJSLQ7hvA4FN797
         MRSMc/HTTE8/fB03f4dUi1Ig0EmIPbG918grJR9AV2ZgOv7K8PCwJN1/QcQkl7+Y4dt5
         TBT2VGNNqByc1PwMZlO6Q0bbI909Oq+zRj7ktGlq4/fPTV0gkiP193Y01hffGL4PaXs2
         Nhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bO5BRP6AeToffh106i/NDvE7XLz7hxSlbZ8ruA4sP5k=;
        b=sd/p5+z4W+7iBnnk0CQeGk1XkYYoRM0ZeisORe4vzDrEEoesr1KKmbrMNomB/cZvPQ
         cHC2enr+xhJA4T81U6DOjB46QTDDyw5uE8/EwhYqeuO7lWAT2bKXUbaf2mqaJcpaCwWb
         yZRQJTWpj7Y0bSOdg7o2mE8BwPmgajLrHnD1o4Fcv8R8EHnNepTmR5KXg6X8xSsz1roF
         V4D0bQ2sk7NK6Cn3NVOqIucm3gUKgaYyJk3iAx/CmnbV/KiIHApId3kszcOEzrZrkt18
         I6lByZ9O4e82nUjYgQdLwNt7pSiq1CvDOd9ECyCVuRemPT8Q+VWIN9M2/sqB6wr6//iO
         WOPw==
X-Gm-Message-State: APjAAAV8z1oQ5K6LkgVfor9Fu0rvYbyLAZ1YIy/l61RhjxA8aMiZFNe4
        TCPIDD9JqaEvwuNW430pek0lVa1zeJ0=
X-Google-Smtp-Source: APXvYqyGri72eUMz1NGTYsqg2P1gNygD9ZukOeytvVlL94flFvtKdFkKz3Zf7FpLDtPicPZ6iZ1SbQ==
X-Received: by 2002:a0c:b5ce:: with SMTP id o14mr27113124qvf.107.1552326603174;
        Mon, 11 Mar 2019 10:50:03 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id s20sm3196209qth.56.2019.03.11.10.49.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Mar 2019 10:50:01 -0700 (PDT)
Date:   Mon, 11 Mar 2019 14:49:58 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bochs: Fix NULL dereference on atomic_disable helper
Message-ID: <20190311174958.xdw4lrvf6ydeplvc@smtp.gmail.com>
References: <20190310212150.xhhb4abzm7j3ain2@smtp.gmail.com>
 <20190311062200.4mtel3j5fjxtxrcf@sirius.home.kraxel.org>
 <20190311101159.t6mbzm5sdwuh5muc@smtp.gmail.com>
 <20190311130716.6hjqci43clic5lxx@sirius.home.kraxel.org>
 <20190311132358.GF2665@phenom.ffwll.local>
 <20190311133919.azyhtioxf23duf3g@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dzkdplsu5vlzb5xc"
Content-Disposition: inline
In-Reply-To: <20190311133919.azyhtioxf23duf3g@sirius.home.kraxel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dzkdplsu5vlzb5xc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03/11, Gerd Hoffmann wrote:
>   Hi,
>=20
> > > IIRC the drm code checks for the atomic_enable callback presence to
> > > figure whenever it should take the atomic or legacy code paths.
> >=20
> > It should check for drm_driver->mode_config.funcs.atomic_commit for tha=
t,
> > see drm_drv_uses_atomic_modeset(). Anything else should be a bug.
> >=20
> > Or do you mean the fallback to the old crtc helper prepare/commit
> > callbacks?
>=20
> Probably the later.  There was some reason why I've left in the empty
> bochs_crtc_atomic_enable() callback ...

Just for checking before I start to work in this patch:
The correct solution should be made atomic_enable and atomic_disable
optional, right? I should do it, and check if Bochs driver really needs
bochs_crtc_atomic_enable after my change, right?

> cheers,
>   Gerd
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech
Graduate Student
Department of Computer Science
University of S=E3o Paulo

--dzkdplsu5vlzb5xc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlyGn8YACgkQWJzP/com
vP+WBhAAr1M8k6aerbm1C1ux/iLe6mX3ju4QPdRP/uCgqw6pWgtTWeVCPCSOHVUe
q9VWmQ6GHV0+lAzN1EurEMi8M6ofPXgQS1GocEhw8lX9YeiUC/60LrgqhvrGVaJ2
qARnXUY6bAHCQeXebNjw6smlIFSAtTzVMYbuDnlvSZe21nW0Et1nubvEVj6JHWbW
cFu+VTJtHCb6ty+HJIeBBKbMK6hP1P6Vi1E6UrG4uKxhM9nb2omlpvNhFSMVWmcg
PSUvg6MkJxSmX3+9UU4sdDPV728k8M2aePlouOwqQE5IXudlSgZu9bOz8kpr5+GP
mD9Sd+3Wcr/8aZEWfLpHN6PdjffqwL55BHg3qE/XND+I1T8paRTIdwE0Rbig8LzN
Fw7hlbo7TD+/zvVscDI+mJcDhTD4cLf0IEq70OcCam+AjcGefTmrO/ygPAinKPBz
DrbsdYWtrtDYiWTPP7E8YWVBhOXeVDhk0vmcHxwsLznE0klk4j8bGauN6rZ88b2o
7Qoqsstnyi3G5aGtVR1u/NZmSkN17687zmCAu0SHfUwTKoCBSV1M6P8o54VbuL9p
IvUSNVOLDPzpg85jZRyy44Wy4kyFosGDTzuDcoPcu+j3JVWg7J/XtCfu+zP8yYza
PCgw1hrWzgdCwWTBtGYhRv5hY5hjBjoev2GvGKons0gUX8j0/68=
=hsIt
-----END PGP SIGNATURE-----

--dzkdplsu5vlzb5xc--
