Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD87C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B8920656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jMnRAkDo";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gXY+qolL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfEGS3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:29:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44332 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbfEGS3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:29:23 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47ITEIf021679;
        Tue, 7 May 2019 11:29:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=VVoJzXiIYMBgDhT3M8nX5YcJdyN0mYb2wMXwaieyRzE=;
 b=jMnRAkDo9k2SGz/kCGNFcfyn9qU4AMGJLpNcNWfyW87KWp92hDGbAiedW/ssJfWqVwvN
 EY74zcKm6e8zoZOzxM7HM0EXsZy/E/EtwFU/JH9mutOk+zJuVD/BN5qzSFuv6gavPlap
 ZhB03JaKONUysDZsAZlla/wMhyAl9q5bzls= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sb1yf2sq3-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 May 2019 11:29:15 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 May 2019 11:29:10 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 7 May 2019 11:29:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVoJzXiIYMBgDhT3M8nX5YcJdyN0mYb2wMXwaieyRzE=;
 b=gXY+qolLLs+Jqjph12tlca+tYatrrbMMpy+0C0gDTzqD052RUktGomri9WT8MgPD5GUN81MWOIo78ghH1SmfmJ03zZf6q+DCM39obIUJqc2W0Q/I4J1S0lWECK/er/nXXDV7fg+TgurV0QAwiVJP7fRrnlzbPT1u4E0gOO3WBFs=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1213.namprd15.prod.outlook.com (10.175.2.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Tue, 7 May 2019 18:29:08 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 18:29:08 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 07/12] perf script: Pad dso name for --call-trace
Thread-Topic: [PATCH 07/12] perf script: Pad dso name for --call-trace
Thread-Index: AQHVAYjr0qNMvZQyn0Whx89yRppmGaZepSIAgACxZgCAAKvnAA==
Date:   Tue, 7 May 2019 18:29:07 +0000
Message-ID: <37A033AF-567C-47F5-8FBB-DBD26ED1BD13@fb.com>
References: <20190503081841.1908-1-jolsa@kernel.org>
 <20190503081841.1908-8-jolsa@kernel.org>
 <8385E7AF-756B-4113-9388-BD81D0F58374@fb.com> <20190507081350.GA17416@krava>
In-Reply-To: <20190507081350.GA17416@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::2:3cfe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bace93b9-9086-4009-4d26-08d6d319e478
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1213;
x-ms-traffictypediagnostic: MWHPR15MB1213:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB1213C90D94C7775A7C321387B3310@MWHPR15MB1213.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(366004)(396003)(199004)(189003)(6306002)(54906003)(6512007)(33656002)(81166006)(186003)(8676002)(8936002)(6916009)(305945005)(6506007)(82746002)(53546011)(99286004)(81156014)(25786009)(7736002)(76176011)(46003)(229853002)(68736007)(966005)(6486002)(486006)(14454004)(6436002)(4326008)(11346002)(446003)(5660300002)(476003)(2616005)(64756008)(57306001)(53936002)(6246003)(316002)(256004)(7416002)(478600001)(66946007)(73956011)(83716004)(76116006)(36756003)(102836004)(71190400001)(6116002)(2906002)(71200400001)(66476007)(86362001)(66446008)(66556008)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1213;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MJegnCnmnrymnKHUafPIUFEiS8ScFZcseSBdVFPGAipAlmeI8ZMfHM1KxyPCO3N8DsE81UNcKOHOeiS9qsnSbRYhKD9uuyE/YM3yI/XxRxo54AzrL6xbs3lbeZo/t2XaHFMzKj5wuT0aWqGslCpbjJiwsbAQcuC/28so6Zm35fq/fkQJl7KXoUSpYvuoI5OWm8maU6Zz8QOnNw4KXkw1pMNGQa841NSPs4LT9djiMxgLQHIkB7H2/pDIVYJ7Uqtq1lIKlkuAwCvWL5DFEpJIqi63qXzxiDqOWLZ+DwJxxDlFYEBS8Xr2OuqvnEuC6C9kV1OVk1O8dt/6AWKb4aSY5FHmX+KzBfVo7DTfa0wnJkceE0Ao6HYnI/ymnW+6yNNCP50AQcH4UZUnIfCoTIICDUuPuPGjWsikJYMW0zRp8MA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A5D3B078D40584E8FC3625223C7FA5E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bace93b9-9086-4009-4d26-08d6d319e478
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 18:29:07.8254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1213
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905070119
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 7, 2019, at 1:13 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Mon, May 06, 2019 at 09:38:55PM +0000, Song Liu wrote:
>=20
> SNIP
>=20
>>>=20
>>> Link: http://lkml.kernel.org/n/tip-99g9rg4p20a1o99vr0nkjhq8@git.kernel.=
org
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>> ---
>>> tools/include/linux/kernel.h  |  1 +
>>> tools/lib/vsprintf.c          | 19 +++++++++++++++++++
>>> tools/perf/builtin-script.c   |  1 +
>>> tools/perf/util/map.c         |  6 ++++++
>>> tools/perf/util/symbol_conf.h |  1 +
>>> 5 files changed, 28 insertions(+)
>>>=20
>>> diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.=
h
>>> index 857d9e22826e..cba226948a0c 100644
>>> --- a/tools/include/linux/kernel.h
>>> +++ b/tools/include/linux/kernel.h
>>> @@ -102,6 +102,7 @@
>>>=20
>>> int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
>>> int scnprintf(char * buf, size_t size, const char * fmt, ...);
>>> +int scnprintf_pad(char * buf, size_t size, const char * fmt, ...);
>>>=20
>>> #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_arr=
ay(arr))
>>>=20
>>> diff --git a/tools/lib/vsprintf.c b/tools/lib/vsprintf.c
>>> index e08ee147eab4..149a15013b23 100644
>>> --- a/tools/lib/vsprintf.c
>>> +++ b/tools/lib/vsprintf.c
>>> @@ -23,3 +23,22 @@ int scnprintf(char * buf, size_t size, const char * =
fmt, ...)
>>>=20
>>>       return (i >=3D ssize) ? (ssize - 1) : i;
>>> }
>>> +
>>> +int scnprintf_pad(char * buf, size_t size, const char * fmt, ...)
>>> +{
>>> +	ssize_t ssize =3D size;
>>> +	va_list args;
>>> +	int i;
>>=20
>> nit: I guess we can avoid mixing int, ssize_t and size_t here?
>=20
> I copied that from scnprintf ;-)
>=20
> the thing is that at the end we call vsnprintf, which takes size_t
> as size param and returns int, so there will be casting at some
> point in any case..
>=20
> I guess the ssize_t was introduced to compare the size_t value with int
>=20

Interesting. Given scnprintf works fine, I think we can keep the patch
as-is.=20

Thanks,
Song=
