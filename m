Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7754EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449EB2071F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLCDta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 22:49:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726896AbfLCDsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 22:48:31 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB33klOD006802
        for <linux-kernel@vger.kernel.org>; Mon, 2 Dec 2019 22:48:30 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wm6cy9se1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 22:48:30 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Tue, 3 Dec 2019 03:48:26 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Dec 2019 03:48:20 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB33mJe930998776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Dec 2019 03:48:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2870F4C052;
        Tue,  3 Dec 2019 03:48:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 802D44C046;
        Tue,  3 Dec 2019 03:48:18 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Dec 2019 03:48:18 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 5663FA03E6;
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
Subject: [PATCH v2 18/27] nvdimm/ocxl: Add an IOCTL to report controller statistics
Date:   Tue,  3 Dec 2019 14:46:46 +1100
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203034655.51561-1-alastair@au1.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120303-0016-0000-0000-000002D0158D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120303-0017-0000-0000-000033320CA8
Message-Id: <20191203034655.51561-19-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=1 bulkscore=0 phishscore=0
 mlxlogscore=712 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

The controller can report a number of statistics that are useful
in evaluating the performance and reliability of the card.

This patch exposes this information via an IOCTL.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/nvdimm/ocxl/scm.c      | 185 +++++++++++++++++++++++++++++++++
 include/uapi/nvdimm/ocxl-scm.h |  17 +++
 2 files changed, 202 insertions(+)

diff --git a/drivers/nvdimm/ocxl/scm.c b/drivers/nvdimm/ocxl/scm.c
index a520f209d626..54a2bac1cab7 100644
--- a/drivers/nvdimm/ocxl/scm.c
+++ b/drivers/nvdimm/ocxl/scm.c
@@ -806,6 +806,186 @@ static int scm_ioctl_controller_dump_complete(struct scm_data *scm_data)
 				    GLOBAL_MMIO_HCI_CONTROLLER_DUMP_COLLECTED);
 }
 
+/**
+ * scm_controller_stats_header_parse() - Parse the first 64 bits of the controller stats admin command response
+ * @scm_data: the SCM metadata
+ * @length: out, returns the number of bytes in the response (excluding the 64 bit header)
+ */
+static int scm_controller_stats_header_parse(struct scm_data *scm_data,
+	u32 *length)
+{
+	int rc;
+	u64 val;
+
+	u16 data_identifier;
+	u32 data_length;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset,
+				     OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		return rc;
+
+	data_identifier = val >> 48;
+	data_length = val & 0xFFFFFFFF;
+
+	if (data_identifier != 0x4353) {
+		dev_err(&scm_data->dev,
+			"Bad data identifier for controller stats, expected 'CS', got '%-.*s'\n",
+			2, (char *)&data_identifier);
+		return -EINVAL;
+	}
+
+	*length = data_length;
+	return 0;
+}
+
+static int scm_ioctl_controller_stats(struct scm_data *scm_data,
+				      struct scm_ioctl_controller_stats __user *uarg)
+{
+	struct scm_ioctl_controller_stats args;
+	u32 length;
+	int rc;
+	u64 val;
+
+	memset(&args, '\0', sizeof(args));
+
+	mutex_lock(&scm_data->admin_command.lock);
+
+	rc = scm_admin_command_request(scm_data, ADMIN_COMMAND_CONTROLLER_STATS);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_write64(scm_data->ocxl_afu,
+				      scm_data->admin_command.request_offset + 0x08,
+				      OCXL_LITTLE_ENDIAN, 0);
+	if (rc)
+		goto out;
+
+	rc = scm_admin_command_execute(scm_data);
+	if (rc)
+		goto out;
+
+
+	rc = scm_admin_command_complete_timeout(scm_data,
+						ADMIN_COMMAND_CONTROLLER_STATS);
+	if (rc < 0) {
+		dev_warn(&scm_data->dev, "Controller stats timed out\n");
+		goto out;
+	}
+
+	rc = scm_admin_response(scm_data);
+	if (rc < 0)
+		goto out;
+	if (rc != STATUS_SUCCESS) {
+		scm_warn_status(scm_data,
+				"Unexpected status from controller stats", rc);
+		goto out;
+	}
+
+	rc = scm_controller_stats_header_parse(scm_data, &length);
+	if (rc)
+		goto out;
+
+	if (length != 0x140)
+		scm_warn_status(scm_data,
+				"Unexpected length for controller stats data, expected 0x140, got 0x%x",
+				length);
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x08,
+				     OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		goto out;
+
+	args.reset_count = val >> 32;
+	args.reset_uptime = val & 0xFFFFFFFF;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x10,
+				     OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		goto out;
+
+	args.power_on_uptime = val >> 32;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x08,
+				     OCXL_LITTLE_ENDIAN, &args.host_load_count);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x10,
+				     OCXL_LITTLE_ENDIAN, &args.host_store_count);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x18,
+				     OCXL_LITTLE_ENDIAN, &args.media_read_count);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x20,
+				     OCXL_LITTLE_ENDIAN, &args.media_write_count);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x28,
+				     OCXL_LITTLE_ENDIAN, &args.cache_hit_count);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x30,
+				     OCXL_LITTLE_ENDIAN, &args.cache_miss_count);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x38,
+				     OCXL_LITTLE_ENDIAN, &args.media_read_latency);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x40,
+				     OCXL_LITTLE_ENDIAN, &args.media_write_latency);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x48,
+				     OCXL_LITTLE_ENDIAN, &args.cache_read_latency);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x50,
+				     OCXL_LITTLE_ENDIAN, &args.cache_write_latency);
+	if (rc)
+		goto out;
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
+	rc = 0;
+	goto out;
+
+out:
+	mutex_unlock(&scm_data->admin_command.lock);
+	return rc;
+}
+
 static long scm_file_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long args)
 {
@@ -830,6 +1010,11 @@ static long scm_file_ioctl(struct file *file, unsigned int cmd,
 	case SCM_IOCTL_CONTROLLER_DUMP_COMPLETE:
 		rc = scm_ioctl_controller_dump_complete(scm_data);
 		break;
+
+	case SCM_IOCTL_CONTROLLER_STATS:
+		rc = scm_ioctl_controller_stats(scm_data,
+						(struct scm_ioctl_controller_stats __user *)args);
+		break;
 	}
 
 	return rc;
diff --git a/include/uapi/nvdimm/ocxl-scm.h b/include/uapi/nvdimm/ocxl-scm.h
index abd2dc9ea112..0a5de46c5acd 100644
--- a/include/uapi/nvdimm/ocxl-scm.h
+++ b/include/uapi/nvdimm/ocxl-scm.h
@@ -50,6 +50,22 @@ struct scm_ioctl_controller_dump_data {
 	__u64 reserved[8];
 };
 
+struct scm_ioctl_controller_stats {
+	__u32 reset_count;
+	__u32 reset_uptime; // seconds
+	__u32 power_on_uptime; // seconds
+	__u64 host_load_count;
+	__u64 host_store_count;
+	__u64 media_read_count;
+	__u64 media_write_count;
+	__u64 cache_hit_count;
+	__u64 cache_miss_count;
+	__u64 media_read_latency; // nanoseconds
+	__u64 media_write_latency; // nanoseconds
+	__u64 cache_read_latency; // nanoseconds
+	__u64 cache_write_latency; // nanoseconds
+};
+
 /* ioctl numbers */
 #define SCM_MAGIC 0x5C
 /* SCM devices */
@@ -57,5 +73,6 @@ struct scm_ioctl_controller_dump_data {
 #define SCM_IOCTL_CONTROLLER_DUMP _IO(SCM_MAGIC, 0x02)
 #define SCM_IOCTL_CONTROLLER_DUMP_DATA _IOWR(SCM_MAGIC, 0x03, struct scm_ioctl_controller_dump_data)
 #define SCM_IOCTL_CONTROLLER_DUMP_COMPLETE _IO(SCM_MAGIC, 0x04)
+#define SCM_IOCTL_CONTROLLER_STATS _IO(SCM_MAGIC, 0x05)
 
 #endif /* _UAPI_OCXL_SCM_H */
-- 
2.23.0

