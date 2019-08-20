Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41582C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA3B22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566302753;
	bh=LUjlSLdZePTyQ1iaXJb+k1nYWxzBNH5fmC49RY9u0Js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nWziHqwSW1cmVJ8BewUFCJDEEhGIwKSGpiaTZTdiywyS7UqiWw1PrGdYBtz8POaqU
	 oK8ksdxrmC307ChtmCfUcssq5rFjHQ8bvcVlUE5Gqym+D1a4wBbB4R3iwpXnTqBSuz
	 ymx03I7k7ykaW6y/G1NumRnK836asI7TFwykDBXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfHTMFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:05:52 -0400
Received: from mail-ed1-f99.google.com ([209.85.208.99]:39549 "EHLO
        mail-ed1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHTMFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:05:51 -0400
Received: by mail-ed1-f99.google.com with SMTP id g8so6032879edm.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 05:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eE6gZQF2ER9hZ6A9hgkSkDoNLmLgYWTJNw8Y60IMAz4=;
        b=AnneSP0GwCG7NjR56C2lvkwyst5Ero3n08ghd7TKe3kDhrH+61NnLew41EMz+zlyEj
         lfoJ+kwwh07xZFN6q8WipnLDeuXkFNjZhqUmU81MRp5gp1cmDMU3VjTqBJ6G3QhjgyKP
         lAvRCAG7RPyTiB8gZxg70oMg5zDQce4PplwrMfUhDVtSRiFF017eir7zihivgK/C1jUB
         +18YHAqc5XfHFIPaRcqHTQbiZMLLQ6xmXXcNLxRZG+7uZtW/cR5XF7GnTV/8KsNXyIPi
         XwfUYqzRQUttySz5miryJiCK8x+U1Zp5ylVd1XA9GJTmOxPMomRMRzcDheJGFjcmhKah
         Vq6g==
X-Gm-Message-State: APjAAAUwH/ONck+ZYXhSeLM5LW6vCUmqfg2iSWAzjsg3qQsTDwgeRB0H
        8p8/NGOPdF7ysU0xROoaBnGYdwTTLWNhzn8bu3z82kiosRLSBwu5JTOkJnO1VQ51NQ==
X-Google-Smtp-Source: APXvYqxUHm8nkJ6hG/35gl6LaLISAhEaymUX6Aha2ZOpAibGjBsVDnsokSZ84fJuax4F9OI9v4NdIcGzfzXX
X-Received: by 2002:a50:f4c3:: with SMTP id v3mr30525317edm.115.1566302749969;
        Tue, 20 Aug 2019 05:05:49 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id n20sm97522ejr.72.2019.08.20.05.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 05:05:49 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i02tZ-00020I-GQ; Tue, 20 Aug 2019 12:05:49 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id BCED5274314C; Tue, 20 Aug 2019 13:05:47 +0100 (BST)
Date:   Tue, 20 Aug 2019 13:05:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: Fix the number of CS lines documented
 as an example
Message-ID: <20190820120547.GA4738@sirena.co.uk>
References: <20190820115000.32041-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20190820115000.32041-1-manivannan.sadhasivam@linaro.org>
X-Cookie: It's the thought, if any, that counts!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2019 at 05:20:00PM +0530, Manivannan Sadhasivam wrote:
> The number of CS lines is mentioned as 2 in the spi-controller binding
> but however in the example, 4 cs-gpios are used. Hence fix that to
> mention 4.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1b4hgACgkQJNaLcl1U
h9CaTAf+NDDtCxFNPDyqiudCbpGsmAOBaem3UqwpTZRbK9vy7b0ePoD9WJKWG+2O
1VxpcQp243Ardj1r8k9gZPYeWpolHmFen00GoakMDJiP7HLfjUIj/qReHkvbY23k
6f0+DWwWlW6dNYOTzunzeqihVNB8Ca+IRADgp6S89o9fMD/2KbIAsNrSKOJwuhAG
qtELaiaIKSFFbibjD1kLAjhcvcSZ6kYeF6sA6dNXvgvH9VgAuoWxcJTR092lPPDd
3f1T/MKZQyo3yal/0WJ9O5rKdUe7HAinhnc8ptUm11hvog21k+sWQkMFgELcJ3Ci
tVI+DaUHu+fv61YcaPMmvHPb8hITEA==
=qfh+
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
