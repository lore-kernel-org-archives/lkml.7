Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47286C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC38421881
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="OnOcKqUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfHHMZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:25:59 -0400
Received: from mail-eopbgr00136.outbound.protection.outlook.com ([40.107.0.136]:45219
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726156AbfHHMZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:25:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8fx6ma8HOcVbtI0ajlLaDmaLE7jzUG39RUtaIwB6wofr6OdPZcPQGteotbqXyJ8x/YH3acn5NQKwSfCMLrD0gil074EpGsyP5tMI9WMiwEfHX6x2fn5MS9a8hGH7JIpedYbdJK66/7Pcw3DFutY8aBsrEXSYQZCSopi/0uVpUlFQrCGH2UarzUJmyzVPMUl8enWH+pQEK3lj/mP/Eq8u9AjruKfkwGZNCdDWL1TVm6lGlEmKXABzItEdtP7ImQCGeijE938k44x0DNV0yfutS4f41jMVga729PE9XapPqFfcTSbTgQekXzaWAVuwQu7OX6R4L4IFvzWfHqZDHb41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0FKx2yuSNO+z0rsyaV+hXyJvbbERP/2X9h4U21pPQE=;
 b=gP3ldK8Vbx+H2nXRNS2E0gvydHCm+sdi4IS6Hdlrvycd0cfOOWr2/593eYV/03k9cI71Djnxnt3Tb3e5D6TBhtG9IrzWx3VB2//Vd8aqa6PDyfDbS/BOY8ghioYLhS15MbM9JEfvqE+RL7dKe52WFd7pRNFhErbgDn8/kr3LgT4gxwxxxeHdQQtPPFYaAJPnQOv2XM8ZoiJJswy3U5mNnOwrwRhghiYm4Lwq+J8oicJ2nBvfb7I9XLUcdej1KBGv2QdU8ZhKk/e1ovleLurKl+yfZR301Syqd8I3nRDr9nyptLR8ylUhOAejsiyDrifoIuHUuQX/l5cEeyAIAQRXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0FKx2yuSNO+z0rsyaV+hXyJvbbERP/2X9h4U21pPQE=;
 b=OnOcKqUE+7VnYKfUMZ8q6dSLkrLc3bUoySfCw9mkO3EaYlPwMbB+VoSafpddULWrkQYrUuGpP5PgsKDFIGyXnE+ATI4702RQKEQHOF7vWscBF5NFNRu/uH/C8g/PESjOO8TZ7YJN2aPlrPaX1LebmlX7hwcdkEGDviNZdCVfZ84=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.170.235.155) by
 VI1PR02MB3006.eurprd02.prod.outlook.com (10.170.235.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Thu, 8 Aug 2019 12:25:53 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::30b7:2c9a:9b15:f88f]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::30b7:2c9a:9b15:f88f%4]) with mapi id 15.20.2136.018; Thu, 8 Aug 2019
 12:25:53 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] habanalabs: Expose devices after initialization is done
Thread-Topic: [PATCH] habanalabs: Expose devices after initialization is done
Thread-Index: AQHVTeRr3vCqzO7+GUyO4ii2MrkBzA==
Date:   Thu, 8 Aug 2019 12:25:52 +0000
Message-ID: <20190808122422.28521-1-ttayar@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR1PR01CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::46) To VI1PR02MB3054.eurprd02.prod.outlook.com
 (2603:10a6:802:17::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f50bd685-5238-48a2-fdef-08d71bfb8de4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR02MB3006;
x-ms-traffictypediagnostic: VI1PR02MB3006:
x-microsoft-antispam-prvs: <VI1PR02MB300620466F335F73DE7DDA61D2D70@VI1PR02MB3006.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:186;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39840400004)(136003)(346002)(376002)(189003)(199004)(3846002)(6506007)(26005)(476003)(2501003)(66556008)(36756003)(71200400001)(1361003)(66476007)(305945005)(81166006)(81156014)(6436002)(386003)(71190400001)(486006)(14454004)(6486002)(50226002)(6116002)(8676002)(66946007)(99286004)(66446008)(102836004)(186003)(52116002)(64756008)(2616005)(25786009)(14444005)(53936002)(8936002)(256004)(4326008)(66066001)(1076003)(86362001)(316002)(2351001)(5660300002)(6916009)(6512007)(5640700003)(478600001)(2906002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3006;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RVoZKVrCVvUyn5FwaghpZy1sPzWp/76NllAdXp+m3LXrGXObBOWvw03sf4Zd7ycVuG7jv/vcrx/IRIBHaaiiv+zfyLgAC+MNg+Yi4plyJS8xD7Jq6iMA4/jgZWmajvDL31mLjkbhShCs+CWPBUrsJSiW/jsW3A9mTPmAn4sAlkUCDUWRwov/9FiQfwaQCAhlp7uQ/ZB/oItJvtHuobJC8tgKmb/Q6zIfR3OCjMgD/D5tJNuQrQdew1pc4Fao7JNh9Op5TqWHZOsjifY00h1iQvk+tH/u58DIqcKq50qaXxVURS8kj8i5X0TlnM8CQGFaKDOPxIkom//nrKKt0dHqeZ2OcfoVmDODRYls71DWuxLdBMYJbGQOvOUEnWX4A7ova0x0rB2cGRJok5g2Iu6WQuPhAYSQbHXHgFvfSjH0QHk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: f50bd685-5238-48a2-fdef-08d71bfb8de4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 12:25:52.9919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttayar@habana.ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The char devices are currently exposed to user before the device and
driver initialization are done.
This patch moves the cdev and device adding to the system to the end of
the initialization sequence, while keeping the creation of the
structures at the beginning to allow the usage of dev_*().

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/device.c     | 163 ++++++++++++++++++---------
 drivers/misc/habanalabs/habanalabs.h |   2 +
 2 files changed, 111 insertions(+), 54 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/dev=
ice.c
index efde1fe7d286..9a5926888b99 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -151,50 +151,94 @@ static const struct file_operations hl_ctrl_ops =3D {
 	.compat_ioctl =3D hl_ioctl_control
 };
=20
+static void device_release_func(struct device *dev)
+{
+	kfree(dev);
+}
+
 /*
- * device_setup_cdev - setup cdev and device for habanalabs device
+ * device_init_cdev - Initialize cdev and device for habanalabs device
  *
  * @hdev: pointer to habanalabs device structure
  * @hclass: pointer to the class object of the device
  * @minor: minor number of the specific device
  * @fpos: file operations to install for this device
  * @name: name of the device as it will appear in the filesystem
- * @cdev: pointer to the char device object that will be created
- * @dev: pointer to the device object that will be created
+ * @cdev: pointer to the char device object that will be initialized
+ * @dev: pointer to the device object that will be initialized
  *
- * Create a cdev and a Linux device for habanalabs's device. Need to be
- * called at the end of the habanalabs device initialization process,
- * because this function exposes the device to the user
+ * Initialize a cdev and a Linux device for habanalabs's device.
  */
-static int device_setup_cdev(struct hl_device *hdev, struct class *hclass,
+static int device_init_cdev(struct hl_device *hdev, struct class *hclass,
 				int minor, const struct file_operations *fops,
 				char *name, struct cdev *cdev,
 				struct device **dev)
 {
-	int err, devno =3D MKDEV(hdev->major, minor);
-
 	cdev_init(cdev, fops);
 	cdev->owner =3D THIS_MODULE;
-	err =3D cdev_add(cdev, devno, 1);
-	if (err) {
-		pr_err("Failed to add char device %s\n", name);
-		return err;
+
+	*dev =3D kzalloc(sizeof(**dev), GFP_KERNEL);
+	if (!*dev)
+		return -ENOMEM;
+
+	device_initialize(*dev);
+	(*dev)->devt =3D MKDEV(hdev->major, minor);
+	(*dev)->class =3D hclass;
+	(*dev)->release =3D device_release_func;
+	dev_set_drvdata(*dev, hdev);
+	dev_set_name(*dev, "%s", name);
+
+	return 0;
+}
+
+static int device_cdev_sysfs_add(struct hl_device *hdev)
+{
+	int rc;
+
+	rc =3D cdev_device_add(&hdev->cdev, hdev->dev);
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to add a char device to the system\n");
+		return rc;
 	}
=20
-	*dev =3D device_create(hclass, NULL, devno, NULL, "%s", name);
-	if (IS_ERR(*dev)) {
-		pr_err("Failed to create device %s\n", name);
-		err =3D PTR_ERR(*dev);
-		goto err_device_create;
+	rc =3D cdev_device_add(&hdev->cdev_ctrl, hdev->dev_ctrl);
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to add a control char device to the system\n");
+		goto delete_cdev_device;
 	}
=20
-	dev_set_drvdata(*dev, hdev);
+	/* hl_sysfs_init() must be done after adding the device to the system */
+	rc =3D hl_sysfs_init(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "failed to initialize sysfs\n");
+		goto delete_ctrl_cdev_device;
+	}
+
+	hdev->cdev_sysfs_created =3D true;
=20
 	return 0;
=20
-err_device_create:
-	cdev_del(cdev);
-	return err;
+delete_ctrl_cdev_device:
+	cdev_device_del(&hdev->cdev_ctrl, hdev->dev_ctrl);
+delete_cdev_device:
+	cdev_device_del(&hdev->cdev, hdev->dev);
+	return rc;
+}
+
+static void device_cdev_sysfs_del(struct hl_device *hdev)
+{
+	/* device_release() won't be called so must free devices explicitly */
+	if (!hdev->cdev_sysfs_created) {
+		kfree(hdev->dev_ctrl);
+		kfree(hdev->dev);
+		return;
+	}
+
+	hl_sysfs_fini(hdev);
+	cdev_device_del(&hdev->cdev_ctrl, hdev->dev_ctrl);
+	cdev_device_del(&hdev->cdev, hdev->dev);
 }
=20
 /*
@@ -898,13 +942,16 @@ int hl_device_init(struct hl_device *hdev, struct cla=
ss *hclass)
 {
 	int i, rc, cq_ready_cnt;
 	char *name;
+	bool add_cdev_sysfs_on_err =3D false;
=20
 	name =3D kasprintf(GFP_KERNEL, "hl%d", hdev->id / 2);
-	if (!name)
-		return -ENOMEM;
+	if (!name) {
+		rc =3D -ENOMEM;
+		goto out_disabled;
+	}
=20
-	/* Create device */
-	rc =3D device_setup_cdev(hdev, hclass, hdev->id, &hl_ops, name,
+	/* Initialize cdev and device structures */
+	rc =3D device_init_cdev(hdev, hclass, hdev->id, &hl_ops, name,
 				&hdev->cdev, &hdev->dev);
=20
 	kfree(name);
@@ -915,22 +962,22 @@ int hl_device_init(struct hl_device *hdev, struct cla=
ss *hclass)
 	name =3D kasprintf(GFP_KERNEL, "hl_controlD%d", hdev->id / 2);
 	if (!name) {
 		rc =3D -ENOMEM;
-		goto release_device;
+		goto free_dev;
 	}
=20
-	/* Create control device */
-	rc =3D device_setup_cdev(hdev, hclass, hdev->id_control, &hl_ctrl_ops,
+	/* Initialize cdev and device structures for control device */
+	rc =3D device_init_cdev(hdev, hclass, hdev->id_control, &hl_ctrl_ops,
 				name, &hdev->cdev_ctrl, &hdev->dev_ctrl);
=20
 	kfree(name);
=20
 	if (rc)
-		goto release_device;
+		goto free_dev;
=20
 	/* Initialize ASIC function pointers and perform early init */
 	rc =3D device_early_init(hdev);
 	if (rc)
-		goto release_control_device;
+		goto free_dev_ctrl;
=20
 	/*
 	 * Start calling ASIC initialization. First S/W then H/W and finally
@@ -1016,12 +1063,6 @@ int hl_device_init(struct hl_device *hdev, struct cl=
ass *hclass)
 		goto release_ctx;
 	}
=20
-	rc =3D hl_sysfs_init(hdev);
-	if (rc) {
-		dev_err(hdev->dev, "failed to initialize sysfs\n");
-		goto free_cb_pool;
-	}
-
 	hl_debugfs_add_device(hdev);
=20
 	if (hdev->asic_funcs->get_hw_state(hdev) =3D=3D HL_DEVICE_HW_STATE_DIRTY)=
 {
@@ -1030,6 +1071,12 @@ int hl_device_init(struct hl_device *hdev, struct cl=
ass *hclass)
 		hdev->asic_funcs->hw_fini(hdev, true);
 	}
=20
+	/*
+	 * From this point, in case of an error, add char devices and create
+	 * sysfs nodes as part of the error flow, to allow debugging.
+	 */
+	add_cdev_sysfs_on_err =3D true;
+
 	rc =3D hdev->asic_funcs->hw_init(hdev);
 	if (rc) {
 		dev_err(hdev->dev, "failed to initialize the H/W\n");
@@ -1066,9 +1113,24 @@ int hl_device_init(struct hl_device *hdev, struct cl=
ass *hclass)
 	}
=20
 	/*
-	 * hl_hwmon_init must be called after device_late_init, because only
+	 * Expose devices and sysfs nodes to user.
+	 * From here there is no need to add char devices and create sysfs nodes
+	 * in case of an error.
+	 */
+	add_cdev_sysfs_on_err =3D false;
+	rc =3D device_cdev_sysfs_add(hdev);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to add char devices and sysfs nodes\n");
+		rc =3D 0;
+		goto out_disabled;
+	}
+
+	/*
+	 * hl_hwmon_init() must be called after device_late_init(), because only
 	 * there we get the information from the device about which
-	 * hwmon-related sensors the device supports
+	 * hwmon-related sensors the device supports.
+	 * Furthermore, it must be done after adding the device to the system.
 	 */
 	rc =3D hl_hwmon_init(hdev);
 	if (rc) {
@@ -1084,8 +1146,6 @@ int hl_device_init(struct hl_device *hdev, struct cla=
ss *hclass)
=20
 	return 0;
=20
-free_cb_pool:
-	hl_cb_pool_fini(hdev);
 release_ctx:
 	if (hl_ctx_put(hdev->kernel_ctx) !=3D 1)
 		dev_err(hdev->dev,
@@ -1106,14 +1166,14 @@ int hl_device_init(struct hl_device *hdev, struct c=
lass *hclass)
 	hdev->asic_funcs->sw_fini(hdev);
 early_fini:
 	device_early_fini(hdev);
-release_control_device:
-	device_destroy(hclass, hdev->dev_ctrl->devt);
-	cdev_del(&hdev->cdev_ctrl);
-release_device:
-	device_destroy(hclass, hdev->dev->devt);
-	cdev_del(&hdev->cdev);
+free_dev_ctrl:
+	kfree(hdev->dev_ctrl);
+free_dev:
+	kfree(hdev->dev);
 out_disabled:
 	hdev->disabled =3D true;
+	if (add_cdev_sysfs_on_err)
+		device_cdev_sysfs_add(hdev);
 	if (hdev->pdev)
 		dev_err(&hdev->pdev->dev,
 			"Failed to initialize hl%d. Device is NOT usable !\n",
@@ -1179,8 +1239,6 @@ void hl_device_fini(struct hl_device *hdev)
=20
 	hl_debugfs_remove_device(hdev);
=20
-	hl_sysfs_fini(hdev);
-
 	/*
 	 * Halt the engines and disable interrupts so we won't get any more
 	 * completions from H/W and we won't have any accesses from the
@@ -1223,11 +1281,8 @@ void hl_device_fini(struct hl_device *hdev)
=20
 	device_early_fini(hdev);
=20
-	/* Hide device from user */
-	device_destroy(hdev->dev_ctrl->class, hdev->dev_ctrl->devt);
-	cdev_del(&hdev->cdev_ctrl);
-	device_destroy(hdev->dev->class, hdev->dev->devt);
-	cdev_del(&hdev->cdev);
+	/* Hide devices and sysfs nodes from user */
+	device_cdev_sysfs_del(hdev);
=20
 	pr_info("removed device successfully\n");
 }
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs=
/habanalabs.h
index aaaa29d98901..1bb181285589 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1216,6 +1216,7 @@ struct hl_device_reset_work {
  * @dma_mask: the dma mask that was set for this device
  * @in_debug: is device under debug. This, together with fpriv_list, enfor=
ces
  *            that only a single user is configuring the debug infrastruct=
ure.
+ * @cdev_sysfs_created: were char devices and sysfs nodes created.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -1291,6 +1292,7 @@ struct hl_device {
 	u8				device_cpu_disabled;
 	u8				dma_mask;
 	u8				in_debug;
+	u8				cdev_sysfs_created;
=20
 	/* Parameters for bring-up */
 	u8				mmu_enable;
--=20
2.17.1

