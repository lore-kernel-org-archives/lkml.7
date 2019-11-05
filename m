Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644AEC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF09A206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pNA4oRT1";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="B1BUvErY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbfKEXHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:07:20 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40870 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726820AbfKEXHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 18:07:19 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xA5MsI5V016057;
        Tue, 5 Nov 2019 15:06:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=PnpEc23bysBSaux/bNdD5/WLm19CKbUZ+VZSsux6dXc=;
 b=pNA4oRT1Ym7QS7EGmh0yn+lwHCqlGsjXgoz0e/eJpGQxfgwgcnBU2ipHkWMqQUs9ulnC
 ++STUQqtCVyRPTNQJiV62Cy7/zBTF7YGlb9OSmjcIBwpDf8TWKhRzCl/xlHkYwo45xVP
 wj+FOC7F4FAd1e3YgYSdo/0Yjg7vv3hlzeU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2w3ghg8pm1-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Nov 2019 15:06:08 -0800
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 5 Nov 2019 15:06:08 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 5 Nov 2019 15:06:08 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 5 Nov 2019 15:06:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdjvXnNFrCuSNZcI5TpSkDHFMYCHzXOoC9ZxuwlsWjNEH/orqFknVxpMlY211bFkFDiAh7WON42zTkE5HTd+Ckpsv0cfeiW4HFNRu/APugtqCaGKChDfWEUgDWyjZzXEettcBFCpc2F5wixpBeG/UNNfnwmWXRbsvZQ8bgSI9tANzjTasOCcjW1IExr9yH2p//c7iq1B9azZrGVfbHLudpzzvY7GkMALv98t+TiFzHYRt4SKT+zpda0S8LSc0LRbArUcg9Pfg4uRoGOX1HJj+/bGE011gBJuGjUJiSPBQ1F99GYI9cQih9x/bL9Z/7QVjv+ikdwrdree3DzI4NaZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnpEc23bysBSaux/bNdD5/WLm19CKbUZ+VZSsux6dXc=;
 b=LVrs50x6T+jRjoY6KdCSU2gCO8UFmBqWpWr1utxZFVMFy3omU5NVC6gCaOrCjddwfe/1yy2F+w0f5bwQs4+7eyjCgegVtiX4vW3Q9RiT2h1mH2cxHbF/+qHErunalmthNIkqcEYoXnuEwAkp1LgX8mRf+vffcf4UKipEJ8+ZbTy/9KdGuRV78WKtJ6vOgp8us9RyEKtsQzcLIstQrp0FYoze3VUgO83kWTgA0vH4F9fst8cpbbIni8Y2Jm7gKJaOflWlwmfGT3GQzarBDTorff3BS5ySDljPQO3Wlc53e7BJU49q4Am/MYjdUJwSvkWwzJcPxMAL4qc9jngJhe+lag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnpEc23bysBSaux/bNdD5/WLm19CKbUZ+VZSsux6dXc=;
 b=B1BUvErY57knQ9f6KXuiL7D2xGkbXQIVDM08UXvPn1kSpNUaYGo03xSwSZlurAPYHZoyOFWYcEi6rp395kKU3N0N/oUUeFIIteQqPzjXC6OQGA5+WFMZM7zBfVbq6YEuAWCDmKehCA+dLIGYD9qTAekZqAHeIRvwqcSWQcB+ICo=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1872.namprd15.prod.outlook.com (10.174.101.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 23:06:06 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2430.020; Tue, 5 Nov 2019
 23:06:06 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, "Tejun Heo" <tj@kernel.org>
Subject: Re: [PATCH v6] perf: Sharing PMU counters across compatible events
Thread-Topic: [PATCH v6] perf: Sharing PMU counters across compatible events
Thread-Index: AQHVbqpjjWjaDbp/ikSYoLFTNk8qM6d09EYAgAA/EQCAB+dbAIAAM8KAgAAvaoA=
Date:   Tue, 5 Nov 2019 23:06:06 +0000
Message-ID: <23D48724-55B7-45A3-A77A-56BAD57937F9@fb.com>
References: <20190919052314.2925604-1-songliubraving@fb.com>
 <20191031124332.GQ4131@hirez.programming.kicks-ass.net>
 <19AE6C78-C54C-4C37-BBD2-0396BB97A474@fb.com>
 <98A6264C-B833-4930-95A0-2A3186519D87@fb.com>
 <20191105201623.GG3079@worktop.programming.kicks-ass.net>
In-Reply-To: <20191105201623.GG3079@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:200::de21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37c2526d-efba-4533-5b81-08d76244bd05
x-ms-traffictypediagnostic: MWHPR15MB1872:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1872531B307EE7137363F606B37E0@MWHPR15MB1872.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(189003)(71190400001)(8676002)(36756003)(6916009)(2616005)(476003)(5660300002)(6512007)(229853002)(7736002)(8936002)(256004)(14444005)(71200400001)(54906003)(305945005)(6436002)(33656002)(50226002)(53546011)(4326008)(81166006)(6486002)(316002)(2906002)(81156014)(46003)(486006)(66446008)(6246003)(64756008)(186003)(25786009)(478600001)(76116006)(66946007)(99286004)(11346002)(446003)(86362001)(6506007)(76176011)(6116002)(102836004)(14454004)(66476007)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1872;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DobgH19okJW1N3L+RTfFRgUY/yoaqJrPZem9a2UFI0gQhp11KcdXSWAge+TzhxkNatjr0gXCRIKnppEbBCUKqKkD7FG/pnUX7zAuOMvKCGRLWqhDI5fVXUsyyvTrMdDyhT6ugxFs1I8Pp6TGUEBVH+Jel/GpeIuPUS467hbdsS+j1dLGsQzqoZUblhFs3XEPXHMhQ3QxjTPUyUrc0cbMR6KqJt8wYCxoSgAzcfEeyt7VnhfY/zNjPMcVAfop7qiDQaC1bLON5TdJ5xcb9277O0Mmkqicuk3BlU2WMY7LIaLaAUIiPb9dnpuenCM1GouGUHgvsTk4dGtCZMyTm/U2PlenKb2VOTmbNKg5zcdpz6XZ3SS+CiA+sXFHmlO+eubGtgdfsrJE55Mj/MFvSZqb3NQjoZ+uMQMb4Tu3+654MvHWzDOStbZXr0Bfadz9eBFD
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3DC57BA46F88C4B9AC3DF1BC2DBE85A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c2526d-efba-4533-5b81-08d76244bd05
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 23:06:06.3498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBr0fic0SHnCkJzawxkVv6bzkWS42rArDWxMVrN7RGlt4f3m8IKraM8BiROiP0NBLR5qeALT8EZPi3Yyx9r52g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1872
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-05_08:2019-11-05,2019-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1911050187
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 5, 2019, at 12:16 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, Nov 05, 2019 at 05:11:08PM +0000, Song Liu wrote:
>=20
>>> I think we can use one of the event as master. We need to be careful wh=
en
>>> the master event is removed, but it should be doable. Let me try.=20
>>=20
>> Actually, there is a bigger issue when we use one event as the master: w=
hat
>> shall we do if the master event is not running? Say it is an cgroup even=
t,=20
>> and the cgroup is not running on this cpu. An extra master (and all thes=
e
>> array hacks) help us get O(1) complexity in such scenario.=20
>>=20
>> Do you have suggestions on how to solve this problem? Maybe we can keep =
the=20
>> extra master, and try get rid of the double alloc?=20
>=20
> Right, you have to consider scope when sharing. The master should be the
> largest scope event and any slaves should be complete subsets.
>=20
> Without much thought this seems a fairly straight forward constraint;
> that is, given cgroups I'm not immediately seeing how we can violate
> that.
>=20
> Basically, pick the cgroup event nearest to the root as the master.
> We have to have logic to re-elect the master anyway for deletion, so
> changing it on add shouldn't be different.
>=20
> (obviously the root-cgroup is cpu-wide and always on, and if you have
> two events from disjoint subtrees they have no overlap, so it doesn't
> make sense to share anyway)

Hmm... I didn't think about cgroup structure with this much detail. And=20
this is very interesting idea.=20

OTOH, non-cgroup event could also be inactive. For example, when we have=20
to rotate events, we may schedule slave before master. And if the master
is in an event group, it will be more complicated...

Currently, we already have two separate scopes in sharing: one for cpu_ctx,=
=20
the other for task_ctx. I would like to enable as much sharing as possible
with in each ctx.=20

Let me double check whether we can make the code with extra master clearer,=
=20
namely, get rid of double alloc and the ugly array.=20

Thanks,
Song

