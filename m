Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B073DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E69206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="5BW0xqto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfCSKc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:32:27 -0400
Received: from mail-eopbgr800085.outbound.protection.outlook.com ([40.107.80.85]:31168
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726244AbfCSKc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmxJBv65vlFi7p7WNKJLwNNLaMEGcdh/Br821x2Fns8=;
 b=5BW0xqtoC0dNcQpkoagKVmo5NOezHrF/Cdx5ZacaRT8MgQkCRhFwSe7Zp8555EyWX191oUTOOFNdPXOm6vxd3+Xw+y/domp28EzVivkPZxdD/BsraQFiFbwqH5aDlvdUKkJeDl0XXqfs+UdXITKG3482PYKIBfScDuakt517/dE=
Received: from DM5PR02MB2187.namprd02.prod.outlook.com (10.168.173.137) by
 DM5PR02MB3274.namprd02.prod.outlook.com (10.164.148.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Tue, 19 Mar 2019 10:32:18 +0000
Received: from DM5PR02MB2187.namprd02.prod.outlook.com
 ([fe80::2d7f:9bf0:24c2:5c57]) by DM5PR02MB2187.namprd02.prod.outlook.com
 ([fe80::2d7f:9bf0:24c2:5c57%6]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 10:32:18 +0000
From:   Appana Durga Kedareswara Rao <appanad@xilinx.com>
To:     Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Alan Tull <atull@opensource.altera.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH 2/2] fpga: add FPGA manager debugfs
Thread-Topic: [PATCH 2/2] fpga: add FPGA manager debugfs
Thread-Index: AQHUNOS5awrxgisErE6UaAEcY42nI6YUEw0wgAABCdA=
Date:   Tue, 19 Mar 2019 10:32:18 +0000
Message-ID: <DM5PR02MB2187DA7C6F4DFAA680DE75CDDC400@DM5PR02MB2187.namprd02.prod.outlook.com>
References: <20180815220958.3606-1-atull@kernel.org>
 <20180815220958.3606-2-atull@kernel.org>
 <DM5PR02MB21872F4FF3749AFBD38B0075DC400@DM5PR02MB2187.namprd02.prod.outlook.com>
In-Reply-To: <DM5PR02MB21872F4FF3749AFBD38B0075DC400@DM5PR02MB2187.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=appanad@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 734ee7ea-0cff-4867-280b-08d6ac56299c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR02MB3274;
x-ms-traffictypediagnostic: DM5PR02MB3274:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM5PR02MB3274728D8715B1F64D541D85DC400@DM5PR02MB3274.namprd02.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(366004)(396003)(346002)(13464003)(189003)(199004)(30864003)(256004)(55016002)(478600001)(229853002)(14454004)(6246003)(2906002)(105586002)(93156006)(106356001)(68736007)(14444005)(9686003)(71200400001)(86362001)(71190400001)(11346002)(66066001)(476003)(446003)(486006)(52536014)(6436002)(53936002)(5660300002)(6506007)(2940100002)(81156014)(81166006)(8936002)(8676002)(7736002)(186003)(74316002)(33656002)(305945005)(7416002)(6116002)(97736004)(99286004)(54906003)(4326008)(7696005)(26005)(316002)(76176011)(25786009)(3846002)(102836004)(110136005)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3274;H:DM5PR02MB2187.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pBSklbqqLFAO5xodbyiABtgIa810ScEZdotkcDvuwU1YS2CeGGDLY3YVGBtGFKQXolKAEAYkbOILWr+X9ubv4Qrd4qybkeLi1ZVkTAlXs5GbICO5p6nSsmQdbN8MsNNDf4P1C1nG5H7DOlRFMbrvNg2NfN70lfsdz5dy9rtXC627VSvrZ8qzG2C0/G4Osh/WqPb4bmVuw5QiJOujSkDOTdxJ648Lhs1TbOYtAaszFa3mmFVP6X3m1wybDt3cioXc8O3lnHfLXCBkUM2utr/aprEKktlvcXs+uYE/VZxjLSgf6fAJNzyOHjcuUxCo5x3+EAoP0Ytp/zhAgTrYk0BhDzmV0eiLZapaNN/7pckIGXq/UUZaCwqYEwpRBns5zKmIJQJ8tec0L0MdHt5G8Z58s7GJDMerFnx43THC/EuVD0k=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734ee7ea-0cff-4867-280b-08d6ac56299c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 10:32:18.3667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3274
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this mail....

Regards,
Kedar.

> -----Original Message-----
> From: Appana Durga Kedareswara Rao
> Sent: Tuesday, March 19, 2019 3:58 PM
> To: 'Alan Tull' <atull@kernel.org>; Moritz Fischer <mdf@kernel.org>; Jona=
than
> Corbet <corbet@lwn.net>; Randy Dunlap <rdunlap@infradead.org>; Dinh
> Nguyen <dinguyen@kernel.org>
> Cc: linux-kernel@vger.kernel.org; linux-fpga@vger.kernel.org; linux-
> doc@vger.kernel.org; Alan Tull <atull@opensource.altera.com>; Matthew
> Gerlach <matthew.gerlach@linux.intel.com>
> Subject: RE: [PATCH 2/2] fpga: add FPGA manager debugfs
>=20
> FYI...
>=20
> Regards,
> Kedar.
>=20
> > -----Original Message-----
> > From: Alan Tull <atull@kernel.org>
> > Sent: Thursday, August 16, 2018 3:40 AM
> > To: Moritz Fischer <mdf@kernel.org>; Jonathan Corbet <corbet@lwn.net>;
> > Randy Dunlap <rdunlap@infradead.org>; Dinh Nguyen
> > <dinguyen@kernel.org>
> > Cc: Appana Durga Kedareswara Rao <appanad@xilinx.com>; linux-
> > kernel@vger.kernel.org; linux-fpga@vger.kernel.org; linux-
> > doc@vger.kernel.org; Alan Tull <atull@kernel.org>; Alan Tull
> > <atull@opensource.altera.com>; Matthew Gerlach
> > <matthew.gerlach@linux.intel.com>
> > Subject: [PATCH 2/2] fpga: add FPGA manager debugfs
> >
> > From: Alan Tull <atull@opensource.altera.com>
> >
> > Implement DebugFS for the FPGA Manager Framework for debugging and
> > developmental use.
> >
> > Enabled by CONFIG_FPGA_MGR_DEBUG_FS
> >
> > Each FPGA gets its own directory such as
> >  <debugfs>/fpga_manager/fpga0 and three files:
> >
> >  * [RW] flags          =3D flags as defined in fpga-mgr.h
> >  * [RW] firmware_name  =3D write/read back name of FPGA image
> >                          firmware file to program
> >  * [WO] image          =3D write-only file for directly writing
> >                          fpga image w/o firmware layer
> >  * [RW] config_complete_timeout_us =3D maximum for the FPGA to
> >                          go to the operating state after
> > 			 programming
> >
> > The debugfs is implemented in a separate fpga_mgr_debugfs.c file, but
> > the FPGA manager core is still built as one module.  Note the name
> > change from fpga-mgr.ko to fpga_mgr.ko.
> >
> > Signed-off-by: Alan Tull <atull@kernel.org>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > ---
> >  drivers/fpga/Kconfig            |   7 ++
> >  drivers/fpga/Makefile           |   4 +-
> >  drivers/fpga/fpga-mgr-debugfs.c | 221
> > ++++++++++++++++++++++++++++++++++++++++
> >  drivers/fpga/fpga-mgr-debugfs.h |  22 ++++
> >  drivers/fpga/fpga-mgr.c         |   8 ++
> >  include/linux/fpga/fpga-mgr.h   |   3 +
> >  6 files changed, 264 insertions(+), 1 deletion(-)  create mode 100644
> > drivers/fpga/fpga-mgr-debugfs.c  create mode 100644
> > drivers/fpga/fpga-mgr- debugfs.h
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> > 1ebcef4..600924d
> > 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -9,6 +9,13 @@ menuconfig FPGA
> >  	  kernel.  The FPGA framework adds a FPGA manager class and FPGA
> >  	  manager drivers.
> >
> > +config FPGA_MGR_DEBUG_FS
> > +       bool "FPGA Manager DebugFS"
> > +       depends on FPGA && DEBUG_FS
> > +       help
> > +         Say Y here if you want to expose a DebugFS interface for the
> > +	 FPGA Manager Framework.
> > +
> >  if FPGA
> >
> >  config FPGA_MGR_SOCFPGA
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> > 7a2d73b..62910cc 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -4,7 +4,9 @@
> >  #
> >
> >  # Core FPGA Manager Framework
> > -obj-$(CONFIG_FPGA)			+=3D fpga-mgr.o
> > +obj-$(CONFIG_FPGA)			+=3D fpga_mgr.o
> > +fpga_mgr-y				:=3D fpga-mgr.o
> > +fpga_mgr-$(CONFIG_FPGA_MGR_DEBUG_FS)	+=3D fpga-mgr-debugfs.o
> >
> >  # FPGA Manager Drivers
> >  obj-$(CONFIG_FPGA_MGR_ALTERA_CVP)	+=3D altera-cvp.o
> > diff --git a/drivers/fpga/fpga-mgr-debugfs.c
> > b/drivers/fpga/fpga-mgr-debugfs.c new file mode 100644 index
> > 0000000..f2fdf58
> > --- /dev/null
> > +++ b/drivers/fpga/fpga-mgr-debugfs.c
> > @@ -0,0 +1,221 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * FPGA Manager DebugFS
> > + *
> > + *  Copyright (C) 2016-2018 Intel Corporation.  All rights reserved.
> > + */
> > +#include <linux/debugfs.h>
> > +#include <linux/fpga/fpga-mgr.h>
> > +#include <linux/slab.h>
> > +#include <linux/uaccess.h>
> > +
> > +static struct dentry *fpga_mgr_debugfs_root;
> > +
> > +struct fpga_mgr_debugfs {
> > +	struct dentry *debugfs_dir;
> > +	struct fpga_image_info *info;
> > +};
> > +
> > +static ssize_t fpga_mgr_firmware_write_file(struct file *file,
> > +					    const char __user *user_buf,
> > +					    size_t count, loff_t *ppos)
> > +{
> > +	struct fpga_manager *mgr =3D file->private_data;
> > +	struct fpga_mgr_debugfs *debugfs =3D mgr->debugfs;
> > +	struct device *dev =3D &mgr->dev;
> > +	char *buf;
> > +	int ret;
> > +
> > +	ret =3D fpga_mgr_lock(mgr);
> > +	if (ret) {
> > +		dev_err(dev, "FPGA manager is busy\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	buf =3D devm_kzalloc(dev, count, GFP_KERNEL);
> > +	if (!buf) {
> > +		fpga_mgr_unlock(mgr);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	if (copy_from_user(buf, user_buf, count)) {
> > +		fpga_mgr_unlock(mgr);
> > +		devm_kfree(dev, buf);
> > +		return -EFAULT;
> > +	}
> > +
> > +	buf[count] =3D 0;
> > +	if (buf[count - 1] =3D=3D '\n')
> > +		buf[count - 1] =3D 0;
> > +
> > +	/* Release previous firmware name (if any). Save current one. */
> > +	if (debugfs->info->firmware_name)
> > +		devm_kfree(dev, debugfs->info->firmware_name);
> > +	debugfs->info->firmware_name =3D buf;
> > +
> > +	ret =3D fpga_mgr_load(mgr, debugfs->info);
> > +	if (ret)
> > +		dev_err(dev, "fpga_mgr_load returned with value %d\n", ret);
> > +
> > +	fpga_mgr_unlock(mgr);
> > +
> > +	return count;
> > +}
> > +
> > +static ssize_t fpga_mgr_firmware_read_file(struct file *file,
> > +					   char __user *user_buf,
> > +					   size_t count, loff_t *ppos)
> > +{
> > +	struct fpga_manager *mgr =3D file->private_data;
> > +	struct fpga_mgr_debugfs *debugfs =3D mgr->debugfs;
> > +	char *buf;
> > +	int ret;
> > +
> > +	if (!debugfs->info->firmware_name)
> > +		return 0;
> > +
> > +	buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	ret =3D snprintf(buf, PAGE_SIZE, "%s\n", debugfs->info-
> > >firmware_name);
> > +	if (ret < 0) {
> > +		kfree(buf);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D simple_read_from_buffer(user_buf, count, ppos, buf, ret);
> > +	kfree(buf);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct file_operations fpga_mgr_firmware_fops =3D {
> > +	.open =3D simple_open,
> > +	.read =3D fpga_mgr_firmware_read_file,
> > +	.write =3D fpga_mgr_firmware_write_file,
> > +	.llseek =3D default_llseek,
> > +};
> > +
> > +static ssize_t fpga_mgr_image_write_file(struct file *file,
> > +					 const char __user *user_buf,
> > +					 size_t count, loff_t *ppos)
> > +{
> > +	struct fpga_manager *mgr =3D file->private_data;
> > +	struct fpga_mgr_debugfs *debugfs =3D mgr->debugfs;
> > +	struct device *dev =3D &mgr->dev;
> > +	char *buf;
> > +	int ret;
> > +
> > +	dev_info(dev, "writing %zu bytes to %s\n", count, mgr->name);
> > +
> > +	ret =3D fpga_mgr_lock(mgr);
> > +	if (ret) {
> > +		dev_err(dev, "FPGA manager is busy\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	buf =3D kzalloc(count, GFP_KERNEL);
> > +	if (!buf) {
> > +		fpga_mgr_unlock(mgr);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	if (copy_from_user(buf, user_buf, count)) {
> > +		fpga_mgr_unlock(mgr);
> > +		kfree(buf);
> > +		return -EFAULT;
> > +	}
> > +
> > +	/* If firmware interface was previously used, forget it. */
> > +	if (debugfs->info->firmware_name)
> > +		devm_kfree(dev, debugfs->info->firmware_name);
> > +	debugfs->info->firmware_name =3D NULL;
> > +
> > +	debugfs->info->buf =3D buf;
> > +	debugfs->info->count =3D count;
> > +
> > +	ret =3D fpga_mgr_load(mgr, debugfs->info);
> > +	if (ret)
> > +		dev_err(dev, "fpga_mgr_load returned with value %d\n", ret);
> > +
> > +	fpga_mgr_unlock(mgr);
> > +
> > +	debugfs->info->buf =3D NULL;
> > +	debugfs->info->count =3D 0;
> > +
> > +	kfree(buf);
> > +
> > +	return count;
> > +}
> > +
> > +static const struct file_operations fpga_mgr_image_fops =3D {
> > +	.open =3D simple_open,
> > +	.write =3D fpga_mgr_image_write_file,
> > +	.llseek =3D default_llseek,
> > +};
> > +
> > +void fpga_mgr_debugfs_add(struct fpga_manager *mgr) {
> > +	struct device *dev =3D &mgr->dev;
> > +	struct fpga_mgr_debugfs *debugfs;
> > +	struct fpga_image_info *info;
> > +
> > +	if (!fpga_mgr_debugfs_root)
> > +		return;
> > +
> > +	debugfs =3D kzalloc(sizeof(*debugfs), GFP_KERNEL);
> > +	if (!debugfs)
> > +		return;
> > +
> > +	info =3D fpga_image_info_alloc(dev);
> > +	if (!info) {
> > +		kfree(debugfs);
> > +		return;
> > +	}
> > +	debugfs->info =3D info;
> > +
> > +	debugfs->debugfs_dir =3D debugfs_create_dir(dev_name(dev),
> > +						  fpga_mgr_debugfs_root);
> > +
> > +	debugfs_create_file("firmware_name", 0600, debugfs->debugfs_dir,
> > mgr,
> > +			    &fpga_mgr_firmware_fops);
> > +
> > +	debugfs_create_file("image", 0200, debugfs->debugfs_dir, mgr,
> > +			    &fpga_mgr_image_fops);
> > +
> > +	debugfs_create_u32("flags", 0600, debugfs->debugfs_dir, &info-
> > >flags);
> > +
> > +	debugfs_create_u32("config_complete_timeout_us", 0600,
> > +			   debugfs->debugfs_dir,
> > +			   &info->config_complete_timeout_us);
> > +
> > +	mgr->debugfs =3D debugfs;
> > +}
> > +
> > +void fpga_mgr_debugfs_remove(struct fpga_manager *mgr) {
> > +	struct fpga_mgr_debugfs *debugfs =3D mgr->debugfs;
> > +
> > +	if (!fpga_mgr_debugfs_root)
> > +		return;
> > +
> > +	debugfs_remove_recursive(debugfs->debugfs_dir);
> > +
> > +	/* this function also frees debugfs->info->firmware_name */
> > +	fpga_image_info_free(debugfs->info);
> > +
> > +	kfree(debugfs);
> > +}
> > +
> > +void fpga_mgr_debugfs_init(void)
> > +{
> > +	fpga_mgr_debugfs_root =3D debugfs_create_dir("fpga_manager", NULL);
> > +	if (!fpga_mgr_debugfs_root)
> > +		pr_warn("fpga_mgr: Failed to create debugfs root\n"); }
> > +
> > +void fpga_mgr_debugfs_uninit(void)
> > +{
> > +	debugfs_remove_recursive(fpga_mgr_debugfs_root);
> > +}
> > diff --git a/drivers/fpga/fpga-mgr-debugfs.h
> > b/drivers/fpga/fpga-mgr-debugfs.h new file mode 100644 index
> > 0000000..17cd3eb
> > --- /dev/null
> > +++ b/drivers/fpga/fpga-mgr-debugfs.h
> > @@ -0,0 +1,22 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#ifndef _LINUX_FPGA_MGR_DEBUGFS_H
> > +#define _LINUX_FPGA_MGR_DEBUGFS_H
> > +
> > +#if IS_ENABLED(CONFIG_FPGA_MGR_DEBUG_FS)
> > +
> > +void fpga_mgr_debugfs_add(struct fpga_manager *mgr); void
> > +fpga_mgr_debugfs_remove(struct fpga_manager *mgr); void
> > +fpga_mgr_debugfs_init(void); void fpga_mgr_debugfs_uninit(void);
> > +
> > +#else
> > +
> > +void fpga_mgr_debugfs_add(struct fpga_manager *mgr) {} void
> > +fpga_mgr_debugfs_remove(struct fpga_manager *mgr) {} void
> > +fpga_mgr_debugfs_init(void) {} void fpga_mgr_debugfs_uninit(void) {}
> > +
> > +#endif /* CONFIG_FPGA_MGR_DEBUG_FS */
> > +
> > +#endif /*_LINUX_FPGA_MGR_DEBUGFS_H */
> > diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c index
> > c8684bc..66eb6f6 100644
> > --- a/drivers/fpga/fpga-mgr.c
> > +++ b/drivers/fpga/fpga-mgr.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/highmem.h>
> > +#include "fpga-mgr-debugfs.h"
> >
> >  static DEFINE_IDA(fpga_mgr_ida);
> >  static struct class *fpga_mgr_class;
> > @@ -698,6 +699,8 @@ int fpga_mgr_register(struct fpga_manager *mgr)
> >  	if (ret)
> >  		goto error_device;
> >
> > +	fpga_mgr_debugfs_add(mgr);
> > +
> >  	dev_info(&mgr->dev, "%s registered\n", mgr->name);
> >
> >  	return 0;
> > @@ -722,6 +725,8 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
> {
> >  	dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
> >
> > +	fpga_mgr_debugfs_remove(mgr);
> > +
> >  	/*
> >  	 * If the low level driver provides a method for putting fpga into
> >  	 * a desired state upon unregister, do it.
> > @@ -748,11 +753,14 @@ static int __init fpga_mgr_class_init(void)
> >  	fpga_mgr_class->dev_groups =3D fpga_mgr_groups;
> >  	fpga_mgr_class->dev_release =3D fpga_mgr_dev_release;
> >
> > +	fpga_mgr_debugfs_init();
> > +
> >  	return 0;
> >  }
> >
> >  static void __exit fpga_mgr_class_exit(void)  {
> > +	fpga_mgr_debugfs_uninit();
> >  	class_destroy(fpga_mgr_class);
> >  	ida_destroy(&fpga_mgr_ida);
> >  }
> > diff --git a/include/linux/fpga/fpga-mgr.h
> > b/include/linux/fpga/fpga-mgr.h index 777c502..e8f2159 100644
> > --- a/include/linux/fpga/fpga-mgr.h
> > +++ b/include/linux/fpga/fpga-mgr.h
> > @@ -170,6 +170,9 @@ struct fpga_manager {
> >  	struct fpga_compat_id *compat_id;
> >  	const struct fpga_manager_ops *mops;
> >  	void *priv;
> > +#if IS_ENABLED(CONFIG_FPGA_MGR_DEBUG_FS)
> > +	void *debugfs;
> > +#endif
> >  };
> >
> >  #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
> > --
> > 2.7.4

