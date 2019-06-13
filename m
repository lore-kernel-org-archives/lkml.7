Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E39C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEA421773
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kbfqa1M9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfFMPhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:37:55 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:62623 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfFMPhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:37:50 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,369,1557212400"; 
   d="scan'208";a="35722873"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2019 08:37:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 13 Jun 2019 08:37:31 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 13 Jun 2019 08:37:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOZ9+vPbOcFNoSthQyXk2v4olF8WrSzzh6Nv3CHKd2M=;
 b=kbfqa1M9ikRf5H7Hn0J/uT/zV5mHc+bsWbyv+cNfmrZDwnBDndNbPEzaneClhRByaNS97COKyBtRniYAO/i+IFsMjLyU1W4J6tIe99WTnYOVJDbLrG7VfTCBy3n5T982gv+56lu6PwpdWwS0LVQqyP4rv5iO2S3JfplaM0UGn38=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1343.namprd11.prod.outlook.com (10.169.232.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Thu, 13 Jun 2019 15:37:31 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::316b:7774:8db6:30ec]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::316b:7774:8db6:30ec%7]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 15:37:31 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@gmail.com>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 7/7] clk: at91: sckc: use dedicated functions to unregister
 clock
Thread-Topic: [PATCH 7/7] clk: at91: sckc: use dedicated functions to
 unregister clock
Thread-Index: AQHVIf3qCcDPnGZNZEKT8OcqVXuveQ==
Date:   Thu, 13 Jun 2019 15:37:31 +0000
Message-ID: <1560440205-4604-8-git-send-email-claudiu.beznea@microchip.com>
References: <1560440205-4604-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1560440205-4604-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0174.eurprd09.prod.outlook.com
 (2603:10a6:800:120::28) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09a276d2-3e5b-4400-f9b6-08d6f0150a85
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1343;
x-ms-traffictypediagnostic: MWHPR11MB1343:
x-microsoft-antispam-prvs: <MWHPR11MB1343A06916FE767F83D045B187EF0@MWHPR11MB1343.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(396003)(366004)(376002)(136003)(346002)(189003)(199004)(81156014)(14454004)(486006)(102836004)(50226002)(8936002)(81166006)(99286004)(110136005)(71190400001)(71200400001)(54906003)(53936002)(6436002)(316002)(72206003)(68736007)(8676002)(52116002)(478600001)(2501003)(446003)(25786009)(476003)(386003)(5660300002)(2616005)(86362001)(6506007)(36756003)(11346002)(76176011)(64756008)(6512007)(4326008)(26005)(66476007)(66556008)(2906002)(4744005)(6116002)(73956011)(66946007)(66446008)(3846002)(107886003)(7736002)(256004)(6486002)(305945005)(186003)(66066001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1343;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mcUM4w9TL+JPNsvlXd5BVcemipc/pxPpf01hPhHy+z0Ev/Q4Pqhc+YXBN6+J0Wr5qBZTaLCi3ipEQmDRJGbE6VbOhWAIeV/AdLKf7ZldzoWBM4MP8yXvzAwVZSSECFPQTJ/WQTdJIeGWklAB7/1pzewkCRUXE3YNPN85yG2IVr5Nd7agX/z+TiDvqsDmBnzekGJGwjLaBE46giTnKNv5vyVtGe6hlWxHFiX05tr400FKX3Fu4vkmQ3F+HT+wpOX0TUGEjLJvOWViObY5e/UllaP0PWlI0nAG33DdTjR9wjnRDRx1K4X6iilPxywaI/tITc9TOipmw6NLEK0x2FGn1OfQ7XGB0WEVdDAB2Ail+MBXxBWIkGOgPU4h2sAl5uRn8DGe7zenZEc/aPC5/hfrgKLzGqr3r0B8txDgio3Oeio=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a276d2-3e5b-4400-f9b6-08d6f0150a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 15:37:31.4883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: claudiu.beznea@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNClVz
ZSBhdDkxIHNwZWNpZmljIGZ1bmN0aW9ucyB0byBmcmVlIGFsbCByZXNvdXJjZXMgaW4gY2FzZSBv
ZiBlcnJvci4NCg0KU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVh
QG1pY3JvY2hpcC5jb20+DQotLS0NCiBkcml2ZXJzL2Nsay9hdDkxL3Nja2MuYyB8IDQgKystLQ0K
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2Nsay9hdDkxL3Nja2MuYyBiL2RyaXZlcnMvY2xrL2F0OTEvc2NrYy5j
DQppbmRleCBmN2FkM2U5NDE0ZGMuLjQyNTAyODMwYTU2YSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
Y2xrL2F0OTEvc2NrYy5jDQorKysgYi9kcml2ZXJzL2Nsay9hdDkxL3Nja2MuYw0KQEAgLTUxNCwx
MyArNTE0LDEzIEBAIHN0YXRpYyB2b2lkIF9faW5pdCBvZl9zYW05eDYwX3Nja2Nfc2V0dXAoc3Ry
dWN0IGRldmljZV9ub2RlICpucCkNCiAJcmV0dXJuOw0KIA0KIHVucmVnaXN0ZXJfdGRfc2xjazoN
Ci0JY2xrX2h3X3VucmVnaXN0ZXIoY2xrX2RhdGEtPmh3c1sxXSk7DQorCWF0OTFfY2xrX3VucmVn
aXN0ZXJfc2FtOXg1X3Nsb3coY2xrX2RhdGEtPmh3c1sxXSk7DQogdW5yZWdpc3Rlcl9tZF9zbGNr
Og0KIAljbGtfaHdfdW5yZWdpc3RlcihjbGtfZGF0YS0+aHdzWzBdKTsNCiBjbGtfZGF0YV9mcmVl
Og0KIAlrZnJlZShjbGtfZGF0YSk7DQogdW5yZWdpc3Rlcl9zbG93X29zYzoNCi0JY2xrX2h3X3Vu
cmVnaXN0ZXIoc2xvd19vc2MpOw0KKwlhdDkxX2Nsa191bnJlZ2lzdGVyX3Nsb3dfb3NjKHNsb3df
b3NjKTsNCiB1bnJlZ2lzdGVyX3Nsb3dfcmM6DQogCWNsa19od191bnJlZ2lzdGVyKHNsb3dfcmMp
Ow0KIH0NCi0tIA0KMi43LjQNCg0K
