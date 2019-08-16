Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE44C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73261206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565942940;
	bh=yoDmS1zKc9YMqaS+w4U8P3gmNC1qzobRREjaGo3pqOk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=0Rjl9ZtMrkC9VhT8kZDZFsiZIm0WhmN//dbecpEVonPTYjlQKH2aANakWy8MOPHLS
	 Dhsrs21dPtvCwTtGtOCDgHo7H8KhC233GoU9Q6dSm1+NulJBPIsnGtKy95EI4eoGDB
	 0/nwoy9hncyUdhuwxTy7Jyw1O5Ls5wIm0ormdjXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfHPII7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 04:08:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44415 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfHPII7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:08:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id c81so2733044pfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 01:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sEkqY19uv8XGz7I8FybL5GTUac7GNDb9xcSQy6fqx7Y=;
        b=Gc54TiWIlPwnifuAyVCjZa/xKtolTyWVGS8/Ytz+48lovcW1xhaccWv65pIie8SBvD
         D9m8N35f09wK+IX7hRvwvSlWx9Wyy2OW6qoemCCxiNxgonBY0MbohVoC/eo1I+VBoQot
         ww4DSZ6lHNNTc6cccitRd98vqn6/WF3MJGbXrpIXZNSTep35wFN8TwfPxOY+nORZLXDW
         fmCozC7EC1sDvOB1bKRBhaJaa69dE8nSXibd5yVHMHBXsmYXWRj2vcevG2W7RCSq6n42
         InPP8J2Ydoc2Uz4yNoKCFImAp3bdXIYZ0+U+MythK1V9OSO+lsYVElgsxv4dCoRFpJWH
         azAQ==
X-Gm-Message-State: APjAAAUlecsGbQcxDBCwwl9og0WHeXFCDKw9vN7uBHgsqJw16jPObRkc
        RaEMzL6HPUUUaNeKg3TMsqc=
X-Google-Smtp-Source: APXvYqyBIAU/2hpaITi+Ec0mmUjHmhk/Lh9vwyRfzVP8Rw/eCVTX6Aak95wOal4rjF1X4F9Lx2MXfw==
X-Received: by 2002:a63:24a:: with SMTP id 71mr6561236pgc.273.1565942938094;
        Fri, 16 Aug 2019 01:08:58 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 16sm8955198pfc.66.2019.08.16.01.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 01:08:56 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 2D9CA403B8; Fri, 16 Aug 2019 08:08:56 +0000 (UTC)
Date:   Fri, 16 Aug 2019 08:08:56 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Knut Omang <knut.omang@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [ANN] kdevops - Linux kernel development devops framework
Message-ID: <20190816080856.GL16384@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLauP2uySp+9cKYP"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLauP2uySp+9cKYP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'd like to announce my first release of kdevops [0] which I am happy to
share with the community. The goal behind this project is to provide a
modern devops framework for Linux kernel development. It is not a tests
suite, it is designed to *use* *any* test suites, and more importantly,
it allows us to let us *easily* set up test environments in a jiffie. It
supports different virtualization enviornments, and different cloud
environments, and supports different Operating Systems.

This is all built on top of ansible, vagrant and terraform. There's a
few demo projects which shows you how this can be used, one for fstests,
and another for selftests.

I've provided a bit more of details on my kernel blog [1]. Give it a
spin, and send rants / patches my way.

[0] https://github.com/mcgrof/kdevops/
[1] https://people.kernel.org/mcgrof/kdevops-a-devops-framework-for-linux-kernel-development

  Luis

--SLauP2uySp+9cKYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEENnNq2KuOejlQLZofziMdCjCSiKcFAl1WZJEACgkQziMdCjCS
iKf5QRAAnz+93tdocgxoN0OJ0NpXzIdUGhEYh9BlTn19pilXL8cdbF/NXk3pEO56
b27gOJt/t9arzZa+OPCFWFzDD54UDWoidyiTJQumkJSKPLCBEQMqa3HEmm7mImEL
Eo2lKdEoPxPhoesoAJBkGhKHUggxm+vJJ9N2OedLizFW5iy1aQGY6MBUj4OwIW1v
H8RLOwZv9D9AmJxmj7qGEJFKw0mUuAIREwXYJZiuurreXOvVcYjx47LqNIgXc25a
i+7DVgCe8lAS3zO+Jor4LvRHWXbRlR7AY1MO38hm/fLrW3UhvF/smxwB+vpz8IOt
5ae9e8jAwbFA4ZbJEqWbEtIgeLN+kmloekfJP4H6fLBsx4sb61YWFkfV7Glh91Dm
0iGbs3WvPVtgsmlS6TKmFuv6AFL1p/pdyZSiZJG+gxSxeM8IqYQH8wjKiUYuxjbc
eXtapXe86yA7LL+bb4XGjAwVhD/KH4sY5OKUbGN8e3Pv/oGADgFFhXkCQAY4X3+n
I4ohjRNldww9tEDb4uPJNvSRP2jRqaYhniE4KSLcICGW926ZCZ2qgo8R8PlZkG22
oQPmZjR14dQ2TC4elC5Hm70FrwNPYhGS3UXQbLHjBPXgH3dSGMSQioMd5Nd4sTLL
oervDIBTBnmHkwN/lT36IvivAFqYe/orOS7kN8unl0yvVdA6Xms=
=yc7a
-----END PGP SIGNATURE-----

--SLauP2uySp+9cKYP--
