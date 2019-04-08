Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C05C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664DC20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfDHUXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:23:07 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:32896 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726220AbfDHUXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:23:06 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hDanF-0007wT-Ds; Mon, 08 Apr 2019 21:23:01 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hDanF-0000Zf-8e; Mon, 08 Apr 2019 21:23:01 +0100
Message-ID: <a5f9b02fbb5ca830e598f1c601cdbecc6c86b789.camel@decadent.org.uk>
Subject: Re: [PATCH 4.20 105/171] net: stmmac: Send TSO packets always from
 Queue 0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     stable@vger.kernel.org, Joao Pinto <jpinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>
Date:   Mon, 08 Apr 2019 21:22:56 +0100
In-Reply-To: <20190312170357.090790506@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
         <20190312170357.090790506@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-7AnsONg7HgzCu3gBLO7C"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7AnsONg7HgzCu3gBLO7C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-03-12 at 10:08 -0700, Greg Kroah-Hartman wrote:
> 4.20-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> [ Upstream commit c5acdbee22a1b200dde07effd26fd1f649e9ab8a ]
>=20
> The number of TSO enabled channels in HW can be different than the
> number of total channels. There is no way to determined, at runtime, the
> number of TSO capable channels and its safe to assume that if TSO is
> enabled then at least channel 0 will be TSO capable.
>=20
> Lets always send TSO packets from Queue 0.
>=20
> Signed-off-by: Jose Abreu <joabreu@synopsys.com>
> Cc: Joao Pinto <jpinto@synopsys.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 5d83d6a7694b..f76f6ae3fa87 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3033,8 +3033,17 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb=
, struct net_device *dev)
> =20
>  	/* Manage oversized TCP frames for GMAC4 device */
>  	if (skb_is_gso(skb) && priv->tso) {
> -		if (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))
> +		if (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
> +			/*
> +			 * There is no way to determine the number of TSO
> +			 * capable Queues. Let's use always the Queue 0
> +			 * because if TSO is supported then at least this
> +			 * one will be capable.
> +			 */
> +			skb_set_queue_mapping(skb, 0);

This is the wrong place to change the queue mapping.  stmmac_xmit() is
called with a specific TX queue locked, and accessing a different TX
queue results in a data race for all of that queue's state.

I think this commit should be reverted upstream and in all stable
branches.  Instead, the driver should implement the ndo_select_queue
operation and override the queue mapping there.

Ben.

>  			return stmmac_tso_xmit(skb, dev);
> +		}
>  	}
> =20
>  	if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 1)) {
--=20
Ben Hutchings
If God had intended Man to program,
we'd have been born with serial I/O ports.



--=-7AnsONg7HgzCu3gBLO7C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlyrraAACgkQ57/I7JWG
EQlSghAAtNTFtJGk70VifBk2xjB/2M1S7xWdw7imGAssV2UQPykbhYMhw/ZOSfSr
l4pbcT+F6I6Un8a3VAdlRXNCaZEuWKg62hayi92J7dHTTiwAa2DqRVvbAcTzjxEs
bYl2LiC8yRLsWRez/frmYKSfWfJ0bXVIXjmgu1d5z7Pl9a4RqA9t+7TqrYg+i+1U
JqminaMj+Nwcf0Hu6OU3UHO4ljTaI7OfYxrrKXT0Wmv+3ttbuIE+mU74amwNEBlg
5pdPLHNv44DYTXGWV0zZyKDfY2LWcJdGwIU7Uln82vjxGqeF4WLqaVvsz8ne4ZoB
+94APhrOweVvf1NX0tTLoPiZJqTKD+Q1xxWYU3fJyT/V2e19PmiqZl9tN7Z0sSjp
8a8UWejMA+KvWWURm7n5Q73WhS0k7+wrFQkJlJMtoEowVeBUU/hlXpIXP+xKZGuW
MHnTVrVDMO/ZADdJxT7GRmpYu8CKDHvrCcjgJNARpVYKSn41AYJ0ADXCD04TCvgt
CVM336vW77sI5lYLSvfvsc427xGyTcAG/YxOjQXsgyqJW56QO0M3U1+lDVGhgE9q
8yfJiHScrKEhMxUYbYElzsNvFgQsMYzewJwtZbDlgNcnUKkmvVeDjyocoGkC/d8V
FiN1OJv4Ca4493IP74/s7QcjQmnZSvHTIrraYG9FpwbXikyY4Zw=
=ztH5
-----END PGP SIGNATURE-----

--=-7AnsONg7HgzCu3gBLO7C--
