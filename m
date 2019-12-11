Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE3CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8345322527
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="g0qB+wDZ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="WINap1SA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfLKSuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:50:51 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11848 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726242AbfLKSuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:50:51 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBIoRE1022496;
        Wed, 11 Dec 2019 10:50:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=o7B3ev/V4giX7/C3uVtHca1jImmyZeUGj3oCFnV4/v4=;
 b=g0qB+wDZ0dL4pSstvxDeNMYwbI+ItrMARG/fNX6CgWGQP+cThyaqHUHjuHZTrmbyV/lW
 IJ46XmpIivDSRNhxjuwQRX3AIcmL/+LEMn3WWMKc7URisIrpMVXnN8hELWcfe/81RsBL
 T8c1rMNFG2aSK7aDdeD9p0uaOwBSkRKO1gs= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wu2gf15bu-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 10:50:37 -0800
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 11 Dec 2019 10:50:35 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 11 Dec 2019 10:50:34 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 11 Dec 2019 10:50:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+mw2/gfVTNGDv/z5Z+pSVub//2w1BENoDTuDbTgMlTvU4gN/8FhqtyVQQnMER2AjZBsntOLjnAgzVTFLAuTntH7ZsOc3q3OQnOmdhC75mtHlApgmBIF/H/h6UWh0bGG8sLVzamWHpVXgchJDR5THkQf1QzfG32KuNPCQsc22rBKW/+d9Lq63B6HROml/auNUIc9gJsBpY1w4FEJderkK2dguXrf478fcHuvJkvskG4b3kux3N4PO+5RvnFMc2D5d83jiDsmlpyuiqMMIHAgDQqxtjphWReyDPtCwuHslICtgTInTruI3Gvd9PE8Ogzv9YbKsQ0fpn3fzjjYfBuG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7B3ev/V4giX7/C3uVtHca1jImmyZeUGj3oCFnV4/v4=;
 b=XYLvIsjhgsZvhOhB3KoG6H1MqlNu/thr1sjbwG+AUDDj5Xh2HI5Rfxt13Iiv0YADewmv/ttTjyn8KQ7yD3rO/q/88QYQvfEOs4bjbvfW1FfCAKJZRBS4vwyde/kbq6BrQVbqGuRqb/RQRH9dxc3OeA/oli7z5hpF9TCssVev7lEObFm5fH2WnS4bB5xQFrpWsVr4ixJ5ixTSB8zjq6kejhOF50seJkqk46FhANfy9A6P6++kncnSnhzmKch2wyQBGRYY59l4kz8lHUs/IremMseOBiSJxx68p2mwTWyC3+ZDlhX5QLbg5ZAZpSxiSFOmNHe4b4uo++YW7ZEz2koyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7B3ev/V4giX7/C3uVtHca1jImmyZeUGj3oCFnV4/v4=;
 b=WINap1SAqmRkLaWJuWluVlV6M7hB/c2PVtWiRMyNTsA5ed0tEz3zuKYA9y+p8Sq59ETnVL9HqLHiaqgP2cpfpssLfutZzMUHBEHb98CXxmQyjLt1JBu76ijAgOqI9OLyvvMQtwaoSZ7id6eJDLbeej2fH50iVfxSHNN9y0ZvFHM=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1536.namprd15.prod.outlook.com (10.173.233.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Wed, 11 Dec 2019 18:50:32 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9%4]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 18:50:32 +0000
From:   Song Liu <songliubraving@fb.com>
To:     open list <linux-kernel@vger.kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v8] perf: Sharing PMU counters across compatible events
Thread-Topic: [PATCH v8] perf: Sharing PMU counters across compatible events
Thread-Index: AQHVrJTJGmqRAKGiXEWGIEJPQu1yRae1TpEA
Date:   Wed, 11 Dec 2019 18:50:32 +0000
Message-ID: <D2DCB5A2-2F19-42EB-A4BF-36F7999E8F7E@fb.com>
References: <20191207002447.2976319-1-songliubraving@fb.com>
In-Reply-To: <20191207002447.2976319-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:180::767e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8693ed72-9977-492f-298e-08d77e6b004e
x-ms-traffictypediagnostic: MWHPR15MB1536:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB15362F906AC62F00029D7222B35A0@MWHPR15MB1536.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(36756003)(66946007)(66446008)(64756008)(8936002)(66556008)(33656002)(8676002)(81166006)(66476007)(81156014)(76116006)(186003)(6486002)(5660300002)(4326008)(2616005)(6506007)(2906002)(71200400001)(6916009)(54906003)(6512007)(498600001)(86362001)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1536;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oUlSJYYVq6k/MaNytgCKNt91IjWBiaB2uxMT/YgJmJmOUY1I6CntlELlWi4v3zmA5mmPhJnZitQxBJip+xR1qlDDGRaV3UMG7G3Bmk++XXrD1jIHMTW2N4FuvhBUpLPgNdzzsLDcf9FxmwC606Q1tUxm81GB+jTOLWpvOUFZWDzayQsFWt90Vl+bBd7K55Msjseb5ndGikkYzpCC4LUhHVqt7Zo3+0NQZoQfzwV0Ie8+uJzrcjCaoYW05kKmwbiZ2pqTkQ2J1wvtsYaeFYGIbiRVqCoBAJPK6fRgM6hGH0TOH9Y+38n1Iqzo5SUXpUFmITzZgDSc43m4oyNY0zL/7fe4hkxAgcOGTe29XtmK89d+TjcXNpRESFqaR1AqRpOggYGEb6gxOBuijhATEr0Rw/Cj3nWR9AXJLDsmCR+gxNXAoshYKpICE9BqxrEQsdkm
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5E8692F67739047BABE66CF56E1B8DF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8693ed72-9977-492f-298e-08d77e6b004e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 18:50:32.6847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vy3UcqEs40iAwoO1DkZsW4vSru1CZgOxvmHPtpw9UO0amF8LiSnXtyJ+bXawiDvDTPor0NPxdtuLgSrjxXu/uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1536
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_05:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912110155
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Jiri,

> On Dec 6, 2019, at 4:24 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
> This patch tries to enable PMU sharing. When multiple perf_events are
> counting the same metric, they can share the hardware PMU counter. We
> call these events as "compatible events".
>=20
> The PMU sharing are limited to events within the same perf_event_context
> (ctx). When a event is installed or enabled, search the ctx for compatibl=
e
> events. This is implemented in perf_event_setup_dup(). One of these
> compatible events are picked as the master (stored in event->dup_master).
> Similarly, when the event is removed or disabled, perf_event_remove_dup()
> is used to clean up sharing.
>=20
> A new state PERF_EVENT_STATE_ENABLED is introduced for the master event.
> This state is used when the slave event is ACTIVE, but the master event
> is not.
>=20
> On the critical paths (add, del read), sharing PMU counters doesn't
> increase the complexity. Helper functions event_pmu_[add|del|read]() are
> introduced to cover these cases. All these functions have O(1) time
> complexity.
>=20
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>
>=20
> ---
> Changes in v8:
> Fix issues with task event (Jiri).
> Fix issues with event inherit.
> Fix mmap'ed events, i.e. perf test 4 (kernel test bot).
>=20
> Changes in v7:
> Major rewrite to avoid allocating extra master event.

Could you please share your feedbacks on this version?

Thanks,
Song

