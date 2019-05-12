Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C942FC04AB1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9525E2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCKgYtIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfELB0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 21:26:16 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54475 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfELBZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:25:52 -0400
Received: by mail-it1-f194.google.com with SMTP id a190so15170227ite.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 18:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Quaedvq3gCPPNDemFqjgPMgNa8XiOI9kX1OdXaei5M=;
        b=GCKgYtIJk37fQcWn2CVOj7WsDgbDIndhJYzN62szv8pN47399ZAusxkq+4/+xFQkRf
         ZrYruufgX3eRbgYUx2qGklCshp3HU8ppV1OOceFt8sqvB63MAoBTTf6dh4G8Qj+OvaxJ
         MR0a0rgw6mplkQUf9LopWAgkoqMZ7gVEtBgjN5htRe/sa1mAdP465FQ2zoFrrolh8dei
         l4HI9+Yzn2hJ7Az4XqQRpKG+adZl4d+Rl3Qv7lL1hg7heBxuq1Nwb8xjJtJEtVL61t9Q
         3JJ3W8QWlcVJbqWX4AOGFfZkNRsxEyYmDIe3To5R9fNQ34wKin+ECCU/whDlKsFuXwv1
         HrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Quaedvq3gCPPNDemFqjgPMgNa8XiOI9kX1OdXaei5M=;
        b=W7w+ktyCOdc/SfBr0FA69hVg6l/R7L79DVBjgdD63nBKd+c3utVyAf2x+2M6rDj/ta
         U7o/FHkAIj/lGv6bUDMLGVNj8MwilZidu16ZFwiPCUX/3iRIv+9/d5rJzHCliMfrHOD6
         vpQxp7H/icsx7CBLHYY58BT7hRkanZr3oTfX9JU9i6yt6WB2LxtJAdGVlcUdd8UrZPbT
         qiSVMW9IC0xZ10lszdj9+8T7oVWU7cpyg20cEOsKonz8qalEiDKqvxyxi3D/y+ZxetVv
         qAme7FxV6JInHRJYFognwUalJlTFAsB7Wfi3FDgmV7/Q3w5x2lMC/0tTU0NH6wuhh9Jw
         7dyg==
X-Gm-Message-State: APjAAAXad25WHQl40AJ7OAitZF0EJlyM/+oMQGju2yp1/r7oHcLdrgNv
        EBydfl7pVGb80nFMsqY3OKNV1Q==
X-Google-Smtp-Source: APXvYqwZGfsq7V7IM3ATUUt1CWbGnJlCdw0D9Dd9Dcryjass4N3oSsRfmx/6CfiOBYsT6MGfAo1FjQ==
X-Received: by 2002:a24:6787:: with SMTP id u129mr1226156itc.112.1557624351110;
        Sat, 11 May 2019 18:25:51 -0700 (PDT)
Received: from shibby.hil-lafwehx.chi.wayport.net (hampton-inn.wintek.com. [72.12.199.50])
        by smtp.gmail.com with ESMTPSA id u134sm1579013itb.32.2019.05.11.18.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 18:25:50 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org, sridhar.samudrala@intel.com,
        jakub.kicinski@netronome.com, daniel@iogearbox.net,
        mcroce@redhat.com, j.neuschaefer@gmx.net
Cc:     syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>
Subject: [PATCH 15/18] soc: qcom: ipa: support build of IPA code
Date:   Sat, 11 May 2019 20:25:05 -0500
Message-Id: <20190512012508.10608-16-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512012508.10608-1-elder@linaro.org>
References: <20190512012508.10608-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add build and Kconfig support for the Qualcomm IPA driver.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/Kconfig      |  2 ++
 drivers/net/Makefile     |  1 +
 drivers/net/ipa/Kconfig  | 16 ++++++++++++++++
 drivers/net/ipa/Makefile |  7 +++++++
 4 files changed, 26 insertions(+)
 create mode 100644 drivers/net/ipa/Kconfig
 create mode 100644 drivers/net/ipa/Makefile

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 7a96d168efc4..0603fde43d54 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -387,6 +387,8 @@ source "drivers/net/fddi/Kconfig"
 
 source "drivers/net/hippi/Kconfig"
 
+source "drivers/net/ipa/Kconfig"
+
 config NET_SB1000
 	tristate "General Instruments Surfboard 1000"
 	depends on PNP
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 21cde7e78621..c01f48badba6 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_ETHERNET) += ethernet/
 obj-$(CONFIG_FDDI) += fddi/
 obj-$(CONFIG_HIPPI) += hippi/
 obj-$(CONFIG_HAMRADIO) += hamradio/
+obj-$(CONFIG_IPA) += ipa/
 obj-$(CONFIG_PLIP) += plip/
 obj-$(CONFIG_PPP) += ppp/
 obj-$(CONFIG_PPP_ASYNC) += ppp/
diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
new file mode 100644
index 000000000000..b1e3f7405992
--- /dev/null
+++ b/drivers/net/ipa/Kconfig
@@ -0,0 +1,16 @@
+config IPA
+	tristate "Qualcomm IPA support"
+	depends on NET
+	select QCOM_QMI_HELPERS
+	select QCOM_MDT_LOADER
+	default n
+	help
+	  Choose Y here to include support for the Qualcomm IP Accelerator
+	  (IPA), a hardware block present in some Qualcomm SoCs.  The IPA
+	  is a programmable protocol processor that is capable of generic
+	  hardware handling of IP packets, including routing, filtering,
+	  and NAT.  Currently the IPA driver supports only basic transport
+	  of network traffic between the AP and modem, on the Qualcomm
+	  SDM845 SoC.
+
+	  If unsure, say N.
diff --git a/drivers/net/ipa/Makefile b/drivers/net/ipa/Makefile
new file mode 100644
index 000000000000..a43039c09a25
--- /dev/null
+++ b/drivers/net/ipa/Makefile
@@ -0,0 +1,7 @@
+obj-$(CONFIG_IPA)	+=	ipa.o
+
+ipa-y			:=	ipa_main.o ipa_clock.o ipa_mem.o \
+				ipa_interrupt.o gsi.o gsi_trans.o \
+				ipa_gsi.o ipa_smp2p.o ipa_uc.o \
+				ipa_endpoint.o ipa_cmd.o ipa_netdev.o \
+				ipa_qmi.o ipa_qmi_msg.o ipa_data-sdm845.o
-- 
2.20.1

