Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A7DC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE12218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562154194;
	bh=pQ5cywh2P7yPCSjoFtq4GTZ4h4b5at6HIPaA+oYE5/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dx7GfPqHmGgkw+9Xjz5HMxQhdT0AsL94gTTl3VFxmzRmhKDPh+JhSnrkuJ6+01I8c
	 xT+xpYGav4RJVTi7FYZ8G4S2S1xQcE92XAaAgUu09klSN3ymy9B51fazDkkVt5ISRy
	 cIfEqj1XmzipF1//TsS6PzaqMTJlKjjpDQvAMUSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfGCLnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:43:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35418 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGCLnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dHtc+HC/gZMsg89GcjEjwooumgr81KnKaASpELhhe/k=; b=nTdK0RmjvwVVsCLNaH9eiQAq9
        o2zDmjgxTuvd5zpxHUekW3Emf4H0kCtejF/OtGRV6CojuZeGcNkPUKr2I+4PXoy+2eQmYVjLvVoaC
        wVAOtCM34t/l0kPKselrnf5A5KW1thg2caQOVX2sHfgo7U33lTPDcRQzyO5kYtYF9NR7o=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hidfJ-0005rp-31; Wed, 03 Jul 2019 11:43:09 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 64149440046; Wed,  3 Jul 2019 12:43:08 +0100 (BST)
Date:   Wed, 3 Jul 2019 12:43:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] debugfs: log errors when something goes wrong
Message-ID: <20190703114308.GU2793@sirena.org.uk>
References: <20190703071653.2799-1-gregkh@linuxfoundation.org>
 <20190703071653.2799-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ImSVV91IQg5ga+3z"
Content-Disposition: inline
In-Reply-To: <20190703071653.2799-2-gregkh@linuxfoundation.org>
X-Cookie: This sentence no verb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ImSVV91IQg5ga+3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 03, 2019 at 09:16:53AM +0200, Greg Kroah-Hartman wrote:
> As it is not recommended that debugfs calls be checked, it was pointed
> out that major errors should still be logged somewhere so that
> developers and users have a chance to figure out what went wrong.  To
> help with this, error logging has been added to the debugfs core so that
> it is not needed to be present in every individual file that calls
> debugfs.

Reviewed-by: Mark Brown <broonie@kernel.org>

--ImSVV91IQg5ga+3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0clMgACgkQJNaLcl1U
h9CsxAf/SAu4STWFRIPGShGVgEIX9T3573oTxMdMrJRG6lI2QjpOqsBhcpKKcjqz
oS5JkGIAa3Nju5YF9r3bi4Fyrg4f5SN+kiy25C+IAg99Oar7s0TyIn5xuC02z30A
kBK6MZxKFSnqDa5RqmHx2TPFxb/H8CRza8KAktHI0qa/8qT7vZWVOLfbokSSK7aH
ZNZz6MHxliJC6lYo+c55nYUk39CYxhJ/vROILwwqUWgCZuL2qBIPOuwGzkwyU+jx
gyE3IoAEo9ujYETzGVP2CqIKqe/qHA4vkfKOzj1GB4wVf/yar6UVKGtftIGj4gnV
RdNvU8OVSYUgm3hKQ/jf+FMkxy/2qA==
=JbGm
-----END PGP SIGNATURE-----

--ImSVV91IQg5ga+3z--
