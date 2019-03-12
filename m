Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6C7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209AE20883
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kReBCLq3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCLL26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:28:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34047 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfCLL26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:28:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id f14so2309871wrg.1;
        Tue, 12 Mar 2019 04:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qt722YEGjhtdvVDbiMDeKW1mbVWB+mHwXdLbZbaUcNc=;
        b=kReBCLq34rO7KZQvqa4KMn8XHBQgTkzwaWpLhrYYXc1bwfuaS1Q0SxU0kfkWIzh+Ay
         p7I87Bo6cUaOV5ZF1Q5OwY4ZHlDg4n+hb13790iRtzt1DgnKlozuAuTpk+ZkXS12yJNj
         gNt/yCt+w9K7ghGTeNFiOpImgjuV8Xu2fQ5agr2UqG8Y3ka/z6DxEmNK7w+FOQ09RemR
         wibN56SKX8F4MMLJxbLJX/pNyHHWhpEB0Bv1uVDWVJSAUIUhZEFvfTv9NoNdncfuOC1I
         waVJAQJxXdp0QYQT4GjGyHWHy8EM/gxnzyNzQA3pMLzmIApgrNGq/0WZCD1GoYm3AIeD
         xBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qt722YEGjhtdvVDbiMDeKW1mbVWB+mHwXdLbZbaUcNc=;
        b=WJuaEFOaWhG96Eaqj+orl/DqRRkpf1tUlMu5eoC56yAU7UFA/Ssxl9RAGR0LEg2N8L
         MWtrxFHqjusXNCvrnUB7x0MQrx2nEFpeeWVkdlOM03ZjFOtAr1pmmyazetjApHqL0EqE
         rwHf6J5Y7fMIlMKS4e/c55I7hKuNuzqkMMAP5HMUtKn/d/u6xM1t/Y3UJ2xg5iJwIka/
         uOsRbCo9Jew+r0u47XoAK7fUvhJUCzHgsLRjYzvTbpzoIGqvQeXItNJt7kUypo/Vm+uq
         zYotViHpJdaIcKzXVMutgNAMY5cYtHHumN9ZKABNj03cPpvRlpwUqCIndoEEghoToyR2
         TJOA==
X-Gm-Message-State: APjAAAV0K0Fumh69ya+A6oo5wK30mCcVTKCutvE5bjh/mcVA/p30d8Lm
        UfGNP2Eio+zg4HQzyeChij0=
X-Google-Smtp-Source: APXvYqyMJDiSiO2bLbQztuKhMD7BYudHhDLEIP1SDheddhWU8L7xNH8xbTSnpJ/9E8L+FR7RnitCUw==
X-Received: by 2002:adf:ec10:: with SMTP id x16mr1377385wrn.171.1552390135702;
        Tue, 12 Mar 2019 04:28:55 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id f13sm3004406wme.4.2019.03.12.04.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 04:28:54 -0700 (PDT)
Date:   Tue, 12 Mar 2019 12:28:53 +0100
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
Subject: Re: [PATCH 26/42] drivers: gpio: rcar: pendantic formatting
Message-ID: <20190312112853.GE31026@ulmo>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-26-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Content-Disposition: inline
In-Reply-To: <1552330521-4276-26-git-send-email-info@metux.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 11, 2019 at 07:55:05PM +0100, Enrico Weigelt, metux IT consult wrote:
> a tab sneaked in, where it shouldn't be.

Pedantic nitpick: "pendantic" -> "pedantic" in the subject, and start
the commit message with a capital letter: "A tab sneaked in [...]".

Thierry

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHl/UACgkQ3SOs138+
s6FaaQ//R/zJZEcZz4RFijMRr+lK0HCGBtzl1v8G6lF445YjR06fA8hKV3G9sWII
iimdkYTtiM2zOn8TVPVmsvLzh7cwr7k3fC5hEamapg8wwwU8PkZHoDKw47vOwmEQ
4AmTJetBVkna6xa45NKCwoEEK83n77lF2Ym+Oc2gSVadZttifUqGlfFp9jIAjABC
LfU0phamxgE+P3Fwn0ohD5oeYpRSj6PQMkC1sdqyeeORH59mS94ckPuJp4vXUX+A
H7lE+cRluO6nfGH48ZHDnAwpPnnHok5tO2Oq+PtITNdyDNy78lMxQ5XVQ8YYsL1e
wjWt5DZUGKH10cGBQvqFsPRuX4QW7yWBmTRmX2OFRrruB48Qr6uylJNb6cvHGM33
80lb6f2Ur8E3ic6hv+ndXtmjlkWmq4VAKbLyEvLmaTx/RlfmpYviaerUQxrnunEQ
adWAkAWQfxT6U5dbnfuJLxKDy4UYdKGWM+1ehAQYw+l3UtQdxwyRCPpkdwTGX2+M
I2RklfTwUVDFPUOsNpavC8K/cMBYBUSbZ1vMx0t20Mex8exLmfr4FqIGBY2uuOE9
9M4//ql7G7ZFsGpMiPf+fKRWsaZ4Xk+tjtP/+fWLOdeyS9u4mbS3FNheVLDH+7bP
ox7s3sFk8SzIGEdmUt/XawU/Zril0Mvw2DB498D8fVdX/cNvCQM=
=ESSN
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
