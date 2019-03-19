Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA288C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDB420651
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="a9q+XmUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfCSO0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:26:08 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:58689
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726763AbfCSO0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnWp0qZgwast77phnzar2zM6q7GrowXZv5JfvECzEWk=;
 b=a9q+XmUHLggZvGheKeqnB2exIdYwJuz+EfpDTnNNVlIYMQfSa98k5SzyrU0iPcanRZM2wkAXwqCIOiwxeQZgnNJSBc7zJC7qIQxqgmiX8J81jS9X889GU382ONBLVyM0juuLQPYOogWDw5dws9BJ4tSM83+yqEfet0Y1Ga7gZKo=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB5124.eurprd08.prod.outlook.com (10.255.30.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 14:26:05 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::7e:6dfb:116b:befd]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::7e:6dfb:116b:befd%2]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 14:26:05 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [RFC][PATCH 2/5 v2] dma-buf: heaps: Add heap helpers
Thread-Topic: [RFC][PATCH 2/5 v2] dma-buf: heaps: Add heap helpers
Thread-Index: AQHU05WrkUl096+RLU6lpJhX2SYydaYTGDIA
Date:   Tue, 19 Mar 2019 14:26:05 +0000
Message-ID: <20190319142604.f6puq3ugxrcxsrjs@DESKTOP-E1NTVVP.localdomain>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-3-git-send-email-john.stultz@linaro.org>
In-Reply-To: <1551819273-640-3-git-send-email-john.stultz@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0106.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::22) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64b42786-6fc7-46c7-028c-08d6ac76d200
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB5124;
x-ms-traffictypediagnostic: AM0PR08MB5124:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB5124F1A4C2C58BC19FC3E218F0400@AM0PR08MB5124.eurprd08.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(376002)(136003)(189003)(199004)(9686003)(11346002)(25786009)(7416002)(5660300002)(6916009)(386003)(52116002)(102836004)(186003)(26005)(6512007)(76176011)(53936002)(3846002)(44832011)(6246003)(8936002)(4744005)(1076003)(4326008)(229853002)(6116002)(6506007)(71200400001)(81166006)(54906003)(81156014)(71190400001)(106356001)(6436002)(105586002)(446003)(2906002)(68736007)(7736002)(86362001)(478600001)(72206003)(486006)(99286004)(6486002)(8676002)(256004)(476003)(305945005)(66066001)(14454004)(97736004)(316002)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5124;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u5BXbpR1VkpH+Nu80r+Ipv7mT2fStayjn8u62OemAwizxjq8rTgDBV2V+hKTR+2XMgfatCjqD4lYQ5b7NRmrEC8aX20ajSpHdt+8i/WNl+HcIbLXH9xjOfjOp1T9tnEUtiwSLZxZ2eUczznPcZLAjW2GoEjmdBKmexf/PmWA0KNeN0xFLhpUsQEBW18TOMvn63vU3TpJ8eUpgjv+osehuvbQTtWc3tV6oeelEpyS+y0DlhwviE5LDUS0pPNB+g1TN+n8aB3Pf2OkcJl8dj5PWbr530g95/UvYozCymqQ0RL9GCgJ7eCdGHYdIOqjgjJ63PBrERIjM0xYalYLeRBSRbe4u6ccpX+oBm0vYmE7g7kDTSg9GyB/3cJlIotSSGZVGsCfrJ9SZunpxuPU8K2U8Hqcs8PeR5OfYLjvWGyZq7U=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D01BE0455B90EB46A48E7E9C442B13CB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b42786-6fc7-46c7-028c-08d6ac76d200
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 14:26:05.2000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Tue, Mar 05, 2019 at 12:54:30PM -0800, John Stultz wrote:

...

> +
> +void dma_heap_buffer_destroy(struct dma_heap_buffer *heap_buffer)
> +{
> +	struct heap_helper_buffer *buffer =3D to_helper_buffer(heap_buffer);
> +
> +	if (buffer->kmap_cnt > 0) {
> +		pr_warn_once("%s: buffer still mapped in the kernel\n",
> +			     __func__);

Could be worth something louder like a full WARN.

> +		vunmap(buffer->vaddr);
> +	}
> +
> +	buffer->free(buffer);
> +}
> +

...

> +
> +static void *dma_heap_dma_buf_kmap(struct dma_buf *dmabuf,
> +					unsigned long offset)
> +{
> +	struct dma_heap_buffer *heap_buffer =3D dmabuf->priv;
> +	struct heap_helper_buffer *buffer =3D to_helper_buffer(heap_buffer);
> +
> +	return buffer->vaddr + offset * PAGE_SIZE;

I think it'd be good to check for NULL vaddr and return NULL in that
case. Less chance of an invalid pointer being accidentally used then.

Thanks,
-Brian
