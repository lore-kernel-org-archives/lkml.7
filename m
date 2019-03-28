Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9FCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE932183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="iUcjMNWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfC1Phx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:37:53 -0400
Received: from mail-eopbgr710077.outbound.protection.outlook.com ([40.107.71.77]:42749
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbfC1Phx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaz+ODJowB7OgL6s3O3KLPf8LjUdFhAEg13OB0YdR2w=;
 b=iUcjMNWpwMQ9onzgjJG+xTfa9/g48yP/x/95GK/g8BkiXv9eUmoZBOQlhWLnGPzMclphDLGCGveuxZt7Clt5d4jo39kXf1sngJ3jLTMLPawQxmU5bD6JXKng/ZZELQxF4hT8Mw7jQhdO4XojencA/wilmxDV/gqdRKb+JYvKiyA=
Received: from MWHPR0501MB3772.namprd05.prod.outlook.com (10.167.163.156) by
 MWHPR0501MB3913.namprd05.prod.outlook.com (10.167.173.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Thu, 28 Mar 2019 15:37:49 +0000
Received: from MWHPR0501MB3772.namprd05.prod.outlook.com
 ([fe80::b9a6:ba16:fc53:bb41]) by MWHPR0501MB3772.namprd05.prod.outlook.com
 ([fe80::b9a6:ba16:fc53:bb41%5]) with mapi id 15.20.1771.007; Thu, 28 Mar 2019
 15:37:49 +0000
From:   Slavomir Kaslev <kaslevs@vmware.com>
To:     "sashal@kernel.org" <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.9 20/87] fs: Make splice() and tee() take into
 account O_NONBLOCK flag on pipes
Thread-Topic: [PATCH AUTOSEL 4.9 20/87] fs: Make splice() and tee() take into
 account O_NONBLOCK flag on pipes
Thread-Index: AQHU5Mnfey1w+A9dv0ipmVXG2EgQJqYhLs+A
Date:   Thu, 28 Mar 2019 15:37:49 +0000
Message-ID: <3c4595fec941c10beaf4bad8df30170b4e950226.camel@vmware.com>
References: <20190327182040.17444-1-sashal@kernel.org>
         <20190327182040.17444-20-sashal@kernel.org>
In-Reply-To: <20190327182040.17444-20-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kaslevs@vmware.com; 
x-originating-ip: [146.247.46.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1be2e20-ee55-4e96-1eb5-08d6b3935591
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0501MB3913;
x-ms-traffictypediagnostic: MWHPR0501MB3913:
x-microsoft-antispam-prvs: <MWHPR0501MB391315433B44801EE2A8FA66DA590@MWHPR0501MB3913.namprd05.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(376002)(366004)(199004)(189003)(6512007)(8936002)(3846002)(6116002)(110136005)(97736004)(26005)(102836004)(316002)(229853002)(478600001)(4744005)(81166006)(81156014)(2616005)(8676002)(5660300002)(71200400001)(2201001)(476003)(486006)(305945005)(66066001)(7736002)(36756003)(99286004)(86362001)(68736007)(71190400001)(256004)(11346002)(106356001)(105586002)(6486002)(118296001)(6436002)(14454004)(6246003)(2906002)(54906003)(4326008)(2501003)(446003)(76176011)(25786009)(53936002)(6506007)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0501MB3913;H:MWHPR0501MB3772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lFMp7vAY53WB8agJcRSnab8mvTVjGCorGt0kYcezSXjm3BMOJh27r72tF1T8wCscrwjGLt8OjsvUUhIGe6urbg9Fny1lAuKosqIMQe3IrVenGrHNb47rjX09uaIYohfZf9b4ac5JxsP4Q31YTwXE/SJ8zdnSH0ZSo2f0w5n5pVgdb4MHbIBZsGTwRhYiZT78HXle6FaRGrIdXAKq4V2VK1jAl2BYAGkPK7hxwvbkj+SrCdKnfbzsSNblWIdmJx64sEALgdMyOTgk1Se2DJsMxEJGTTRH75RJ8xeMyJa0Og4HIeHY1f4rOeheZtolzjwEt4ORT1y9FEFw4nMVh1HHgRu+deq5/IDeUBznh2lpjK2H3yjYxhyjHHRoYenKrugpUbs+tOOSn5TeLFj2Nk/gYc7erOivDHcFRAiPKetrRK8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BFEA5B084D6BA4687709F2F9E315E5E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1be2e20-ee55-4e96-1eb5-08d6b3935591
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 15:37:49.5741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0501MB3913
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTAzLTI3IGF0IDE0OjE5IC0wNDAwLCBTYXNoYSBMZXZpbiB3cm90ZToNCj4g
RnJvbTogU2xhdm9taXIgS2FzbGV2IDxrYXNsZXZzQHZtd2FyZS5jb20+DQo+IA0KPiBbIFVwc3Ry
ZWFtIGNvbW1pdCBlZTVlMDAxMTk2ZDEzNDViOGZlZTI1OTI1ZmY1ZjFkNjc5MzYwODFlIF0NCj4g
DQo+IFRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIHNwbGljZSgpIGFuZCB0ZWUoKSBpZ25v
cmVzIE9fTk9OQkxPQ0sNCj4gc2V0DQo+IG9uIHBpcGUgZmlsZSBkZXNjcmlwdG9ycyBhbmQgY2hl
Y2tzIG9ubHkgdGhlIFNQTElDRV9GX05PTkJMT0NLIGZsYWcNCj4gZm9yDQo+IGJsb2NraW5nIG9u
IHBpcGUgYXJndW1lbnRzLiAgVGhpcyBpcyBpbmNvbnNpc3RlbnQgc2luY2Ugc3BsaWNlKCktaW5n
DQo+IGZyb20vdG8gbm9uLXBpcGUgZmlsZSBkZXNjcmlwdG9ycyBkb2VzIHRha2UgT19OT05CTE9D
SyBpbnRvDQo+IGNvbnNpZGVyYXRpb24uDQo+IA0KPiBGaXggdGhpcyBieSBwcm9tb3RpbmcgT19O
T05CTE9DSywgd2hlbiBzZXQgb24gYSBwaXBlLCB0bw0KPiBTUExJQ0VfRl9OT05CTE9DSy4NCg0K
SGV5IFNhc2hhLA0KDQpJIGRvbid0IHRoaW5rIHRoYXQgdGhpcyBwYXRjaCBzaG91bGQgYmUgbWVy
Z2VkIHRvIHN0YWJsZSBrZXJuZWxzLiBJdCdzDQptb3JlIG9mIGEgZmVhdHVyZSByYXRoZXIgdGhh
biBhIGJ1Zy9yZWdyZXNzaW9uIGZpeCBhbmQgaXQgY2hhbmdlcyBob3cNCnNwbGljZSgpIGhhcyBi
ZWVuIHdvcmtpbmcgZnJvbSBkYXkgb25lLg0KDQpDYW4geW91IHBsZWFzZSBkcm9wIGl0IGZyb20g
dGhlIHN0YWJsZSBxdWV1ZXM/DQoNClRoYW5rcywNCg0KLS0gU2xhdmkNCg==
