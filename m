Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A43C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8998C2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RitidenU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfFNPwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:52:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36214 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfFNPwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:52:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id u8so2821723wmm.1;
        Fri, 14 Jun 2019 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yc0M3nTKwaQlaSGBH4dokXAfrG6fhV88i/j5CNPCL2U=;
        b=RitidenUYWXN5BPG4W5mLQ3l7BKQQkPW1IntaH57/2ydMS0RLx+5mAWajHqgjri7RO
         wy06TNxc6gvzcISt9DCap0ncGktmnxT2fblUVfT17FwUJdiR6p4un0vhdU0X8v9OwH1c
         ZQrxHIyw/JvhrcwHPRE/rJ79eO6D8qNLYS0hK3I9eybaCyVACU4yPfNP754K60C+l6aP
         vsoH3w1MQ3h5c43DiYJLydpUB/FDI4lJhih1G1TM8ekfvOW6T1dTPLwqu7Ls90kLdSkz
         z9iIEItPfEN5D+V58alFP5o/fCDiTrKWwfttdYEzKMnF6CiL9hL+c/S6weKYzdFxRKWl
         n01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yc0M3nTKwaQlaSGBH4dokXAfrG6fhV88i/j5CNPCL2U=;
        b=lYyBS02wqEZYRzhPS6vpif447S9O2atM9w92IH4b5GIIHZ1S/gPWjeuElEwpcAqq9L
         sPDgBdCcwtu1kUl3oZIZZiAKR5c93VY8vnwk8/kyDk8YA4fKfHFV9RrmVFq8l/cwg5jQ
         GZPZbgjS/xn6MJ32h9+idEe7B2MjORmJvnc6Fo6UOK537aii5/2qxqtg3pF8mbTv7QBl
         AHNsBnpnPcGzGbMzhDJxz2IZsFms1MnqMPOWy/EE0Yo1aWghsfC0xKZ8FlUZzM+afuSx
         Slp9CbFMRYSKKCy8fca1kpKb6lyU3JbAX2bKmNAlG9wTRdEps6CwbSTD4YuC49bWzJPv
         AR6w==
X-Gm-Message-State: APjAAAXpRHtVpu6rsJVJEDfeX9vrlnhBFAtngmDZNw4IYGZuUf+krv+y
        +XJ9OJhjMn1Rk/GJh8StXbOWz17A
X-Google-Smtp-Source: APXvYqzeZJjkz+lMDsPARX2Q8/EDKIU/+YPWJ7ukkoAa0gc2g15xCr+I6BndMujpgwpmJT2z6hTvAg==
X-Received: by 2002:a1c:c583:: with SMTP id v125mr8202325wmf.158.1560527531895;
        Fri, 14 Jun 2019 08:52:11 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id o8sm4389269wrj.71.2019.06.14.08.52.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 08:52:11 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:52:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bitan Biswas <bbiswas@nvidia.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH V1 2/2] mailbox: tegra: avoid resume NULL mailboxes
Message-ID: <20190614155210.GC26922@ulmo>
References: <1560515734-2085-1-git-send-email-bbiswas@nvidia.com>
 <1560515734-2085-2-git-send-email-bbiswas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
In-Reply-To: <1560515734-2085-2-git-send-email-bbiswas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2019 at 05:35:34AM -0700, Bitan Biswas wrote:
> If Tegra hsp device tree does not have 'shared irqs',

s/hsp/HSP/, otherwise looks good.

Thierry

> mailboxes pointer is NULL. Add non-NULL HSP mailboxes
> check in resume callback before tegra_hsp_mailbox_startup()
> call and prevent NULL pointer exception.
>=20
> Signed-off-by: Bitan Biswas <bbiswas@nvidia.com>
> ---
>  drivers/mailbox/tegra-hsp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> index f147374..a11fb1c 100644
> --- a/drivers/mailbox/tegra-hsp.c
> +++ b/drivers/mailbox/tegra-hsp.c
> @@ -782,11 +782,13 @@ static int __maybe_unused tegra_hsp_noirq_resume(st=
ruct device *dev)
>  			tegra_hsp_doorbell_startup(db->channel.chan);
>  	}
> =20
> -	for (i =3D 0; i < hsp->num_sm; i++) {
> -		struct tegra_hsp_mailbox *mb =3D &hsp->mailboxes[i];
> +	if (hsp->mailboxes) {
> +		for (i =3D 0; i < hsp->num_sm; i++) {
> +			struct tegra_hsp_mailbox *mb =3D &hsp->mailboxes[i];
> =20
> -		if (mb->channel.chan->cl)
> -			tegra_hsp_mailbox_startup(mb->channel.chan);
> +			if (mb->channel.chan->cl)
> +				tegra_hsp_mailbox_startup(mb->channel.chan);
> +		}
>  	}
> =20
>  	return 0;
> --=20
> 2.7.4
>=20

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0DwqoACgkQ3SOs138+
s6HJehAAlPsKTuPsEIq3BYzsUwtxA2ZtjCFy0N/+cOom6PoIlmFZQ3ZqVVYmVGUt
6sP7L8VoUzcgP1LXassF3wiTLv7/Il+hWM9SxHN5k8a1UBEnij4vxtt13/vIirLh
FfeV5AyZZ7FmgsyGm/ZM41evcYZg/WM6JKXaHGMjbxMhxXk2sQxH98WY2urTSxoz
rb2+MRrTQu5jrbUiF//cjSrULA6tcldY567nFyFPTRTu8e+jtqGna1lMDIrNHw5q
n3SR3Z5sOobv5R5qcp4SBBrHLRMPaiIPiGrLnUccLDsxrjYzeII51Ij2ib5y4osZ
BfALmCAAy06DoJWoeTLH706nEv0hIeXTYTQSgWgY2Jqzt68beW0pOc59KFjcn/fr
4yK51+AqGwwYNfnlVSp1WdJD4eXdahHzBWFpBzr9koHpsYUeTnUfMNfrZRHsOPJb
9gWbFUmUj7O7QzTdB5coMcmhSi9bpGd9B5/9Lrk7S/fKRUQfI6YhjHRhaZTG3R80
7Yg5p133EU334sl3K6i91ekysja57vJDlQngieJzGWRZRItjMOSI+l2PxsGXD4Z+
KTXVl57gbB6Zl5W44CWfAo0N/+UblHIfLn81x6hmAuD5G3ewHVj0CcG0ccyn2Cem
H1NjV3NH0goy6jG2v/XfL88I38u2Hm9ZG03yK80lJekkZ+nS5OY=
=ErAC
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
