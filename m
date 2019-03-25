Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9350FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541AE20693
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="A65bYuxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbfCYVpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:45:36 -0400
Received: from ushosting.nmnhosting.com ([167.160.173.127]:54220 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfCYVpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:45:35 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id E3ACB2F287F0;
        Mon, 25 Mar 2019 17:45:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1553550334;
        bh=bxDjUeTmvb4ejswIF03RrXxYLx7YRmxOTuDyR4F4ONs=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=A65bYuxOR6G484SPOsMLInQgQbbBid24SyFe7qVU42e6EhFfKR8FwajL37HTOKQJW
         GkYrJsA2/BXGPY7GZqqX5G2kuOP63kcxhuyIF/rWTRln3qBEgV4dBiTw9/5sTtJPHl
         QcDIlPHTMlzPq8532YkAgJO6lPkG0ubOje9BgUXe/eew0GaBZHW2ZVQHWfoVJ4RGa2
         v9TmqDVpL6Ah7e00RHR7ubb1P+5fot5IA2IIW6YT5cDcj32Gnk1smz2DTGrPOeTgbj
         Vf6dpwdel0iLgMaO4T/7/5m9nO/ZZdJso9nyP10D59sLdRyhg3nvWP6vvkVuvhGnMy
         k+DeOEEWDOnbPMIvpJMmooBQJI/6MlwFgKPOWH1ssem2q3TGmOqpfr6/wOIkFPs9qW
         CGRcbRoauE9wvRVn+1JzSrm55JRUG4WgmbKGPl8I27+VpkZwT12T9ca98mQ16KV6rA
         g8mMeFx3XCBRpd7Wsk4FEhZwjqldp0NzJ0JJJ4mkTw5e1d5ZLCD7hgzAEHAkm9SYzc
         yCYtJUdNZdlTcDch9uXt5PGCCrkPnIGP94C/8nPRKOal2Zzwm78QghdyODI6FXvUfO
         aUw5APLiEHp2czBavEqGkTHthwxT/4fCml2+zY4yXzMZ2xIys+T/5V70bJJqloExe3
         oj6DfPeGYB51kWy1JnqKoMu0=
Received: from Hawking (ntp.lan [10.0.1.1])
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x2PLjRKH071802
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Mar 2019 08:45:28 +1100 (AEDT)
        (envelope-from alastair@d-silva.org)
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     "'Frederic Barrat'" <fbarrat@linux.ibm.com>,
        "'Greg Kurz'" <groug@kaod.org>,
        "'Alastair D'Silva'" <alastair@au1.ibm.com>
Cc:     "'Arnd Bergmann'" <arnd@arndb.de>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        "'Andrew Donnellan'" <andrew.donnellan@au1.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>
References: <20190320053448.2098-1-alastair@au1.ibm.com> <20190325053456.14599-1-alastair@au1.ibm.com> <20190325174919.5c877cf9@bahia.lab.toulouse-stg.fr.ibm.com> <5d6792fe-f4db-b973-c654-460533f69f2f@linux.ibm.com>
In-Reply-To: <5d6792fe-f4db-b973-c654-460533f69f2f@linux.ibm.com>
Subject: RE: [PATCH v4 0/4] ocxl: OpenCAPI Cleanup
Date:   Tue, 26 Mar 2019 08:45:31 +1100
Message-ID: <1121601d4e354$126a2050$373e60f0$@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJxQ5zc/X54GvcuUabOLzZoxv3nuQHodgkHAh5VXE0CmKCoGqSvJWGw
Content-Language: en-au
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Tue, 26 Mar 2019 08:45:28 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Frederic Barrat <fbarrat@linux.ibm.com>
> Sent: Tuesday, 26 March 2019 4:34 AM
> To: Greg Kurz <groug@kaod.org>; Alastair D'Silva =
<alastair@au1.ibm.com>
> Cc: alastair@d-silva.org; Arnd Bergmann <arnd@arndb.de>; Greg Kroah-
> Hartman <gregkh@linuxfoundation.org>; linux-kernel@vger.kernel.org;
> Andrew Donnellan <andrew.donnellan@au1.ibm.com>; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH v4 0/4] ocxl: OpenCAPI Cleanup
>=20
>=20
>=20
> Le 25/03/2019 =C3=A0 17:49, Greg Kurz a =C3=A9crit :
> > Hi Alastair,
> >
> > I forgot to mention it during v3 but please don't link new version =
of
> > a patchset to the previous one with --in-reply-to. This is to ensure =
I
> > can see them in my email client without having to scroll back many
> > days in the past (which likely means a fair number of e-mails on
> > linuxppc-dev).
>=20
>=20
> I'm also seeing the other series (ocxl refactoring) somehow under the =
same
> thread. I haven't checked why, and there may be some mail client bug =
in the
> way, I just mention it in case you see a reason for it in the way you =
submit
> the patch set.
>=20

I probably grabbed the wrong message-id.

--=20
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva     msn: alastair@d-silva.org
blog: http://alastair.d-silva.org    Twitter: @EvilDeece

