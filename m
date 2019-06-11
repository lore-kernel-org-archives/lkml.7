Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC099C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E3E2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JqMFjcKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405301AbfFKPkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:40:46 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:47052 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405025AbfFKPkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:40:45 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B6744C1E7F;
        Tue, 11 Jun 2019 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1560267642; bh=tSfhNTVAtEcZIdHqsOW2xYtdiEkMPWIQ8rIoVt3Qax0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=JqMFjcKNpyvKq5gXHIMeamJeX97oFxnRZRE+DM1zVDpNXradD0i72ykoD1GXteFna
         nfRKzX80zIxWP2ywSUSW/d7VGh5EW5JFJbUKh6kRJLRky2e4nJ3jGe3rOZBf+QeBcw
         BadohOVF/c5lxj9EsErwa2kf1CKnrO5uj4u6qMnpvKpnR8saw1zoJUSiJbLdcdVzLA
         ljmul6ufloKvind5/OWzxADR6tujCsaRtkFVzvnngImnnX8uci7fn7yZ82lVHYNfBE
         MrWyzpHfalc1xOp+RCnw0ZoEgvem+idBqrAY6USKbjwO3rE4sPOHXETJaLU+TfbSBi
         5k1sUrEfUpNMg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 34D8AA0093;
        Tue, 11 Jun 2019 15:40:44 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 11 Jun 2019 08:40:43 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 11 Jun 2019 17:40:41 +0200
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jose Abreu <Jose.Abreu@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: RE: [PATCH net-next 2/3] net: stmmac: Start adding phylink support
Thread-Topic: [PATCH net-next 2/3] net: stmmac: Start adding phylink support
Thread-Index: AQHVIGkDSyzoVLl6dU6s6hlTdoKT5qaWdD+AgAAhwSA=
Date:   Tue, 11 Jun 2019 15:40:41 +0000
Message-ID: <78EB27739596EE489E55E81C33FEC33A0B949445@DE02WEMBXB.internal.synopsys.com>
References: <cover.1560266175.git.joabreu@synopsys.com>
 <7daa1ac5cf56152b9d6c969c24603bc82e0b7d55.1560266175.git.joabreu@synopsys.com>
 <20190611153529.z6hlkhtrnd5ksx2n@shell.armlinux.org.uk>
In-Reply-To: <20190611153529.z6hlkhtrnd5ksx2n@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.107.19.176]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King - ARM Linux admin <linux@armlinux.org.uk>

> If this is not used, I don't really see the point of splitting this from
> the rest of the patch.  Also, I don't see the point of all those NULL
> initialisers either.

Thanks for the feedback. Please see previous discussion here that lead=20
to the introduction of this patch [1].

I can squash it into 3/3 but the diff of that patch will look even worse=20
...

[1] https://patchwork.ozlabs.org/patch/1110489/

Thanks,
Jose Miguel=20
Abreu
