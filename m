Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF098CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE272087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="Aiv58saH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbfJ2EUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 00:20:02 -0400
Received: from mail-eopbgr820043.outbound.protection.outlook.com ([40.107.82.43]:44736
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727937AbfJ2EUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 00:20:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FD+vPqhtQ60eJRKTCMjnG4aj1bo6272XuVyft+D8x51FQ4seQstpipctLc0c5Q9621pV/QxwjktlTn7nW+FzHq60/fdn+/p44U33c9wyCRNa6ZfdpKL9bK98s6mr8k0ar/YIsav1hf/Cg9uqCTzomLvvNwsaKq+RJ+GG/hAK0BnuUwlW3dBPzBvG/+5mXDzrlkO824ywFbKB5JFHi9nmGgusL+7VdrgbQ3NDqLQ2J9hb2RRLTESqqn4h5eWlplV+2STVBMtKK/cQ7SpYH7P/hWwZuaLABHHlkRB1LktgmPp4KVL7F0ZXwm0l9fi7xP3MF9C6ODkG898WPA/Q/U7uLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/FCPeXafzqDSGZLSY8HTfoMAstxNbe+6oObwMBwK6Q=;
 b=CIiKCfbRfxn4A6i/+E9pwNx7sIdxV/cM6MkcViD8Cau1BApa8OW12GxawnUegAj4FKq8oJFHS0vhSVCFSExmfgNc1+1FNDE/LxBN5MyctveFqoYzWaZNSQIaDYWFoeqwaCT6y4jxOSpp1ofDF3DqCu6EvypvYZeQh+Ee1PHG6xw7S2w1oXmjzVmV1iVCDALa77ec2UfmxV0vs9KNbVtkyFi8UjXr3PrZ706NcqhxEY6jeFenCcfODY+3UpT38nzWCUqVvlW9us5BIxvfB1zuC4HfuSp52gD5oBzK/Rlv0P8k2HPpAdoOm4HXneqfPpiw7DyeTn2QDOV+1Ka6V2wCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/FCPeXafzqDSGZLSY8HTfoMAstxNbe+6oObwMBwK6Q=;
 b=Aiv58saHLMWA1vUUPO84uy+8e414p/ka2Y7nNjo4BeTssM0rTHqU/Ek3BjFKugPn/n6oXHyvl/l71uH6ESvDlPVvPHPL9IMmx66xq31mvuMLvQXrgN4tQkQ+hXAtbyOCZHgbFcEiXPt8u0NP8P4EIW0qgAI0htZLSBVYn3too0s=
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3445.namprd13.prod.outlook.com (52.132.244.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.15; Tue, 29 Oct 2019 04:19:56 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::853e:1256:311e:d29]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::853e:1256:311e:d29%7]) with mapi id 15.20.2408.014; Tue, 29 Oct 2019
 04:19:56 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>
CC:     "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt ( Sifive)" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        "alex@ghiti.fr" <alex@ghiti.fr>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "sorear2@gmail.com" <sorear2@gmail.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Subject: RE: [PATCH v2] RISC-V: Add PCIe I/O BAR memory mapping
Thread-Topic: [PATCH v2] RISC-V: Add PCIe I/O BAR memory mapping
Thread-Index: AQHViw5l0jY9JQhUEkq6xffYZOywOadrgoeAgAWHKLA=
Date:   Tue, 29 Oct 2019 04:19:56 +0000
Message-ID: <CH2PR13MB3368A6E99DAB164A52D2954A8C610@CH2PR13MB3368.namprd13.prod.outlook.com>
References: <1571992163-6811-1-git-send-email-yash.shah@sifive.com>
 <alpine.DEB.2.21.9999.1910250852420.28076@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1910250852420.28076@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
x-originating-ip: [114.143.65.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a71613c0-7ad6-41ea-c404-08d75c274136
x-ms-traffictypediagnostic: CH2PR13MB3445:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR13MB34456B932746A73B676418788C610@CH2PR13MB3445.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(376002)(136003)(366004)(396003)(346002)(189003)(199004)(107886003)(229853002)(4744005)(6246003)(316002)(86362001)(6862004)(55016002)(486006)(66556008)(44832011)(66476007)(76116006)(9686003)(4326008)(64756008)(66946007)(66446008)(256004)(14444005)(99286004)(6116002)(14454004)(26005)(6436002)(54906003)(102836004)(3846002)(186003)(33656002)(476003)(5660300002)(446003)(11346002)(6636002)(7416002)(66066001)(52536014)(8936002)(74316002)(81166006)(2906002)(81156014)(7736002)(6506007)(8676002)(76176011)(7696005)(305945005)(25786009)(71200400001)(478600001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3445;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MEGWlcZfPwgDwjBu9LhuaZgUGZIud4RgLg+rKY6Fn/bn6BkGgnEsbHQtzcc7IRE4sAuc7fL09/Pc5AmzZQDWoueG9WDC09tu+XZ8OSuUXfYG3qNL0efK9MXkZyVuIECy2mQt8Tr+l1n/+0v94kvnp9BFMZcYSiDLEIBHkw6QXhUV8mNNq8Oj7y5quJ4Cp1a1e0DoXW0ugfZ2E8l3MYqtfmoLc6PYvY16cK4IwOJmJ6ugwXW7Aj3rR0z0eW1Bppakkrvy6wqla5qgIR7NnKn7Fa39wO6RJjYFxUvxki5T24xYWqf+5uk9iPuuX52YracI9RLFUQZozVhjqu+gx33J47VOSa9elpmkkDPrKeZ0okPP8TruQ5zhRrZD9nfz+rKPT70RS0WU8BW8XBiw19OflTrDRJK8bYwrPb1IdKACoXyJSdZgXMdTbJZ9Brjzb9Kz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71613c0-7ad6-41ea-c404-08d75c274136
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 04:19:56.3003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7dPlHCLmbI+c1hn/2tr4Q6S9mfcTqpwbYBTNN+JttOH6YMxcxRlmlKP++uzFUIkVSXBJL+5FyOtkh9VPuGDH1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3445
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 25 Oct 2019, Yash Shah wrote:
>=20
> > For legacy I/O BARs (non-MMIO BARs) to work correctly on RISC-V Linux,
> > we need to establish a reserved memory region for them, so that
> > drivers that wish to use the legacy I/O BARs can issue reads and
> > writes against a memory region that is mapped to the host PCIe
> > controller's I/O BAR mapping.
> >
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
>=20
> Thanks.  And just to confirm: this is a fix, right?  Without this patch, =
legacy
> PCIe I/O resources won't be accessible on RISC-V?

Yes, this is a fix.

- Yash
