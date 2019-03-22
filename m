Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E31C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF4621900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfCVV2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:28:10 -0400
Received: from anholt.net ([50.246.234.109]:52800 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbfCVV2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:28:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E5A1D10A2C47;
        Fri, 22 Mar 2019 14:28:07 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id MP_bbBtIY4Pf; Fri, 22 Mar 2019 14:28:06 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E250C10A2F16;
        Fri, 22 Mar 2019 14:28:05 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 6559E2FE4653; Fri, 22 Mar 2019 14:28:05 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH RESEND] drm/vc4: Make sure to emit a tile coordinates between two MSAA loads.
In-Reply-To: <5c5ef4c7869f9294cfb7128a8b0ee00cf2012e40.camel@bootlin.com>
References: <20190206232550.12012-1-eric@anholt.net> <5c5ef4c7869f9294cfb7128a8b0ee00cf2012e40.camel@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Fri, 22 Mar 2019 14:28:04 -0700
Message-ID: <87imwa38gr.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> Hi,
>
> Le mercredi 06 f=C3=A9vrier 2019 =C3=A0 15:25 -0800, Eric Anholt a =C3=A9=
crit :
>> The HW only executes a load once the tile coordinates packet happens,
>> and only tracks one at a time, so by emitting our two MSAA loads back
>> to back we would end up with an undefined color or Z buffer.
>
> This change deals with things that I'm not very familiar with, but here
> is my take on what is happening here:
>
> - When we have to do more than a single load in the same render command
> list, we need to send out tile coordinates and a dummy store in between
> the two, because of internal architecture requirements of the GPU;
> - We're dealing with the color buffer first and then the z-stencil
> buffer;
> - As a result, we need to issue that dummy store in the block handling
> the z-stencil, if there was a previous color load in the rcl;
> - We previously only did that for non-MSAA z-stencil buffers (without
> the FULL_RES flag);
> - The same thing actually needs to be done for the MSAA case too, as
> the reason why we need that dummy store also applies to MSAA loads.
>
> If my understanding is correct, then consider this:
> Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

This is all correct.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyVU2UACgkQtdYpNtH8
nujq9A/9HbvDJ1hdn+1ZPs45CqL0EKn21SV067mXvQBjWWnH7bTk9R8Gi2Kf0W4Y
52T7ZtFz/m056VSYu0LC5pkdHBFR0OVs5OyTsjft5hZKwcJlZpxrTqDO1zeUAURF
HfVMpV2cyFEdXLUwV5F9bw/3VNjJ1VFHON3fZzb7Au8OB6EdpTLhNGfepoVsbnnq
WFU0CWyg30yQLIz2yDgCVk0Vrx/b8GJQtWxaPpKpn2wC9nYQ0XT9Skn7Hku766Rx
Zct4LU4K2CrSnN2UwLXPRnFxSjSOUZLYoCOdO82uKfOwYQJOQwmsrJkWuAo7XeQZ
bUaaZcRItY+f4GzhELQakUV2JMrDlgYy8V3S9S5UwN4UIhXX8Y327+jm93ewURs7
HbTw2xs3NHkaDfo0S8993AWSe12zifR2TjVGy9CbUbUz5fuIvIgf2tZCLG0zdszn
lO836aJht2t2UXl6FNOrdDKlDzi5rAM6TMoT7uWCHzD0UY/UyYPkFciACHoM3pRm
QcxkpnFu790NQlFHshkRgZjSVo7qpcHokjFhoJqfxsdNT/nsM2e6nOxClxjyNhAD
q+xwg57R2XTev9Sqd4RrT70oFFEjPOD7AMy1nGjez9182te759XeBpiSzhZ89iHY
J+tAhxDmJWIWHMDDVobqKpMCyuRQUhChhDXnZKRsO/oLpF/zOkA=
=Kh8o
-----END PGP SIGNATURE-----
--=-=-=--
