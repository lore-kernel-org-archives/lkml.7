Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E59ECDFB6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 05:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8494D2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 05:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="iwpNngcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbfJAFy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 01:54:27 -0400
Received: from mail-eopbgr780089.outbound.protection.outlook.com ([40.107.78.89]:6454
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725777AbfJAFy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 01:54:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzpJFscQJG73iiT96/JCVUE9KKVOpBSlk5TB/hB5XPpHLu8Cs/XkNknrcpG8f603+RT4WxmSBwLhEZup3H5BotvRLipNs9glh04z67JZ8CNOX6QKxLbkPuGa2Rmy95WNlVqOnLvzLWsIPGK/biriVB3e1kaqORtzTnw3buQqGKW5mBE/y5m4PFfCj3zAoI6rV6gwR5sAwHI5oh4Lbt0/dkCJ6CS+6mkKbHzzQGeoqNDCDBHgBExYHxZ5gbCgVPz2pbLXGFuqrGBYtFxMmhVji+xDNda2Zh39V8R3BxbFowhCfX920/4LvVC1S/d5VEclvOZHnub0Ui8rwbRfpD/TOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExGbHavrffNB/QqEm2TIj2sD2X7o2Ky9GZqvQnE3hlc=;
 b=Iam0VOiH80NrwyauFVP8fHUAwNS2vCqHXvN19IIG23sRzdViGPfoUALvOiYaatOH7mld9HtFKJ3nIHFU+a+xfmjMIHPqPnhJPuXFR6dVG72AXCXsKZmPc1CxSFGlB8feMsJDgYZjcBbXsQlMfmkjHlUYMZKNqd0RI7ic3tSZ0z1M+pH+6a4tZLPTe0SR7803JwJDZY2jMNbPq6+gpLeJDwMVtRXTRnoVUdbeeKXDzKq0nOLA4lWl2SMt3mg587V7Q7I8gLnfLTLRS2xWtVKBvte+ji1YN5Lvu+EKY7d+JYRR5CLEpa5Bh1wCI4jr2OijUu81OoS2rTnlhRmiVK9VZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExGbHavrffNB/QqEm2TIj2sD2X7o2Ky9GZqvQnE3hlc=;
 b=iwpNngcbq8xKatv6UbhV5QpwhBE7ZLCvZtwnce2LNmL3Ah+YIgWA0EKbiE7nWA8J1ew+CkdV/CRfPklj28GcMzkSucxvFTMOFoltoyIsGLdsqWWaaor/VH7s9QPnoAGS7LtXGrgixLr/HzEkRIDx24BGuhDbBfNSifNRMmRJ8YY=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB7102.namprd05.prod.outlook.com (52.135.38.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.14; Tue, 1 Oct 2019 05:54:22 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::9861:5501:d72f:d977]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::9861:5501:d72f:d977%2]) with mapi id 15.20.2327.009; Tue, 1 Oct 2019
 05:54:22 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        =?iso-8859-1?Q?Thomas_Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Pv-drivers <Pv-drivers@vmware.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 1/2] x86: Don't let pgprot_modify() change the page
 encryption bit
Thread-Topic: [PATCH v3 1/2] x86: Don't let pgprot_modify() change the page
 encryption bit
Thread-Index: AQHVbVgRi/HBwpPDsU6JzTdc8oGYgw==
Date:   Tue, 1 Oct 2019 05:54:22 +0000
Message-ID: <MN2PR05MB61416C02E95D28652B432BB7A19D0@MN2PR05MB6141.namprd05.prod.outlook.com>
References: <20190917130115.51748-1-thomas_os@shipmail.org>
 <20190917130115.51748-2-thomas_os@shipmail.org>
 <d893ef47-443e-0759-8f1e-d496a4ad3dfd@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e74b3ff-4e87-4790-d4c0-08d74633cee2
x-ms-traffictypediagnostic: MN2PR05MB7102:|MN2PR05MB7102:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR05MB7102CCDAD455F9CA8C01D9B9A19D0@MN2PR05MB7102.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(8676002)(9686003)(4744005)(4326008)(14454004)(6506007)(74316002)(186003)(305945005)(7736002)(7696005)(66066001)(52536014)(6246003)(7416002)(5660300002)(55016002)(81166006)(81156014)(53546011)(2501003)(8936002)(6116002)(91956017)(66476007)(66556008)(64756008)(446003)(66446008)(3846002)(54906003)(33656002)(76116006)(2906002)(102836004)(476003)(229853002)(6436002)(478600001)(486006)(86362001)(71190400001)(66946007)(71200400001)(25786009)(110136005)(256004)(26005)(76176011)(316002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB7102;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IxrTCrk56U9YLICk9cPrKr0FVJEGRFHIhVFiix+Ik/F2Ov0x8J8Jx9IMBea+aT+BBxJvqVWSmsJLsEh4D+fjv8N9VJpyqeVvj5tKzQ+9CPz65IsLx8YgD9nP9Bu31OSFQxt2rQ9AnKTKJnlV/Et0u7oDuKyEyvvqjhhLR49h/a1Qb3xD5uovdIqBH525exTTCJrR+TXzkBXTXAkfgGZS1LLKhR8j4bS0pqBggsa9XrP63WQvhEWRVaVmIvwc0n2gbH8eCCIARmMsDVWw7wMhuCoWqSPPOJGOASe3zzFOtkkGNGnfxwHZdpxDtGEn8lmghFGpZXPEJBk7y1iKStwnzmDkNaVMZps1WMiPWr5lVxJyINr6uUvpgTQEbRcMRDBGN2Il1nCuMcpONsTdWZK+4TvomxZjnLq7eirRONSWvl4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e74b3ff-4e87-4790-d4c0-08d74633cee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 05:54:22.1844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HtpgmlK1tm5i/aHhjaaIWnUtPvyqvLfj9MqvaMbzOm6mKB9x/8iF12lGuj8b+BNriANh0/w3kFg23y7KIpSklg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB7102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
On 9/18/19 7:57 PM, Dave Hansen wrote:=0A=
> On 9/17/19 6:01 AM, Thomas Hellstr=F6m (VMware) wrote:=0A=
>> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm=
/pgtable_types.h=0A=
>> index b5e49e6bac63..8267dd426b15 100644=0A=
>> --- a/arch/x86/include/asm/pgtable_types.h=0A=
>> +++ b/arch/x86/include/asm/pgtable_types.h=0A=
>> @@ -123,7 +123,7 @@=0A=
>>   */=0A=
>>  #define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\=0A=
>>  			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\=0A=
>> -			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)=0A=
>> +			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC)=0A=
>>  #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)=0A=
> My only nit with what remains is that it expands the infestation of=0A=
> things that look like a simple macro but are not.=0A=
>=0A=
> I'm debating whether we want to go fix that now, though.=0A=
>=0A=
Any chance for an ack on this? It's really a small change that, as we've=0A=
found out, fixes an existing problem.=0A=
=0A=
Thanks,=0A=
=0A=
Thomas=0A=
=0A=
=0A=
=0A=
