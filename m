Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C303C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410F320857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=criteo.com header.i=@criteo.com header.b="ofkyKIH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfDAPFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:05:49 -0400
Received: from mx07-00287e01.pphosted.com ([91.207.212.151]:19796 "EHLO
        mx08-00287e01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726617AbfDAPFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:05:49 -0400
Received: from pps.filterd (m0111311.ppops.net [127.0.0.1])
        by mx08-00287e01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x31F58D0026861;
        Mon, 1 Apr 2019 17:05:36 +0200
Received: from eur03-ve1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2053.outbound.protection.outlook.com [104.47.9.53])
        by mx08-00287e01.pphosted.com with ESMTP id 2rj08et9qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 01 Apr 2019 17:05:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCEt5udvUWRUSpbF/5EtwLqXFMpvpYFGEXrQEWuPwKQ=;
 b=ofkyKIH8HwEVgboMZvfRQiZXo8WiBDsbZYmfQkbfdLsMJx2iWkA8D4/K72pnpYSQ7eNKka0PZi97TyKORHzw4LzUY7PlRo6QD5CP1MQgE6cfnHqtPqSQ0mSmz9A36khOe1bsn/O/8MROmUOYbX1cGTB931Vbyv+ACzakyx4NTOA=
Received: from DB8PR04MB6713.eurprd04.prod.outlook.com (20.179.251.78) by
 DB8PR04MB5787.eurprd04.prod.outlook.com (20.179.11.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Mon, 1 Apr 2019 15:05:34 +0000
Received: from DB8PR04MB6713.eurprd04.prod.outlook.com
 ([fe80::ac3f:a606:384b:d9ed]) by DB8PR04MB6713.eurprd04.prod.outlook.com
 ([fe80::ac3f:a606:384b:d9ed%3]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 15:05:34 +0000
From:   Erwan Velu <e.velu@criteo.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq/intel_pstate: Load only on Intel hardware
Thread-Topic: [PATCH] cpufreq/intel_pstate: Load only on Intel hardware
Thread-Index: AQHU6Jwe2CFjG7FSP0S1CNDsOxhqI6YnZ3yA
Date:   Mon, 1 Apr 2019 15:05:34 +0000
Message-ID: <8364b496-4d63-13d7-8c05-7041e09085df@criteo.com>
References: <20190330100225.14744-1-bp@alien8.de>
 <fa14666a-269c-249a-f603-b00f6301c1a6@criteo.com>
 <20190401083902.GC28264@zn.tnic> <20190401150345.GJ28264@zn.tnic>
In-Reply-To: <20190401150345.GJ28264@zn.tnic>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0200.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::20) To DB8PR04MB6713.eurprd04.prod.outlook.com
 (2603:10a6:10:10e::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [91.199.242.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74b6d699-f2e5-474c-3632-08d6b6b37dcc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB8PR04MB5787;
x-ms-traffictypediagnostic: DB8PR04MB5787:
x-microsoft-antispam-prvs: <DB8PR04MB5787739B10DA3571E8EFCAEAF2550@DB8PR04MB5787.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(366004)(376002)(346002)(189003)(199004)(316002)(106356001)(8676002)(36756003)(31696002)(53936002)(6512007)(81156014)(3846002)(25786009)(6486002)(93886005)(8936002)(7736002)(6116002)(305945005)(97736004)(105586002)(81166006)(6436002)(11346002)(26005)(6506007)(66066001)(229853002)(186003)(54906003)(31686004)(478600001)(4326008)(52116002)(2616005)(68736007)(446003)(5660300002)(256004)(486006)(71200400001)(476003)(4744005)(386003)(99286004)(76176011)(6246003)(71190400001)(14454004)(102836004)(6916009)(2906002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB8PR04MB5787;H:DB8PR04MB6713.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: criteo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kb3Uxw6T2OgcS8uax4BmZjAkbd1qKqIEOSiHEvVA8fJ0aPtC1eW3V+WL8AmpcltvWlb3mr+T48zSu/PQl40r3AFGruxQ7bWhGlxNxgyfplFfcD/9TruZSfPoLSXKMtpOq7Qy6E8eboBdh9yv51nxQ7gMpZpQiLKqchcyvgaEhSqRzMqoVvkM3dmlNCkDkR8ypE71rRW+7PdgYcEBvgSIJXSosxF9eOLxyTw9X2nsCnAjc05i9TcF2xGRYqo5b43gDzgsZM/4vZhAIkJumtPDjViElyn9McFxdinj1sPGoI+IlJdE6tryVLYeXBUr7dZUf4g1rf89KP1KxEOZv2dXKO+b4qJn6IB2wcuQgn9dbrDGlmHAjGehggygRdGN24OqGyWdp3fwMWT2W/BVcRT9WX9gi6j6gvbAr/gbxYCaFRg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99176AE59B31094BAE25A94E77F1F497@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b6d699-f2e5-474c-3632-08d6b6b37dcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 15:05:34.7631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpMZSAwMS8wNC8yMDE5IMOgIDE3OjAzLCBCb3Jpc2xhdiBQZXRrb3YgYSDDqWNyaXTCoDoNCj4g
RnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPg0KPg0KPiBUaGlzIGRyaXZlciBpcyBJ
bnRlbC1vbmx5IHNvIGxvYWRpbmcgb24gYW55dGhpbmcgd2hpY2ggaXMgbm90IEludGVsIGlzDQo+
IHBvaW50bGVzcy4gUHJldmVudCBpdCBmcm9tIGRvaW5nIHNvLg0KPg0KPiBXaGlsZSBhdCBpdCwg
Y29ycmVjdCB0aGUgIm5vdCBzdXBwb3J0ZWQiIHByaW50IHN0YXRlbWVudCB0byBzYXkgQ1BVDQo+
ICJtb2RlbCIgd2hpY2ggaXMgd2hhdCB0aGF0IHRlc3QgZG9lcy4NCj4NCkxvb2tzIGdvb2QgdG8g
bWUgIQ0KDQpUaGFua3MgIQ0KDQpFcndhbiwNCg0K
