Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9062EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 01:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2098321883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 01:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.onmicrosoft.com header.i=@fortanix.onmicrosoft.com header.b="Zk/4EwZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfIDBPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 21:15:00 -0400
Received: from mail-eopbgr730114.outbound.protection.outlook.com ([40.107.73.114]:63168
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbfIDBPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 21:15:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8UbiOpQPEUzxE/Z4Z9pfQcqKqBOhrMITP3kleCAti7rTcl/hDpNScfRh9LktNID6Mq49oFb7DxXIp+se0dWo0AShiGm66yITrbsfC3IBbm3BV8kbzmyvWyB9W5hyTdwF3Cm5oEID4B3b2u3XFTmukOUvOiJxei5djpHh21XgpwO3o8L7t6FXwK2VAyDZC/iOUSUy1DB4vgr1+x0AzzO1JkZScB/SDXTadLM69LmI/BZguV5JzorTc2awMevl4txZS491yv7Zktyl22vrBz4RYJsQtO6Kc8xUhkuSaTdbwvOE4ltWXNsnf4KbhxR8vz+BH6D+ACtPxbolB7mCQnsqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEELJB33e/WXAxh+I3Iqmn3NMzIRTdgNeca92LdhzJU=;
 b=cC7VLMZKaQHqtMrQF5y7S5tDJU3oAbdFHuOYF7CtF4iqEGE9H/t20Z4gfylXkLNUmkKOPvC5D1nSCropL9btSayGzl5/u01hx+S6t8THp/fUvxxlIpkFuf1aTzm28WIbDwpPZQxg25Dm1PNOhOQIxi6o07o1x1PmYY3VWBdzqEZKmLxSS9p6kuPmKkVdLx6xF4vtHN4b5NI3CzmwQkZKBIW+UgYNcm/8NQGgg8vab8FV/m2E4YTfMxlQwbgw8HrnvmPEtqKrKr+djfddIPlVFnlVQhT9/9m1DWRTgOAfDOi8H/uDaw9IqZguyBLNzGHK/k4arSpFjvVzNXLyuZsFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector2-fortanix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEELJB33e/WXAxh+I3Iqmn3NMzIRTdgNeca92LdhzJU=;
 b=Zk/4EwZhF9YMwPZZyr9XUAWGPHT+sG13UidmEaoZeI7ltszHxN4gXMDqyxvVn/SI06PrCwK9U+yz5xlIltgyZ1zEpWYJ64395A3NuADZiU4apr9pZkUMo1XNsR2hGn/Im96M4G6c7O9A/7/PdoTEYx4zPjbc0cPN94utvM3cVUw=
Received: from DM5PR1101MB2348.namprd11.prod.outlook.com (10.173.174.144) by
 DM5PR1101MB2089.namprd11.prod.outlook.com (10.174.106.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Wed, 4 Sep 2019 01:14:57 +0000
Received: from DM5PR1101MB2348.namprd11.prod.outlook.com
 ([fe80::798a:dabe:a59f:bb42]) by DM5PR1101MB2348.namprd11.prod.outlook.com
 ([fe80::798a:dabe:a59f:bb42%6]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019
 01:14:57 +0000
From:   Jethro Beekman <jethro@fortanix.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jethro Beekman <jethro@fortanix.com>,
        Enrico Weigelt <info@metux.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Support for Intel Cannon Lake SPI flash
Thread-Topic: [PATCH v2 0/2] Support for Intel Cannon Lake SPI flash
Thread-Index: AQHVYr4q8mwj1J9/J0yJS2ASf5BlBw==
Date:   Wed, 4 Sep 2019 01:14:56 +0000
Message-ID: <86b51358-8f54-ecee-3dab-f44db143a37a@fortanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:180::18) To DM5PR1101MB2348.namprd11.prod.outlook.com
 (2603:10b6:3:a8::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jethro@fortanix.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.107.146]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79a3b0f3-4fbb-4550-10cb-08d730d54ca6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR1101MB2089;
x-ms-traffictypediagnostic: DM5PR1101MB2089:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB208946EFCA46BF5A347F132EAAB80@DM5PR1101MB2089.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(346002)(39840400004)(136003)(189003)(199004)(7736002)(25786009)(3846002)(14454004)(2906002)(6486002)(52116002)(5660300002)(6116002)(81166006)(81156014)(31696002)(8676002)(2201001)(508600001)(99286004)(86362001)(6436002)(8936002)(305945005)(4744005)(316002)(66066001)(36756003)(31686004)(110136005)(386003)(71190400001)(1250700005)(6506007)(71200400001)(6512007)(66476007)(66556008)(64756008)(66446008)(102836004)(7416002)(66946007)(53936002)(476003)(2616005)(486006)(256004)(2501003)(186003)(26005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1101MB2089;H:DM5PR1101MB2348.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fortanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P6kovEDCP3rP8G5FRaDLQm9ELk9cGpuNJZ/yvfPAgVhCnGb1li2lHamxNyCtGoMrqqZ4yZBAJ+xPYxnn3xarD5dB6ZK2bwFnn1VJDBFQnyPvEY2mVCZvLJRj/zqcDgY1XslPjxwqBFT38RdF0aKBuPf2OTns3DywmfwENYcyzHtSKg9PHEq4I/7U5ZmlTCcHoeRX+x9d/Agruj/veyQ4Too49CEkPZwvCqBeGWnNSYOiO7NJT1Wx+qt178Dfl9QQ6TLH6V5BqC1tNR6xt7aI5/2cav5C39ZscOsvk8KLXQWVjUpz0hE4NhTZ53+HzBDaaQqYYT/+CUcfXy8vi5ca7ilSeeykI9O3bqgMnpyPiftL9TiQI4Q5TFt9qD//v6k4cDz9nCYQcgYpvn8h1EL0uAxyDu7iH1M9x9ENTPJZ71U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6083003C27C3E40897DFAFFDB751ACD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a3b0f3-4fbb-4550-10cb-08d730d54ca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 01:14:56.9453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUmhcMEZT01SninAi2s+spkAzEo3eQ6WMUlm1sK0I2Ljcf20ZXR+v+QbxZj9m+oQhI4pr6Km6lHMpjtvUspS/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

djIgY2hhbmdlczoNCiogRml4IHdoaXRlc3BhY2UuDQoqIExpbmsgdG8gZGF0YXNoZWV0Lg0KDQpK
ZXRocm8gQmVla21hbiAoMik6DQogIG10ZDogc3BpLW5vcjogaW50ZWwtc3BpOiBzdXBwb3J0IGNo
aXBzIHdpdGhvdXQgc29mdHdhcmUgc2VxdWVuY2VyDQogIG10ZDogc3BpLW5vcjogaW50ZWwtc3Bp
OiBhZGQgc3VwcG9ydCBmb3IgSW50ZWwgQ2Fubm9uIExha2UgU1BJIGZsYXNoDQoNCiBkcml2ZXJz
L210ZC9zcGktbm9yL2ludGVsLXNwaS1wY2kuYyAgICAgfCAgNSArKysrKw0KIGRyaXZlcnMvbXRk
L3NwaS1ub3IvaW50ZWwtc3BpLmMgICAgICAgICB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLQ0KIGluY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9pbnRlbC1zcGkuaCB8ICAx
ICsNCiAzIGZpbGVzIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQoN
Ci0tIA0KMi43LjQNCg0K
