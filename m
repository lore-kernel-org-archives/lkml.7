Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999E1C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B4522525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ij0mNltv";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IBhDEPLJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfLEXXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:23:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34290 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725926AbfLEXXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 18:23:38 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB5NNId3012885;
        Thu, 5 Dec 2019 15:23:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zk/94KuBibXYDxz7zTaEOpwQo6TdeuEqSYrroFallmg=;
 b=Ij0mNltvVs90nMBKbHfrzWD7XUZmZYXyCC7SO/3DgfU08jdOfftNbrWizocNDyL9CQwq
 /pCK3rNxwDyEZAHucAwKBQXqWt6W0ePQIhwh92WVDQz/qR03nW0XwSqIduqv6GeyMUu6
 wjfwGpoYUHEKaRbXfvHnG2nKf5esJaXf+7w= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wpyvjkj49-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 15:23:25 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 5 Dec 2019 15:23:18 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 5 Dec 2019 15:23:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfbv4v99zOrTkfZMlNLnDUv9HvlHjGYnlGYU36QS7zNMJKL/x1JTuYhLZVR3uYEhZL1iaRSX/nl8sen4HIxEPjTiK69I4V9OiPB5B0r0LZL+7uTIH4wILmzUvIEf2/QZIVz2ROJlCKs6tpE9lijp5Idp7oaUWaTJoZUORLu9N/tj3A8lpO4TWuHbza4BGzJwOnzbyz0Y7URxRlpGJLLcM+bf92P2Xov8y+uXNxXJCYPOeoe8C1IXE7PMCWlGEP3D95w73bo56RpBl1EMPXE6wmQoNWHh7dnfJG9iG621IXuGdFHVulbJbrkrecAONWc3Cje4E8JjWCpn9CZ5eb97Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zk/94KuBibXYDxz7zTaEOpwQo6TdeuEqSYrroFallmg=;
 b=YdOlaunn46Bin5i6N9IxF507ACoWf7IcBx7BJdgAF+R4p/8X9r9Y7omvfEo4MQoOkHjZpNQjdjBlQfWgmQatOmEVFfbi2GhLiey4L0Z7r3BL5dfYVxRPbe65x6k1lUoMBg75BGeYCgFDArAMWRTZcq3lV0Sr66c5fGIv1tG+0E3WYIcGUEzPTRutVnKtQOt6JBedQ5PFy7m+/I8RTqWy86BCsKr61EBY10KIjfTjn/WHnHyTxUInYikQUzHu2k2eCPMvSo66x1qIktD2QflM/0vhwQnZ9DQEbKeAviQ4b/4rILUKDR55pRG1lZEZOqSSP4VelQGeKPVjRvOCgyBrmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zk/94KuBibXYDxz7zTaEOpwQo6TdeuEqSYrroFallmg=;
 b=IBhDEPLJfeAW6JPsGq6ZTPsagYgz1z6dBc2AyBilAXapUiy0Jkit5SRNQBWLvVoXz0N/oQrqe6UBcrOeJUF+rGKXMUCAgV3SZRq6BuYJso1bY/y2OjWpUK1kwfvHFXy+Js+TqJnb7kDbIDghIWa+UZ9Et/WCqTXKZcGpClfnL+g=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2984.namprd15.prod.outlook.com (20.178.206.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Thu, 5 Dec 2019 23:23:16 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60%3]) with mapi id 15.20.2495.026; Thu, 5 Dec 2019
 23:23:16 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: account security cred as well to kmemcg
Thread-Topic: [PATCH] memcg: account security cred as well to kmemcg
Thread-Index: AQHVq7zmY0RJOkn79EOYBtO93ilvEaesLnIA
Date:   Thu, 5 Dec 2019 23:23:16 +0000
Message-ID: <20191205232312.GA21927@localhost.localdomain>
References: <20191205223721.40034-1-shakeelb@google.com>
In-Reply-To: <20191205223721.40034-1-shakeelb@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR16CA0068.namprd16.prod.outlook.com
 (2603:10b6:907:1::45) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::63f1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 845e02a8-a6c8-4257-79ff-08d779da1b3c
x-ms-traffictypediagnostic: BYAPR15MB2984:
x-microsoft-antispam-prvs: <BYAPR15MB2984824D4D66D0C75DD3BAA8BE5C0@BYAPR15MB2984.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(366004)(136003)(376002)(189003)(199004)(99286004)(33656002)(14444005)(8676002)(4326008)(6916009)(6512007)(6486002)(81156014)(9686003)(305945005)(2906002)(52116002)(71190400001)(81166006)(71200400001)(15650500001)(229853002)(76176011)(8936002)(64756008)(478600001)(102836004)(66556008)(14454004)(5660300002)(66946007)(54906003)(11346002)(316002)(66476007)(66446008)(4744005)(186003)(86362001)(25786009)(1076003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2984;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N4FaFbzxwt6TBA3N1FbGkceqcGibMhBOydJm+EX4lSgoeFzQ+34atJCSeyzD1ThK3isU7uL3R7SQmNh8ft4oGAj1Q1jTb2PsqLkvngtQvjjaZGzXjnpYyOTBW3dXN3fam4fqqwBsfrBX1PsWhK5RQ1K/YjgZ39j8+FlhR9ZvTKmgTXo3f5mf+OLQZ3d61ed8SmgX6PeM7y/zysoA1lkmB62n/zFq3vgesz3lMr8WRK2O5gfs2ed23aaUfoRIxViAIpycUIgj6J6FfJ+Olw9fDIC29IYHqqE/R+anOyMHjIgEKqRiXQ0yb/9ldi+Wjdn4xTqd5eyZ1QtkoFOxOZDbE9Er89VgYUhY0mrMuYidkPPGb9a9AFSKsCaWlPXRBBPUMKteIObbWc+JsMDMDPijKXwgZEvN1rCUgNSC5eaCNsK52SvPESUTQMI8wFmSdJJ5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EC77818A3D22744F97C49CB802CB4691@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 845e02a8-a6c8-4257-79ff-08d779da1b3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 23:23:16.5462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q6Ma2cT9lDVdeSNCV/2bxUXhf7IDZf/CPiIrui/G8CEt7y4novLPVGoAgH5udxY6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2984
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_10:2019-12-04,2019-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=470 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912050191
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 02:37:21PM -0800, Shakeel Butt wrote:
> The cred_jar kmem_cache is already memcg accounted in the current
> kernel but cred->security is not. Account cred->security to kmemcg.
>=20
> Recently we saw high root slab usage on our production and on further
> inspection, we found a buggy application leaking processes. Though that
> buggy application was contained within its memcg but we observe much
> more system memory overhead, couple of GiBs, during that period. This
> overhead can adversely impact the isolation on the system. One of source
> of high overhead, we found was cred->secuity objects.
>=20
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
