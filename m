Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2556FC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42802082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JsumvsUK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="Je6k7CiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfGIKdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 06:33:24 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:54622 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725947AbfGIKdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 06:33:24 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 90113C0127;
        Tue,  9 Jul 2019 10:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1562668403; bh=3ID/eNgnM54kEEEIv4XlZ/O+E9xDglfl4VK2MpkrqOU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=JsumvsUKc6BMVzr8/qfoPSPddFwQF+AyxBpnVZdDe6/4PxYvTTgfr4c0azG1xfauL
         Au/iTUKgrAQhzwyMzw3uSAGj21CfcXNYaEJrESlw1yGMgCWbfV8DGDNAhaAAshxKNu
         nd7Xk8mhlZ6j3cihPezGTK4AqFS2msBWNupf2hiW1G8wop1CFQj2/WeLFC+N5tCK+7
         NeF07QEbaR7KqJ3spAQoiRyf3UMKUbM53d+jff/Sn5kYaJoHZ3aDIdkWcI49F687U7
         SN+OzGd4SSUhN4YoR4o9q7H1cguwewoUBgmyZ8crCaDp2UVR33OtNA6XljD4HaQ7uB
         aSteUNMSs7voA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B67ACA0069;
        Tue,  9 Jul 2019 10:33:22 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 9 Jul 2019 03:33:22 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 9 Jul 2019 03:33:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjYWJ8yh1941EPOmwR85nb/Ljvk2zHonSgGY2fgXSKQ=;
 b=Je6k7CiUSxZT61Zhdfhvr2DrdnuDBudiyCb5Vftwh1kzxmvbY6IG5hFB8dM3ZRysUhPOKohmecswY2KitzQf6RN3izGESpBS7Ir3D45q00oLqbAEMs4ManTzVdirC7ExBvqIGUWeAe84sO2RkWueLYvHlZyDS5L6gRU1AdDWUh0=
Received: from MN2PR12MB3710.namprd12.prod.outlook.com (10.255.236.23) by
 MN2PR12MB3133.namprd12.prod.outlook.com (20.178.241.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 10:33:18 +0000
Received: from MN2PR12MB3710.namprd12.prod.outlook.com
 ([fe80::8025:feba:c9cf:ba9f]) by MN2PR12MB3710.namprd12.prod.outlook.com
 ([fe80::8025:feba:c9cf:ba9f%3]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 10:33:18 +0000
From:   Luis de Oliveira <Luis.Oliveira@synopsys.com>
To:     Rob Herring <robh@kernel.org>,
        Luis Oliveira <Luis.Oliveira@synopsys.com>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: RE: [PATCH V2 2/2] dt-bindings: Document the DesignWare IP reset
 bindings
Thread-Topic: [PATCH V2 2/2] dt-bindings: Document the DesignWare IP reset
 bindings
Thread-Index: AQHVHH23e2+X/xsJsUq7VXVMGc6J2KbBuOcAgACOyjA=
Date:   Tue, 9 Jul 2019 10:33:18 +0000
Message-ID: <MN2PR12MB371095ABA70D43398ABF982CCBF10@MN2PR12MB3710.namprd12.prod.outlook.com>
References: <1559835388-2578-1-git-send-email-luis.oliveira@synopsys.com>
 <1559835388-2578-3-git-send-email-luis.oliveira@synopsys.com>
 <20190709015220.GA18239@bogus>
In-Reply-To: <20190709015220.GA18239@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lolivei@synopsys.com; 
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9977b52e-b334-484f-e5a5-08d70458db76
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR12MB3133;
x-ms-traffictypediagnostic: MN2PR12MB3133:
x-microsoft-antispam-prvs: <MN2PR12MB313328ECBE02E5B03CF873E3CBF10@MN2PR12MB3133.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(54534003)(37524003)(6636002)(68736007)(478600001)(5660300002)(6436002)(3846002)(6116002)(229853002)(25786009)(446003)(316002)(66446008)(64756008)(66476007)(66556008)(4326008)(54906003)(107886003)(73956011)(110136005)(33656002)(66946007)(486006)(52536014)(476003)(186003)(11346002)(256004)(26005)(8676002)(81166006)(81156014)(71190400001)(74316002)(71200400001)(102836004)(66066001)(8936002)(7736002)(99286004)(76176011)(6506007)(7696005)(86362001)(6246003)(305945005)(9686003)(76116006)(53936002)(14454004)(55016002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR12MB3133;H:MN2PR12MB3710.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ik+Y5CevsidhK5AiS0Uwpu2Goc53762sZ1qel0/nMvLdQKrflYiC2eF3wZADMsyz6T+aNbtidZv0JqaajZ2r6/N25U3va5ZWf2VYPOvdsPvz+3+IP5ZMNxuUgYUEUVsRXdAh5IhptbZFd6IX541EB4+8k5IkiQvv7uWg1d5BCyLV3sN2GATqrqHBB44cwIweXckehFNezdzm6+bs315QBibPFjaC61YKYZTUj2DvAPIUdA1kqc9fderuCqmDkzloytuJo4z/S7J65oENq9PQiogxmjc/cdxMiylUphvty7Df9hd/p2OHZdpFG44Gd7vZwUDW+V60Wp3jdp+W3SKAR9RCqS5OBIzfePxzGsNlxRAZO+ShYINLMo94whIk1+hgTZ92ubNjBTQDM4U6HTwWhBkmO/EYWXsrPsxl/xI0M+I=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9977b52e-b334-484f-e5a5-08d70458db76
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 10:33:18.0920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lolivei@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3133
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the comments,

From: Rob Herring <robh@kernel.org>
Date: Tue, Jul 09, 2019 at 02:52:20

> On Thu, Jun 06, 2019 at 05:36:28PM +0200, Luis Oliveira wrote:
> > This adds documentation of device tree bindings for the
> > DesignWare IP reset controller.
> >=20
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Signed-off-by: Luis Oliveira <luis.oliveira@synopsys.com>
> > ---
> > Changelog
> > - Add active low configuration example
> > - Fix compatible string in the active high example
> >=20
> >  .../devicetree/bindings/reset/snps,dw-reset.txt    | 30 ++++++++++++++=
++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/reset/snps,dw-res=
et.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/reset/snps,dw-reset.txt =
b/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
> > new file mode 100644
> > index 0000000..85f3301
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
> > @@ -0,0 +1,30 @@
> > +Synopsys DesignWare Reset controller
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Please also refer to reset.txt in this directory for common reset
> > +controller binding usage.
> > +
> > +Required properties:
> > +
> > +- compatible: should be one of the following.
> > +	"snps,dw-high-reset" - for active high configuration
> > +	"snps,dw-low-reset" - for active low configuration
>=20
> This is really a standalone block?
>=20
> Are there versions of IP?
>=20

We use this block because is is very simple. The Verilog is autogenerated=20
after an simple input configuration (APB config, reset pin number, active=20
high/low, etc) so it does not need versioning.
We use it in almost all our testchips and prototyping, and it is a=20
standalone block.

> > +
> > +- reg: physical base address of the controller and length of memory ma=
pped
> > +	region.
> > +
> > +- #reset-cells: must be 1.
> > +
> > +example:
> > +
> > +	dw_rst_1: reset-controller@0000 {
> > +		  compatible =3D "snps,dw-high-reset";
> > +	 	  reg =3D <0x0000 0x4>;
> > +		  #reset-cells =3D <1>;
> > +	};
> > +
> > +	dw_rst_2: reset-controller@1000 {i
> > +		  compatible =3D "snps,dw-low-reset";
> > +		  reg =3D <0x1000 0x8>;
> > +		  #reset-cells =3D <1>;
> > +	};
> > --=20
> > 2.7.4
> >=20

Thank you Rob,

Luis

