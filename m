Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD8AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5570213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WL2yARxR";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EYzcnpf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfCSUPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:15:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54866 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727017AbfCSUPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:15:15 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JKCKcE019571;
        Tue, 19 Mar 2019 13:15:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=facebook;
 bh=kxwGvXRq6eMeBaXh9b05WOAD3wrtaMklvgSAuzBR7X0=;
 b=WL2yARxRAD+vCVHQiQd1M8sU0/LIGbWvLVpSbQWPyZOQO9cu+HuPhf+C20AjEPaRhrPo
 yxwuxMzJSUfSF0qtS9fyzaKdTeaGdJDTrXjCIkOejZj6eoCf3k4Cb+wNjU+aY0MqeiUl
 F96pfeplJF8rJ5Ydl0/4q97l7hIbQefKfqw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2rb0x59mqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 Mar 2019 13:15:11 -0700
Received: from frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 19 Mar 2019 13:15:11 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 19 Mar 2019 13:15:10 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 19 Mar 2019 13:15:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxwGvXRq6eMeBaXh9b05WOAD3wrtaMklvgSAuzBR7X0=;
 b=EYzcnpf3mo2iloh+/6a/dw625RJAXJOPdqv4/0+dzeGldWEFARxxgDB7GCBapAJIg84VlvraaPhrFffq0hLAtb9K8VWoIVty3rGtHzSXfQI8jOwl1cG72NUHGNZiPmbejMLaUoQJBXp8Z+Kw38Qawib2r0zikxYvO5/TMlVblbM=
Received: from MW2PR1501MB1993.namprd15.prod.outlook.com (52.132.149.157) by
 MW2PR1501MB2185.namprd15.prod.outlook.com (52.132.150.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 20:15:07 +0000
Received: from MW2PR1501MB1993.namprd15.prod.outlook.com
 ([fe80::25c8:e561:b2ff:4a40]) by MW2PR1501MB1993.namprd15.prod.outlook.com
 ([fe80::25c8:e561:b2ff:4a40%7]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 20:15:07 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     "dave.rodgman@arm.com" <dave.rodgman@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Kernel LZO compressor
Thread-Topic: Kernel LZO compressor
Thread-Index: AQHU3pByWt4yBWNOP0ewGbmZjuuI6A==
Date:   Tue, 19 Mar 2019 20:15:07 +0000
Message-ID: <31D143C0-D64F-4905-B25F-5C3630D38913@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::2:2ee8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c73ff9b-6aa8-4978-ff83-08d6aca794fc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MW2PR1501MB2185;
x-ms-traffictypediagnostic: MW2PR1501MB2185:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MW2PR1501MB2185E1D2FCCCD73C561C00C3AB400@MW2PR1501MB2185.namprd15.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(39860400002)(346002)(366004)(199004)(189003)(966005)(106356001)(3480700005)(46003)(110136005)(33656002)(71200400001)(71190400001)(83716004)(68736007)(476003)(2501003)(82746002)(8936002)(105586002)(6306002)(25786009)(7116003)(5660300002)(97736004)(316002)(256004)(102836004)(6512007)(6506007)(2616005)(81156014)(8676002)(6486002)(86362001)(81166006)(6636002)(53936002)(186003)(6116002)(14454004)(36756003)(2906002)(478600001)(7736002)(305945005)(486006)(6436002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR1501MB2185;H:MW2PR1501MB1993.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AMhS/Hk5I1LMVC/bAep0lbr7N+axPkdAEG7k7jMdKqDoDMqpoTpF/dlQAAuXVvip9mT8USJ5O0r1CboXGVTCc8y0RJ2tydwJYVrIc3k/vJBcx/r1AnkuVNaNAlpKWmFXg8DSoZzSOjX05AJYdXdpCWlVBNMYLOtexHI48+k1GrgZwZm3haai8uo+CGqnyZbbouMi4No9jK7R+tI8UAcbe2hu6bDMjMxF2nCuvJ/e7wECrdFfbgLjkl5+J5pD/lCmjZKfBqnyC3SymoKHthnMTKGGTgzGlacxncMnQiDRhvzhmUSLUEISCda4BRy6O0H7Ii5s8L8jFH85VI2kUC85Of4ZxU+nW/ZudrcVNfbhPJ7eOGX/y9IroLfi4nqYGvKE3eEYvR8Wee3MVfmXlgW5TsMqFDVpMbXFNXp5TqiYZkU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B76C7350B42D4846A33F964A76905327@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c73ff9b-6aa8-4978-ff83-08d6aca794fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 20:15:07.7137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2185
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

I just saw you patches adding LZO-RLE, so I decided to fuzz the LZO
compressor and decompressor. I didn't find any crashes, but I found some ed=
ge
cases in the decompressor.

After compressing the empty input with lzo1x_1_compress() I get
[0x11, 0x00, 0x00] which is rejected by lzo1x_decompress_safe() on line 60
because *ip =3D=3D 17 and in_len < 5 with error LZO_E_INPUT_OVERRUN.

After compressing the input [0x00] with lzorle1x_1_compress() I get
[0x11, 0x01, 0x00, 0x11, 0x00, 0x00] which is rejected by
lzo1x_decompress_safe() with error LZO_E_OUTPUT_OVERRUN.

I ported LZO to userspace by copying the headers from the kernel to
userspace and/or rewriting them. The fuzzers and ported LZO are in
a GitHub repo so it can be easily reproduced [1]. The compression
fuzzer is also included inline below.

```
#undef NDEBUG
#include <string.h>
#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>
#include <assert.h>
#include <stdio.h>

#include "lzo.h"

char wrkmem[LZO1X_MEM_COMPRESS];

#define RLE 1

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
  size_t outSize =3D lzo1x_worst_compress(size);
  uint8_t* const out =3D (uint8_t*)malloc(outSize);
  assert(out);
#if RLE
  assert(LZO_E_OK =3D=3D lzorle1x_1_compress(data, size, out, &outSize, wrk=
mem));
#else
  assert(LZO_E_OK =3D=3D lzo1x_1_compress(data, size, out, &outSize, wrkmem=
));
#endif
  uint8_t* const rt =3D (uint8_t*)malloc(size);
  assert(rt);
  size_t rtsize =3D size;
  int const ret =3D lzo1x_decompress_safe(out, outSize, rt, &rtsize);
  if (ret !=3D LZO_E_OK) {
    assert(size < 4);
    fprintf(stderr, "INPUT: ");
    for (size_t i =3D 0; i < size; ++i)
      fprintf(stderr, "%u ", (unsigned)data[i]);
    fprintf(stderr, "\nOUTPUT: ");
    for (size_t i =3D 0; i < outSize; ++i)
      fprintf(stderr, "%u ", (unsigned)out[i]);
    fprintf(stderr, "\nret =3D %d\n", ret);
  }
  assert(ret =3D=3D LZO_E_OK);
  assert(rtsize =3D=3D size);
  assert(memcmp(data, rt, size) =3D=3D 0);
  free(out);
  free(rt);
  return 0;
}
```

[1] https://github.com/terrelln/lzo-userspace-fuzz

Best,
Nick Terrell
