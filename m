Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABFBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D592075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mziFIS8O";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="B0BG1qry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfCMS0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:26:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58704 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfCMS0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:26:14 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2DIJp60006331;
        Wed, 13 Mar 2019 11:26:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ud6/U5sLaNyQXgEDX4pHtMm5ih1hKxAeLoRbN2lxZms=;
 b=mziFIS8OmcB2Is91py7AUWN/UQz/Ls1qbwNhOrXSSsvF7DDruapGvastyLrSznxvm546
 yZRl/JHVjpWDgmR46CCVDi8S1Mk+x/icnHhB1e+lYa2BBkc7V8rpUU60bBSrhStn4YQ4
 8m7ZSKZmOknxa9KDASU8fwppT2LybCnBhF4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r771wg1js-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 13 Mar 2019 11:26:09 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 13 Mar 2019 11:23:53 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 13 Mar 2019 11:23:53 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 13 Mar 2019 11:23:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud6/U5sLaNyQXgEDX4pHtMm5ih1hKxAeLoRbN2lxZms=;
 b=B0BG1qryZKvLbkk6UtpBeut4ET96MlB4oTZu5rak8GF5wTZ5mcyoyWdNktcyf2timix7VwAiEVaQgJP9GuifI5MV24UhRBujxyLL68icPybzbN+Ssc0hTeLLfRQ022LO4t6KKBcIgSfwUvSz48ftxSsSFOKI+cXNu8TgiYZDGBw=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3192.namprd15.prod.outlook.com (20.179.56.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 13 Mar 2019 18:23:35 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%2]) with mapi id 15.20.1686.021; Wed, 13 Mar 2019
 18:23:35 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Roman Gushchin <guroan@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 6/6] mm: refactor memcg_hotplug_cpu_dead() to use
 memcg_flush_offline_percpu()
Thread-Topic: [PATCH v2 6/6] mm: refactor memcg_hotplug_cpu_dead() to use
 memcg_flush_offline_percpu()
Thread-Index: AQHU2SPHfXxtM9jIQ0KuYqpravz+paYJu4eAgAAl6oA=
Date:   Wed, 13 Mar 2019 18:23:35 +0000
Message-ID: <20190313182330.GB7336@castle.DHCP.thefacebook.com>
References: <20190312223404.28665-1-guro@fb.com>
 <20190312223404.28665-8-guro@fb.com> <20190313160749.GB31891@cmpxchg.org>
In-Reply-To: <20190313160749.GB31891@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR06CA0024.namprd06.prod.outlook.com
 (2603:10b6:301:39::37) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::f5e6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 078580ba-439e-4445-d3d0-08d6a7e1018c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3192;
x-ms-traffictypediagnostic: BYAPR15MB3192:
x-microsoft-antispam-prvs: <BYAPR15MB31923ECE92661A5BDCE4AED6BE4A0@BYAPR15MB3192.namprd15.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(136003)(396003)(346002)(189003)(199004)(1076003)(6116002)(4744005)(6486002)(256004)(86362001)(316002)(6246003)(7736002)(305945005)(5660300002)(186003)(25786009)(229853002)(52116002)(4326008)(386003)(9686003)(6506007)(76176011)(6916009)(102836004)(81156014)(6436002)(71190400001)(478600001)(53936002)(8676002)(99286004)(97736004)(8936002)(446003)(46003)(14454004)(105586002)(106356001)(476003)(33656002)(11346002)(486006)(6512007)(81166006)(68736007)(2906002)(54906003)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3192;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W4ZXKtGqonpn34CApX3WoIFNatmGsbukFbmxlANWRngoEECNmSisUrnXJIgSu8EmHqLF5ewi4pj3btJZCN6eS5PhhH/Vyl+QcUC0TfKuri+F6ryrEP4RL2lLlA40LIQtkS914W0Hn23QTUyLTHuB3PEe2YIIwtz8Reqz7EnKf0KBGgUuWMDc6hIp2dcGQekvn3eABJLPYT4zdY/hFlusj8k8bIsqf3WHQ98JaDngosO//ZJydinyGS3ZUsAJxVQALbX4u6LLAozXZ09WBSI3da0FCviiwolu8gn/eekKyG6xcy7Y7CRjE70ox8UcJDvW0ZBzO8YvOa7G5vC1K+lz3fn6vc6qxBW+T6jrEAjY2+TdL7dTF/P0Frtc7WwEoDRrLuLekcQsRPK4eTKS3C+7vPOV4xmT2+yIaKWycLuzwLU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65B672453086894D9C2E74DC37F97FB3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 078580ba-439e-4445-d3d0-08d6a7e1018c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 18:23:35.7732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3192
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 12:07:49PM -0400, Johannes Weiner wrote:
> On Tue, Mar 12, 2019 at 03:34:04PM -0700, Roman Gushchin wrote:
> > @@ -2180,50 +2179,8 @@ static int memcg_hotplug_cpu_dead(unsigned int c=
pu)
> > +	for_each_mem_cgroup(memcg)
> > +		memcg_flush_offline_percpu(memcg, get_cpu_mask(cpu));
>=20
> cpumask_of(cpu) is the official API function, with kerneldoc and
> everything. I think get_cpu_mask() is just an implementation helper.
>=20
> [hannes@computer linux]$ git grep cpumask_of | wc -l
> 400
> [hannes@computer linux]$ git grep get_cpu_mask | wc -l
> 20
>=20
> Otherwise, looks good to me!

Fixed in v3.

Thank you!
