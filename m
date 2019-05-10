Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04F1C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E70217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mFRD4kAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfEJLXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:23:41 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:61924 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfEJLXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:23:38 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,453,1549954800"; 
   d="scan'208";a="32481293"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 May 2019 04:23:37 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 10 May 2019 04:23:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSG1He/SB9PmzcyV+Nycq1ZBZI+h/GlduqushupIFI8=;
 b=mFRD4kAB2IgOkp+8dX+Xzw+HlqyU5UZk/4t1lcWF9wdf1xrA8dqnmmnT4C2UjG9bEv/8EIWtbjkOmbwOMZ6OF/vgT2gVVH6fR+2dmEE4TyVOOZAHjh1lwSoBaFgtVBm6BS6i5WPoki/3FvC1B3Ow9zeDYBxc3FTdTX+1EqtV80k=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1935.namprd11.prod.outlook.com (10.175.54.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Fri, 10 May 2019 11:23:35 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 11:23:35 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 3/4] dt-bindings: clk: at91: add bindings for SAM9X60's
 slow clock controller
Thread-Topic: [PATCH v3 3/4] dt-bindings: clk: at91: add bindings for
 SAM9X60's slow clock controller
Thread-Index: AQHVByLOKp8OVlW+B0CEXz+NfifVqA==
Date:   Fri, 10 May 2019 11:23:35 +0000
Message-ID: <1557487388-32098-4-git-send-email-claudiu.beznea@microchip.com>
References: <1557487388-32098-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1557487388-32098-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0031.eurprd07.prod.outlook.com
 (2603:10a6:800:90::17) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a9798e9-5941-4513-39b4-08d6d539f0a8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1935;
x-ms-traffictypediagnostic: MWHPR11MB1935:
x-microsoft-antispam-prvs: <MWHPR11MB193509C264E9F8B05A302F61870C0@MWHPR11MB1935.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(366004)(376002)(199004)(189003)(256004)(52116002)(478600001)(3846002)(99286004)(72206003)(68736007)(26005)(5660300002)(6116002)(66446008)(110136005)(107886003)(2906002)(4326008)(186003)(386003)(6506007)(66476007)(64756008)(66946007)(102836004)(66556008)(54906003)(2501003)(76176011)(14454004)(6512007)(73956011)(6436002)(2616005)(6486002)(7736002)(305945005)(53936002)(66066001)(25786009)(316002)(71200400001)(71190400001)(86362001)(11346002)(446003)(8676002)(81166006)(50226002)(36756003)(81156014)(476003)(8936002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1935;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RL1cx9jPLQG/7FHARLkB/zDHbZWDQ/HsOrLbafWOA/6+stpbcrujORE2BDXVSY17Z6T1j3GBKGo84Ln5DdfECwr713B46ZxgP5FZ9OM7COYhk86+3fRwU9qKV2zegosbzB6Z1Pz0/bjBG2hMvTEA6CGrXupD5Ss4kWAxk5v2TLmRKSWscJFPNdIqFAI5uxvKyODFTbRPvyx0Tuw3UCkIVNFCTUweeYNNP+kaACw0izlSATJENkDne1YnShyEo1D+Wk5ah7L3M2ARKVqNd2eMm3uFcj5S1cxKeaoaVTuE70r8aD/G4SQjzdc0gazi5+BuqWY1Ez/F3024aPKokVn87qMLoVYGqStF3QLuDxdzm1ASsr4f3qIprRmjktgHlwvl6eoZohGWwNpn9xmP+J0egHJBdZICW1NzeNnZM02Mewg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9798e9-5941-4513-39b4-08d6d539f0a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 11:23:35.4158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1935
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCkFk
ZCBiaW5kaW5ncyBmb3IgU0FNOVg2MCdzIHNsb3cgY2xvY2sgY29udHJvbGxlci4NCg0KU2lnbmVk
LW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQot
LS0NCg0KSGkgUm9iLA0KDQpJIGRpZG4ndCBhZGRlZCB5b3VyIFJldmlld2VkLWJ5IHRhZyB0byB0
aGlzIHZlcnNpb24gc2luY2UgSSBjaGFuZ2VkDQp0aGUgZHJpdmVyIHdpdGggcmVnYXJkcyB0byBj
bG9jay1jZWxscyBEVCBiaW5kaW5nIChhbmQgSSB0aG91Z2ggeW91DQptYXkgd2FudCB0byBjb21t
ZW50IG9uIHRoaXMpLg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQogRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2F0OTEtY2xvY2sudHh0IHwgNyArKysrLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdDkxLWNs
b2NrLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdDkxLWNs
b2NrLnR4dA0KaW5kZXggYjUyMDI4MGUzM2ZmLi4xM2Y0NWRiM2I2NmQgMTAwNjQ0DQotLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svYXQ5MS1jbG9jay50eHQNCisr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdDkxLWNsb2NrLnR4
dA0KQEAgLTksMTAgKzksMTEgQEAgU2xvdyBDbG9jayBjb250cm9sbGVyOg0KIFJlcXVpcmVkIHBy
b3BlcnRpZXM6DQogLSBjb21wYXRpYmxlIDogc2hhbGwgYmUgb25lIG9mIHRoZSBmb2xsb3dpbmc6
DQogCSJhdG1lbCxhdDkxc2FtOXg1LXNja2MiLA0KLQkiYXRtZWwsc2FtYTVkMy1zY2tjIiBvcg0K
LQkiYXRtZWwsc2FtYTVkNC1zY2tjIjoNCisJImF0bWVsLHNhbWE1ZDMtc2NrYyIsDQorCSJhdG1l
bCxzYW1hNWQ0LXNja2MiIG9yDQorCSJtaWNyb2NoaXAsc2FtOXg2MC1zY2tjIjoNCiAJCWF0OTEg
U0NLQyAoU2xvdyBDbG9jayBDb250cm9sbGVyKQ0KLS0gI2Nsb2NrLWNlbGxzIDogc2hhbGwgYmUg
MC4NCistICNjbG9jay1jZWxscyA6IHNoYWxsIGJlIDEgZm9yICJtaWNyb2NoaXAsc2FtOXg2MC1z
Y2tjIiBvdGhlcndpc2Ugc2hhbGwgYmUgMC4NCiAtIGNsb2NrcyA6IHNoYWxsIGJlIHRoZSBpbnB1
dCBwYXJlbnQgY2xvY2sgcGhhbmRsZSBmb3IgdGhlIGNsb2NrLg0KIA0KIE9wdGlvbmFsIHByb3Bl
cnRpZXM6DQotLSANCjIuNy40DQoNCg==
