Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37544C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF022083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="IW4LnsC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbfCALY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:24:59 -0500
Received: from mail-eopbgr30061.outbound.protection.outlook.com ([40.107.3.61]:45954
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727952AbfCALY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 06:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLxH7+9FvP9SCJC58TYtKbEMAGhdngc8QCK4XxuWzec=;
 b=IW4LnsC8aKZNU7FJZlxTQb02fInkfFU1ncH1lXMUIo1gIvJz0dglNm3j0hBcErMHLz1PEfbbq0XpberzPecpE3+so/eqgh13VucvmI6T6TDD84ReHgwC6jduBSajc1RxAqjgc3gw0nkS5YCpFXDLIRKXF1fZLMlZPxu8vwREBa4=
Received: from DB5PR0801MB1590.eurprd08.prod.outlook.com (10.167.230.14) by
 DB5PR0801MB1544.eurprd08.prod.outlook.com (10.167.229.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 11:24:55 +0000
Received: from DB5PR0801MB1590.eurprd08.prod.outlook.com
 ([fe80::ac52:cef2:374a:afbd]) by DB5PR0801MB1590.eurprd08.prod.outlook.com
 ([fe80::ac52:cef2:374a:afbd%2]) with mapi id 15.20.1643.022; Fri, 1 Mar 2019
 11:24:54 +0000
From:   Dave P Martin <Dave.Martin@arm.com>
To:     Amit Kachhap <Amit.Kachhap@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Kristina Martsenko <Kristina.Martsenko@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [kvmtool PATCH v6 6/6] arm/kvm: arm64: Add a vcpu feature for
 pointer authentication
Thread-Topic: [kvmtool PATCH v6 6/6] arm/kvm: arm64: Add a vcpu feature for
 pointer authentication
Thread-Index: AQHUyDUOH0S96lHnNUqqzBY6pIzdJ6X2pUibgAANFAA=
Date:   Fri, 1 Mar 2019 11:24:54 +0000
Message-ID: <20190301112452.GS16031@e103592.cambridge.arm.com>
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
 <1550568271-5319-7-git-send-email-amit.kachhap@arm.com>
 <20190221155409.GA3567@e103592.cambridge.arm.com>
 <048f772a-1faf-5fa3-d82c-25212a5104af@arm.com>
In-Reply-To: <048f772a-1faf-5fa3-d82c-25212a5104af@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.23 (2014-03-12)
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LO2P265CA0214.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::34) To DB5PR0801MB1590.eurprd08.prod.outlook.com
 (2603:10a6:0:3b::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dave.Martin@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d4b22a2-b484-4b63-e4ba-08d69e38874d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR0801MB1544;
x-ms-traffictypediagnostic: DB5PR0801MB1544:
x-microsoft-exchange-diagnostics: 1;DB5PR0801MB1544;20:aHQrxyivKDmjAmeQrAHc0s9uUME3LR3qU51DDq5BDIFcdBTClD+asyY2xXFnauInm0cEgb6b41OE4eoUQcHIg3K2p+BxuiDfNkpFQjpxlpigbZvdwyN3JJcLR/ZD4AfE5+VUS28cif7SSfFgPI+8oFb0/NS1+kfCKDN0zzc7jag=
x-microsoft-antispam-prvs: <DB5PR0801MB154467585FC1C0CDA0C41B95FE760@DB5PR0801MB1544.eurprd08.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(396003)(376002)(136003)(40434004)(199004)(189003)(256004)(14444005)(486006)(5024004)(1076003)(52116002)(71200400001)(71190400001)(93886005)(186003)(2906002)(446003)(76176011)(86362001)(316002)(102836004)(33656002)(6506007)(386003)(26005)(53546011)(58126008)(99286004)(476003)(54906003)(11346002)(66066001)(229853002)(53936002)(6486002)(72206003)(105586002)(4326008)(8676002)(305945005)(7736002)(478600001)(5660300002)(97736004)(6512007)(68736007)(14454004)(81156014)(81166006)(6636002)(106356001)(8936002)(6246003)(6116002)(3846002)(6436002)(6862004)(25786009)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR0801MB1544;H:DB5PR0801MB1590.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pWdgY5RmmNPKnW8CL+uZhuSVVDzAhLtNUX+SrSYUuNm9Ls2DMMqchee0uhJfnDiElTSjreNk7BTiR1JdqcCJQgYZqPWzU6IQI6wG2/7EGmRqQRb21M5KIbAh+G6yQWv6GNdjOMrSENT9fC0lr5ILfLWxv+6NvvIzjeoAsZNd4Loqcsd70ToX6wf4WcIlDM6mgpaECQvSKbUmXNUo9djLJh5QM4h0lwfVCjpLiw1XOi71Ns5Kc3F8dB816vZW+YqaZpFI7TJ6p+1pwBLMqsbM4piJR12nNhW2UZ0VkzwiEZqfdtSh6LKrryEBBM7NYlyh/aPlS7h1lNliwLBS1ScXDsM5vvrkVo4JfG9FN4Sdp/z0KgwlgA/b5GkxJjQ12r2IbSt3oHD3aP1T711jk5HKrGQyR+uEr2ADHnjlxGAdNj4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EAE43C6DD55A704C8A230EA1AB7EEF68@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4b22a2-b484-4b63-e4ba-08d69e38874d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 11:24:54.3198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR0801MB1544
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 10:37:54AM +0000, Amit Daniel Kachhap wrote:
> Hi,
>
> On 2/21/19 9:24 PM, Dave Martin wrote:
> > On Tue, Feb 19, 2019 at 02:54:31PM +0530, Amit Daniel Kachhap wrote:

[...]

> >> diff --git a/arm/aarch64/include/kvm/kvm-config-arch.h b/arm/aarch64/i=
nclude/kvm/kvm-config-arch.h
> >> index 04be43d..2074684 100644
> >> --- a/arm/aarch64/include/kvm/kvm-config-arch.h
> >> +++ b/arm/aarch64/include/kvm/kvm-config-arch.h
> >> @@ -8,7 +8,9 @@
> >>   "Create PMUv3 device"),\
> >>   OPT_U64('\0', "kaslr-seed", &(cfg)->kaslr_seed,\
> >>   "Specify random seed for Kernel Address Space "\
> >> -"Layout Randomization (KASLR)"),
> >> +"Layout Randomization (KASLR)"),\
> >> +OPT_BOOLEAN('\0', "ptrauth", &(cfg)->has_ptrauth,\
> >> +"Enable address authentication"),
> >
> > Nit: doesn't this enable address *and* generic authentication?  The
> > discussion on what capababilities and enables the ABI exposes probably
> > needs to conclude before we can finalise this here.
> ok.
> >
> > However, I would recommend that we provide a single option here that
> > turns both address authentication and generic authentication on, even
> > if the ABI treats them independently.  This is expected to be the commo=
n
> > case by far.
> ok
> >
> > We can always add more fine-grained options later if it turns out to be
> > necessary.
> Mark suggested to provide 2 flags [1] for Address and Generic
> authentication so I was thinking of adding 2 features like,
>
> +#define KVM_ARM_VCPU_PTRAUTH_ADDR4 /* CPU uses pointer address
> authentication */
> +#define KVM_ARM_VCPU_PTRAUTH_GENERIC5 /* CPU uses pointer generic
> authentication */
>
> And supply both of them concatenated in VCPU_INIT stage. Kernel KVM
> would expect both feature requested together.

Seems reasonable.  Do you mean the kernel would treat it as an error if
only one of these flags is passed to KVM_ARM_VCPU_INIT, or would KVM
simply treat them as independent?

[...]

> >> diff --git a/arm/kvm-cpu.c b/arm/kvm-cpu.c
> >> index 7780251..4ac80f8 100644
> >> --- a/arm/kvm-cpu.c
> >> +++ b/arm/kvm-cpu.c
> >> @@ -68,6 +68,12 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm,=
 unsigned long cpu_id)
> >>   vcpu_init.features[0] |=3D (1UL << KVM_ARM_VCPU_PSCI_0_2);
> >>   }
> >>
> >> +/* Set KVM_ARM_VCPU_PTRAUTH if available */
> >> +if (kvm__supports_extension(kvm, KVM_CAP_ARM_PTRAUTH)) {
> >> +if (kvm->cfg.arch.has_ptrauth)
> >> +vcpu_init.features[0] |=3D ARM_VCPU_PTRAUTH_FEATURE;
> >> +}
> >> +
> >
> > I'm not too keen on requiring a dummy #define for AArch32 here.  How do
> > we handle other subarch-specific feature flags?  Is there something we
> > can reuse?
> I will check it.

OK

Cheers
---Dave
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
