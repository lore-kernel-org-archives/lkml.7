Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A4FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3552083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551440760;
	bh=uQiqb/8HsrWZDUs5nbzoHaOMDoaNPvBxnFDv3PloHiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i35gN8WArIpyTGfL+kpEn6CgB67mNgetUXT8QaVFMxQa3t1USfhMUT67sT11R6EVQ
	 JjrR6F52tZR7oJN3MxVJvTMMd+j+fYankO6tgieqoJTfDebVjdIKcRnMDR6bMTba2q
	 5m9bJ2NbAs6hqqHmWFniu6Y76EP/p5QJO7YLdge0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387668AbfCALp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:45:59 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46772 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfCALp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 06:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T6pXHKNa+ACXCXsUuVIA/K9jwD+fxsERuqC5A6ON50c=; b=lUTdB8kF9sCjBt8oRzoqjZkIt
        sGcKFwfzbePvy3qmykp1v76FCrTI+N+gFkC2IBMANuYYzdC2Botq2iRTEwavgBOWuozlPjAbGJLQ4
        yitkW7tuiG/n+bxl2BfQSljUuApSG9u1TxAntY/umXEhoFQ58h1ZvYbNmrdBZuVLQVNd4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gzgbU-00027o-6q; Fri, 01 Mar 2019 11:45:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5C0F11126E96; Fri,  1 Mar 2019 11:45:23 +0000 (GMT)
Date:   Fri, 1 Mar 2019 11:45:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "kernelci.org bot" <bot@kernelci.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        guillaume.tucker@collabora.com, matthew.hart@linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>, khilman@baylibre.com,
        enric.balletbo@collabora.com, Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Hocko <mhocko@suse.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, info@kernelci.org
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
Message-ID: <20190301114523.GA7429@sirena.org.uk>
References: <5c6702da.1c69fb81.12a14.4ece@mx.google.com>
 <20190215104325.039dbbd9c3bfb35b95f9247b@linux-foundation.org>
 <20190215185151.GG7897@sirena.org.uk>
 <20190226155948.299aa894a5576e61dda3e5aa@linux-foundation.org>
 <CAPcyv4ivjC8fNkfjdFyaYCAjGh7wtvFQnoPpOcR=VNZ=c6d6Rg@mail.gmail.com>
 <20190228151438.fc44921e66f2f5d393c8d7b4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <20190228151438.fc44921e66f2f5d393c8d7b4@linux-foundation.org>
X-Cookie: Yow!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 28, 2019 at 03:14:38PM -0800, Andrew Morton wrote:

> hm, does bot@kernelci.org actually read emails?  Let's try info@ as well..

bot@ isn't reading mails but it copies people who can look at stuff on
what it sends out.

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx5G1AACgkQJNaLcl1U
h9DjOAf+PPHQ/BVl5TBqjfMNMuiPCeaKRG1c8zsb8fiR194RFwgdwNGWRE8HcRXk
AN30FaxyXFI+y7WhlvBmJj3kCLHiP1ZXpDFU7XOpFLEcPdSqjMyYZttxSM5Dztdg
s5M58t9V3ic2Panl7J+yq2e2U3aC8NRui2v8RgsEaXNo++uKkEHRbQy5O8+sp57B
ScsEjIa6hWFmy0XZBOSAWSCo+ev7nIiqTdV7EFcYyD9B/TGzJQKvExT5qqq8NYDy
N2U7xhc4a3pWHmtfkyAYfG9MZw8e1nlnoRZqOETEApoI7T1XG0af2C2CyenZ/YER
MQQzHE5/oVawoiZ1dtzvnsn32Nfl3Q==
=VHFA
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
