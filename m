Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263ABC17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B3B21783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nK1MPR3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfKKVe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 16:34:57 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46074 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKKVe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:34:56 -0500
Received: by mail-qk1-f195.google.com with SMTP id q70so12517012qke.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 13:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqRT2zB36D0UiTUydvSwzR+TVY4Rzn1+x2E/5+jgQiw=;
        b=nK1MPR3Iz6j591oHVOXiWzJo6ZzwCbx31o98EFFM9IT+yrR4FYE6FD1RO96lpaZ0iE
         UCkFePRMCESnisYT2yHDpDc9e+lS8FNn9OdpKkuSJGvueqxNxpInm1na+j4PHVDPZoO6
         5BkxPnsVFoAq6M66D9rYSck9Lo3fY8MqrVWl3xdX1fd656BUyc9XxTwR9hhzBKvMXIWz
         sPgrhqEvujBQUrFfWLEwQc9tEsmMqc1/ZTTW2sFkgscO/XTOW5qhavpMePuy8aRAEeqV
         f14+F9SvK3IdnZNkvXMAMjEbhK+e3BLmHpaqNvsZ7uYYfR9wS1qIucK6m9oh3MVDuu2a
         yNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqRT2zB36D0UiTUydvSwzR+TVY4Rzn1+x2E/5+jgQiw=;
        b=slhTWy5Xgw1pxHgQzglO7pVu23aMBXTHpZs/ayDArB3B9d2WdLbM1oOX93gO1NMZ4b
         G13JS8LyzsKwlmrkzsn+8Yfk/VXxfaritaDUecvn0XRWTDSKdOK2bsPMKPWF3DSHAh+n
         e7gMJF+8ncHpuV/+F9vwflSebN6ozjqTq8xWNFUAz7aJ/D0GbP0A1aJNoI1C3MSXqXY/
         my5koAyw15wV47wLETP2rL85JEV5xTL2CKfBpr/BVz0l9OpWxDsd8/BaNU4YNBu2jeEc
         TnNlpByXYrtS42HlJpQ3unshLyNb4WS7uGqvIvW151Pdhdbzg1NJrLMn9v7Ehrnrj8Wr
         LjJg==
X-Gm-Message-State: APjAAAVD76QU0Uv8V85NLR7yAlmKt74XE22oGyr44oo2vb0OxCYYTXAH
        lAe0ZU/pdl4w8rRjJqz0uruOD1/h7fmUaQ==
X-Google-Smtp-Source: APXvYqwIfu1MgLTlK3zKMx8UKbqGzIiafEmoONOSvESOXY8xd7dqXxNCpHABuOil+jQM9Wx2Tl8JjQ==
X-Received: by 2002:a05:620a:128e:: with SMTP id w14mr12885169qki.246.1573508095584;
        Mon, 11 Nov 2019 13:34:55 -0800 (PST)
Received: from ovpn-125-1.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 32sm8908757qth.16.2019.11.11.13.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 13:34:54 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     rafael.j.wysocki@intel.com
Cc:     dave.hansen@linux.intel.com, dan.j.williams@intel.com,
        tglx@linutronix.de, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] acpi/numa/hmat: fix a section mismatch
Date:   Mon, 11 Nov 2019 16:34:26 -0500
Message-Id: <20191111213426.1415-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit cf8741ac57ed ("ACPI: NUMA: HMAT: Register "soft reserved"
memory as an "hmem" device") introduced a linker warning,

WARNING: vmlinux.o(.text+0x64ec3c): Section mismatch in reference from
the function hmat_register_target() to the function
.init.text:hmat_register_target_devices()
The function hmat_register_target() references
the function __init hmat_register_target_devices().
This is often because hmat_register_target lacks a __init
annotation or the annotation of hmat_register_target_devices is wrong.

Since hmat_register_target() is also called from hmat_callback(), and
then register_hotmemory_notifier() where it should not be freed when
hmat_init() is done, it indicates the annotation of
hmat_register_target_devices() is incorrect.

Fixes: cf8741ac57ed ("ACPI: NUMA: HMAT: Register "soft reserved" memory as an "hmem" device")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/acpi/numa/hmat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 42cafeaac336..600ae3babd15 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -694,7 +694,7 @@ static void hmat_register_target_device(struct memory_target *target,
 	memregion_free(id);
 }
 
-static __init void hmat_register_target_devices(struct memory_target *target)
+static void hmat_register_target_devices(struct memory_target *target)
 {
 	struct resource *res;
 
-- 
2.21.0 (Apple Git-122.2)

