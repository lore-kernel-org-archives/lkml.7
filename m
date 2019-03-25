Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2113C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA2E2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Augs1O85";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cY3BwwzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfCYR7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:59:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47946 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729036AbfCYR7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:59:49 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PHoQm9020038;
        Mon, 25 Mar 2019 10:59:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=NkjDEd48Zf+wfCnazALnbyRMc1qMouW3VF6HUThvFOY=;
 b=Augs1O85uQUJBV2LzZ80QAeuwhWgYpSwtKT+3BkeJlwH4Qn12iuOeQvk6IoYNvXIxU9r
 nnE182zOz8Zz/h7u2AMso7+9v/E5KdFgnFLXmW03NmhKyfK0S8Gaq8ZT07u9Iapn86XW
 UxOIeSSWog7HymzDFqLRaKRW99KSm8dHruM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rf2hj8j5c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 25 Mar 2019 10:59:45 -0700
Received: from frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 25 Mar 2019 10:59:43 -0700
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 25 Mar 2019 10:59:44 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 25 Mar 2019 10:59:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkjDEd48Zf+wfCnazALnbyRMc1qMouW3VF6HUThvFOY=;
 b=cY3BwwzPvD3QCG1AvvVbZrgfgNG9pb9URcxAfa9zBBwN50CWRODnQZ6W0HjoKgr6xTyT5NZISFT/9lDWweA6HJv1niWz2+s2xwusQG3laUecJnNaqlOzsqlfMcIwXTEmV1TzN6BPmAG6miUDG7uBGJsM023MH5Cc72mxEP2GPFw=
Received: from MW2PR1501MB1993.namprd15.prod.outlook.com (52.132.149.157) by
 MW2PR1501MB1994.namprd15.prod.outlook.com (52.132.149.158) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 17:59:28 +0000
Received: from MW2PR1501MB1993.namprd15.prod.outlook.com
 ([fe80::3d69:6fbf:b6fa:4952]) by MW2PR1501MB1993.namprd15.prod.outlook.com
 ([fe80::3d69:6fbf:b6fa:4952%4]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 17:59:28 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Dave Rodgman <dave.rodgman@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: Kernel LZO compressor
Thread-Topic: Kernel LZO compressor
Thread-Index: AQHU3pByLhwF/AtNc0KFk3n3IDEkuqYcXBGAgABPxgA=
Date:   Mon, 25 Mar 2019 17:59:27 +0000
Message-ID: <95032476-E8E5-4602-B3FC-60A5219123E3@fb.com>
References: <31D143C0-D64F-4905-B25F-5C3630D38913@fb.com>
 <3996dd23-75ab-1619-8ef4-3025436ed4f8@arm.com>
In-Reply-To: <3996dd23-75ab-1619-8ef4-3025436ed4f8@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::1:2942]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8f2dca7-6710-473b-a63f-08d6b14b9fbb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MW2PR1501MB1994;
x-ms-traffictypediagnostic: MW2PR1501MB1994:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MW2PR1501MB19949769F959AC2698F6D39CAB5E0@MW2PR1501MB1994.namprd15.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(40434004)(53936002)(102836004)(76176011)(3480700005)(186003)(53546011)(71200400001)(305945005)(83716004)(71190400001)(6916009)(82746002)(99286004)(97736004)(6246003)(7736002)(6512007)(14454004)(68736007)(6306002)(6506007)(54906003)(4326008)(316002)(86362001)(11346002)(2616005)(476003)(81166006)(81156014)(6436002)(5660300002)(25786009)(106356001)(486006)(105586002)(446003)(6486002)(8936002)(36756003)(478600001)(8676002)(2906002)(5024004)(14444005)(966005)(33656002)(6116002)(229853002)(46003)(7116003)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR1501MB1994;H:MW2PR1501MB1993.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G+bZoxHUtpOHuWZFJnhi3UbBN4L5fgWgRfK+Q96o0Zbr20W8Z78Fdj/AGunIiQJH7AGYPOrkewo3M0AbYPLNpT44+MD24TWS95A+P2pPTBfggKbkRh+NiI522eGOq+bDSXwuKOTtujBubWgMUZWb1v8+Pmi70da5jvVO4AoApTQeptsXP0BNe6ZPWiz/H6jaaSItogiiJdqIAUkO2GbyLPrKRnk7rPx+07xLenBRaoedTt9u+9P7ZYo7y3/dkEbTMLkYzpOM5PRoxEyQBwZ7LmgPrzlsOf0O14mlPkRZCY7PuLaep+7UzyNTapNnVifx5L6Z4y45Bu8ktCsKwyGPa/XOOFinVyJvTmnQNZAkE3Y3uWvqa8DVcJjs+J7tzJRGCtDvlnNpmNu2mVxqYJAE1sDkLkRUPNSI0jR9y0JA/ow=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A1A23587EB245B46BC28E8AF86720E46@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f2dca7-6710-473b-a63f-08d6b14b9fbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 17:59:27.8251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB1994
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 25, 2019, at 6:13 AM, Dave Rodgman <dave.rodgman@arm.com> wrote:
>=20
> On 19/03/2019 8:15 pm, Nick Terrell wrote:
>> Hi Dave,
>>=20
>> I just saw you patches adding LZO-RLE, so I decided to fuzz the LZO
>> compressor and decompressor. I didn't find any crashes, but I found some=
 edge
>> cases in the decompressor.
>=20
> Hi Nick,
>=20
> Thanks - I will take a look at this. These cases won't affect zram, which=
 is
> currently the only place lzo-rle is used, because zram operates over comp=
lete
> pages, but I would prefer not to have this kind of edge case lurking.
>=20
> Presumably the fuzzer generates inputs of various sizes - how large did y=
ou
> test up to?

I tested on inputs up to 4096 bytes large, which is the default, but the fu=
zzing
library libFuzzer has a flag -max_len which allows you to control the maxim=
um
input size.

> thanks
>=20
> Dave
>=20
>>=20
>> After compressing the empty input with lzo1x_1_compress() I get
>> [0x11, 0x00, 0x00] which is rejected by lzo1x_decompress_safe() on line =
60
>> because *ip =3D=3D 17 and in_len < 5 with error LZO_E_INPUT_OVERRUN.
>>=20
>> After compressing the input [0x00] with lzorle1x_1_compress() I get
>> [0x11, 0x01, 0x00, 0x11, 0x00, 0x00] which is rejected by
>> lzo1x_decompress_safe() with error LZO_E_OUTPUT_OVERRUN.
>>=20
>> I ported LZO to userspace by copying the headers from the kernel to
>> userspace and/or rewriting them. The fuzzers and ported LZO are in
>> a GitHub repo so it can be easily reproduced [1]. The compression
>> fuzzer is also included inline below.
>>=20
>> ```
>> #undef NDEBUG
>> #include <string.h>
>> #include <stdint.h>
>> #include <stddef.h>
>> #include <stdlib.h>
>> #include <assert.h>
>> #include <stdio.h>
>>=20
>> #include "lzo.h"
>>=20
>> char wrkmem[LZO1X_MEM_COMPRESS];
>>=20
>> #define RLE 1
>>=20
>> extern "C" int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) =
{
>>  size_t outSize =3D lzo1x_worst_compress(size);
>>  uint8_t* const out =3D (uint8_t*)malloc(outSize);
>>  assert(out);
>> #if RLE
>>  assert(LZO_E_OK =3D=3D lzorle1x_1_compress(data, size, out, &outSize, w=
rkmem));
>> #else
>>  assert(LZO_E_OK =3D=3D lzo1x_1_compress(data, size, out, &outSize, wrkm=
em));
>> #endif
>>  uint8_t* const rt =3D (uint8_t*)malloc(size);
>>  assert(rt);
>>  size_t rtsize =3D size;
>>  int const ret =3D lzo1x_decompress_safe(out, outSize, rt, &rtsize);
>>  if (ret !=3D LZO_E_OK) {
>>    assert(size < 4);
>>    fprintf(stderr, "INPUT: ");
>>    for (size_t i =3D 0; i < size; ++i)
>>      fprintf(stderr, "%u ", (unsigned)data[i]);
>>    fprintf(stderr, "\nOUTPUT: ");
>>    for (size_t i =3D 0; i < outSize; ++i)
>>      fprintf(stderr, "%u ", (unsigned)out[i]);
>>    fprintf(stderr, "\nret =3D %d\n", ret);
>>  }
>>  assert(ret =3D=3D LZO_E_OK);
>>  assert(rtsize =3D=3D size);
>>  assert(memcmp(data, rt, size) =3D=3D 0);
>>  free(out);
>>  free(rt);
>>  return 0;
>> }
>> ```
>>=20
>> [1] https://github.com/terrelln/lzo-userspace-fuzz
>>=20
>> Best,
>> Nick Terrell
>>=20
>=20
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.

