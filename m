Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847EBC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554F820663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DJ6YaoPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfLLLqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:46:07 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:33691 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726492AbfLLLqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:46:06 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id BA1B3725;
        Thu, 12 Dec 2019 06:46:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 12 Dec 2019 06:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ol6RFW
        OIya20JlX27c+UNzAio0bqaxzpviWh9kgvntk=; b=DJ6YaoPVWBLH9EEVX9M3nl
        vfkaWhkcS2rur+gAlk5xib9TIW3fmqG6zrLqaxS9hUgnRlm1EYzMyMGdmI0j3qc7
        7J7PlEnw43gLOuXw+MA3o1JhEsgz3yZ/Dmk28dytHyB3e6oEu1YwXJZZfdWAC8Sk
        I8Uaqw1McwM+wDSJmJCb9Bzg7wbhakAX/1cEggCX2Z+1D9iy5AGikL/bVi1kFt6X
        kVMusyPqV7xISsjTBU1QgAoiCswm5+VEv3Rjs5Zl3AObQA/NT+XHXyFfiEiNYq+M
        E7sG528MDORuTIRQoy47HU+vWOMgyw5p+nesS1WGcc533oWVq8KGKSC8SLFv5wng
        ==
X-ME-Sender: <xms:fCjyXVhT38A60yl56bzcPmJ0Pm_1zcvVYvsVweVdMPdVcVFVuZ4r3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeljedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucfkphepledurdeihedrfeegrdef
    feenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslh
    gvthhhihhnghhslhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:fCjyXQeu4fJb78qZjQ-MgGvc0yTc7mv1Uym0BXewvvrTH7dcafIoBw>
    <xmx:fCjyXSkX9HZGrOdrMpCPmxFzUdPAZ5SjgQyOlEJE1i5tPq6PFN_3NA>
    <xmx:fCjyXSrAQlmxHNpeMew9dUyAqHw66-S8HK3FECeeT95qyhMQGSZ5WQ>
    <xmx:fCjyXZiELqMSNaWzBNwmVM3tb8uS-9f7LHVsLf-JcCBaIoOEBpVbvw>
Received: from mail-itl (ip5b412221.dynamic.kabel-deutschland.de [91.65.34.33])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2AF1F80059;
        Thu, 12 Dec 2019 06:46:03 -0500 (EST)
Date:   Thu, 12 Dec 2019 12:45:59 +0100
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usbip: Fix receive error in vhci-hcd when using
 scatter-gather
Message-ID: <20191212114559.GW11116@mail-itl>
References: <20191212052841.6734-1-suwan.kim027@gmail.com>
 <20191212052841.6734-2-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R7Dyui215VKdTDYA"
Content-Disposition: inline
In-Reply-To: <20191212052841.6734-2-suwan.kim027@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R7Dyui215VKdTDYA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] usbip: Fix receive error in vhci-hcd when using
 scatter-gather

On Thu, Dec 12, 2019 at 02:28:40PM +0900, Suwan Kim wrote:
> When vhci uses SG and receives data whose size is smaller than SG
> buffer size, it tries to receive more data even if it acutally
> receives all the data from the server. If then, it erroneously adds
> error event and triggers connection shutdown.
>=20
> vhci-hcd should check if it received all the data even if there are
> more SG entries left. So, check if it receivces all the data from
> the server in for_each_sg() loop.
>=20
> Fixes: ea44d190764b ("usbip: Implement SG support to vhci-hcd and stub dr=
iver")
> Reported-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab=
=2Ecom>
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>

Tested-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab.com>

> ---
>  drivers/usb/usbip/usbip_common.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_c=
ommon.c
> index 6532d68e8808..e4b96674c405 100644
> --- a/drivers/usb/usbip/usbip_common.c
> +++ b/drivers/usb/usbip/usbip_common.c
> @@ -727,6 +727,9 @@ int usbip_recv_xbuff(struct usbip_device *ud, struct =
urb *urb)
> =20
>  			copy -=3D recv;
>  			ret +=3D recv;
> +
> +			if (!copy)
> +				break;
>  		}
> =20
>  		if (ret !=3D size)

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--R7Dyui215VKdTDYA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl3yKHgACgkQ24/THMrX
1ywSWwf/aXnourZh6+z8Levd5Q3SYBwIJXKYM9bNFOW1KwgCtYhhjVKYKVpkMh0v
dsn9QNc3Is5A0bp+zfgsqskyDLCJYbtT7nq5UIdSd4xKID0oa6nlz1ODmgfducTI
HTJ3jCyYoscaJZhCBkMSv0hcnoJQMAta+yr9qZJkYh/E5LnA5yErl8o6juSJ+E7g
624+4ZHwgYIopr+fFSyD51c42dhrciu4j2C6URNhhJRMVqann/jvQZHT6eaBWfzt
Uz0o3vfRLg5rBoU7luV2tTqPJOCve7Q+/CGUdawOIqRXs1FqnePq46r9T3VS5T3u
0rWwX0nGquiKG6pYh/myHMobV2JuCA==
=UnQt
-----END PGP SIGNATURE-----

--R7Dyui215VKdTDYA--
