Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5CFC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FADB205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mE/KQgnn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfEHOzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 10:55:07 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:42194 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726956AbfEHOzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:55:05 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5EBEDC011E;
        Wed,  8 May 2019 14:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557327308; bh=OyuDIlKKF19OaJlrS+fbwBer3egeSY4j1jMCaPU9OqM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=mE/KQgnnVbLcjfK6l2q22Gh+f4KyshSYb/1jCZQu8FXNfwbYjpoyzGmNAoBlB+4jF
         iq5oadnTtsHq8KwxUFg/uc74JVkdKTeVg6oDArX7PGxWcRS0GtNJDlMjz5SkEadRBp
         O33NPEtMZhOlh65vkFV2bXjhXnn8F57k0ksA1U+a9Hz4hIxi+HEWjlgb2jxUY5DD/i
         yPTu2KicQWyNdxj2nlWkgv4AE8gG4k0Bwo/gxV9OIXZeieaK3VOm91CF/sk2biIAQ0
         3NmLetBLM0RPiOUF53pjfjyX+vBdh2yNw+hOHMiV3gmokPstq9bczklZ1HS9ML+7Xz
         WgFzEfVHCcJYA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1BC79A0328;
        Wed,  8 May 2019 14:55:03 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 8 May 2019 07:54:22 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 8 May 2019 16:54:20 +0200
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "Jose.Abreu@synopsys.com" <Jose.Abreu@synopsys.com>
CC:     "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: RE: [PATCH] ARC: [plat-hsdk]: Add missing multicast filter bins
 number to GMAC node
Thread-Topic: [PATCH] ARC: [plat-hsdk]: Add missing multicast filter bins
 number to GMAC node
Thread-Index: AQHVAMdCOflFMqXaVU6/uA7yDRRMYqZX2A8AgAZ1TQCAApAzUIAAFfkAgABmh6A=
Date:   Wed, 8 May 2019 14:54:19 +0000
Message-ID: <78EB27739596EE489E55E81C33FEC33A0B479FD8@DE02WEMBXB.internal.synopsys.com>
References: <7f36bbadc0df4c93c396690dab59f34775de3874.1556788240.git.joabreu@synopsys.com>
         <56933076-879c-78a0-4bae-2613203b93b1@synopsys.com>
 <1557166759.17021.9.camel@synopsys.com>
 <78EB27739596EE489E55E81C33FEC33A0B478870@DE02WEMBXB.internal.synopsys.com>
 <CY4PR1201MB01206801C1C2B8272ABE9B17A1320@CY4PR1201MB0120.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB01206801C1C2B8272ABE9B17A1320@CY4PR1201MB0120.namprd12.prod.outlook.com>
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

RnJvbTogQWxleGV5IEJyb2RraW4gPGFicm9ka2luQHN5bm9wc3lzLmNvbT4NCkRhdGU6IFdlZCwg
TWF5IDA4LCAyMDE5IGF0IDExOjQ2OjM2DQoNCj4gQ291bGQgeW91IHBsZWFzZSBwcm9wb3NlIGEg
cGF0Y2g/DQoNCkkgY291bGRuJ3QgeWV0IGZpbmQgdGhlIGV4YWN0IEZJRk8gc2l6ZSBvZiB0aGUg
SFcgKGl0J3Mgbm90IGRlc2NyaWJlZCBpbiANCnRoZSBkb2N1bWVudHMgSSBoYXZlKS4gRG8geW91
IGhhdmUgdGhlIHZhbHVlcyA/DQoNClRoYW5rcywNCkpvc2UgTWlndWVsIEFicmV1DQo=
