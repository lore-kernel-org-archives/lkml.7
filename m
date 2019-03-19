Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B924C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3795620854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="2pVU8XLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfCSMEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:04:46 -0400
Received: from mail-eopbgr750044.outbound.protection.outlook.com ([40.107.75.44]:61511
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727495AbfCSMEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvk1zt1cyhTuR0jWfllVRPfW4sYl4buGsmof2Z3RNcA=;
 b=2pVU8XLltY9Qp6HQpYb9u2v4BMfWZuVZXKXZM4tj1wk+Qb7HYi8t2vwISjHIhWsXyu7HkzMVAAr7+ybUo3bsPEON0ndtbRB13On3k0r3heR/G4u/wB7AFKCuMT7keGMPuZdMTFIb1Rkx68hUO6fh/ZFKPwGHr3UbVpPom8cZffs=
Received: from SN6PR02CA0013.namprd02.prod.outlook.com (2603:10b6:805:a2::26)
 by BN8PR02MB5908.namprd02.prod.outlook.com (2603:10b6:408:b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Tue, 19 Mar
 2019 12:04:38 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by SN6PR02CA0013.outlook.office365.com
 (2603:10b6:805:a2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.14 via Frontend
 Transport; Tue, 19 Mar 2019 12:04:38 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1730.9 via Frontend Transport; Tue, 19 Mar 2019 12:04:37 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 19 Mar 2019 12:04:34 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 19 Mar 2019 12:04:34 +0000
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=43674 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1h6DTu-0003Ch-Qf; Tue, 19 Mar 2019 12:04:34 +0000
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Date:   Tue, 19 Mar 2019 12:04:16 +0000
Message-ID: <1552997064-432700-5-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(189003)(199004)(50466002)(356004)(14444005)(2201001)(7696005)(51416003)(8676002)(48376002)(186003)(107886003)(71366001)(26005)(76176011)(26826003)(246002)(5024004)(6666004)(5660300002)(478600001)(60926002)(486006)(7636002)(47776003)(305945005)(36756003)(28376004)(44832011)(9786002)(93146003)(8746002)(106466001)(8936002)(110136005)(316002)(106002)(336012)(50226002)(4326008)(54906003)(476003)(446003)(126002)(956004)(11346002)(2906002)(36906005)(2616005)(426003)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR02MB5908;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f16c2fd-4cff-4084-ed49-08d6ac630f88
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN8PR02MB5908;
X-MS-TrafficTypeDiagnostic: BN8PR02MB5908:
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN8PR02MB5908FA9D576F68AEDD8E934FCB400@BN8PR02MB5908.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: FYSGRofFoJBqXUicnPYf1G37R08sB0gQ8TnpGiSBgnzIXrI39ghEXvOQNy02xUKEb5KSpwTidyiH/TEOpyF9b2DnTHhZaWsvn0df6U8rYnbURCzHmrwbyKYltacd+G+XKrY+smKk3gs0ph2udB6w0vaG4Or7Ld39qs1Q41BTZef9V6lxCN6cUFl/DmdEZa2KCFPxe5oEiGa/6zriJeFExqJVXvoJ2KUPplyuNsM+dVqj2Q+tnynNN6WEkQD7/IjKQ1HkY95oftSmZ2zPDsk87HWIyBwi+LdeQMQlAdcz6sDFh7rCsTG1VUl9F4dy1bs7FimGvFP7kSv+hNb5Ciavim9bjS7IA2TcVI10G+cTpcWSMkKq2V1bXAEz02yfCR5PxOEy3WlBU7QAa5t0ZSCxFcLg7a8ZvYWUokrHZyDXswI=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 12:04:37.8142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f16c2fd-4cff-4084-ed49-08d6ac630f88
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5908
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add char device interface per DT node present and support
file operations:
- open(), which keeps only one open per device at a time,
- close(), which release the open for this device,
- ioctl(), which provides infrastructure for a specific driver
control.

Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/xilinx_sdfec.c      | 79 ++++++++++++++++++++++++++++++++++++=
++++
 include/uapi/misc/xilinx_sdfec.h |  4 ++
 2 files changed, 83 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index a52a5c6..3407de4 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -81,8 +81,87 @@ struct xsdfec_dev {
        struct xsdfec_clks clks;
 };

+static int xsdfec_dev_open(struct inode *iptr, struct file *fptr)
+{
+       struct xsdfec_dev *xsdfec;
+
+       xsdfec =3D container_of(iptr->i_cdev, struct xsdfec_dev, xsdfec_cde=
v);
+       if (!xsdfec)
+               return -EAGAIN;
+
+       /* Only one open per device at a time */
+       if (!atomic_dec_and_test(&xsdfec->open_count)) {
+               atomic_inc(&xsdfec->open_count);
+               return -EBUSY;
+       }
+
+       fptr->private_data =3D xsdfec;
+       return 0;
+}
+
+static int xsdfec_dev_release(struct inode *iptr, struct file *fptr)
+{
+       struct xsdfec_dev *xsdfec;
+
+       xsdfec =3D container_of(iptr->i_cdev, struct xsdfec_dev, xsdfec_cde=
v);
+       if (!xsdfec)
+               return -EAGAIN;
+
+       atomic_inc(&xsdfec->open_count);
+       return 0;
+}
+
+static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
+                            unsigned long data)
+{
+       struct xsdfec_dev *xsdfec =3D fptr->private_data;
+       void __user *arg =3D NULL;
+       int rval =3D -EINVAL;
+       int err =3D 0;
+
+       if (!xsdfec)
+               return rval;
+
+       if (_IOC_TYPE(cmd) !=3D XSDFEC_MAGIC) {
+               dev_err(xsdfec->dev, "Not a xilinx sdfec ioctl");
+               return -ENOTTY;
+       }
+
+       /* check if ioctl argument is present and valid */
+       if (_IOC_DIR(cmd) !=3D _IOC_NONE) {
+               arg =3D (void __user *)data;
+               if (!arg) {
+                       dev_err(xsdfec->dev,
+                               "xilinx sdfec ioctl argument is NULL Pointe=
r");
+                       return rval;
+               }
+       }
+
+       /* Access check of the argument if present */
+       if (_IOC_DIR(cmd) & _IOC_READ)
+               err =3D !access_ok((void *)arg, _IOC_SIZE(cmd));
+       else if (_IOC_DIR(cmd) & _IOC_WRITE)
+               err =3D !access_ok((void *)arg, _IOC_SIZE(cmd));
+
+       if (err) {
+               dev_err(xsdfec->dev, "Invalid xilinx sdfec ioctl argument")=
;
+               return -EFAULT;
+       }
+
+       switch (cmd) {
+       default:
+               /* Should not get here */
+               dev_err(xsdfec->dev, "Undefined SDFEC IOCTL");
+               break;
+       }
+       return rval;
+}
+
 static const struct file_operations xsdfec_fops =3D {
        .owner =3D THIS_MODULE,
+       .open =3D xsdfec_dev_open,
+       .release =3D xsdfec_dev_release,
+       .unlocked_ioctl =3D xsdfec_dev_ioctl,
 };

 static int xsdfec_clk_init(struct platform_device *pdev,
diff --git a/include/uapi/misc/xilinx_sdfec.h b/include/uapi/misc/xilinx_sd=
fec.h
index 5543163..5de0add 100644
--- a/include/uapi/misc/xilinx_sdfec.h
+++ b/include/uapi/misc/xilinx_sdfec.h
@@ -39,4 +39,8 @@ struct xsdfec_config {
        s32 fec_id;
 };

+/*
+ * XSDFEC IOCTL List
+ */
+#define XSDFEC_MAGIC 'f'
 #endif /* __XILINX_SDFEC_H__ */
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
