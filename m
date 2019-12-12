Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E52C00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9885C2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfLLR26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:28:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:43434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730114AbfLLR26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:28:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 30906B11E;
        Thu, 12 Dec 2019 17:28:56 +0000 (UTC)
Message-ID: <cf77eec5df92b1845f0bf7cc8eb53edd4af9e1bf.camel@suse.de>
Subject: Re: [PATCH v3] bluetooth: hci_bcm: enable IRQ capability from node
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Guillaume La Roque <glaroque@baylibre.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, khilman@baylibre.com,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Date:   Thu, 12 Dec 2019 18:28:53 +0100
In-Reply-To: <20191211094923.20220-1-glaroque@baylibre.com>
References: <20191211094923.20220-1-glaroque@baylibre.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Z4kIgFWyImQq74xI5plv"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Z4kIgFWyImQq74xI5plv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-12-11 at 10:49 +0100, Guillaume La Roque wrote:
> Actually IRQ can be found from GPIO but all platforms don't support
> gpiod_to_irq, it's the case on amlogic chip.
> so to have possibility to use interrupt mode we need to add interrupts
> field in node and support it in driver.
>=20
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  drivers/bluetooth/hci_bcm.c | 3 +++
>  1 file changed, 3 insertions(+)

This triggers the following panic on Raspberry Pi 4:

[    6.634507] Unable to handle kernel NULL pointer dereference at virtual
address 0000000000000018
[    6.643486] Mem abort info:
[    6.646350]   ESR =3D 0x96000004
[    6.649466]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    6.654873]   SET =3D 0, FnV =3D 0
[    6.657977]   EA =3D 0, S1PTW =3D 0
[    6.661201] Data abort info:
[    6.664135]   ISV =3D 0, ISS =3D 0x00000004
[    6.668042]   CM =3D 0, WnR =3D 0
[    6.671061] user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000f3c83000
[    6.677627] [0000000000000018] pgd=3D0000000000000000
[    6.682595] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    6.688255] Modules linked in: hci_uart brcmutil btqca btbcm cfg80211
bluetooth raspberrypi_cpufreq ecdh_generic ecc rfkill clk_raspberrypi
raspberrypi_hwmon pwm_bcm2835 crct10dif_ce bcm2835_dma i2c_bcm2835 pcie_brc=
mstb
ip_tables x_tables ipv6 nf_defrag_ipv6
[    6.711519] CPU: 3 PID: 39 Comm: kworker/u8:1 Not tainted 5.5.0-rc1-next=
-
20191212-00009-geb500fec1e34-dirty #26
[    6.721771] Hardware name: Raspberry Pi 4 Model B Rev 1.1 (DT)
[    6.727709] Workqueue: events_unbound async_run_entry_fn
[    6.733105] pstate: a0000005 (NzCv daif -PAN -UAO)
[    6.737971] pc : platform_get_irq_optional+0xa4/0x260
[    6.743099] lr : platform_get_irq_optional+0x6c/0x260
[    6.748226] sp : ffff8000101b3c20
[    6.751586] x29: ffff8000101b3c20 x28: ffffd4bd4a957000
[    6.756980] x27: ffff0000f6c0c070 x26: ffff0000f6c0c020
[    6.762373] x25: 0000000000000000 x24: 0000000000000000
[    6.767767] x23: ffff0000f6238c00 x22: ffffd4bd4a241a38
[    6.773159] x21: ffffd4bd49e95838 x20: ffff0000f6238bf0
[    6.778552] x19: 0000000000000000 x18: 0000000000000010
[    6.783944] x17: 0000000000000000 x16: ffffd4bd497117a8
[    6.789337] x15: ffff0000f6fc0470 x14: 0720072007200720
[    6.794730] x13: 0720072007200720 x12: 0720072007200720
[    6.800123] x11: 0720072007200720 x10: 0720072007200720
[    6.805516] x9 : 0720072007200720 x8 : 0720072007200720
[    6.810913] x7 : ffffd4bd496ad210 x6 : 000000000000017d
[    6.810922] x5 : 0000000000000000 x4 : ffff0000fb7fa1b0
[    6.821713] x3 : 00000000f6238800 x2 : 0000000000000000
[    6.821716] x1 : 0000000000000000 x0 : 0000000000000000
[    6.821720] Call trace:
[    6.821730]  platform_get_irq_optional+0xa4/0x260
[    6.839768]  platform_get_irq+0x1c/0x58
[    6.839792]  bcm_serdev_probe+0x40/0x138 [hci_uart]
[    6.839805]  serdev_drv_probe+0x34/0x70
[    6.852544]  really_probe+0xd8/0x428
[    6.852546]  driver_probe_device+0xdc/0x130
[    6.852549]  __driver_attach_async_helper+0xa8/0xb0
[    6.852558]  async_run_entry_fn+0x40/0x1a0
[    6.869534]  process_one_work+0x19c/0x320
[    6.869537]  worker_thread+0x48/0x420
[    6.877319]  kthread+0xf0/0x120
[    6.877324]  ret_from_fork+0x10/0x18
[    6.877330] Code: 17ffffef f9419293 937a7c02 8b020273 (f9400e62)
[    6.890329] ---[ end trace 3ebb39e57973e0b7 ]---

>=20
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index f8f5c593a05c..9f52d57c56de 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -1409,6 +1409,7 @@ static int bcm_serdev_probe(struct serdev_device
> *serdev)
>  {
>  	struct bcm_device *bcmdev;
>  	const struct bcm_device_data *data;
> +	struct platform_device *pdev;
>  	int err;
> =20
>  	bcmdev =3D devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNEL);
> @@ -1421,6 +1422,8 @@ static int bcm_serdev_probe(struct serdev_device
> *serdev)
>  #endif
>  	bcmdev->serdev_hu.serdev =3D serdev;
>  	serdev_device_set_drvdata(serdev, bcmdev);
> +	pdev =3D to_platform_device(bcmdev->dev);

Ultimately bcmdev->dev here comes from a serdev device not a platform devic=
e,
right?

> +	bcmdev->irq =3D platform_get_irq(pdev, 0);
> =20
>  	/* Initialize routing field to an unused value */
>  	bcmdev->pcm_int_params[0] =3D 0xff;

Regards,
Nicolas


--=-Z4kIgFWyImQq74xI5plv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3yeNUACgkQlfZmHno8
x/4v6AgAk3WeE4hzmCOiKm5HgGoC4H9YbcSS6pHN/nIdgPZvgs4lM5Kpk18xnpsl
GyjXSy19ZWtj9ufT2JG/bSagHzn+ahHjuM2wo71b+4lmDZ+PFlY049LyHw0unmYP
uSvQaD6SV67vV9hBqFpnJnxpDWJylPwDh0sS2Ch5D2O+THNxlkK9J/8ZYX+bsTjg
mFXSu1y2h6uPzlcGuRxKmwsgIz03DjS02W7eLqhUC/bALo5s/QMFfO1pc8amjBAX
+V4iQHGtRAr6Sdf+HZibn5UkuQWpQDowTo61VyL51le1LGEMHWlPx7JOwwir6AKl
oZj0Om024+71HxKW3wxtq3Xk6NJsTg==
=NemX
-----END PGP SIGNATURE-----

--=-Z4kIgFWyImQq74xI5plv--

