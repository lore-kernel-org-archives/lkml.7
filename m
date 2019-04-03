Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A2EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53DB2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Er5/3q5a";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="aX4JKmAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDCRFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:05:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56550 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726188AbfDCRFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:05:18 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33GxYcL019293;
        Wed, 3 Apr 2019 10:05:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=u+BvOZ7eOGV3eqUxAdpZKz8Wy6sLlnZ0bhmwWgUFkHI=;
 b=Er5/3q5a2A0x/HNWWp+PuXEF+RZlqz18vR44sPZGadmdStzY+b4e4Bv/jOpWkq1IcwEt
 nXbSooCboLQukArwXDDbu3Lr7MNyKYt06gfzd7FgD9DZtWNOpjvFSRxgShfJ1D3vNQGc
 NLuNBml8g67WOmdn1ImFEjwlTBL3IIUc4os= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rmsgahnr6-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Apr 2019 10:05:08 -0700
Received: from frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 10:05:04 -0700
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 10:05:04 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 3 Apr 2019 10:05:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+BvOZ7eOGV3eqUxAdpZKz8Wy6sLlnZ0bhmwWgUFkHI=;
 b=aX4JKmAr4wBjF/S63QbwqLZxv8n0FG+ASL5oJ5MYKJBU+7/ut1CNCC6DkPCAmPKOwZ7Kxad9jsPbR0/ITELTGu7nNs/HjkNaDQJJrEtmOTm5ivGwSKynggkhLFHHYF/FV2Ix2Z4SPm4fVCUN5HjYTqgLJiXdSvP8oKb4JW7Jn8o=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1950.namprd15.prod.outlook.com (10.175.8.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 3 Apr 2019 17:05:02 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171%2]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 17:05:02 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [BUG] perf: intel_pt won't display kernel function
Thread-Topic: [BUG] perf: intel_pt won't display kernel function
Thread-Index: AQHU6irWpD85AOHzLkautxj0S1Vk3aYqqmmA
Date:   Wed, 3 Apr 2019 17:05:02 +0000
Message-ID: <4EA3EF29-6D79-4F79-B1AD-0B6C12A5FF97@fb.com>
References: <20190403143738.GB32001@krava>
In-Reply-To: <20190403143738.GB32001@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::2:1b0d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e32b794-d96d-4ccf-9044-08d6b8568354
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1950;
x-ms-traffictypediagnostic: MWHPR15MB1950:
x-microsoft-antispam-prvs: <MWHPR15MB1950B8139A9BC8ADEB999C78B3570@MWHPR15MB1950.namprd15.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6246003)(33656002)(6512007)(71200400001)(8676002)(81156014)(81166006)(14454004)(54906003)(2906002)(36756003)(105586002)(106356001)(5660300002)(68736007)(186003)(316002)(256004)(76176011)(6116002)(6436002)(14444005)(4326008)(102836004)(6506007)(83716004)(97736004)(25786009)(71190400001)(476003)(53546011)(53936002)(46003)(11346002)(305945005)(57306001)(486006)(82746002)(229853002)(50226002)(478600001)(446003)(6916009)(86362001)(7736002)(99286004)(6486002)(2616005)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1950;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H9tgcSyV5Lcir4i6lVYFS+MIebiI9D7nNKzQvufRz9caLWzPl5LyRECPRNYilI4NkpZDUlE4+qyGc8WzQCzOBnXX7f7X34gDqymcb4RyJCp/ADDsLxU7UeQ3F6yikJDHJ0fig6yBrYpgs4nRpPP4+4ilH/fNefxfgKF0Q5sKME0LLLZDRzjCqoIzaRfVwK9beGIdSAD7yJK+d7PURdfq0EJbd3hnGqvbaLOn0hbpr+abrQrrxdOeD9b3tTgaH6u0fOCN235ydlSjWFHvc5C3jCeYgz+w72XewzjPLL1tTnJ/4WdoitS0k6pMws6Z64/XG5wKkNsN64Lr8izKnnLEO085GFytyzHxxCwc7BLoOO2gaiOvEUAtBLc6ijOn6m/o5wy0ZkXvtoSbki8TcNWIblJ03FC+SfpTcnBqDAddeeI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C01B5A517BD4664FB4AB7595DC37932F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e32b794-d96d-4ccf-9044-08d6b8568354
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 17:05:02.7867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1950
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 3, 2019, at 7:37 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> hi,
> perf script --call-trace stop working for me recently,
> and displays only user space functions
>=20
> I bisected that to:
>  7b612e291a5a perf tools: Synthesize PERF_RECORD_* for loaded BPF program=
s
>=20
> data from following comands will display user space functions only:
>  # perf-with-kcore record pt -e intel_pt// -- ls
>  # perf-with-kcore script pt --call-trace

Seems the following are ok (upstream as-is)?

./perf record -e intel_pt// -- ls
./perf script --call-trace

Jiri, could you please verify this? (Sorry I am new to perf-with-kcore).=20

Thanks,
Song

>=20
> when I disable the bpf synthesizing (patch below), kernel functions are b=
ack
>=20
> I guess the new events mess up with intel_pt decoder somehow
>=20
>=20
> thanks,
> jirka
>=20
>=20
> ---
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4e2d953d4bc5..3daa78bc6549 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1114,10 +1114,12 @@ static int record__synthesize(struct record *rec,=
 bool tail)
> 		return err;
> 	}
>=20
> +#if 0
> 	err =3D perf_event__synthesize_bpf_events(session, process_synthesized_e=
vent,
> 						machine, opts);
> 	if (err < 0)
> 		pr_warning("Couldn't synthesize bpf events.\n");
> +#endif
>=20
> 	err =3D __machine__synthesize_threads(machine, tool, &opts->target, rec-=
>evlist->threads,
> 					    process_synthesized_event, opts->sample_address,

