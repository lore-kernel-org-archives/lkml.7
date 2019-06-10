Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A006C468BC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 06:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E11A20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 06:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="iGJ9x9xZ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="rCCoWPAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbfFJGeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 02:34:01 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:35038 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387464AbfFJGeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 02:34:00 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5A6WX0Q009117;
        Sun, 9 Jun 2019 23:33:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=HH7wOCyQVWwX+EDSKnl41d00kyywX0p1sINaLFRYcmg=;
 b=iGJ9x9xZkfRUCm3CJs1I44Cro8ncpWYfMY4subRP7VIuqzEXc7dVZQZ2DNwJf5vy5oC4
 +B8nJKunGAnYqmuWktJmsjw2y9kJrsOYNhKQbO/CDd+X9+v4ljnJgFfVLtTONwH5QGnv
 At0ZpoHfXbPjgupcvvv9mNi9q6QG097IhBFDS3f5tZmuoqM6XjAZMnn30izR3/oXuNc9
 HGJicpBphNApWpaJnBCMLrdiRqVwlI4Zhkb7ULOv2L6QiwqNZn4s3UFmr8dUEgbIZZki
 4HkDjcAflE3nqy0GTevYNBBEMo5xIEnki5Pl44kNF131eYoRSLj8lGFDkJh4c9DbC2QK bA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2059.outbound.protection.outlook.com [104.47.46.59])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2t09jvcx37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 09 Jun 2019 23:33:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH7wOCyQVWwX+EDSKnl41d00kyywX0p1sINaLFRYcmg=;
 b=rCCoWPAHaHyCS22H0WQODNVZMqHsXbxzdwRoZn8+dCAUQdEQti6QbcGvrlINY9q9QWy8fS/ew6ZWBx6jdHTIUbfM9uMeGyIk5FtBACOz4wzRccDiN+BP1QzXwcjekoRfhf6oBYjXqlXYrPwjSUteaIoSNrn8xTrjMBlnuIZrs98=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5063.namprd07.prod.outlook.com (52.135.239.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Mon, 10 Jun 2019 06:33:29 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::594a:4a73:3ead:457d]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::594a:4a73:3ead:457d%3]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 06:33:29 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v7 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v7 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHVG4Y4SF7nQPUaCk+2a30suK0doKaP/PcAgARnSZA=
Date:   Mon, 10 Jun 2019 06:33:29 +0000
Message-ID: <BYAPR07MB4709F32FF0C6DAE8905703C7DD130@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1559729030-16390-1-git-send-email-pawell@cadence.com>
 <1559729030-16390-6-git-send-email-pawell@cadence.com>
 <20190607101602.GD10298@kuha.fi.intel.com>
In-Reply-To: <20190607101602.GD10298@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYTc4MGY3NTMtOGI0OS0xMWU5LTg3NDEtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGE3ODBmNzU0LThiNDktMTFlOS04NzQxLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNjExMCIgdD0iMTMyMDQ2MjIwMDgxMjc5MjM4IiBoPSJHcFZzaUFYNGMvdlJNc0hjUEVGSys5MzdtT0E9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d75bbb10-538e-43d7-cefa-08d6ed6d8d5f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5063;
x-ms-traffictypediagnostic: BYAPR07MB5063:
x-microsoft-antispam-prvs: <BYAPR07MB50634BFC3ADBA82C91BE0280DD130@BYAPR07MB5063.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(36092001)(51444003)(3846002)(6116002)(52536014)(478600001)(2906002)(186003)(229853002)(7736002)(305945005)(102836004)(7416002)(6436002)(107886003)(6246003)(11346002)(25786009)(4326008)(74316002)(53936002)(66556008)(54906003)(486006)(86362001)(66476007)(81166006)(64756008)(66446008)(9686003)(99286004)(33656002)(55016002)(8936002)(5660300002)(81156014)(6506007)(76116006)(7696005)(8676002)(76176011)(66066001)(14454004)(316002)(73956011)(71200400001)(6916009)(26005)(446003)(71190400001)(66946007)(476003)(256004)(14444005)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5063;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3YgETQLJhw0WKPznZHzGTV9Ti+xaIoIN19BARVNJfWyBmqBLfs6JxVAQhzf6SZiEY8jTy0bAp5j34l4YnqLccXLPzchDk0mDdC63ZzyuBUX4j7CA3ZpsjBNLja0KAHXloJsTiiwqM6XxFtzPN2qNwZtKe2aPAulmFbA4/2KULSOyM1PjqZ9Kz9IBS1Akbeo6i03tmBUiELt+9IbTAPIEMpuh37HMqVomGo2kJiwlakgXNbOiYk/24t8A2IbgZWLwg2vX5FlcR1Aiy1veBDrvMiqLAnIE3h+cAtBkDJq/j2EwGF6rAcSRP+BSeAS0J69eAubN4k6R4tzQJMawxVnYxNV+EITTup7Q/3mj4NSqBSuC5D3WaIGCt3rwSgnInMU2N5RgdOO7Pfwh2DWRqtfbJbKJXBVic+RobV4xA6vMz4c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75bbb10-538e-43d7-cefa-08d6ed6d8d5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 06:33:29.7499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5063
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-10_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906100045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Jun 05, 2019 at 11:03:49AM +0100, Pawel Laszczak wrote:
>> diff --git a/drivers/usb/cdns3/debugfs.c b/drivers/usb/cdns3/debugfs.c
>> new file mode 100644
>> index 000000000000..dfcbeb5e14f8
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/debugfs.c
>> @@ -0,0 +1,173 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Cadence USBSS DRD Controller DebugFS filer.
>> + *
>> + * Copyright (C) 2018-2019 Cadence.
>> + *
>> + * Author: Pawel Laszczak <pawell@cadence.com>
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/debugfs.h>
>> +#include <linux/seq_file.h>
>> +#include <linux/uaccess.h>
>> +
>> +#include "core.h"
>> +#include "gadget.h"
>> +#include "drd.h"
>
>static const char *const cdns3_mode[] =3D {
>        [USB_DR_MODE_UNKNOWN]           =3D "unknown",
>        [USB_DR_MODE_OTG]               =3D "otg",
>        [USB_DR_MODE_HOST]              =3D "host",
>        [USB_DR_MODE_PERIPHERAL]        =3D "device",
>};
>
>> +static int cdns3_mode_show(struct seq_file *s, void *unused)
>> +{
>> +	struct cdns3 *cdns =3D s->private;
>> +
>> +	switch (cdns->current_dr_mode) {
>> +	case USB_DR_MODE_HOST:
>> +		seq_puts(s, "host\n");
>> +		break;
>> +	case USB_DR_MODE_PERIPHERAL:
>> +		seq_puts(s, "device\n");
>> +		break;
>> +	case USB_DR_MODE_OTG:
>> +		seq_puts(s, "otg\n");
>> +		break;
>> +	default:
>> +		seq_puts(s, "UNKNOWN mode\n");
>> +	}
>
>All you should need here is:
>
>        seq_puts(s, cdns3_mode[cdns->current_dr_mode]);
>
>> +	return 0;
>> +}
>> +
>> +static int cdns3_mode_open(struct inode *inode, struct file *file)
>> +{
>> +	return single_open(file, cdns3_mode_show, inode->i_private);
>> +}
>> +
>> +static ssize_t cdns3_mode_write(struct file *file,
>> +				const char __user *ubuf,
>> +				size_t count, loff_t *ppos)
>> +{
>> +	struct seq_file	 *s =3D file->private_data;
>> +	struct cdns3 *cdns =3D s->private;
>> +	u32 mode =3D USB_DR_MODE_UNKNOWN;
>> +	char buf[32];
>> +	int ret =3D 0;
>
>        int ret;
>
>> +	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
>> +		return -EFAULT;
>
>                return -EINVAL;

Why? I've checked in some place in kernel and after copy_from_user are used=
 EFAULT.
I think that EINVAL is better but I wanted be  consistent with the rest of =
kernel.=20

Is there any explanation for this ?

>
>> +
>> +	if (cdns->debug_disable) {
>> +		dev_err(cdns->dev,
>> +			"Mode can't be changed when disable is set\n");
>> +		return -EFAULT;
>
>                return -EPERM;
>
>> +	}
>> +
>> +	if (!strncmp(buf, "host", 4)) {
>> +		if (cdns->dr_mode =3D=3D USB_DR_MODE_HOST ||
>> +		    cdns->dr_mode =3D=3D USB_DR_MODE_OTG) {
>> +			mode =3D USB_DR_MODE_HOST;
>> +		}
>> +	}
>> +
>> +	if (!strncmp(buf, "device", 6))
>> +		if (cdns->dr_mode =3D=3D USB_DR_MODE_PERIPHERAL ||
>> +		    cdns->dr_mode =3D=3D USB_DR_MODE_OTG)
>> +			mode =3D USB_DR_MODE_PERIPHERAL;
>> +
>> +	if (!strncmp(buf, "otg", 3) && cdns->dr_mode =3D=3D USB_DR_MODE_OTG)
>> +		mode =3D USB_DR_MODE_OTG;
>> +
>> +	if (mode =3D=3D USB_DR_MODE_UNKNOWN) {
>> +		dev_err(cdns->dev, "Failed: incorrect mode setting\n");
>> +		return -EFAULT;
>> +	}
>
>To cover all those, you just need to:
>
>        ret =3D match_string(cdns3_mode, ARRAY_SIZE(cdns3_mode), buf));
>        if (ret < 0 ||=A0ret =3D=3D USB_DR_MODE_UNKNOWN)
>                return -EINVAL;
>
>> +	if (cdns->current_dr_mode !=3D mode) {
>> +		cdns->desired_dr_mode =3D mode;
>
>        if (cdns->current_dr_mode !=3D ret)
>		cdns->desired_dr_mode =3D ret;
>
>> +		cdns3_role_stop(cdns);
>> +		ret =3D cdns3_drd_update_mode(cdns);
>> +		if (ret)
>> +			return ret;
>> +
>> +		queue_work(system_freezable_wq, &cdns->role_switch_wq);
>> +	}
>> +
>> +	return count;
>> +}
>> +
>> +static const struct file_operations cdns3_mode_fops =3D {
>> +	.open			=3D cdns3_mode_open,
>> +	.write			=3D cdns3_mode_write,
>> +	.read			=3D seq_read,
>> +	.llseek			=3D seq_lseek,
>> +	.release		=3D single_release,
>> +};
>> +
>> +static int cdns3_disable_show(struct seq_file *s, void *unused)
>> +{
>> +	struct cdns3 *cdns =3D s->private;
>> +
>> +	if (!cdns->debug_disable)
>> +		seq_puts(s, "0\n");
>> +	else
>> +		seq_puts(s, "1\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static ssize_t cdns3_disable_write(struct file *file,
>> +				   const char __user *ubuf,
>> +				   size_t count, loff_t *ppos)
>> +{
>> +	struct seq_file	 *s =3D file->private_data;
>> +	struct cdns3 *cdns =3D s->private;
>> +	bool disable;
>> +	char buf[16];
>> +
>> +	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
>> +		return -EFAULT;
>> +
>> +	if (kstrtobool(buf, &disable)) {
>> +		dev_err(cdns->dev, "wrong setting\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (disable !=3D cdns->debug_disable) {
>> +		cdns->debug_disable =3D disable;
>> +		queue_work(system_freezable_wq, &cdns->role_switch_wq);
>> +	}
>> +
>> +	return count;
>> +}
>> +
>> +static int cdns3_disable_open(struct inode *inode, struct file *file)
>> +{
>> +	return single_open(file, cdns3_disable_show, inode->i_private);
>> +}
>> +
>> +static const struct file_operations cdns3_disable_fops =3D {
>> +	.open			=3D cdns3_disable_open,
>> +	.write			=3D cdns3_disable_write,
>> +	.read			=3D seq_read,
>> +	.llseek			=3D seq_lseek,
>> +	.release		=3D single_release,
>> +};
>> +
>> +void cdns3_debugfs_init(struct cdns3 *cdns)
>> +{
>> +	struct dentry *root;
>> +
>> +	root =3D debugfs_create_dir(dev_name(cdns->dev), NULL);
>> +	cdns->root =3D root;
>> +	if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET) &&
>> +	    IS_ENABLED(CONFIG_USB_CDNS3_HOST))
>> +		debugfs_create_file("mode", 0644, root, cdns,
>> +				    &cdns3_mode_fops);
>> +
>> +	debugfs_create_file("disable", 0644, root, cdns,
>> +			    &cdns3_disable_fops);
>> +}
>> +
>> +void cdns3_debugfs_exit(struct cdns3 *cdns)
>> +{
>> +	debugfs_remove_recursive(cdns->root);
>> +}
>
>thanks,
>
>--
>heikki

Thank for nice simplification.=20
Regards=20
Pawel
