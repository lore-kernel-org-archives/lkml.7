Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD7FC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E2120B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oP+Xs6vo";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="oZbpEOd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfE1Wqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 18:46:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60560 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726683AbfE1Wqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 18:46:31 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4SMeDTl022356;
        Tue, 28 May 2019 15:45:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Dht/EQ/NW33hPf0N0sVtdqFlpzTQYlHxhyoym/GWSLw=;
 b=oP+Xs6voWwAiusXETLr3L9cA3PNnbAsuNrSsb8mIX1fkHPd5wFB297dAEVDqphX7dcHQ
 eLDqpUdQw9kDPsgboF79nVfxQSgzvYwnKa2erQEOQyLnbEWYc5nzSSwCEPsQXOmmuP+0
 bn7N98OtcoRQAUBsqATMIOfF3A3xbG3QGnw= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ss90ch6pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 May 2019 15:45:09 -0700
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 28 May 2019 15:45:08 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 28 May 2019 15:45:08 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 28 May 2019 15:45:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dht/EQ/NW33hPf0N0sVtdqFlpzTQYlHxhyoym/GWSLw=;
 b=oZbpEOd1sVRudzcS8ruxOCx+8m2AM+/XB5Umb3mwfYQ21qMGKGjTJO4ixstSq+KgMZBvPLqWYyYEygffjIvsYmhnV7tEJUbPMuTUFY/LFQYY6krD75dPWCVOaNPFsAqwMBAwx7xzXkOBM3Xgava9eVFIbJBAPK1inm2iEfyKfmc=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2216.namprd15.prod.outlook.com (52.135.196.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.22; Tue, 28 May 2019 22:45:05 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 22:45:05 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 3/4] mm/vmap: get rid of one single unlink_va() when
 merge
Thread-Topic: [PATCH v3 3/4] mm/vmap: get rid of one single unlink_va() when
 merge
Thread-Index: AQHVFHAI/JciIcIEUUWzIo9i9KPWz6aBJReA
Date:   Tue, 28 May 2019 22:45:05 +0000
Message-ID: <20190528224501.GH27847@tower.DHCP.thefacebook.com>
References: <20190527093842.10701-1-urezki@gmail.com>
 <20190527093842.10701-4-urezki@gmail.com>
In-Reply-To: <20190527093842.10701-4-urezki@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1401CA0023.namprd14.prod.outlook.com
 (2603:10b6:301:4b::33) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:3dca]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b998bf86-8829-42a4-328a-08d6e3be209f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2216;
x-ms-traffictypediagnostic: BYAPR15MB2216:
x-microsoft-antispam-prvs: <BYAPR15MB2216D649F2D69DE087853C2EBE1E0@BYAPR15MB2216.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39860400002)(136003)(199004)(189003)(305945005)(6916009)(86362001)(81166006)(7736002)(6116002)(81156014)(7416002)(6506007)(386003)(33656002)(25786009)(71190400001)(102836004)(476003)(52116002)(5660300002)(4326008)(4744005)(256004)(6246003)(486006)(446003)(11346002)(46003)(76176011)(71200400001)(66476007)(64756008)(1411001)(66946007)(6512007)(66446008)(68736007)(6436002)(73956011)(229853002)(66556008)(478600001)(1076003)(8676002)(2906002)(8936002)(54906003)(186003)(316002)(99286004)(6486002)(14454004)(53936002)(9686003)(26583001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2216;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CGJxwBqTXVRi3HzqT5WQvCUdUv/yPQVJJCQTfiI08BNexPiTg6dlK9SfEjWSH4KI2ShBWfWo8IwXM8m5ZXwKPvSRcXJivMTHQqNtHEVgv+YhFsWFbDsq7srhuitthw0WO18666mrr+WCo4jiI00lymu0HLO9zHsPdknMPXoAcjZbHgoocvx0n6hcGAOWJL3g4M/yQHT97lQDpR1CifXmq93ql8O6uWTb0UOSOr6/ITblfARU7PVh4dm24YMHMReD2yJCx2kNjospynp9HjGrvrZ7daNHFxLzEXUFRQfBIAtK+tmJ7t14h3tNblr+SKqLAgx8K1wfgKJmFnJSRl8lGTZtWPzvt7cYHzBVx+yQ5u1RrXK625m83hiDTaju26+YaJRBTRHjLAQrODIfNxQP9Ih9yRqNvTMHbGHtVP9z3K0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5ACA9FE83084AC42BDE0EF09E00EB164@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b998bf86-8829-42a4-328a-08d6e3be209f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 22:45:05.2747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2216
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=753 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905280142
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 11:38:41AM +0200, Uladzislau Rezki (Sony) wrote:
> It does not make sense to try to "unlink" the node that is
> definitely not linked with a list nor tree. On the first
> merge step VA just points to the previously disconnected
> busy area.
>=20
> On the second step, check if the node has been merged and do
> "unlink" if so, because now it points to an object that must
> be linked.
>=20
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Acked-by: Hillf Danton <hdanton@sina.com>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
