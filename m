Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC800C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6D92053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557178084;
	bh=B1BySDmpD75Bv69AxNOFeAGE5mVaN5HI4Uo27hl4AJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=Smojf1oNyPci1nfq7Au44btDkEgvSCzyKuidgzbICtgzPL2EfvYEiiPdA6YQb06Ci
	 WaGlsIpIR+AWwfumn3aphbKqJ4AnwZOi4XjNsP+E1eyn/jpiNBbFl9Inzop+cPkoDf
	 IdyB+r6NlnABZpUCWZyEf9N6ns/veVk0EQAhEZTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfEFV0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:26:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44743 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfEFV0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:26:35 -0400
Received: by mail-io1-f65.google.com with SMTP id v9so8559565ion.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=yIImtsMNTtBSlvN1QNVma82QIGt0h9DTz+k1trYzhKw=;
        b=Z5QWO9EKEnKxuoWH080agxMVMF2qkG9nDlGTN6ACWA6jOmzzwYCozPIcxaLYh43yi5
         OEBuzFWm/EcXmxXFe/fRdl6cgN2ncOQqExHBJn2lYGPG5pdCkQ7FwvXVvSOMC4c1QGge
         LniKPrZWDR9QLT9qRoDIHd6Ggo+TzczGln97YLaK8lkXjWeltiS70hZUetySxeBR1fWk
         h4pM1r3dOI8CzIXDV+Ez16b/4HvCTfDFLD9kCqUdcYrFsBIr//9L9fbu5Bl6s7/VYkFS
         k10sebnwpZio8Chfx4JMnp9lx4zyyUVhdfH/xxyAYr2Cn8yaJ+mk0I++abnSFpJmOIUz
         T+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=yIImtsMNTtBSlvN1QNVma82QIGt0h9DTz+k1trYzhKw=;
        b=BiCcjX01vk+qTEm+4DkJghReuIdCD12P6FZm8wCvsrJ8R75YUA1sHLgaKj1qu4nM74
         pxLCe3MhlMjRpovSpdREVxxv3xyb3aG3hoc5qXB7bkwnl9wLfS1UyfjvcadzxxIgOTb7
         SaEimtVMIJK35pzKZGIL+5JYkj1Eu0HCrOK5LjIyrcRuaJKUs2syYz2isSwganLoPon9
         ZizN/u5y5kD64IfMOc9HUAyxSg3jWF3SOcOFJgGN8Qwl5/BiIh5yNihGeAwZXV9uxiXQ
         O2+HNrxA1UYSQMiWiIl4Aq4UCC7nZkc0d+psIxVr07TR37gvOLcK8CP271mVPpjA1lP1
         47hw==
X-Gm-Message-State: APjAAAUtu9xjjTWIPirymRlMFAmYrgobJdJNGS3qeN1wRIkc6bOtIV9V
        PgqEt90VLFFzQZDF161biAY=
X-Google-Smtp-Source: APXvYqxkWOUnXeSO/36rNdrcpb2xRLEkmhHFDyn+T2y4A5au8P5zOHSoLV5HnUGhoA/icrUbYO9nHA==
X-Received: by 2002:a6b:bd07:: with SMTP id n7mr19652395iof.54.1557177994091;
        Mon, 06 May 2019 14:26:34 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:33 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 07/22] x86 topology: Define topology_die_id()
Date:   Mon,  6 May 2019 17:26:02 -0400
Message-Id: <c0a079aa03646e8a7a0f996b6917d78cf0b89beb.1557177585.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

topology_die_id(cpu) is a simple macro for use inside the kernel
to get the die_id associated with the given cpu.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/topology.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index e0232f7042c3..3777dbe9c0ff 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -106,6 +106,7 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
+#define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 
 #ifdef CONFIG_SMP
-- 
2.18.0-rc0

