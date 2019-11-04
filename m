Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FCACA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49EF2080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yK3rgZ6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbfKDSNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:13:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35755 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729581AbfKDSNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:13:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id d13so12854374pfq.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2TYCPoaBU+FOY9wFLOA8g8gCr6xKGu2mGQ2/GrP3thc=;
        b=yK3rgZ6yZD3RNfOAUT5KKC7wvdg3eQXm0qjVkejDULzy2iZuRlmvREq3bbhUpdK1yS
         khALmRPYxY4dlRY+isX9N4agFR4UoTPsKwD/6vsAIqMDfeWxfvaKoMPf7chzzc5q+54R
         vEB2N2EuUUUbnGG5bMEjscAaxdC8YI8lQBdbHz+PCeQrjyVO+7JpmNQslY/XnMlDe1PW
         Wi2ydjh99cSMbKV58a+E6gX6sBCdrFuLjdvWRDZpVEILepT4at6fB49Yorc43Q9JXYXX
         TM+5i7xjPb7+QaGyNajUfII87qr1XfK7oIb9e5AbS9tvHPtcD8NSGbZTen6Tx9fNnMS7
         hD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2TYCPoaBU+FOY9wFLOA8g8gCr6xKGu2mGQ2/GrP3thc=;
        b=hOoEiqDs+UFrihBmn/qOS91jy1fsYJVbcTmXRDK59hesmywFeno20Mur3ZRMbzXJ7I
         oQUI9HykvHAaTeCZU56GE1Ftict7FB5SMD9GSpGUt7RzZ/GS27V0Hlq/eD6GoJDPycwA
         RcQzdJjY0Dc9v9htBRxQy3cLUwWBk0wQPhY9WMPM5Pt+agvzneoFm3e0ts4WaE/Za2bq
         zojmjZUSZ3VOVC4rxSDYW/b5X9+CnO8U1fGEDT4s6mk/bA++BgTuy8pvE1ux2s1NM4Wj
         VRrVI5SIEbdeshL0FzD9wAf3/u6UFRcmXOU12cyMuXJ7bJY0GDQ0upRQLbUNua1qOMGN
         ww/w==
X-Gm-Message-State: APjAAAVUWO9Fxrnph1LTPS3yuVc7GRO3pF9MnMklWQfTpEeAYkuZO0e3
        K0+q9imy7UwqOKZzcScJcqzJH+2fp6Q=
X-Google-Smtp-Source: APXvYqzIbPpB+G4swl5eLaUlXFMGgWmyLuweZFCx95myydLdnjzl5S79EzGVY2b2dknWdoG38ICkHA==
X-Received: by 2002:a63:3203:: with SMTP id y3mr31406523pgy.437.1572891183679;
        Mon, 04 Nov 2019 10:13:03 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o12sm16149520pgl.86.2019.11.04.10.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:13:03 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/14] coresight: etm4x: Add view comparator settings API to sysfs.
Date:   Mon,  4 Nov 2019 11:12:47 -0700
Message-Id: <20191104181251.26732-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104181251.26732-1-mathieu.poirier@linaro.org>
References: <20191104181251.26732-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

Currently it is not possible to view the current settings of a given
address comparator without knowing what type it is set to. For example, if
a comparator is set as an addr_start comparator, attempting to read
addr_stop for the same index will result in an error.

addr_cmp_view is added to allow the user to see the current settings of
the indexed address comparator without resorting to trial and error when
the set type is not known.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-sysfs.c         | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 1cfbddda0b4d..1768e7286a9e 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1275,6 +1275,57 @@ static ssize_t addr_exlevel_s_ns_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(addr_exlevel_s_ns);
 
+static const char * const addr_type_names[] = {
+	"unused",
+	"single",
+	"range",
+	"start",
+	"stop"
+};
+
+static ssize_t addr_cmp_view_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	u8 idx, addr_type;
+	unsigned long addr_v, addr_v2, addr_ctrl;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
+	int size = 0;
+	bool exclude = false;
+
+	spin_lock(&drvdata->spinlock);
+	idx = config->addr_idx;
+	addr_v = config->addr_val[idx];
+	addr_ctrl = config->addr_acc[idx];
+	addr_type = config->addr_type[idx];
+	if (addr_type == ETM_ADDR_TYPE_RANGE) {
+		if (idx & 0x1) {
+			idx -= 1;
+			addr_v2 = addr_v;
+			addr_v = config->addr_val[idx];
+		} else {
+			addr_v2 = config->addr_val[idx + 1];
+		}
+		exclude = config->viiectlr & BIT(idx / 2 + 16);
+	}
+	spin_unlock(&drvdata->spinlock);
+	if (addr_type) {
+		size = scnprintf(buf, PAGE_SIZE, "addr_cmp[%i] %s %#lx", idx,
+				 addr_type_names[addr_type], addr_v);
+		if (addr_type == ETM_ADDR_TYPE_RANGE) {
+			size += scnprintf(buf + size, PAGE_SIZE - size,
+					  " %#lx %s", addr_v2,
+					  exclude ? "exclude" : "include");
+		}
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  " ctrl(%#lx)\n", addr_ctrl);
+	} else {
+		size = scnprintf(buf, PAGE_SIZE, "addr_cmp[%i] unused\n", idx);
+	}
+	return size;
+}
+static DEVICE_ATTR_RO(addr_cmp_view);
+
 static ssize_t vinst_pe_cmp_start_stop_show(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
@@ -2120,6 +2171,7 @@ static struct attribute *coresight_etmv4_attrs[] = {
 	&dev_attr_addr_ctxtype.attr,
 	&dev_attr_addr_context.attr,
 	&dev_attr_addr_exlevel_s_ns.attr,
+	&dev_attr_addr_cmp_view.attr,
 	&dev_attr_vinst_pe_cmp_start_stop.attr,
 	&dev_attr_seq_idx.attr,
 	&dev_attr_seq_state.attr,
-- 
2.17.1

