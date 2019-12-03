Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3845C33CBB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B98206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfLCDsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 22:48:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726897AbfLCDsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 22:48:31 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB33kkPK032800
        for <linux-kernel@vger.kernel.org>; Mon, 2 Dec 2019 22:48:30 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wm6snr95h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 22:48:30 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Tue, 3 Dec 2019 03:48:27 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Dec 2019 03:48:19 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB33mI2F44630180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Dec 2019 03:48:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C2A1A4040;
        Tue,  3 Dec 2019 03:48:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBBFEA4057;
        Tue,  3 Dec 2019 03:48:17 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Dec 2019 03:48:17 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 4DCB9A03E3;
        Tue,  3 Dec 2019 14:48:13 +1100 (AEDT)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: [PATCH v2 17/27] nvdimm/ocxl: Add controller dump IOCTLs
Date:   Tue,  3 Dec 2019 14:46:45 +1100
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203034655.51561-1-alastair@au1.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120303-0020-0000-0000-00000392CC5A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120303-0021-0000-0000-000021E9EAA9
Message-Id: <20191203034655.51561-18-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=14 bulkscore=0 mlxscore=14
 suspectscore=1 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=77 spamscore=14 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

This patch adds IOCTLs to allow userspace to request & fetch dumps
of the internal controller state.

This is useful during debugging or when a fatal error on the controller
has occurred.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/nvdimm/ocxl/scm.c      | 132 +++++++++++++++++++++++++++++++++
 include/uapi/nvdimm/ocxl-scm.h |  15 ++++
 2 files changed, 147 insertions(+)

diff --git a/drivers/nvdimm/ocxl/scm.c b/drivers/nvdimm/ocxl/scm.c
index 0bbe1a14291e..a520f209d626 100644
--- a/drivers/nvdimm/ocxl/scm.c
+++ b/drivers/nvdimm/ocxl/scm.c
@@ -688,6 +688,124 @@ static int scm_ioctl_error_log(struct scm_data *scm_data,
 	return 0;
 }
 
+static int scm_ioctl_controller_dump_data(struct scm_data *scm_data,
+	struct scm_ioctl_controller_dump_data __user *uarg)
+{
+	struct scm_ioctl_controller_dump_data args;
+	u16 i;
+	u64 val;
+	int rc;
+
+	if (copy_from_user(&args, uarg, sizeof(args)))
+		return -EFAULT;
+
+	if (args.buf_size % 8)
+		return -EINVAL;
+
+	if (args.buf_size > scm_data->admin_command.data_size)
+		return -EINVAL;
+
+	mutex_lock(&scm_data->admin_command.lock);
+
+	rc = scm_admin_command_request(scm_data, ADMIN_COMMAND_CONTROLLER_DUMP);
+	if (rc)
+		goto out;
+
+	val = ((u64)args.offset) << 32;
+	val |= args.buf_size;
+	rc = ocxl_global_mmio_write64(scm_data->ocxl_afu,
+				      scm_data->admin_command.request_offset + 0x08,
+				      OCXL_LITTLE_ENDIAN, val);
+	if (rc)
+		goto out;
+
+	rc = scm_admin_command_execute(scm_data);
+	if (rc)
+		goto out;
+
+	rc = scm_admin_command_complete_timeout(scm_data,
+						ADMIN_COMMAND_CONTROLLER_DUMP);
+	if (rc < 0) {
+		dev_warn(&scm_data->dev, "Controller dump timed out\n");
+		goto out;
+	}
+
+	rc = scm_admin_response(scm_data);
+	if (rc < 0)
+		goto out;
+	if (rc != STATUS_SUCCESS) {
+		scm_warn_status(scm_data,
+				"Unexpected status from retrieve error log",
+				rc);
+		goto out;
+	}
+
+	for (i = 0; i < args.buf_size; i += 8) {
+		u64 val;
+
+		rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+					     scm_data->admin_command.data_offset + i,
+					     OCXL_HOST_ENDIAN, &val);
+		if (rc)
+			goto out;
+
+		if (copy_to_user(&args.buf[i], &val, sizeof(u64))) {
+			rc = -EFAULT;
+			goto out;
+		}
+	}
+
+	if (copy_to_user(uarg, &args, sizeof(args))) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	rc = scm_admin_response_handled(scm_data);
+	if (rc)
+		goto out;
+
+out:
+	mutex_unlock(&scm_data->admin_command.lock);
+	return rc;
+}
+
+int scm_request_controller_dump(struct scm_data *scm_data)
+{
+	int rc;
+	u64 busy = 1;
+
+	rc = ocxl_global_mmio_set64(scm_data->ocxl_afu, GLOBAL_MMIO_CHIC,
+				    OCXL_LITTLE_ENDIAN,
+				    GLOBAL_MMIO_CHI_CDA);
+
+
+	rc = ocxl_global_mmio_set64(scm_data->ocxl_afu, GLOBAL_MMIO_HCI,
+				    OCXL_LITTLE_ENDIAN,
+				    GLOBAL_MMIO_HCI_CONTROLLER_DUMP);
+	if (rc)
+		return rc;
+
+	while (busy) {
+		rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+					     GLOBAL_MMIO_HCI,
+					     OCXL_LITTLE_ENDIAN, &busy);
+		if (rc)
+			return rc;
+
+		busy &= GLOBAL_MMIO_HCI_CONTROLLER_DUMP;
+		cond_resched();
+	}
+
+	return 0;
+}
+
+static int scm_ioctl_controller_dump_complete(struct scm_data *scm_data)
+{
+	return ocxl_global_mmio_set64(scm_data->ocxl_afu, GLOBAL_MMIO_HCI,
+				    OCXL_LITTLE_ENDIAN,
+				    GLOBAL_MMIO_HCI_CONTROLLER_DUMP_COLLECTED);
+}
+
 static long scm_file_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long args)
 {
@@ -699,7 +817,21 @@ static long scm_file_ioctl(struct file *file, unsigned int cmd,
 		rc = scm_ioctl_error_log(scm_data,
 					 (struct scm_ioctl_error_log __user *)args);
 		break;
+
+	case SCM_IOCTL_CONTROLLER_DUMP:
+		rc = scm_request_controller_dump(scm_data);
+		break;
+
+	case SCM_IOCTL_CONTROLLER_DUMP_DATA:
+		rc = scm_ioctl_controller_dump_data(scm_data,
+						    (struct scm_ioctl_controller_dump_data __user *)args);
+		break;
+
+	case SCM_IOCTL_CONTROLLER_DUMP_COMPLETE:
+		rc = scm_ioctl_controller_dump_complete(scm_data);
+		break;
 	}
+
 	return rc;
 }
 
diff --git a/include/uapi/nvdimm/ocxl-scm.h b/include/uapi/nvdimm/ocxl-scm.h
index b34dd1ba06ff..abd2dc9ea112 100644
--- a/include/uapi/nvdimm/ocxl-scm.h
+++ b/include/uapi/nvdimm/ocxl-scm.h
@@ -38,9 +38,24 @@ struct scm_ioctl_error_log {
 	__u8 *buf; // pointer to output buffer
 };
 
+struct scm_ioctl_controller_dump_data {
+	__u8 *buf; // pointer to output buffer
+	__u16 buf_size; /* in/out, buffer size provided/required.
+			 * If required is greater than provided, the buffer
+			 * will be truncated to the amount provided. If its
+			 * less, then only the required bytes will be populated.
+			 * If it is 0, then there is no more dump data available.
+			 */
+	__u32 offset; // in, Offset within the dump
+	__u64 reserved[8];
+};
+
 /* ioctl numbers */
 #define SCM_MAGIC 0x5C
 /* SCM devices */
 #define SCM_IOCTL_ERROR_LOG	_IOWR(SCM_MAGIC, 0x01, struct scm_ioctl_error_log)
+#define SCM_IOCTL_CONTROLLER_DUMP _IO(SCM_MAGIC, 0x02)
+#define SCM_IOCTL_CONTROLLER_DUMP_DATA _IOWR(SCM_MAGIC, 0x03, struct scm_ioctl_controller_dump_data)
+#define SCM_IOCTL_CONTROLLER_DUMP_COMPLETE _IO(SCM_MAGIC, 0x04)
 
 #endif /* _UAPI_OCXL_SCM_H */
-- 
2.23.0

