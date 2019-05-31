Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA71EC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8620E26969
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559309224;
	bh=YqusqY9ZkH6Npoicn+crWGyPEFfsOWB2EFhjTifVbMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LTfjVfpy5l8F8ap1l1xJQjLbbY0gnMlHu0QQh0sKEQDmou3jRRbLBhoKSqH7OvXUC
	 u4au85n4plH/XuFFEVoli28AAk+8kY4POKEojZ1SKXZbKbwGp+agCn8oii8dGzBD06
	 uENihZz/U3UFvBzJpD8nJn30ms/eXfDLHeAWe7c4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfEaN1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 09:27:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbfEaN1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 09:27:03 -0400
Received: from earth.universe (host-091-097-002-124.ewe-ip-backbone.de [91.97.2.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C697626963;
        Fri, 31 May 2019 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559309222;
        bh=YqusqY9ZkH6Npoicn+crWGyPEFfsOWB2EFhjTifVbMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yTdPijdQt8v7qtRFDw9pFy+qt44JpuV3K/Cz5T4qmw09784Xdt2s9ac02aezUJIUf
         c4RTjM5ZSMQtaky85KkxQlV6LQfWccRikbhWo5gbE0Gf6tB1HdPYG7bkvCsKugjv6k
         CNx/lx5Q+ULsMLVHsXWeX6V1O+OqmMlrQAOFFvTQ=
Received: by earth.universe (Postfix, from userid 1000)
        id 3D7443C08D3; Fri, 31 May 2019 15:27:00 +0200 (CEST)
Date:   Fri, 31 May 2019 15:27:00 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        teheo@suse.de
Subject: Re: devm_* vs. PROBE_DEFFER: memory leaks?
Message-ID: <20190531132700.o7kopr33kdztqdv6@earth.universe>
References: <20190531085209.GA20964@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sfcqqzyrmfnzli66"
Content-Disposition: inline
In-Reply-To: <20190531085209.GA20964@amd>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sfcqqzyrmfnzli66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, May 31, 2019 at 10:52:10AM +0200, Pavel Machek wrote:
> Is devm_ supposed to work with EPROBE_DEFFER?

Sure.

> Probe function is now called multiple times;
> is memory freed between calling probe()?

Yes, EPROBE_DEFER is an error code, so devm resources
are released.

> Will allocations from failed probe()s remain after the driver is
> inserted successfully, leaking memory?

devm_ is connected to the device, not to the driver.

Since code is better than words, check drivers/base/dd.c yourself.
The relevant function name is really_probe(), interesting part for
you starts at ret = drv->probe(dev) line.

-- Sebastian

--sfcqqzyrmfnzli66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzxK6AACgkQ2O7X88g7
+po8XhAApEXxQhcTweD9Ef8YuyoQm7NGIQl1kT6QV+Mg9vDgyf4wvowZDEcInCMd
Em2OCVHoO6QBEnmq8yci4a1l1hpppH3a7MugZKGBRdS9t1f0tBMdyE5dpU5xYmWX
yPfV16JT6Duk47wxVN53DhjNZlpYNVCQL4ok6crOlJWwp3JvfG+GZVXpuEZ+0md5
Qo1iQWVYsOnVljBgKTeQ4ZkcjeRqrUIB7OcJJ4jmV2/t2JurtYr2C9u7BCnG26CC
AuBUE5wWQtq30HS79jF0/b9F2sVu2QLf9vfCRt8mayTA+pi3e6qoYsYrvkHOTjTF
PuJGb1oxgrJ2YSZm+R0q7GRZIwB2twV3LgTghImzHP85rX3uo8KvJPvbkyTYNMfk
NspgQCcJAuNNNRH9rRkMLLuWTx2lCC77mWxNUwfHBltDIphT/3m+JRsnW6VdgA/T
xR6yZ/q/ThQZQ0tCPxyEunry62fHbdllcRYCIwJ9CNKSnrO4kWLrDUqop8LUFlq+
b0bSYHHd3+CDT5379zQPlryIlJKy9l2P0vTCwIFDKurOSX+Qi8APnpas4qjD0vAE
lPEoPoLUwqWefDbt1t90OSVJCggqIDoTH4q3aOLWPDwvNr4wFXHo7kW37ogwYr6F
FM22DHPQUqZqdNyLYnlxonn2h+959laOa0xYN8lR+y5IfrMvTek=
=K+Zu
-----END PGP SIGNATURE-----

--sfcqqzyrmfnzli66--
