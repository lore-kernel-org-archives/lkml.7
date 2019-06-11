Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A84C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4F42086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BE650KSY";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LclP55GL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404245AbfFKHSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 03:18:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53222 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404113AbfFKHSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:18:54 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5B7IFkO017665;
        Tue, 11 Jun 2019 00:18:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WtVxs7gfl1cR1XXKRas3cqP+6+xbsNHhlffuh5z6AVo=;
 b=BE650KSYFPa1P7W0CzXCcLqhC6dh5djnttLC/haBS43MdWE6/FrUqP91pTnFbPPg4HlH
 PTQJHU1r0Xvv5HOjS7m8Do8bBsKfAaE4WF/YQ/64P65dkp5rDyjB60ukNLVIwSLomusS
 K2LapxbYrwWFeZ0j4ZXxE2JFyBkvNeE/Aaw= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t1wqbstag-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 11 Jun 2019 00:18:27 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 11 Jun 2019 00:18:26 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 11 Jun 2019 00:18:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtVxs7gfl1cR1XXKRas3cqP+6+xbsNHhlffuh5z6AVo=;
 b=LclP55GLpWo4zAE2+b8rydbZmCzK3xdLslg4HTrjF++YrY0HoUOGDQUu+AugNUnhzXvF0RFz3lN7D1YsG9vwM7dkekEMmd2NzZHDEvd0VHSaX3HmARqvFIO1kZbTpd3N2j4O2cVhi/MWlwr14Pz+ZekPHlhiD8zc+5nZVlrzbc0=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1664.namprd15.prod.outlook.com (10.175.141.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Tue, 11 Jun 2019 07:18:09 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 07:18:09 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        David Carrillo Cisneros <davidca@fb.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>
Subject: Re: [PATCH] perf script/intel-pt: set synth_opts.callchain for
 use_browser > 0
Thread-Topic: [PATCH] perf script/intel-pt: set synth_opts.callchain for
 use_browser > 0
Thread-Index: AQHVH+Yx7p0qFbqvmEmy4wLpGw5xK6aWApkAgAAJPQA=
Date:   Tue, 11 Jun 2019 07:18:09 +0000
Message-ID: <F8963F4B-46FF-41D2-B261-6DD2EE898D93@fb.com>
References: <20190610234216.2849236-1-songliubraving@fb.com>
 <def87b9f-a4fa-37ff-722a-9f14b14b2c7b@intel.com>
In-Reply-To: <def87b9f-a4fa-37ff-722a-9f14b14b2c7b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::1:73aa]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc004123-9a89-4fcd-ecd0-08d6ee3cf51b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1664;
x-ms-traffictypediagnostic: MWHPR15MB1664:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB16642435CDCFF958FA3EA3C3B3ED0@MWHPR15MB1664.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:247;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(136003)(346002)(366004)(199004)(189003)(14454004)(76176011)(6506007)(102836004)(2616005)(25786009)(6116002)(446003)(53546011)(57306001)(6436002)(11346002)(476003)(6306002)(46003)(486006)(66574012)(86362001)(6916009)(82746002)(316002)(99286004)(6246003)(6512007)(76116006)(66556008)(8936002)(966005)(66446008)(81166006)(305945005)(64756008)(54906003)(71200400001)(5660300002)(66476007)(73956011)(66946007)(33656002)(7736002)(6486002)(50226002)(256004)(186003)(81156014)(68736007)(14444005)(4326008)(53936002)(478600001)(71190400001)(2906002)(8676002)(229853002)(36756003)(83716004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1664;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 47L6DlyDVSQpYf5jGalqdr5KwJObiJhRWp+sbF0aPn+u6i1gT6gBCsnNqiBatPlBSYlAbuB/bNuA2hGFt6Wcs1+q08e+CtdKwjxVRz+snNIMGx1d7OQr6G7QkLFpNnz+ro57Me7qT5OIrrmn+F5VAWv4DvRaxk2gmtgMvO+WjaGzuYE/9Q5aEhEaZxn2AGOhXv/ktoT23zXCMvYSS6MI31n4cljn+QbwX9z4JllLNsd8rmA8zA9gyndgaLClCgzK06pYTODyn/vb68I37eLttCYgsqxZGYrgNyHlTr2AjU24XDoFVod/3lssSAbh79mrbxVeNJd7h63BfIUqmyvskALCaxo9s8cTLUruG7rZ4hIXUqzia5ib6VBxVKf6sUtFNX0UPBMW5wHGcWM7H2urufJ3mcXsoyBrSjX6CY/E2FE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <04CD47207BEF8141A133719DAE4A7E91@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bc004123-9a89-4fcd-ecd0-08d6ee3cf51b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 07:18:09.5789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1664
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110051
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 10, 2019, at 11:45 PM, Adrian Hunter <adrian.hunter@intel.com> wro=
te:
>=20
> On 11/06/19 2:42 AM, Song Liu wrote:
>> Currently, intel_pt_process_auxtrace_info() sets synth_opts.callchain fo=
r
>> use_browser !=3D -1, which is not accurate after we set use_browser to 0=
 in
>> cmd_script(). As a result, the following commands sees a lot more errors
>> like:
>>=20
>>  perf record -e intel_pt//u -C 10 -- sleep 3
>>  perf script
>>=20
>>  ...
>>  instruction trace error type 1 time ...
>>  ...
>>=20
>> This patch fixes this by checking use_browser > 0 instead.
>>=20
>> Fixes: c1c9b9695cc8 ("perf script: Allow extended console debug output")
>> Reported-by: David Carrillo Cisneros <davidca@fb.com>
>> Cc: Milian Wolff <milian.wolff@kdab.com>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> tools/perf/util/intel-pt.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
>> index 6d288237887b..15692c104ca8 100644
>> --- a/tools/perf/util/intel-pt.c
>> +++ b/tools/perf/util/intel-pt.c
>> @@ -2588,7 +2588,7 @@ int intel_pt_process_auxtrace_info(union perf_even=
t *event,
>> 	} else {
>> 		itrace_synth_opts__set_default(&pt->synth_opts,
>> 				session->itrace_synth_opts->default_no_sample);
>> -		if (use_browser !=3D -1) {
>> +		if (use_browser > 0) {
>=20
> That code has changed recently.  Refer:
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=
=3Dperf/core&id=3D26f19c2eb7e54

Thanks for a better fix! I was using Arnaldo's perf/urgent branch, and miss=
ed
this one.=20

Song

>=20
>=20
>> 			pt->synth_opts.branches =3D false;
>> 			pt->synth_opts.callchain =3D true;
>> 		}

