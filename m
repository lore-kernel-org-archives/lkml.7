Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F0BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F78F20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fmQz6EN+";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QiT3P11O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfDDS5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:57:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55504 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727398AbfDDS5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:57:06 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34Is3Kp019601;
        Thu, 4 Apr 2019 11:55:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=9UdoYJmczw+bO/UVZdPp9h+8nEq2EtmEzU3lHO4/2tU=;
 b=fmQz6EN+pif90FTHV/v9lXGR6Q9NiXsDVCBG5Tz+uD9n8mp9GhQNSON0wKv6TOAne/g6
 JRe4FwN0LAtZ+YMMaA+KoXl4I0kbOJj9WbZTgDq21Gs3pMQI9hXlzBXp9zQtpu/MNBcs
 iE5ClEcDbgyPsq1E2/8CbkDCORNQ/J6uD+E= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rnjyc96y4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 Apr 2019 11:55:23 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 4 Apr 2019 11:55:20 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 4 Apr 2019 11:55:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UdoYJmczw+bO/UVZdPp9h+8nEq2EtmEzU3lHO4/2tU=;
 b=QiT3P11OLN0zJEDMRt/kKV66HGcTLDArszO4cKegU/GHbTvLMpkGMeL4Ida1ktSY7pHxbFCUnmcYAZtUQwmwilcR7UkTuOurdfoD8iAJfer0jIAgk0RtShNuXlJIObSB6+85F5EIUx+olsRtXPnsIgRMhIFZy5/F6xERHfkdaXM=
Received: from BYAPR15MB2311.namprd15.prod.outlook.com (52.135.197.145) by
 BYAPR15MB2360.namprd15.prod.outlook.com (52.135.198.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Thu, 4 Apr 2019 18:55:18 +0000
Received: from BYAPR15MB2311.namprd15.prod.outlook.com
 ([fe80::1803:10f2:3d80:c10c]) by BYAPR15MB2311.namprd15.prod.outlook.com
 ([fe80::1803:10f2:3d80:c10c%2]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 18:55:18 +0000
From:   Lawrence Brakmo <brakmo@fb.com>
To:     "Tilmans, Olivier (Nokia - BE/Antwerp)" 
        <olivier.tilmans@nokia-bell-labs.com>,
        David Miller <davem@davemloft.net>
CC:     "De Schepper, Koen (Nokia - BE/Antwerp)" 
        <koen.de_schepper@nokia-bell-labs.com>,
        "research@bobbriscoe.net" <research@bobbriscoe.net>,
        "fw@strlen.de" <fw@strlen.de>,
        "borkmann@iogearbox.net" <borkmann@iogearbox.net>,
        "ycheng@google.com" <ycheng@google.com>,
        "ncardwell@google.com" <ncardwell@google.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "agshew@gmail.com" <agshew@gmail.com>,
        "glenn.judd@morganstanley.com" <glenn.judd@morganstanley.com>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] tcp: Ensure DCTCP reacts to losses
Thread-Topic: [PATCH net-next v2] tcp: Ensure DCTCP reacts to losses
Thread-Index: AQHU6uFJ5qKL9TJ2LUy0DTa6bmxAT6YsSKWAgAAmjID//+KCMIAAKfSA
Date:   Thu, 4 Apr 2019 18:55:18 +0000
Message-ID: <75CDFF88-5632-4A44-A2BF-5725CDDE7DCA@fb.com>
References: <20190404121731.13917-1-olivier.tilmans@nokia-bell-labs.com>
 <20190404.105243.1039649838417325989.davem@davemloft.net>
 <532BB0D8-95C8-4A4D-A73D-3B563909780F@fb.com>
 <AM6PR07MB4821BB64AF86A1A650C95000E0500@AM6PR07MB4821.eurprd07.prod.outlook.com>
In-Reply-To: <AM6PR07MB4821BB64AF86A1A650C95000E0500@AM6PR07MB4821.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.14.0.181208
x-originating-ip: [2620:10d:c090:180::1499]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e20858d4-45fe-48dc-0e03-08d6b92f14e2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2360;
x-ms-traffictypediagnostic: BYAPR15MB2360:
x-microsoft-antispam-prvs: <BYAPR15MB23600D7D3DBB35009B851A48A9500@BYAPR15MB2360.namprd15.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(36756003)(58126008)(46003)(71200400001)(186003)(68736007)(54906003)(53546011)(86362001)(6506007)(71190400001)(76176011)(6116002)(99286004)(446003)(229853002)(110136005)(7416002)(476003)(83716004)(102836004)(11346002)(316002)(6436002)(2906002)(6486002)(2616005)(305945005)(82746002)(4326008)(93886005)(478600001)(6246003)(8936002)(486006)(5660300002)(256004)(105586002)(8676002)(106356001)(81166006)(97736004)(53936002)(81156014)(14454004)(6512007)(25786009)(33656002)(14444005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2360;H:BYAPR15MB2311.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QPp08bvVER5Tf+lLN4n+evZX5EXxf1NR60r/gZto81hkgIW9CZDNHoj2vgz/bpQyxRHBLXFIywZY48/x01WEH+ErYBZeOZfePIxN/3hoVaxSbIqGKuBL5dd7ew7zsY1dHw7bPkMyyseKDP9DqEJAFsekynY1u8kuyScOgeX3qQ+4QzxWcfI2Vx0+RXxvAES2CKGRfp62ySHSd2ZEb24Y5D9p0DN5zO3+KN/KvIwoxy3prVS20MW+88a/XgzXEUsUAW0h7ScdIjPfFa3bHqtCYxJzM6LdbKGerD+etd6CveuYZOmxxzeLLeN+M7jpQNUl8S1uxMgjJW69+ULRuOkmUwA6O6euvIwgHBNGN+8tC/cG0hennt0Ijua89e2Fa2ZVh+6f298TAie7xjLRfG8amiaTjCETa7Z6WxATavb3mfA=
Content-Type: text/plain; charset="utf-7"
Content-ID: <DB381A052CB9AD4B961E3B7013D81BBC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e20858d4-45fe-48dc-0e03-08d6b92f14e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 18:55:18.3453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2360
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/19, 11:39 AM, +ACI-Tilmans, Olivier (Nokia - BE/Antwerp)+ACI- +ADw-o=
livier.tilmans+AEA-nokia-bell-labs.com+AD4- wrote:

    +AD4- DCTCP is meant to be used in environments where the switches/rout=
ers do
    +AD4- ECN marking, so it is not surprising that it performs badly when =
used in
    +AD4- environments where it was not meant to be used. Has anyone measur=
ed the
    +AD4- effect of this changed when DCTCP is used in environments where a=
ll the
    +AD4- switches/routers do ECN marking? My concern is that we could end =
up
    +AD4- hurting performance when DCTCP is used how it was meant to be use=
d in
    +AD4- order to protect incorrect uses of DCTCP.
   =20
    The results reported are indeed from a non-optimal setting, and mostly =
to
    show that it was ignoring losses. In practice, we only use DCTCP on=20
    ECN-enabled AQMs, and rarely see the loss reaction (e.g., a burst of ne=
w flows
    IW that congest the ToR switch, in which case I'd argue the behavior is
    beneficial). I cannot estimate the impact on FB's workloads though.
   =20
In some of our environments we do see packet losses at high workloads with =
DCTCP.
My concern is that I have no idea whether this change will be beneficial or
harmful in those environments.

    I had originally put a module parameter to make this loss reaction beha=
vior
    optional, mostly to enable people to check first whether it was safe to=
 use=20
    with their configuration. In hindsight, I should have waited a bit more
    before submitting the v2 with its removal as requested.
   =20
The module parameter, even if enabled by default, would have been
preferable since it would support environments where this feature
turned out to be sub-optimal.
   =20
    Olivier
   =20

