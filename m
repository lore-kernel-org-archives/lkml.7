Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAA1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD2720835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Oykq1I3l";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Ujk8RoTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfCDToV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:44:21 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45904 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726076AbfCDToV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:44:21 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x24JXZMm001924;
        Mon, 4 Mar 2019 11:43:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=SN174mvKRVuXMpzN8dQfgm762CZKH7O/bq286HbMJ34=;
 b=Oykq1I3lDeNjfxGj6XOaihjo3h9cglF+rYjvGj6VDFxTlXeslPP576zJfkpj2JGRXVGE
 AHqnhTcUKppp7dERKwlva1DzJYsv+APQ47zYnUGwBjdwG/zkohkozKVE5olMB/Y0CrPA
 3fmi4RC53sLA9GoB1H6SqZINMafIJy+HujA= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2r19w0r4hd-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Mar 2019 11:43:54 -0800
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Mar 2019 11:43:53 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Mar 2019 11:43:53 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Mar 2019 11:43:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SN174mvKRVuXMpzN8dQfgm762CZKH7O/bq286HbMJ34=;
 b=Ujk8RoTFg3oHeFJKLdT1omPtp6EgPCdFnW43MH9TpoaPrS/MvqfPsRt6Z1oBy8CS96X/Lg7humehJ9ZBaaMAE5XnY156vv7WhI70JLelnmGatKwGemJ6Vxt23MyS7Zd7rkNVeHykJ4Jf3Wl4AbonhX/yZSR+wpfPVDy7cIkjEqU=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1390.namprd15.prod.outlook.com (10.173.234.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 19:43:50 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 19:43:50 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v5 perf,bpf 08/15] perf, bpf: save btf in a rbtree in
 perf_env
Thread-Topic: [PATCH v5 perf,bpf 08/15] perf, bpf: save btf in a rbtree in
 perf_env
Thread-Index: AQHUzyObmBfnDZryjE6Y25DRRwK/I6X7hL6AgABiJ4A=
Date:   Mon, 4 Mar 2019 19:43:50 +0000
Message-ID: <8D38E918-5FF5-4404-8201-58A8FEFA086A@fb.com>
References: <20190228050643.958685-1-songliubraving@fb.com>
 <20190228050643.958685-9-songliubraving@fb.com>
 <20190304135231.GE19809@krava>
In-Reply-To: <20190304135231.GE19809@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::3:1d00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb5b5961-d4a8-4aef-e70d-08d6a0d9b9b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1390;
x-ms-traffictypediagnostic: MWHPR15MB1390:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1390;20:kBZG4uKbP1MmGH+Bgck57eH0algCYCGnEPFd06299wGrZ0mOdE9jbihFFGcgtsrYVgjQDLbdlbNMYRndKXOdYEgXIk9Gu3nQQdtmFlhmfZyXUPnl+xij3H7tbrKOimmkfTt68SQR+M9O4+4/ScEuJJ5TguMLjW0b7GzqidfYtlY=
x-microsoft-antispam-prvs: <MWHPR15MB139091E8B09224D492BA5CEFB3710@MWHPR15MB1390.namprd15.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(396003)(136003)(199004)(189003)(57306001)(82746002)(36756003)(6246003)(71200400001)(71190400001)(256004)(83716004)(6436002)(6512007)(186003)(2906002)(478600001)(14454004)(229853002)(5660300002)(4326008)(46003)(2616005)(316002)(33656002)(53546011)(8936002)(446003)(11346002)(97736004)(305945005)(476003)(486006)(86362001)(6116002)(81156014)(106356001)(102836004)(54906003)(76176011)(6486002)(7736002)(53936002)(8676002)(50226002)(25786009)(99286004)(81166006)(105586002)(68736007)(6916009)(6506007)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1390;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Gb23zXc5rCo0tk4gRzl3ASKxTSxhtwTI/7zkQQoYRfqRFPqpuE+o4u0HtVTA+u/Re2TZWLKhA9Y+5ng8keVvGfFbPLUfKY6445PmZ8sG63z/by9TXiL6T4HlM6gxR4Kz2jwmgbdclXwpgLvUHsELhxVqE4DY6QrlsY1JmjvZcPmh4M8/U59u9WZO2r5AOx/BP0H0NeTFj/e/BFBPMN8uJf00JJlJmm3S7nugIr6X/orMgux91S1mNepaOD30yE5gczTLt983sZ7Mgi/aSotIwEhokZW6UGikgyJQ+B5CPHQGSnnt5mUmdGSMEkzohasFNMr2ocmr0QlfbPln+57LTyjJ4zQREfGG8cLJRTP0WX7aI9c+bTiCh2Rp6gNYAlz6i56dAvaF2pEvizAn+3Yr8tC63ZR1fTU6vjqGgPAZxXY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49E188CAD166074BA0CA033EED079547@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5b5961-d4a8-4aef-e70d-08d6a0d9b9b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 19:43:50.1593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1390
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 4, 2019, at 5:52 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Wed, Feb 27, 2019 at 09:06:36PM -0800, Song Liu wrote:
>> btf contains information necessary to annotate bpf programs. This patch
>> saves btf for bpf programs loaded in the system.
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> tools/perf/util/bpf-event.c | 24 ++++++++++++++
>> tools/perf/util/bpf-event.h |  7 ++++
>> tools/perf/util/env.c       | 65 +++++++++++++++++++++++++++++++++++++
>> tools/perf/util/env.h       |  4 +++
>> 4 files changed, 100 insertions(+)
>>=20
>> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
>> index ce81b2c43a51..370b830f2433 100644
>> --- a/tools/perf/util/bpf-event.c
>> +++ b/tools/perf/util/bpf-event.c
>> @@ -34,6 +34,29 @@ int machine__process_bpf_event(struct machine *machin=
e __maybe_unused,
>> 	return 0;
>> }
>>=20
>> +static int perf_env__fetch_btf(struct perf_env *env,
>> +			       u32 btf_id,
>> +			       struct btf *btf)
>> +{
>> +	struct btf_node *node;
>> +	u32 data_size;
>> +	const void *data;
>> +
>> +	data =3D btf__get_raw_data(btf, &data_size);
>> +
>> +	node =3D malloc(data_size + sizeof(struct btf_node));
>> +
>> +	if (!node)
>> +		return -1;
>> +
>> +	node->id =3D btf_id;
>> +	node->data_size =3D data_size;
>> +	memcpy(node->data, data, data_size);
>=20
> why don't we store just struct btf itself?
>=20
> thanks,
> jirka

In current libbpf design, definition of "struct btf" is private=20
to tools/lib/bpf/btf.c. So we cannot copy the struct itself.=20

Thanks,
Song




