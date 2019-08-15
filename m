Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAEDC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE82206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565887968;
	bh=RBryVFven3RZFpz9Ruus7F2nJ4Oc7APoeNae+7kUYvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ogy8WDJ0KgB8WCxzlwJor9hNLdv9Vm32QbQrzGmxG3/wWDrZkwojmPQb81/M47XWn
	 EvzY1K5ryiAMIuenjIt+cg/yN+xu5jXyNyiiXXez/UzBqSh36LiorJYg9IWI5dZHbv
	 pTCgRg6uFFvlETSrZkiJzz0+FKaxMBoFx+GIg3DM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfHOQwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:52:47 -0400
Received: from mail-ed1-f100.google.com ([209.85.208.100]:46113 "EHLO
        mail-ed1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfHOQwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:52:47 -0400
Received: by mail-ed1-f100.google.com with SMTP id z51so2617858edz.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bBE6aaXfbdthMjW7RrUsuVXnTyAwPNUrUks/THOR0hY=;
        b=IL8uUe05mW84v7yec+FYj361gDFOCiaUGSqgax5DuMvkKwmAG06AlBppRBNkK1d1fV
         ZqLFJnXG9tPI5i8PwTyV3OYUrx0OlzGEmWwJ92GkczZMgEtAi2qRPhdQrHUpsSjqxtp3
         tc6vHwIJ7Gdb8rXyOgv4gqcgIR7xs8U+ciym1EjcBQfwIiEh4G79Weig5RwxBZBERi21
         pmdQihbPsjbnM4v0Xdws8bmBSvMkR128XglKNQSPJrQUDesUNxKOhnuS+6RxsWZ5d9Xn
         9Pq5TIfNAA8z+6FcABGp7i09mg6ki3MIsG9Df0DRTOqs9Z4NvJHFRlWixRv4Vym6M19U
         l29g==
X-Gm-Message-State: APjAAAX4Bds5GRXQBOg+FptRZXDhd8HeCFQLzFrB2Mh1SGLIaLdTVmE3
        XGyfqSacoRuHHpvZKxufiUmVxpViZvitSfIPiqaMjEdjusV4PkCf/XpDU/tcvPTOxA==
X-Google-Smtp-Source: APXvYqzy7m9fqIQzgnbqEAxq3CNhPE1jwxvUpnhU6Nj6SwebXXMkv/eKf0PkEDtd+tkRDORcIHtXs7I/K8K4
X-Received: by 2002:aa7:c64c:: with SMTP id z12mr6501653edr.146.1565887965322;
        Thu, 15 Aug 2019 09:52:45 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id v11sm61880eds.33.2019.08.15.09.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:52:45 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyIzU-0004u3-TT; Thu, 15 Aug 2019 16:52:44 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3CA2F2742B9E; Thu, 15 Aug 2019 17:52:44 +0100 (BST)
Date:   Thu, 15 Aug 2019 17:52:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Raag Jadav <raagjadav@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 1/2] regulator: act8865: operating mode and suspend
 state support
Message-ID: <20190815165244.GA54921@sirena.co.uk>
References: <1565721176-8955-1-git-send-email-raagjadav@gmail.com>
 <1565721176-8955-2-git-send-email-raagjadav@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <1565721176-8955-2-git-send-email-raagjadav@gmail.com>
X-Cookie: Klatu barada nikto.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2019 at 12:02:55AM +0530, Raag Jadav wrote:
> Implement ->set_mode(), ->get_mode() and ->set_suspend_xx() hooks
> for act8865 with unlocked expert registers.

This breaks the build because it depends on patch 2:

drivers/regulator/act8865-regulator.c:22:10: fatal error: dt-bindings/regulator/active-semi,8865-regulator.h: No such file or directory
 #include <dt-bindings/regulator/active-semi,8865-regulator.h>
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1VjdsACgkQJNaLcl1U
h9DGoQf/U7SNQL5EaBGBy7/X3RqNXsOh5/zVXWrjoxsQb7s9IYT7DrN5ESS491h0
muZWo1k9R3SrDXao8/mxE9V+k7Jv9tF4Rw/5SCHT9lYE71aUMrFlWQ2Rn5yqRaXu
/eEyoKkjkqRFo75iK5TR5zBw1ae7mC3leSeUxbTGspKxFrsJKcVNausaIF60/M9Z
VPKfVbisLdSZD8GuXW3WAY/vpI7EuXuMBqHsiJXqv9LD1GrTbpVRaaAQr7BKHoMe
OJqLTYg+Dne7YF7jCnh29v6plsyOnRgkTWHPSTL9r55WcGL1gSD+WwspvJU+XFTU
1QXbYjANxj2DF2TXIQv26F/WgeBIrA==
=MsMV
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
