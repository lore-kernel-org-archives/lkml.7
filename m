Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E8DC06508
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF9221743
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="CRAEEdTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407071AbfFKS1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:27:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34395 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406910AbfFKS1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:27:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id m29so15753662qtu.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 11:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=XTSl1X3TVusNnBwvpfSKetQ7KFSoxgL/x9tvPN4y51Q=;
        b=CRAEEdTtEd/R/ClPRCAiQrGs353d6Tbo3jIKj42fETxvxpoFht2citqwCizu+33E4B
         +JP4HyZtGaV+ojzUSANo2JTxN9uZJuVTCIdB5VDwxaajMa4IdsmZqr2iMOOdkQug4CPO
         D4HrAY5X+k+OfpDZIqflFncGBPA/BYEeK5fkJKZiTpnIXjHJE8C8C9Gw1Q1r6y0ZsMer
         1ih33ubjy3e80OUbS/QmPjKW+iqSeJzTiyB7yn2brAaZZSQ4KGgtAKsJl2SBbVAm0zAB
         P37irrMi8CrkU4pwyEi6yC+kFXGeOXHQbZXEfQdwkhvBSLzQ4z71mRd4ouAld+i1/yRN
         EZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=XTSl1X3TVusNnBwvpfSKetQ7KFSoxgL/x9tvPN4y51Q=;
        b=QaJ0IRO+RBp+2YBr917xQBtxg7qNGMEhU0qAZc3w3IammDcxtV4GIaB8u2QnQvYCQa
         xX/R+g1mzC0Yp3GWDL6hRoN9pf19rvFRzGEbnAyN8kYWJiKfmkzHL2bJJDzgg8lxrAtU
         6hiFSuh42WruLbQUg8W2882aUBVz3LnzLJXbeh7ZCR0QPWrJU2+/VACx6HN3BVevk+HR
         vZiErEpvEtIaO2ATJ7fEnbW00PeDDJLGTsiAzrTW30pu0v6C6RuNFYPlrkVypHH9hC2Y
         hwbxXru6aTUuVtxMXrL9eWdAuYVkG5G8C2Jb0Ok4zMivo1pjYIvSFUJD3jMm8kocVtHR
         opmw==
X-Gm-Message-State: APjAAAVB71Wbpg/5+DKSpk/D06H+8217n4SMVt4inqwG7dLjQJugkRdi
        cBojqNpS7ANz+7/ZryVsq7+RrQ==
X-Google-Smtp-Source: APXvYqxOJlQrkKCKNeZVMer/ppqUM3GcMD8BwtnZWk7n591FH4TR2dpB9T5BB74xMJinUiXzrdjheA==
X-Received: by 2002:ac8:7545:: with SMTP id b5mr56892127qtr.234.1560277635418;
        Tue, 11 Jun 2019 11:27:15 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id u7sm6731244qkm.62.2019.06.11.11.27.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 11:27:15 -0700 (PDT)
Date:   Tue, 11 Jun 2019 11:27:10 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH net] net: ethtool: Allow matching on vlan CFI bit
Message-ID: <20190611112710.211e218b@cakuba.netronome.com>
In-Reply-To: <20190611155456.15360-1-maxime.chevallier@bootlin.com>
References: <20190611155456.15360-1-maxime.chevallier@bootlin.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 17:54:56 +0200, Maxime Chevallier wrote:
> Using ethtool, users can specify a classification action matching on the
> full vlan tag, which includes the CFI bit.
>=20
> However, when converting the ethool_flow_spec to a flow_rule, we use
> dissector keys to represent the matching patterns.
>=20
> Since the vlan dissector key doesn't include the CFI bit, this
> information was silently discarded when translating the ethtool
> flow spec in to a flow_rule.
>=20
> This commit adds the CFI bit into the vlan dissector key, and allows
> propagating the information to the driver when parsing the ethtool flow
> spec.
>=20
> Fixes: eca4205f9ec3 ("ethtool: add ethtool_rx_flow_spec to flow_rule stru=
cture translator")
> Reported-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> Hi all,
>=20
> Although this prevents information to be silently discarded when parsing
> an ethtool_flow_spec, this information doesn't seem to be used by any
> driver that converts an ethtool_flow_spec to a flow_rule, hence I'm not
> sure this is suitable for -net.
>=20
> Thanks,
>=20
> Maxime
>=20
>  include/net/flow_dissector.h | 1 +
>  net/core/ethtool.c           | 5 +++++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
> index 7c5a8d9a8d2a..9d2e395c6568 100644
> --- a/include/net/flow_dissector.h
> +++ b/include/net/flow_dissector.h
> @@ -46,6 +46,7 @@ struct flow_dissector_key_tags {
> =20
>  struct flow_dissector_key_vlan {
>  	u16	vlan_id:12,
> +		vlan_cfi:1,
>  		vlan_priority:3;
>  	__be16	vlan_tpid;
>  };
> diff --git a/net/core/ethtool.c b/net/core/ethtool.c
> index d08b1e19ce9c..43df34c1ebe1 100644
> --- a/net/core/ethtool.c
> +++ b/net/core/ethtool.c
> @@ -3020,6 +3020,11 @@ ethtool_rx_flow_rule_create(const struct ethtool_r=
x_flow_spec_input *input)
>  			match->mask.vlan.vlan_id =3D
>  				ntohs(ext_m_spec->vlan_tci) & 0x0fff;
> =20
> +			match->key.vlan.vlan_cfi =3D
> +				!!(ntohs(ext_h_spec->vlan_tci) & 0x1000);
> +			match->mask.vlan.vlan_cfi =3D
> +				!!(ntohs(ext_m_spec->vlan_tci) & 0x1000);

nit: since you're only using the output as a boolean, you can apply the
     byteswap to the constant and have it performed at build time.
     Another option is be16_get_bits() from linux/bitfield.h.

>  			match->key.vlan.vlan_priority =3D
>  				(ntohs(ext_h_spec->vlan_tci) & 0xe000) >> 13;
>  			match->mask.vlan.vlan_priority =3D
