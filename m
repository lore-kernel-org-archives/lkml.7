Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60A0C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5FD20645
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfDOMN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:13:28 -0400
Received: from sauhun.de ([88.99.104.3]:41226 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbfDOMN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:13:26 -0400
Received: from localhost (p54B331F8.dip0.t-ipconnect.de [84.179.49.248])
        by pokefinder.org (Postfix) with ESMTPSA id B023D2C0114;
        Mon, 15 Apr 2019 14:13:23 +0200 (CEST)
Date:   Mon, 15 Apr 2019 14:13:23 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH] axxia-i2c: use auto cmd for last message
Message-ID: <20190415121323.grku4l66bq5xsk4u@ninjato>
References: <20190328111858.GA17086@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7mxb4uywimzggudx"
Content-Disposition: inline
In-Reply-To: <20190328111858.GA17086@localhost.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7mxb4uywimzggudx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2019 at 11:19:45AM +0000, Adamski, Krzysztof (Nokia - PL/Wr=
oclaw) wrote:
> Some recent commits to this driver were trying to make sure the TSS
> interrupt is not generated on busy system due to 25ms timer expiring
> between commands. It can still happen, however if STOP command is not
> issued on time at the end of the transmission. If wait_for_completion in
> axxia_i2c_xfer_msg() would not return after 25ms of getting an
> interrupt, TSS will be generated and idev->err_msg will be set to
> -ETIMEDOUT which will be returned from the axxia_i2c_xfer_msg(), even
> though the transfer did actually succeed (STOP is automatically issued
> when TSS triggers).
>=20
> Fortunately, apart from already used manual and sequence commands, the
> controller also has so called auto command. It works just like manual
> mode but it but an automatic STOP is issued when either transfer length
> is met or NAK is received from slave device.
>=20
> This patch changes the axxia_i2c_xfer_msg() function so that auto
> command is used for last message in transaction letting hardware manage
> issuing STOP. TSS is disabled just after command transferring last
> message finishes. Auto command, just like sequence, ends with SS
> interrupt instead of SNS so handling of both had to be unified.
>=20
> The axxia_i2c_stop() is no longer needed as the transfer can only end
> with following conditions:
> - fully successful - then last message was send by AUTO command and STOP
>   was issued automatically
> - NAK received - STOP is issued automatically by controller
> - arbitration lost - STOP should not be issued as we don't control the
>   bus
> - IP interrupt received - this is sent when transfer length is set to 0
>   for auto/sequence command. The check for that is done before START is
>   send so no STOP is required
> - TSS received between commands - STOP is issued by the controller
>=20
> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Changed $subject to "i2c: axxia:" and applied to for-next, thanks!


--7mxb4uywimzggudx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly0dV8ACgkQFA3kzBSg
Kbaxcw/7BbpKmWB8GVSwSy6KqHl4w1Fa4yxtsCJIAKdn2Qx/fLfAbipovVoYOk2G
rh4F15GFBo7NoJ3o/p4MEvbBsNYVBbVTgGuI5ggLOKgPFtrir9BiVO2yRMi/9fSX
Ms+uWze1Uxocqy+q1YIuDnJmNmkU/H5fy1FOMz6L11QLXJdAxdx+/Yr0yGjUMcQX
Ga91sMN8MRU22PgJiTdSeTmTuWBlXl95v/oPfdBuCIpvY/ULUt4zhbMcjzN8DhtQ
4UBRDAz8jD9nIAkKXJENB1SqH99GQbPNk3AhYlxZbQnx6SLES7OVVaPhUXyzhsIs
yu2jYtN6h8mqU2xlNFo1xZAy6k1Uq6tSUVKXfr01yMEOMMXzHEVpFuiXoJZJhf1L
M1WkyXaZX4xRw9a2/THzSOSAWfQ/XkaAt0Wa04tUYDAr8ZrqOGRf2bFpsoxmzJPR
Cz4DgOId2f5MhqflmQ31XOJRM4Na/TYMiPljPXrT72Qye3ngeU/KCFrErssLkmVE
iOOPG7kuYhjX68knNpSIfj0LfN/Zgn3qI/3XDMkDrhmESsE9kxDT8+IBEtCKy5Fz
U/WIiyodb43TYbVkkXOpH0XyJ+DZUN7gzrfJhc+30EKcUexavr7IOKs995/7hiq0
aZUz+Zo32H58IuptsnwS1W1FpuRlio4bNhrQSZD0koLsmCvMcbg=
=FdeM
-----END PGP SIGNATURE-----

--7mxb4uywimzggudx--
