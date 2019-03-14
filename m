Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240E1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71C320854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="nsl3P9XZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfCNVjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 17:39:11 -0400
Received: from mail-eopbgr130047.outbound.protection.outlook.com ([40.107.13.47]:30086
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726731AbfCNVjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 17:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z80iAsc7UcR6LpoNEq/jtLvi/7m0aLrqNj99RH8Fg+U=;
 b=nsl3P9XZ/0rD/9Yfpn82WHQVYn87mQaXd+yT0epy4lG2lefcNohD5CfLTm5Yt4OOTKzfYqAeAOBAIJYwE3hoO39Er935OTYqXnCcVl+/3TOnNuNeeBqThXioONuyycDqZ6u9TFPQv514vO+cLwGJmt8KWnL1MQG8E/ca3sYVthM=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2399.eurprd05.prod.outlook.com (10.168.135.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.20; Thu, 14 Mar 2019 21:38:53 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 21:38:53 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jiri Pirko <jiri@mellanox.com>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        Vu Pham <vuhuong@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [RFC net-next v1 0/3] Support mlx5 mediated devices in host
Thread-Topic: [RFC net-next v1 0/3] Support mlx5 mediated devices in host
Thread-Index: AQHU1ftxoq/20NoyU02DSUADWZ4DWKYKJn4AgAGFZKA=
Date:   Thu, 14 Mar 2019 21:38:53 +0000
Message-ID: <VI1PR0501MB2271E31103727546484AB834D14B0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1552082876-60228-1-git-send-email-parav@mellanox.com>
 <20190313150804.3702ae47@cakuba.netronome.com>
In-Reply-To: <20190313150804.3702ae47@cakuba.netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d832070e-6651-4dde-0cf8-08d6a8c57496
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2399;
x-ms-traffictypediagnostic: VI1PR0501MB2399:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR0501MB2399;23:Oa/LHYomlRiYZRiYiwZHRMfQaCWzJO8b1VisT14?=
 =?us-ascii?Q?4w+SkvewRu8GHkKZQalctSteUxOhf/+VWwA7I9uXl4y8B4ppziAtlofHckeA?=
 =?us-ascii?Q?HSbJqp5aLOoTASS4fSrQhNyou0J6R65a5Soz/NrN9aP00nfX8mhoGXH93I3Q?=
 =?us-ascii?Q?9WqIHgIfjSJYvdPFc67Hjnm2ukQ6fH9c3QJL1F5eLPCNyNMXBx+mVytzIntj?=
 =?us-ascii?Q?RWQQe39DKzG6cbYedoKe+H/4f5T1ED+4zBOehC70alArxdzEajQIixQCDw4N?=
 =?us-ascii?Q?bZ8LYGQO2uodN8bJDuBhAuVrndFVjXr70dhd+rvKIbADfXy+pgPpjaTUUva5?=
 =?us-ascii?Q?9MUUt0YyH2C3QPt7pC3VNb2Cxq20uhiJrZc/kmR23V8KpYF8YT76fIEW9m92?=
 =?us-ascii?Q?2KGjL1xNzxGXQVE6lmRh8nyDyaluDXs8/F60zDUKUAKzk5IPn5MNViKiR5Vk?=
 =?us-ascii?Q?rHcT6shBUUSi5sD8plTcG+Vm51oV4b2IqmDckznikjKfUSAhF4+hjJnwi17v?=
 =?us-ascii?Q?D9fAcf7E58CDmE9egXr1LB5SM3/3mnkjXI8TOJAvoGQowbTx2VoH3kaSLYam?=
 =?us-ascii?Q?Y1XWrqy27xw4TTw1eoU75wj4Dq9GIoXEzsn7pXsx6Tzf2KLOQixbeC+ww2+f?=
 =?us-ascii?Q?mD8YYg9UGKnogN5JWI+Tz4FuFCQrHs7TGk0aq3jUmYTdVBFEkW7g8ctoXdOt?=
 =?us-ascii?Q?/9FoctnrwcjsOXSrDusLFTdpp3o0vXeoPIg6NpcwxMkseBoVdJhMGKnGtme0?=
 =?us-ascii?Q?TBfYJJivm0/wh33o+/aEGvx0Vo2Z4GwIqxGj4IVkT/8HUI+bje0OfVWV37Uu?=
 =?us-ascii?Q?esMFePkQcVTj6V0sfa8g4QL6vcl33EpQ0SoKDs8lz1ELPBNKS/ep1RvTHXB/?=
 =?us-ascii?Q?9/xPI51MmrZZD2Zbv44ogpDJIAPq5NFmZlzmfMAhSJCjftXUQHmEQPOgDSKE?=
 =?us-ascii?Q?b2oP0GU6TrQWtaxCaRqtejdGkwNJG9if9lobEngu7jDq2RZRkl/OfSrdKyBj?=
 =?us-ascii?Q?ywoTypfflFyYmuIB1oXMwoxj0gxbjUmYDe/ibh+hyzKphhRFjXBoaFFzTha+?=
 =?us-ascii?Q?GzSA5wzOnERbVgxPgVLEPeNqOVQGNCorj82zukpcuyHrZUkyKCLkUbzRqNIQ?=
 =?us-ascii?Q?gYD4ZVWHruj2BY2IncNK8wmhkQpuW5OUs0tGz8dlgUqGL3A/dpjPglY6aJiN?=
 =?us-ascii?Q?TjDiVLj6UkLB+i60uRw5N8UztP4UmqgcLRCB/X2DRq8r8jURG19YWZLwL8MS?=
 =?us-ascii?Q?nKamstMAqEHhW4jzj8UfOT5Nyh0qzk943/LmIucdiRkUi9zFzd/1d+hXlP0L?=
 =?us-ascii?Q?oyg=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR0501MB23998AAD90A20D76CFBDC139D14B0@VI1PR0501MB2399.eurprd05.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(366004)(376002)(396003)(13464003)(199004)(189003)(476003)(102836004)(6116002)(26005)(5660300002)(186003)(11346002)(3846002)(256004)(486006)(6506007)(53546011)(7696005)(99286004)(14444005)(76176011)(71200400001)(71190400001)(52536014)(316002)(54906003)(5024004)(33656002)(105586002)(8936002)(81166006)(106356001)(81156014)(8676002)(4326008)(74316002)(6916009)(305945005)(68736007)(446003)(66066001)(97736004)(7736002)(25786009)(6246003)(478600001)(2906002)(6436002)(53936002)(55016002)(229853002)(14454004)(9686003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2399;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /gK+uSpSV1ZPhHUXuUlgNnGR1QjicuHDSFbtZXsZZmi9Zy87z4u5X3kioeGpZlWGhm5o8eOrM345qyEd0CeIoabrDQzz7MkgmRH1P+UFc9KqeNnbJ9Bubw6gRIq1/jZkahPZ/yUhXyaKPOy+Ik0rVZcBtQlZEQvJHGcodkEaE13HIQ7c6DUFHPcIfzlyFLhd7j0EZsr/qBPXE+e/+DzYaBHqakZHhpVrU9LbtT4SClCvESvREITABt13HRNb9MlcZ48yWVL8nXn9pwIMIEvM9VbTUuRtKey1pZN7t4rTXlg9shlfoZderc7LVFU5rheGsxXa/hdFxMgphhhoIIx0lP/umSkZn0W7VhsSB1INYLjCJWIYEblymaa7fRNZiADmr7BcpAYXa7gxSeo30gPzrNzKXOBKpUg01sXUmlzHP+o=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d832070e-6651-4dde-0cf8-08d6a8c57496
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 21:38:53.1072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2399
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

> -----Original Message-----
> From: Jakub Kicinski <jakub.kicinski@netronome.com>
> Sent: Wednesday, March 13, 2019 5:08 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> michal.lkml@markovi.net; davem@davemloft.net;
> gregkh@linuxfoundation.org; Jiri Pirko <jiri@mellanox.com>;
> kwankhede@nvidia.com; alex.williamson@redhat.com; Vu Pham
> <vuhuong@mellanox.com>; Yuval Avnery <yuvalav@mellanox.com>;
> kvm@vger.kernel.org
> Subject: Re: [RFC net-next v1 0/3] Support mlx5 mediated devices in host
>=20
> On Fri,  8 Mar 2019 16:07:53 -0600, Parav Pandit wrote:
> > Use case:
> > ---------
> > A user wants to create/delete hardware linked sub devices without
> > using SR-IOV.
> > These devices for a pci device can be netdev (optional rdma device) or
> > other devices. Such sub devices share some of the PCI device resources
> > and also have their own dedicated resources.
> > A user wants to use this device in a host where PF PCI device exist.
> > (not in a guest VM.) A user may want to use such sub device in future
> > in guest VM.
> >
> > Few examples are:
> > 1. netdev having its own txq(s), rq(s) and/or hw offload parameters.
> > 2. netdev with switchdev mode using netdev representor
>=20
> Hi Parav!
>=20
> Sorry for going quiet, I'm hoping to clarify the use cases and the devlin=
k part
> on the other thread with Jiri, and then come back to implementation detai=
ls.
>=20
That's fine. Now we have detached two things so we don't need to create med=
iated devices etc through devlink anymore.
It is not just implementation details here in RFC.
RFC describes the single and multiport use cases and attachment with devlin=
k too.
It uses existing well defined devlink objects.
So I am not envisioning a big change.

> > 3. rdma device with IB link layer and IPoIB netdev 4. rdma/RoCE device
> > and a netdev 5. rdma device with multiple ports
