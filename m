Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E6FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85802147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bOj9klGS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Brqapsrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfCKVzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:55:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41882 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727459AbfCKVzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:55:32 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BLkFTj016244;
        Mon, 11 Mar 2019 14:55:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5WpMukIKjceil3SpIAngqgCoYJv6uUf8iK+7I+cfzkA=;
 b=bOj9klGSQ91vAxDIFYyo3BVCqMYyAS1Y6230xl+Hu2cKPIyaLgJeoQxAmg6gQ96uBmc2
 BbG5R7OP2aD/5m5IE+oXo2HaQAhXSp+tTZd3VcvHNjcMfjY5wSbJRwDG7QD0lkg+IsFN
 elk2mNJd5Zh1aVHaUlHNrOYOCDF5wCniLhA= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r5w3srmff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Mar 2019 14:55:20 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 14:54:18 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Mar 2019 14:54:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WpMukIKjceil3SpIAngqgCoYJv6uUf8iK+7I+cfzkA=;
 b=BrqapsrbN0Y2HSsETtFKz1p0Y/QXvDcVRmhasiQa9q4fXYyY8vcMa+NHKgz2hvxQ4JV2YZ9DCCXvc+oyfiV0UDUVfxSW1Uu7jRq/Apyo22bu5+pidCA24TpF1BcjmbJH0YcvPqAIRMmCXQ2z4qDuAB21QW+j6pr3m1tB+cF9VPs=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2262.namprd15.prod.outlook.com (52.135.197.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.19; Mon, 11 Mar 2019 21:54:17 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 21:54:17 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Tobin C. Harding" <tobin@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 03/15] tools/vm/slabinfo: Add support for -C and -F options
Thread-Topic: [RFC 03/15] tools/vm/slabinfo: Add support for -C and -F options
Thread-Index: AQHU1WW9Q5dc3ffqEUmrnDIqAHiCmKYG/yKA
Date:   Mon, 11 Mar 2019 21:54:17 +0000
Message-ID: <20190311215413.GB7915@tower.DHCP.thefacebook.com>
References: <20190308041426.16654-1-tobin@kernel.org>
 <20190308041426.16654-4-tobin@kernel.org>
In-Reply-To: <20190308041426.16654-4-tobin@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0038.namprd22.prod.outlook.com
 (2603:10b6:300:69::24) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:b487]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f8a58a6-10e4-4e7c-61b3-08d6a66c1bb5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2262;
x-ms-traffictypediagnostic: BYAPR15MB2262:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2262;20:xk69ZlJcxUOgdCxxHWbjcFMj0bKl4x8tv4Mes8xEx8VLaL+hWoPRqc30FsGXzQ1vYriXxJWzx78I509yUmLliRjCoipBfgxzEW9BmkfJAmbxANW7fYzNozwbxRzFu51MTTU0No1KP+RzFTGBVzYXkJ1fWytGmZYuga5oUpuB7AU=
x-microsoft-antispam-prvs: <BYAPR15MB226231FA91450427DE6FD9BABE480@BYAPR15MB2262.namprd15.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(136003)(346002)(376002)(199004)(189003)(5660300002)(6116002)(53936002)(316002)(6486002)(54906003)(81166006)(478600001)(68736007)(305945005)(386003)(4744005)(6512007)(99286004)(81156014)(76176011)(1076003)(52116002)(6436002)(6506007)(8936002)(9686003)(7736002)(25786009)(105586002)(229853002)(6246003)(2906002)(8676002)(97736004)(186003)(4326008)(106356001)(6916009)(14454004)(71190400001)(446003)(71200400001)(11346002)(486006)(476003)(33656002)(46003)(256004)(102836004)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2262;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kX7YyUhaqp6Z8wmqVaKmlj+IhGwDxFPc3GCC5Pj4fWR1uipGO9TK3NQZhxlV6kjef8fONRhx/KkrIk2qWN0qsyk2/y3f2SmjAKSwaK33+zMtFxyat4xOS6e9qtwu8VGcHsGLVdijbFiyTodjUVdspdLhQYA1qHkkL2uSWQwjEpsqfm6hTpwAUR5RY/QlpavAZBXDigrdl6UrlqE1+DDyq1wtbFXgXCS0i3Lq5HZ0fiRLA6/H+vh+7WuoVfD14ZkXM1nlSaT/feWcnU1E/0NiBoFhRmGLY5oy4bQukHYoagQEeE7mY/W5wnh3GVnRTe/NO+ba8wtiGJT7QDWqZpsO3J0tnieAaggw8lTJ1ozU7s9M4P7OiDZ2fn+78JPticfDjHQ67D4LEUKUmaOgCl5bKiDymwPXVX1vK4hYhc88wOM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A029BE8C00B34E46921E29BCC8B15777@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8a58a6-10e4-4e7c-61b3-08d6a66c1bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 21:54:17.3656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2262
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:14:14PM +1100, Tobin C. Harding wrote:
> -F lists caches that support object migration.

Maybe -M?

>=20
> -C lists caches that use a ctor.
>=20
> Add command line options to show caches with a constructor and caches
> with that are migratable (i.e. have isolate and migrate functions).
>=20
> Co-developed-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  tools/vm/slabinfo.c | 40 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 4 deletions(-)

Thanks!
