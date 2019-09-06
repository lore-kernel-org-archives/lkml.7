Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756A8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CFC20842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404077AbfIFJQD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 05:16:03 -0400
Received: from m9a0001g.houston.softwaregrp.com ([15.124.64.66]:51569 "EHLO
        m9a0001g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728356AbfIFJQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:16:02 -0400
Received: FROM m9a0001g.houston.softwaregrp.com (15.121.0.190) BY m9a0001g.houston.softwaregrp.com WITH ESMTP;
 Fri,  6 Sep 2019 09:15:13 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 6 Sep 2019 09:12:21 +0000
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (15.124.72.10) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 6 Sep 2019 09:12:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Entu40NWFn/2UHrszKxgSRDGyhpn5Jc4Rh70on6VvGPXx6YsKVEodvLKNuvRzdtMzHOYO3fZomKtY+2KUUq/Ad0g/9b37sWOOUd7NfIQzZbtXf1EePPlMqgoFNoZnNEQEg7y3tW7PMb4T61uQ2A3t7JWl9RiMRH+JlomKO4ssbhRQ27xEkTRuaB97zIk05xqTVIjHpg9irT6pGvB3A/6qKQiVma7S/RQJs6z6fWoR3NeL0yfYBypI1chWwXEgObswgJ0fL5jL1j75coJWOBd7jVr3w9ukR1U7rHkRaRYKuOtGmZk092LF/P27IY80boYwwlHfIa5pITTGA6W9nWqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxBxstM8pyA3ftiVRgmFNvaUM8AZ3wor+xRizEmh258=;
 b=Dm6YTG318cUWBYzvyRkEF3jftHY/5Tk8vyPUSABA6wek8UEP9Uddc2ZDv7xPeYU69g+EX32ClonqlVhjSt76H7vPQxL+r4M/YsjCU/YCSGQNefnzcYBd34WUe6F8XmINQSxArwnFchnc9lYRPDWhnVaZn0mXd7kO3dIebnNmR+1he9ozTJVQrVPGj9ZLHp9ZMc8oT0ENjKvmbWhHQ6NcvG37lVgVgVLZiadN1yo/g0l3X/kwFXoMXraTbRKFEBCPwqgOiL1YpeT6qGHmIK+OJkINXLpf8vcG320E3KUNNuCR/s9T6OOIzOsJ+YFDb/TMW2IGaOx9GhpyA51/hTaWdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3283.namprd18.prod.outlook.com (10.255.139.203) by
 BY5PR18MB3172.namprd18.prod.outlook.com (10.255.137.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Fri, 6 Sep 2019 09:12:14 +0000
Received: from BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::a46b:1f66:8378:b25e]) by BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::a46b:1f66:8378:b25e%3]) with mapi id 15.20.2241.014; Fri, 6 Sep 2019
 09:12:14 +0000
From:   Chester Lin <clin@suse.com>
To:     Anup Patel <anup@brainfault.org>
CC:     Chester Lin <clin@suse.com>,
        "rick@andestech.com" <rick@andestech.com>,
        "merker@debian.org" <merker@debian.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "atish.patra@wdc.com" <atish.patra@wdc.com>
Subject: Re: [PATCH] riscv: save space on the magic number field of image
 header
Thread-Topic: [PATCH] riscv: save space on the magic number field of image
 header
Thread-Index: AQHVZIMcNduMKr0kk0WFNI6AGCbw56ceTwPLgAAOM4A=
Date:   Fri, 6 Sep 2019 09:12:14 +0000
Message-ID: <20190906091151.GA311@linux-8mug>
References: <20190906071631.23695-1-clin@suse.com>
 <CAAhSdy3dyw_VsmP_x9NoWKhpmen6zC5EhTjxPRPHS-OizYgL-Q@mail.gmail.com>
In-Reply-To: <CAAhSdy3dyw_VsmP_x9NoWKhpmen6zC5EhTjxPRPHS-OizYgL-Q@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR04CA0053.apcprd04.prod.outlook.com
 (2603:1096:202:14::21) To BY5PR18MB3283.namprd18.prod.outlook.com
 (2603:10b6:a03:196::11)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [60.251.47.116]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5008b175-4fca-4779-f6d8-08d732aa4eca
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3172;
x-ms-traffictypediagnostic: BY5PR18MB3172:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB31722DCDBED1A072385A9C8BADBA0@BY5PR18MB3172.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(189003)(199004)(14454004)(52116002)(229853002)(86362001)(476003)(11346002)(446003)(386003)(33716001)(6486002)(53546011)(486006)(102836004)(8936002)(8676002)(81156014)(81166006)(55236004)(478600001)(76176011)(7736002)(6506007)(305945005)(7416002)(66446008)(316002)(71190400001)(25786009)(26005)(71200400001)(186003)(4326008)(54906003)(66946007)(6916009)(64756008)(33656002)(99286004)(66476007)(66066001)(6116002)(256004)(14444005)(6436002)(2906002)(3846002)(6246003)(66556008)(9686003)(1076003)(6512007)(53936002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3172;H:BY5PR18MB3283.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cC0g4g0hBbfKM+O/bHgZbIQ5nDsnHa418cDhBtoVD/Il7eBHeQaY90PlB+05G7pAi/DAfYSBDXCf22t/ORfBbqw/Ghd2kruMfvqO9L/RFYv+h9CObj+D4v5ZpxkGoLhfEonfURX2Lwv9NFj8aJah72MZyB731SerlUDw+I3giHM62H4AZ/ovcDxb6IconA1IMhWa/3BcTfd+/+r3Hbbn8rls1WxHogzNEKSHK8+FLbzljyvLtj435CkhjrJ7VdYnDUwhS+6WdLQwOTRCBr7ZC2T+1SogsJOAKb2jccttS2ivwm4egBgo1uy3BdYXNfsnUOy78fDjoR0XYEBQQ+6qFJEHivWdTNCqR3jAKGXUv5EzzmU0KXS1y43NUj27+x6+wPNTPED6rMR/hlO5SYg4kXzL1xZF5/tTnM2W4LszjWM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF1572D81E5D5F4AB0CB4C84DD16387A@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5008b175-4fca-4779-f6d8-08d732aa4eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 09:12:14.6966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUwzKfJfJvOZAHdNEmyd5zV8S64t4tWn8gPg4N7rINsReDuNmh/t3tVUExi/Xuzm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3172
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On Fri, Sep 06, 2019 at 01:50:37PM +0530, Anup Patel wrote:
> On Fri, Sep 6, 2019 at 12:50 PM Chester Lin <clin@suse.com> wrote:
> >
> > Change the symbol from "RISCV" to "RSCV" so the magic number can be 32-bit
> > long, which is consistent with other architectures.
> >
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  arch/riscv/include/asm/image.h | 9 +++++----
> >  arch/riscv/kernel/head.S       | 5 ++---
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
> > index ef28e106f247..ec8bbfe86dde 100644
> > --- a/arch/riscv/include/asm/image.h
> > +++ b/arch/riscv/include/asm/image.h
> > @@ -3,7 +3,8 @@
> >  #ifndef __ASM_IMAGE_H
> >  #define __ASM_IMAGE_H
> >
> > -#define RISCV_IMAGE_MAGIC      "RISCV"
> > +#define RISCV_IMAGE_MAGIC      "RSCV"
> > +
> >
> >  #define RISCV_IMAGE_FLAG_BE_SHIFT      0
> >  #define RISCV_IMAGE_FLAG_BE_MASK       0x1
> > @@ -39,9 +40,9 @@
> >   * @version:           version
> >   * @res1:              reserved
> >   * @res2:              reserved
> > - * @magic:             Magic number
> >   * @res3:              reserved (will be used for additional RISC-V specific
> >   *                     header)
> > + * @magic:             Magic number
> >   * @res4:              reserved (will be used for PE COFF offset)
> >   *
> >   * The intention is for this header format to be shared between multiple
> > @@ -57,8 +58,8 @@ struct riscv_image_header {
> >         u32 version;
> >         u32 res1;
> >         u64 res2;
> > -       u64 magic;
> > -       u32 res3;
> > +       u64 res3;
> > +       u32 magic;
> >         u32 res4;
> >  };
> >  #endif /* __ASSEMBLY__ */
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index 0f1ba17e476f..1f8fffbecf68 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -39,9 +39,8 @@ ENTRY(_start)
> >         .word RISCV_HEADER_VERSION
> >         .word 0
> >         .dword 0
> > -       .asciz RISCV_IMAGE_MAGIC
> > -       .word 0
> > -       .balign 4
> > +       .dword 0
> > +       .ascii RISCV_IMAGE_MAGIC
> >         .word 0
> >
> >  .global _start_kernel
> > --
> > 2.22.0
> >
> 
> This change is not at all backward compatible with
> existing booti implementation in U-Boot.
> 
> It changes:
> 1. Magic offset
> 2. Magic value itself
> 

Thank you for the reminder. I have submitted a patch to U-Boot as well. Since
my email post to the uboot mailing list is still under review by the list
moderator, here I just list my code change of uboot:

diff --git a/arch/riscv/lib/image.c b/arch/riscv/lib/image.c
index d063beb7df..e8a8cb7190 100644
--- a/arch/riscv/lib/image.c
+++ b/arch/riscv/lib/image.c
@@ -14,8 +14,8 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-/* ASCII version of "RISCV" defined in Linux kernel */
-#define LINUX_RISCV_IMAGE_MAGIC 0x5643534952
+/* ASCII version of "RSCV" defined in Linux kernel */
+#define LINUX_RISCV_IMAGE_MAGIC 0x56435352
 
 struct linux_image_h {
 	uint32_t	code0;		/* Executable code */
@@ -25,8 +25,8 @@ struct linux_image_h {
 	uint64_t	res1;		/* reserved */
 	uint64_t	res2;		/* reserved */
 	uint64_t	res3;		/* reserved */
-	uint64_t	magic;		/* Magic number */
-	uint32_t	res4;		/* reserved */
+	uint64_t	res4;		/* reserved */
+	uint32_t	magic;		/* Magic number */
 	uint32_t	res5;		/* reserved */
 };


> We don't see this header changing much apart from
> res1/res2 becoming flags in-future. The PE COFF header
> will be append to this header in-future and it will have lot
> more information.
> 

I think a smaller magic field will let res4 have more room [32bit->64bit], which
could offer more options for RISC-V's boot-flow development in the future. This
change also synchronizes with arm64's image header.

> Regards,
> Anup
> 
