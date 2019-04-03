Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD18C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF082084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="A6ZufNz7";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="TZvx6ZUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfDCVMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:12:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57760 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbfDCVMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:12:41 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33Kvt5J031101;
        Wed, 3 Apr 2019 14:10:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=lBpXIYSt+i5xjKGGv8Fkuc+A2zIwjHPU9qm9priR/+E=;
 b=A6ZufNz7Gt8nF5T/wUjUfpn4bbWRUm57OA9z0w8FegAfj09lSiysQOWAXcHXtSuSKrWZ
 Gol2a9FYhcpNkCsDawd+gkMOYMFWwsnPRR4TrE6uKscT1912eypeBpdyWdx1d1waa5hg
 XPSXoRt+3LAun6kUk+iuk9dA0xF0uV7Wt8s= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rn1e98t1k-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Apr 2019 14:10:16 -0700
Received: from frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 14:10:14 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 14:10:14 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 3 Apr 2019 14:10:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBpXIYSt+i5xjKGGv8Fkuc+A2zIwjHPU9qm9priR/+E=;
 b=TZvx6ZUtyRImHxd8D/SKjmDp3RhCg0LuBP04S13E97V+pr1GbmJhGE6t5ysqxAyfztF59aO4jY9Y4x07KdP1IS+KU0aRPCM0k2RV6geIgdGPVBDWmfHVX+vktzWhlHLnnrA9KGSGhcF6/bM/rjFvcVDe60Ho2vDJHRBckLY9CGU=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3032.namprd15.prod.outlook.com (20.178.238.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Wed, 3 Apr 2019 21:10:11 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%3]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 21:10:11 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RESEND PATCH 3/3] mm/vmap: add DEBUG_AUGMENT_LOWEST_MATCH_CHECK
 macro
Thread-Topic: [RESEND PATCH 3/3] mm/vmap: add DEBUG_AUGMENT_LOWEST_MATCH_CHECK
 macro
Thread-Index: AQHU6XDC3sbimF76+0azspH94wRFo6Yq8FcA
Date:   Wed, 3 Apr 2019 21:10:11 +0000
Message-ID: <20190403211006.GI6778@tower.DHCP.thefacebook.com>
References: <20190402162531.10888-1-urezki@gmail.com>
 <20190402162531.10888-4-urezki@gmail.com>
In-Reply-To: <20190402162531.10888-4-urezki@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:301:3a::32) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:9220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4f3d00b-cda3-447f-d832-08d6b878c229
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3032;
x-ms-traffictypediagnostic: BYAPR15MB3032:
x-microsoft-antispam-prvs: <BYAPR15MB303247EDE7CF3B17941C3020BE570@BYAPR15MB3032.namprd15.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(346002)(376002)(136003)(199004)(189003)(71200400001)(2906002)(97736004)(1411001)(6506007)(386003)(102836004)(76176011)(68736007)(14444005)(33656002)(6916009)(229853002)(6436002)(6486002)(6116002)(1076003)(256004)(478600001)(71190400001)(4744005)(9686003)(25786009)(105586002)(11346002)(52116002)(106356001)(446003)(476003)(53936002)(486006)(86362001)(14454004)(6512007)(316002)(46003)(186003)(6246003)(5660300002)(8676002)(4326008)(99286004)(81166006)(54906003)(81156014)(7736002)(8936002)(305945005)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3032;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GlhxPEXdpAp7xhVWaT0eljk+aSgsNwa8vsr/uuLFVFCXVNHqLQoQpxHJ8wkm/wrFRjap4g+rgPH9sqMqsyd4LXYE0HGLkqWhpG86ZY3UwT4mkWLAnQ93HTe3Dgli3Cvh4lelBk/yA3CmGCSTNfBEVA967BSx5U50Uf9jOSdarj2CcEjrDCxlL3Bwi8iQO8MiVhqpkk9KsWI/Fh2tq9ndUzV1HaG88P5BiAF/h5TgyLu2A9g7LgZ+7Te703GOOG3wR/CQoRUUDr5huTaWfW/F9Q6pwdzTfM7zvun2qhmikv9yJLzgsfxsc3U1NQbYUIdjeICdM9obxCxqODbiBiDO9AWQBhjnrHqYRFI5k9QikAQHTKN9bcLkiBsybMrMJZlP6YyCgGXTe78c2g5nOClA4ZP7CZ51me+DWk8eFEBPX9c=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F4CB3BD58012A4B96E411103F51C97F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f3d00b-cda3-447f-d832-08d6b878c229
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 21:10:11.5664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3032
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 06:25:31PM +0200, Uladzislau Rezki (Sony) wrote:
> This macro adds some debug code to check that vmap allocations
> are happened in ascending order.
>=20
> By default this option is set to 0 and not active. It requires
> recompilation of the kernel to activate it. Set to 1, compile
> the kernel.
>=20
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
