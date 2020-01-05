Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2340C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 18:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C75B207FD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 18:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jonmasters-org.20150623.gappssmtp.com header.i=@jonmasters-org.20150623.gappssmtp.com header.b="J1fmoRu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgAES6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 13:58:44 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:42654 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgAES6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 13:58:44 -0500
Received: by mail-qk1-f177.google.com with SMTP id z14so36515972qkg.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 10:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:in-reply-to:to;
        bh=GfWPZ1IoqGFtGNaCsmEU0Md+UBRsRdcismpPZHy7P5k=;
        b=J1fmoRu8AE+9WbSwzfVVSZCUuKmrto1w4YQloXCbX53GVL/atRwy3hNPrbZr+5DqUT
         0NE+KLcIfpmrdnldqycZ47VG0f4cyIkrsDQ9zoxaKfcHq2bwvhSL3UB7ipfEUKk78Moz
         kOYlyvCWyJWwMEWpSCqwP3xLnO6dbQXNSpJHyBayqwJKm45CpZWprWMT58SgAKh1Mw41
         /vnxJgNvJb5eYYinILi2M/8Z/T+64s+833WumTe1wUZYIQ14A3AbKSZMGmTv/W36fJey
         TMUTyUoDsVH+3ebu3plxG+MNQtY7ey0+Ybgb0LTeoHjW4gVpzlHwxw58FbqVrGa/NzDt
         NnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:in-reply-to:to;
        bh=GfWPZ1IoqGFtGNaCsmEU0Md+UBRsRdcismpPZHy7P5k=;
        b=GY9Ta+kELAZWTJxw3hHCsklM5PLcr16opsTPDULotTST2GUMuCL3BXjTpj/bd2WbUQ
         RR8yNbwGvoZvyVjMcRG1AqOtYfWsrYyZGEsWKcLEz6t2Mf9eMbI3CxLzL8fMkzZTSxK8
         4OALdn0vLXjlPNCilgZNWLEZysOTCK/i9EU9PvqrSkl93vH5OSDxfsxI3TDMNoP5Dmch
         P1elhASw8xwerUduhOMfoFBAxvjQE9fW1zfjZon5efeeEMdh0B+o2KN1AkUhH6OTxpdb
         SWe8zBg8bmJ+bzQBeqi34cdG80yCafdI3QfOULdLySQFgGVuWFNBJPeWuKMlK9RWmVbM
         toAg==
X-Gm-Message-State: APjAAAVwAuRIJ8kUR4VAVfqjNl/M+zAoIu9RFzskfPyR0nP//L3Ra64q
        GwD9e9Wevb72/KTfKN610nkoHIjfvdk=
X-Google-Smtp-Source: APXvYqz7eCgzbM3/T2jer6ze912kLc8bXrBe6+usmeZ2/79viMC/89zfdibWkoi3dGnXrF4KIiabkQ==
X-Received: by 2002:ae9:e513:: with SMTP id w19mr79905996qkf.34.1578250723033;
        Sun, 05 Jan 2020 10:58:43 -0800 (PST)
Received: from [192.168.1.120] (Boston.jonmasters.org. [50.195.43.97])
        by smtp.gmail.com with ESMTPSA id l35sm20667159qtl.12.2020.01.05.10.58.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2020 10:58:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Jon Masters <jcm@jonmasters.org>
Mime-Version: 1.0 (1.0)
Subject: Re: nf_nat not running in a netns
Date:   Sun, 5 Jan 2020 13:58:38 -0500
Message-Id: <8D4A3CF6-E12A-4AC5-A8CC-E2D80DB83F65@jonmasters.org>
References: <29555895-6D59-4415-B44C-5AD90C14C63F@jonmasters.org>
In-Reply-To: <29555895-6D59-4415-B44C-5AD90C14C63F@jonmasters.org>
To:     linux-kernel@vger.kernel.org
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore. The below was exactly the problem.

It was broken. netns nat rules in CentOS7.7 kernel were exactly not working d=
ue to a bug. Sigh.

--=20
Computer Architect


> On Jan 4, 2020, at 10:51, Jon Masters <jcm@jonmasters.org> wrote:
>=20
> =EF=BB=BFHi there,
>=20
> Can anyone offer any reasons why the nat table chains for a netns wouldn=E2=
=80=99t be running?
>=20
> Longer detail:
>=20
> I=E2=80=99ve be playing with Kolla (containerized OpenStack) and the way t=
hey implement (virtual) routers for tenant networks is to create network nam=
espaces with interfaces representing the ports plugged into the router. To t=
ranslate addresses from internal to external networks, they apply D/SNAT rul=
es within that netns. All of these are created and the interfaces are pingab=
le, but the nat rules aren=E2=80=99t being run and the untranslated addresse=
s are ultimately seen on the physical network once packets traverse out of t=
he containers and to the external neutron interface.
>=20
> Jon.
>=20
> --=20
> Computer Architect
>=20
