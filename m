Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518BEC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 02:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5CC2133F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 02:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="b6xZIWfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDGCFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 22:05:16 -0400
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:17669
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbfDGCFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 22:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQx/HszHfjp+L/4VPNdR0K/RTaQgZJ/QDjE5a65/UXU=;
 b=b6xZIWfCKo2/xB4e9YKE5jkqt2UahQb+NkM+Md911DX6BAx3fV/SloJHvhKV+8Hei1BFsA4IgoMkJ+HVjp1EMwDMIw1BslXOVHHWunD1C5YTDGJLTYacQnGR+Lkk3JztO/8uv4FtVmKxjo+JnexgEBRLxv5NB/pwttw08wM7wJk=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB3383.eurprd05.prod.outlook.com (10.175.233.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Sun, 7 Apr 2019 02:05:10 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::cd05:875e:61bd:b480]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::cd05:875e:61bd:b480%3]) with mapi id 15.20.1771.016; Sun, 7 Apr 2019
 02:05:10 +0000
From:   Liming Sun <lsun@mellanox.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     David Woods <dwoods@mellanox.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v13] platform/mellanox: Add TmFifo driver for Mellanox
 BlueField Soc
Thread-Topic: [PATCH v13] platform/mellanox: Add TmFifo driver for Mellanox
 BlueField Soc
Thread-Index: AQHU6x3BvT3IgEW16Emk4/JJP7JsJaYttpsAgAA2COCAAf5i9A==
Date:   Sun, 7 Apr 2019 02:05:10 +0000
Message-ID: <DB6PR05MB3223F6EA9E91F2564C24F5D5A1530@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1554406595-3128-1-git-send-email-lsun@mellanox.com>
 <CAHp75VdUwn1NEpSc0_Oc4wEh0TRzCwcE0_tajg3ak8BjfZ_-Mw@mail.gmail.com>,<DB6PR05MB3223779DDDF815D2F5AFFE6BA1510@DB6PR05MB3223.eurprd05.prod.outlook.com>
In-Reply-To: <DB6PR05MB3223779DDDF815D2F5AFFE6BA1510@DB6PR05MB3223.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [75.138.166.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c607967-b50b-4031-0b8f-08d6bafd7703
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB6PR05MB3383;
x-ms-traffictypediagnostic: DB6PR05MB3383:
x-microsoft-antispam-prvs: <DB6PR05MB3383C152D3FFE47179289780A1530@DB6PR05MB3383.eurprd05.prod.outlook.com>
x-forefront-prvs: 00003DBFE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(366004)(376002)(396003)(346002)(136003)(39850400004)(13464003)(199004)(189003)(71200400001)(186003)(14454004)(86362001)(76176011)(53546011)(478600001)(66066001)(33656002)(54906003)(71190400001)(6506007)(11346002)(81166006)(81156014)(446003)(97736004)(68736007)(7696005)(93886005)(102836004)(105586002)(476003)(8676002)(106356001)(26005)(8936002)(486006)(229853002)(6246003)(6436002)(9686003)(55016002)(7736002)(53936002)(256004)(305945005)(6916009)(4326008)(25786009)(99286004)(52536014)(14444005)(316002)(74316002)(6116002)(3846002)(5660300002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3383;H:DB6PR05MB3223.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rarL/iohO0pKXcBNA0W7puvXVeSEnp63BCQ5ZvyCaWGQ3EGIM9v4pJZ83kQOLcQW4biW0xVkdeHar9ABI4UkY76AonvUSWy9CTWeqtQ+VbYNEgqVtsogEWXbaJf78/7vfqk5LjBr7SpDw4Rf1/TkE5NUsog7M/lxZ3CdDguodpY+GyawLwZkmHCuv/RFxNgfFuzUmrX38qxQMjBuk6HS8gUsZKeaO757JVY1shNHFDt5pKhBcdPuptX/d/gtdIwclYiBUAqx2RyRL8p9R5BxV56NlzybG0zOgYN88I0BmV1dL2kUbOclg8IT274S1kJl16Yfy0MXLCmIKKlDZWnzU7pELeGmUGIURzL2RjhS6f3Y3jWWw7bHzbmfd4BLfkByi4U/p3sBjFfv6YXw76JfD+J9HOqpofleGkAqu0Dy+tY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c607967-b50b-4031-0b8f-08d6bafd7703
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2019 02:05:10.3843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andy!  I just posted v14, which addresses all the comments you menti=
oned below for v13.=0A=
=0A=
Regards,=0A=
Liming=0A=
=0A=
> -----Original Message-----=0A=
> From: Andy Shevchenko <andy.shevchenko@gmail.com>=0A=
> Sent: Friday, April 5, 2019 11:44 AM=0A=
> To: Liming Sun <lsun@mellanox.com>=0A=
> Cc: David Woods <dwoods@mellanox.com>; Andy Shevchenko <andy@infradead.or=
g>; Darren Hart <dvhart@infradead.org>; Vadim=0A=
> Pasternak <vadimp@mellanox.com>; Linux Kernel Mailing List <linux-kernel@=
vger.kernel.org>; Platform Driver <platform-driver-=0A=
> x86@vger.kernel.org>=0A=
> Subject: Re: [PATCH v13] platform/mellanox: Add TmFifo driver for Mellano=
x BlueField Soc=0A=
>=0A=
> On Thu, Apr 4, 2019 at 10:36 PM Liming Sun <lsun@mellanox.com> wrote:=0A=
> > This commit adds the TmFifo platform driver for Mellanox BlueField=0A=
> > Soc. TmFifo is a shared FIFO which enables external host machine=0A=
> > to exchange data with the SoC via USB or PCIe. The driver is based=0A=
> > on virtio framework and has console and network access enabled.=0A=
>=0A=
> Thanks for an update. Almost good.=0A=
> My comments below.=0A=
>=0A=
> Meanwhile I pushed this to my review and testing queue, thanks!=0A=
>=0A=
> > +#include <linux/acpi.h>=0A=
> > +#include <linux/bitfield.h>=0A=
> > +#include <linux/circ_buf.h>=0A=
> > +#include <linux/efi.h>=0A=
> > +#include <linux/irq.h>=0A=
> > +#include <linux/module.h>=0A=
> > +#include <linux/mutex.h>=0A=
> > +#include <linux/platform_device.h>=0A=
> > +#include <linux/types.h>=0A=
>=0A=
> Perhaps blank line here. Would be more clear that this is utilizing=0A=
> virtio framework.=0A=
=0A=
Updated in v14.=0A=
=0A=
>=0A=
> > +#include <linux/virtio_config.h>=0A=
> > +#include <linux/virtio_console.h>=0A=
> > +#include <linux/virtio_ids.h>=0A=
> > +#include <linux/virtio_net.h>=0A=
> > +#include <linux/virtio_ring.h>=0A=
>=0A=
> > +/**=0A=
> > + * mlxbf_tmfifo_msg_hdr - Structure of the TmFifo message header=0A=
> > + * @type: message type=0A=
> > + * @len: payload length=0A=
> > + * @u: 64-bit union data=0A=
> > + */=0A=
> > +union mlxbf_tmfifo_msg_hdr {=0A=
> > +       struct {=0A=
> > +               u8 type;=0A=
> > +               __be16 len;=0A=
> > +               u8 unused[5];=0A=
> > +       } __packed;=0A=
> > +       u64 data;=0A=
>=0A=
> I'm not sure I understand how you can distinguish which field of union to=
 use?=0A=
> Isn't here some type missed?=0A=
=0A=
Updated the comment in v14.=0A=
=0A=
This message header is a union of struct and u64 data.=0A=
The 'struct' has=0A=
type and length field which are used to encode & decode the message. =0A=
The 'data' field is used to read/write the message header from/to the FIFO.=
=0A=
=0A=
>=0A=
> > +};=0A=
>=0A=
> > +static u8 mlxbf_tmfifo_net_default_mac[ETH_ALEN] =3D {=0A=
>=0A=
> > +       0x00, 0x1A, 0xCA, 0xFF, 0xFF, 0x01};=0A=
>=0A=
> This should be two lines.=0A=
=0A=
Updated in v14.=0A=
=0A=
>=0A=
> > +/* Supported virtio-net features. */=0A=
> > +#define MLXBF_TMFIFO_NET_FEATURES      (BIT_ULL(VIRTIO_NET_F_MTU) | \=
=0A=
> > +                                        BIT_ULL(VIRTIO_NET_F_STATUS) |=
 \=0A=
> > +                                        BIT_ULL(VIRTIO_NET_F_MAC))=0A=
>=0A=
> Better to write as=0A=
>=0A=
> #define FOO \=0A=
> (BIT(x) | BIT(y) ...)=0A=
>=0A=
> I think I told this earlier?=0A=
=0A=
Updated in v14.=0A=
=0A=
>=0A=
> > +/* Allocate vrings for the fifo. */=0A=
>=0A=
> fifo -> FIFO (and check all occurrences)=0A=
=0A=
Updated in v14.=0A=
=0A=
>=0A=
> > +static int mlxbf_tmfifo_alloc_vrings(struct mlxbf_tmfifo *fifo,=0A=
> > +                                    struct mlxbf_tmfifo_vdev *tm_vdev)=
=0A=
> > +{=0A=
> > +       struct mlxbf_tmfifo_vring *vring;=0A=
> > +       struct device *dev;=0A=
> > +       dma_addr_t dma;=0A=
> > +       int i, size;=0A=
> > +       void *va;=0A=
> > +=0A=
> > +       for (i =3D 0; i < ARRAY_SIZE(tm_vdev->vrings); i++) {=0A=
> > +               vring =3D &tm_vdev->vrings[i];=0A=
> > +               vring->fifo =3D fifo;=0A=
> > +               vring->num =3D MLXBF_TMFIFO_VRING_SIZE;=0A=
> > +               vring->align =3D SMP_CACHE_BYTES;=0A=
> > +               vring->index =3D i;=0A=
> > +               vring->vdev_id =3D tm_vdev->vdev.id.device;=0A=
> > +               dev =3D &tm_vdev->vdev.dev;=0A=
> > +=0A=
> > +               size =3D vring_size(vring->num, vring->align);=0A=
> > +               va =3D dma_alloc_coherent(dev->parent, size, &dma, GFP_=
KERNEL);=0A=
> > +               if (!va) {=0A=
>=0A=
> > +                       dev_err(dev->parent, "dma_alloc_coherent failed=
\n");=0A=
>=0A=
> I don't see how this will free the allocated entries.=0A=
> I think I told about this either.=0A=
=0A=
Updated in v14.=0A=
It's not a memory leak since the caller will release them=0A=
in case of failures. I added one line in this function to=0A=
call the mlxbf_tmfifo_free_vrings() to be more clear.=0A=
=0A=
>=0A=
> > +                       return -ENOMEM;=0A=
> > +               }=0A=
> > +=0A=
> > +               vring->va =3D va;=0A=
> > +               vring->dma =3D dma;=0A=
> > +       }=0A=
> > +=0A=
> > +       return 0;=0A=
> > +}=0A=
>=0A=
> > +/* House-keeping timer. */=0A=
> > +static void mlxbf_tmfifo_timer(struct timer_list *arg)=0A=
> > +{=0A=
>=0A=
> > +       struct mlxbf_tmfifo *fifo =3D container_of(arg, struct mlxbf_tm=
fifo,=0A=
> > +                                                timer);=0A=
>=0A=
> One line would be still good enough.=0A=
=0A=
Updated in v14.=0A=
=0A=
>=0A=
> > +       int more;=0A=
> > +=0A=
> > +       more =3D !test_and_set_bit(MLXBF_TM_RX_HWM_IRQ, &fifo->pend_eve=
nts) ||=0A=
> > +                   !test_and_set_bit(MLXBF_TM_TX_LWM_IRQ, &fifo->pend_=
events);=0A=
> > +=0A=
> > +       if (more)=0A=
> > +               schedule_work(&fifo->work);=0A=
> > +=0A=
> > +       mod_timer(&fifo->timer, jiffies + MLXBF_TMFIFO_TIMER_INTERVAL);=
=0A=
> > +}=0A=
>=0A=
> > +       status =3D efi.get_variable(mlxbf_tmfifo_efi_name, &guid, NULL,=
 &size,=0A=
> > +                                 buf);=0A=
> > +       if (status =3D=3D EFI_SUCCESS && size =3D=3D ETH_ALEN)=0A=
> > +               ether_addr_copy(mac, buf);=0A=
> > +       else=0A=
>=0A=
> > +               memcpy(mac, mlxbf_tmfifo_net_default_mac, ETH_ALEN);=0A=
>=0A=
> ether_addr_copy() as well.=0A=
=0A=
Updated in v14.=0A=
=0A=
>=0A=
> > +}=0A=
>=0A=
> > +       fifo->pdev =3D pdev;=0A=
>=0A=
> Do you really need to keep pdev there? Isn't struct device pointer enough=
?=0A=
=0A=
Not needed. Updated in v14. Thanks!=0A=
=0A=
>=0A=
>=0A=
> > +       /* Create the console vdev. */=0A=
> > +       ret =3D mlxbf_tmfifo_create_vdev(&pdev->dev, fifo, VIRTIO_ID_CO=
NSOLE, 0,=0A=
> > +                                      NULL, 0);=0A=
>=0A=
> If you define temporary variable=0A=
>   struct device *dev =3D &pdev->dev;=0A=
> these lines can be merged into one.=0A=
=0A=
Yes, updated in v14.=0A=
=0A=
>=0A=
> > +       if (ret)=0A=
> > +               goto fail;=0A=
>=0A=
> --=0A=
> With Best Regards,=0A=
> Andy Shevchenko=0A=
