Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFDFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F6D20684
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PwXG4LUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfDXJ0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:26:51 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:33688 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726952AbfDXJ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:26:50 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EEC5AC0B56;
        Wed, 24 Apr 2019 09:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1556098009; bh=G1ILqqfxwDrF0Nw5NbE0/OxnaAXD5A8HSQY2TNiPmks=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=PwXG4LUzcIG73tCW/SUUu9mHxweidIqZLUSuxBooFHhUMofJMEMaBDKwUxx5AGezg
         /GPdWj/qBDIDmBCKU9jKcRVHgmq993jqn9S8igzhbQVfXRKTUmII5AyxFTc7U+fhRw
         VeRP9JgLIYjWjyA/t2Is1sjrt3LdrRUeX6loZZPqu1j7nnTzXRgRG26xtoSU3K/4pV
         y90EbQ/zzdjWj1MlN9fxFz3+k5+zmhu3s884jqJcqSctLuKtUmxtGrg92FNtdrqN4V
         c4SOM1JeXYtAhPRuakA8J7/EYwD6zRaNYXoQc+Cv887NZcbDRCjcG5rslR3lXm453L
         repSN6OrTrjQw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C6875A008B;
        Wed, 24 Apr 2019 09:26:49 +0000 (UTC)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 24 Apr 2019 02:26:49 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 24 Apr 2019 11:26:47 +0200
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     Weifeng Voon <weifeng.voon@intel.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Kweh Hock Leong <hock.leong.kweh@intel.com>
Subject: RE: [PATCH 0/7] net: stmmac: enable EHL SGMII
Thread-Topic: [PATCH 0/7] net: stmmac: enable EHL SGMII
Thread-Index: AQHU+n6UM7GU7OtY/UWKCWYebuRSxqZLCeAA
Date:   Wed, 24 Apr 2019 09:26:46 +0000
Message-ID: <78EB27739596EE489E55E81C33FEC33A0B465F6A@DE02WEMBXB.internal.synopsys.com>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
In-Reply-To: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
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

From: Weifeng Voon <weifeng.voon@intel.com>
Date: Wed, Apr 24, 2019 at 18:17:14

> From: "Voon, Weifeng" <weifeng.voon@intel.com@intel.com>
>=20
> This patch-set is to enable Ethernet controller (DW Ethernet QoS
> and DW Ethernet PCS) with SGMII interface in Elkhart Lake. The
> DW Ethernet PCS is the Physical Coding Sublayer that is between
> Ethernet MAC and PHY and uses MDIO Clause-45 as Communication.
>=20

Please re-send this series with the stmmac maintainers in CC. Also CC=20
Andrew Lunn and Florian Fainelli for the C45 part.

Thanks,
Jose Miguel Abreu
