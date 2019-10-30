Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C83CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4C02067D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jbiHAiws";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NG9iU9if"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfJ3Vfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:35:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36802 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727361AbfJ3Vfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:35:41 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9ULZGdP007608;
        Wed, 30 Oct 2019 14:35:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=xtn4Gu0q4WTHSoxu3eGVPY1mCW0JtcubVqX6fgIDKzQ=;
 b=jbiHAiwsKFBdmJbKsS6Hpn/DxeRVicwHmvOc3GHKeYqs0ERWG7aZjB0jQjj7P7Quv2//
 ab2o0X1+OEl9G0xWIQBs5ojAm98u/6uJpfUXaMmZC2OF6X3WvnA244u6PcVignR0JM/K
 tLmEVATH2Ekgm3C7j708o36a3gALkRAmgrY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vxwn6x0kr-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 30 Oct 2019 14:35:30 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 30 Oct 2019 14:35:22 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 30 Oct 2019 14:35:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0W3fpc31fXXzE2PFnYnW2jrpKG1meJNOVYtzwzHxGP9UAmxv2Y3aUjMuWGl/j9MDpzcU8vWzXHmswgTb+m0K1qYOmh+D43wbaoIATsKuyEn2cw8KAQeihTAntW20dhKZQFFPEs8FkZ3LbTF4u2Lk+h80A4U7dDnHmpBUE2HGCSeKBHK7Ra+hsgyNcQjHEnmC4IIufkg6S/+9SPG4X0EgquZ+Tk5CsuwBv1OEcDE7erxv4nuNX2KeVJ1NoSFs0QXvvcyORYRiJPm25ly4/V/poXI1L4vjqFK51YPuRaHbb0J6LzDPN4NAJaqhOse5HgnpE6DO+jg7YMUWkkeEKdnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtn4Gu0q4WTHSoxu3eGVPY1mCW0JtcubVqX6fgIDKzQ=;
 b=e3B6DwiTkuBJo2lv8u7K2fzO3dMIFByhCb234hEt7aCpYMfMVvTG/1IB1DdXee1wV34KIlOEDJQBgCOV09THMNP/rwy2qt635okloxDyJ0KSRveNFuNB4JU13BXkie9qTnfNDcn3c1N9cXqkje7F8tcFD78PBEDmuDhktVQvJSKAWAoagkYRLnlMENbJSJoefkYUR5WG4olEbQwll/Dmq9C3CP0etbBot85ULNNVtydryubsZD5lmudQihaNtTMNJzEbKm/XGzUBwz7Ci+xp/+RE/KnFD4nYwdgHXomXBweLIKe/bbGZiRHTX8imm7l7GL8iVr2G+aYg/xqX+FZqTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtn4Gu0q4WTHSoxu3eGVPY1mCW0JtcubVqX6fgIDKzQ=;
 b=NG9iU9ifkYhrrEb6XHjvsUn0IRYab+QSEktiXyNL2RoyFY7WXbY2Cy4PLFsPMT/ytRQ+lOTHsrnMiIDIi68tM5tXfEhQhbMpZY0tQzICBGOZChu8wqEYTtsans/3NH4GNZSAQZkO2Q9LVVdaSHUpUWECM814w+movuzTB7xn5zQ=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3444.namprd15.prod.outlook.com (20.179.76.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.18; Wed, 30 Oct 2019 21:35:20 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2387.027; Wed, 30 Oct 2019
 21:35:20 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] mm: slab: make page_cgroup_ino() to recognize
 non-compound slab pages properly
Thread-Topic: [PATCH] mm: slab: make page_cgroup_ino() to recognize
 non-compound slab pages properly
Thread-Index: AQHVi4v82H5KK2bDBUCYEvoLagPlLadzs8sAgAAI8IA=
Date:   Wed, 30 Oct 2019 21:35:19 +0000
Message-ID: <20191030213513.GA15706@castle.DHCP.thefacebook.com>
References: <20191025232710.4081957-1-guro@fb.com>
 <20191030210314.2el7wysojucqypoq@ca-dmjordan1.us.oracle.com>
In-Reply-To: <20191030210314.2el7wysojucqypoq@ca-dmjordan1.us.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0048.namprd22.prod.outlook.com
 (2603:10b6:301:16::22) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::3c87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9521b0e0-d522-4045-39f6-08d75d811016
x-ms-traffictypediagnostic: BN8PR15MB3444:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB3444570AE43932CCBF223E4ABE600@BN8PR15MB3444.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(199004)(6246003)(476003)(6486002)(1076003)(11346002)(478600001)(486006)(52116002)(305945005)(6916009)(99286004)(5660300002)(86362001)(102836004)(446003)(46003)(7736002)(6436002)(186003)(6512007)(9686003)(76176011)(6506007)(386003)(4744005)(6116002)(8936002)(54906003)(81156014)(81166006)(8676002)(14444005)(2906002)(71200400001)(256004)(4326008)(229853002)(71190400001)(33656002)(316002)(25786009)(66556008)(66946007)(64756008)(66476007)(66446008)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3444;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yjR5fqMUHxVzGxQdpylR7bPzLPOizylHsMyl3Xbv6zfsB4OCfH6MBKzT0xQrku9cu9qMjC/ecxZVOMuoehAJsLrPeAxoik2psb7sLFDcEPEb4A+Ny9VOOj5dR+BRnjGjDuxxAONRXx/2LBmpA9gbg8GDVrGnA2ZdRHqtO2cU2FtRuS1Evik/8OFFqQ/YoBPmmjPCHTRE/rLPZ7sUCDgoIClOQWvnYyQtf9oSHV0ISRUxGk59BttIa3wVi7MlaI6OxI6WalFjESNRFnPKjqXZiD1kHxPbMuZg/7S5k/4hrpkV3NWpby6bfc0xpgaZ5ND60hpKVMQ2hY6K09cLpcBFQ+X6WAqZjNdKAaDnOkWZ+aDfDbKJ+uGw2oTBL8mVmqCfeAM+YM1o3YWbHf63d2WvZRS2usGtxWPCKq84wVYN83S2f6PW/6X7qH7MPrJihaQ3
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93E53AB8895A244C87CBDBD29623B224@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9521b0e0-d522-4045-39f6-08d75d811016
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 21:35:20.0119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sUnHOaYpEdiBImls1tSq9PvFTr6JBdOa+cua/ApyAy7UCiAdZhjTDDv4+uI7xXxD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3444
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-30_09:2019-10-30,2019-10-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=766
 mlxscore=0 spamscore=0 clxscore=1011 phishscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910300189
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 05:03:14PM -0400, Daniel Jordan wrote:
> Hi Roman,
>=20
> On Fri, Oct 25, 2019 at 04:27:10PM -0700, Roman Gushchin wrote:
> > page_cgroup_ino() doesn't return a valid memcg pointer for non-compund
> > slab pages, because it depends on PgHead AND PgSlab flags to be set
> > to determine the memory cgroup from the kmem_cache.
> > It's correct for compound pages, but not for generic small pages. Those
> > don't have PgHead set, so it ends up returning zero.
> >=20
> > Fix this by replacing the condition to PageSlab() && !PageTail().
>=20
> You may also want to update the comment above memcg_from_slab_page():
>=20
>  * So this function assumes that the page can pass PageHead() and PageSla=
b()
>  * checks.

Good catch, thank you! Will send v2 in no time.
