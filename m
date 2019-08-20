Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E891C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308A322CE3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566320313;
	bh=ooh6mwKy6a+QGfw+7zbwTx9DfsC355+UrHQNcQkfTs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o46WB1MpkPuM/AGTpvaLv5TysYhDmT82PP8QktsXnFTbG6dczEQTVplL5JuEl07K5
	 KXLSuvGIIt7OO51gd9GkXkx5x+l2qeOt6Z/b5ACVKEnHwFEOg8V/3wa2hqv0ZzgZUo
	 ZOTFXG+n+i4ChzxFc2cj+PG5XlD73VN8tMT+Sf+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbfHTQ6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:58:32 -0400
Received: from mail-ed1-f97.google.com ([209.85.208.97]:46152 "EHLO
        mail-ed1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730581AbfHTQ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:58:29 -0400
Received: by mail-ed1-f97.google.com with SMTP id z51so7102215edz.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 09:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ooh6mwKy6a+QGfw+7zbwTx9DfsC355+UrHQNcQkfTs0=;
        b=bT924AWwNws6iQ6zmP9UYbxSE54uKaXztRYzwxZJ2A58CULptNwXOHi0dpAzmBhgas
         n+SDkr9tml1KFlW7e28YVFuowGRZV8f4x3qdSUIIr51kUBLezFPtMCYDL41bNQSVBt7l
         SSK5tVPWxQ5wzswM538RDVCZwq+o6aEW/vwSjeEe94ShjRtptFzY16Lct7bWqOln/n8U
         0ImmnqA0XliwetVFsL3CgJgUT4xM0rBdO7XeG19H7tHsctd7lSvVoeIqPIfgcQTkkU1R
         z4f/2qv50XaKnz4MQ8t45Gv8TeAgsPL2/yAl+CUQaPIKmrIIa83wXuvK7uGKUIdtX8Ij
         /YdA==
X-Gm-Message-State: APjAAAVs8aVbkjaeLiyLh16tKeXgt13RpHV5hXFrvxpqzDw7Pw5kiZ2R
        IMWUL0TD2Co795KvWTt/f98r0PBBCRc9Bok5rXHrbASgEp290Od7eD6ysr1mFNyDHQ==
X-Google-Smtp-Source: APXvYqyXYDITnerApjnV3yhEXbC8CsmwtSNn7YEC7TwQ4jD0UiOEEoErm4RuMvwy8jf2prlgJYaGQRrquonj
X-Received: by 2002:a17:906:4d19:: with SMTP id r25mr26660999eju.125.1566320308261;
        Tue, 20 Aug 2019 09:58:28 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id u11sm303737edq.8.2019.08.20.09.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 09:58:28 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i07Sl-0002xT-Q6; Tue, 20 Aug 2019 16:58:27 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id BB8642742ABD; Tue, 20 Aug 2019 17:58:26 +0100 (BST)
Date:   Tue, 20 Aug 2019 17:58:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Subject: Re: [PATCH] docs: mtd: Update spi nor reference driver
Message-ID: <20190820165826.GF4738@sirena.co.uk>
References: <1565107583-68506-1-git-send-email-john.garry@huawei.com>
 <6c4bb892-6cf5-af46-3ace-b333fd47ef14@huawei.com>
 <9b074db7-b95d-a081-2fba-7b2b82997332@kontron.de>
 <ab2d3c29-982f-cb13-e2a2-e6d8da8f1438@huawei.com>
 <b2a475eb-58e6-e7c7-7b8f-b1be04cf27c0@ti.com>
 <c5e063e8-5025-8206-f819-6ce5228ef0fb@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NGIwU0kFl1Z1A3An"
Content-Disposition: inline
In-Reply-To: <c5e063e8-5025-8206-f819-6ce5228ef0fb@huawei.com>
X-Cookie: It's the thought, if any, that counts!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NGIwU0kFl1Z1A3An
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2019 at 03:09:15PM +0100, John Garry wrote:
> On 19/08/2019 05:39, Vignesh Raghavendra wrote:
> > On 16/08/19 3:50 PM, John Garry wrote:

> > > About the child spi flash devices, is the recommendation to just use
> > > PRP0001 HID and "jedec,spi-nor" compatible?

> > I am not quite familiar with ACPI systems, but child flash device should
> > use "jedec,spi-nor" as compatible.

> Right, so to use SPI MEM framework, it looks like I will have to use PRP0001
> and "jedec,spi-nor" as compatible.

> My reluctance in using PRP0001 and compatible "jedec,spi-nor" is how other
> OS can understand this.

Last I heard Windows wasn't doing anything with PRP0001 but on the other
hand the idiomatic way to handle this for ACPI is as far as I can tell
to have what is essentially a board file loaded based on DMI information
without any real enumerability so there's no real conflict between the
two methods.

--NGIwU0kFl1Z1A3An
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1cJrEACgkQJNaLcl1U
h9CKegf/diFxbL9O/cQMcq2uRUNMNl4gLgGHjuKME4Zo+1sQkFrJNR27rNlGsAh2
mulo2giJlmEzVN1m+nQouojKPegOQjt42Oj8UDF1XOg9LKisfrXp4JMQ7mmQ2Joh
B37OCYGAZPzjJk6MpPwRGUD94v/BE9H6Ma5cqdL+HKTx4dIgMMdvszTG7gwsGDoP
S+BjjyCx/Y/qByOr0w4VxAuMYo/D43tfzvIgcE1YnhPtnkPBIDx7qUa0gWEWVqjF
q8AqdEPcJyLL3Wu+8OBPFdFRWlbjXtLwoCXy+nsC9285sqc8uF+ppJ9UyFP3FgFW
J5/itNaPyZUXNmFPziim/nbgI43BTQ==
=Hh41
-----END PGP SIGNATURE-----

--NGIwU0kFl1Z1A3An--
