Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B77C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E292075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfFEH2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:28:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:29838 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfFEH2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:28:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 00:28:47 -0700
X-ExtLoop1: 1
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga006.jf.intel.com with ESMTP; 05 Jun 2019 00:28:44 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] USB: move usb debugfs directory creation to the usb common core
In-Reply-To: <20190604124349.GA10203@kroah.com>
References: <20190604093258.GB30054@kroah.com> <87tvd5illh.fsf@linux.intel.com> <20190604124349.GA10203@kroah.com>
Date:   Wed, 05 Jun 2019 10:28:12 +0300
Message-ID: <871s08ebjn.fsf@linux.intel.com>
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

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> > diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
>> > index 7fcb9f782931..f3d6b1ab80cb 100644
>> > --- a/drivers/usb/core/usb.c
>> > +++ b/drivers/usb/core/usb.c
>> > @@ -1185,19 +1185,17 @@ static struct notifier_block usb_bus_nb =3D {
>> >  	.notifier_call =3D usb_bus_notify,
>> >  };
>> >=20=20
>> > -struct dentry *usb_debug_root;
>> > -EXPORT_SYMBOL_GPL(usb_debug_root);
>> > +static struct dentry *usb_devices_root;
>> >=20=20
>> >  static void usb_debugfs_init(void)
>> >  {
>> > -	usb_debug_root =3D debugfs_create_dir("usb", NULL);
>> > -	debugfs_create_file("devices", 0444, usb_debug_root, NULL,
>> > -			    &usbfs_devices_fops);
>> > +	usb_devices_root =3D debugfs_create_file("devices", 0444, usb_debug_=
root,
>>=20
>> don't we have a race now? Can usbcore ever probe before usb common?
>
> How can that happen if usb_debug_root is in usb common?  The module
> loader will not let that happen.  Or it shouldn't :)

argh, indeed. The very fact that usbcore tries to resolve usb_debug_root
already forces a dependency :-p

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlz3bwwACgkQzL64meEa
mQYjnQ/9ERfLIDtB7Gh0eaevRNVrN6PGvd94Q4mu7LJ5qDfm/+UbfGucwDeINNVH
CggpHymmca0HA3+OsdoUDf5x15oMPauyDulSrIK2Ldbvdupvq7MOsODxm0il0kO2
ItTKb7gdV7k1oULdemrz3ONNTyB6glyAA1ed+6w0bbK88ZEmg1+el8ZHNA2w78Kx
UnA5uHAa9P2eJ3fDDOw895EqD/NnZLO0hWVxEN+TvHc/iKI7afjejdwPgjcjF1f2
yVeZXyJcMglpCc5zrzRPLzSBy3ysn99tQFWkuPUiDIaV8f795Zgb0m16YFjUCfZt
/u3K71bO3b0rKgSsJgmuMFw8dZaf2Cz54uXvHY3tw2EBtSbQ1aMlRXJZjt2MXRJB
zmyejHBzTC0zQVWsJpZZmL+dNXaIcSH/NU12CVzlo5F36vmbQ/lyfiEbvnfh/t7H
VnliozWmqZxUI676WvFL/tRVsVLw6TtOLcD4ZRveIX6iUstun++SuKLw/tAj+jex
2O04C/yPRCoerZ7HiWT6kBfcZlQsMua4BhM7jB0mdp3P3ReyqSsnUrRbE8/b1BEv
aKm/SCbUdGo09YakAsVT2gRosjH6Aygd9NqsO+uyRCaA/sSvSit6wKNhQsC2apK2
S7C3MnT6a8w1pyZ8kA3Fl3+VYub8N5Z22op6YYVM7FHS+Smtlpw=
=88ax
-----END PGP SIGNATURE-----
--=-=-=--
