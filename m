Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B173C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1097F2465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RDULRgwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfLSUQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:16:22 -0500
Received: from mail-eopbgr10131.outbound.protection.outlook.com ([40.107.1.131]:42400
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbfLSUQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:16:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pd+h2ZGeL8LhH3w87fGY7xdOFMSHcZa+mKb7hgv64O7/RC3sw/yCXOKzkdr0KJ0ei1VTf7Mwaier07sGc17mxAz7MGuvonYaNfTSaQzvANggEogzEEUzb+6HH8pwe6auYRAsxq9A2IdwQ1UvfH+8rCYuSvGKxoWqNLrD+X+qT+he+/X6TIWhDojBF7kSOfHwamGFhVzYIFmFXJSP/MMFp+iFp8yBGAnwu2u6SYCoudZVf6q7S43XjJW6BRGIRQbbi10gHqgf/I4TrB7J/lbrb9ZKeJgBL2yMovaWUhHjto/wzfjX63KVxjbaO/F5wiSw+uSEnKzJ6WmIaza6led8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L14ATJw1kXwXBN0OsjJY5e47wrbVHs4xnmGQ2CVEWh8=;
 b=J/jyvasLcsDlItUCPu9c9KjI+tQV08+KQ4HWapnRpaIv2bx8dx9jbq3lTBz7SwzjNnOVroY2d9r/Rxn+yds6nP/DwGfWlsCaga/il74gMLQ1RXe0zTazwp0YrD+NoPBNIA6vCnqfXnwAu/bZA5F9raDSkxG57y2wtg7nhZ8Pb/gQwOE5nbrJYV/v8RWusFLecKXIo9pGqDOr/TW3DZKbrCjIzv9QXzx5g6Qg6M5j1IwQj0AvBNmtOvuwt/g3Qh+towNl+ha5zCSOKPfvNJJFBS7pKUD0MeyDU5TAhqIJIa8tDdJFizj0TsmRPDZLaQdsIpaBzkAAuUdnNs0wGX6j9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L14ATJw1kXwXBN0OsjJY5e47wrbVHs4xnmGQ2CVEWh8=;
 b=RDULRgwTLmzX+iiGheAvRLul5BIya5/aJCoHFuslGxqv+a7I5i2dvpEJNU6eZhweIAEFmZo/tBpBSzpV64SB5giyUnpPVwyk3fJtTceROCD2i3JqLq/3NTCkdrDECLpTPRrD53bLWvhnYcpOcW2UpCUmkLKxKmKKNtDopFV0ftU=
Received: from VI1PR08MB3472.eurprd08.prod.outlook.com (20.177.60.27) by
 VI1PR08MB3343.eurprd08.prod.outlook.com (52.133.15.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 20:16:17 +0000
Received: from VI1PR08MB3472.eurprd08.prod.outlook.com
 ([fe80::a99c:2efb:3a9d:7ba3]) by VI1PR08MB3472.eurprd08.prod.outlook.com
 ([fe80::a99c:2efb:3a9d:7ba3%7]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 20:16:17 +0000
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched: Micro optimization in pick_next_task() and in
 check_preempt_curr()
Thread-Topic: [PATCH v2] sched: Micro optimization in pick_next_task() and in
 check_preempt_curr()
Thread-Index: AQHVtn/rEdaAkhwQzEOZQjeAvSuXP6fBmDoAgAA6DoD//9GqAIAAQU4A
Date:   Thu, 19 Dec 2019 20:16:17 +0000
Message-ID: <4a708948-7140-d8f3-a5ec-d242ae0737d4@virtuozzo.com>
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
 <20191219131242.GK2827@hirez.programming.kicks-ass.net>
 <20191219140252.GS2871@hirez.programming.kicks-ass.net>
 <bfaa72ca-8bc6-f93c-30d7-5d62f2600f53@virtuozzo.com>
 <20191219094330.0e44c748@gandalf.local.home>
 <11d755e9-e4f8-dd9e-30b0-45aebe260b2f@virtuozzo.com>
 <20191219095941.2eebed84@gandalf.local.home>
 <44c95c18-7593-f3e7-f710-a7d424af7442@virtuozzo.com>
 <20191219104018.5f8e50d2@gandalf.local.home>
 <af65cbaf-2f8e-0384-03e8-262d35e3790e@virtuozzo.com>
 <20191219112214.37f1f0af@gandalf.local.home>
In-Reply-To: <20191219112214.37f1f0af@gandalf.local.home>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0014.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::27)
 To VI1PR08MB3472.eurprd08.prod.outlook.com (2603:10a6:803:80::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [176.14.212.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50bb86e3-b96e-471e-44e4-08d784c04dff
x-ms-traffictypediagnostic: VI1PR08MB3343:
x-microsoft-antispam-prvs: <VI1PR08MB334340E62479EC04408B840ECD520@VI1PR08MB3343.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39840400004)(376002)(136003)(396003)(199004)(189003)(86362001)(6916009)(4326008)(2616005)(52116002)(6506007)(81156014)(8676002)(31696002)(8936002)(54906003)(5660300002)(71200400001)(81166006)(316002)(53546011)(478600001)(6486002)(186003)(26005)(6512007)(31686004)(2906002)(36756003)(4744005)(66946007)(66556008)(64756008)(66446008)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3343;H:VI1PR08MB3472.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AXtl48gdGE/m0niJltQvjcVWwq6KzGn19sT1v5acJot+s/kuO1BgLjZryaNO//eizvPPV3wcLl0RziL5waCVq99w5f1wbJrMDdorIptF/6oYlSJDrjYbZQjjY0/SbuCXppMJ6EEw+vA61IYT3b94JVCmCc9o3kIcBZD2rZirjKE7LSkyHsBSJd4FmrdO2KeVnE1xGBVZRiQob0nJHTNdZJ/iSgf+F8KyrL7pZqqI6VZ5ozgxF4bYqUv/20AoK/BonQn6XU79+O7Vuqvr6eDqIySbeiRTmkLrF9Y0DeoUIheHuXvXilNh3PVo3ITJl0VX6n2wTmzYL6WHp1jOiaGY/6LvYGXvOgTnU8coEctI0nehik+zWlQuTMn1OauIw+axvdjM2cNJpu62USOgvtcUEa32IjusQ/71zlcWsHL8je8Tl1WdYQR7jpO2zWgI6Gjp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD8E7A41A2573D47A3045844E0416220@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bb86e3-b96e-471e-44e4-08d784c04dff
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 20:16:17.5355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nb9ibDPkPggY3EHPM23IfE8lizzCE178vGFxjRBwUF2BI2uwNYkvvd8wQbnfSUkHXPCn7pPWnagafLg7qHGiDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkuMTIuMjAxOSAxOToyMiwgU3RldmVuIFJvc3RlZHQgd3JvdGU6DQo+IE9uIFRodSwgMTkg
RGVjIDIwMTkgMTk6MDg6MDUgKzAzMDANCj4gS2lyaWxsIFRraGFpIDxrdGtoYWlAdmlydHVvenpv
LmNvbT4gd3JvdGU6DQo+IA0KPj4gU2hvdWxkIEkgcmVzZW5kIHRoaXMgYXMgdHdvIHBhdGNoZXMs
IHdpdGggeW91ciBjaGFuZ2VzIGluIGEgc2VwYXJhdGU/DQo+IA0KPiBZb3UgZG9uJ3QgaGF2ZSB0
bywgeW91IGNhbiBpbmNsdWRlIG11bHRpcGxlIFNPQnMgaWYgYSBwYXRjaCB3YXMgd3JpdHRlbg0K
PiBieSB0d28gcGVvcGxlLg0KPiANCj4gQnV0IHBlcmhhcHMgaXQgd2lsbCBiZXR0ZXIgdG8gZG8g
c28sIHRoYXQgd2F5IHBlb3BsZSB3aWxsIGtub3cgd2hvIHRvDQo+IGJsYW1lIHdoZW4gdGhlIGxp
bmtlciBicmVha3MgOy0pDQo+IA0KPiBJJ2xsIHNlbmQgeW91IGEgcGF0Y2ggdGhhdCB5b3UgY2Fu
IGFwcGx5IGp1c3QgYmVmb3JlIHlvdXIgY2hhbmdlLiBUaGF0DQo+IG1heSBiZSB0aGUgY2xlYW5l
c3Qgd2F5Lg0KDQpUd28gc21hbGwgcGF0Y2hlcyBsb29rIGJldHRlciB0aGVuIG9uZSBodWdlLCBz
byBJIHByZWZlciB0byBzZW5kIGEgcGF0Y2gNCm9uIHRvcCBvZiB5b3VycyA6KQ0K
