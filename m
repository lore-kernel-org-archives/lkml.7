Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B03ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE262082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571310782;
	bh=Z16BzfTJRQyY4OaHhTth+R8GgLkwhum8TZacufHgBYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xZM0E+KjTRGA9BHexa/9QyDAOyvBlMuQ5zQbIYE6MKVJAvrwhbVyRaWPXFa4c/sdE
	 ylprJw9qhTdnzu4QBFHqUjAs9Cw8NWqheWe9hxQHnO7wzxW37SuPhm+5fOppevxCxt
	 cP4S6vGotz2sRUTctfuWwzqVYNL96yjs3QlChomk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502088AbfJQLNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:13:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34740 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502065AbfJQLNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z16BzfTJRQyY4OaHhTth+R8GgLkwhum8TZacufHgBYo=; b=CQzBlz5ovZmQvv79SVJjnkSY/
        K83tjTFkwaDH3x7YI2kiyerEMKoPJdSK3jPxY1/cDPCKNvYKWMbR9nK/ib/HAd+rpLD3x2Iont/At
        2ZhgkmFlEPZZhgYkQXNkK1lWgcnYvci4YCNjumC53qRgMDTNT4Kro2F11L74oGlEARzuE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iL3hg-0000ms-ON; Thu, 17 Oct 2019 11:12:24 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 4C46427429C0; Thu, 17 Oct 2019 12:12:24 +0100 (BST)
Date:   Thu, 17 Oct 2019 12:12:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     vishnu <vravulap@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] ASoC: amd: No need PCI-MSI interrupts
Message-ID: <20191017111224.GC4976@sirena.co.uk>
References: <1569891524-18875-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <BN6PR12MB18093C8EDE60811B3D917DEAF79D0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20191001172941.GC4786@sirena.co.uk>
 <f9b1c3d5-6e02-354f-91b6-3b57e2f88bde@amd.com>
 <76668467-5edf-407a-a063-50f322fe785d@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
In-Reply-To: <76668467-5edf-407a-a063-50f322fe785d@amd.com>
X-Cookie: Shut off engine before fueling.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2019 at 09:33:06AM +0000, vishnu wrote:

> Any updates on this patch.

I already negatively reviewed it?

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2oTJcACgkQJNaLcl1U
h9BZ8Af/aItxQ/fzZbfWq7+sgVlfdqtTcaeA+CvcFEXbLtRyz07zrmSlpvF63bNl
FVNBlxmpPAJdoCoQMn+VLO7rZaXkGBwo9N/yGN9dcb73JVUL3qvF+fNmP0n85Oz4
maskfYtpX4+PGQqaIwPUVh1d2QBOoRwJ60rPincB7mYIgNuDhlXTkUqy8xViqCOx
VJJC5AmosnKW9ViuxAhBnJSIc0r3WgpF6TC5432+B0Ba/r2le0N1ftexI/8fXHnK
w3yhxTyJ907vh0O8tIRVo/ZP1UfxVhKH/+ktbXk7xV97G3EP7oH8oRsl0Buylj8H
T99jB4z9IozWpqazJPeSWSPtFaDnYw==
=hpgc
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--
