Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7030EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C2620823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LPYmDytc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfCYRw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:52:58 -0400
Received: from mail-eopbgr770101.outbound.protection.outlook.com ([40.107.77.101]:43558
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbfCYRw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EeYMdW6Osx+UhhevIA4KH4wyzgVgLD04KCbsq4YOfM=;
 b=LPYmDytc+tdecUQLSDY/1FdoPNJfM4qMpfYdVBicmZcut5xtArjsjCPM3rKPDGsMfI96zd24CjBqCqpDe90QjgibUR1wuBwTCRPKOpG6RimO9p8c+Uu3Rxb/jY98PmMkYLh0oUne9J7nM50z+nrxNteMGtI6DjcvMGnFCtqIrzY=
Received: from DM6PR21MB1305.namprd21.prod.outlook.com (20.179.52.94) by
 DM6PR21MB1324.namprd21.prod.outlook.com (20.179.53.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.1; Mon, 25 Mar 2019 17:52:52 +0000
Received: from DM6PR21MB1305.namprd21.prod.outlook.com
 ([fe80::5d7:1d10:7a44:6620]) by DM6PR21MB1305.namprd21.prod.outlook.com
 ([fe80::5d7:1d10:7a44:6620%7]) with mapi id 15.20.1771.002; Mon, 25 Mar 2019
 17:52:52 +0000
From:   Lakshmi Ramasubramanian <nramas@microsoft.com>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Portable Executable (PE) Signature Validation and Measurement for
 KEXEC system call using IMA
Thread-Topic: Portable Executable (PE) Signature Validation and Measurement
 for KEXEC system call using IMA
Thread-Index: AdTg1clupl0uJvoTS1+4SCE/Pu8WqwCXSF5g
Date:   Mon, 25 Mar 2019 17:52:52 +0000
Message-ID: <DM6PR21MB130526848C86A7390FB3BF53C35E0@DM6PR21MB1305.namprd21.prod.outlook.com>
References: <BYAPR21MB1301CBCD4956476F8F2F0FC4C3430@BYAPR21MB1301.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1301CBCD4956476F8F2F0FC4C3430@BYAPR21MB1301.namprd21.prod.outlook.com>
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
x-originating-ip: [2001:4898:80e8:7:1078:7225:fd33:4f42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23202640-6d6f-4c5c-f589-08d6b14ab3ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR21MB1324;
x-ms-traffictypediagnostic: DM6PR21MB1324:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR21MB1324C744CC946DB7D261BC6BC35E0@DM6PR21MB1324.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(13464003)(189003)(199004)(316002)(33656002)(14444005)(229853002)(8990500004)(10090500001)(53546011)(52536014)(110136005)(6436002)(256004)(6506007)(22452003)(7696005)(81156014)(305945005)(99286004)(105586002)(14454004)(966005)(10290500003)(71190400001)(2906002)(86362001)(102836004)(76176011)(476003)(71200400001)(8676002)(486006)(25786009)(11346002)(2201001)(6306002)(186003)(53936002)(478600001)(106356001)(6116002)(6246003)(6346003)(86612001)(46003)(55016002)(81166006)(8936002)(9686003)(97736004)(2501003)(68736007)(74316002)(5660300002)(7736002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1324;H:DM6PR21MB1305.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nramas@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pWCKIuECeCw78GHKpvEOe94Y9G5D3nCjPjkv9KyOxSSJlCee8pmhTYokHfm4z1zetZfH6KKoHBv4wcHw1I3m3pS1O3MXdrUd7qoHWNpGJylBXuQc31VKVTT9XkQyUBjRn05+DDwSKsjWlV9vvqBJcTM1VmkP5Kds5R7/jAIp7RAadzb/K6wKw+37fX/IO3cO0f3rHlBIXhCov5OZLO35woGYgTyikZXOmyRcZ3FBOa73tEK4b7CrC03xa7STauXKI3F4HAjJen6Fjy85OeUNA1AqiNm7Y7s6ILx3Be3ISplE6uxt99j2gIjgjsehNcyWyFhM0I1+qLqajPCdhFZpxFwhugS8TEz3gVZCWwhHCfctjGlas3D8o/dcwQ6CgAP4xVQlNb/8Gwjy0PKcVInyF99LEMwu5AeSLK3OCS/2D6Y=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23202640-6d6f-4c5c-f589-08d6b14ab3ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 17:52:52.3436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mimi,

Could you please let me know if you have any concerns with this approach?

Thanks,
 -lakshmi

-----Original Message-----
From: linux-integrity-owner@vger.kernel.org <linux-integrity-owner@vger.ker=
nel.org> On Behalf Of Lakshmi Ramasubramanian
Sent: Friday, March 22, 2019 10:39 AM
To: linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Portable Executable (PE) Signature Validation and Measurement for =
KEXEC system call using IMA

Hello,

When loading the new kernel image file for executing KEXEC system call, we =
would like to verify that the kernel image file is signed and the signer ce=
rtificate is valid.=20

If the kernel image file is in Portable Executable (PE) format we want to v=
alidate the PE Signature and measure the signer X.509 certificate (Extend a=
s part of IMA Template defaulting to PCR 10, if not otherwise set,  and the=
 IMA measurement log).

We plan to use Integrity Measurement Architecture (IMA) for the above.

Please let us know if anyone is already working on a patch set for such a f=
unctionality.

I am aware of the work that Thiago Jung Bauermann @ IBM is doing for "Appen=
ded signatures support for IMA appraisal"=20
(Web link given below)

    https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkm=
l.org%2Flkml%2F2018%2F12%2F12%2F1049&amp;data=3D02%7C01%7Cnramas%40microsof=
t.com%7C2791f20f548e4502060108d6aeed54a8%7C72f988bf86f141af91ab2d7cd011db47=
%7C1%7C0%7C636888731683001667&amp;sdata=3Dai2KrDlnyyEqJfLS9kYUw0ebUTbq7Y5dT=
qMciwSRZ%2BM%3D&amp;reserved=3D0

Thank You.
 -lakshmi
