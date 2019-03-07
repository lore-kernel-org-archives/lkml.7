Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E39C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BAFA2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lFHP0FiX";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Zu9jkZc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfCGRWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:22:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46518 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726161AbfCGRWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:22:08 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27HH9an006619;
        Thu, 7 Mar 2019 09:21:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=I19nWPn1ISt/7dc06z1qAsARd5McKV51XLt88R21XEs=;
 b=lFHP0FiXGjtf5lEFKN3ULSb3ZP1XHJHzeI5KrlTGONeqCVYoc+W9+QjoKP0ghCs0vEjj
 pLXMUQBqTkfNRfwzfHFLV4/wXFpjoeYdTQ1VnP9+GOCmHUevGKzw2yuf/eeLNaWXRxo4
 04x5VWYeUy8Qm6DOiMaywSN0lhjbV2ed2/0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r34up0k4m-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 07 Mar 2019 09:21:33 -0800
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 7 Mar 2019 09:19:14 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 7 Mar 2019 09:19:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I19nWPn1ISt/7dc06z1qAsARd5McKV51XLt88R21XEs=;
 b=Zu9jkZc7dqF6vgHbXM19j+KJpXDMMIWfRQrDqoWiGDl5sInI11LwChU4xvaL82kS6AXvoAzZ7nEqkDP1ns1d14EBSiQf2mdTLQtpwg5jUdTzV8Yo/IJWA77g3pxzgqUdF/bMKCP85QkpvPMHvypEJyUSXl6RYR6Bqli4RZwdhh4=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1902.namprd15.prod.outlook.com (10.174.100.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Thu, 7 Mar 2019 17:19:12 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1665.021; Thu, 7 Mar 2019
 17:19:12 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v6 perf,bpf 07/15] perf, bpf: save bpf_prog_info
 information as headers to perf.data
Thread-Topic: [PATCH v6 perf,bpf 07/15] perf, bpf: save bpf_prog_info
 information as headers to perf.data
Thread-Index: AQHU0+xdzbakwDRacEqsy3fX06hwoaYANeqAgAA1/4A=
Date:   Thu, 7 Mar 2019 17:19:12 +0000
Message-ID: <37FD92BA-3DA2-4A24-BA47-29ADFC592874@fb.com>
References: <20190306071359.2359896-1-songliubraving@fb.com>
 <20190306071359.2359896-8-songliubraving@fb.com>
 <20190307140555.GD7233@krava>
In-Reply-To: <20190307140555.GD7233@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::3:415b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 493789b0-1cd0-4004-7bd9-08d6a32104a4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1902;
x-ms-traffictypediagnostic: MWHPR15MB1902:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1902;20:MGvXshrsAwpfTqbIff3Ff+1BvbANDVosk2/h70RsUM8oMPdTF2CmZarjHLoOu8LK/Xip7EC2Zc8RakEzt2bmTzHRUinHrpWMB+svamsm1UrF2234z+0Rh6kocG/Drzxfc6HNdm7WCLFXxnDAfA1YC9xopUYoOGvtf+P+hdTmV3U=
x-microsoft-antispam-prvs: <MWHPR15MB1902A0C69979D0A145C4F2B1B34C0@MWHPR15MB1902.namprd15.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(366004)(136003)(376002)(199004)(189003)(6116002)(82746002)(102836004)(11346002)(83716004)(53546011)(6506007)(476003)(478600001)(76176011)(2616005)(57306001)(5660300002)(6436002)(36756003)(446003)(14454004)(486006)(71200400001)(46003)(71190400001)(86362001)(8936002)(186003)(7416002)(50226002)(229853002)(99286004)(6486002)(6512007)(105586002)(54906003)(106356001)(53936002)(8676002)(81156014)(97736004)(316002)(68736007)(81166006)(6246003)(256004)(33656002)(14444005)(2906002)(6916009)(7736002)(305945005)(25786009)(4326008)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1902;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r+mdL8URUNS2LWiT+2CbYk6DWUJdVXkZWMtKn7ttEYp1IIgT+XXAVIBLY+yHx7Mz3WXcusufLawpggFaq8BHX8YO7Q1W1wf47D2uZIEEXn9FxBpALXvDHAnUgiyn7IQpyILqkm7ZCfUs1JHIWGap1Z3RpL97ZUoBbUHFcoFpK2xWPNJmROLGP5HVITx6nuYIYb/lmJ18sYHNcRt7u4oPQoT5iMsjDJ7IWnI4r55TCLZoCgRbSc/Y00/dMNbCoLxKh2Pt7J8HXQVO+DFdQYoYsYbGjg6ZsoOLACaRht98Ju94SaG7QqX/ECIQxRiHiTSPoDlibTwPlgj5qaAYQue3eJybThE0haqVkBhZyWuAFcbkptruOPl/LEVtqNye8DeGI5TfIrYHRdrSD2gs1WuM71rf2UpBJ13nuHo6v6l8Nj8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A92E946C500624481C329242F49F75B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 493789b0-1cd0-4004-7bd9-08d6a32104a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 17:19:12.5469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1902
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 7, 2019, at 6:05 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Tue, Mar 05, 2019 at 11:13:51PM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> +static int process_bpf_prog_info(struct feat_fd *ff,
>> +				 void *data __maybe_unused)
>> +{
>> +	struct bpf_prog_info_linear *info_linear;
>> +	struct bpf_prog_info_node *info_node;
>> +	struct perf_env *env =3D &ff->ph->env;
>> +	u32 count, i;
>> +	int err =3D -1;
>> +
>> +	if (do_read_u32(ff, &count))
>> +		return -1;
>> +
>> +	if (ff->ph->needs_swap)
>> +		pr_warning("interpreting bpf_prog_info from systems with endianity is=
 not yet supported\n");
>=20
> 		return 0; ?
>=20
> what's here to process?
>=20
> jirka

Aha, I didn't notice the lseek() call in perf_file_section__process(),=20
so I was thinking we need to keep proper offset. With the lseek(),=20
this is not necessary.=20

I will fix it in the next version.=20

Thanks,
Song

>> +
>> +	down_write(&env->bpf_progs.lock);
>> +
>> +	for (i =3D 0; i < count; ++i) {
>> +		u32 info_len, data_len;
>> +
>> +		info_linear =3D NULL;
>> +		info_node =3D NULL;
>> +		if (do_read_u32(ff, &info_len))
>> +			goto out;
>> +		if (do_read_u32(ff, &data_len))
>> +			goto out;
>> +
>> +		if (info_len > sizeof(struct bpf_prog_info)) {
>> +			pr_warning("detected invalid bpf_prog_info\n");
>> +			goto out;
>> +		}
>> +
>> +		info_linear =3D malloc(sizeof(struct bpf_prog_info_linear) +
>> +				     data_len);
>> +		if (!info_linear)
>> +			goto out;
>> +		info_linear->info_len =3D sizeof(struct bpf_prog_info);
>> +		info_linear->data_len =3D data_len;
>> +		if (do_read_u64(ff, (u64 *)(&info_linear->arrays)))
>> +			goto out;
>> +		if (__do_read(ff, &info_linear->info, info_len))
>> +			goto out;
>> +		if (info_len < sizeof(struct bpf_prog_info))
>> +			memset(((void *)(&info_linear->info)) + info_len, 0,
>> +			       sizeof(struct bpf_prog_info) - info_len);
>> +
>> +		if (__do_read(ff, info_linear->data, data_len))
>> +			goto out;
>> +
>> +		/* endian mismatch, drop the info, continue */
>> +		if (ff->ph->needs_swap) {
>> +			free(info_linear);
>> +			continue;
>> +		}
>> +
>> +		info_node =3D malloc(sizeof(struct bpf_prog_info_node));
>> +		if (!info_node)
>> +			goto out;
>> +
>> +		/* after reading from file, translate offset to address */
>> +		bpf_program__bpil_offs_to_addr(info_linear);
>> +		info_node->info_linear =3D info_linear;
>> +		perf_env__insert_bpf_prog_info(env, info_node);
>> +	}
>> +
>> +	return 0;
>> +out:
>> +	free(info_linear);
>> +	free(info_node);
>> +	up_write(&env->bpf_progs.lock);
>> +	return err;
>> +}
>=20
> SNIP

