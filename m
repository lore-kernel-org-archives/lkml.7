Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FC5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D94218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553171531;
	bh=NVKD/HyI/lvTEUSobWmp2Zw6/ESgILA8WrzuDgaGAbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=efdmSuJ3Rb7s+O5s78BioDK+7dvm0RB5zzpMrWUESPOu8f8DxBCDnzWdbru8L8u+1
	 0rQSe3gLAHsG3a5tBooUIYynksdMZTguvFEdzdgBs+pCgtrCa3+t63FWkolQm8LEZl
	 ctWpS2T5h3Fmo/HuhoWeEpsUBPbWwaIfQKYJ/Zdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfCUMcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:32:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41360 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfCUMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eIJzhBwfuniGvbF33UlrEZMbwpZ9TpRwvWFtJbhmxD8=; b=vmZwiTx0DSwQGeZR68wUZgzdN
        6vWxVpMCkc8o3akvRpzqc5IPSJ5xJVQ7M/cd0vUkm+LVsIiQlvi7D1iWGcR8+9Zu2tfW9aqzYYe5C
        A66qiZn8whlwq9kqUFg+e9Ot5kKNOV5vko54kcMeC90/iFY1rVbmlMg9U4J4w7F8hucBM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6wrU-0004uS-Tk; Thu, 21 Mar 2019 12:31:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 28E3F11288EC; Thu, 21 Mar 2019 12:31:56 +0000 (GMT)
Date:   Thu, 21 Mar 2019 12:31:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dapm: Fix NULL pointer dereference in
 snd_soc_dapm_new_dai
Message-ID: <20190321123156.GB5684@sirena.org.uk>
References: <1553163085-16845-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
In-Reply-To: <1553163085-16845-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
X-Cookie: Hackers of the world, unite!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2019 at 03:41:25PM +0530, Pankaj Bharadiya wrote:

>  outfree_kcontrol_news:
>  	devm_kfree(card->dev, (void *)template.kcontrol_news);
> -	snd_soc_dapm_free_kcontrol(card, &private_value,
> -				   rtd->dai_link->num_params, w_param_text);
> +	if (w_param_text)
> +		snd_soc_dapm_free_kcontrol(card, &private_value,
> +				rtd->dai_link->num_params, w_param_text);

This is very non-obvious - it's not at all clear why we'd need the text
to free controls.  If there is an issue here it seems like it'd be
better to make sure that snd_soc_dapm_free_kcontrol() can cope with that
being NULL, that will be clearer and also avoid potential issues with
other callers.

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyThDsACgkQJNaLcl1U
h9B7MAf/aI4rdoOjE8VyQHKfBX2aHB87qkmKc68mZWOkQcDzuxO4u9EdmdgIlqcO
HrcViAczXi+oE1U1tqXJKoW8F+vgEsVTr35axy7sfoeZB5IhjVRDNoJTYT0ypj65
vqjd4Ul3LeXnOraDU0dujGtA/TSiPoXu9IBkxsw6qymeWBvEuFi4GmWvN09jMulE
hQSUZ8wmp9eNfWb8h9xLNagEDmJFjDAhVBF8hz4yWvOu9P1F0ypiWrpPVbUeR50z
ZXpjCs6cMpaQx0wmTO9IyGAjiaxFCSuHswTOit912mhDxfnsW8OrTtILDWeM18+z
KVJzMUh10RKGcPowirNRvHGKBQbA2g==
=J0ZG
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
