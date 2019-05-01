Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5C8C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B892177B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556684744;
	bh=B1BySDmpD75Bv69AxNOFeAGE5mVaN5HI4Uo27hl4AJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=N86AsysXG/Pa787X8HrjsI7zUGkg6T95CKfopPqPb/3FRZW1F5+cDiCX0foToiKm8
	 rbz74x1jlsLGc3Fxq8zbihfgw12xVz8KWJCtDFH9Hxfi+s3UtaRHxw7oFFwjMhVGBZ
	 E06arjkjEQ0v1g/XIF8mYrCcgl5Dx9HLAbF8UAlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfEAEZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:25:43 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:56255 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfEAEYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:24:43 -0400
Received: by mail-it1-f193.google.com with SMTP id w130so8318104itc.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 21:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=yIImtsMNTtBSlvN1QNVma82QIGt0h9DTz+k1trYzhKw=;
        b=KeCMpCbmWHnDmO4vFxed+6LyK+vEOHspV/MpVpk7NiWuoT9ZcAyOFU8voGW1iW/ppM
         wXQcPmisswUjVEiWvGidJTVO18zHWvTbcK3NTpX3rN2xJXxZhEs1lDMbTfRPYjBi5vjZ
         6CqlH3dHG4Ymikt17O6IfgfDnujmeU0hKS08YRPHquH/q7eH+2K7lfQl2oXoQ7cz2RuF
         yXSeQtGsWJN/c1SFtDgLWfiQQ6onqUPgnSx+p37sSirHLeY+zi24uT+wRvzC2jeJpAV5
         ZjH0vVMp1EoS/NJ/nOMWmhWEZajxt6INMxLnsSS2F+ZWLls9lMbl2wHNjo7mfg1A2yVq
         0c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=yIImtsMNTtBSlvN1QNVma82QIGt0h9DTz+k1trYzhKw=;
        b=uay9Hxr+JHicCNdaqxQeNOPKGnNG6uBqmETJkPnPZ/7Ix5BwJtgrwOOA5zFmdMApdB
         xo5DBrYYusVS2UtAHoQRv3528kHYamw/ZAwFAy0bA6/7UO2EaDuu2xmfETBJCWZb1DY5
         K0az6M5dF3UJJ3ce8nT++M25yRKRQC0j2e8t7belRmXPFI1EpLDTJyamtW8htA1E89ey
         RPT3+0k1u2RuhOnI0NgMnONL8AfEx1zb9FJQHrSITbQNEoRXBQCRoY3EXGLw6XsMWjW5
         5pr5lY+iE0UeeF+NWuHeVxDrEfy4GYEdJBUrNEP8vdUCUju+GiyyIWTsKBGGRM/fQi4C
         ARBQ==
X-Gm-Message-State: APjAAAW3Mtd6Ou4R+ckLCiMQGzN9ECNlSCKxW1+EtrtPh92/ohR9in+y
        ZJaMyVAPM7Dt/9HcTEA9qZU=
X-Google-Smtp-Source: APXvYqy/c4WNWflGmxrCUa660cnayZyHErsYitOCkoXzy3OyG4S05rihgXIJZnzzBXRxeU17iOXjrg==
X-Received: by 2002:a24:7a8b:: with SMTP id a133mr6487438itc.118.1556684682595;
        Tue, 30 Apr 2019 21:24:42 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id b8sm2569728itb.20.2019.04.30.21.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:24:41 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 07/18] x86 topology: Define topology_die_id()
Date:   Wed,  1 May 2019 00:24:16 -0400
Message-Id: <c0a079aa03646e8a7a0f996b6917d78cf0b89beb.1556657368.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
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

