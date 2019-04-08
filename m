Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9040DC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE6E21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BSm/Mp3G";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BSMnM7hT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfDHWOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:14:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42168 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726343AbfDHWOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 18:14:20 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38LwHut018713;
        Mon, 8 Apr 2019 15:14:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5i/1E2kTS3p1CbdWzT30zU1x2bwEA7OP6pPWPlJlxxs=;
 b=BSm/Mp3GvKzIgO6500QWYg6tkLZJLVQhgUlGHIK4N8EfF2b1cQDidEWUeQ94g0VY5qNt
 mYZp2gobgG/qsz4fmS7adrBzmbGOAmKi1wzgequvuLIiiG2hrjL0/X557CQwNqcP488g
 tYExuTlEYViLHi/auTmwsfcZGnPV4TiGysw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rraew179d-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Apr 2019 15:14:13 -0700
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 8 Apr 2019 15:13:58 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 8 Apr 2019 15:13:57 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 8 Apr 2019 15:13:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i/1E2kTS3p1CbdWzT30zU1x2bwEA7OP6pPWPlJlxxs=;
 b=BSMnM7hTg+GLnAb3T28X+zs6L7iCdb8KqHT319W0fCk0S7rpgL2SWj2Z6QZi8K6p2qmVO/TSFECEkqdann+ygYloYBcWBYLDC/XJ2+WpWHWZHs0+HlkUL7jzWkV2onKXCTAdlKW7dXYOVlXMiMnDmhWvcbUU63mRZJW7+QLJPwc=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2439.namprd15.prod.outlook.com (52.135.198.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 22:13:56 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%3]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 22:13:56 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        "Mike Rapoport" <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] selftests: cgroup: fix cleanup path in
 test_memcg_subtree_control()
Thread-Topic: [PATCH] selftests: cgroup: fix cleanup path in
 test_memcg_subtree_control()
Thread-Index: AQHU7lRu6JeDm9liREyEUsQ3gmR3g6Yy1AkA
Date:   Mon, 8 Apr 2019 22:13:56 +0000
Message-ID: <20190408221350.GA15335@castle>
References: <20190408214512.1815060-1-guro@fb.com>
In-Reply-To: <20190408214512.1815060-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2001CA0009.namprd20.prod.outlook.com
 (2603:10b6:301:15::19) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:3bd3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bc85ce3-30ec-4e64-62e2-08d6bc6f7e44
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2439;
x-ms-traffictypediagnostic: BYAPR15MB2439:
x-microsoft-antispam-prvs: <BYAPR15MB24397880C8CC39D71F0022B3BE2C0@BYAPR15MB2439.namprd15.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(39860400002)(376002)(346002)(136003)(396003)(189003)(199004)(316002)(71190400001)(106356001)(105586002)(99286004)(71200400001)(97736004)(1076003)(8936002)(52116002)(5660300002)(81156014)(8676002)(86362001)(256004)(305945005)(81166006)(33656002)(229853002)(33716001)(6486002)(558084003)(7736002)(14454004)(4326008)(76176011)(6436002)(25786009)(478600001)(6916009)(54906003)(68736007)(6246003)(2351001)(6506007)(5640700003)(102836004)(386003)(6512007)(9686003)(6116002)(53936002)(186003)(2501003)(2906002)(476003)(11346002)(446003)(46003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2439;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HmQegWdvA1GHos+/VZCWOsmAbURCqt0s7C6NG9bDqLRlNjwU4E9V6bTxmYQr0wfpCv7mApVYuP++ZOerT+vr/KRyEmch3y3Nsp+BhvbFSL2YxnQ/owE19GMHad8J6lFubFY7apCw/hEyOHGlQ7BxAq6TezFk7g85f8CT9wxfx6LgxKJip3hbQ0FIdwFNqaqIZdeGLujoAKwSN2k4fRzJTwqScxGM/Xvz1QzrZHlJRzX+BDfMc5TV4Tt8o5DAm4K9k8iIlKI730dbspg8/w+PMrgPy352AR+jVSNKQawo6a080UB5BsTNJu0D/wUApafbry4lO1I597/kZlmq/zHrgFsWnmgu3QT4b2uh9NSO6/De+L11BLZuWY3mhwHtWlvrfNqxIvAsHCKH7BB09NUbQET3HYMw0SliKUkLppg+3so=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A7006AD72034247855F51ED719C9BCE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc85ce3-30ec-4e64-62e2-08d6bc6f7e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 22:13:56.8398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2439
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ooops... wrong subject. Please, ignore.

Thanks!
