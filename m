Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D296C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193872075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TffYgIlS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfCLLaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:30:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52285 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfCLLaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:30:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id f65so2241008wma.2;
        Tue, 12 Mar 2019 04:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+XcJvH542AD4bXehLJbV9mB4t5I10uxa2rKnBAMyGM8=;
        b=TffYgIlS8y4yA3LfMbRuqdfD9315J83Y/7tqgb1HBbRBOAK+m8AZnM/AabBvd9Wx35
         oSMdfFzScO3UhpFpxGjoYMB5aJ3+Tgaj4bVlIU794ZqG7S2z2SssjW2/uy/MUmuFDUAD
         bGEXvqNrbCQSDt91X54p4iCzII4rnPPW1GT01tkKsAZy6vjHfdwbBEryvAYXBe96piOf
         d0Fjv6687CuQxynEmkbfD0Vnaq6d59fdJSlW/RfJLjp9W902eSMMyvStywKogZ5+ziDo
         I3UOkkphqsdULMmERycStiDK2SzulittA03UBK3TQbxXFLD4URB+qu21iSyfN0DDhQNU
         wmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+XcJvH542AD4bXehLJbV9mB4t5I10uxa2rKnBAMyGM8=;
        b=tHqVAyur3so5PzDZ67IRxUN+wj3zYQKJpcOm1tEwsqmrWu6rZps59MzZkKQa0kR6sp
         Ep/mcE0Ns6FiQETCs9hO2T57t8cBaFeevB8r8LW6jWTyXQ84XBOrZrV7TCpplVHG1C59
         Y0l0SSKXMltBI8y7ctJvsWulmS3tOTgOetKo9wxo4pyKiRaZofuqTXRxzz1hxAuj/sbt
         jwBINBZHxnHAfFmcO2iYaWno7dkDbcW6tjMYyoQbfO9LJ7VKKxDkSGg8M7ihmVu4by4D
         Ks2LSBAHMqz+LCuRX0GeVyrD4juN4/Y3Nacx1swLdqzqt0aS6b6AK5RmfiFqF/HNUR4W
         aafA==
X-Gm-Message-State: APjAAAVxanzOpFpo3Svb/Xj+oC9xA+t/wbBCUrMMTNIeplbmEJnlk9nt
        V79ao26sJOna68hhxx9SK8s=
X-Google-Smtp-Source: APXvYqwfEb+0fl0GoX7XVKmGKH2mQq36SYnbRmhTidPc6rMQ2ZwcX5mwctIIm3AmGpT64/xQPm1PYg==
X-Received: by 2002:a1c:b40b:: with SMTP id d11mr2218472wmf.80.1552390206103;
        Tue, 12 Mar 2019 04:30:06 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id c21sm12508423wre.35.2019.03.12.04.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 04:30:05 -0700 (PDT)
Date:   Tue, 12 Mar 2019 12:30:04 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        hoan@os.amperecomputing.com, orsonzhai@gmail.com,
        baolin.wang@linaro.org, zhang.lyra@gmail.com,
        keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com,
        grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org,
        robert.jarzmik@free.fr, yamada.masahiro@socionext.com,
        jun.nie@linaro.org, shawnguo@kernel.org,
        linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 33/42] drivers: gpio: tegra: use
 devm_platform_ioremap_resource()
Message-ID: <20190312113004.GF31026@ulmo>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-33-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline
In-Reply-To: <1552330521-4276-33-git-send-email-info@metux.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 07:55:12PM +0100, Enrico Weigelt, metux IT consult =
wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>=20
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-tegra.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHmDwACgkQ3SOs138+
s6F7Qw/+Ig2XXOoqc2QD68SQdohFVyykTnyHy3+Un2OUtPW8/Qj/zr6kpRbpEtXF
yyVZ5vYXGJmaSYSYjPRGHdXwy7UDCtFoEdrP7vElVJgZRtWS9aeodcIqy+s39i86
DrCuskY+baZpX4HBHL0EWs+2JF4QBVL8wRPneCsIB5hQZnIevxBkCaxxhzVp6lXE
LSMRF45aDp01RrGT700sctdvC/MzL6wWPLcb1f9RtCQpdMFtEzv38MpsK6WH7TeX
ezjPiuPss2tmC4pf8wWQ3YDoJi1TjqFpfvbeUviezvwtGq0lW66j6jXpC6QwmcSb
7un7Yxsm9lInxRWxTA3+ZjPRnDF8Ln32uGr9UuzGYE49ImIRBrX+7LRMcosDEIlu
538Ggsf8UFsGfMITCvIOHCamOZFpNTdgLYHCBNt6UcL1IKAJJezoDL5QvU9Nipgt
p9+As3hfvqId1Z3UAu0LPmWcHWhdYr1og21X6pjQC3ynMZoWW2w9F8ceWBFpDf2h
ug2aWWqT8UgQw8dT4chcokFVWABRLhScukWtFg1jmLG1TkvZm/hs3YyyTrdb4yKX
gAHznvIqom40DPcA8oF5DjSH2n8OTQTvoQVroXeX5HF3BXkW39LuahWmuDWSJMmF
ZucmkgTcF9CC+wv/dbWzgGzBs6Ec8Zcvd3AIBvgjggsLlcOFJhA=
=Pzrs
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
