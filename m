Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8EBC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC99821D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Odj3OOZ0";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="B0bRIS7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392573AbfIYT67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 15:58:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61776 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731558AbfIYT66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 15:58:58 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8PJnVkk015014;
        Wed, 25 Sep 2019 12:58:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=D33I52QrrDYS6I0XA4Hcpeftq/Ryy87FlQyumwpSjfA=;
 b=Odj3OOZ0teeAuSpkQOHG/PP6A4aUkpABgp7Hj7tLR4IJXm05vEQ1baBYaa4GKqGS3U8s
 dPP4KekGBL9RK1eiJhETmQFeSkO/TJtvIhE6xQVsi5WgmzhqSYizUnje72i3q8Pf+dL5
 ShZNUfLvfhwBAuxNpW4e5SA5RYrvtzdmXek= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2v7uqn4kqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 25 Sep 2019 12:58:55 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 25 Sep 2019 12:58:54 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 25 Sep 2019 12:58:53 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 25 Sep 2019 12:58:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVcJuUlfB/laAegKel3SNqKInpKt36LZ7dmdIktcu2s1OTxty7S/4e+IZkR4mTMJLGIrdR0Qa7hgVeVeD8CX7YYdrauXdbKi96V1sl5ZzTevz1n+BcKMBv0QMQzOUrTZf/ab/+9NCsqHaU6aepNtZrKtwH2NBJmm5aEMqdDMtfsdGWJQSMVle6gGKpf10xz8zMNb55QCLe1l1JiMpIRlRBvLQ12xYDSlK5cM10kwiMSwm9IpnS3FnL9BjWj6GLi0luG7gFBGIA7Riqe0Vhi0YwHq0LEhnkuWpWAucjfstYJC83IdFys5JOQmsZmPzfBm1pyy56MFDegFvQcJiSLhHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D33I52QrrDYS6I0XA4Hcpeftq/Ryy87FlQyumwpSjfA=;
 b=iHuy/HsccEfS935RKIT5cisFO3C5jsbnUObm3iNGvztvd3akPtqnfSycD1wfFNdjUIcwtFiwczUoyCwB+TYMxbjxWlNfJJziKhpkhG7+rb01rjo0tD7nc71TaxjTjYcy+l+3Ldbpg6ZL+8xm9XszYMlZ3fOqxNMRlrUcDWlXRn4Gpq0QuAB3Vw0kjN9GodRoBj43iRbAA2fcX+BnODCdSOY+UboBJ5zapUTPmkVRK0BHQen/OuxRwQKaeFrXPSbv2n78F7qwMQ2DDPm3N5cLB6IaBhNpGqPl8SvHSxCZeurje/7lRBEuIoIxpiKk6Nxk/ivpWAHbZ3eRyiUGtmv+AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D33I52QrrDYS6I0XA4Hcpeftq/Ryy87FlQyumwpSjfA=;
 b=B0bRIS7sulIxJP3IiiRTIqqcwEjqYngDw2rUVplgHSTmtbzDV8o35UfftbtOq1blQEJEIsHyoyJLoc+H10xCH88zc4TQm0Bmsp/P7OK2goUnRpaDilXkU7NpGitDI1lPvIyV9dTkn7Wlm7UFwmYn6hLJ88g7Kfv6Wdjss1TRG5I=
Received: from BYASPR01MB0023.namprd15.prod.outlook.com (20.177.126.93) by
 BYAPR15MB3319.namprd15.prod.outlook.com (20.179.58.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Wed, 25 Sep 2019 19:58:52 +0000
Received: from BYASPR01MB0023.namprd15.prod.outlook.com
 ([fe80::e448:b543:1171:8961]) by BYASPR01MB0023.namprd15.prod.outlook.com
 ([fe80::e448:b543:1171:8961%5]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 19:58:51 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Jonathan Haslam <jonhaslam@fb.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH] docs: fix memory.low description in cgroup-v2.rst
Thread-Topic: [PATCH] docs: fix memory.low description in cgroup-v2.rst
Thread-Index: AQHVc9tPpoIhWHv/e0OyKQ/9Cg9cx6c8z5MA
Date:   Wed, 25 Sep 2019 19:58:51 +0000
Message-ID: <20190925195848.GA24238@tower.dhcp.thefacebook.com>
References: <20190925195604.2153529-1-jonhaslam@fb.com>
In-Reply-To: <20190925195604.2153529-1-jonhaslam@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0022.namprd22.prod.outlook.com
 (2603:10b6:301:28::35) To BYASPR01MB0023.namprd15.prod.outlook.com
 (2603:10b6:a03:72::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:5155]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61f07905-05c4-44b7-3e77-08d741f2c972
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB3319;
x-ms-traffictypediagnostic: BYAPR15MB3319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB33193CBD6FE93116A53806D1BE870@BYAPR15MB3319.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(189003)(8936002)(52116002)(476003)(54906003)(11346002)(446003)(76176011)(486006)(316002)(2906002)(186003)(6506007)(386003)(99286004)(9686003)(6512007)(478600001)(6246003)(6636002)(1076003)(46003)(81156014)(66476007)(66556008)(66946007)(305945005)(25786009)(86362001)(81166006)(5660300002)(33656002)(6436002)(14454004)(71200400001)(71190400001)(6486002)(256004)(64756008)(6862004)(8676002)(66446008)(6116002)(229853002)(7736002)(102836004)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3319;H:BYASPR01MB0023.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9koz+Eb949fGghtPJzkC361f4aNm1vBqgUSYbr6pY9MD8II7OwN6hSFUu0iZeK7I85G7CmDzCnaHYhU7FLwEdvxzyHodB41njRXjMrgsjnlRURtGmyJUGi5OfUMKEgOMcTT8UMXex1GzCK47/W5zo1cESUpBBf3xSwzYcAOCbrSa9ujEfJZlAl6kIXzTDgS1rtmAnfrzr97jd2KEn5PkX5THvjGf0BVvSHC7eUJT+LByWzR+27hgJvyoNQ+0qf0WoSsb08UkDML8ulp09+TCWlkg9V8AjE2Kopy0HjkQvpjsYyg+aITEHuJCB+RNEFhNh0nqk7mookMH88SI98ERUGqKlRba0s6i6Xxh6/L+TFpG7XqjngDdB+69iICO1bk0PoKMzUj987vHS7jkJxpHQ8W4i2kOHDtHFdSWxv81VVA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0B0607AD1C7C624E905B618BBEE01B90@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f07905-05c4-44b7-3e77-08d741f2c972
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 19:58:51.6381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41BVbrUw9i74q+XxIwy6n6Bvo87ZdSMo6lb7yNVSQrC2AYJaXMNp8HCqwK2WXK5L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3319
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-25_09:2019-09-25,2019-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 clxscore=1011 mlxscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909250162
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 12:56:04PM -0700, Jon Haslam wrote:
> The current cgroup-v2.rst file contains an incorrect description of when
> memory is reclaimed from a cgroup that is using the 'memory.low'
> mechanism. This fix simply corrects the text to reflect the actual
> implementation.
>=20
> Fixes: 7854207fe954 ("mm/docs: describe memory.low refinements")
> Signed-off-by: Jon Haslam <jonhaslam@fb.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks, Jon!

> ---
>  Documentation/admin-guide/cgroup-v2.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 0fa8c0e615c2..26d1cde6b34a 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1117,8 +1117,8 @@ PAGE_SIZE multiple when read back.
> =20
>  	Best-effort memory protection.  If the memory usage of a
>  	cgroup is within its effective low boundary, the cgroup's
> -	memory won't be reclaimed unless memory can be reclaimed
> -	from unprotected cgroups.
> +	memory won't be reclaimed unless there is no reclaimable
> +	memory available in unprotected cgroups.
> =20
>  	Effective low boundary is limited by memory.low values of
>  	all ancestor cgroups. If there is memory.low overcommitment
> @@ -1914,7 +1914,7 @@ Cpuset Interface Files
> =20
>          It accepts only the following input values when written to.
> =20
> -        "root"   - a paritition root
> +        "root"   - a partition root
>          "member" - a non-root member of a partition
> =20
>  	When set to be a partition root, the current cgroup is the
> --=20
> 2.17.1
>=20
