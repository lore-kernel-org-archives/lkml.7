Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F820C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D85206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eDufUeoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfCEBbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:31:50 -0500
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:7366
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726095AbfCEBbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 20:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ0sZKuOdUJl5ZUGg1HcGw8V9oJ2L81R+WQTf7BCO8I=;
 b=eDufUeoDsjefvXn3chRprrtkXpcPmYmHKf6fe8GIgcskjzG8aYrrinK8b2/NjzfoqDheMpPW3hYum1CBJQ23a8ErGsBY9L3Lfla10ARfq6BIlPjfKLef4G+GYIw/hcIS90vWFm6pJyM5tw0gW8er5azlL9Xx02msjlPY0JIx3VY=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.16) by
 DB7PR04MB3964.eurprd04.prod.outlook.com (52.134.107.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Tue, 5 Mar 2019 01:31:43 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::cda3:5f5:6a0:df0e]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::cda3:5f5:6a0:df0e%5]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 01:31:43 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "dennis@kernel.org" <dennis@kernel.org>
CC:     "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH 2/2] percpu: pcpu_next_md_free_region: inclusive check for
 PCPU_BITMAP_BLOCK_BITS
Thread-Topic: [PATCH 2/2] percpu: pcpu_next_md_free_region: inclusive check
 for PCPU_BITMAP_BLOCK_BITS
Thread-Index: AQHU0nXEG16tPwZG4EKC+VpW/1eoj6X70ymAgABtc+A=
Date:   Tue, 5 Mar 2019 01:31:43 +0000
Message-ID: <DB7PR04MB4490859B718948F4AABCEBE788720@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <20190304104541.25745-1-peng.fan@nxp.com>
 <20190304104541.25745-2-peng.fan@nxp.com>
 <20190304185657.GA17970@dennisz-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190304185657.GA17970@dennisz-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17ff188f-22e2-4729-8f55-08d6a10a52f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB3964;
x-ms-traffictypediagnostic: DB7PR04MB3964:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjdQUjA0TUIzOTY0OzIzOkFIVTBxM1NtcHR6aWx6Qk9vWkVhNWRNZHEv?=
 =?gb2312?B?TE1Ic0tPZndFZitTNXNqMllJUFdFQnZWUEdQWHFpZ2FSdUs1TWRWSGwzUERi?=
 =?gb2312?B?N25lSUhMUTlIY00rUjcxUFBxdmo3RmZrQmVJcERTdGErZWRWcElWU0xMTkRY?=
 =?gb2312?B?OTM1QTFVSEE1UkY5S25vL2R3d3lNUFE0WHhKa0RXSUpCck0vK1AzenIzdjl4?=
 =?gb2312?B?U1VhYWRranlNaEkxY1hPT09YSnA4L05zUENPT25qQ3BlNUU3M3hoSnQ3Rlc4?=
 =?gb2312?B?ODJLODhpS2RlYW9oSmkyWkhtZ1MxSmNNd29OZ0huWkdTNTZIY0NkZ1A0YnZH?=
 =?gb2312?B?QWxtbEx4ZXRud2VjMmN2SGJkYzFHdGNWZnhTUzNBdVJmRXp3cmh1ZVBRbjJr?=
 =?gb2312?B?cmZ1UnNtS0k0OVRUMXB3Z3E0M3EvUFRsd0RBMDZzR0JOODJnY0dDVHpGQ0FB?=
 =?gb2312?B?anRBcEkwUkdMendCMVIzYzdzUzMxSWMzNmwwUDg5NkxnNEVpQk5Ka2l3cHlM?=
 =?gb2312?B?OG9SWFNXaGc4Mm01MkdLQ0VRUXlHUnJIb2JOb3pQeXY5UGo5WUZ4aFl0akM3?=
 =?gb2312?B?MS9pMnhTZUhRZkN0dVZMMmMzQ01TckpsV04waDlvMzNSM2NvT1kyOWQ1YXVI?=
 =?gb2312?B?b2NmSE1jbUUxWm5TNTBsb3FHN3ZlNTBYQXdmQzRVTkVXWXlDakdLVmRld2Qw?=
 =?gb2312?B?ZDMzU1B1ZUtRcXpWUUNDUS9LM2lHczdZczBNUDJXVFBLYS9WaUtQaUtpSWVT?=
 =?gb2312?B?MktQSU5ueXdIdXF4NzVNa1ZhSDAzdzlVbWFZd3VnWHFNVUhLSEI5U2pKRVlh?=
 =?gb2312?B?U2M5dXFjSlBIWjFWSkdwelIydVVLTmVIWnZtRENpUTNKVTJWeTJHNkVrNXdW?=
 =?gb2312?B?ZTAwMXBiVTAvbVY0eGREcGlDd1BRVS9qYi85RUM4SmFYZHlxZThvY09QVVpG?=
 =?gb2312?B?WWFQN0RONDFZZ1ptUVlJNmR0eHpObDJ6c1hpY3ZIY2UxOHpxQ2tCRDdUMjNY?=
 =?gb2312?B?K0xYVHJTVk1HbUVZclRxZ3dobTkzZUJxUmFsQzNyclhzR3BRNFF0enFzc1JX?=
 =?gb2312?B?d3BaeDdwUHRCMDRnZFMzOTZQMjZMbUdkVkx0SWxHTWJUUmxHVUgreDZQblNi?=
 =?gb2312?B?WG8rNzYxTmZ0ZGFialNIYXcrenVGM3lCcENoUEpZa1BCbHQrTXVnV1k1RXB3?=
 =?gb2312?B?Wjd6V2JKdUt5bWh0QmhQc3ZBZ0VjTERMQ1hZZWs3V0EyLzN4ODZRbFQvbUNs?=
 =?gb2312?B?UzJBY3RpWTVER2xnbDNDNVJZRk1rU2RTbUZDeC94RC9jdEExZURuQ2hRUmts?=
 =?gb2312?B?VlQzM2FOVnplZDU0U2lhYU9uZlpuVEx4UVZrYUU5REZ0RWtmMTJDeFNKUVFk?=
 =?gb2312?B?YjMzVXZHcHFBQTg2UGdNNnJHRWNuSFg3b3FyOG5jMDY5dWpaUWhVeE9yMFhY?=
 =?gb2312?B?YVQzZjhIY2hVYnoyY1pOa3ZwKytqVFFsY09nUFFVeGJRR2FVNVF0emdoQnlI?=
 =?gb2312?B?ZXNFdy9pRDVIbW1ScVZyc0xTOEdrbHFheTBMVjU2czVVNFdGNkJSeERwMEFH?=
 =?gb2312?B?bFhYK21UOTBqK1BKM3A0OUR6U09kOFBlVXFsNWkrZzJUcXJWMzQvVFRYNDZk?=
 =?gb2312?B?aW12aXZ5YXpXbFMwdU1lYlNpOVZsUzV5c3FqNVgxR3dYS0F3VmJMdHY2NTdI?=
 =?gb2312?B?a0puQWVZc2JZbGlnck01QXBQYXg3K1daK1M0TUhLb3pabit2Wk00L2RuaHVw?=
 =?gb2312?B?UVFLY0lnOXlGNXJzYmNBYVR0RVNPazNrWmhHZlIvT09PeEExeXF1RDgvdnpU?=
 =?gb2312?B?MUp4a2NXVXdNM080OVpHcVowVEVIWjN6TUpsRW9KVmcvdE5zVVFKODNSVzYy?=
 =?gb2312?B?WndrVmUwU2poNDBONVUwbTJKQWtUbzlCKzk4NDN2QURKZ3JqWVJkRk5TbWt6?=
 =?gb2312?B?bjlZbmtuSTlQS0p6VVpEejM3djgyWUZMakNUbS9obWZ5V2czRlBoVHpjaTda?=
 =?gb2312?Q?yEDOh8?=
x-microsoft-antispam-prvs: <DB7PR04MB39642908F7B0944914D8D5DB88720@DB7PR04MB3964.eurprd04.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(396003)(346002)(376002)(199004)(189003)(13464003)(99286004)(14454004)(74316002)(52536013)(33656002)(316002)(7736002)(54906003)(305945005)(6916009)(6346003)(2906002)(26005)(186003)(6506007)(53546011)(102836004)(66066001)(966005)(7696005)(76176011)(4326008)(478600001)(45080400002)(97736004)(5660300002)(71190400001)(71200400001)(68736007)(55016002)(8936002)(8676002)(81156014)(81166006)(2351001)(25786009)(1730700003)(106356001)(105586002)(486006)(53936002)(6246003)(476003)(446003)(11346002)(6306002)(44832011)(256004)(9686003)(86362001)(14444005)(6436002)(2501003)(3846002)(5640700003)(6116002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB3964;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bY4DDJDm7m+gEBv/+XzmShazfv0nokFQRvEhLFtUdPWuiL9RqJWY1pJiniBN/TZgtEZXsoTfncSg6YFKXN0AfEe1cu8OQ+25aMqmpYzNlKAQO8HGtyxWvo2EE2eMWbKwUjwjubP+IdF+/L5zfaMW9QcCn8YeNYKWN6uKUs8iWShA4NrJFcEw2DF1xIg2Lebk+odk+UmnqwP1BdejdIkPl/6MzxRIdUcoQTDVdEa+CVf0n3n/bmbLgrN41ScMhbRE1eqTV2uUPHNGtGWi6KEeJvqm/CL6SnKydl60mJIkxI45V15rUbIiKfN4ZBIWvj0cHWxFkVoMQCNSRtiuMxDA5X3Uyu9Z+e8zioCsUPzPdQ6tCG/ORdK29FO5qCkASY1QYaYuzhvVJ8S0dwehVLXPUnVyhkOM7is6sX8ZnK/pxAE=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ff188f-22e2-4729-8f55-08d6a10a52f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 01:31:43.1164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3964
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogZGVubmlzQGtlcm5lbC5v
cmcgW21haWx0bzpkZW5uaXNAa2VybmVsLm9yZ10NCj4gU2VudDogMjAxOcTqM9TCNcjVIDI6NTcN
Cj4gVG86IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiBDYzogdGpAa2VybmVsLm9yZzsg
Y2xAbGludXguY29tOyBsaW51eC1tbUBrdmFjay5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IHZhbi5mcmVlbml4QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIv
Ml0gcGVyY3B1OiBwY3B1X25leHRfbWRfZnJlZV9yZWdpb246IGluY2x1c2l2ZSBjaGVjaw0KPiBm
b3IgUENQVV9CSVRNQVBfQkxPQ0tfQklUUw0KPiANCj4gSGkgUGVuZywNCj4gDQo+IE9uIE1vbiwg
TWFyIDA0LCAyMDE5IGF0IDEwOjMzOjU1QU0gKzAwMDAsIFBlbmcgRmFuIHdyb3RlOg0KPiA+IElm
IHRoZSBibG9jayBbY29udGlnX2hpbnRfc3RhcnQsIGNvbnRpZ19oaW50X3N0YXJ0ICsgY29udGln
X2hpbnQpDQo+ID4gbWF0Y2hlcyBibG9jay0+cmlnaHRfZnJlZSBhcmVhLCBuZWVkIHVzZSAiPD0i
LCBub3QgIjwiLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQo+ID4gLS0tDQo+ID4NCj4gPiBWMToNCj4gPiAgIEJhc2VkIG9uDQo+IGh0dHBzOi8v
ZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYl
MkZwYXRjDQo+IGh3b3JrLmtlcm5lbC5vcmclMkZjb3ZlciUyRjEwODMyNDU5JTJGJmFtcDtkYXRh
PTAyJTdDMDElN0NwZW5nLmYNCj4gYW4lNDBueHAuY29tJTdDNjU0NmRmY2M4NWYwNDkyZDdjNzUw
OGQ2YTBkMzMwNzYlN0M2ODZlYTFkM2JjMmINCj4gNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdD
MCU3QzYzNjg3MzIyNjI0MTE4NTUzNCZhbXA7c2RhdGE9OQ0KPiBhekl3OHZYSjhlcXFkMFQwem5t
RU42alIyY1doRmdoS0JmZzB6SUpNRE0lM0QmYW1wO3Jlc2VydmVkPTANCj4gYXBwbGllZCBsaW51
eC1uZXh0DQo+ID4gICBib290IHRlc3Qgb24gcWVtdSBhYXJjaDY0DQo+ID4NCj4gPiAgbW0vcGVy
Y3B1LmMgfCAzICsrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbW0vcGVyY3B1LmMgYi9tbS9wZXJjcHUu
YyBpbmRleA0KPiA+IDVlZTkwZmMzNGVhMy4uMGY5MWYxZDg4M2M2IDEwMDY0NA0KPiA+IC0tLSBh
L21tL3BlcmNwdS5jDQo+ID4gKysrIGIvbW0vcGVyY3B1LmMNCj4gPiBAQCAtMzkwLDcgKzM5MCw4
IEBAIHN0YXRpYyB2b2lkIHBjcHVfbmV4dF9tZF9mcmVlX3JlZ2lvbihzdHJ1Y3QNCj4gcGNwdV9j
aHVuayAqY2h1bmssIGludCAqYml0X29mZiwNCj4gPiAgCQkgKi8NCj4gPiAgCQkqYml0cyA9IGJs
b2NrLT5jb250aWdfaGludDsNCj4gPiAgCQlpZiAoKmJpdHMgJiYgYmxvY2stPmNvbnRpZ19oaW50
X3N0YXJ0ID49IGJsb2NrX29mZiAmJg0KPiA+IC0JCSAgICAqYml0cyArIGJsb2NrLT5jb250aWdf
aGludF9zdGFydCA8IFBDUFVfQklUTUFQX0JMT0NLX0JJVFMpDQo+IHsNCj4gPiArCQkgICAgKmJp
dHMgKyBibG9jay0+Y29udGlnX2hpbnRfc3RhcnQgPD0NCj4gPiArCQkgICAgUENQVV9CSVRNQVBf
QkxPQ0tfQklUUykgew0KPiA+ICAJCQkqYml0X29mZiA9IHBjcHVfYmxvY2tfb2ZmX3RvX29mZihp
LA0KPiA+ICAJCQkJCWJsb2NrLT5jb250aWdfaGludF9zdGFydCk7DQo+ID4gIAkJCXJldHVybjsN
Cj4gPiAtLQ0KPiA+IDIuMTYuNA0KPiA+DQo+IA0KPiBUaGlzIGlzIHdyb25nLiBUaGlzIGl0ZXJh
dG9yIGlzIGZvciB1cGRhdGluZyBjb250aWcgaGludHMgYW5kIG5vdCBmb3INCj4gZmluZGluZyBm
aXQuDQoNCkkgbWlzc2VkIHRvIGNvbnNpZGVyIHRoZSBjYXNlIHRoZSB3aGVuIGNvbnRpZ19oaW50
X3N0YXJ0IG1hdGNoZXMNCnJpZ2h0X2ZyZWUgYXJlYSwgdGhlIHJpZ2h0X2ZyZWUgYXJlYSB3aWxs
IGJlIHRha2UgaW50byBjb25zaWRlcmF0aW9uDQppbnRvIG5leHQgbG9vcC4NCg0KPiANCj4gSGF2
ZSB5b3UgdHJpZWQgcmVwcm9kdWNpbmcgYW5kIHByb3ZpbmcgdGhlIGlzc3VlIHlvdSBhcmUgc2Vl
aW5nPyBJbg0KPiBnZW5lcmFsLCBtYWtpbmcgY2hhbmdlcyB0byBwZXJjcHUgY2FycmllcyBhIGxv
dCBvZiByaXNrLiBJIHJlYWxseSBvbmx5DQo+IHdhbnQgdG8gYmUgdGFraW5nIGNvZGUgdGhhdCBp
cyBwcm92YWJseSBzb2x2aW5nIGEgcHJvYmxlbSBhbmQgbm90DQo+IHN1cHBvcnRlZCBieSBqdXN0
IGNvZGUgaW5zcGVjdGlvbi4gQm9vdCB0ZXN0aW5nIGZvciBhIGNoYW5nZSBsaWtlIHRoaXMNCj4g
aXMgcmVhbGx5IG5vdCBlbm91Z2ggYXMgd2UgbmVlZCB0byBiZSBzdXJlIGNoYW5nZXMgbGlrZSB0
aGVzZSBhcmUNCj4gY29ycmVjdC4NCg0KSSdsbCBiZSBjYXJlZnVsIGZvciBmdXR1cmUgcGF0Y2hl
cy4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gVGhhbmtzLA0KPiBEZW5uaXMNCg==
