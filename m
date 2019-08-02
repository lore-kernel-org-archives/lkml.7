Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A0CC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D80120644
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nUNh5AV9";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZzWNw10n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388146AbfHBRA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:00:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8358 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725385AbfHBRA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:00:58 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x72GxRua027808;
        Fri, 2 Aug 2019 10:00:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=/baQDE+XaPTFQ7a4R5OWepdjL3g77WfHeqktmstfnEg=;
 b=nUNh5AV9JjsIbhzCysgnKmpLeSYzUp92URPzNQ7/C4xZX3+KmjBfvq0t2T/KfJrVBToa
 qh/Gdg04JkOq7UIzJhHvIHnWVFHDKzZMvSLckgLPZuYIEk+5+8hgqxIDPIF+2WacvfKB
 uLx8/tAx8j+EKPH4CNuCBZZSB5G05oz53To= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2u43h7v9nk-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 10:00:53 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 2 Aug 2019 10:00:38 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 2 Aug 2019 10:00:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTEBkVnd0pciJ4XbgqvDvSQ6+pwieTpLo16azjvwelPu7uBKO3woew90Yx1cGgXBeNRCIx/d2ymmIN2tpMpIVfZKx1/mG3yCNQaC3LiX+N/wbsTvwygO/MULCD0LBKxoLs0lOy3LxHkEsAzDI0q+si56wBNu1gLeKDQtbOFeEM2FFaSURXBLzLGNF2OxCIp+ASawD2R6yMFY76YOIFc6mRf+FwEHldV4w+bBmanhuKY2MZivps7PSCk2QmvmdF7AFZNOCFhJ6RB7o2rqWSmHSjYWdS9OiV6wXnSLDg2vkSXYs2B823+NWflUWV5r3I4cnQ7vphx4ol+qHTAhZzPxHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/baQDE+XaPTFQ7a4R5OWepdjL3g77WfHeqktmstfnEg=;
 b=Tn5JuxSwhR1BaZMU5AosQToSmvSJGKEGQQORRvl1MgFbWZhTokxo7DtnymJPeT+EQsbDSZBMYmW9wKsEj2tjzHqM6vE+xEoTqv5aXgya99nIhAVDHjBoeL3iYhzKcKD+77C5KJAX7mxDTsqkEhqSRqeem5KhHWBq6VzJxujz6C1+LFhUOyAAx1EjvfWbaZU1rfFEmmNQEjJxi7YVXbG5zjTsblxme+iBMRW6oIO2WpenbOVwXFaH/HFW0XPCj+C9x08t9v5uiAxCFE5gkVuAVLE2rXQ80rP+/7EYeOpWHz+8v+aJWRTvjJicXRLWFJCkwi+54YcYGFpddAQNtbRhPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/baQDE+XaPTFQ7a4R5OWepdjL3g77WfHeqktmstfnEg=;
 b=ZzWNw10npkBYmidxb6l9aJNY6m26q/rDRqk3X3VN96kL0Ps6ssNdYsYR71R+ugxWPB2umUKpNyYuSlWNJcc6fJo+YZKlHgE0MfyomHuN8Gke3NubqxQ3sbxwQ/LA1lZcSqBPsujpCJIFkH9hSMbzBJlb5gcs722CiCD7NbDfJd0=
Received: from DM6PR15MB2635.namprd15.prod.outlook.com (20.179.161.152) by
 DM6PR15MB3689.namprd15.prod.outlook.com (10.141.166.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.15; Fri, 2 Aug 2019 17:00:35 +0000
Received: from DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::fc39:8b78:f4df:a053]) by DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::fc39:8b78:f4df:a053%3]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 17:00:35 +0000
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
Thread-Index: AQHVSMHRid8xy6v2VESi4846kGYnRKbngEUAgAAPfICAAIZPAA==
Date:   Fri, 2 Aug 2019 17:00:34 +0000
Message-ID: <20190802170030.GB28431@tower.DHCP.thefacebook.com>
References: <20190801233513.137917-1-guro@fb.com>
 <20190802080422.GA6461@dhcp22.suse.cz> <20190802085947.GC6461@dhcp22.suse.cz>
In-Reply-To: <20190802085947.GC6461@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:301:60::33) To DM6PR15MB2635.namprd15.prod.outlook.com
 (2603:10b6:5:1a6::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::a1bd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5aca90cb-af4a-48e0-7ce0-08d7176aef5e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR15MB3689;
x-ms-traffictypediagnostic: DM6PR15MB3689:
x-microsoft-antispam-prvs: <DM6PR15MB3689D582E1CA7C30DA85076DBED90@DM6PR15MB3689.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(376002)(346002)(366004)(199004)(51444003)(189003)(446003)(66476007)(8936002)(386003)(66446008)(305945005)(68736007)(6486002)(1076003)(71190400001)(5660300002)(229853002)(486006)(11346002)(7736002)(66946007)(478600001)(99286004)(6916009)(64756008)(6246003)(316002)(256004)(476003)(6512007)(33656002)(25786009)(14454004)(4326008)(46003)(86362001)(186003)(6506007)(2906002)(54906003)(8676002)(81156014)(81166006)(52116002)(6116002)(76176011)(6436002)(53936002)(102836004)(66556008)(71200400001)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3689;H:DM6PR15MB2635.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: flIBM8Lr6BMEmotSJUXe7HFd449Qo/4CoXijFtydKIID4uMJQ0UcIgHIDvMazjgnwu4FpTyNRgajTd1+8Mqur/VroX7sHBypWn9+/J19YiU+Njyv+WjLROXYP/DQALItD3+MWBgsYnGC311BycM6TIHg9XYis5FbThaEX3zet6z09TjFpI9RYUQUv/YNcruuqGTeNQ+0J6/vE+INAB2ax1DK6170wXLGMTwa5059WcPkDY6WCYB1HQ3kUjhltlGN7Pc13SUHaDb7AufjDFCTIHioLZ5Rl21DKAb/GHJayX/JCMteyfGjTLrIOcGEivufzLZJokp39TEt0d/6rIoKr5E8Ysnfvu11sKB9peOafiHoH7onZxRea7V4Me2W8oQDl8hz8J/IPQxFdMX9Jj9WEunxDtMgcUtNAbs19PzTYzs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E3B45B3499AF14E90DB72AA1E22C56E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aca90cb-af4a-48e0-7ce0-08d7176aef5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 17:00:34.8162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3689
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=861 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020176
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 10:59:47AM +0200, Michal Hocko wrote:
> On Fri 02-08-19 10:04:22, Michal Hocko wrote:
> > On Thu 01-08-19 16:35:13, Roman Gushchin wrote:
> > > Commit 72f0184c8a00 ("mm, memcg: remove hotplug locking from try_char=
ge")
> > > introduced css_tryget()/css_put() calls in drain_all_stock(),
> > > which are supposed to protect the target memory cgroup from being
> > > released during the mem_cgroup_is_descendant() call.
> > >=20
> > > However, it's not completely safe. In theory, memcg can go away
> > > between reading stock->cached pointer and calling css_tryget().
> >=20
> > I have to remember how is this whole thing supposed to work, it's been
> > some time since I've looked into that.
>=20
> OK, I guess I remember now and I do not see how the race is possible.
> Stock cache is keeping its memcg alive because it elevates the reference
> counting for each cached charge. And that should keep the whole chain up
> to the root (of draining) alive, no? Or do I miss something, could you
> generate a sequence of events that would lead to use-after-free?

Right, but it's true when you reading a local percpu stock.
But here we read a remote stock->cached pointer, which can be cleared
by a remote concurrent drain_local_stock() execution.

In theory, it could be the last reference, and the memcg can be destroyed
remotely, so we end up trying to call css_tryget() over freed memory.

The race is theoretical, but as I wrote in the thread, I think
that it's still worth fixing, because the current code looks confusing
(and this confirms my feelings).

Thanks!
