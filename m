Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81114C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B2E21927
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSFpxI5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbfI3ORU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:17:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50874 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730923AbfI3ORT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:17:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id 5so13655252wmg.0;
        Mon, 30 Sep 2019 07:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fT3u0kO00B12KTl27/O+hzJQRozEYKlkkbEEU64XnhY=;
        b=YSFpxI5yHDLoYYeh10IlDZt/MaBfJO2AGUzyW6NvtaBWcTdhljHrHSJ/4KOYvr7CUl
         mzfgob7qcvwRYyzISn5K6ENc5t3CtU3eXIulQK6yGRS/8J46WGQSzTkhvdDeHk6z3Rpw
         e/u2ebHXEP+ilaWWQOo3b4VAQdRFr/QYKdv8QeCuFnxVtzr3Jxr6/fI55YIJmllSp1Ud
         7zmjdDZulBZgEiacObrEvaRMBDNOEOyftsQ8DNBlMv0FnJbLGCRPLJDAWz9DVlIvTXaj
         b3Mb5o0TrZaA7W6mQws5i1DuFMus8Ie72a2HbmRYPhpc1xc1BoItqPaqcxsWUcuX7oQn
         GOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fT3u0kO00B12KTl27/O+hzJQRozEYKlkkbEEU64XnhY=;
        b=Y9HUPtGI1r/7JWRmyWddbtX32s9mvdheaQA2wzOczTIv2nyLUuPEH5/2MW5VeamsAF
         app/t5n6CMm0qK5ew+58w6xJMHKyasTLgtYrBIGSu4EUfwzwmOtvT9SVqsFp9NnH5p5Y
         eCunmjdJz7JWRtwPE0sOpSSXMTzuZbwZGR4J/zJR3CulZJ1FJ4ZzdRmdgYOxT3w56OhL
         amjYQID8R41mfgXLkUXClL/G7E8duPc4N9dp+vKNH43m+DzZgK9bZo6/ZqPzwgLAEQzo
         u+ziowMTT5XJ0g6t/NRRG2YJ8QvuuKq8QpXh86AeFznWPpxwO5S8Gr0iJB03p7qmaNWG
         Kgkg==
X-Gm-Message-State: APjAAAWXzOuKZ0X6FyDr6rg4RFh9rpd5FBhvdjOKiXl5oBumnkckoXyG
        q1jV7mGCCI0ex6eHvSDLhOs=
X-Google-Smtp-Source: APXvYqyOpLv95qJQ+llcAqXMVTSBYBINojPzeN7jeK5bbXTojnJSfyJH4CM7gYJhBd4cwlv1x7DsKw==
X-Received: by 2002:a05:600c:110a:: with SMTP id b10mr16910581wma.18.1569853036041;
        Mon, 30 Sep 2019 07:17:16 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id n8sm27354090wma.7.2019.09.30.07.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 07:17:14 -0700 (PDT)
Date:   Mon, 30 Sep 2019 16:17:13 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [RESEND PATCH] ARM: dts: Add stmpe-adc DT node to Toradex T30
 modules
Message-ID: <20190930141713.GA1943656@ulmo>
References: <20190814105318.21902-1-philippe.schenker@toradex.com>
 <b40974742543a2e8450c097bf86c5c0d3baec977.camel@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <b40974742543a2e8450c097bf86c5c0d3baec977.camel@toradex.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2019 at 11:54:59AM +0000, Philippe Schenker wrote:
> On Wed, 2019-08-14 at 10:53 +0000, Philippe Schenker wrote:
> > Add the stmpe-adc DT node as found on Toradex T30 modules
> >=20
> > Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
>=20
> Hi Thierry, could you please pull this patch for 5.4? Or tell me what is
> holding it back from being pulled?

At this point I'm only waiting for the merge to close. Before that I
can't take any new patches.

Thierry

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2SDmYACgkQ3SOs138+
s6EOew/9EaFyL0YfHDuqjRoWXeAmsw0mcgPyEEz2xexpsdhl8h4YlyY+qGovRd4v
gh/Ep8/OsiI8xyD//tgXVkLHVkdtaQ3T2VxpiogcnemJ+g50z83nKZR02rQIAJGQ
h7ERw1WBAVUZEU/5/6nF6hRoDjpiI/K4VuP3HDiGZvWzAzY3/pr/xoP9Ho6UdYeD
hf0Y6zwKHYHsClNKGCzC6/X0itk9sDUl8GDzCpxwySRTn1pDhCxf3fMDuaytE+lS
HDvm8hGqxja5UAGhuypdFRZP8UEGJq6zxetwIyWl3ot13cDUdwRDuLlGaNcH1SOn
ItwsIqfhvyN5uFI1JSFxDXw+oG24MoWK3ObwytNyHXSJ8KAjAS3Ov7O4G9d79dhb
R7hwJ8ZA08Ur9NTmz0mThSBINhCMV3ENZKuZMIoWoiR4Zm4Az6bNbNgbjGc029Iu
45zbqQTzHpGMwcCQhvx2+SHTUzsgAzTudmZNTJltzWKzCCINEoOj+6L8+lHCAdXm
8VvCu1zGft4LmdP6xqA1CZ+l2MAJK8suaG9xVyZOfZx1f/2jemNGOid2AG3ck2lE
TAJuSP+gyz1Qk/N7kIl5qifmRMWNgtt28Won7fvAvz5gqRoFSPBZt3VAC0Ib/B11
IGvFvmgOMDxT9JGIGf/k3t1/aosY9XXt+O/boFYJFybYjoIugCE=
=JeIS
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
