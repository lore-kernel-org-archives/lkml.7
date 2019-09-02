Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502C9C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 05:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1590E21897
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 05:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cialufXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfIBFuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 01:50:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39697 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfIBFuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 01:50:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id s12so1383117pfe.6;
        Sun, 01 Sep 2019 22:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VHR2oUikhGymiq3l3JPn9qwh6SndWvo22AKhZbZsGIM=;
        b=cialufXNcKV8EuxIGCx/p8H3ino+76F5AJnlHGROi/dnpZo2D7BV37b4WI3I13UnpB
         anU2jXoBXqv+PT+iBCAyj5Gw150lp/UcP/Ikbf8JxQUK+GSwLFCBqe4ArQoqxtUxZFX6
         HSFalxecBr4wGbFmuXPX+guu3BOcQQ5XeSU3PFNrH4Yzg3x5zyRgcuduHnVxdlQq6k9G
         YmjGxsvVnXprGi3eu/nQNjGccBbDbqAGioWDACwUyZlMNtttZm95y7owZCoJS5R9CDcA
         E6YtNhuNcTeIsr6fVtntKQ/oNnBhXl9nJeMU/PTeXaJUd7LfcptNVNcwHOyVoTamKCGb
         jMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHR2oUikhGymiq3l3JPn9qwh6SndWvo22AKhZbZsGIM=;
        b=Cw7flty3HerFMpf4rG/5qANhZ6utZwidYrQxCc5ZvQle7exRttH67qi9FHcgq5XTb/
         /qGApeWWDVRBO/JF8nUwx5JRelen+kx4AE87SpjOUqe+PoyMBuRVIjMxfrw0goIvmoLV
         GvwnPJvAHmYDSA450Z3vNvthYH2hGiFo6XNPrgzY7GHJPE8w7ScI49rJoXI37DTay9rE
         kr+hHt19c6Jt+kH5SKyS6yYaJUa63/K4SCRqgkdbS191EAxQeb92yk5+Odd0DcwLnqPh
         xmGEFzUsCjMZgQrTWwoQkqN6DNqQgQQPAfINNXXg+At3qJ1+Z0MWbHI2d0RfPgtQxAJ7
         wBug==
X-Gm-Message-State: APjAAAWorE4LBNYZdIa9rgL7VUlyKyRdLJa0+fPO1t7ub8h/ImiqYVQ5
        Gmzzxs8Ye9TmKuf+o55id5g=
X-Google-Smtp-Source: APXvYqwmdUXPqi3ELKdd7JJ6ITxSjC1Cb8KnMkJcNc+1LyCD1qxliCCAz2zLAfU5/txxmlOJFyi6Aw==
X-Received: by 2002:a62:b412:: with SMTP id h18mr28505359pfn.175.1567403403285;
        Sun, 01 Sep 2019 22:50:03 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.203])
        by smtp.gmail.com with ESMTPSA id 136sm16533912pfz.123.2019.09.01.22.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 22:50:02 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv4-next 3/3] arm64: dts: meson: odroid-c2: Disable usb_otg bus to avoid power failed warning
Date:   Mon,  2 Sep 2019 05:49:35 +0000
Message-Id: <20190902054935.4899-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190902054935.4899-1-linux.amoon@gmail.com>
References: <20190902054935.4899-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_otg bus needs to get initialize from the u-boot to be configured
to used as power source to SBC or usb otg port will get configured
as host device. Right now this support is missing in the u-boot and
phy driver so to avoid power failed warning, we would disable this
feature  until proper fix is found.

[    2.716048] phy phy-c0000000.phy.0: USB ID detect failed!
[    2.720186] phy phy-c0000000.phy.0: phy poweron failed --> -22
[    2.726001] ------------[ cut here ]------------
[    2.730583] WARNING: CPU: 0 PID: 12 at drivers/regulator/core.c:2039 _regulator_put+0x3c/0xe8
[    2.738983] Modules linked in:
[    2.742005] CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.2.9-1-ARCH #1
[    2.748643] Hardware name: Hardkernel ODROID-C2 (DT)
[    2.753566] Workqueue: events deferred_probe_work_func
[    2.758649] pstate: 60000005 (nZCv daif -PAN -UAO)
[    2.763394] pc : _regulator_put+0x3c/0xe8
[    2.767361] lr : _regulator_put+0x3c/0xe8
[    2.771326] sp : ffff000011aa3a50
[    2.774604] x29: ffff000011aa3a50 x28: ffff80007ed1b600
[    2.779865] x27: ffff80007f7036a8 x26: ffff80007f7036a8
[    2.785126] x25: 0000000000000000 x24: ffff000011a44458
[    2.790387] x23: ffff000011344218 x22: 0000000000000009
[    2.795649] x21: ffff000011aa3b68 x20: ffff80007ed1b500
[    2.800910] x19: ffff80007ed1b500 x18: 0000000000000010
[    2.806171] x17: 000000005be5943c x16: 00000000f1c73b29
[    2.811432] x15: ffffffffffffffff x14: ffff0000117396c8
[    2.816694] x13: ffff000091aa37a7 x12: ffff000011aa37af
[    2.821955] x11: ffff000011763000 x10: ffff000011aa3730
[    2.827216] x9 : 00000000ffffffd0 x8 : ffff000010871760
[    2.832477] x7 : 00000000000000d0 x6 : ffff0000119d151b
[    2.837739] x5 : 000000000000000f x4 : 0000000000000000
[    2.843000] x3 : 0000000000000000 x2 : 38104b2678c20100
[    2.848261] x1 : 0000000000000000 x0 : 0000000000000024
[    2.853523] Call trace:
[    2.855940]  _regulator_put+0x3c/0xe8
[    2.859562]  regulator_put+0x34/0x48
[    2.863098]  regulator_bulk_free+0x40/0x58
[    2.867153]  devm_regulator_bulk_release+0x24/0x30
[    2.871896]  release_nodes+0x1f0/0x2e0
[    2.875604]  devres_release_all+0x64/0xa4
[    2.879571]  really_probe+0x1c8/0x3e0
[    2.883194]  driver_probe_device+0xe4/0x138
[    2.887334]  __device_attach_driver+0x90/0x110
[    2.891733]  bus_for_each_drv+0x8c/0xd8
[    2.895527]  __device_attach+0xdc/0x160
[    2.899322]  device_initial_probe+0x24/0x30
[    2.903463]  bus_probe_device+0x9c/0xa8
[    2.907258]  deferred_probe_work_func+0xa0/0xf0
[    2.911745]  process_one_work+0x1b4/0x408
[    2.915711]  worker_thread+0x54/0x4b8
[    2.919334]  kthread+0x12c/0x130
[    2.922526]  ret_from_fork+0x10/0x1c
[    2.926060] ---[ end trace 51a68f4c0035d6c0 ]---
[    2.930691] ------------[ cut here ]------------
[    2.935242] WARNING: CPU: 0 PID: 12 at drivers/regulator/core.c:2039 _regulator_put+0x3c/0xe8
[    2.943653] Modules linked in:
[    2.946675] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G        W         5.2.9-1-ARCH #1
[    2.954694] Hardware name: Hardkernel ODROID-C2 (DT)
[    2.959613] Workqueue: events deferred_probe_work_func
[    2.964700] pstate: 60000005 (nZCv daif -PAN -UAO)
[    2.969445] pc : _regulator_put+0x3c/0xe8
[    2.973412] lr : _regulator_put+0x3c/0xe8
[    2.977377] sp : ffff000011aa3a50
[    2.980655] x29: ffff000011aa3a50 x28: ffff80007ed1b600
[    2.985916] x27: ffff80007f7036a8 x26: ffff80007f7036a8
[    2.991177] x25: 0000000000000000 x24: ffff000011a44458
[    2.996439] x23: ffff000011344218 x22: 0000000000000009
[    3.001700] x21: ffff000011aa3b68 x20: ffff80007ed1bd00
[    3.006961] x19: ffff80007ed1bd00 x18: 0000000000000010
[    3.012222] x17: 000000005be5943c x16: 00000000f1c73b29
[    3.017484] x15: ffffffffffffffff x14: ffff0000117396c8
[    3.022745] x13: ffff000091aa37a7 x12: ffff000011aa37af
[    3.028006] x11: ffff000011763000 x10: ffff000011aa3730
[    3.033267] x9 : 00000000ffffffd0 x8 : ffff000010871760
[    3.038528] x7 : 00000000000000fd x6 : ffff0000119d151b
[    3.043790] x5 : 000000000000000f x4 : 0000000000000000
[    3.049051] x3 : 0000000000000000 x2 : 38104b2678c20100
[    3.054312] x1 : 0000000000000000 x0 : 0000000000000024
[    3.059574] Call trace:
[    3.061991]  _regulator_put+0x3c/0xe8
[    3.065613]  regulator_put+0x34/0x48
[    3.069149]  regulator_bulk_free+0x40/0x58
[    3.073203]  devm_regulator_bulk_release+0x24/0x30
[    3.077947]  release_nodes+0x1f0/0x2e0
[    3.081655]  devres_release_all+0x64/0xa4
[    3.085622]  really_probe+0x1c8/0x3e0
[    3.089245]  driver_probe_device+0xe4/0x138
[    3.093385]  __device_attach_driver+0x90/0x110
[    3.097784]  bus_for_each_drv+0x8c/0xd8
[    3.101578]  __device_attach+0xdc/0x160
[    3.105373]  device_initial_probe+0x24/0x30
[    3.109514]  bus_probe_device+0x9c/0xa8
[    3.113309]  deferred_probe_work_func+0xa0/0xf0
[    3.117796]  process_one_work+0x1b4/0x408
[    3.121762]  worker_thread+0x54/0x4b8
[    3.125384]  kthread+0x12c/0x130
[    3.128575]  ret_from_fork+0x10/0x1c
[    3.132110] ---[ end trace 51a68f4c0035d6c1 ]---
[    3.136753] dwc2: probe of c9000000.usb failed with error -22

Fixes: 5a0803bd5ae2 ("ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes")
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Rebased on linux-next
Added Acked by Martin

[0] https://patchwork.kernel.org/patch/10757569/
Earlier my approach to initialize the usb0 bus was limited, some more
phy tuning is required both at driver and u-boot to get this feature
working. So for now just disable this.
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index d4c8b896dd26..3e51f0835c8d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -312,7 +312,7 @@
 };
 
 &usb0_phy {
-	status = "okay";
+	status = "disabled";
 	phy-supply = <&usb_otg_pwr>;
 };
 
@@ -322,7 +322,7 @@
 };
 
 &usb0 {
-	status = "okay";
+	status = "disabled";
 };
 
 &usb1 {
-- 
2.23.0

