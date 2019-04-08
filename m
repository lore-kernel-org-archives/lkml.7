Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D66C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769F92084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="l65kp3nc";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QoVJnztj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfDHVrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:47:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52578 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726717AbfDHVrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:47:03 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38LWkgR004864;
        Mon, 8 Apr 2019 14:46:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+fyi7ubaydaPKmQc6qb1GVdWe24A37XGIgduhgdkkkE=;
 b=l65kp3ncsxSO3qh9Y3CC7+0OJg7PGD7ffOXi+kaj3luP2kGTaUEnq/UTfCZa5mUxlFF+
 tZNO+lrR4svGMj9y5HZbdewB00ibqp8cRY10GlmpzGg58zsZn9BuVC1vq295BGkKCM37
 n2l7KFSvKx3dLOocKmryxeTAVRKa7uwGmgI= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2rra0ph84x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Apr 2019 14:46:56 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 8 Apr 2019 14:46:36 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 8 Apr 2019 14:46:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fyi7ubaydaPKmQc6qb1GVdWe24A37XGIgduhgdkkkE=;
 b=QoVJnztjfukq/j+oS1x+C0WOHWO7QZAHzMjh7EHomIA7B9hKa41AbYxQ2pxWPGVuZas2MZN8yOmUrEV3zYraXUB1pBmrl1wrXyLDF5upYTAiG888IYC/WeTiA7EATekGq28JfdvoXVM/92tVwkkZrlF9rMgV5MZndYCATCehjQ8=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2598.namprd15.prod.outlook.com (20.179.155.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Mon, 8 Apr 2019 21:46:34 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%3]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 21:46:34 +0000
From:   Roman Gushchin <guro@fb.com>
To:     shuah <shuah@kernel.org>
CC:     Roman Gushchin <guroan@gmail.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH kselftest-next] selftests: cgroup: fix cleanup path in
 test_memcg_subtree_control()
Thread-Topic: [PATCH kselftest-next] selftests: cgroup: fix cleanup path in
 test_memcg_subtree_control()
Thread-Index: AQHU5RH8Mm7Zp+AxqUmB3GSIVhQzuaYyrp2AgAAwSwA=
Date:   Mon, 8 Apr 2019 21:46:33 +0000
Message-ID: <20190408214628.GA14748@castle>
References: <20190328025659.25684-1-guro@fb.com>
 <32b7ae48-99dd-1261-4086-37d416ffcfd5@kernel.org>
In-Reply-To: <32b7ae48-99dd-1261-4086-37d416ffcfd5@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0057.namprd02.prod.outlook.com
 (2603:10b6:a03:54::34) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:27ff]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 649355b7-6e40-4481-bcc5-08d6bc6bab02
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB2598;
x-ms-traffictypediagnostic: BYAPR15MB2598:
x-microsoft-antispam-prvs: <BYAPR15MB2598D6725F60C27981616770BE2C0@BYAPR15MB2598.namprd15.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(39860400002)(376002)(366004)(396003)(346002)(199004)(189003)(2906002)(446003)(99286004)(76176011)(316002)(54906003)(52116002)(486006)(11346002)(86362001)(6116002)(476003)(1076003)(97736004)(71190400001)(68736007)(229853002)(6916009)(71200400001)(6486002)(4326008)(33656002)(5660300002)(14454004)(6246003)(106356001)(305945005)(478600001)(25786009)(105586002)(6436002)(14444005)(9686003)(186003)(6512007)(6506007)(102836004)(53546011)(386003)(4744005)(46003)(53936002)(81166006)(81156014)(8936002)(7736002)(8676002)(256004)(33716001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2598;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zFDZ8UOLcQOigL21A7lWex4V5M93PZXcbq2O6ajQauJEiiwW6AfOEzPFzSWtNxQfDl4o/2eal1WnA3nC2dlpwta+T9WYJtzNvHcM94xLg/RNSvtEPHoGwo9Y4uIQ6xj0aKhDMnCJjUxd7eMzTxy1b4xheVmBpVlPL4HQr6luvKOAwgCNKY3MdeO4juLld1ewrInjwEfsncxHlo4+0eA062gaNIxgyscAF9MyvP42lY707OHm0t2dDg8XEZvw1Sc3SgUmsTTAGc44GymwH7Kn558ggJj7W0xpbI/UA0+MkR0s5fsQ/aWJ1afivxfbnKhg+6Lthzafviqg6N6n6Kp7uxJ5qn5LKxOPdDnbX7T7vpnQRfTSgdmquUqxOW0OtXlbYgLfZsYomltr6RZ7w1/tq3OZpQKv2o6mDq1Ag21nyh8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F957FB9A8FD034AA545765FF2DCF63D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 649355b7-6e40-4481-bcc5-08d6bc6bab02
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 21:46:33.9012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2598
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 12:53:39PM -0600, shuah wrote:
> On 3/27/19 8:56 PM, Roman Gushchin wrote:
> > Dan reported, that cleanup path in test_memcg_subtree_control()
> > triggers a static checker warning:
> >    ./tools/testing/selftests/cgroup/test_memcontrol.c:76 \
> >    test_memcg_subtree_control()
> >    error: uninitialized symbol 'child2'.
> >=20
> > Fix this by initializing child2 and parent2 variables and
> > split the cleanup path into few stages.
> >=20
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Fixes: 84092dbcf901 ("selftests: cgroup: add memory controller self-tes=
ts")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> > Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
>=20
>=20
> From and Signed-off don't match. Please fix it and resend the patch.

Done.

Thank you!

Roman
