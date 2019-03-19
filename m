Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7965C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F12920857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aGvSZu9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfCSMIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:08:30 -0400
Received: from mail-eopbgr150070.outbound.protection.outlook.com ([40.107.15.70]:51221
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbfCSMIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKuPaP8lSFntEiALNNnt7DkKjpxC38mOcLrcCtIiWfA=;
 b=aGvSZu9KjhM5wbAiLf+sx0MCm15jgrwZ6HtWWYfEmVizdqn3oK/w+a8YNUnDzmNnjQ6ERSjdObEM1iIQc9FYoxMxy7uQVPsxXkk/FY0iXuIike2zpj/tJkxCpWaBldY6QnXoJ4cOeW0J0fZ965erxvzf6+h1dJC7vGUX2ohU8c8=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB3393.eurprd08.prod.outlook.com (20.177.110.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 12:08:26 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::7e:6dfb:116b:befd]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::7e:6dfb:116b:befd%2]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 12:08:26 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [RFC][PATCH 1/5 v2] dma-buf: Add dma-buf heaps framework
Thread-Topic: [RFC][PATCH 1/5 v2] dma-buf: Add dma-buf heaps framework
Thread-Index: AQHU05WqB1hCfZFQU0aIg8CG+/g7QqYS8b2A
Date:   Tue, 19 Mar 2019 12:08:26 +0000
Message-ID: <20190319120825.3mvdxp5saluboy7o@DESKTOP-E1NTVVP.localdomain>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-2-git-send-email-john.stultz@linaro.org>
In-Reply-To: <1551819273-640-2-git-send-email-john.stultz@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0130.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::22) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc2cc41c-84be-49ea-a42e-08d6ac639733
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3393;
x-ms-traffictypediagnostic: AM0PR08MB3393:
x-ms-exchange-purlcount: 1
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3393FE108D385DE9ADC34C9EF0400@AM0PR08MB3393.eurprd08.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(136003)(39860400002)(189003)(43544003)(199004)(9686003)(71190400001)(8936002)(71200400001)(386003)(76176011)(86362001)(102836004)(11346002)(6506007)(52116002)(44832011)(14444005)(476003)(99286004)(486006)(186003)(7736002)(256004)(6916009)(305945005)(446003)(14454004)(6116002)(54906003)(81166006)(81156014)(316002)(106356001)(8676002)(7416002)(58126008)(2906002)(478600001)(72206003)(966005)(229853002)(25786009)(3846002)(105586002)(5660300002)(68736007)(97736004)(1076003)(6306002)(4326008)(53936002)(6512007)(26005)(66066001)(6436002)(6246003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3393;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3ehzOG8rvYXFsXNZhrComBS5Q6hO2/eGOztjzeN+6LzM5BKorcg0+n3NA8dNmSiMFH6Fd91y5a9ZpkS38F8FRJeyQzquKWzrq5hoPo4M62US03T68ONyeU0xT7y2Ygxmu29zDYQh+QHf7H53NEYeJW9kvkzMN+Uqsl97DcdnjYA1FycNFCzIX65ZCJNP9SYmSXZbqM96o7RUTwAbwJAIn/icGdztyIRDwvajq8yKu2RZkuY97k08TkWXIENnFDJzrAeeYd6QPvW86X3MUtt163G7PZnWstZQlWD0xTA24/s7Kn9Nnapq/optBP/+n1Lz3lkEx78/Zc+btdrjRwUoPiiTzgm8PwSsLk9ZwfSnYTumULuYVAzDII39e0D9Y835SYUq05sEQyiS9M+dHwn0AjSwK9MeFV9p1gWxo7NyPOM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47CB2493646EAA4C82B3583D17819BBE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2cc41c-84be-49ea-a42e-08d6ac639733
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 12:08:26.0579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3393
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Tue, Mar 05, 2019 at 12:54:29PM -0800, John Stultz wrote:
> From: "Andrew F. Davis" <afd@ti.com>

[snip]

> +
> +#define NUM_HEAP_MINORS 128
> +static DEFINE_IDR(dma_heap_idr);
> +static DEFINE_MUTEX(minor_lock); /* Protect idr accesses */

I saw that Matthew Wilcox is trying to nuke idr:
https://patchwork.freedesktop.org/series/57073/

Perhaps a different data structure could be considered? (I don't have
an informed opinion on which).

> +
> +dev_t dma_heap_devt;
> +struct class *dma_heap_class;
> +struct list_head dma_heap_list;
> +struct dentry *dma_heap_debug_root;
> +
> +static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> +				 unsigned int flags)
> +{
> +	len =3D PAGE_ALIGN(len);
> +	if (!len)
> +		return -EINVAL;

I think aligning len to pages only makes sense if heaps are going to
allocate aligned to pages too. Perhaps that's an implicit assumption?
If so, lets document it.

Why not let the heaps take care of aligning len however they want
though?

...

> +
> +int dma_heap_add(struct dma_heap *heap)
> +{
> +	struct device *dev_ret;
> +	int ret;
> +
> +	if (!heap->name || !strcmp(heap->name, "")) {
> +		pr_err("dma_heap: Cannot add heap without a name\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!heap->ops || !heap->ops->allocate) {
> +		pr_err("dma_heap: Cannot add heap with invalid ops struct\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Find unused minor number */
> +	mutex_lock(&minor_lock);
> +	ret =3D idr_alloc(&dma_heap_idr, heap, 0, NUM_HEAP_MINORS, GFP_KERNEL);
> +	mutex_unlock(&minor_lock);
> +	if (ret < 0) {
> +		pr_err("dma_heap: Unable to get minor number for heap\n");
> +		return ret;
> +	}
> +	heap->minor =3D ret;
> +
> +	/* Create device */
> +	heap->heap_devt =3D MKDEV(MAJOR(dma_heap_devt), heap->minor);
> +	dev_ret =3D device_create(dma_heap_class,
> +				NULL,
> +				heap->heap_devt,
> +				NULL,
> +				heap->name);
> +	if (IS_ERR(dev_ret)) {
> +		pr_err("dma_heap: Unable to create char device\n");
> +		return PTR_ERR(dev_ret);
> +	}
> +
> +	/* Add device */
> +	cdev_init(&heap->heap_cdev, &dma_heap_fops);
> +	ret =3D cdev_add(&heap->heap_cdev, dma_heap_devt, NUM_HEAP_MINORS);

Shouldn't this be s/dma_heap_devt/heap->heap_devt/ and a count of 1?

Also would it be better to have cdev_add/device_create the other way
around? First create the char device, then once it's all set up
register it with sysfs.

> +	if (ret < 0) {
> +		device_destroy(dma_heap_class, heap->heap_devt);
> +		pr_err("dma_heap: Unable to add char device\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(dma_heap_add);

Until we've figured out how modules are going to work, I still think
it would be a good idea to not export this.

Cheers,
-Brian

