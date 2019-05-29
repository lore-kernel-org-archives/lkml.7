Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84B5C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B640420665
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bq8edUN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfE2HvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:51:07 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:40142 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725895AbfE2HvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:51:07 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DCA33C1E97;
        Wed, 29 May 2019 07:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559116250; bh=O4m8Slnem2aqPN5cvF04pcHB8VJrzCkhF42k8NlkGos=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bq8edUN/z7Se1ooSC7xpybCBbiM8riMcrnNHAosyXjpMmgLGT/9lmpi3/JuPing52
         16uLpEaVfiaSJfu4OhLnY2YXq/FYcgx0DLPj2CPZiXeHtBSG3wlszQvQfNBPFhihTk
         IBJ7Mh9vw5Yz6IAugBFBlOo1GaXVcKI4OdeV0+HIKCdqYAAjig+Znw5sKq0gpng4eE
         6wTF+LcV/n+MOsZaP5syH5WFcb2Qtv2FUZHEsB3ka5Hsi61fsDeQueOLyuukcJg4Ra
         GNGcIOlK4Cnch4qAt9l4ZFUZ1lWo93NKQsUBJBY904K8F1CCozxqlmUDzyyaKgB5QR
         Iwi0h7tsNTbcg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5A558A009C;
        Wed, 29 May 2019 07:51:04 +0000 (UTC)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 29 May 2019 00:51:04 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 29 May 2019 09:51:01 +0200
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
Subject: RE: [PATCH net-next v3 0/5] net: stmmac: enable EHL SGMII
Thread-Topic: [PATCH net-next v3 0/5] net: stmmac: enable EHL SGMII
Thread-Index: AQHVFcTD9h9jmx1QT0W4AMzbkVV3B6aBupZQ
Date:   Wed, 29 May 2019 07:51:00 +0000
Message-ID: <78EB27739596EE489E55E81C33FEC33A0B932F7F@DE02WEMBXB.internal.synopsys.com>
References: <1559125118-24324-1-git-send-email-weifeng.voon@intel.com>
In-Reply-To: <1559125118-24324-1-git-send-email-weifeng.voon@intel.com>
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
Date: Wed, May 29, 2019 at 11:18:33

> This patch-set is to enable Ethernet controller
> (DW Ethernet QoS and DW Ethernet PCS) with SGMII interface in Elkhart Lak=
e.
> The DW Ethernet PCS is the Physical Coding Sublayer that is between Ether=
net
> MAC and PHY and uses MDIO Clause-45 as Communication.

Did you rebase this series against latest net-next tree ?

Because you are missing MMC module in your HWIF table entry. This module=20
was recently added with the addition of selftests.

Thanks,
Jose Miguel Abreu
