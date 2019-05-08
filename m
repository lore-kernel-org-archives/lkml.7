Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A0EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A81214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Y1YmsR77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfEHH3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:29:03 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:55518 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbfEHH3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:29:02 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A3689C00E5;
        Wed,  8 May 2019 07:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557300545; bh=TgHt3b2Gg9tpKFC4TR7N7CkLAgIAaku1jGPKdCF3QAc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Y1YmsR77akkGn/MrWnXmnnXm/mj1phLENM6JaNxyd715tYf0VKlEQTsDFAeh+R5lP
         jWnpGUdeHezx6OEAf3+0zx187aq9Viy6HebCPA6XOVpwWTfcJM6/xzJ/MYy0jBouIR
         o4AtuLJeXAcmcw6vHjWRtPqpxPZjFjQUmtdRcjQKP/vUsTRCDYvPafyLST/GC8NuTI
         BUKA8EvWeO8IKMlYC/VbMSWiHl4shXXfqTohqQo2OUNR4voauzfdUj776qJtVab0X4
         dlIbjAEpLL/mFrhqZDVjP3DpetAFaVmvz8X6462nGSsQbAwt8vuNLo9JkoKs4d+ezi
         hLAtXw6+qeSYg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id EFD57A02AB;
        Wed,  8 May 2019 07:29:00 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 8 May 2019 00:29:01 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 8 May 2019 09:28:58 +0200
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "Jose.Abreu@synopsys.com" <Jose.Abreu@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: RE: [PATCH] ARC: [plat-hsdk]: Add missing multicast filter bins
 number to GMAC node
Thread-Topic: [PATCH] ARC: [plat-hsdk]: Add missing multicast filter bins
 number to GMAC node
Thread-Index: AQHVAMdCOflFMqXaVU6/uA7yDRRMYqZX2A8AgAZ1TQCAApAzUA==
Date:   Wed, 8 May 2019 07:28:57 +0000
Message-ID: <78EB27739596EE489E55E81C33FEC33A0B478870@DE02WEMBXB.internal.synopsys.com>
References: <7f36bbadc0df4c93c396690dab59f34775de3874.1556788240.git.joabreu@synopsys.com>
         <56933076-879c-78a0-4bae-2613203b93b1@synopsys.com>
 <1557166759.17021.9.camel@synopsys.com>
In-Reply-To: <1557166759.17021.9.camel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.107.19.176]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRXVnZW5peSBQYWx0c2V2IDxwYWx0c2V2QHN5bm9wc3lzLmNvbT4NCkRhdGU6IE1vbiwg
TWF5IDA2LCAyMDE5IGF0IDE5OjE5OjIwDQoNCj4gSGksDQo+IA0KPiBJJ2xsIGNoZWNrIHRoaXMg
aW4gdGhlIG5leHQgZmV3IGRheXMuDQo+IA0KDQpJIGFsc28gbm90aWNlZCB0aGF0IEZJRk8gc2l6
ZSBlbnRyeSBpcyBtaXNzaW5nLiBEV01BQzEwMDAgZG9lcyBub3QgDQpzdXBwb3J0IGF1dG9tYXRp
YyBGSUZPIHNpemUgZGV0ZWN0aW9uIHNvIHRoaXMgZW50cnkgbmVlZHMgdG8gYmUgYWRkZWQuDQoN
ClRoYW5rcywNCkpvc2UgTWlndWVsIEFicmV1DQo=
