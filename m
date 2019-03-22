Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F6DC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7837D2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PRxLuaK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfCVRj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:39:26 -0400
Received: from mail-eopbgr800124.outbound.protection.outlook.com ([40.107.80.124]:40260
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbfCVRj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWvMF++E9IIBvm3UkyNicHmgIs7K2VJQQpoQLXyRxwk=;
 b=PRxLuaK1MskskxBE/thGZLYrKpHBiIVjGR4tua2WCJZdNtz40tWiPKIytPXZSj+wGYPhBzU5lwzsmmkbFpCW9izYUAas5ofMODzzTXPgRPUttl/vgcUCglqg+xIk1UR/7ddTiaQMtoRhl1ZwsBGFHYUf7oBb2+6puXP2ICWy5+c=
Received: from BYAPR21MB1301.namprd21.prod.outlook.com (20.179.58.83) by
 BYAPR21MB1287.namprd21.prod.outlook.com (20.179.58.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.3; Fri, 22 Mar 2019 17:39:23 +0000
Received: from BYAPR21MB1301.namprd21.prod.outlook.com
 ([fe80::e1e3:1872:e32c:7036]) by BYAPR21MB1301.namprd21.prod.outlook.com
 ([fe80::e1e3:1872:e32c:7036%3]) with mapi id 15.20.1730.008; Fri, 22 Mar 2019
 17:39:23 +0000
From:   Lakshmi Ramasubramanian <nramas@microsoft.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Portable Executable (PE) Signature Validation and Measurement for
 KEXEC system call using IMA
Thread-Topic: Portable Executable (PE) Signature Validation and Measurement
 for KEXEC system call using IMA
Thread-Index: AdTg1clupl0uJvoTS1+4SCE/Pu8Wqw==
Date:   Fri, 22 Mar 2019 17:39:22 +0000
Message-ID: <BYAPR21MB1301CBCD4956476F8F2F0FC4C3430@BYAPR21MB1301.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=nramas@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-22T17:39:21.5499995Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a4e10f41-6446-49fa-9371-9e0f7fbb42e6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2001:4898:80e8:b:2218:ea28:4673:9ba5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ecda19a-c6c7-4559-1d1a-08d6aeed5265
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR21MB1287;
x-ms-traffictypediagnostic: BYAPR21MB1287:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR21MB128774945261DA00C1AE5861C3430@BYAPR21MB1287.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(136003)(346002)(39860400002)(199004)(189003)(86362001)(8936002)(4744005)(7696005)(68736007)(256004)(6306002)(9686003)(33656002)(55016002)(14444005)(6436002)(316002)(22452003)(110136005)(8990500004)(5660300002)(6506007)(2501003)(53936002)(10090500001)(106356001)(478600001)(10290500003)(105586002)(81166006)(81156014)(6346003)(71190400001)(14454004)(966005)(71200400001)(305945005)(2906002)(7736002)(74316002)(97736004)(8676002)(102836004)(25786009)(476003)(486006)(450100002)(186003)(86612001)(99286004)(46003)(52536014)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1287;H:BYAPR21MB1301.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nramas@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +JSCVxivHlRDX6LE/M9EETxxS63mvfkt7oVv5MGI8Koi2pkMLCJom8BvIfETyMnkc8yH1/qM4cdEdKlwuD0+UoamoMqNRzsbA7xIWCkYT3wGTZ/HpdYFCDxks5pdpj9+H/X8Je+PUkWKJTMtvFELgNi9EQUvsQt59Dni9u1tsHVx75Sgbx3Qo+/gklrkWi69QUuZxUPiRC7xwNOMxPZcvsjW1CdBq6pI8XIIPqAbDwHB6W284earQjb2rx4yeEMJLQKDo1ekUana+9GvJXqdf3sxBvf9SQTLUaZyvCgppiAMWZ4VQtWtdiFAQ4q08zJvJmepNru7Qd6g+CIGozOGdFFOtyqymhu0IkiQZvqae4efHBntzyHep5rLB7r7O+if0eUeGuLfbGu2TLyx6C34I8SOIlTwelV9TYfFhtOJOp8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecda19a-c6c7-4559-1d1a-08d6aeed5265
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 17:39:22.9965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1287
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When loading the new kernel image file for executing KEXEC system call,=20
we would like to verify that the kernel image file is signed and=20
the signer certificate is valid.=20

If the kernel image file is in Portable Executable (PE) format we want to=20
validate the PE Signature and measure the signer X.509 certificate=20
(Extend as part of IMA Template defaulting to PCR 10, if not otherwise set,=
=20
 and the IMA measurement log).

We plan to use Integrity Measurement Architecture (IMA) for the above.

Please let us know if anyone is already working on a patch set
for such a functionality.

I am aware of the work that Thiago Jung Bauermann @ IBM is doing for=20
"Appended signatures support for IMA appraisal"=20
(Web link given below)

    https://lkml.org/lkml/2018/12/12/1049

Thank You.
 -lakshmi
