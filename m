Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BE5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEAE20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fdkJWURP";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fguWLlW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389214AbfJVQLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:11:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6006 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389184AbfJVQLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:11:00 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9MG5AKc001730;
        Tue, 22 Oct 2019 09:10:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=NZSOkFIjEgDa7qiOEZnClKpo6buRPxMJJzI5T32hoxA=;
 b=fdkJWURP1StnWgNyLq7Hy5JoQT9i9Y2zSET+H/gzV7P7yCArgFPbNdKaG2JEW8IaUDpC
 pzYQf31AVRPZgLnTcKD4DmPrcpa8T6WF5yaNIJdKYhzN1BT4ArX34Kr/T7MQR+7uSuRn
 4jhV8VpuWuStGhb3GUv44X70qHBz8Je2nqs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vsp5e4375-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Oct 2019 09:10:33 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Oct 2019 09:10:32 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Oct 2019 09:10:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jw3pKtVcF83Z6jaIRDv6o2vNBeLWNEyjdQLoRXp17aL8IXakoCD5xNBBe1UVWpKTqW+p0mpl8F7n9M+uKCIqhI4jgzjkL6nphd7gQQDoelmce2jwfsXp8UdkwKzgQMBmGsfXVZU3dBNLWvtaPax7Rz82wo1Zlx8t/4nRTigiFOo1YddvYF+jYUhA57PY8rynZ8PNzFMemYcOMIQNB1OEPz1dw5dja+8ZEJPqZVQwRloMUQY7P+VOs6kVsh1kq5rJ9X+LpoYMSTuDaoR+eT5qG6X55xZS4DGcqpx3of8/vYxmD2NiKO7IF1q27Mo9lEhdY24P9sgQI3deTSq8TRztKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZSOkFIjEgDa7qiOEZnClKpo6buRPxMJJzI5T32hoxA=;
 b=O1QoMYHA5TsuQ1ziXuAiGZ0KXUyAn20cdP8lh9/Zu1nDQ5FDdNfioj1jd6qa7JrNC+mP6o3tfaJRETriyNEFFSg9iAM17q6SktG1iGoPCdivaof+fw/bikKl3tz34emnHubVkNHV48gTtslOak4dV78K+oK6TXpQAc8DPjYFZ1wffMfzzVR2jQucITEb5Qrc6CBHRiYUO6IM1j+97T7xoYPJqbp+dxqEKIdz6JjgqMW1skZ4wtv1fUSTxswhvhRDqLA5I4bKiuBQuROKgwpxA8pumjh/yj57BW3rQ6/uSaxXXTrarTAYw7LeRumKb1Vq4uOBxxl+W0XjRpTrSoUdcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZSOkFIjEgDa7qiOEZnClKpo6buRPxMJJzI5T32hoxA=;
 b=fguWLlW1SxbNYRigmklf29xJJt/sjkT+oFvYNrsh6jrCGW0CLx7UjYi+Re9fbxtiUcnQdOVEZ/W6MD/OjpfztG/0kDO9FgE7u7CKZ+4nmMlV8UNvprOKDEA86Ev+GDSx9ahE8eWzhGpkMWWjId8Gj8Mqg4DtixasERsPdDyYuLQ=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2593.namprd15.prod.outlook.com (20.179.137.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Tue, 22 Oct 2019 16:10:31 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 16:10:31 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Hao Lee <haolee.swjtu@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "chris@chrisdown.name" <chris@chrisdown.name>,
        "yang.shi@linux.alibaba.com" <yang.shi@linux.alibaba.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix comments based on per-node memcg
Thread-Topic: [PATCH] mm: fix comments based on per-node memcg
Thread-Index: AQHViOpGcox1GpSC1kCeFYxSbqsfdKdm1JiA
Date:   Tue, 22 Oct 2019 16:10:30 +0000
Message-ID: <20191022161025.GC21381@tower.DHCP.thefacebook.com>
References: <20191022150618.GA15519@haolee.github.io>
In-Reply-To: <20191022150618.GA15519@haolee.github.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR18CA0039.namprd18.prod.outlook.com
 (2603:10b6:320:31::25) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:1ce2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b5d1ed9-5d73-4ccd-023f-08d7570a5c58
x-ms-traffictypediagnostic: BN8PR15MB2593:
x-microsoft-antispam-prvs: <BN8PR15MB2593ED40B71EF9D8BB97F23ABE680@BN8PR15MB2593.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(39860400002)(136003)(199004)(189003)(229853002)(476003)(102836004)(5660300002)(478600001)(6486002)(1076003)(305945005)(186003)(46003)(71190400001)(86362001)(71200400001)(8936002)(486006)(11346002)(6436002)(81166006)(81156014)(6506007)(386003)(446003)(316002)(9686003)(33656002)(8676002)(6512007)(76176011)(54906003)(7736002)(2906002)(6916009)(14454004)(7416002)(99286004)(6246003)(66946007)(66476007)(66556008)(64756008)(66446008)(6116002)(14444005)(256004)(52116002)(25786009)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2593;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NkWAJ7vgFQNlUcBO/Lr3FenE7BQr2U6Y0q2psQf7qyWceLm7Qcl8t6ASW6+qTQS0q14LFVkWD23dKxxr3/LKu8pDC65jqUqDdiR+Z+dkcNJC8F1Z5IHYN8qZkmuc1rnx4c+mYQ+/ls9Zy/p9ZqDU4s0jcCadUrkroyzGFghKiXiTbJQJPT0SimmSimFkjEDLEHfL2mfh6JY0jA7mcl+/WSrlP5jfjxN2NYReazPMQxN7eEEXlL38uXmiSWR91WO1kZfQcywvh68xiQqrWJNMvX7WZKe2jvaxmT1VMv6ijC3KiG/ZwLn/MvKNiIyR5wWc7ZIiSAEh+QrPZ5bja/ZzplAvTkMer1DKXxgvaj/v7DP6gl0v7PmPShNp9HH+zGSP5iDhUG4F28V/e9W0uLkr2VUCZRDvjpDoFxBRVJC+Ac5FSSKhkmcaO7GIaqpJZIvB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE2FB09EFAD911479A0176C5ED821C16@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5d1ed9-5d73-4ccd-023f-08d7570a5c58
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 16:10:30.9224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Sflmv7MkkrTWMgDTomZGzq6H5hKOYZmnTzrKEewozBa+vLC8xRKklzJoG2d0S7a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2593
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_03:2019-10-22,2019-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910220137
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 03:06:18PM +0000, Hao Lee wrote:
> These comments should be updated as memcg limit enforcement has been move=
d
> from zones to nodes.
>=20
> Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  include/linux/memcontrol.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index ae703ea3ef48..12c29f74c02a 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -112,7 +112,7 @@ struct memcg_shrinker_map {
>  };
> =20
>  /*
> - * per-zone information in memory controller.
> + * per-node information in memory controller.
>   */
>  struct mem_cgroup_per_node {
>  	struct lruvec		lruvec;
> @@ -399,8 +399,7 @@ mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid=
)
>   * @memcg: memcg of the wanted lruvec
>   *
>   * Returns the lru list vector holding pages for a given @node or a give=
n
> - * @memcg and @zone. This can be the node lruvec, if the memory controll=
er
> - * is disabled.
> + * @memcg. This can be the node lruvec, if the memory controller is disa=
bled.
>   */
>  static inline struct lruvec *mem_cgroup_lruvec(struct pglist_data *pgdat=
,
>  				struct mem_cgroup *memcg)
> --=20
> 2.14.5
>=20
