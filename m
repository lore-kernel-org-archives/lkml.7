Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7A8C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C66214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C03VUDuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfDWMTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:19:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40446 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWMTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:19:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so19927661wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 05:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1DC0f63RY62BxhULRxZEpyim5MsJ0VuP0LFii+VzJh8=;
        b=C03VUDuPXHvMcVnTuIYt8CjcBDH1CQjL+G8L/6objd1/X1DUPPrVPBeFAV6zgGVtUY
         p6TeZ6kolbOwCyYvP8hkpBPZlpC9u2fzc3z/hMi6kSSkDSenV7VxntObQQ1wY7Ao8Kgp
         3t6y94X02ufCtXaAEsCafDi+hmpMfwksPk6U4OoBori6kxP1ugcBs9CHdykohKPfE/I0
         MrUY3G3dmQYtosqpkfCQj2i8zRSN3r8EUqsdLAbdsU0Q7GDi38tUVbo0kAYdSoSnlD0e
         o3gNdZBygV8A1uqF9ggedqLo8+qHd4t4Wd5bhthz6yxaNmkRPn1Rc6ua9MhKnD7zScfW
         SoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1DC0f63RY62BxhULRxZEpyim5MsJ0VuP0LFii+VzJh8=;
        b=RkIFDVm9zgXLEkBmDQbGyjthvPB62/cizBJPV7gPerRCq34kHw8Na0MmBSRu82TqXe
         CaYpC6w7igKg3eUgzljONxFk30eZAzDBtyfVl0IvhIHx62ZXDHhlbEiuuJlyN96HSeOy
         UfCBgn3Vj1JQDyHBiJfGyzO9BVJ7oTushbfioqPdomqScPSnpSDS2bsy+l1I7yHABuGX
         s9SvYrRvsIBQ2zUYRHXkT+A1hLj4uN+K4uTjttZOqB+Tv9zT1veeArwX9vHgzmhG/8cz
         Jz1/o8YyF0imGOZ4vnvTvnjICMQnPaSr5eXvIuWmDmWwAvTfZdOMD7HASAzHkN8Kbo+R
         fr6w==
X-Gm-Message-State: APjAAAUddYipXEB/xWXexU62wx7Eke8u0gMMFx1C4UEMGMkrJfWihEEA
        cgwc0JkBLisSRt5GanBrLew=
X-Google-Smtp-Source: APXvYqzzVZKN/QJSP6NuK4LGElGkDEb9IGb6eCOyAntcpKpfikuOBCeEQf7gurDNnemCaANjKwdjow==
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr12357408wrs.15.1556021957467;
        Tue, 23 Apr 2019 05:19:17 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id b8sm9335141wrf.21.2019.04.23.05.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 05:19:16 -0700 (PDT)
Date:   Tue, 23 Apr 2019 14:19:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: Re: [PATCH] drm/panel: Remove duplicate header
Message-ID: <20190423121915.GK23448@ulmo>
References: <1555183750-11028-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SCOJXUq1iwCn05li"
Content-Disposition: inline
In-Reply-To: <1555183750-11028-1-git-send-email-jrdr.linux@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SCOJXUq1iwCn05li
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2019 at 12:59:10AM +0530, Souptick Joarder wrote:
> Remove duplicate header which is included twice.
>=20
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

Thierry

--SCOJXUq1iwCn05li
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly/AsMACgkQ3SOs138+
s6Hwwg/6AruIkKm1QPzWdYG1+zyelH9R5zApFpkXlzO1CbGQtVso2f0m6nKxP8Km
MB9QbyAGqAqvPgZEliLgjWIXpgSkNZQizJrdgnNwJ4jFP1ZmNHh59Xjl9yNEb11l
+5bOSv2cOGzvB678eUzLcVp2ofYNaPfZyFQGw0WvMEFBvJYIh85AWcqlAmny40Xz
dryjS3gJG+pmFVTEAFagmEaGqrmXUwtFdOybQO7CXTeGIjLdVmYXXtAuDFpN1keD
BZZ1Hc4ouWfBN3gogAqbPuUZJ0KJXBKAwi6cr3YQ2JzNHAIdhg4Y+MJQTq/hVlT7
XpN9PEg/CH20zsF65PquWLbb3niVRd/BGpf2NCHufiIaD14E21tNkskuK6B3NB4b
AFKoid7kQBFkj3TrFncQWM7OdcoNrhAINhClATBctcyYiL9YgaqVLNI9o+ve9eY1
L+/LO+DT2PNsnzEzsZQheGE61S/qq58DC2FphcugbQ2AjkzAPJIHFAQtwWsR1RNX
e9aGqmdcLF8nXeixO9t1c7m1BxhJn90zdMrfCoBjY/Nu03X3SqkXWfLz3baZ0hMu
A7XeyHdhmZFESvFBv8Y5qNj0JeGRooiPZ9spHAc/X4XGCmAK3wibq2rS14kc9Kkv
7FWWt4q/ue/ggyfat0hFU0jyg4ahYvt39gwwPZEJxUYaOtdDzmg=
=XMQA
-----END PGP SIGNATURE-----

--SCOJXUq1iwCn05li--
