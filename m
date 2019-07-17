Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93649C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D192173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563361903;
	bh=3vhOqYj+PtzbUcEHbW35eUy5bV7n9Ggbk572XlLEhPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fVYWMJm2+77DTnSNUGLRzs+/HnhavqG3xefd1rUVHj/AU3cmWarkFI0C3z7iOVhHF
	 kZwjCH9ofV2o/FAbOOqwPP3dyggnYX4AixMJ60WN3Ih5/YNvwnXMmm+eFudAOSovr3
	 j3J9WjNOfN/nIE5Oq9XX2/EEpQb7xdCK7L9JFoU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbfGQLLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 07:11:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38858 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfGQLLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 07:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3g+m/3pNJ7dl6s5kOVZHW5kfjNCA7x/qsW8ealkNHEc=; b=txE94zUT+VkiVbqb+q3XJ4LpO
        QQrh/zydf7DZ/KavtcMaa0EtSWnjXPuLzqswnkSvjKkMdyphd+VdQD94m8OhZloNIm9cPGnaUXyGO
        9Q/Stgwf4jci+vKlvzxYhn1T75GL5vOnvZT9/t9AieuD4jg7lKxeJSDjfIvh0sbV68I9E=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hnhqU-0000Oi-4T; Wed, 17 Jul 2019 11:11:38 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 056DA2742C17; Wed, 17 Jul 2019 12:11:36 +0100 (BST)
Date:   Wed, 17 Jul 2019 12:11:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: remove redundant put_device
Message-ID: <20190717111136.GB4459@sirena.org.uk>
References: <1563357944-24496-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <1563357944-24496-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Cookie: Fremen add life to spice!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 17, 2019 at 06:05:44PM +0800, Ding Xiang wrote:

> device_unregister will call put_device,
> so remove the redundant put_device

>  	child = device_find_child(&ctlr->dev, NULL, match_true);
> -	if (child) {
> +	if (child)
>  		/* Remove registered slave */
>  		device_unregister(child);
> -		put_device(child);
> -	}

That's to undo the extra get we have from device_find_child(),
not to undo part of the registration.

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0vAmgACgkQJNaLcl1U
h9BxeQgAgRydnwPM775pyEWvHZVBMnZKxO5KnJ44V8lw2qXRKK9Kz8z973ADoIWS
31b8shX3Ei9CHkC9eW334ha2stXGD316psiHzeo/7TAS/0VW88XfQ1c9Htn2rT1S
VmED80yhjqttGATYKeXSApnG5GFtM8geQ/hINWrtRc15RV/1z9ng/2gs5XURVfcC
y6DrZoYmOEywyA1NtsdTmUhh31cmovlwaGDWgaekIY/ZmSWF95al9jMLzJiL8V1W
BJNswwTcrlF93GvIddxA/LqjMe1/8xck6gik4y18Npw2qbnpqFpu6yujgOowmBW8
SuB872plg39gO2fiYBRLl2ytmx6P1Q==
=/MxI
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
