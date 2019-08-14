Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30D7C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8351120679
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565787989;
	bh=d/Hxf3vmPYsdj6m+7b/zR0Tc7ldEmzN9HwYhQquDtMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=QREacyJZjKoPHwhdXcPiKbuSI4XHR+rWzCXwhDX/CasrcCTKbv46Y+IVStBXpPQ+5
	 d8Ef1Cto1SY4CUSnNrP8QfBadryMPFvcSyuWVL81HmhW5YqQeif7JIM5hwhSIZS21X
	 iSM2I1+ThsGN0SmrrtilIpwzRfMMgQBAqZng31Z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfHNNG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:06:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:1678 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfHNNG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:06:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 06:06:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,385,1559545200"; 
   d="asc'?scan'208";a="328044176"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga004.jf.intel.com with ESMTP; 14 Aug 2019 06:06:08 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Vicente Bergas <vicencb@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: kexec on rk3399
In-Reply-To: <c6993a1e-6fc2-44ab-b59e-152142e2ff4d@gmail.com>
References: <ebcb52be-2063-4e2c-9a09-fdcacb94f855@gmail.com> <c6993a1e-6fc2-44ab-b59e-152142e2ff4d@gmail.com>
Date:   Wed, 14 Aug 2019 16:06:04 +0300
Message-ID: <87v9uzaocj.fsf@gmail.com>
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

Vicente Bergas <vicencb@gmail.com> writes:
> On Monday, July 22, 2019 4:31:27 PM CEST, Vicente Bergas wrote:
>> Hi, i have been running linux on rk3399 booted with kexec fine until 5.2
>> From 5.2 onwards, there are memory corruption issues as reported here:
>> http://lkml.iu.edu/hypermail/linux/kernel/1906.2/07211.html
>> kexec has been identified as the principal reason for the issues.
>>
>> It turns out that kexec has never worked reliably on this platform,
>> i was just lucky until recently.
>>
>> Please, can you provide some directions on how to debug the issue?
>
> Thank you all for your suggestions on where the issue could be.
>
> It seems that it was the USB driver.
> Now using v5.2.8 booted with kexec from v5.2.8 with a workaround and
> so far so good. It is being tested on the Sapphire board.
>
> The workaround is:
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -133,6 +133,13 @@
>  	return 0;
>  }
>=20=20
> +static void dwc3_of_simple_shutdown(struct platform_device *pdev)
> +{
> +	struct dwc3_of_simple *simple =3D platform_get_drvdata(pdev);
> +
> +	reset_control_assert(simple->resets);
> +}
> +
>  static int __maybe_unused dwc3_of_simple_runtime_suspend(struct device=20
> *dev)
>  {
>  	struct dwc3_of_simple	*simple =3D dev_get_drvdata(dev);
> @@ -190,6 +197,7 @@
>  static struct platform_driver dwc3_of_simple_driver =3D {
>  	.probe		=3D dwc3_of_simple_probe,
>  	.remove		=3D dwc3_of_simple_remove,
> +	.shutdown	=3D dwc3_of_simple_shutdown,
>  	.driver		=3D {
>  		.name	=3D "dwc3-of-simple",
>  		.of_match_table =3D of_dwc3_simple_match,
>
> If this patch is OK after review i can resubmit it as a pull request.

not a pull request, just send a patch using git send-email

> Should a similar change be applied to drivers/usb/dwc3/core.c ?

Is it necessary? We haven't had any bug reports regarding that. Also, if
we have reset control support in the core driver, why do we need it in
of_simple? Seems like of_simple could just rely on what core does.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl1UBzwACgkQzL64meEa
mQYOVQ//eKd2UVl0Lk/iBF9be4Qe4UnhUTXChWgQRk4zD9Xvjfgx16lvKHRd202Y
tDKEYXDrOeSfQZTopKUfO8d3vjPkxfqYMeLyiiXTA983oXVwc6ZeaE6+VA3AO9m1
nWdQthWGnpSiBaXhceBgMmAaKkvuFe/dDua9OhGkLz/aOYFQ5iLEVT/Ffkj8sr5g
u9oXIq/Vs49XFoymk8s+9qGip9l3ZbQNEkUkJbL4+hw83IiFR5SWtGG7kf/Uv/bI
sA6JUkcTDvOXkqI/9cSk9ZeCePbOQpu5lk9C5B78//hdDNpkopJ8OeIW6YOBh5HF
HIOZzyBgWjXu6fRM1XiqoRjWZvfpv/76CGml0zNKdDs5bvN4tbcUoJtf655JWdav
S+0cEGfvLMsh5UiFcsBTT63S7+/Gh/d8Z/m3JsgSw9i0TBZLhbGQ36SYX+RpNSrr
LNZsCbl67wc12ftHZOJaUTsdHy6MU4O5nf5vlSFTJCkRJtNKV65hODulCRMiTdkh
kgyjs98yUegt2siGNHbVg8LC14GjWQaAxRLB7BN4pCx4243vmpapRRWjHG63f2Jh
VZvYCB8hj5MBy+2BZ5S94siSoMS6+qaZ8DQ2L065EwdrlKLly4Rofh0FNhtbL5I5
F5P6V1xEnd0TN75wevzsI57lsNB2Cov8WoSeFQ0D7OSrS6eN38s=
=9b3X
-----END PGP SIGNATURE-----
--=-=-=--
