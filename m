Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B170CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB25206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="nDrLoiOO";
	dkim=pass (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="0+ZBmQ4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfG2RcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 13:32:09 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:1356 "EHLO
        rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfG2RcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 13:32:08 -0400
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 13:32:07 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=456; q=dns/txt; s=iport;
  t=1564421527; x=1565631127;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ceMV1HsgTfN3GfDUcZ5zW2rzvBFNz0hpgiZSDaFK71Q=;
  b=nDrLoiOOj6yVt63YUsTt8qShAwtDi5lrMH+d6UwM9fdqlqCJRg4H2LKo
   6hjQ1F3gDq39XPeuLU/kz1RokEWF//I0im+hNdeJpIWNnc45LO1/mU4ih
   ow3R2gonQfogtH7gkUWKmIv6K4baFLNdhXiihHC7RPaJYSj11W34DQDdV
   s=;
IronPort-PHdr: =?us-ascii?q?9a23=3AJAHC5B1YXIAEhmd2smDT+zVfbzU7u7jyIg8e44?=
 =?us-ascii?q?YmjLQLaKm44pD+JxKGt+51ggrPWoPWo7JfhuzavrqoeFRI4I3J8RVgOIdJSw?=
 =?us-ascii?q?dDjMwXmwI6B8vQElbwLPfnZC8SF8VZX1gj9Ha+YgBY?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AJAAAvLD9d/5NdJa1mGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUwUBAQEBCwGBQ1ADgUIgBAsqh2UDhFKIMYI2JZdTgS6BJAN?=
 =?us-ascii?q?UCQEBAQwBAS0CAQGEQAKCbCM0CQ4BAwEBBAEBAgEGbYUeDIVLAQEBAgESLgE?=
 =?us-ascii?q?BNwEECwIBCEYyJQIEAQ0FIoMAgWsDDg8BoUYCgTiIYIIjgnoBAQWFCxiCEwm?=
 =?us-ascii?q?BNAGLXxeBQD+BEScME4JMPoQNg3SCJo5NhVNblgAJAoIalBQUB4IelXCNO5d?=
 =?us-ascii?q?WAgQCBAUCDgEBBYFQOIFYcBVlAYJBgkI3gzqKU3KBKYpxglIBAQ?=
X-IronPort-AV: E=Sophos;i="5.64,323,1559520000"; 
   d="scan'208";a="605097458"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 29 Jul 2019 17:29:05 +0000
Received: from xch-rcd-011.cisco.com (xch-rcd-011.cisco.com [173.37.102.21])
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id x6THT5X5019098
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 29 Jul 2019 17:29:05 GMT
Received: from xhs-rtp-003.cisco.com (64.101.210.230) by XCH-RCD-011.cisco.com
 (173.37.102.21) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jul
 2019 12:29:04 -0500
Received: from xhs-rtp-002.cisco.com (64.101.210.229) by xhs-rtp-003.cisco.com
 (64.101.210.230) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jul
 2019 13:29:02 -0400
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (64.101.32.56) by
 xhs-rtp-002.cisco.com (64.101.210.229) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 29 Jul 2019 13:29:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlGy4ACrHN++civwXfwptYNhTeaMzce1iKt+TrvCHOwlvt3rZsStRxWD7JYnd/ys83GzmG0J7sZmzX6KLh/zyxMwn2hNCFgB/ixRGZkDSynGBuRHEq9rBDaqZ3sqZkrfdsBgr6d6q3c3o+oA51HuK+F1ABvwFvB4FsEgxvffHTbKDDx9SN0fa3ydCsfh3xu8QQMNcLLAefbmaAGEEq2PS7T/96pmkG7eETL+GidD/EuCP47K/2KYvALLs8D10g5doJjLnFnzr2pmr4pi/idEwZ7uQyhGT65gvAfsaqoSoymznHvhpK3V5zhS5MfePvDDFP4xMFW8vbCDmq2xoRw3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C54rsf+b5DPterrMjfWuADkLCorY8sMzXgpZkUj9PXQ=;
 b=E/IY9YlZevY3FuRak8tovCJrZ/muFeuYLz2V8949jziBEePZgbZIt0unF9uRyx61T7dqUI4QHo8uH3wep5eEovn61guHM4zIcxXCW3qPPkoHnkI66th/72aQmMDhxAcF47f653dkQbSR5k90coi5qU669iqG2ejZC+GTl32IfK53wl+eKJ7Kqk1OLaZ3mT6Nwt3Sw9Kk356hLngxCIyssgurZBy9oic81eu9QjndoMlEL8/lq/AabAQm/dGlyFssLYnWKxsWVfsnwZFWVdsIigssRTbQn+vcTlKmabJkuqgf1ckRAu7u133SRiDwkixlCi7eLCV+O611abpc4SfGFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=cisco.com;dmarc=pass action=none
 header.from=cisco.com;dkim=pass header.d=cisco.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C54rsf+b5DPterrMjfWuADkLCorY8sMzXgpZkUj9PXQ=;
 b=0+ZBmQ4SlxZPaRjbpOhF4+wce0M3VH8MHsS5UTp3GnMKS1lGxWo/bDP3MMlFWqHjxtRV0otuwApyTOBMKVqWen6xsvxh+SkD4u+y7SUz1aBQLhNSeA90SyUJzPW3MF3bzdCmFkugIQqFDacmEGG3A2Wg12Ng7JSmHyCSrwe1o2M=
Received: from BY5PR11MB4007.namprd11.prod.outlook.com (10.255.161.92) by
 BY5PR11MB3880.namprd11.prod.outlook.com (10.255.160.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Mon, 29 Jul 2019 17:29:01 +0000
Received: from BY5PR11MB4007.namprd11.prod.outlook.com
 ([fe80::a9a1:897e:f584:9d6f]) by BY5PR11MB4007.namprd11.prod.outlook.com
 ([fe80::a9a1:897e:f584:9d6f%6]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 17:29:01 +0000
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
Subject: Re: [PATCH 02/17] ARM: dts: aspeed-g5: Use recommended generic node
 name for SDMC
Thread-Topic: [PATCH 02/17] ARM: dts: aspeed-g5: Use recommended generic node
 name for SDMC
Thread-Index: AQHVQ3SkIHcc3CSkQUy+2gvzeKU5DabhafaA
Date:   Mon, 29 Jul 2019 17:29:01 +0000
Message-ID: <EF113919-7590-442F-A1EE-12143FA4D960@cisco.com>
References: <20190726053959.2003-1-andrew@aj.id.au>
 <20190726053959.2003-3-andrew@aj.id.au>
In-Reply-To: <20190726053959.2003-3-andrew@aj.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1b.0.190715
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sschaeck@cisco.com; 
x-originating-ip: [2001:420:30d:1254:1000:5c0c:8a0d:62f5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d2facdc-ed70-481b-51ce-08d7144a3f09
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR11MB3880;
x-ms-traffictypediagnostic: BY5PR11MB3880:
x-microsoft-antispam-prvs: <BY5PR11MB38803E2407D1FDC4D9D8B5A2C7DD0@BY5PR11MB3880.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(189003)(199004)(446003)(66946007)(66446008)(64756008)(66556008)(66476007)(476003)(8936002)(36756003)(71200400001)(54906003)(81156014)(2616005)(81166006)(76116006)(11346002)(6512007)(6436002)(86362001)(6486002)(58126008)(110136005)(14454004)(2906002)(99286004)(33656002)(102836004)(8676002)(53936002)(71190400001)(229853002)(6506007)(486006)(186003)(53546011)(478600001)(46003)(316002)(4744005)(6246003)(2501003)(25786009)(4326008)(305945005)(7736002)(76176011)(6116002)(256004)(14444005)(5660300002)(68736007)(41533002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB3880;H:BY5PR11MB4007.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0MymAVkWwBDg7NsRlj7EVo2UFpQ+Qtjl2Uy89p7HnkeHusmzB32n++6JgPjLjdqq51YBvuYFyqBggKkwna/kwFeLHR0qyH0KZhzokRyIU9abZq0UXouqsjKD0Nh29kwkkLrkSa3csZjRzKOQvenvksTD3cXZniQvAU8/PBhuEHWRaZNHdYp3JgNDLcO2aOQJX61H8ln5nzwlrzRJzfI0eYx0LjUHhPDX5IAhMKkc6lzQlxOyCClhFf8nhhbxWlrSDxAjfCD5Dzx2DicMQw5SU8jO6tjR3oGZMnxbyo21gydW2P6PJTXLwCcGaPbeA92onsqbzy7hvj7B7MH0MnOEOY8ew99CNOsROgNAfGNPHPZn25dd6lZB7ouNh01ROXe5BhfJaHViWd4Oc89bYQUvH5yaAr7UfOUN7F+0JLBht44=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <CAA3C299B7A78046AC880CC515AC5AC9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2facdc-ed70-481b-51ce-08d7144a3f09
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 17:29:01.2416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sschaeck@cisco.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3880
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.21, xch-rcd-011.cisco.com
X-Outbound-Node: rcdn-core-11.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 25, 2019 at 10:40 PM, Andrew Jeffery wrote:

> The EDAC is a sub-function of the SDRAM Memory Controller. Rename the
> node to the appropriate generic node name.
>
> Cc: Stefan M Schaeckeler <sschaeck@cisco.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  arch/arm/boot/dts/aspeed-g5.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
   =20
Reviewed-by: Stefan Schaeckeler <sschaeck@cisco.com>   =20

