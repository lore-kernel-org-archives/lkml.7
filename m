Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DB1C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B0620B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570628236;
	bh=TY7xBS5LYEmBh2Ar+0iDVGLHv6A5+Yhw4WFBNmWLflE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1RxLixBXCHo85pxged40WXVo4GK97Bxwk1OEQ0gyFGmF5owfiDofPvwNhQBB66gQP
	 0fMKBHyX6+xhYChVKvCPrckprkkBoZhW+PKN1/Q3cyrUvrHn6SyHTBbrq0sSLcSOwO
	 ++sa3B4VLszaPHAZxDdWhAlUDaeQlOG+O02znkL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbfJINhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:37:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33274 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbfJINhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XfFUTXDUlOBhRb5NjOcI6XT8SYuoYPJzK11sfR/uJkA=; b=TkpLetSuWl8IcRpP8aCZuAweh
        rQ//FqOsPsXPcYJaQWrJ5aAhgDZL0qJHoZ73wlcoyF1KNoBWv0Ino2ACKa67KCOxx20xy3XCwf6+O
        VXo+b4KcDuCtrfE7AJaVQcVmRn82phybnp+1dy1SUQZZAO/1ZqWLk6cWTpjLlVIMtR5cw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iIC9O-0004sS-EY; Wed, 09 Oct 2019 13:37:10 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2E1F92741DF9; Wed,  9 Oct 2019 14:37:09 +0100 (BST)
Date:   Wed, 9 Oct 2019 14:37:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Cheng-yi Chiang <cychiang@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        Hung-Te Lin <hungte@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Paul <seanpaul@chromium.org>,
        Dylan Reid <dgreid@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] firmware: vpd: Add an interface to read VPD value
Message-ID: <20191009133709.GB3929@sirena.co.uk>
References: <20191007071610.65714-1-cychiang@chromium.org>
 <CA+Px+wWkr1xmSpgEkSaGS7UZu8TKUYvSnbjimBRH29=kDtcHKA@mail.gmail.com>
 <ebf9bc3f-a531-6c5b-a146-d80fe6c5d772@roeck-us.net>
 <CAFv8NwLuYKHJoG9YR3WvofwiMnXCgYv-Sk7t5jCvTZbST+Ctjw@mail.gmail.com>
 <5d9b5b3e.1c69fb81.7203c.1215@mx.google.com>
 <CAFv8Nw+x6V-995ijyws1Q36W1MpaP=kNJeiVtNakH-uC3Vgg9Q@mail.gmail.com>
 <5d9ca7e4.1c69fb81.7f8fa.3f7d@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <5d9ca7e4.1c69fb81.7f8fa.3f7d@mx.google.com>
X-Cookie: Every path has its puddle.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2019 at 08:14:43AM -0700, Stephen Boyd wrote:
> Quoting Cheng-yi Chiang (2019-10-07 11:50:31)

> > IMO the nvmem approach would create more complexity to support this
> > simple usage. Plus, the underlying assumption of accessing data with
> > offset in a buffer does not fit well with the already parsed VPD
> > values in a list of vpd_attrib_info. But if you strongly feel that
> > this is a better approach I can work toward this.

> I'm not sure how an ACPI system like this would work because my exposure
> to ACPI is extremely limited. I would expect there to be some sort of
> firmware property indicating that an nvmem should be used and it's
> provided by VPD or for firmware to parse VPD itself and put the
> information into the ACPI table for this device.

I fear this is optimistic.  It's fairly idiomatic for ACPI for stuff
like this to be keyed off DMI information rather than integrated with
anything, basically once you get out of the bits that are explictly
standardized you're into board file territory.  There is the _DSD stuff
for using DT properties in ACPI but it's had limited use AFAICT.

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2d4oQACgkQJNaLcl1U
h9AkxAf/WtJz8gLoIEhfmWFM3Y4Qvz6cFPqsO5kNBWEQH18SykjRbNumBoeynRlg
0j+2Vz6nFCns429nsLJ/ooS/sKbFGY9UfK8TDxJdUiifheot3MJahzT92vTj7LbB
AGk+U9e4/n627enaqdqDGmf8m2aPpUqJdmPhr0zuV8/N2c3SMzCTcBXB4BGqkd9I
My1IdAX5qlmi5+Q0SXmUJjwJtiVs0rdurw3TcKaOdpvhDmyLdJVuaLYmM1QXh0v8
G5UNLVXzEN0RJZO7dDnbImprk1hOTC7Sze0T5ykh0W0UeydBAw7stk0zVGYro7jO
K/UYMfOOX3LPFttYf22WeGOLFUf5TQ==
=UWfy
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
