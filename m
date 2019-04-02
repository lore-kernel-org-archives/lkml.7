Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCB3C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7341120663
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfDBX5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:57:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:38078 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfDBX5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:57:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 97C66AE92;
        Tue,  2 Apr 2019 23:57:48 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>
Date:   Wed, 03 Apr 2019 10:57:38 +1100
Cc:     George Hilliard <thirtythreeforty@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Nishad Kamdar <nishadkamdar@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sergej Perschin <ser.perschin@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH 03/16] staging: m57621-mmc: delete driver from the tree.
In-Reply-To: <20190402204658.GA5187@habor.localdomain>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org> <20190402103203.14959-4-gregkh@linuxfoundation.org> <CACmrr9hZRiw10dDVcvFUFB7ZFzFq-WfELRXnTLOM_j5LoNnw3A@mail.gmail.com> <87r2ak18yy.fsf@notabene.neil.brown.name> <20190402204658.GA5187@habor.localdomain>
Message-ID: <87imvw0xl9.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02 2019, Christian L=C3=BCtke-Stetzkamp wrote:

> On Wed, Apr 03, 2019 at 06:51:49AM +1100, NeilBrown wrote:
>> People keep telling me that drivers/mmc/host/mtk-sd.c should be able to
>> handle the same hardware as this driver, with a little bit of work.
>> Unfortunately they haven't told me what the little bit of work involves.
>>=20
>> Have you explored that possibility at all?  I might try to have a look
>> if I can make time.
>
> I have started to look into it, when I was working on that
> driver. First sorry for me doing nothing in the last few
> month. Generally the two drivers seem to be very similar, the main
> difference is the code for tuning. In the staging driver. this is a
> total mess. It tries to account for tuning itself, so it also tries to
> account which command was executed (succesfully) before a tuning is
> necessary and reexecutes it, when it was the APP_CMD. But there are
> still some differences in the tuning code, that are not due to
> handling it in the driver.
>
> If have mainly understand how to remove the 'in driver handling' of
> the tuning and thing I could prepare a patch for that. But the
> differences in the tuning code itself, I do not understand
> completely.
>
> There are two other larger differences that I found during my
> work. One is that drivers/mmc/host/mtk-sd.c has much more features,
> like voltage and clock handling and some support for high speed
> modes. I don't know if these features are required/useful for this
> device. The other thing is the card detect handling. This driver is
> doing the card detect / read only detection on its own, where the in
> tree one just uses some default gpio functions there and I don't know
> weather this must be changed or weather there is a gpio driver for the
> mt7621.
>
> That is all I currently remember. Hope it helps.
>
> Christian

Thanks, it might be.
Other info I have received at
   https://github.com/gnubee-git/GnuBee_Docs/issues/75#issuecomment-4792165=
37

is that there might be something worth examining at

 https://github.com/jonpry/openwrt_mt7688/commit/a85e6d99899f3dc1204cd5bfba=
944e17bfa6178f
 https://github.com/jonpry/openwrt_mt7688/commit/24878467a650d765b747618de1=
a575e79114b764

        A few notes: The MMC driver there is basically the 4.9 mtk-sd
        one with all the patches from maybe 4.17 or 4.18 backported.

and that a diff against current mainline here:

  https://gist.github.com/neheb/3d9e4cbf966f8487114df19b49f28214

might be useful.

I'll look more on the weekend if no-one beats me to it.

NeilBrown


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyj9vMACgkQOeye3VZi
gbl9uw//T8TvVvBZcQDNAc3yhA1CH8HEaAwQZyCAbEygEYfhgHAlIY3Nn9FG/Gkc
rqko1qUF+82KWYSWWoipLkwQefzUdCsUScfk0LNZsyYIPPdZBcB1XY8G1lY2Nm/j
KvKJIgbaVp3GYeDztvN+MD28u3nB1ieTVUECKZGhFJ70ulwIjyoCUegZAahLtElW
1VwCYDJvYP04umMOoMkmG/93hjb7Q5b7dKfnCYQUsO/Teq0fHjXJ+UV+N99rQ1Ka
IvAqWgYaD9NavmBjmJKzwH2WkvNk2MoeukEeiPTYxWZtM6V4jDNV07mnmiVlYJ8g
wVJhdhglcOi9CGDPgKlRFfT3Y54ly/9O1KynFdKHaRv4tFjSnCL4dAueGaFjt8a9
xHYm8+675sAVeJVUElo6JMwRKDKdbPZ87EJYzuBITbPMSLeN9V31XWBEP6MyXlAZ
UJBZaiQF2VPVz+S677i+468fRMYTGYjLm/E9IIyyx7D3k89POJL/7j7tn8OVILn4
DgUBxzTQ8hEoNU6rFj1KZKhky8M7b+RYUm+JA9VDRra+TNnYB1fjtxNFbdKBBeyL
2dkIwl3AvDl3pT6+qT8BvyLpZuUitZh3P7NmpuPf+C01k0PunCH7zIbyMUx83y0s
YdZKPjj9N9JwWDJi2LjrGYbAv48koQ3B+5nhtASyqPIL3UpLrCg=
=bJax
-----END PGP SIGNATURE-----
--=-=-=--
