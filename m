Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299EAECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024B120679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JqmPT+MZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbfJITms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 15:42:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32817 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbfJITmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:42:47 -0400
Received: by mail-io1-f66.google.com with SMTP id z19so7910512ior.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=+KlI9AjuWQfTR2YtyJ47gFugrYwenbbGRumyyrkEG94=;
        b=JqmPT+MZwUh6TV8RvMkIBN6mPdYVJZ1Z/j2BObiv9kgi4hgwgS9RInTkhBldMtR0l0
         gjqPGFqoqofsQkGHS+nXQSY6gBU1Corb1haodDV+xq6YpB42/k8MvBBuPF3H/eHV5vpP
         dTd6TBc8W7e5FDWlMJNm8ImM4PncaGF1XsbJu6Y3Lmv+/C6vABuSqYLAPciSLM2Zikx4
         oox7CGDOJV2j4RbFjZ17KSqE9mNQK5BWZZ2P0lHYNWj212rakCbUMXQEzJBfpF4HRVYU
         u7bzRcrnlQMDFpw5pqiM/bG77qg27PuSbuBDxXxvzsjJQl8x16huu2VPhyW2dddnROB+
         xx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=+KlI9AjuWQfTR2YtyJ47gFugrYwenbbGRumyyrkEG94=;
        b=Dn6v7g6ra0XXoyxfXabYGZlb1n0i4fFQcHwrEwlv97SH8Jog50MXZTzSqH35SNp7ig
         PlfV8qrhQCNKjHvrP9rLHknwNN5swaLHw4YpHtKd+2FS2mVYFVNx+KrKwuSBhLDdTnqO
         qpXyv3W4ui/8A+OylrQtkPCe422x5aZHYsF2hMsFYWFy0tNX5GWB0RFi0HntHMfvdMhK
         PzQirdtG5LuuliXoiDs0iuhfQfhQeZDCDsKufAe3A2KHOxp8b3PM/9+c8UN53QGuExBF
         Zgcyff4RP/rlriElLiIURT4MD5MDhEupJR4RTKuXKIpQ6fSUUp5AV66aCNN8gelVOaMY
         yt/A==
X-Gm-Message-State: APjAAAU1RlJOHGF+m6JKXHVNXl8BRWHVRWHaic8lQ3bSYx9AJDwX3pv9
        GuFUHX4e1MK9WjTQnin+XhoJhCAMDzM=
X-Google-Smtp-Source: APXvYqwdEoDZ8D48q3qk4OPa90nVU+iVNMbJAUe4M4Y1VfbLn43LsORxIYD9MhzVUj3L2cuD0RJWsQ==
X-Received: by 2002:a02:6d08:: with SMTP id m8mr5157249jac.34.1570650165999;
        Wed, 09 Oct 2019 12:42:45 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id h70sm1614658iof.48.2019.10.09.12.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 12:42:45 -0700 (PDT)
Date:   Wed, 9 Oct 2019 12:42:44 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org
cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] riscv: dts: HiFive Unleashed: add default
 chosen/stdout-path
Message-ID: <alpine.DEB.2.21.9999.1910091240220.11044@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add a default "stdout-path" to the kernel DTS file, as is present in many 
of the board DTS files elsewhere in the kernel tree. With this line 
present, earlyconsole can be enabled by simply passing "earlycon" on the 
kernel command line.  No specific device details are necessary, since the 
kernel will use the stdout-path as the default.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
Tested on a HiFive Unleashed using BBL.

 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 104d334511cd..88cfcb96bf23 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -13,6 +13,7 @@
 	compatible = "sifive,hifive-unleashed-a00", "sifive,fu540-c000";
 
 	chosen {
+		stdout-path = "serial0";
 	};
 
 	cpus {
-- 
2.23.0


