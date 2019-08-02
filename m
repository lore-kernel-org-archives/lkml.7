Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABFDC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F33E217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kmC6vmJ5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fVqJADMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405525AbfHBRgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:36:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41270 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405108AbfHBRgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:36:53 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72HafEd030920;
        Fri, 2 Aug 2019 10:36:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Kbqu2pkdbuE6Hfv0C18aO+pa2j5XdDTFvxFMkm7G37I=;
 b=kmC6vmJ5AUCWFUpb/FWyFQa+QOp+F0dxe7La3YqaxwpqNiMvwCl+H4ftFLOYrEk2eRAl
 AzOnAUlthSm9T0ajATb6Z5ETg40CjYoxN3jjTlp4oLDtWBzRFb7IxkHIVHgi3PHJIJmk
 hsxRxrUIYd5JKEzvWP+9YcwzgVOM9PJdUbs= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2u4s4q050m-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 10:36:47 -0700
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 2 Aug 2019 10:36:44 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 2 Aug 2019 10:36:44 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 2 Aug 2019 10:36:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw7RmsxR3kWmLAYq6bZ3KnqqwXfBa0aioGbc+y20TXlmNnJ/GoelLf03z269HVvDj78Zes7shYKJKZALxhkL6POF0bzBmNzNeI9uO8ozXsnAf6d8JwJ1tPb1QwuQml5ZfPoVXRoETHbuGlPDYFoXr/0RYi6/Z7JFnuMtLAYScqNHB81D5nNJfcL6TkvbL6p1/+3rwOom4L9TzcFJpR+qfHGm/EcS5Fw1x53VfgAS+RlJzqSxRZus6GhpVp7LSY31oALmJwz3ZGB5Quwtr33xhZx/pWZzAd0KtEspCL83RgveLDywuLNxa60IC9AZg4PcDxYodK+xLKzE+h6ZL4ceJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbqu2pkdbuE6Hfv0C18aO+pa2j5XdDTFvxFMkm7G37I=;
 b=lq75wxlCOkaXneKyOVPsUyuu7MWIUkDtIHwke2fCRP75e/5GZ7/bQ8fG71EFi4qjGav8d0P2ZuNRzbO1LE056QyV6LsOLNSkrXLD5X/0QqS44wUy7vL3Mp/DT+VvKZ1ytcWYwTnhMlBHdGxDx4qLwEOTdiWjVCjla6zmPAFTtsU3JiDfHq7uh/o+1YtJjPrz/y10gXUILtnaLlcSrpMADaLBtvWXcTPWFvjq6oVtu5bCOM0EZ3u22OQoWe7kKeUg73vAWjC8RFh8EjRPyrkiTHl1chIZ1Nt1zwxTXLe4Kh1RFQQz8vD1vhljSHNfcz3oplOn9FSMozWEbDtY6aevkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbqu2pkdbuE6Hfv0C18aO+pa2j5XdDTFvxFMkm7G37I=;
 b=fVqJADMCFCfakRO46fLBroI0kXlP/m5H9yiBvG5gQmp4U0FVddU80nHwWfy1D9zE3Fu+ZnIFrY4fiIE9P9hMUAhUF4cnW2OfBb59ahCZ6E9tKGZeweekhImPZLOtqy1jewhY/tq8K1cXkpVLZbMUjTH3gSE6eXVMKtkZCSt5CgI=
Received: from DM6PR15MB2635.namprd15.prod.outlook.com (20.179.161.152) by
 DM6PR15MB2745.namprd15.prod.outlook.com (20.179.163.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Fri, 2 Aug 2019 17:36:42 +0000
Received: from DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::fc39:8b78:f4df:a053]) by DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::fc39:8b78:f4df:a053%3]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 17:36:42 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: switch to rcu protection in
 drain_all_stock()
Thread-Topic: [PATCH] mm: memcontrol: switch to rcu protection in
 drain_all_stock()
Thread-Index: AQHVSMHRid8xy6v2VESi4846kGYnRKbngEUAgAAPfICAABD8gIAAeVaAgAAGFgA=
Date:   Fri, 2 Aug 2019 17:36:42 +0000
Message-ID: <20190802173638.GC28431@tower.DHCP.thefacebook.com>
References: <20190801233513.137917-1-guro@fb.com>
 <20190802080422.GA6461@dhcp22.suse.cz> <20190802085947.GC6461@dhcp22.suse.cz>
 <20190802170030.GB28431@tower.DHCP.thefacebook.com>
 <20190802171451.GN6461@dhcp22.suse.cz>
In-Reply-To: <20190802171451.GN6461@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR17CA0063.namprd17.prod.outlook.com
 (2603:10b6:300:93::25) To DM6PR15MB2635.namprd15.prod.outlook.com
 (2603:10b6:5:1a6::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::a1bd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 970329ea-ab62-4131-dfec-08d7176ffb51
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR15MB2745;
x-ms-traffictypediagnostic: DM6PR15MB2745:
x-microsoft-antispam-prvs: <DM6PR15MB27459C7374B204C5DB7C6095BED90@DM6PR15MB2745.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(366004)(346002)(396003)(189003)(199004)(54534003)(102836004)(6916009)(8676002)(81166006)(81156014)(8936002)(478600001)(53936002)(6246003)(66556008)(64756008)(66446008)(229853002)(2906002)(66946007)(25786009)(6486002)(5660300002)(6512007)(4326008)(6116002)(9686003)(66476007)(1076003)(6436002)(33656002)(71200400001)(71190400001)(14454004)(68736007)(446003)(11346002)(186003)(476003)(7736002)(86362001)(486006)(305945005)(46003)(54906003)(256004)(99286004)(6506007)(386003)(316002)(76176011)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2745;H:DM6PR15MB2635.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EhLmm4BHKqWYT9OJPp3+PmsufvIrRPbMQM4/MHJ3uXMf8wI6bVu1/6KCS7tZFh5vT2sNeYSyaCBMvO/Q5Y21xeYZgVIJt4Je9yc4OQNCEdYit2koIttTPKOpENlvOjjkXbwh1GzMs12hUcg58QO8pPV6waGLL+FjormPM3hyLLsV8frOC6uKCMFHDNombl45LfWLO6fnrchUnb61lvSPdZK4d0fbT9pbE/vZLsA/vvRtgew6iY8YYIeEIcG8GzjlxtLybiN4dA6SLzFQaBjDFhMiHC9u16JETBdPlq+PEGKPzQ1VB5zRBRMb0pjl+vKj4lnNSbBvlDxdmc1QzTqWmKtlS9QgzkLO66Ouv4xvWqdpyLC1TPsUNCyly1a3N8mkbA2ktCms2TKSpQtnByYM5yQbCzGlfzS0zGakWHkNIuA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF6B796117402648BDC1DDFF2537D4AA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 970329ea-ab62-4131-dfec-08d7176ffb51
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 17:36:42.4318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2745
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=772 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020184
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 07:14:51PM +0200, Michal Hocko wrote:
> On Fri 02-08-19 17:00:34, Roman Gushchin wrote:
> > On Fri, Aug 02, 2019 at 10:59:47AM +0200, Michal Hocko wrote:
> > > On Fri 02-08-19 10:04:22, Michal Hocko wrote:
> > > > On Thu 01-08-19 16:35:13, Roman Gushchin wrote:
> > > > > Commit 72f0184c8a00 ("mm, memcg: remove hotplug locking from try_=
charge")
> > > > > introduced css_tryget()/css_put() calls in drain_all_stock(),
> > > > > which are supposed to protect the target memory cgroup from being
> > > > > released during the mem_cgroup_is_descendant() call.
> > > > >=20
> > > > > However, it's not completely safe. In theory, memcg can go away
> > > > > between reading stock->cached pointer and calling css_tryget().
> > > >=20
> > > > I have to remember how is this whole thing supposed to work, it's b=
een
> > > > some time since I've looked into that.
> > >=20
> > > OK, I guess I remember now and I do not see how the race is possible.
> > > Stock cache is keeping its memcg alive because it elevates the refere=
nce
> > > counting for each cached charge. And that should keep the whole chain=
 up
> > > to the root (of draining) alive, no? Or do I miss something, could yo=
u
> > > generate a sequence of events that would lead to use-after-free?
> >=20
> > Right, but it's true when you reading a local percpu stock.
> > But here we read a remote stock->cached pointer, which can be cleared
> > by a remote concurrent drain_local_stock() execution.
>=20
> OK, I can see how refill_stock can race with drain_all_stock. I am not
> sure I see drain_local_stock race because that should be triggered only
> from drain_all_stock and only one cpu is allowed to do that. Maybe we
> might have scheduled a work from the previous run?

Exactly. Previously executed drain_all_stock() -> schedule_work ->
drain_local_stock() on a remote cpu races with checking memcg pointer
from drain_all_stock.

>=20
> In any case, please document the race in the changelog please. This code
> is indeed tricky and a comment would help as well.

Sure, will send out v2 soon.

Thanks!
