Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AB6C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CF920B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561683040;
	bh=HTXUDiI2XJzn0haedlcigLgWr+KSG9nPGlB4vG0jnts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a0XUBu+ReYOvzoHgrBOYYnJTCpNL6R6B1qoCMUudd6wAmA2O6niqfV44xz2QcqDHD
	 LBWNjPET5RVZDXb1ahxgsn9RFaQ5b9E7kjRF+FQf3dWNdzuUIn26FdFPDNn9Gpn3Pf
	 tXu8Er75lZQawkJgmTZqHOIyotb9LQI5bXlLQD0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfF1Auj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:50:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46566 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfF1Aue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:50:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so2189743pls.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 17:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATRG1e875qwxAq0JAR3n412xOJaexDE+GFlNI7EJgQs=;
        b=EcDI4oitmmVFajl4N/ForA3vKp1W4K1wLngEnrPEovK1KDvqiJZwrTRqHpuEuKfPQ5
         kQQMWcZKCf8U595sCwvFa3i+sjKLh2k9Zsk0iGat6c65XG2Ux7ftF/ecDnjOaFfhEpGl
         qGdjw66XJH8/KteLrbm+vLT+lt9l5KYb+5/qd+6pTS8+ha0yP3bWieZltjCUTzF0kg0P
         /ti0d19MOkObHMv/qQMQ8pGSVa78+smtOcq6/uTscT1McpybbQqPkrP/zReRhHkaamdc
         31bFdOffScVLMbZee5OedJnRKrtFmvShpZeOlsJSdt5+Yz5L3Nyie91TJiyMActtn41P
         fgvw==
X-Gm-Message-State: APjAAAXXvV8O8u+DioRikD08hrP9L+Ckx96nFMRDB9ezBhowbmweYqaW
        CuWyzFbDi6/iMWDP3PKH5Zzn1Q==
X-Google-Smtp-Source: APXvYqymoR2R/YVUjJDVKzMbHtTtRtY6+tP5pvBHVbzzxFk2JcWohZn6gNhNjoZIYXVsOJa5EjNb8w==
X-Received: by 2002:a17:902:4c:: with SMTP id 70mr8006989pla.308.1561683033338;
        Thu, 27 Jun 2019 17:50:33 -0700 (PDT)
Received: from localhost (c-76-21-109-208.hsd1.ca.comcast.net. [76.21.109.208])
        by smtp.gmail.com with ESMTPSA id f10sm260084pgq.73.2019.06.27.17.50.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 17:50:31 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 08/15] fpga: dfl: afu: add AFU state related sysfs interfaces
Date:   Thu, 27 Jun 2019 17:49:44 -0700
Message-Id: <20190628004951.6202-9-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628004951.6202-1-mdf@kernel.org>
References: <20190628004951.6202-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu Hao <hao.wu@intel.com>

This patch introduces more sysfs interfaces for Accelerated
Function Unit (AFU). These interfaces allow users to read
current AFU Power State (APx), read / clear AFU Power (APx)
events which are sticky to identify transient APx state,
and manage AFU's LTR (latency tolerance reporting).

Signed-off-by: Ananda Ravuri <ananda.ravuri@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 .../ABI/testing/sysfs-platform-dfl-port       |  30 ++++
 drivers/fpga/dfl-afu-main.c                   | 140 ++++++++++++++++++
 drivers/fpga/dfl.h                            |  11 ++
 3 files changed, 181 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-port b/Documentation/ABI/testing/sysfs-platform-dfl-port
index 6a92dda517b0..17b37d110618 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-port
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-port
@@ -14,3 +14,33 @@ Description:	Read-only. User can program different PR bitstreams to FPGA
 		Accelerator Function Unit (AFU) for different functions. It
 		returns uuid which could be used to identify which PR bitstream
 		is programmed in this AFU.
+
+What:		/sys/bus/platform/devices/dfl-port.0/power_state
+Date:		June 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It reports the APx (AFU Power) state, different APx
+		means different throttling level. When reading this file, it
+		returns "0" - Normal / "1" - AP1 / "2" - AP2 / "6" - AP6.
+
+What:		/sys/bus/platform/devices/dfl-port.0/ap1_event
+Date:		June 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-write. Read or set 1 to clear AP1 (AFU Power State 1)
+		event. It's used to indicate transient AP1 state.
+
+What:		/sys/bus/platform/devices/dfl-port.0/ap2_event
+Date:		June 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-write. Read or set 1 to clear AP2 (AFU Power State 2)
+		event. It's used to indicate transient AP2 state.
+
+What:		/sys/bus/platform/devices/dfl-port.0/ltr
+Date:		June 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-write. Read and set AFU latency tolerance reporting value.
+		Set ltr to 1 if the AFU can tolerate latency >= 40us or set it
+		to 0 if it is latency sensitive.
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 02baa6a227c0..040ed8ad16e5 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -21,6 +21,8 @@
 
 #include "dfl-afu.h"
 
+#define DRV_VERSION	"0.8"
+
 /**
  * port_enable - enable a port
  * @pdev: port platform device.
@@ -141,8 +143,145 @@ id_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(id);
 
+static ssize_t
+ltr_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+	v = readq(base + PORT_HDR_CTRL);
+	mutex_unlock(&pdata->lock);
+
+	return sprintf(buf, "%x\n", (u8)FIELD_GET(PORT_CTRL_LATENCY, v));
+}
+
+static ssize_t
+ltr_store(struct device *dev, struct device_attribute *attr,
+	  const char *buf, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u8 ltr;
+	u64 v;
+
+	if (kstrtou8(buf, 0, &ltr) || ltr > 1)
+		return -EINVAL;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+	v = readq(base + PORT_HDR_CTRL);
+	v &= ~PORT_CTRL_LATENCY;
+	v |= FIELD_PREP(PORT_CTRL_LATENCY, ltr);
+	writeq(v, base + PORT_HDR_CTRL);
+	mutex_unlock(&pdata->lock);
+
+	return count;
+}
+static DEVICE_ATTR_RW(ltr);
+
+static ssize_t
+ap1_event_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+	v = readq(base + PORT_HDR_STS);
+	mutex_unlock(&pdata->lock);
+
+	return sprintf(buf, "%x\n", (u8)FIELD_GET(PORT_STS_AP1_EVT, v));
+}
+
+static ssize_t
+ap1_event_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u8 ap1_event;
+
+	if (kstrtou8(buf, 0, &ap1_event) || ap1_event != 1)
+		return -EINVAL;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+	writeq(PORT_STS_AP1_EVT, base + PORT_HDR_STS);
+	mutex_unlock(&pdata->lock);
+
+	return count;
+}
+static DEVICE_ATTR_RW(ap1_event);
+
+static ssize_t
+ap2_event_show(struct device *dev, struct device_attribute *attr,
+	       char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+	v = readq(base + PORT_HDR_STS);
+	mutex_unlock(&pdata->lock);
+
+	return sprintf(buf, "%x\n", (u8)FIELD_GET(PORT_STS_AP2_EVT, v));
+}
+
+static ssize_t
+ap2_event_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u8 ap2_event;
+
+	if (kstrtou8(buf, 0, &ap2_event) || ap2_event != 1)
+		return -EINVAL;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+	writeq(PORT_STS_AP2_EVT, base + PORT_HDR_STS);
+	mutex_unlock(&pdata->lock);
+
+	return count;
+}
+static DEVICE_ATTR_RW(ap2_event);
+
+static ssize_t
+power_state_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+	v = readq(base + PORT_HDR_STS);
+	mutex_unlock(&pdata->lock);
+
+	return sprintf(buf, "0x%x\n", (u8)FIELD_GET(PORT_STS_PWR_STATE, v));
+}
+static DEVICE_ATTR_RO(power_state);
+
 static const struct attribute *port_hdr_attrs[] = {
 	&dev_attr_id.attr,
+	&dev_attr_ltr.attr,
+	&dev_attr_ap1_event.attr,
+	&dev_attr_ap2_event.attr,
+	&dev_attr_power_state.attr,
 	NULL,
 };
 
@@ -634,3 +773,4 @@ MODULE_DESCRIPTION("FPGA Accelerated Function Unit driver");
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:dfl-port");
+MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 1350e8eb9e59..1525098b8260 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -119,6 +119,7 @@
 #define PORT_HDR_NEXT_AFU	NEXT_AFU
 #define PORT_HDR_CAP		0x30
 #define PORT_HDR_CTRL		0x38
+#define PORT_HDR_STS		0x40
 
 /* Port Capability Register Bitfield */
 #define PORT_CAP_PORT_NUM	GENMASK_ULL(1, 0)	/* ID of this port */
@@ -130,6 +131,16 @@
 /* Latency tolerance reporting. '1' >= 40us, '0' < 40us.*/
 #define PORT_CTRL_LATENCY	BIT_ULL(2)
 #define PORT_CTRL_SFTRST_ACK	BIT_ULL(4)		/* HW ack for reset */
+
+/* Port Status Register Bitfield */
+#define PORT_STS_AP2_EVT	BIT_ULL(13)		/* AP2 event detected */
+#define PORT_STS_AP1_EVT	BIT_ULL(12)		/* AP1 event detected */
+#define PORT_STS_PWR_STATE	GENMASK_ULL(11, 8)	/* AFU power states */
+#define PORT_STS_PWR_STATE_NORM 0
+#define PORT_STS_PWR_STATE_AP1	1			/* 50% throttling */
+#define PORT_STS_PWR_STATE_AP2	2			/* 90% throttling */
+#define PORT_STS_PWR_STATE_AP6	6			/* 100% throttling */
+
 /**
  * struct dfl_fpga_port_ops - port ops
  *
-- 
2.22.0

