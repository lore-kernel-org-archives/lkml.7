Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2985AC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2512070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gMAJ/kdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfE2KZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:25:29 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:42080 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbfE2KZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:25:29 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 93485C0110;
        Wed, 29 May 2019 10:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559125537; bh=Pcjd9VNcn+xaJUrAja6YEnvXeWRu4uUt7EGvfdDAy0A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=gMAJ/kdWirJQwLs92PvYJs5E5W+ObsL9Gp8GNdsA6a3mpH9Y018JWLx8mBauEtFDA
         XeOVE7Ph86dwIwOdV4sTuf6WbUoc/LPS+y44yx/fDT7X8o65gK7PVdJRKxfPUm6Fgq
         ROPeAvc3REgLOTQ7lFZXOmxYA3Oldixd8/XkktbitEryiq8SY5oFBMoirAz9bEQvrc
         phYJqN1QEjldh+vPAnRilwZ5zk3ykewGDWdpQ9Dai9Cd2bXo+AN4/lxJ9cNTu/oUuY
         YMYL6TK1qynpdT7ahyPd39NNJNby30gTqmRuC1mPtMaXe+6LXIvxZnmOwdrtOx3eTv
         dwtHDI328kXnw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 354AFA009C;
        Wed, 29 May 2019 10:25:28 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 29 May 2019 03:25:28 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 29 May 2019 12:25:25 +0200
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     Voon Weifeng <weifeng.voon@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Giuseppe Cavallaro" <peppe.cavallaro@st.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        biao huang <biao.huang@mediatek.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Kweh Hock Leong <hock.leong.kweh@intel.com>
Subject: RE: [PATCH net-next v4 4/5] net: stmmac: add xPCS functions for
 device with DWMACv5.1
Thread-Topic: [PATCH net-next v4 4/5] net: stmmac: add xPCS functions for
 device with DWMACv5.1
Thread-Index: AQHVFfyojskpttCUHUuHRFPbapmAMaaB5Y4g
Date:   Wed, 29 May 2019 10:25:25 +0000
Message-ID: <78EB27739596EE489E55E81C33FEC33A0B933444@DE02WEMBXB.internal.synopsys.com>
References: <1559149107-14631-1-git-send-email-weifeng.voon@intel.com>
 <1559149107-14631-5-git-send-email-weifeng.voon@intel.com>
In-Reply-To: <1559149107-14631-5-git-send-email-weifeng.voon@intel.com>
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

From: Voon Weifeng <weifeng.voon@intel.com>
Date: Wed, May 29, 2019 at 17:58:26

> From: Ong Boon Leong <boon.leong.ong@intel.com>
>=20
> We introduce support for driver that has v5.10 IP and is also using
> xPCS as MMD. This can be easily enabled for other product that integrates
> xPCS that is not using v5.00 IP.
>=20
> Reviewed-by: Chuah Kim Tatt <kim.tatt.chuah@intel.com>
> Reviewed-by: Voon Weifeng <weifeng.voon@intel.com>
> Reviewed-by: Kweh Hock Leong <hock.leong.kweh@intel.com>
> Reviewed-by: Baoli Zhang <baoli.zhang@intel.com>
> Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
> Signed-off-by: Voon Weifeng <weifeng.voon@intel.com>

Acked-by: Jose Abreu <joabreu@synopsys.com>

Thanks,
Jose Miguel=20
Abreu
