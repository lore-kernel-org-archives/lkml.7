Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E90C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C85214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jZAQSS6v";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Ui3ZsfSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfCKVX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:23:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41686 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727008AbfCKVX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:23:58 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2BLIh7t015533;
        Mon, 11 Mar 2019 14:23:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=0VHe4V9iGcaua732RtUpDFHFgGRYc3j4n5V6/hihZJs=;
 b=jZAQSS6vftlwDe0r8HeqUg+YJ/5qmlWwEE8yr3OuFLeLkf/RtzohKJUrE4WVV0Ol4Jgn
 d0nEo45si2YnNxxYuF5QBrFfrbjEevunyBBa07U9PNgfzyk0sAVBWD9EBDj1oF6IbnyL
 8eW0yicupGLvCuEGnn9s6VL5WV3ppHFvTlw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2r5y6g82m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Mar 2019 14:23:45 -0700
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 14:23:29 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Mar 2019 14:23:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VHe4V9iGcaua732RtUpDFHFgGRYc3j4n5V6/hihZJs=;
 b=Ui3ZsfSNLe7W8lEhgCSpXFljc7JdUi9pbhAUvXcNX36fPDBzm3tfAPykLvQDm6LaOamLsUQGWajsRl7RwtFfahV/5urPjbQAvQpNvCyXJFwAWKlPjK2MPrgpWCUItM3//QzbhYtgqD2lmB8eYu6I6cP/Kpv/CEj3niJHBKBXOz0=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2632.namprd15.prod.outlook.com (20.179.156.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 21:23:27 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 21:23:27 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Tobin C. Harding" <tobin@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 01/15] slub: Create sysfs field /sys/slab/<cache>/ops
Thread-Topic: [RFC 01/15] slub: Create sysfs field /sys/slab/<cache>/ops
Thread-Index: AQHU1WWJSvHJgpw2R0OQb90UQnNxQKYG9oWA
Date:   Mon, 11 Mar 2019 21:23:27 +0000
Message-ID: <20190311212316.GA4581@tower.DHCP.thefacebook.com>
References: <20190308041426.16654-1-tobin@kernel.org>
 <20190308041426.16654-2-tobin@kernel.org>
In-Reply-To: <20190308041426.16654-2-tobin@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1401CA0014.namprd14.prod.outlook.com
 (2603:10b6:301:4b::24) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:b487]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 916fcd9d-ef96-4136-0adc-08d6a667cd06
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2632;
x-ms-traffictypediagnostic: BYAPR15MB2632:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2632;20:4eLbDy7U7bhoMvcms5bebKF7jdvsyqNdySF72e0IStnfGsGgwBhDCp/dwdKZv+ecUZIq1jSenbk/3IY/kWIPfG+3ztI5h7u17pkcWMPKWlFZMZ6vMeW2wsuy3//ntsw4UcN1/r/9AZ94JiSvr3bmSdYed6W4XAN1+sS6cmyooH4=
x-microsoft-antispam-prvs: <BYAPR15MB263270839E30FA4BCD3614EABE480@BYAPR15MB2632.namprd15.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(346002)(39860400002)(189003)(199004)(86362001)(478600001)(105586002)(7736002)(14454004)(6916009)(8936002)(6506007)(71200400001)(6246003)(5660300002)(11346002)(386003)(316002)(4326008)(446003)(76176011)(305945005)(106356001)(81156014)(81166006)(71190400001)(8676002)(9686003)(53936002)(68736007)(6512007)(6486002)(25786009)(186003)(52116002)(6436002)(486006)(1076003)(229853002)(54906003)(6116002)(476003)(2906002)(97736004)(46003)(102836004)(33656002)(99286004)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2632;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Jp7hegtA/gKVW4RDleJifdSpv0DliUdH+H0T6SPeFyHzeJXkuO7t0spDgGpmdfTfZ4UVh5vSHxaVzt1MQ6W6DwhmhJy9pDtG3Fu4s8CrAHIKwxc5ysguM9S3UlQlV/ANDCCDnqxDb5f94UgfFeKmjDalqf4KGpLdVEH0tJ9a0T9AP+vpaGGMi0LFjWoBeXbeB8N6oSH+gFUXZQTLMQ+IV/m70LQ/4rX+ENG7j4HT1wWXz6k1VTAbQl+UPvdzTBSJGFXmdfwmyLZo9Dgkh74j+dyNxOUd8meDvaVa0jbjCO+b7/OU6fYwbP0kmVv/Jf02e7+2/FB78247kUla2axpDeOp1dlM3CMxTeOtOeOxNrmB7SNzAqKaF7R5cIaXNDRJfMCWsor9r8TgG7qFN06Ux6XDvRJGxJ7+iWfl+SMl9nQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EECCF5440A2E6941B26DCFC69FEF05CC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 916fcd9d-ef96-4136-0adc-08d6a667cd06
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 21:23:27.3523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2632
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:14:12PM +1100, Tobin C. Harding wrote:
> Create an ops field in /sys/slab/*/ops to contain all the callback
> operations defined for a slab cache. This will be used to display
> the additional callbacks that will be defined soon to enable movable
> objects.
>=20
> Display the existing ctor callback in the ops fields contents.
>=20
> Co-developed-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Hi Tobin!

> ---
>  mm/slub.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/mm/slub.c b/mm/slub.c
> index dc777761b6b7..69164aa7cbbf 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5009,13 +5009,18 @@ static ssize_t cpu_partial_store(struct kmem_cach=
e *s, const char *buf,
>  }
>  SLAB_ATTR(cpu_partial);
> =20
> -static ssize_t ctor_show(struct kmem_cache *s, char *buf)
> +static ssize_t ops_show(struct kmem_cache *s, char *buf)
>  {
> +	int x =3D 0;
> +
>  	if (!s->ctor)
>  		return 0;
        ^^^^^^^^^^^^^^^^^
You can drop this part, can't you?

Also, it's not clear (without looking into following patches) why do you
make this refactoring. So, please, add a note, or move this change into
the patch 3.

Thanks!
