Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F97C46499
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 00:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A84218AD
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 00:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YphLAoX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfGFAFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 20:05:31 -0400
Received: from mail-eopbgr680123.outbound.protection.outlook.com ([40.107.68.123]:41552
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbfGFAFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 20:05:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbKXS/dY9CvCyXj57HGrAGLLvdN2ycdY5RVTU+s9aCBUAsh+1RsdI9tG8IBuJbjie8+qRAQIcL6yzirdEiIGD16ORCK3vNncknC2gqjBW5NLs91Kclvel/CbhBRrnjiYqXZHY6UwgnYZ5lVCJU5h0dvoJoKaYUzbVi/PNE3Kqp8wrTD/Gq4zQPJxI3a3/N0ov9mqOIkyh1Bf5fSAcITY8ch/qarFVLH077+r2k5m5MfG0ovIE7b+vqfgJOF1pWABChl3Kbg0pCDYuWIPfUEhycN+XEgMWZSqtNWnWPape8TZfKa5llivvk4vvtUeZ+zzlAtPn6JcAEQk9Bu+dE5S/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gzc4Xrn4M5mGt2oX7S9QPC72c7MAvWtH6v4dQlKNEGc=;
 b=fdhyDvwpZb5Oknv2kBMA2ecHffwWunn3UCBeCgARcb8Rb5tk3Kx4JPzTSg11f2eeFBOd540q/MF+no2rbBtb8R+L7kiYQ3vROUV95Ntwrh8zHYHuMfg2kMZlhcB+g/thWfpHWUE1KfYMXNU4yGuKS63Pdw48uTEjvmTfeqznzcWvQbRigu/RhpiuLOHAmUzPXcl2go7hYUp3egkHgqhexvpqwPBCOX2YBwFNt+HNl6wrQJGi9xGXsaIfODovQhJNc7QY8Gt3YsiPUq6LuZZcVbbMK554+d95t4R+cu116ihZtsfTZQYbM97XQlB8z6Rrzr5nC67O84hyF6xEenpsYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gzc4Xrn4M5mGt2oX7S9QPC72c7MAvWtH6v4dQlKNEGc=;
 b=YphLAoX2Rmw07+2ib+g7z7WltSj7sYyuhcRe4ZnfAXNBNs22G9BqlKwk5IMrt0b5YGtSk9QIFU14a2Vo60xyHpb2uEC9HyD6CmADfNSz7y1GbWibIMECZ9Xx8E1Zm8c/M3ARRZ2KbhFwlkTQ+8A8vhWwuvGFSp0C6LjS+jDQBl0=
Received: from MWHPR21MB0784.namprd21.prod.outlook.com (10.173.51.150) by
 MWHPR21MB0478.namprd21.prod.outlook.com (10.172.102.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.2; Sat, 6 Jul 2019 00:05:27 +0000
Received: from MWHPR21MB0784.namprd21.prod.outlook.com
 ([fe80::69c0:8cb:908c:f221]) by MWHPR21MB0784.namprd21.prod.outlook.com
 ([fe80::69c0:8cb:908c:f221%8]) with mapi id 15.20.2073.001; Sat, 6 Jul 2019
 00:05:27 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: linux-next: build failure after merge of the kbuild tree
Thread-Topic: linux-next: build failure after merge of the kbuild tree
Thread-Index: AQHVMwwREwrvW6WqyUmShlwUSoJDuKa8teXQ
Date:   Sat, 6 Jul 2019 00:05:27 +0000
Message-ID: <MWHPR21MB07845807FA6F9C772D08C8B5D7F40@MWHPR21MB0784.namprd21.prod.outlook.com>
References: <20190705183104.6fb50bd0@canb.auug.org.au>
In-Reply-To: <20190705183104.6fb50bd0@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-06T00:05:25.4562832Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=98319eec-39c7-42a5-a931-33955c9e4ff7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16efa677-e01c-47a1-844b-08d701a5a6ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0478;
x-ms-traffictypediagnostic: MWHPR21MB0478:
x-microsoft-antispam-prvs: <MWHPR21MB04787BD194BA9DA5FB916823D7F40@MWHPR21MB0478.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:188;
x-forefront-prvs: 00909363D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(199004)(189003)(8936002)(55016002)(71200400001)(6436002)(71190400001)(26005)(52536014)(14454004)(186003)(53936002)(9686003)(5660300002)(10290500003)(4744005)(10090500001)(76116006)(81166006)(305945005)(6246003)(8676002)(478600001)(3846002)(6116002)(81156014)(73956011)(33656002)(110136005)(99286004)(66066001)(68736007)(66446008)(66476007)(22452003)(7736002)(2906002)(102836004)(7696005)(25786009)(8990500004)(86362001)(66946007)(6506007)(256004)(4326008)(64756008)(229853002)(76176011)(486006)(11346002)(54906003)(66556008)(476003)(446003)(316002)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0478;H:MWHPR21MB0784.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3jtgqQR67uRzoqD7RM7EIhtrnfRapd66n4yIRC6zCOFygwOv/i8OalEq7Sm/P7qopCf7soC386RIljTIWaZ1atsIoUtyO9WUl0hDK/fYD7QtwRlOfmgx8tefUqnegd06UtUpO0fzWQGJucWoM6v2pL2X+WCQ+1RbK/lO0oEC/R2auN/FArG+o3kcbMfs8uGJqzoGWJTLb7hszvxtze2DhkbgGVHoZGm7AA/CLzY67FGTsyOgrTxizFX+4UnjTuTturYN6jMhTeVBxlkqxytLc/PAV4+PNiKY5NoEDiKinpqZqZWba/xJ4uniXzsmabNbWrHsHwSOabPgiPIMBFKyf4Gf7FShp1gkKiLBpsdEvB2yCjv8un1bO/JfBeFMIZ5mdiTC89cFZdfRPLNtYGWSdcIAH4GN3HFzxUKWarM4pDY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16efa677-e01c-47a1-844b-08d701a5a6ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2019 00:05:27.3285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mikelley@ntdev.microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>  Sent: Friday, July 5, 2019 1=
:31 AM
>=20
> After merging the kbuild tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
>=20
> In file included from <command-line>:
> include/clocksource/hyperv_timer.h:18:10: fatal error: asm/mshyperv.h: No=
 such file or
> directory
>  #include <asm/mshyperv.h>
>           ^~~~~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   34085aeb5816 ("kbuild: compile-test kernel headers to ensure they are s=
elf-contained")
>=20
> interacting with commit
>=20
>   dd2cb348613b ("clocksource/drivers: Continue making Hyper-V clocksource=
 ISA agnostic")
>=20
> from the tip tree.
>=20

Thomas -- let's remove my two clocksource patches from your 'tip' tree.  I'=
ll need
a little time to fully understand the self-contained header requirements an=
d restructure
hyperv_timer.h to avoid this problem.

Michael
