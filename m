Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9E0CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5627420679
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="I5Due8/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfKBKhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 06:37:09 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:16514 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfKBKhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 06:37:08 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: bEys7KM6o1qYNwa/fMESzDL5Jlj8pSdGdQ454jUDrnoZcbEK9c6JLiaYgMD4/RbUj3MkP2BEOB
 jAqe8cIeDqpFBu+kXBCpfpfjH+HKAP88Ctkaeq8NWskeTEbaD50KM8Muea3NlopZdVpP0F5Lbt
 WbzcSSWez5u6PfqZmgTcnX9hFRyJ3XQaKZotXy6R32XwZg0fT7a1B/UR73p15olaKEdNDpdcnT
 Sziw3WtzqYGod9vg6I/A1z92Lri/UtGFny6ZNVH5sgrGnsOS0wCwlJCjUzHxKW0Pdh5XwdF6DZ
 Qb8=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="53899190"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 03:37:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 03:37:04 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 2 Nov 2019 03:37:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9iwVbe8r0VbZbg/ZmjNLvpY38tqhAK3AAdhfM4PWDvSvt74QDFT3W/xr4dL3936lTajud5WwqJb1jvvHnyxEzwWw/wE7zshWnBs2fwexJQV9f+puxUzVmrRBJLMRlqTkJ8epz3+VoMm/WPPuwsMCgaTn/bYWJ2WnB4y8E9xs53GNjD+nYJ8ztCVdkp22SsmOWsv8Q7OaLqJkPDpHgIhR7D8XGHPXnv5Axnn4gONgkzU2DOqUjnzTL1fhqFnT33Bh5LXK6qAWHGxya9I1zyCSX+ZF/HjYN8GI81/3qXPPIK3oStvxcHLq6HiypSpwM+LPisqV10Psn4iDfI6xCoQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULXnrUy0H8Ml6ifVtzB0/sE2DOcIVE7ZIxgCyuZ+/48=;
 b=aiLqu0sVvQtvJXA8l3fWtzZHh9MWFv2ayEGqPkKNI3bMwkk6KkHbVKEyiSZA4wlslGStdpkDANLyUr8TB6iC8iP0t1ojH16YMt2qLLdMZeNbwrqJIxHL8WqumkI8XYlXu1vIcZGGpS3JyahHlbqZ5sit+uT+czeips/nbHJ9An6d3u5AYB8kxyC7WLXKnOLrxheLKsY6wqYEjkmL/D9iaVTuT5WmvqrtuoABc0i+e2zrGdTBiZVgg7L3HQHipKpEL5XIXh5IGcIiP0G2xVNghNMGXQjq1T4bZfD++getySvyb1FyodMH/cuQyJaAd9y4dvnQB/sVcP3DaD0/5UIBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULXnrUy0H8Ml6ifVtzB0/sE2DOcIVE7ZIxgCyuZ+/48=;
 b=I5Due8/ht+crec2aBv0cIbItRqAd+EhPigi5kW+W5JtfyBxV1q8zD1aUC2lZi8s+tsSQ+Dp7P0nunk6iaeQeRp63p0miKkOrixTV5Xd51vNpPby3smzqx2+YygMMI/AOjD/+rgFR+UKvs3UK7vNc13YfWn3l4rIFSJ/TZGXguDU=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4223.namprd11.prod.outlook.com (52.135.37.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Sat, 2 Nov 2019 10:37:02 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 10:37:02 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 05/32] mtd: spi-nor: Drop explicit cast to int to
 already int value
Thread-Topic: [PATCH v3 05/32] mtd: spi-nor: Drop explicit cast to int to
 already int value
Thread-Index: AQHVjkpf8ywexjKiGUe8CuXMeClSh6d3tkGA
Date:   Sat, 2 Nov 2019 10:37:02 +0000
Message-ID: <bcfc11d5-51be-4e57-7331-4c6acc2dc12e@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
 <20191029111615.3706-6-tudor.ambarus@microchip.com>
In-Reply-To: <20191029111615.3706-6-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P18901CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::33) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5460e42f-9143-40c6-672a-08d75f80991d
x-ms-traffictypediagnostic: MN2PR11MB4223:
x-microsoft-antispam-prvs: <MN2PR11MB42235718B63F8484D6BC6BFCF07D0@MN2PR11MB4223.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(396003)(346002)(199004)(189003)(8676002)(6436002)(5660300002)(52116002)(36756003)(81166006)(81156014)(486006)(71200400001)(256004)(7736002)(229853002)(71190400001)(25786009)(476003)(99286004)(6486002)(2616005)(54906003)(558084003)(31686004)(478600001)(3846002)(6116002)(2501003)(11346002)(305945005)(2906002)(26005)(446003)(14454004)(186003)(64756008)(4326008)(6246003)(66066001)(6512007)(31696002)(110136005)(53546011)(6506007)(76176011)(66446008)(86362001)(8936002)(386003)(2201001)(66946007)(66476007)(66556008)(102836004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4223;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 35mCUavY+FRwhwB58QYtcW4im+06DyXtWMajSg6Y6z3s0kffD9EbqL2assph2zy3dQvzTM5Nagb06GwXV0pWCt4mvlNxiLBGyetrxUFw5lez3BhlAbR7Yax3OXfhAlDF9h7IU17t8ESvi1658AWM+8LWqwK4ynz7NAQMqGG+je2PdGn1FKGZV1fMFIVYJQWQWPcRG/Wxb0SDKl2eMD6vutDV+NWum1DsWRShQkUARJ007uW7p3eF0iGHBPwqcgi+/tjY232WEcEDTo5S/dyhFrk5s4RhwEvptz2YbYHS+jlNQV4pA7H3VB6KzaHUPvUEyMYjRbUhXIqB4PkXb+prZi14GzZniU2E8uoRLSX6nYi7Mi8IjQ1EnFjD0NROyW/qVUjGLMfOnTgtyLiGECtBcwjx+dVK/YPT4thRKXW4T+W9iv/m1QAKVBjKNZPBS4AX
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8205AB1856AD84AA229BA65795145DC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5460e42f-9143-40c6-672a-08d75f80991d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 10:37:02.8066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f77E6Yr6sJMMTxS9JtyrhUwkktp73BgijxToRNGyTmFfKxszcW9Q3w2P3+JXtt31EbPZRZSFI/NT8ReVW9XflLGseG+K2BnzgV/vCFvlV0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzI5LzIwMTkgMDE6MTYgUE0sIFR1ZG9yIEFtYmFydXMgLSBNMTgwNjQgd3JvdGU6
DQo+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4g
DQo+IHJldCBpcyBhbHJlYWR5IG9mIHR5cGUgaW50Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIHwgMTUgKysrKysrLS0tLS0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KDQpBcHBsaWVkIHRvIHNw
aS1ub3IvbmV4dC4gVGhhbmtzLg0K
