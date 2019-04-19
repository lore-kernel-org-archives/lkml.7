Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D457C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BA820663
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LV9XzgT/";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="E3X3JSXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfDSTu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:50:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57078 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726173AbfDSTu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:50:27 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3JJdRKj007468;
        Fri, 19 Apr 2019 12:49:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=daTFhMCPfRY5e0lpSemsw/octXjCYfqxVw2a5UJP8b8=;
 b=LV9XzgT/fyBBB1dVRvlnNQ11V1Al3+yBB6Qw+SzJjzCn2CuL2KCVgHDZxS7NnBnokE3y
 Ba/MrqsTiPuQ3jWgJUuRl/Ag7FZYCQCRaPr2+mz9ApBrI+LLP9b78Z/U5bIUtytQh7x+
 fNq5VOWz4ZlZCGlna2oo90NtVdwx+s680e8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ryjv1ghys-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 19 Apr 2019 12:49:24 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 19 Apr 2019 12:49:23 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 19 Apr 2019 12:49:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daTFhMCPfRY5e0lpSemsw/octXjCYfqxVw2a5UJP8b8=;
 b=E3X3JSXcU6f+pC3MDf0P7hisNvll7R4Qhjd+YI4KaoWfluxersn25y0haV+DS5OHUPJsy0/9V7DhUCclOy5szl7eY+cOa+aihHu8KG4uVbhCjFpDnbkx1hnj+rBYfyEHQQNKvYX6Kzl9e6dxI2agz5Za2uUNrupaM7tW0z9a3Bg=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3256.namprd15.prod.outlook.com (20.179.57.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Fri, 19 Apr 2019 19:49:21 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e%5]) with mapi id 15.20.1792.023; Fri, 19 Apr 2019
 19:49:21 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] lib/test_vmalloc: do not create cpumask_t variable on
 stack
Thread-Topic: [PATCH 1/1] lib/test_vmalloc: do not create cpumask_t variable
 on stack
Thread-Index: AQHU9h6BEDcJgiq48kmDkFtL+5OKO6ZD5bSA
Date:   Fri, 19 Apr 2019 19:49:21 +0000
Message-ID: <20190419194914.GA31878@tower.DHCP.thefacebook.com>
References: <20190418193925.9361-1-urezki@gmail.com>
In-Reply-To: <20190418193925.9361-1-urezki@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:907:1::40) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:180f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9da27ac5-ffc7-4c1e-860d-08d6c5001de0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3256;
x-ms-traffictypediagnostic: BYAPR15MB3256:
x-microsoft-antispam-prvs: <BYAPR15MB32563E42FA6A6800E5AAC0DEBE270@BYAPR15MB3256.namprd15.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(39860400002)(376002)(396003)(189003)(199004)(486006)(11346002)(7416002)(476003)(71190400001)(1076003)(46003)(6436002)(446003)(53936002)(6246003)(71200400001)(6916009)(81166006)(81156014)(102836004)(33656002)(9686003)(6512007)(76176011)(8676002)(6486002)(66946007)(8936002)(4744005)(68736007)(229853002)(186003)(6506007)(478600001)(66556008)(14454004)(5660300002)(386003)(52116002)(97736004)(73956011)(25786009)(7736002)(1411001)(14444005)(305945005)(2906002)(99286004)(4326008)(86362001)(66446008)(316002)(256004)(66476007)(64756008)(54906003)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3256;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4wU7KqZATKTXTtSYO3Fy/ulZxROVz2bSa9OQeihEpVthwnlSxdz7yh5yHPOzlj45X+oNn7OPWCTtkI45ng8ymQDP7URTRvNIoVTZ3HvVhkzgEkCM6zgcAH+BhsLlm6N8pxFOxAN+FXQznNikfZBQJT3V80Fw4xTcosu1Cgg1OFV1BfSS04PKG48FCU/zzR0uZ7+/EYYdeqgjIV8Gqkz5fRKK7KT/gEkULocs3FFFcKMlOLU7PpV0FjYI8pKjXY6HbFDDzJnSwPRBgTiY/wR6OXKOO99PuZyzRDqFDOADp/HPd1mKUfqzXjRw0JycXfxBrk4z9423uHk55RVqu2KrVQeKrntqEE/vfQWYPMKJXsWdfB0ihDTZuDvzg/mIl0FyrDi4p7+5nb9Frcxu55AeIzu3A7WzQQDygr4axm1lwnk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0CD1E7C251F964419054F9BBF8BAE627@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da27ac5-ffc7-4c1e-860d-08d6c5001de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 19:49:21.4121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3256
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-19_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 09:39:25PM +0200, Uladzislau Rezki (Sony) wrote:
> On my "Intel(R) Xeon(R) W-2135 CPU @ 3.70GHz" system(12 CPUs)
> i get the warning from the compiler about frame size:
>=20
> <snip>
> warning: the frame size of 1096 bytes is larger than 1024 bytes
> [-Wframe-larger-than=3D]
> <snip>
>=20
> the size of cpumask_t depends on number of CPUs, therefore just
> make use of cpumask_of() in set_cpus_allowed_ptr() as a second
> argument.
>=20
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
