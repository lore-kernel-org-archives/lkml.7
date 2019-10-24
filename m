Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DD0CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A2B20684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438496AbfJXIwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:52:16 -0400
Received: from sauhun.de ([88.99.104.3]:37578 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730467AbfJXIwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:52:15 -0400
Received: from localhost (x4e374e90.dyn.telefonica.de [78.55.78.144])
        by pokefinder.org (Postfix) with ESMTPSA id 283C22C011D;
        Thu, 24 Oct 2019 10:52:14 +0200 (CEST)
Date:   Thu, 24 Oct 2019 10:52:13 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Gene Chen <gene.chen.richtek@gmail.com>, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v4] mfd: mt6360: add pmic mt6360 driver
Message-ID: <20191024085212.GB2850@kunai>
References: <1571749359-15752-1-git-send-email-gene.chen.richtek@gmail.com>
 <20191024082623.GK15843@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <20191024082623.GK15843@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> > +	for (i = 0; i < MT6360_SLAVE_MAX; i++) {
> > +		if (mt6360_slave_addr[i] == client->addr) {
> > +			mpd->i2c[i] = client;
> > +			continue;
> > +		}

Not knowing the DT bindings, I wonder if we can let the for-loop start
at 1 and do beforehand:
	mpd->i2c[0] = client;

That would save the above if block. However, this is a minor nit.


> > +		mpd->i2c[i] = i2c_new_dummy(client->adapter,
> > +					    mt6360_slave_addr[i]);

Please use the new API i2c_new_dummy_device here...

> > +		if (!mpd->i2c[i]) {

... and IS_ERR() here.

> > +			dev_err(&client->dev, "new i2c dev [%d] fail\n", i);
> > +			ret = -ENODEV;

Then you can also return a proper errno value.

You can probably also use devm_i2c_new_dummy_device()...


> > +			goto out;
> > +		}
> > +		i2c_set_clientdata(mpd->i2c[i], mpd);
> > +	}
> > +
> > +	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
> > +				   mt6360_devs, ARRAY_SIZE(mt6360_devs), NULL,
> > +				   0, regmap_irq_get_domain(mpd->irq_data));
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "mfd add cells fail\n");
> > +		goto out;
> > +	}
> > +
> > +	return 0;
> > +out:
> > +	while (--i >= 0) {
> > +		if (mpd->i2c[i]->addr == client->addr)
> > +			continue;
> > +		i2c_unregister_device(mpd->i2c[i]);

... to save this ...

> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int mt6360_pmu_remove(struct i2c_client *client)
> > +{
> > +	struct mt6360_pmu_data *mpd = i2c_get_clientdata(client);
> > +	int i;
> > +
> > +	for (i = 0; i < MT6360_SLAVE_MAX; i++) {
> > +		if (mpd->i2c[i]->addr == client->addr)
> > +			continue;
> > +		i2c_unregister_device(mpd->i2c[i]);
> > +	}

... and this. But please double check.


--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl2xZjwACgkQFA3kzBSg
KbbRSQ/+KeAeLPnHYJBgZYJS5bMotybmbaM9VfBSaGUp5IofDuEyobHAph3O4y49
+qLo5KN/PusE8qnTUfTxs5+7ZC4vWwlwkCMOSK/iX74H5jxXlu3aM3hitvMtWqCD
Sq3eqHRtMqw9Q+Qm5LEEIUdhcmSk7ExoDoVrShZImg3ZjqcGTRVB8+JOfI3GrLfl
dEfyRwn5u/epXucr39dP3NCZTgSCCQOIl3bJGLqRn4jDM/K3WaZu4/SwEYTOQy/d
y8MzBZjKJY3xDIl3WIPOVAcw1fz3wrr/Ff3sfGczPR+jEQAac6E5hGDmsdsbvG4G
CqNYEGb9ey96S1wcrYeBnZjMu5lX672L5rNSSXnEp47UlU3zynovqqYDvh8tEcsB
r1nWY54EUzCKm5KNWRGhsEj99O4Ellz0+7ocpOyqeP+7oPviuXee3L1pv0MtHQcc
Cs1IcT07FmGSSOwyUl+f9neOmNDx2RyK4OCGZn3G3dqE5ncuQUbafQR0LnYjCodB
ui3gQw7SnSGAnusmVsJQPaaPHzJ9o39EHO6TzFKXgWMU6CLprEdRmkGIhLZ6YkcD
IgpgVvN7YSgHqulUAAjnjueJ4qP8jdEIqZx6BpnrWH0DthprMWBNPjThEdHO5pUi
2kXCG5sCZbmg9j/H0apIMNXZAgLJggvRjwt5nz9ftT/bL1ZQuas=
=yXdj
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
