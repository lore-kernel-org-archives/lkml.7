Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB051C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821DF2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=criteo.com header.i=@criteo.com header.b="XaDxyNrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbfDAIMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:12:07 -0400
Received: from mx08-00287e01.pphosted.com ([62.209.51.156]:42634 "EHLO
        mx07-00287e01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbfDAIMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:12:07 -0400
Received: from pps.filterd (m0111315.ppops.net [127.0.0.1])
        by mx07-00287e01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3185a1S001709;
        Mon, 1 Apr 2019 10:11:53 +0200
Received: from eur03-ve1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2057.outbound.protection.outlook.com [104.47.9.57])
        by mx07-00287e01.pphosted.com with ESMTP id 2rhvw41rm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 01 Apr 2019 10:11:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWfIoPPyiH/X+zqK7mflFPZgyj7Cy5V4mI+7LLLpgJc=;
 b=XaDxyNrVgvKgdzf6R2M5/UOITvUl6XcTgmv99j1Knhdd5nRxPqKFLpHOxwtH+3QvsOnkB7X6SNSMXnjUeeFzNv3XzjMBdLUpqZ2JjmKNbizCfX6+67Ngs1qozOFu/u2bRAR7+IzTp2UgqxaIg5isb3tUek+F4sO+L7ltgvjkBng=
Received: from DB8PR04MB6713.eurprd04.prod.outlook.com (20.179.251.78) by
 DB8PR04MB5866.eurprd04.prod.outlook.com (20.179.12.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Mon, 1 Apr 2019 08:11:51 +0000
Received: from DB8PR04MB6713.eurprd04.prod.outlook.com
 ([fe80::ac3f:a606:384b:d9ed]) by DB8PR04MB6713.eurprd04.prod.outlook.com
 ([fe80::ac3f:a606:384b:d9ed%3]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 08:11:51 +0000
From:   Erwan Velu <e.velu@criteo.com>
To:     Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
CC:     Len Brown <lenb@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq/intel_pstate: Do not issue the not supported
 message on !Intel
Thread-Topic: [PATCH] cpufreq/intel_pstate: Do not issue the not supported
 message on !Intel
Thread-Index: AQHU5t+uhlGXK3m4u0G3b51UEffXcaYm91yA
Date:   Mon, 1 Apr 2019 08:11:51 +0000
Message-ID: <fa14666a-269c-249a-f603-b00f6301c1a6@criteo.com>
References: <20190330100225.14744-1-bp@alien8.de>
In-Reply-To: <20190330100225.14744-1-bp@alien8.de>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0379.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::31) To DB8PR04MB6713.eurprd04.prod.outlook.com
 (2603:10a6:10:10e::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [91.199.242.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60340a1a-6639-4794-a5b8-08d6b679b1fe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB8PR04MB5866;
x-ms-traffictypediagnostic: DB8PR04MB5866:
x-microsoft-antispam-prvs: <DB8PR04MB5866776BBE27F6BD6F1F736FF2550@DB8PR04MB5866.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(396003)(39850400004)(376002)(199004)(189003)(229853002)(6512007)(186003)(97736004)(53936002)(6486002)(256004)(6436002)(106356001)(4326008)(105586002)(52116002)(31696002)(5660300002)(6116002)(3846002)(446003)(6246003)(316002)(11346002)(110136005)(476003)(76176011)(54906003)(4744005)(6506007)(386003)(2906002)(486006)(26005)(102836004)(2616005)(8676002)(81156014)(71200400001)(71190400001)(81166006)(68736007)(86362001)(31686004)(8936002)(478600001)(36756003)(305945005)(66066001)(7736002)(99286004)(14454004)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:DB8PR04MB5866;H:DB8PR04MB6713.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: criteo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I0Ol4s52guHP1ctcqe8Owvump4yAw0QHfzlTF140wihlBie0vRPBzYSQuaTbU2t7K7qTFlcKFXTKwtlHqfbVdSQynpq28GjuLoNx37+z7IhaP+ouSfvGzRx3mpBZLw1QF6EVdcCEWjq9S/fTr4FbPn7LEWNv7Tz28cWPxdkyjHw+hmVyRurOLMkTfCbymMpZvzqSPQzjbfNmG8k5hUZRo1QM+xQDD+Biw8U3aiVS5ezewvSz4sL5XoBXsPVxNQVqOgNQQ2llGQYZI6SRwfXeX93VqdTC84VSLyfWvF+dDMjAqykWNRyDXi6SQdd7j1NzzlmDRnZGQfIRp06YzrLlOu+D6jJycLbW6wDlZzn6HXXeWDRE9Ai/xChQrt3hDOLB3c9QnigVPBh2Z9Ykin3Cf9O/8V2Rwy5odovlYbexN0s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F168A6D4E6B19C45BAEF38DB12BAFD9A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60340a1a-6639-4794-a5b8-08d6b679b1fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 08:11:51.5809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5866
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IGluZGV4IGVhNjJlM2YwMmQ1Ni4uMTk4NTRmMDFlMmZhIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMNCj4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2ludGVs
X3BzdGF0ZS5jDQo+IEBAIC0yNjA4LDcgKzI2MDgsOSBAQCBzdGF0aWMgaW50IF9faW5pdCBpbnRl
bF9wc3RhdGVfaW5pdCh2b2lkKQ0KPiAgIAl9IGVsc2Ugew0KPiAgIAkJaWQgPSB4ODZfbWF0Y2hf
Y3B1KGludGVsX3BzdGF0ZV9jcHVfaWRzKTsNCj4gICAJCWlmICghaWQpIHsNCj4gLQkJCXByX2lu
Zm8oIkNQVSBJRCBub3Qgc3VwcG9ydGVkXG4iKTsNCj4gKwkJCWlmIChib290X2NwdV9kYXRhLng4
Nl92ZW5kb3IgPT0gWDg2X1ZFTkRPUl9JTlRFTCkNCj4gKwkJCQlwcl9pbmZvKCJDUFUgbW9kZWwg
bm90IHN1cHBvcnRlZFxuIik7DQo+ICsNCj4gICAJCQlyZXR1cm4gLUVOT0RFVjsNCj4gICAJCX0N
Cg0KVGhhdCdzIGEgZ29vZCBjYXRjaCBidXQgSSB3YXMgd29uZGVyaW5nIHdoeSBub3QgcHV0dGlu
ZyB0aGlzIHZlbmRvciANCmNvbmRpdGlvbiBhdCB0aGUgaW5pdGlhbCAiaWYgKG5vbG9hZCkiIHN0
YXRlbWVudC4NCg0KSSBtZWFuLCBpZiB3ZSBkb24ndCBydW4gYW4gaW50ZWwgQ1BVIHRoZXJlIGlz
IG5vIG5lZWQgb2YgbWFraW5nIHRoZSANCng4Nl9tYXRjaF9jcHUoKS4NCg0KVGhpcyBjb21taXQg
aXMgYWxzbyBraWxsaW5nIHRoZSBjYXNlIG9mIHJlcG9ydGluZyBhbiB1bnN1cHBvcnRlZCBpbnRl
bCANCnByb2Nlc3Nvci4NCg0KDQpJJ2Qgc3VnZ2VzdCBzb21ldGhpbmcgbGlrZSB0aGlzIGFuZCBr
ZWVwIHRoZSAnQ1BVSUQgbm90IHN1cHBvcnRlZCcgcGFydCANCnVudG91Y2hlZC4NCg0KIMKgwqDC
oCBpZiAobm9fbG9hZCkgfHwgKGJvb3RfY3B1X2RhdGEueDg2X3ZlbmRvciAhPSBYODZfVkVORE9S
X0lOVEVMKQ0KDQogwqDCoMKgIMKgwqDCoCByZXR1cm4gLUVOT0RFVg0KDQo=
