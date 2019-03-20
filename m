Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113B9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD80721850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553064703;
	bh=pEP+uwho+aStzHT22KI3MKPcLtQjhkJKc67s0wJtjS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=e7viIiZ16ZVJN33bbiKXCK1aiuubW1/GAAKagXQoLCevw5b/qTO40tPJK1SXbzgVt
	 eeoJSl9uCGYVUyGaPfSbxaY0tfEYaVK9D06e9sLUuL2/IKp+ZcbJdR67BFNe5Yw05x
	 HObJZqt8JWfpb943V1RFtrvmimQE34jshg1H8rGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfCTGvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 02:51:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:28767 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbfCTGvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 02:51:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 23:51:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,248,1549958400"; 
   d="asc'?scan'208";a="124166464"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga007.jf.intel.com with ESMTP; 19 Mar 2019 23:51:39 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/5] reset: Add acquired flag to of_reset_control_array_get()
In-Reply-To: <1553013476.6482.6.camel@pengutronix.de>
References: <20190221152557.8534-1-thierry.reding@gmail.com> <20190221152557.8534-2-thierry.reding@gmail.com> <1553013476.6482.6.camel@pengutronix.de>
Date:   Wed, 20 Mar 2019 08:51:34 +0200
Message-ID: <87tvfyujgp.fsf@linux.intel.com>
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

Philipp Zabel <p.zabel@pengutronix.de> writes:

> On Thu, 2019-02-21 at 16:25 +0100, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>=20
>> In order to be able to request an array of reset controls in acquired or
>> released mode, add the acquired flag to of_reset_control_array_get() and
>> pass the flag to subsequent calls of __of_reset_control_get().
>>=20
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>>  drivers/reset/core.c              |  9 ++++++---
>>  drivers/usb/dwc3/dwc3-of-simple.c |  3 ++-
>>  include/linux/reset.h             | 14 ++++++++------
>>  3 files changed, 16 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
>> index 1e8a42b16f23..f94da91c22af 100644
>> --- a/drivers/reset/core.c
>> +++ b/drivers/reset/core.c
>> @@ -830,12 +830,15 @@ static int of_reset_control_get_count(struct devic=
e_node *node)
>>   * @np: device node for the device that requests the reset controls arr=
ay
>>   * @shared: whether reset controls are shared or not
>>   * @optional: whether it is optional to get the reset controls
>> + * @acquired: only one reset control may be acquired for a given contro=
ller
>> + *            and ID
>>   *
>>   * Returns pointer to allocated reset_control_array on success or
>>   * error on failure
>>   */
>>  struct reset_control *
>> -of_reset_control_array_get(struct device_node *np, bool shared, bool op=
tional)
>> +of_reset_control_array_get(struct device_node *np, bool shared, bool op=
tional,
>> +			   bool acquired)
>>  {
>>  	struct reset_control_array *resets;
>>  	struct reset_control *rstc;
>> @@ -851,7 +854,7 @@ of_reset_control_array_get(struct device_node *np, b=
ool shared, bool optional)
>>=20=20
>>  	for (i =3D 0; i < num; i++) {
>>  		rstc =3D __of_reset_control_get(np, NULL, i, shared, optional,
>> -					      true);
>> +					      acquired);
>>  		if (IS_ERR(rstc))
>>  			goto err_rst;
>>  		resets->rstc[i] =3D rstc;
>> @@ -898,7 +901,7 @@ devm_reset_control_array_get(struct device *dev, boo=
l shared, bool optional)
>>  	if (!devres)
>>  		return ERR_PTR(-ENOMEM);
>>=20=20
>> -	rstc =3D of_reset_control_array_get(dev->of_node, shared, optional);
>> +	rstc =3D of_reset_control_array_get(dev->of_node, shared, optional, tr=
ue);
>>  	if (IS_ERR(rstc)) {
>>  		devres_free(devres);
>>  		return rstc;
>> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-o=
f-simple.c
>> index 4c2771c5e727..67ce2037472d 100644
>> --- a/drivers/usb/dwc3/dwc3-of-simple.c
>> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
>> @@ -107,7 +107,8 @@ static int dwc3_of_simple_probe(struct platform_devi=
ce *pdev)
>>  		simple->pulse_resets =3D true;
>>  	}
>>=20=20
>> -	simple->resets =3D of_reset_control_array_get(np, shared_resets, true);
>> +	simple->resets =3D of_reset_control_array_get(np, shared_resets, true,
>> +						    true);
>
> Felipe, could I get your acked-by to merge this through the reset tree?
>
> dwc3-of-simple is a bit of a special case because it calls
> of_reset_control_array_get directly instead of through the
> of_reset_control_array_get_shared/exclusive wrappers.

Sure thing:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlyR4vYACgkQzL64meEa
mQZ9Kw/+I1IrdMF3FmYc9NjB4bNdvHKB258C5wIFM4ypdDdQCA0KO07hw0qnJlwM
tVZ+n6fWSkH1bjRFULVFmejpflOWav8PirMepFIt5Arn0CJSSOwW7NLyfjy/fFT9
sZy1vlDPnim/EbVCVhc5VJiHNeofs8o1EXAmxJAPAot2PEBbsbcfIDfdMXxMgskm
9To/jMd1OW5p+EugOicpIPz3lzZdPHu9MzmVXc294oS7/To2xO/kCnvDckfG7sk/
oyylqx79LolmI4f4j0XkX2Poz7NTXYjbM88qpoDWX1phntVd6WGi4Sjhe2Vgu7e9
6oabn/3Ws/+lWZM38hloiWxowS2o0ZwxLnGL7R22HUlmlatahz5lOUrNqLvFDvTI
Du0B4obhZTfkG9AS5sq/hFIGiIqyFCs1D4OBnBuooF/tf73K48p1Mv1YryPIRIfu
5vZCNNEyMB2iRIOfSow5etSPZgijEXH50AgQZg3aDViLBZQDKqWFFYjc0RioxaC1
lzAK7QmlIMdlrsP3fl65jj/WPrg6el1/3oM4lyThDVOr3Tdllk3nUiyTRPwew87d
zdZPgQKXV93xvJ3SbwXJ78wQI3ZwrsXxaxbijI/g3BDbd25ivWTRffx7dYet3LoK
qVo5EsdILA5nntmGqfNM6umJwqB4kLyIA31p5bYtI+fDXomDDCA=
=gvkl
-----END PGP SIGNATURE-----
--=-=-=--
