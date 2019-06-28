Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B15CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E4220B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561683050;
	bh=Bm1hn3WUSTQUL8gOX/XcUFULZv+CUcwbYSwZ21raHB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HJu/wr19NNFiOGlWPzpb9cR2+gJqDYJlIzj1cdxjhOsqKfL+RORzA9UY+PcVGaHSt
	 Pa/KvyEDNcf4cITatT5wJ3xwpDdJrD+8R20uQXNp6eRwSJx2ShTpR7n4KgWhGXrFfL
	 lM9OKqFOlwdWuhs6yACKDepQiKPOcsAGNUQKDjFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfF1Aus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:50:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45054 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbfF1Aur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:50:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so2047994pfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 17:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3QsqgjppNoRqVMVUzDD6R+n+xqC7gpGu6izDLvFjBzc=;
        b=rvqd2I4F/URvaNy/MI3wHh45g9ZvPB3Ne3eKzJYPa5SyYU5CIjAD1cYpDeGzHaDYhW
         WZdECtDpTUjL23WyibRYgXiw7jRsbL2RsJLEgbX+3veyDu4s4WlY/KZbLmCISOdBENxZ
         F3K7KnDk1osllv6ij5/HwqVxC4Um2N59iAz8Jhd2shro7RVQ9VCjuWmofMrT369f3ykI
         s90q4NSr8K0LTeujuKcmNAbYFpObWbaYxbUI9PuD6HqywGqYIrjjgLb2hDMYOCc0mkKf
         I4chNmOg0nPJ5P86ocOg3cP8sO49vx0K4bGNJqhVvnposYmsaiCgiwFrJo3ZXlTILIM1
         apzQ==
X-Gm-Message-State: APjAAAU70pkgetSR5zZ11wKuFXVfyWu6iQ6IL46n6tQdaZuS2XeoZNtP
        EGMk9dbC/7qEagjvOER8KIG75g==
X-Google-Smtp-Source: APXvYqyucLbjxxsIuwJrF1wIvOTOksJ63dskV4JjA7s1YJoefKAR0BrD9iJ21KiGB4kGeFh1umrzHA==
X-Received: by 2002:a17:90a:30e4:: with SMTP id h91mr9188812pjb.37.1561683046125;
        Thu, 27 Jun 2019 17:50:46 -0700 (PDT)
Received: from localhost (c-76-21-109-208.hsd1.ca.comcast.net. [76.21.109.208])
        by smtp.gmail.com with ESMTPSA id 25sm273021pfp.76.2019.06.27.17.50.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 17:50:44 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>, Luwei Kang <luwei.kang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 14/15] fpga: dfl: fme: add capability sysfs interfaces
Date:   Thu, 27 Jun 2019 17:49:50 -0700
Message-Id: <20190628004951.6202-15-mdf@kernel.org>
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

This patch adds 3 read-only sysfs interfaces for FPGA Management Engine
(FME) block for capabilities including cache_size, fabric_version and
socket_id.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 .../ABI/testing/sysfs-platform-dfl-fme        | 23 +++++++++
 drivers/fpga/dfl-fme-main.c                   | 48 +++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
index 8fa4febfa4b2..99cd3b2acff5 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
@@ -21,3 +21,26 @@ Contact:	Wu Hao <hao.wu@intel.com>
 Description:	Read-only. It returns Bitstream (static FPGA region) meta
 		data, which includes the synthesis date, seed and other
 		information of this static FPGA region.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/cache_size
+Date:		June 2019
+KernelVersion:  5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns cache size of this FPGA device.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/fabric_version
+Date:		June 2019
+KernelVersion:  5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns fabric version of this FPGA device.
+		Userspace applications need this information to select
+		best data channels per different fabric design.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/socket_id
+Date:		June 2019
+KernelVersion:  5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns socket_id to indicate which socket
+		this FPGA belongs to, only valid for integrated solution.
+		User only needs this information, in case standard numa node
+		can't provide correct information.
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 38c6342e1865..2d69b8fd0137 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -75,10 +75,58 @@ static ssize_t bitstream_metadata_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(bitstream_metadata);
 
+static ssize_t cache_size_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+
+	v = readq(base + FME_HDR_CAP);
+
+	return sprintf(buf, "%u\n",
+		       (unsigned int)FIELD_GET(FME_CAP_CACHE_SIZE, v));
+}
+static DEVICE_ATTR_RO(cache_size);
+
+static ssize_t fabric_version_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+
+	v = readq(base + FME_HDR_CAP);
+
+	return sprintf(buf, "%u\n",
+		       (unsigned int)FIELD_GET(FME_CAP_FABRIC_VERID, v));
+}
+static DEVICE_ATTR_RO(fabric_version);
+
+static ssize_t socket_id_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+
+	v = readq(base + FME_HDR_CAP);
+
+	return sprintf(buf, "%u\n",
+		       (unsigned int)FIELD_GET(FME_CAP_SOCKET_ID, v));
+}
+static DEVICE_ATTR_RO(socket_id);
+
 static const struct attribute *fme_hdr_attrs[] = {
 	&dev_attr_ports_num.attr,
 	&dev_attr_bitstream_id.attr,
 	&dev_attr_bitstream_metadata.attr,
+	&dev_attr_cache_size.attr,
+	&dev_attr_fabric_version.attr,
+	&dev_attr_socket_id.attr,
 	NULL,
 };
 
-- 
2.22.0

