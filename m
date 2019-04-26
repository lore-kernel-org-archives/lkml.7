Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F315CC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78272084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ZYKRoWsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfDZMY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:24:29 -0400
Received: from mail-eopbgr700053.outbound.protection.outlook.com ([40.107.70.53]:65249
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbfDZMY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxL0zrHAuNtM/IxDnD1yqD8fj/cxgVuzz75O7+Q8FaE=;
 b=ZYKRoWsJPXgVsGYpZxOz9aaDYj6r051mRbclS2w2ipP8g0wMcBMrIEBq5Nb+mutIth2kh30ycgsTqoDc2g0Ud0R3sYmf99kc/uZ7B0DHnRVMPNnK8BxJOKHnjOMOnHrjJmxe0DN1GpsTR/sDDGeOsR/QbvtpJYExarlwMheS5Bg=
Received: from BL0PR02MB5681.namprd02.prod.outlook.com (20.177.241.92) by
 BL0PR02MB4707.namprd02.prod.outlook.com (20.177.144.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.14; Fri, 26 Apr 2019 12:24:25 +0000
Received: from BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::9872:12d3:6703:84cd]) by BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::9872:12d3:6703:84cd%2]) with mapi id 15.20.1813.017; Fri, 26 Apr 2019
 12:24:25 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>, Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: RE: [PATCH V2 02/12] misc: xilinx-sdfec: add core driver
Thread-Topic: [PATCH V2 02/12] misc: xilinx-sdfec: add core driver
Thread-Index: AQHU7rwA7vq/I9ep7Eapo+KTqPE4RqZNbK8AgADZIGA=
Date:   Fri, 26 Apr 2019 12:24:25 +0000
Message-ID: <BL0PR02MB5681309AC6C61CF78263E3EDCB3E0@BL0PR02MB5681.namprd02.prod.outlook.com>
References: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
 <1554804414-206099-3-git-send-email-dragan.cvetic@xilinx.com>
 <20190425202552.GB22307@kroah.com>
In-Reply-To: <20190425202552.GB22307@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3fd8510-1ddd-4d8a-71c2-08d6ca421ef0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BL0PR02MB4707;
x-ms-traffictypediagnostic: BL0PR02MB4707:
x-microsoft-antispam-prvs: <BL0PR02MB4707DAFA8C20C1B0FED082E8CB3E0@BL0PR02MB4707.namprd02.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(136003)(346002)(13464003)(189003)(199004)(66066001)(99286004)(74316002)(7736002)(71190400001)(71200400001)(66556008)(66476007)(305945005)(66446008)(64756008)(7696005)(76116006)(66946007)(73956011)(6916009)(256004)(229853002)(14444005)(52536014)(53936002)(54906003)(86362001)(5660300002)(68736007)(6436002)(55016002)(9686003)(11346002)(81156014)(8676002)(486006)(53546011)(81166006)(8936002)(316002)(446003)(6506007)(76176011)(2906002)(476003)(25786009)(186003)(33656002)(6116002)(3846002)(26005)(478600001)(107886003)(14454004)(6246003)(102836004)(4326008)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4707;H:BL0PR02MB5681.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PAjJ4jkW6g4om7IM9S4t6dIaGeeOcJzemZbR0WHkhZIUrTWULwNCVykaaxqGJKgfZIQXgdvzfElzTKLcntY1ERusrHYro+73BQETjrD5duLdEj9llktr4eeyhL+K9TNRgCt8ZB4ZyBjx496Cdw/GlAnkOCGGlzPzLhoZuDEiR/vjlf1sZ4yBL7fS5oqNRpOk2hhYuaa0Og2Pl8E4jfWtfZ47NIEBF7NPF0S7wXYCYVibF9qwIzHEhRhxx/x/JMpDFEZpbL++V1x1R8pxAq5wA0sSyICGa4VEbXLJocv8EOsi8OHJqFqfswsdyEDi1LX8TU2+juSXrkIg/HfKYaQoJt71gvvDzzp4OC8iml0Gv5Etl3I5P/RnjwzK92neKPvQqAlRPGrS36Mb4FQPHrlqxzPvSSfulIwzYrbuAzT9QqI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fd8510-1ddd-4d8a-71c2-08d6ca421ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 12:24:25.3519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,


Please find my inline comments below.




> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday 25 April 2019 21:26
> To: Dragan Cvetic <draganc@xilinx.com>
> Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@li=
sts.infradead.org; linux-kernel@vger.kernel.org; Derek
> Kiernan <dkiernan@xilinx.com>
> Subject: Re: [PATCH V2 02/12] misc: xilinx-sdfec: add core driver
>=20
> On Tue, Apr 09, 2019 at 11:06:44AM +0100, Dragan Cvetic wrote:
> > +++ b/include/uapi/misc/xilinx_sdfec.h
> > @@ -0,0 +1,42 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
>=20
> That is not the proper SPDX license for a UAPI kernel header file :(
>=20
> Please fix this up.


I will put /* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
Thanks.


>=20
> Also, why do you need a uapi file at all?  Who is using these values?
>=20

These values are descriptors of the SD-FEC HW and its state, they will be u=
sed by the user space API.
Please advise.



> > +/*
> > + * Xilinx SD-FEC
> > + *
> > + * Copyright (C) 2016 - 2017 Xilinx, Inc.
> > + *
> > + * Description:
> > + * This driver is developed for SDFEC16 IP. It provides a char device
> > + * in sysfs and supports file operations like open(), close() and ioct=
l().
> > + */
> > +#ifndef __XILINX_SDFEC_H__
> > +#define __XILINX_SDFEC_H__
> > +
> > +/**
> > + * enum xsdfec_state - State.
> > + * @XSDFEC_INIT: Driver is initialized.
> > + * @XSDFEC_STARTED: Driver is started.
> > + * @XSDFEC_STOPPED: Driver is stopped.
> > + * @XSDFEC_NEEDS_RESET: Driver needs to be reset.
> > + * @XSDFEC_PL_RECONFIGURE: Programmable Logic needs to be recofigured.
> > + *
> > + * This enum is used to indicate the state of the driver.
> > + */
> > +enum xsdfec_state {
> > +	XSDFEC_INIT =3D 0,
> > +	XSDFEC_STARTED,
> > +	XSDFEC_STOPPED,
> > +	XSDFEC_NEEDS_RESET,
> > +	XSDFEC_PL_RECONFIGURE,
> > +};
> > +
> > +/**
> > + * struct xsdfec_config - Configuration of SD-FEC core.
> > + * @fec_id: ID of SD-FEC instance. ID is limited to the number of acti=
ve
> > + *          SD-FEC's in the FPGA and is related to the driver instance
> > + *          Minor number.
> > + */
> > +struct xsdfec_config {
> > +	s32 fec_id;
>=20
> What is this structure for and why are you telling userspace about it?
> If you are telling userspace about it, you are using the wrong data
> type :(


My mistake, I should use __s32, I'll fix all of them.


>=20
> thanks,
>=20
> greg k-h


Thank you
Dragan

