Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124EAC47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45F32064A
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="I225Qb0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfJNH1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:27:00 -0400
Received: from mout.web.de ([212.227.15.3]:58813 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730143AbfJNH1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571038003;
        bh=dsoSLnLfGAdxql9MTdroU6khYAI5V0TJYhpARTc++9o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=I225Qb0cFAqHrV2r61VILdB/x2ZEYQscWugSF9nxKyh3QC7BwdV+mHMIl17KG7aid
         hkzZr0u4r839FeAtJSYP+We2uZpQ1HbyEpuhOVh5F4uRbzwS7XED52iXxDho48+73T
         RJreTMn4UXXRK67qnPgraWLPtI0vcbGfXupfhzYM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.26.106]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdalO-1hcZJA3gKw-00iinV; Mon, 14
 Oct 2019 09:26:43 +0200
Subject: Re: clk: rockchip: Checking a kmemdup() call in
 rockchip_clk_register_pll()
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>
References: <e96505a8-b554-f61e-3940-0b9e9c7850ff@web.de>
 <5801053.xxhhKtLrcJ@diego> <29d12079-d888-e090-da5a-c407c13d696b@web.de>
 <2588953.0pqkEXWxhN@phil>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <45588ab8-2a6c-3f29-61ff-bccf8d6fb291@web.de>
Date:   Mon, 14 Oct 2019 09:26:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2588953.0pqkEXWxhN@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5BG8F1ok0Fxurtt6hu8W1VYe91qbGIMXAK9ZSgQht2xBTlxOTVv
 XSxPNLzabBo49c4EaKwCIevFiZSFPpamsyaazaXAQ4MKel3MeZDb7wNHyKnSHZamNGM0dbP
 38oXsXaSvW54M2lEXX+vuPoCFZOIIZ+/bzIp0K7kTula40Mvm0CGHvXa17tXbb/DAWuW8uS
 2p1EkiacCieIXdxj+9kmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:67X0CqQYWOI=:RKCVRgsunpicIqfihEJ85s
 bzYQRGcj7UBenQ4HTZG0hGx5NGnhDm/cBvRQtXNPkMr2TG6G5gqdgsfY+s7ZA2yH51fXfjKnO
 Rw7UB0HonrEeBPEyGxRV1JlWojYOvzmfnkPMtcnfsx3rYtOFsY0t0vRMRYJ9QnYnh0G38SLcY
 JDcaAMtfzldjVmRCnSbH8oJrYRP5ps/HBgdEvM8h//wja5zJgElOebeRAjp0Qrd8gzI0878hK
 gtOClFfAQpZmd0MsBfjvP5QlN38eROVB9yPvW767BpgPC49d+FllO+ienK4HlOG1QE9wwHfL5
 VOht1fXcud7CV1/iOslWyuk+vVprqAbBCdfIJGBzIj8eGUtP6MdczFDle/zH7aLCPpX3+hmpB
 wwx9hdY1JsV2F2iSvS8qn0as7xWvGTG/NCuzBAWEfOu8wPlTEkT7qpI/QPGKVp49yD02UD2XE
 B39zSlyI5XbBvBnltz6v9DlxjKXG/8Hp3pvnmcIOEwo28SVgARM+bVNnIFkScVj4wt7Qs5Fww
 1Yffrl22ycmLKaFNfA9IO73o6BZeHCPhtFy/4irO1Y8aZ1h7w9hW2IXB5MZr6FuBaH2k2LbHq
 VJTO9IWVpPzVOgwYmLXiUSYqK+AZs1H39ZrQRJYaQaKCM/frQKJWcOp/4NgR87vKiZITHurVg
 H2TxhqZHY77gYldDHR/TJPTVmrudN7aICvsycM4z7IgC/NQ1NRFgcD85rTL1LjgnnrRa6I2ct
 oMmqgs835GIHUeDCp+fYV1gpm7N9sHTdkBSouPqV+moTdVHAyTaFr28uYtMQV7zn2b/Y6+mx6
 tgf2UJyfJCDkeofOvPnAPmboiM8vna4pC2RzHEzMALIkl9I4PzXFS0eVOfFaKuzyQXgrMKwCe
 zBMpyglDkwjzf9v5DcSk286qLt4+plqVW/fnHRVHefoacbs7cFdBFyWvJBJaZtSBQHx+MIbrV
 vlnVxiEGzq9khaDEXsCudjwus0SYjpz2lzP5iwW1Xue14ZgM4yVG1AZu0JTW4MXWas0hbtPxO
 ta28GxcefhgCxYcUq6LD2UyBQrZ9uBV8VKpT6GT/ALRaI+FnUGOP1Md9AXDTmXRaLemaXDJ0v
 MwgqmKyNy9lwNyO6FpyvCEkqraobUA1w1jBYAyfP6U+FQcLowi8p1kOSHRcU7UPni1p0+tfZ/
 BLvEIFItGoY69k7bzI/drGma+2ydKpYkjmZJHBLUrzK7+BR30FgKQS9JenvlpUM1BEfIHplSu
 oi4hJZxfFJHPKDmpI4bFw8VpNQWpxjw4i/XSZWf0+8p98fNYGfuskB6lB1IU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The other option would be to panic, but the kernel should not
> panic if other options are available - and continuing with a static
> pll frequency is less invasive in the error case.

I would like to point out that this function implementation contains
the following source code already.

=E2=80=A6
	/* name the actual pll */
	snprintf(pll_name, sizeof(pll_name), "pll_%s", name);

	pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
	if (!pll)
		return ERR_PTR(-ENOMEM);
=E2=80=A6



=E2=80=A6
> +++ b/drivers/clk/rockchip/clk-pll.c
> @@ -909,14 +909,16 @@ struct clk *rockchip_clk_register_pll(struct rockc=
hip_clk_provider *ctx,
=E2=80=A6
> -		pll->rate_count =3D len;
>  		pll->rate_table =3D kmemdup(rate_table,
>  					pll->rate_count *
>  					sizeof(struct rockchip_pll_rate_table),
>  					GFP_KERNEL);
> -		WARN(!pll->rate_table,
> -			"%s: could not allocate rate table for %s\n",
> -			__func__, name);
> +
> +		/*
> +		 * Set num rates to 0 if kmemdup fails. That way the clock
> +		 * at least can report its rate and stays usable.
> +		 */
> +		pll->rate_count =3D pll->rate_table ? len : 0;

Can an other error handling strategy make sense occasionally?

=E2=80=A6
		if (!pll->rate_table) {
			clk_unregister(mux_clk);
			mux_clk =3D ERR_PTR(-ENOMEM);
			goto err_mux;
		}
=E2=80=A6


Would you like to adjust such exception handling another bit?

Regards,
Markus
