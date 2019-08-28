Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27762C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EC02173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="aOKMzBxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfH1GL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:11:26 -0400
Received: from mail-eopbgr700040.outbound.protection.outlook.com ([40.107.70.40]:14177
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbfH1GL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:11:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EK2ca0UwFwv2Lqo8fwB3YOo3h2l4mdWYqU+xs7TNcfBCThCIMzZEnDz+EW2ADwRATnQRyBth1d2rjjzHBs8abidmn+dvfEjwQIAZ2Vx2UeEe6F2GGw7n/ri9EhAbopP7cpuSsJQK6j3+qnPxRTN7spNQneRRwf6H/SDYEUP4xODbn31MwDxU2fLxmScqhZk1qbdD50e2TJqDROBZHzZ1UP5ae+rEZnIk5tXbDbOIWRWtMvl4uTk7zM0b/2Hj3NZuEGm+p+DuvQ52FqhDLurGIYfiG9dEz/Bw+fXKQkMYZw8Nsr9FJGrEiVmKYjEKqUx+r1bI0Z2uu9BUyTZVCCt/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGpE63J3u/bXrLMI4LFs5+4k3hv9G4uzthqViaUDK8Y=;
 b=PUwYRSiADrBEZd23brmhyPIbailHkihTzwkxOWfxJnMFBN0xT/8mN61d9CImWgYZRd1DXd5SnaOqiWGGjN2djEuuEAewD/lOAKb6JEuFJv37VVeWcymnHVjwZZYdHfQ0j5KzBybxXX26nAUQcTjbz4HPhWThv/JREMmLlPRpLqk86693kHJN7g9iO/ud6r1z0GUDNInFydlM6GBJBgyqKXvK7Br/5bZrwp5i0cWWqpydJoHyFZ66Czj7ZoOKMItAMH/ouF1QlSWJfKt1w6X4Ko1WIq4HFsp7C/PWaDJw+wlRhctieoxY2n6kEAIIWaKvvFPfn+vdru8eFV8u+Zli/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGpE63J3u/bXrLMI4LFs5+4k3hv9G4uzthqViaUDK8Y=;
 b=aOKMzBxUhG5qeXSWKagJBR0IS9RGiRD3QLBOsx/ECNgGK9d6U77UhD9Bu/UGp4BWKUoPHYqn3uqzj1RGIq0mibFjFPt/6uicHkBdPJ6GctHgUpRQMCHQlNaEAXgfBSW0Peb3ChWs8lyorjjojbJkZPmCQJ3Ko0sQAoD8+Bhefwc=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4503.namprd03.prod.outlook.com (20.178.49.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 06:11:23 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 06:11:23 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v2 5/8] dt-bindings: sy8824x: Document SY20276 support
Thread-Topic: [PATCH v2 5/8] dt-bindings: sy8824x: Document SY20276 support
Thread-Index: AQHVXWdrWeANySZyR0K4TjLC7mqiHQ==
Date:   Wed, 28 Aug 2019 06:11:23 +0000
Message-ID: <20190828140006.6223f958@xhacker.debian>
References: <20190828135646.52457ac3@xhacker.debian>
In-Reply-To: <20190828135646.52457ac3@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:404:a::14) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eed70e70-dbc5-4b21-e4b4-08d72b7e8d88
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4503;
x-ms-traffictypediagnostic: BYAPR03MB4503:
x-microsoft-antispam-prvs: <BYAPR03MB450392ECFBAD812CC087FA14EDA30@BYAPR03MB4503.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(66946007)(66556008)(386003)(64756008)(6506007)(52116002)(5660300002)(66446008)(71200400001)(81166006)(76176011)(71190400001)(99286004)(6512007)(9686003)(14444005)(4744005)(81156014)(4326008)(14454004)(54906003)(66476007)(6486002)(102836004)(26005)(186003)(50226002)(1076003)(25786009)(6436002)(8676002)(8936002)(7736002)(478600001)(2906002)(6116002)(305945005)(53936002)(86362001)(3846002)(110136005)(66066001)(11346002)(256004)(486006)(476003)(446003)(316002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4503;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vElXjHjyr9G4QKr3yj1FbF0LBdfLOAbSJy5gRVq1+toXsawRr8EK3bOTB3iL+/pQopkxnin68o5vLrQqulFT7ffco5e0M1XNUx70d6pEBc8d/a+3klY66Sy3WR3JqwdtsnPhqgERKfAUohv6e3x/NT6oi90HXZrJy/mnVHQx9Dfe4a4vrcgAFwfb7kBplzYizxftEyx+2RymqvoHHl9v0P+gRHILmeZ1UISlf/WSpjhd7m9zwRCM17ZXhApeBWkE7vFCuEKMdHy+1oJvvDZDjUabjEYdLUf5083TfEd1N1AkuaedqkiAiAsWTBHqqwfq5Yidb/dhvZS35RfJ0N5C4X2QwIKzk6oMfGOspCntuxFpb75fVftSx9l9vilUuUPatYqrAZsri/jEpWqKRBpuRfjhAnBx+aSQYCpjdHoKjnA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B546BCD7F86DC145949DDB394FB427BA@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed70e70-dbc5-4b21-e4b4-08d72b7e8d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 06:11:23.9365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +YBZJJ4+YyhRiDZeBqpKnmYUPSF7jFZf4+2iKej2jgVdNOd96jn8JJ+iIW8iC6VuZvY92daft2iIK3IxCb6JqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SY20276 is an I2C-controlled adjustable voltage regulator made by
Silergy Corp. The differences between SY8824C and SY20276 are
different vsel_min, vsel_step, vsel_count and regs for mode/enable.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/regulator/sy8824x.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/sy8824x.txt b/Docu=
mentation/devicetree/bindings/regulator/sy8824x.txt
index 31fefa3baa71..28600541b5de 100644
--- a/Documentation/devicetree/bindings/regulator/sy8824x.txt
+++ b/Documentation/devicetree/bindings/regulator/sy8824x.txt
@@ -1,9 +1,10 @@
-SY8824C/SY8824E Voltage regulator
+SY8824C/SY8824E/SY20276 Voltage regulator
=20
 Required properties:
 - compatible: Must be one of the following.
 	"silergy,sy8824c"
 	"silergy,sy8824e"
+	"silergy,sy20276"
 - reg: I2C slave address
=20
 Any property defined as part of the core regulator binding, defined in
--=20
2.23.0.rc1

