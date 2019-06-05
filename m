Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D8AC28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57137206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTqSOkNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfFEMie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:38:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44452 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfFEMie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:38:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id w13so19258363wru.11;
        Wed, 05 Jun 2019 05:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9D3ypK1jNrXXP78FSrpag9w6FVvOQQOTO7rf8vLaKZQ=;
        b=gTqSOkNp4dWI7DqqFRrpWC0i5v2Gsy+Bl6n+EozDsdNt8/41QJZmmd+4iw6MWwirJv
         My/yy4mUBoPTQLWoJGXGjkG77wsHm68yfuYLLzm4gn199uQDW9u9exj7n7w19MZ5kqkf
         R2pjc5+NFDsra/OgEJoXshprvNwT/aZSGpz+b5TW76+Oa+OwgtxbDCHc77ngf/J/RZo/
         bZsNM+G9pIDVfBLG1XP4wtyFyiMVORLenm0HqcCx5KvqwJpdy02+K99fODsaczHP/Z+L
         d2N5taX9IITkXLqcG7atrefjshw6t285WG8BaKsDLzMOir/ZDMr5W2WcE6zz4kQdhxVh
         rRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9D3ypK1jNrXXP78FSrpag9w6FVvOQQOTO7rf8vLaKZQ=;
        b=g+TDnqSiNIkeNS+BjoKqS474Cl54PE/4840yspVTp5cn5OOuDlKSD4KngF+N1i8Y4k
         st4FVSkVIhK3B3bDGbBGzD80nb88S533D6no4oez4nIl/1g+33Go/pQjoLD1dDCSGQuL
         kEkYjMI2Fzt3PFsbiLKP+aXU60S+XViFK2T5JiFxQEGzFhXiVciMYFuz1okeZj+TzFqw
         ABMl6SwkR0dcMLEBHKv1raqguDdQdBTSqnoU7MwiZreb5aW2deMfw7LOoDaNdKgyByVy
         LUprwpEz+ktFBRPTZprm8DNGvozyV5Y2JCFl5A706fb+nIhZHcu5lL7VBrm6YjUm/Ye1
         qXog==
X-Gm-Message-State: APjAAAUkxYDl4hMPIg3JfVXLrspjBvmj8Z5jIe174tET+2NGQD9LniS0
        tgqlfdbXdmUI4SsvdvJOVOE=
X-Google-Smtp-Source: APXvYqxgJTzolF4uDBpvTA6U4fB8aq1pFFlSHSXVQXdpRB68LM4KZN8GHIpY7vqmfOowjQNpd7hICg==
X-Received: by 2002:adf:fe4e:: with SMTP id m14mr961373wrs.21.1559738312046;
        Wed, 05 Jun 2019 05:38:32 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id f21sm19701243wmb.2.2019.06.05.05.38.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 05:38:31 -0700 (PDT)
Date:   Wed, 5 Jun 2019 14:38:30 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH] clk: tegra210: Fix default rates for HDA clocks
Message-ID: <20190605123830.GA1012@ulmo>
References: <1559121501-8566-1-git-send-email-jonathanh@nvidia.com>
 <20190529134625.GD17223@ulmo>
 <5f2b8f8d-f3e5-fab8-8cf0-fa8a3e917845@nvidia.com>
 <f2757c84-363c-cef0-db9d-c4e4423200b5@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <f2757c84-363c-cef0-db9d-c4e4423200b5@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2019 at 12:30:31PM +0100, Jon Hunter wrote:
>=20
> On 31/05/2019 15:58, Jon Hunter wrote:
> >=20
> > On 29/05/2019 14:46, Thierry Reding wrote:
> >> On Wed, May 29, 2019 at 10:18:21AM +0100, Jon Hunter wrote:
> >>> Currently the default clock rates for the HDA and HDA2CODEC_2X clocks
> >>> are both 19.2MHz. However, the default rates for these clocks should
> >>> actually be 51MHz and 48MHz, respectively. Correct the default clock
> >>> rates for these clocks by specifying them in the clock init table for
> >>> Tegra210.
> >>>
> >>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> >>> ---
> >>>  drivers/clk/tegra/clk-tegra210.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>
> >> Does this fix anything? Should this be backported to stable releases?
> >=20
> > Good point. We are aligning the clock configuration with what we ship.
> > So I thought for completeness it would be good to test HDA playback
> > across the various sample-rates we support (32kHz to 192kHz) but with or
> > without this patch I am not hearing anything. Let me check on this with
> > Sameer as I would like to see if we need to mark this for stable or not.
> >=20
> >> Acked-by: Thierry Reding <treding@nvidia.com>
>=20
> I have confirmed that this does fix HDA playback on Tegra210. Without
> this fix, I am seeing the following messages during playback and
> playback is distorted ...
>=20
> Write error: -32,Broken pipe
> [   15.069335] tegra-mc 70019000.memory-controller: hdar: read
> @0x0000000000000000: EMEM address decode error (EMEM decode error)
> Write error: -32,Broken pipe
> [   15.465362] tegra-mc 70019000.memory-controller: hdar: read
> @0x0000000000000000: EMEM address decode error (EMEM decode error)
> Write error: -32,Broken pipe
> [   15.858615] tegra-mc 70019000.memory-controller: hdar: read
> @0x0000000000000000: EMEM address decode error (EMEM decode error)
> W
>=20
> Do you want me to update the change and resend?

Honestly I'm not sure if it's worth it. I haven't seen any bug reports
for this and we haven't had audio over HDMI support for very long, so a
backport may not be necessary.

I guess there'd be some use to backport this so that our stable kernel
testing passes these. So it's really up to you. I have a slight tendency
towards backporting, because it's really tiny and then we just have it
out of the way and it's not going to haunt us.

Thierry

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz3t8YACgkQ3SOs138+
s6HDVw//fVw0ZwJVA8M4iHuRpPgj6iIfoP9raM5gEG0eUfa6FEr3iDtfOIW+rB7G
GQqEtIR/l6GaPKrRWQX/0AwTOKb3uIoVxACSye7jh/M4o8A4ml8faPvQGpx97Oe3
3hq6aEaU3lwTCOv4hJy3QWXAYqNJAyEFv9puOm0iiNuTODVNHO4dlAg8SYZQMzG+
FqBPH08pEZaQ0sRktNX00wcWrrLPEnRJwHZr0yWfnajdeWJAhNtrU5d5vD5ffUsn
sdu5PnEOxZdpuzqPFdwZDYAmj5i+D7cw1aLF9vN+Vzuju4dxtVgb+0uWSD4osmyy
l8TDbLrVNx2IRqMe6EaMl8tg5ZCubNtVbA/cuo+XdBGjNBzXQVTPK/sni/Tt/g3K
+gl5cyOcCdGDjNyER6Ve2g1hmnBld4mkKrH1A20IDlIhO1WTa3Eej0eWpfJzpIvR
nS0Zds+7tNDsjDlSjlBFSxmgzUtmhtQdJ7M4ymdXZNt5BVcQGBK4fteewDYZgf2T
23+LpkKudJxWPVTLc60Bzu+EYUOOyrdOMoITAKWmzw5k0ZaLwSpmgcrvPi+xGrgk
THaYxb8LgJENFvOZQF7MFepAGRfaeknYptfUKV2Qw/+Rrjjyg2ZqIbT86bBq5obj
izICkwk+/IWwz0efRc0kMYu6+S9Tpfr5rewS7hB2uzg+EM8AMqQ=
=AXlW
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
