Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBAEC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95131214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="HKbhAdfU";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="HKbhAdfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440167AbfIYRDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:03:21 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:26439
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731087AbfIYRDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjKW6Muj86KSvn0QQUm2lay250KaRt6XPwA/Xcd5pKk=;
 b=HKbhAdfUO9Vn+GKgVVGZRzJxSG45E1jVg0oKhp1+XavTTgEnlqozwu1XktTNb6/QUsdWXlHvcMYQXJCfDUiC+azNs/RMvHMGpYW0Brhv0eUjEscQUwICweGWmzJ+lKy5w/wzNfsKFFq1aLV8T5wed1TQaUXnJOwDIXSGcZFQGk8=
Received: from AM4PR08CA0054.eurprd08.prod.outlook.com (2603:10a6:205:2::25)
 by AM4PR0802MB2259.eurprd08.prod.outlook.com (2603:10a6:200:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23; Wed, 25 Sep
 2019 17:03:15 +0000
Received: from AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by AM4PR08CA0054.outlook.office365.com
 (2603:10a6:205:2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.16 via Frontend
 Transport; Wed, 25 Sep 2019 17:03:14 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT004.mail.protection.outlook.com (10.152.16.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 25 Sep 2019 17:03:13 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Wed, 25 Sep 2019 17:03:02 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5857ac6d3e50e69d
X-CR-MTA-TID: 64aa7808
Received: from ee212d738cc0.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8AC15DDA-0570-4F23-9D50-46A38CDA16A6.1;
        Wed, 25 Sep 2019 17:02:57 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2055.outbound.protection.outlook.com [104.47.10.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ee212d738cc0.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 25 Sep 2019 17:02:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flIFPcKbyF2ihM+Qrdc5LorM9psLw1lfrYNk3MYTVj+lJ426yfUWdBJDuBXcOoHRhwpeNGY2DOiG/HguBcQJKo1VtguHRNutR/Xug1xgmUyFhIrY7Dg3pmMS3mNYJsopu/AVsvl1RVRHY8UqO3H9U36oK0LJNkqkD2hlynVxHqvDfbkcVlI48a7gVDT9vBj5/yIwnI0q0CJ+PrPx1QBsZPHdq7fgXB7CVr8GP3G2BdDs9PoDuePGfjxd6EmYaSZiJ+WvcPKRRSKmnrlr44nTvNRZHvRARnHvv4i3mWvFf2oGIm51TcCoaHG1gu0uU2revRAoNtY1Po3JleNR8dCruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjKW6Muj86KSvn0QQUm2lay250KaRt6XPwA/Xcd5pKk=;
 b=nYmN+2/jsHr+B3DCf1JSAzwlAmzRF6CKWXqAY0BB10YqV0aspPGo9g7lgUtJqj0keRAvAJ5tVqfZyeBMb88cvl5Afx6i42b40fNWNYb+yPlHP9tK642jaLtCGCDNS/vzNwJAJ8M27x3iOKv0uBBmR7FrVSXXwgWG5w7M0gXpl3E8lA+ncNYZZdfrL72H51PALOW1BaYfdNOJZn73YVjsG2ocIACRuaA228OLnQvmBshWn75wv77gt0qDqGzVIZS7pPjDr2fqyJN/k8Qv4Ex9oqxk2i//jm8F+BFAe6w0b7jB+3kvEu84pxMm5nZpXr9U9xaxVpla99RNClDSZmia/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjKW6Muj86KSvn0QQUm2lay250KaRt6XPwA/Xcd5pKk=;
 b=HKbhAdfUO9Vn+GKgVVGZRzJxSG45E1jVg0oKhp1+XavTTgEnlqozwu1XktTNb6/QUsdWXlHvcMYQXJCfDUiC+azNs/RMvHMGpYW0Brhv0eUjEscQUwICweGWmzJ+lKy5w/wzNfsKFFq1aLV8T5wed1TQaUXnJOwDIXSGcZFQGk8=
Received: from DBBPR08MB4903.eurprd08.prod.outlook.com (10.255.78.17) by
 DBBPR08MB4282.eurprd08.prod.outlook.com (20.179.43.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Wed, 25 Sep 2019 17:02:56 +0000
Received: from DBBPR08MB4903.eurprd08.prod.outlook.com
 ([fe80::7d9f:6b56:cfbd:899e]) by DBBPR08MB4903.eurprd08.prod.outlook.com
 ([fe80::7d9f:6b56:cfbd:899e%7]) with mapi id 15.20.2305.013; Wed, 25 Sep 2019
 17:02:56 +0000
From:   Peter Smith <Peter.Smith@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>
CC:     "H. Peter Anvin" <hpa@zytor.com>,
        Jarkko Sakkinen <jarkko.sakkinen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Tri Vo <trong@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>,
        George Rimar <grimar@accesssoftek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Fangrui Song <maskray@google.com>,
        Rui Ueyama <ruiu@google.com>, nd <nd@arm.com>
Subject: Re: [PATCH v2] x86, realmode: explicitly set entry via command line
Thread-Topic: [PATCH v2] x86, realmode: explicitly set entry via command line
Thread-Index: AQHVc79E6IxdC67Wc0CXARwlaJTRRqc8m7UJ
Date:   Wed, 25 Sep 2019 17:02:56 +0000
Message-ID: <DBBPR08MB490303D229CB1C7F1CE5796CF8870@DBBPR08MB4903.eurprd08.prod.outlook.com>
References: <CAKwvOdmFqPSyeKn-0th_ca9B3QU63G__kEJ=X0tfjhE+1_p=FQ@mail.gmail.com>
 <20190924193310.132104-1-ndesaulniers@google.com>
 <20190925102041.GB3891@zn.tnic>,<CAKwvOdneE7kMupFzxZC-6c=ps_98FP+Nz88fCXQ74z90hmaaXQ@mail.gmail.com>
In-Reply-To: <CAKwvOdneE7kMupFzxZC-6c=ps_98FP+Nz88fCXQ74z90hmaaXQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Peter.Smith@arm.com; 
x-originating-ip: [12.206.46.61]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: d476bc29-7683-4149-b9be-08d741da403f
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: DBBPR08MB4282:|AM4PR0802MB2259:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <AM4PR0802MB22599D76B5D622D9039C5ACEF8870@AM4PR0802MB2259.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 01713B2841
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(51914003)(199004)(189003)(66946007)(53546011)(6506007)(33656002)(8676002)(8936002)(81166006)(81156014)(5660300002)(3846002)(74316002)(7736002)(229853002)(4326008)(9686003)(52536014)(71190400001)(71200400001)(6436002)(2906002)(6246003)(55016002)(6116002)(305945005)(7416002)(6306002)(86362001)(316002)(66476007)(54906003)(110136005)(14444005)(256004)(102836004)(66556008)(64756008)(25786009)(11346002)(486006)(446003)(476003)(966005)(66446008)(26005)(14454004)(478600001)(186003)(76116006)(76176011)(7696005)(66066001)(99286004)(586874002);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4282;H:DBBPR08MB4903.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: zSY5KgJgv0XMYKxusp8E+CMhj+rP/7Q/kOWK1il2RqbnLHyzQxdiRSVAVGpqBTUSG8W4R+aV1GQquPfYrFKqgM/JhjqG51tqHmy2govMKsOZK1no69AT1369fOwp4l7TT9FC1MYhB4RUKi9a3btAdEIvelYRDcRmmCCQVMfKALArNNYIPbEvtug1mE3R6cDhN+pM/27kHCqIRmk1jL5OaZ+fkKov6+thMb4O9etb/USMHJznWTLcRAhLwZBAkX/uYreAHxyrU8mQ0IjbFZDei3avMCjpzmdU+svikUOuLZhhWr6yxubgqYyKkyq+GL6rTTeGey3Wfr7dxjhxcGLNf5QBSXj7/e5fu/m0jTIVxfves3pQ1pkyggvbKgWgyqt5i1d7mlQokMGjlFTsqz3dNg8+mIErZA6SOMeca3j3FZ8ewfdNFXRX00Wzqx2rEFN/LQSOzaW6086MHreofZfn6w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4282
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Peter.Smith@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(51914003)(189003)(199004)(26826003)(186003)(966005)(86362001)(23756003)(7696005)(74316002)(305945005)(9686003)(66066001)(8746002)(8936002)(81156014)(81166006)(14454004)(6246003)(70586007)(476003)(6306002)(63350400001)(446003)(76176011)(14444005)(50466002)(126002)(7736002)(52536014)(5660300002)(25786009)(11346002)(26005)(486006)(8676002)(36906005)(3846002)(229853002)(70206006)(76130400001)(53546011)(316002)(336012)(99286004)(22756006)(54906003)(6506007)(33656002)(102836004)(4326008)(47776003)(6116002)(478600001)(356004)(110136005)(2906002)(55016002)(586874002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2259;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 686056d6-f652-415b-926f-08d741da3644
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR0802MB2259;
NoDisclaimer: True
X-Forefront-PRVS: 01713B2841
X-Microsoft-Antispam-Message-Info: Y9V82grQ9NH85GS6ISdBRLWNkTyPON3fxRTrntvZEN0mfMbLg8GPZT9L87CKHt01YabeN67clXlJVmrtDcwypoAYPiQZbZ9j0obeWSjjeIfMBSK3ZoUbiPiCUp1xe7JBY4DRY73jIqtBkZqd4VulC1LpVC3YAMKIOop7XFgpZh52R3fKPJxtNJELuLhXWMMjpXRZIJ10f0B7EulkADtBwM4EpwWxZ6wPN41wHcz8YZ/mMCkN/PT8t2vDjRMJMuCl1yBS4l9sjl53jkf211qpOD1JLZF32SLSE/by5KGLW1lJAPv4um/S+WXcOx4yjdothSTCxFPtaVkHiBJr4tE2dmtEIZglh8Lb6nsIHZY3crLmxL3CSiqPUpD6CNkIRLP6IqGhYhowo7Hj26OvSN1i05CTHKXNLCXMF9iEsdjLMbzmlALiV/sjUNcC808s/4aVlcKyiSvB0XLoTKaa2i3Q+A==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2019 17:03:13.2228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d476bc29-7683-4149-b9be-08d741da403f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
=0A=
________________________________________=0A=
From: Nick Desaulniers <ndesaulniers@google.com>=0A=
Sent: 25 September 2019 17:35=0A=
To: Borislav Petkov=0A=
Cc: H. Peter Anvin; Jarkko Sakkinen; Thomas Gleixner; Ingo Molnar; clang-bu=
ilt-linux; maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT); Tri Vo; Masahir=
o Yamada; Rob Herring; George Rimar; LKML; Fangrui Song; Peter Smith; Rui U=
eyama=0A=
Subject: Re: [PATCH v2] x86, realmode: explicitly set entry via command lin=
e=0A=
=0A=
+ Fangrui, Peter, Rui, George (LLD)=0A=
=0A=
On Wed, Sep 25, 2019 at 3:20 AM Borislav Petkov <bp@alien8.de> wrote:=0A=
>=0A=
> + some more people who did the unified realmode thing.=0A=
>=0A=
> On Tue, Sep 24, 2019 at 12:33:08PM -0700, Nick Desaulniers wrote:=0A=
> > Linking with ld.lld via $ make LD=3Dld.lld produces the warning:=0A=
> > ld.lld: warning: cannot find entry symbol _start; defaulting to 0x1000=
=0A=
> >=0A=
> > Linking with ld.bfd shows the default entry is 0x1000:=0A=
> > $ readelf -h arch/x86/realmode/rm/realmode.elf | grep Entry=0A=
> >   Entry point address:               0x1000=0A=
> >=0A=
> > While ld.lld is being pedantic, just set the entry point explicitly,=0A=
> > instead of depending on the implicit default.=0A=
> >=0A=
> > Link: https://github.com/ClangBuiltLinux/linux/issues/216=0A=
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>=0A=
> > ---=0A=
> > Changes V1 -> V2:=0A=
> > * Use command line flag, rather than linker script, as ld.bfd produces =
a=0A=
> >   syntax error for `ENTRY(0x1000)` but is happy with `-e 0x1000`=0A=
> >=0A=
> >  arch/x86/realmode/rm/Makefile | 2 +-=0A=
> >  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> >=0A=
> > diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makef=
ile=0A=
> > index f60501a384f9..338a00c5257f 100644=0A=
> > --- a/arch/x86/realmode/rm/Makefile=0A=
> > +++ b/arch/x86/realmode/rm/Makefile=0A=
> > @@ -46,7 +46,7 @@ $(obj)/pasyms.h: $(REALMODE_OBJS) FORCE=0A=
> >  targets +=3D realmode.lds=0A=
> >  $(obj)/realmode.lds: $(obj)/pasyms.h=0A=
> >=0A=
> > -LDFLAGS_realmode.elf :=3D -m elf_i386 --emit-relocs -T=0A=
> > +LDFLAGS_realmode.elf :=3D -m elf_i386 --emit-relocs -e 0x1000 -T=0A=
>=0A=
> So looking at arch/x86/realmode/rm/realmode.lds.S: what's stopping=0A=
> people from adding more sections before the first=0A=
>=0A=
> . =3D ALIGN(PAGE_SIZE);=0A=
>=0A=
> which, with enough bytes to go above the first 4K, would cause that=0A=
> alignment to go to 0x2000 and then your hardcoded address would be=0A=
> wrong, all of a sudden.=0A=
=0A=
Thanks for the consideration Boris.  So IIUC if the preceding sections=0A=
are larger than 0x1000 altogether, setting the entry there will be=0A=
wrong?=0A=
=0A=
Currently, .text looks like it's currently at 0x1000 for a defconfig,=0A=
and I assume that could move in the case I stated above?=0A=
$ readelf -S arch/x86/realmode/rm/realmode.elf | grep text=0A=
  [ 3] .text             PROGBITS        00001000 201000 000f51 00  AX=0A=
 0   0 4096=0A=
...=0A=
=0A=
In that case, it seems that maybe I should set the ENTRY in the linker=0A=
script as:=0A=
diff --git a/arch/x86/realmode/rm/realmode.lds.S=0A=
b/arch/x86/realmode/rm/realmode.lds.S=0A=
index 3bb980800c58..64d135d1ee63 100644=0A=
--- a/arch/x86/realmode/rm/realmode.lds.S=0A=
+++ b/arch/x86/realmode/rm/realmode.lds.S=0A=
@@ -11,6 +11,7 @@=0A=
=0A=
 OUTPUT_FORMAT("elf32-i386")=0A=
 OUTPUT_ARCH(i386)=0A=
+ENTRY(pa_text_start)=0A=
=0A=
 SECTIONS=0A=
 {=0A=
=0A=
--=0A=
Thanks,=0A=
~Nick Desaulniers=0A=
=0A=
If I've understood the thread correctly, sorry jumping in late.=0A=
- LLD will set the entry point to the start of the .text section in absence=
 of any of the other ways to communicate an entry point. It gives a warning=
 in this case.=0A=
- Setting the entry point to an address that is the current start of the .t=
ext section silences the warning, but is potentially fragile.=0A=
=0A=
I think LLD is on balance right to give a warning as in many cases the star=
t of the .text section is not going to coincide with the desired entry poin=
t.=0A=
=0A=
I recommend doing this via using a symbol defined at the entry point, for e=
xample Nick's last suggestion. This will be most resistant to changes such =
as the .text section changing address or the entry point isn't first in the=
 .text section.=0A=
=0A=
Peter=0A=
