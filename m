Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC4EC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 04:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F9A2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 04:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfHVEGD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 00:06:03 -0400
Received: from m9a0001g.houston.softwaregrp.com ([15.124.64.66]:45870 "EHLO
        m9a0001g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbfHVEGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 00:06:03 -0400
Received: FROM m9a0001g.houston.softwaregrp.com (15.121.0.191) BY m9a0001g.houston.softwaregrp.com WITH ESMTP;
 Thu, 22 Aug 2019 04:05:20 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 22 Aug 2019 03:59:43 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.124.72.10) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 22 Aug 2019 03:59:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sct61Eq1ZDoPUhgRd4NEdhuP+DxK3iNhKluTI3NSNt2eoK02ihMZfa2haFOhBOE5kiqJBYgDng4lKlzDt50G35FlFlRsbZBvUyx8Ft/iVfCdNeLNFh5N13XK6KR7Y1tcSv6JraO73rt6HIEm6jqVuKUyDlLmQQOGeHCiZGKTUX38cdT/zNxbt2St8YT+nGxnth3MSVFwsENOq/V28Fd0s5JQARFX9x6nUmYbLekSe7WCm5kAeQtxBMGvqP0/PHBnbMLsUvDK7f/5tuXqwfhG5Kq6DiqZXYaSKdV8lhGAMIoTQdz1ObDs2BrKEVHA08hyv/qDTWDCWywHG9x551T2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW2RhL7H2LNeHEe6Aan1RmlgL5J2iXm7mi6jOyFKPjo=;
 b=fhP/q5fduYIw0DiDORwW3ohHuP2nZnsE5od1sRa/2ddp8k91LGryf4gwO0TmNHDmEA1xM0xgrU1kT2851Wn06JflgEI5RtKaPunuT5sexv3A/7gO5UYeuBrtW9Q5czoEPq3QKREbD7XO5aZ30f1q04L7krGxri8cJBsSAdAMQavBCkEmYNFO9fBfqE1S1Q7Sp0rLHmXWpXhV2iuHnZA2He45sFbzVheTIi1Mqhj6fR2n+LnU587VxvlYI7POpvI+b+7lJ+wGSDWrYlo9iIK/XoIPdnHcaSTXdcQfdY/6YXDQ8tOvsHtTFmVOoIrPzpXgF3Rw01SWEA3L5JyVjgErHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3283.namprd18.prod.outlook.com (10.255.139.203) by
 BY5PR18MB3219.namprd18.prod.outlook.com (10.255.137.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 03:59:43 +0000
Received: from BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::847e:511a:8cc2:8fca]) by BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::847e:511a:8cc2:8fca%6]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 03:59:43 +0000
From:   Chester Lin <clin@suse.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        Gary Lin <GLin@suse.com>, Joey Lee <JLee@suse.com>
Subject: Re: [PATCH] arm: skip nomap memblocks while finding the
 lowmem/highmem boundary
Thread-Topic: [PATCH] arm: skip nomap memblocks while finding the
 lowmem/highmem boundary
Thread-Index: AQHVWJwNXyBr+dQszki0v7NBI7XKFacGirsA
Date:   Thu, 22 Aug 2019 03:59:42 +0000
Message-ID: <20190822035920.GA27154@linux-8mug>
References: <20190822034425.25899-1-clin@suse.com>
In-Reply-To: <20190822034425.25899-1-clin@suse.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB8PR03CA0014.eurprd03.prod.outlook.com
 (2603:10a6:10:be::27) To BY5PR18MB3283.namprd18.prod.outlook.com
 (2603:10b6:a03:196::11)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [202.47.205.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02ef12b8-4396-44c5-322e-08d726b529af
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BY5PR18MB3219;
x-ms-traffictypediagnostic: BY5PR18MB3219:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB321930AFDB724C487E15DF2BADA50@BY5PR18MB3219.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(199004)(189003)(102836004)(6116002)(110136005)(8676002)(6436002)(6306002)(7416002)(81156014)(14454004)(3846002)(386003)(6506007)(11346002)(446003)(99286004)(256004)(14444005)(2201001)(9686003)(305945005)(76176011)(25786009)(86362001)(81166006)(2906002)(6512007)(1076003)(6246003)(33656002)(486006)(64756008)(52116002)(66556008)(66946007)(66476007)(66446008)(53936002)(2501003)(6486002)(8936002)(7736002)(229853002)(5660300002)(107886003)(4326008)(478600001)(71200400001)(71190400001)(66066001)(476003)(54906003)(186003)(33716001)(316002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3219;H:BY5PR18MB3283.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pihe8yK0ze8ASnxoz63m0fmDIDLGoLmFLD9D55ARfvfBV782FUNWq3VheeJOB/urbP/4uq2WnZEE96yvFqgYB3P2Ebj8V4atvHDgKBzVmkW8p5BUVjYnzB29uDrC88mC749ubSLYIWj+HYWhgYP+eKN74/t0K7CNFyiPMtVqaibPW6PruQfcDzyo/i07oAfe49Cz7JaXaKFGC2xEJ0uo62EITHOzlTQ/Tq2D5w9zhf25gux42fFbVCXPDSW5kRNDYOO6rXSmH1/lMAnUhGMBMgX7iUOaS29s4YqHrMe/QVqBGb6nFKIpGub9jtsJZ0Tigd4Ap8gw6ZEE3edYDSZnV5Ol4KGvUahNxxVtpAh0P60Ue8WRIwrYOOnyZXBWe6bp+0klrLccCK37pXeeP3oXIklAtPVTKp9yoWFq2Op34Vs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <655EB30C6C68C1439EF38D1F1C4169BB@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ef12b8-4396-44c5-322e-08d726b529af
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 03:59:42.8716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AEtHnytHCPRzfmfXtZxVyvYxFJm1RXwZQEsqrXZil/MvFjPUeRcbmLG9Jz+YvEi9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3219
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 11:45:34AM +0800, Chester Lin wrote:
> adjust_lowmem_bounds() checks every memblocks in order to find the boundary
> between lowmem and highmem. However some memblocks could be marked as NOMAP
> so they are not used by kernel, which should be skipped while calculating
> the boundary.
> 
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  arch/arm/mm/mmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 426d9085396b..b86dba44d828 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1181,6 +1181,9 @@ void __init adjust_lowmem_bounds(void)
>  		phys_addr_t block_start = reg->base;
>  		phys_addr_t block_end = reg->base + reg->size;
>  
> +		if (memblock_is_nomap(reg))
> +			continue;
> +
>  		if (reg->base < vmalloc_limit) {
>  			if (block_end > lowmem_limit)
>  				/*
> -- 
> 2.22.0
>

Hi Russell, Mike and Ard,

Per the discussion in the thread "[PATH] efi/arm: fix allocation failure ...",
(https://lkml.org/lkml/2019/8/21/163), I presume that the change to disregard
NOMAP memblocks in adjust_lowmem_bounds() should be separated as a single patch.

Please let me know if any suggestion, thank you.


