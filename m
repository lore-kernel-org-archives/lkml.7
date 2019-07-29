Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1003C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80112070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ko2iqzL4";
	dkim=pass (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="ecWDMY/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfG2RdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 13:33:19 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:1752 "EHLO
        rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfG2RdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 13:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=462; q=dns/txt; s=iport;
  t=1564421598; x=1565631198;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DnzRDcKw8LCr6kwuLsFsSDdA5JtrsMkypm5zzHhVE3Y=;
  b=ko2iqzL4llDCHDw3CMt3XE1QdZ6aY8V5lb3FyKun2eaBxWvqatU6pZeL
   +8fQkVEqnI7PZr/wYm1HIBztT4igkZls24mPrZGaM/YIb4EdH/j7Y7lry
   pj/0IepOFNujhfFNN8HpcekqhBxTP86qs8s+8U6dn7WEgtmmJr/MdJUPp
   8=;
IronPort-PHdr: =?us-ascii?q?9a23=3A/+6wqxAGfVJBZFDZA7RrUyQJPHJ1sqjoPgMT9p?=
 =?us-ascii?q?ssgq5PdaLm5Zn5IUjD/qs03kTRU9Dd7PRJw6rNvqbsVHZIwK7JsWtKMfkuHw?=
 =?us-ascii?q?QAld1QmgUhBMCfDkiuN+XhbyU3F8dqX15+9Hb9Ok9QS47z?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ATAAAWKz9d/5ldJa1mGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBVQMBAQEBCwGBQ1ADgUIgBAsqh2UDjQOCW5dTgS6BJANUCQE?=
 =?us-ascii?q?BAQwBAS0CAQGEQAKCbCM2Bw4BAwEBBAEBAgEGbYUeDIVLAQEBAgESLgEBNwE?=
 =?us-ascii?q?ECwIBCEYyJQIEAQ0FIoMAgWsDDg8BoUUCgTiIYIIjgnoBAQWFCxiCEwmBNAG?=
 =?us-ascii?q?LXxeBQD+BEScfgkw+iAGCJo5Nhi6WAAkCghqUFBuCHpVwjTuXVgIEAgQFAg4?=
 =?us-ascii?q?BAQWBVwongVhwFWUBgkGCQoNxilNygSmNQwEB?=
X-IronPort-AV: E=Sophos;i="5.64,323,1559520000"; 
   d="scan'208";a="605095987"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 29 Jul 2019 17:26:12 +0000
Received: from XCH-ALN-001.cisco.com (xch-aln-001.cisco.com [173.36.7.11])
        by rcdn-core-2.cisco.com (8.15.2/8.15.2) with ESMTPS id x6THQCvM032638
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 29 Jul 2019 17:26:12 GMT
Received: from xhs-aln-003.cisco.com (173.37.135.120) by XCH-ALN-001.cisco.com
 (173.36.7.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jul
 2019 12:26:11 -0500
Received: from xhs-aln-002.cisco.com (173.37.135.119) by xhs-aln-003.cisco.com
 (173.37.135.120) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jul
 2019 12:26:11 -0500
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (173.37.151.57)
 by xhs-aln-002.cisco.com (173.37.135.119) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 29 Jul 2019 12:26:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNIK0bXNlOwzjjNqhAzELU9kNrgF51BsmEsRyJblrPubY9jj7vN81JPz6V2s1YQVVnffEJsQC0P0Q4r5RO6eF4QHHu+feLRTT2BzKh9auSx9Fa2pHjtU3RwKWQxRcXZn60dndUoZEE5HfxnlL4te4dwRy9705GTf7xbz1vOIH3Wb+isrKixms5MhBTF28xPVTDsI5ZAsTOO83TYRIuW/CIQZraSXWXF2wW/HjPAr1J3C/7EsZtPUxbJWTQkbRqov/NEgt8xYl/5p/bh+OF85G8uH8YC7pC2Zy+FJcfyyyipVHs7I4jfzYf7mxj3ANN0fbqZ2HiOwvKrQFMOjZb2ZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTchYUz6py+HpzKadvTZ38+nJ+pBLombCgxcw/5c0h8=;
 b=fFY+de+tIVCX4LfJGIeLv/0dZ10t+kyfQNNWrRIIa92035or5gzE7kJUUHjarCQGshARRPtnq9VdLFV47Cm/0/02H2V+ezV4PEVQpNnbALVRU7tfBzB4JHEwTyNU6sVllbIXa2yFRUXsp32eq0txhIfxMVALpGcQd2FU8meJHH7Z+gIUD/6EikTtVVPDn6dn4fxrA0OhmE8HO6zcSfqdebuPb4wdOBbUC5cu24P8/ugAZ6IRAAq8EDcr4aS5XsW3hGYOO2Mu0iA/sbLCaJj2FxHA3FKFN3HBlAe3FkvddPgNz466l+CQzQ1/MdKBHZ1WXVK01NVV15rqRWPL08ZBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=cisco.com;dmarc=pass action=none
 header.from=cisco.com;dkim=pass header.d=cisco.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTchYUz6py+HpzKadvTZ38+nJ+pBLombCgxcw/5c0h8=;
 b=ecWDMY/3seZbW62Uiz5hqKFxoJcLuMjF02qBCjpTpfOnuNd6hwz5mi7dqFrpVmE9r9Zlw+oqAk862leSnWi/vt0RDfc43dMSHxrjMave1IN4ekajjfG+AnpDPtzWYIgUHiVZcqAWa2iWoCypB7UovQLWnFM4GITY7EJk+ryER/Y=
Received: from BY5PR11MB4007.namprd11.prod.outlook.com (10.255.161.92) by
 BY5PR11MB3928.namprd11.prod.outlook.com (10.255.161.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Mon, 29 Jul 2019 17:26:10 +0000
Received: from BY5PR11MB4007.namprd11.prod.outlook.com
 ([fe80::a9a1:897e:f584:9d6f]) by BY5PR11MB4007.namprd11.prod.outlook.com
 ([fe80::a9a1:897e:f584:9d6f%6]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 17:26:10 +0000
From:   "Stefan Schaeckeler (sschaeck)" <sschaeck@cisco.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/17] ARM: dts: aspeed-g5: Move EDAC node to APB
Thread-Topic: [PATCH 01/17] ARM: dts: aspeed-g5: Move EDAC node to APB
Thread-Index: AQHVQ3SkzIRhhRUUW0+FMgPuy4Chg6bhaSoA
Date:   Mon, 29 Jul 2019 17:26:10 +0000
Message-ID: <8F0B09F9-A2EA-4A88-BE8A-A8869FCE178A@cisco.com>
References: <20190726053959.2003-1-andrew@aj.id.au>
 <20190726053959.2003-2-andrew@aj.id.au>
In-Reply-To: <20190726053959.2003-2-andrew@aj.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1b.0.190715
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sschaeck@cisco.com; 
x-originating-ip: [2001:420:30d:1254:1000:5c0c:8a0d:62f5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 290499c3-57b7-4bc6-d03c-08d71449d931
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR11MB3928;
x-ms-traffictypediagnostic: BY5PR11MB3928:
x-microsoft-antispam-prvs: <BY5PR11MB39288983C7EAAF8EDC1BF363C7DD0@BY5PR11MB3928.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(189003)(199004)(66556008)(102836004)(6116002)(66476007)(71190400001)(76116006)(53546011)(5660300002)(6506007)(66446008)(36756003)(64756008)(71200400001)(99286004)(486006)(66946007)(76176011)(6246003)(14454004)(186003)(53936002)(305945005)(6512007)(54906003)(110136005)(229853002)(5024004)(256004)(6436002)(81166006)(81156014)(11346002)(4326008)(68736007)(4744005)(316002)(2906002)(8676002)(33656002)(2616005)(8936002)(478600001)(6486002)(2501003)(446003)(7736002)(476003)(58126008)(86362001)(46003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB3928;H:BY5PR11MB4007.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UFo7tZdMmSrDEQWmUTk7cNubH0pmCcmG3xLyZvW66PbdiCMzXst7Abok7MIqoZXtpvb6WEnE6rbwfNO0jIrVM4LwYQ7yHrUo1A2j32Ukt8Jf3Vw3qwZHqj7KxhN1VO+1XVEIJNxvCsrX0uK87ZJVPL3aG9z69/pmKuv4liFElmJfqKz71m3uB8bhT0HpoZDAnLd57jockQB4NM+KevP5WtTgZiiutqrpZ0huYunxtYeybIZOpVosCLm7l3n6PD324OVoqDSOodaaNIO95j8i36OmJM7bx3IqUfaKM+G7cvivS1B6gvywCp8G0CEtl0U+0zwhNpPdTUw4+3f5OtRadkVWKhROwKiqRrP7NnQozYVPouC/4XluvOydeBZTpX9CV5//OIVOqY9aHhq7qMoOUw00FxDkP2LZSPzrC36jevY=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <756A23CAC08DC448858086B25C1F218A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 290499c3-57b7-4bc6-d03c-08d71449d931
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 17:26:10.2564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sschaeck@cisco.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3928
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.11, xch-aln-001.cisco.com
X-Outbound-Node: rcdn-core-2.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 25, 2019 at 10:40 PM, Andrew Jeffery wrote:

> Previously the register interface was not attached to any internal bus,
> which is not correct - it lives on the APB.
>
> Cc: Stefan M Schaeckeler <sschaeck@cisco.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  arch/arm/boot/dts/aspeed-g5.dtsi | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Schaeckeler <sschaeck@cisco.com>


