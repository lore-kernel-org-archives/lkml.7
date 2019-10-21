Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3F8CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF6420659
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfJUIoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:44:02 -0400
Received: from mail-oln040092066082.outbound.protection.outlook.com ([40.92.66.82]:60899
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727065AbfJUIoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:44:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+OPCvbxQwoMBTidoz1xuOEISmoXPGVgChpUF9Ou3QARYMSpHsBK8ejnnTmUkjktYaOx2FWFPLoAe//V7/9YPAagCy+6oYJgOSWWSQdS5ToCirkWIlyo7UoWe27Bb0SGD9rzFfkAfd1BJawyjfMt4zJTWhNCWUrz3ytBkNpEv1hYzmMstPVTzrbGzI31A5w61rXtA9H33kXIlwcBxWp2izBB1NxoDxbzNQl2a+ptjeEV4v/IuXztaGbX4DpgS4bAjYNbxRXpCB5oUrMiC6RZhG/JRiVjTpiVefxv0EfjMDM5lAgW1wAz6Jlj55ML0FpfpZJrphT6dQdOHXpe07oZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QB6dNWKygoF4guypCasXlzbcOPHSSammvgW5CV/Tj0=;
 b=cjCbNOdXG5etySX99jkylSm1brxUgOKbd0X5DmuGnFkLqn7q7Gc4bJnUQSUHEc4VpuORPs6jN7/NuzQwWj4vcnLf9So8cTx8jmTlu+RYtwkNFZMB6rPXroPArHhiYIEHwJumsT2LwjscNfcXpKb5W9zLJ/KLMIYHP4MxiqPKxfnZIlMrqB+ZOFQlq1ExKywHLX0l+lyGvKddwCIBONvS7WgqaABqx83oL+8ZMCCw60a5ILrBtqFTyB6ilPUG04Hcspq85G+fpyLnKG+77la3itnbbYro50hnYrPCtNAsF1Gm8n/zekvHZJhwVcZa3CeVN/QMLRJfnzx8E+qmsIx+7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB5EUR01FT048.eop-EUR01.prod.protection.outlook.com
 (10.152.4.57) by DB5EUR01HT214.eop-EUR01.prod.protection.outlook.com
 (10.152.5.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.14; Mon, 21 Oct
 2019 08:43:58 +0000
Received: from AM0PR0502MB3668.eurprd05.prod.outlook.com (10.152.4.53) by
 DB5EUR01FT048.mail.protection.outlook.com (10.152.5.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.14 via Frontend Transport; Mon, 21 Oct 2019 08:43:58 +0000
Received: from AM0PR0502MB3668.eurprd05.prod.outlook.com
 ([fe80::b1e4:568d:bbc:8247]) by AM0PR0502MB3668.eurprd05.prod.outlook.com
 ([fe80::b1e4:568d:bbc:8247%6]) with mapi id 15.20.2347.029; Mon, 21 Oct 2019
 08:43:58 +0000
From:   Anatol Belski <weltling@outlook.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        "trivial@kernel.org" <trivial@kernel.org>
Subject: Re: [PATCH] include/linux/byteorder/generic.h: fix signed/unsigned
 warnings
Thread-Topic: [PATCH] include/linux/byteorder/generic.h: fix signed/unsigned
 warnings
Thread-Index: AQHVh2rzQudqiWaARkuhjP20crUqsKdkqXKAgAAfEIA=
Date:   Mon, 21 Oct 2019 08:43:58 +0000
Message-ID: <AM0PR0502MB3668CBCDF1C1C3747D02BBFBBA690@AM0PR0502MB3668.eurprd05.prod.outlook.com>
References: <AM0PR0502MB3668B1A0EC328690DA25E9C6BA6E0@AM0PR0502MB3668.eurprd05.prod.outlook.com>
         <20191021065245.GH32742@smile.fi.intel.com>
In-Reply-To: <20191021065245.GH32742@smile.fi.intel.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-clientproxiedby: AM0PR06CA0053.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::30) To AM0PR0502MB3668.eurprd05.prod.outlook.com
 (2603:10a6:208:19::11)
x-incomingtopheadermarker: OriginalChecksum:18BFDDB472A3570CA96121E86E8DF5C53A7265AA33E418D970E2CB313C1689B9;UpperCasedChecksum:1157FD1386BDEAF7DFE3CA74B0C4FEE31136CC6A8CA77AF2B3C41BB6AB86AE58;SizeAsReceived:8055;Count:52
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [ejcq5jySr1kI4hMI53s/ekpre4RqsKHBuOUdl7LNtamqH1W+cwcZb1ZfjEGfeKGA]
x-microsoft-original-message-id: <b673366e4bbde2432a250e196a2556be7faa1527.camel@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 52
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: DB5EUR01HT214:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RhDbtJce7qdluBnaujq88UHb9uinsFJlFNOSk7aXsgVCasULh9/ktcjvZniaYxRPl/iySY1O29Di4oj5kjfv216DDZG+4ZeJRz4lu/grXl6ynCH7GhSfbG/kZ+ZssFI5dcmJrLE/0F/gvhWKoKBAmdLKpxPTCMTfbdXs90zSApB7LYGOg+cYjX6fuwLn6J3Z
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <76D334A49846F64A9DDD3C2F6FA80921@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 83558524-e54e-4a76-9f97-08d75602d00d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 08:43:58.3927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR01HT214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIE1vbiwgMjAxOS0xMC0yMSBhdCAwOTo1MiArMDMwMCwgQW5keSBTaGV2Y2hlbmtv
IHdyb3RlOg0KPiBPbiBTdW4sIE9jdCAyMCwgMjAxOSBhdCAwNToyMjozMFBNICswMDAwLCBBbmF0
b2wgQmVsc2tpIHdyb3RlOg0KPiA+IEZyb206IEFuYXRvbCBCZWxza2kgPGFuYmVsc2tpQG1pY3Jv
c29mdC5jb20+DQo+IA0KPiBCZXR0ZXIgdG8gYWRkIGNvbW1pdCBtZXNzYWdlIGV2ZW4gZm9yIHNt
YWxsIHBhdGNoZXMgbGlrZSB0aGlzLg0KPiBEbyB5b3UgaGF2ZSBjb21waWxlciAvIHNwYXJzZSAv
IGV0YyB3YXJuaW5nPyBDaXRlIGl0IGhlcmUgYXMgd2VsbCENCj4gDQoNCnllcywgaXQncyAtV3Np
Z24tY29tcGFyZS4gSSdsbCBzZW5kIGEgZm9sbG93IHVwIHdpdGggYSBiZXR0ZXIgY29tbWl0DQpt
ZXNzYWdlLg0KDQpUaGFua3MNCg0KQW5hdG9sDQoNCg==
