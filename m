Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489A9C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071C82184B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SHZqsjk2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="AOGDzevZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389115AbfGQSfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 14:35:25 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:37986 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727377AbfGQSfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 14:35:25 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CAE42C2962;
        Wed, 17 Jul 2019 18:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563388524; bh=prrW1Ndm7Bdq3WM62kogpc9GH1kqMmi6FD47AxwU2nE=;
        h=From:To:CC:Subject:Date:References:From;
        b=SHZqsjk2x+Bnuymsx/kt+qURLS9X39vmjXdsYu9zXkazQDuep/wU2/t7X5zkn8ghL
         SzfEMGQVcF5fo/AGm57jNsMdcbSHY3RdzZYONL+wGwaoMPJL1+R3Kg27VhPLLepcBd
         mVfadtWdXtRs78CFWqFiCw1W3qD/oM6ic4LwSp1kV2oJLfdohT3sTdJbrcxcukqdzB
         YxXAy/0aa0dwFYb+dktgx+vqJ7vvEGbQHou7fAp6f75pk1I2QOznFcYXvD5bzZZCII
         hjUYEllMIQu2y2MVRWAQv2u/p2l03OM6cLysBK1YqX3+DKf9ZQ374nx8hE34wjQ1b6
         Ct7zBIKy/LuEw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id BB80DA009F;
        Wed, 17 Jul 2019 18:35:20 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 17 Jul 2019 11:35:07 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 17 Jul 2019 11:35:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVWw5xiE5yqUH4k/FT1GQIKnAPYBJWTL4e15VcCuLW9RVr4s3pKYHQqYwFhzr4dUgbPEk8W/zHZvi8CVWdmsws08A+fuUoFPBilBd6NlgzzA+uALf6osIgBGw8rGPD0oYuPw5R0H/fM/OhX4Bt1mt3la9y2up3Yd5ik9iB+G21f41UZC9da9Klg5iT9f8gIJKiX3hG4bYVjzrwOCgf8xpICd87+/I4ofCdSql+cmf/A4cfq0yIgsChhfA3QZRQkTp5SFy2Df8cBdGsTl456VQWYdiKz4briZnqB+LSoX09FXdAS5AkYRGsh3ufR2XlvTMJHX8aPv4xSKwCetr5MowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3mNfbxTclfRCoJ5x4d8zRoFCRBS7pDYJ86mL5d4ivw=;
 b=BFgXWg0EGGgIAFrWRNblJV2S4tLnAKrjFreRvjcOT8qiwmdOhkwO+a/W0BgctSa3s0LTLdtvaNqpmRqB1TPkYqVOoS8J/QVpKbIaIt9oe5PTrAul56BlRO7gmBNwgckyfcqJAY7jFfDCMGtbUYzb1NRxNGtDswXHUYsjA5F4XCID496lcibyLH/1JzN+Ptzc2dtM+sh6FicpNJ34WmE2r9cgL2jUKV1w+UlHUcGGId6767iMVM7DwZkv2338Id+wWx9lI6b7jFJM4S3yxtHT4uUR1/k4VWJOLHDwBckHbyIfiWH5M20Dysz/xpD2d78aDU5OJvZASLF+PL84qBfyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=synopsys.com;dmarc=pass action=none
 header.from=synopsys.com;dkim=pass header.d=synopsys.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3mNfbxTclfRCoJ5x4d8zRoFCRBS7pDYJ86mL5d4ivw=;
 b=AOGDzevZBKA/BExTnUBMKelyDAPZq5MHnieakHMMmvXP6lj6ndHI1hsFyOGiqZSoUOq3EJAwumDj+g0ivk0BUky/paetwKA1Z6Xxpfm6hbEpsx3vs3E0cqvNPmTjl31eKJN/GKJ14xWaGw0Navz8fWU73eTGIQlDOSQ39/vB3oA=
Received: from BN6PR1201MB0035.namprd12.prod.outlook.com (10.174.238.140) by
 BN6PR1201MB0241.namprd12.prod.outlook.com (10.174.116.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 18:35:03 +0000
Received: from BN6PR1201MB0035.namprd12.prod.outlook.com
 ([fe80::24a0:9726:b1f7:fb3c]) by BN6PR1201MB0035.namprd12.prod.outlook.com
 ([fe80::24a0:9726:b1f7:fb3c%11]) with mapi id 15.20.2073.012; Wed, 17 Jul
 2019 18:35:03 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARCv2: Don't pretend we may set U & DE bits in STATUS32
 with kflag
Thread-Topic: [PATCH] ARCv2: Don't pretend we may set U & DE bits in STATUS32
 with kflag
Thread-Index: AQHVPBg5vQNhnF2iB0aHFOZdtIGHIA==
Date:   Wed, 17 Jul 2019 18:35:02 +0000
Message-ID: <BN6PR1201MB003505F72EBBE443FADBC23CB6C90@BN6PR1201MB0035.namprd12.prod.outlook.com>
References: <20190716205034.42466-1-abrodkin@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [198.182.56.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4c85b62-7026-4f0f-0189-08d70ae57b65
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR1201MB0241;
x-ms-traffictypediagnostic: BN6PR1201MB0241:
x-microsoft-antispam-prvs: <BN6PR1201MB0241EFC111FFADA987022383B6C90@BN6PR1201MB0241.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(136003)(366004)(376002)(54534003)(189003)(199004)(476003)(6246003)(6506007)(53546011)(53936002)(2906002)(81166006)(81156014)(8936002)(7736002)(25786009)(74316002)(305945005)(66946007)(86362001)(256004)(66476007)(66556008)(64756008)(66446008)(76116006)(76176011)(8676002)(99286004)(54906003)(110136005)(14444005)(52536014)(4326008)(5660300002)(7696005)(66066001)(91956017)(33656002)(71200400001)(71190400001)(14454004)(102836004)(6116002)(3846002)(26005)(68736007)(55016002)(9686003)(186003)(478600001)(229853002)(486006)(6436002)(2501003)(446003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR1201MB0241;H:BN6PR1201MB0035.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xBhBhKXgPywXpgn5xjNL4MO7W125ZaBwJGmesSYuiW3nd677DD8qR9R7FBLeIMZsae3o5MfClpytHgmfxV4+VnJtTWgmpfRg/XDAbqkcoYJMxrd+2V1Noibhy/1ZpRnAJokadsrAhvYCPHps0Kzph+3kVZNva/WVhUtHU/yWRedPiKj5Xfma0KpEfV1gvbVoIAQvTDdYIvvOgvLc9V5eMWwBI7ZdcqylbLIFMmpWtOKJDnuxr1nWA4g9v7t6hgnSIhBSfWSz4cOUjKlZDlZZpfW6tDVakv4UnfN5zQFHwPQD7XhNTe7ZMrIicLOZspq6oQiJZDZYKOl6d90athfH6CfL+JzN+vMDGJElJNFhwHJz44hq0/t9iYbvwLvL8p7Hjf7ASMCXfSwzjJwJbmUH9rtw2zrPxG9gKZX0ua1y2Sg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c85b62-7026-4f0f-0189-08d70ae57b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 18:35:02.9040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgupta@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0241
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/19 1:51 PM, Alexey Brodkin wrote:=0A=
> As per PRM "kflag" instruction doesn't change state of=0A=
> DE-flag ("Delayed branch is pending") and U-flag ("User mode")=0A=
> in STATUS32 register so let's not act as if we can affect those bits.=0A=
=0A=
I understand the motivation and indeed bits not writable by kflag should be=
=0A=
removed. But what if we do need to clear those bits out from status32 (assu=
ming=0A=
they exist there in first place) and that kflag might not be the right inst=
ruction=0A=
to do that.=0A=
So the question to ask is do we need to clear U and DE bits from status32 a=
nd=0A=
answer from reading the PRM is no, we don't have to, as those are cleared a=
lready=0A=
when an exception is taken.=0A=
=0A=
The likely reason this code is because back in arc700 days we used to have =
a=0A=
different version of this macro which atleast in original code relied on us=
ing the=0A=
pre-exception status32 (in pt_regs) - and that could easily have U and/or D=
E set=0A=
based hence needed clearing.=0A=
=0A=
.macro FAKE_RET_FROM_EXCPN  reg=0A=
=0A=
    ld  \reg, [sp, PT_status32]=0A=
    and \reg, \reg, ~(STATUS_U_MASK|STATUS_DE_MASK)=0A=
    or  \reg, \reg, STATUS_L_MASK=0A=
    sr  \reg, [erstatus]=0A=
    mov \reg, 55f=0A=
    sr  \reg, [eret]=0A=
=0A=
    rtie=0A=
55:=0A=
.endm=0A=
=0A=
This is not needed (even in arc700) if we are using the current "in-excepti=
on"=0A=
status32 for doing the early return.=0A=
=0A=
Long story short, your patch is correct but we need to explain better why i=
t is.=0A=
I've applied it locally with slight tweak to changelog to that effect.=0A=
=0A=
=0A=
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>=0A=
> ---=0A=
>  arch/arc/include/asm/entry-arcv2.h | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/en=
try-arcv2.h=0A=
> index 225e7df2d8ed..6558e2edb583 100644=0A=
> --- a/arch/arc/include/asm/entry-arcv2.h=0A=
> +++ b/arch/arc/include/asm/entry-arcv2.h=0A=
> @@ -237,7 +237,7 @@=0A=
>  =0A=
>  .macro FAKE_RET_FROM_EXCPN=0A=
>  	lr      r9, [status32]=0A=
> -	bic     r9, r9, (STATUS_U_MASK|STATUS_DE_MASK|STATUS_AE_MASK)=0A=
> +	bic     r9, r9, STATUS_AE_MASK=0A=
>  	or      r9, r9, STATUS_IE_MASK=0A=
>  	kflag   r9=0A=
>  .endm=0A=
=0A=
