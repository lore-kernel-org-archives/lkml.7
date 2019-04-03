Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A6EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FBD20657
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="D4A9+Cb2";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Quey626e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDCR6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:58:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57072 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbfDCR6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:58:20 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33Hqpow001589;
        Wed, 3 Apr 2019 10:57:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=szVyQXzqNWFLz55J/ZpIrcml3NcRugE0hUK+gSoqhVQ=;
 b=D4A9+Cb2q+yHlJw+MNGM50mCNehKtmxAFZ2rDBqYP6i/widC0ggiZ0+ENI1HSFxpAPm9
 fa9LfN0/8sEe4z48uRRgSfEKLmjLs99UWnM6T/ldsNv5hpsuBRyAw9xLSibszMxotRm4
 IVAnhrh8LP1b5oCELhQ9N0UjDf51zw3oLcc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rn1hvg1dv-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Apr 2019 10:57:57 -0700
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 10:57:53 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 10:57:45 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 3 Apr 2019 10:57:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szVyQXzqNWFLz55J/ZpIrcml3NcRugE0hUK+gSoqhVQ=;
 b=Quey626ebiTBxmyhI0+PVUiCsNnGs/iLpDJVZr+fr3cqDhMianAKQiPpX19z5Xe0ULVy74LZwcdCMEdKEOs5ktNwx7EdcohGJFQybiiUmVTQNvxYX49xkDCf9eFMh1lcxMszypEv50Dnywo/8yMLP+GwvLkEJW/OWJjIj6Hxh4E=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2231.namprd15.prod.outlook.com (52.135.196.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Wed, 3 Apr 2019 17:57:43 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%3]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 17:57:43 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Tobin C. Harding" <tobin@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/7] list: Add function list_rotate_to_front()
Thread-Topic: [PATCH v5 1/7] list: Add function list_rotate_to_front()
Thread-Index: AQHU6ai/hRRVJsHCh0Ws9dfflaiJBKYquiKA
Date:   Wed, 3 Apr 2019 17:57:42 +0000
Message-ID: <20190403175739.GB6778@tower.DHCP.thefacebook.com>
References: <20190402230545.2929-1-tobin@kernel.org>
 <20190402230545.2929-2-tobin@kernel.org>
In-Reply-To: <20190402230545.2929-2-tobin@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0085.namprd15.prod.outlook.com
 (2603:10b6:101:20::29) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:9220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a106cac7-85a9-43f6-e12a-08d6b85dde9d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB2231;
x-ms-traffictypediagnostic: BYAPR15MB2231:
x-microsoft-antispam-prvs: <BYAPR15MB2231D9DC7E65A43F17277132BE570@BYAPR15MB2231.namprd15.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(6246003)(86362001)(25786009)(46003)(486006)(81166006)(186003)(81156014)(2906002)(305945005)(6512007)(7736002)(6436002)(1076003)(102836004)(6506007)(76176011)(9686003)(105586002)(6116002)(386003)(6916009)(8936002)(106356001)(14444005)(8676002)(4326008)(53936002)(99286004)(6486002)(14454004)(478600001)(52116002)(5660300002)(71190400001)(71200400001)(256004)(33656002)(68736007)(446003)(476003)(229853002)(11346002)(316002)(97736004)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2231;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sHSjdRnrnJck4csKcNDUt05UUmEkRZ6JRXUpgdY2ivdycWiocae+N18jlYYUVTPJNIdPt9z0w7fBdt8e2ZFLrE6zGgPi7EOATv0wRDhO2T0M8kAMDnMs2/pYU9hCh9//+cB3N+fd/pAhiX0s501CcJyHirdawEG7vRs+qfkviGzjIa/SB9gm9IwQZOcRm3CxhevQGRRwrz+EeP3kl8zxlWCetSMUg3/9QZnO9mWiLlueRccKIbTjspYHWaxLPaRpTivCDDMeiDu6Hx+L8/WorhIIvfNZ4ZvoMmDCpeEJGeNdg2RtSr2BFDGmbiyydC/tDS6eUCwaeNAFVijXvlPKe+PNYrigEo883wbv1/po9Jxe7OwoowJaElcTNAKZx4HqvsMiAu90rol/KqYXWDTOq+JZids4bGNbB4q4XcvKnqA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <088A820733D4244DA401E5CE186B29A6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a106cac7-85a9-43f6-e12a-08d6b85dde9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 17:57:42.9005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2231
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:05:39AM +1100, Tobin C. Harding wrote:
> Currently if we wish to rotate a list until a specific item is at the
> front of the list we can call list_move_tail(head, list).  Note that the
> arguments are the reverse way to the usual use of list_move_tail(list,
> head).  This is a hack, it depends on the developer knowing how the
> list_head operates internally which violates the layer of abstraction
> offered by the list_head.  Also, it is not intuitive so the next
> developer to come along must study list.h in order to fully understand
> what is meant by the call, while this is 'good for' the developer it
> makes reading the code harder.  We should have an function appropriately
> named that does this if there are users for it intree.
>=20
> By grep'ing the tree for list_move_tail() and list_tail() and attempting
> to guess the argument order from the names it seems there is only one
> place currently in the tree that does this - the slob allocatator.
>=20
> Add function list_rotate_to_front() to rotate a list until the specified
> item is at the front of the list.
>=20
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Reviewed-by: Roman Gushchin <guro@fb.com>
