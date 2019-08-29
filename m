Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48FBC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FB92173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Zt6ydK2V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="VAmZ25cV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfH2L0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:26:02 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:34636 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbfH2L0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:26:02 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6BAB9C0169;
        Thu, 29 Aug 2019 11:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567077961; bh=EocaRKKORAS6tZA1bFfHsctjyWTBAaXaKfUQORwS5+Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Zt6ydK2VCgGVSiUDdHkvAusBtrfvvZdIxK1F1pTCABQ0njzvZlmeyxC8zi1hI9V+s
         eBVDq3KZE2p6AqzfZg+M6pbSP/6Qvd9qYxcuk64XVk4do+sDrNirwaeVSxB7oE+o1K
         +L8xU+7mtA7a5hXt99iUFpqHxOqpsgYPMXqKBC0X20IMt43p83rG7jsw1AP0EtJdhm
         JchgpzGxW2tgWiUvnmj+wHAiugng5oprZ1+ffpzQgg5sZn7hSve6MeEWB5ZSWYsb/T
         bkPmVoEQIkuV9QQQqsQVjrs8ULvrDfNGi7jYa1Thqlh+5Qd1SnVV6IsLVPkA72onDu
         trevWD0R5L5vw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E8AF3A023B;
        Thu, 29 Aug 2019 11:25:59 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 29 Aug 2019 04:25:59 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 29 Aug 2019 04:25:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmvvH1CBJnUkWFzLWyZj0wFuyaWaFrp2uZxDPUZwJhHJRlJ5RUcgi7bXGsmbZdWjZhfSmOu+WjbnHkmzE35O+5vj7aLqBm8zU+DRzek/7A3cO0bIoe5dkrjKxyimF/wBrWZzLI6z2m+uk2QlisgWdfgVg0i1ygbnzLVfjHz5s/BFQMreKIhoKMCCqDKCj6vLcWDkJh+9LCgNXWLB2poWb/S528tJsNjpRGwqY0KW5shL8amC/IjlYhwoNZIg0mViuyR7GLx8MLg0DPCab2qj513THqQ/JsXypPn8sqvOOR0p2VF/jVK4O0MSDPedUAajNrAsxCdcr5m66Ms+VmOy2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIv6iUQT967CMrqaTQ0XkL2mQQlTzjFxt6cknbWUvcU=;
 b=hn25X4tW9DNvJ/4LM7CgBNpp10OVSOCj6lGr+Hsxsj39wStsqOVi8lffLzN9QS7G8WODeiiFJ0kp8oP8mFhPLAx06QkxHz4r9nueuiELQ1k+R1Xe9GHuTqLfa6Kiu6KpviUJEXjyAoyeI/HPBRdjHfCRDArccu4HBBO0aC9ZeiD7weCHptInhIjLEg5Aezo1R036LjbxkuE/clcqPWyR+pOrYSUIrrdImU2/wdT/+tQ7S2O6hqJisbQqr4ik+Iz1k8l5ZyGmeFc3a8wVBfa1qAx9bWTMoAfaFxc/E4pJPdEWJ7d7b1TjQV5o/1TzPmsMy7i23a+3HK24gLmCZ40pIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIv6iUQT967CMrqaTQ0XkL2mQQlTzjFxt6cknbWUvcU=;
 b=VAmZ25cV0HQuj6i+DQcAnVFeL7BBIkVLD17EV8Og8fWTQzGYLUJfYn6E+Pflx7AY7hC7zgftFlIScsc8y6Etexl7HhgsVpsocl2yyv6/aoGeHSPEF8Oknzz5GMLTDDsuNfYsvwuB+WutDykb4EW+86UN7ZyD350LNJGrN21Yo5c=
Received: from BY5PR12MB4034.namprd12.prod.outlook.com (52.135.53.73) by
 BY5PR12MB4081.namprd12.prod.outlook.com (52.135.55.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Thu, 29 Aug 2019 11:25:57 +0000
Received: from BY5PR12MB4034.namprd12.prod.outlook.com
 ([fe80::1083:152c:8a76:81de]) by BY5PR12MB4034.namprd12.prod.outlook.com
 ([fe80::1083:152c:8a76:81de%3]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 11:25:57 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] ARC: unwind: Mark expected switch fall-through
Thread-Topic: [PATCH] ARC: unwind: Mark expected switch fall-through
Thread-Index: AQHVV7/v0+5zBKAmz0GpGDpXE1V0v6cRZ/OAgACg9H8=
Date:   Thu, 29 Aug 2019 11:25:57 +0000
Message-ID: <BY5PR12MB403422F37413E42066FCA9BEDEA20@BY5PR12MB4034.namprd12.prod.outlook.com>
References: <20190821012907.GA29165@embeddedor>,<2c3ef09b-bd07-6caf-05a9-908700a60afd@embeddedor.com>
In-Reply-To: <2c3ef09b-bd07-6caf-05a9-908700a60afd@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 663cbc68-6c3a-4ee9-3a26-08d72c73a9e1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR12MB4081;
x-ms-traffictypediagnostic: BY5PR12MB4081:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4081CB9602CA05DA22FFF8B3DEA20@BY5PR12MB4081.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(14444005)(6916009)(478600001)(966005)(316002)(2906002)(8936002)(81166006)(81156014)(8676002)(305945005)(74316002)(4326008)(25786009)(6246003)(107886003)(6436002)(7736002)(14454004)(99286004)(55016002)(6306002)(53936002)(54906003)(9686003)(52536014)(7696005)(76176011)(26005)(71190400001)(71200400001)(6506007)(53546011)(102836004)(33656002)(86362001)(476003)(486006)(11346002)(446003)(186003)(66946007)(91956017)(76116006)(66446008)(64756008)(66556008)(66476007)(5660300002)(66066001)(229853002)(3846002)(256004)(6116002)(485434002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR12MB4081;H:BY5PR12MB4034.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1sbOIpONjK9dBsNm2nakIfD2RjPTipyBZAaH+uH6nSlNi5Hyfvc9OS8ZF/FWoY0Fu/QmvOm7t/ZOu5baGEZ3Zvq+8OedEGHzU983Zew9Fg/G+HFGxMO1Z0GVccQ9xkcqNhqxiwFLvTYFsqtKVwdqmZSZ52CpXYxBjrc+dXcF66AYJ/Bx5tHMNgQWaIzNHX0GTBNTOA2uba/Te4g7Q0LvD8WO/m4gN9+C/rL2GL9tumtS+vRngQZEV6SaExfd8p/TlCkz5rgZr16wVQfnE6BkRrO36gNOi1dkLGelVskR/oIYnZ9KFaEusaVUp3oULqMxxkxxMN+toAKWRoq5eVjMCq5nY2Zk+Vy4/lbIICHQJUoSqR+oT7Bx67ZQ9Vt/hpM0Jcec/Z1qdp2qtWOn+2vKNl4QNd9JIrojO19oaUw8BWs=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 663cbc68-6c3a-4ee9-3a26-08d72c73a9e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 11:25:57.6903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 81jIdrtyoHsGoKMvH/diTwPFr2KalwvIivY+cEgn1MsqZh1kl8DXjGPCfDhknulTKXs/aWNAUAtnSE8/KlsXTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,=0A=
=0A=
I guess this patch is already sent as a pull request to 'v5.3-rc7' by Vinee=
t:=0A=
https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg05854.ht=
ml=0A=
=0A=
---=0A=
 Eugeniy Paltsev=0A=
=0A=
=0A=
________________________________________=0A=
From: linux-snps-arc <linux-snps-arc-bounces@lists.infradead.org> on behalf=
 of Gustavo A. R. Silva <gustavo@embeddedor.com>=0A=
Sent: Thursday, August 29, 2019 04:47=0A=
To: Vineet Gupta=0A=
Cc: linux-snps-arc@lists.infradead.org; linux-kernel@vger.kernel.org=0A=
Subject: Re: [PATCH] ARC: unwind: Mark expected switch fall-through=0A=
=0A=
Hi,=0A=
=0A=
Friendly ping:=0A=
=0A=
Who can take this, please?=0A=
=0A=
Thanks=0A=
--=0A=
Gustavo=0A=
=0A=
On 8/20/19 8:29 PM, Gustavo A. R. Silva wrote:=0A=
> Mark switch cases where we are expecting to fall through.=0A=
>=0A=
> This patch fixes the following warnings (Building: haps_hs_defconfig arc)=
:=0A=
>=0A=
> arch/arc/kernel/unwind.c: In function =91read_pointer=92:=0A=
> ./include/linux/compiler.h:328:5: warning: this statement may fall throug=
h [-Wimplicit-fallthrough=3D]=0A=
>   do {        \=0A=
>      ^=0A=
> ./include/linux/compiler.h:338:2: note: in expansion of macro =91__compil=
etime_assert=92=0A=
>   __compiletime_assert(condition, msg, prefix, suffix)=0A=
>   ^~~~~~~~~~~~~~~~~~~~=0A=
> ./include/linux/compiler.h:350:2: note: in expansion of macro =91_compile=
time_assert=92=0A=
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)=0A=
>   ^~~~~~~~~~~~~~~~~~~=0A=
> ./include/linux/build_bug.h:39:37: note: in expansion of macro =91compile=
time_assert=92=0A=
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)=0A=
>                                      ^~~~~~~~~~~~~~~~~~=0A=
> ./include/linux/build_bug.h:50:2: note: in expansion of macro =91BUILD_BU=
G_ON_MSG=92=0A=
>   BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)=0A=
>   ^~~~~~~~~~~~~~~~=0A=
> arch/arc/kernel/unwind.c:573:3: note: in expansion of macro =91BUILD_BUG_=
ON=92=0A=
>    BUILD_BUG_ON(sizeof(u32) !=3D sizeof(value));=0A=
>    ^~~~~~~~~~~~=0A=
> arch/arc/kernel/unwind.c:575:2: note: here=0A=
>   case DW_EH_PE_native:=0A=
>   ^~~~=0A=
>=0A=
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>=0A=
> ---=0A=
>  arch/arc/kernel/unwind.c | 1 +=0A=
>  1 file changed, 1 insertion(+)=0A=
>=0A=
> diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c=0A=
> index 445e4d702f43..dc05a63516f5 100644=0A=
> --- a/arch/arc/kernel/unwind.c=0A=
> +++ b/arch/arc/kernel/unwind.c=0A=
> @@ -572,6 +572,7 @@ static unsigned long read_pointer(const u8 **pLoc, co=
nst void *end,=0A=
>  #else=0A=
>               BUILD_BUG_ON(sizeof(u32) !=3D sizeof(value));=0A=
>  #endif=0A=
> +             /* Fall through */=0A=
>       case DW_EH_PE_native:=0A=
>               if (end < (const void *)(ptr.pul + 1))=0A=
>                       return 0;=0A=
>=0A=
=0A=
_______________________________________________=0A=
linux-snps-arc mailing list=0A=
linux-snps-arc@lists.infradead.org=0A=
https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.infradead.org_m=
ailman_listinfo_linux-2Dsnps-2Darc&d=3DDwIGaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=
=3DZlJN1MriPUTkBKCrPSx67GmaplEUGcAEk9yPtCLdUXI&m=3DGJ6OJTL5qRgb-RdlLBhiFzZH=
5ZmLXf2lxjuQgwbw7n8&s=3D1TapZixYsKQRFCCPkofjhki-eZ34KmyqojUdAxceNNA&e=3D=0A=
