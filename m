Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6821C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF2A206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560847537;
	bh=WmgpBieHSkxsaMS3Y22VhOIhpsw+Zh5JsSb+CdXH8U8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=19itiUjAVvXuNO7l1ip4SZsSIpv91LlVfJRY9b3EANFuEvuxRCOt6dbMVdZprwlXE
	 mj9qKPaS4lT7EfuDzKmmx3RFRlZuJ65ufVjIno9JOiWR99ZaQjpS1T8t5cmNqdL0Pf
	 eECyUDdeaDQ+FLyTX0n2QJjqqvCpk5STU4qnXvC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfFRIpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:45:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:36491 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbfFRIpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:45:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 01:45:35 -0700
X-ExtLoop1: 1
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2019 01:45:33 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        James Grant <james.grant@jci.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: udc: lpc32xx: allocate descriptor with GFP_ATOMIC
In-Reply-To: <20190618074633.GC23549@piout.net>
References: <20190510124248.2430-1-alexandre.belloni@bootlin.com> <87zhmffiui.fsf@linux.intel.com> <20190618074633.GC23549@piout.net>
Date:   Tue, 18 Jun 2019 11:45:29 +0300
Message-ID: <87tvcnffiu.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Alexandre Belloni <alexandre.belloni@bootlin.com> writes:
> Hi,
>
> On 18/06/2019 10:33:41+0300, Felipe Balbi wrote:
>> Alexandre Belloni <alexandre.belloni@bootlin.com> writes:
>>=20
>> > Gadget drivers may queue request in interrupt context. This would lead=
 to
>> > a descriptor allocation in that context. In that case we would hit
>> > BUG_ON(in_interrupt()) in __get_vm_area_node.
>> >
>> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> > ---
>> >  drivers/usb/gadget/udc/lpc32xx_udc.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget=
/udc/lpc32xx_udc.c
>> > index d8f1c60793ed..b706d9c85a35 100644
>> > --- a/drivers/usb/gadget/udc/lpc32xx_udc.c
>> > +++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
>> > @@ -938,7 +938,7 @@ static struct lpc32xx_usbd_dd_gad *udc_dd_alloc(st=
ruct lpc32xx_udc *udc)
>> >  	struct lpc32xx_usbd_dd_gad	*dd;
>> >=20=20
>> >  	dd =3D (struct lpc32xx_usbd_dd_gad *) dma_pool_alloc(
>> > -			udc->dd_cache, (GFP_KERNEL | GFP_DMA), &dma);
>> > +			udc->dd_cache, (GFP_ATOMIC | GFP_DMA), &dma);
>>=20
>> doesn't apply:
>>=20
>> checking file drivers/usb/gadget/udc/lpc32xx_udc.c
>> Hunk #1 FAILED at 938.
>>=20
>
> You already applied it for v5.2-rc5

d'oh!

Guess I haven't looked at my inbox in a while :-p

thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl0IpKkACgkQzL64meEa
mQYO4RAAitET6cBuDxzFobV4YHrYjjF73rGS7yNKbAtd+M+GXQ8pNAoxCtlGal7l
q4b49b11QVDgEKuXse4fKPkywviIDJdjkpzt0nO4/MLiMj3+3KRHlgazy5fMdJa2
Z9qkf8mSXR6VA2jrSbQRDwl1TcVZYj8cGivfsXGoX4PkNyplprXnphPpnaMEIfwq
97SEYUb7XnoUeMLcvxqGdCJRsuC5qaTuwmfjVeO4g7MHw2t6qc+ApAmLw4D2MfHj
td6eDfgyzhFDfm+qVQ74G/wYAVghNx5x7+MpUhDKCUX/VmcpWE9jodOQCzBTJEgM
BINzvBgdN/X/lu9S6aKkmEboRERbMUyub6JB5kZIWJF6wM8RfOA9izTb20eNkB+4
2koU6Pjl3C044HM0WR/MFK+TlMSOm+bGdXASCgMt2VwqsSqP3KPhLDwnKMVRyJyA
8y5xM3H/Tn5rxHqWIWzwX/hTo2bA+WyL5SM21K+BEXaJE4gbCiR8oUJG8ZHkbgi9
b/Ptky/Ss37Jbsjq5Sn2srSmDV3SGH4YNGoiZIfxrGgyRY4UqJgmgs1Y0KnJP0YA
BixOhFb1Vnub7jkhgNtQ7iilO2gpY6hptmrdbV/LRQqkSfKgzh9dtFp2IecZ34Zf
oL3TsbxVuhm/Wmf3sujdRsScVH0CjjKwpl2iV4Hr3k4mXTqGjNU=
=KroP
-----END PGP SIGNATURE-----
--=-=-=--
