Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979E7C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8DA21743
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556657788;
	bh=ndoLcm6Cu58A/6nmeY+Pw2ySzOR6KE+qURoXSH+NlQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=RrFe4HeXIqpGdDtAgIGMf38QBfe8Zlje7qREl/FraHCjQ+2s8g+nhrfuiNo0118vv
	 wQZAxI0CtOkGSue3JxhXw8hNekTQeqX0cVc+nDGtFhMLS0beDz7+8bXvfGf4mhpKt9
	 /QiuONAFKNzKrujFqHW7LYHDWAwWwQKj0GFcmAxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfD3U40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:56:26 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51131 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfD3U4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:56:23 -0400
Received: by mail-it1-f195.google.com with SMTP id q14so7099049itk.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 13:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=AA9rmVBDfPkvX3TMr0eqVTS4YBr90lGzdpj5gUDL6UE=;
        b=f6q2+QqkpXDE0R499RBDOtLn8oHnJrCzVCibV/m+msvISUipiNkPu8vVii+EWd+GJF
         DmnFXfFW7bUUi1hJVhTTSXkKb3/ObqWo2JybjokJyLiQnglDSc7/JqGHW/uGMp55oQ3M
         VQq9rxaihcMvu++8hb5wNg5lRdiHI9u7OYawODhgCUfKOrL1t8dc8N2qrPzOvvqtOrer
         sO2ENMsC3d/nZlqOoZl0La2g7i2yEtybvM3qZLff0Km4aa2ptbDXm/u7UHP+7fY8UZ6s
         eHkTPMAtZuLC3JS+r4VwpxZVcudBnhPktzOISNNV5PXthT4Ubh9HfQnYFH/qoMqS7CKP
         n2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=AA9rmVBDfPkvX3TMr0eqVTS4YBr90lGzdpj5gUDL6UE=;
        b=EtvKacHooht1nlKUD9eo7iZcaSNZPE6N75CIZhYxy123tNt+Z0O+Oig7MXCv31OulY
         ZN4Ua/6yZoUB8igJHOrJzCPHcp0dmK0es+0kR38TkpJfHPs8mMPNrb7c52ni/mKS0as1
         +C4JIIePEtaAVTikOGxpHPVJXvKibLkrNMorojC5SOUL7GWZzJTAVs1Ad46MyPsok6VH
         u59MgHbi5s+ocpwYg+gtDr/Nb98E+UjRKEFraUVe2JVJjUwwgC5pe3wxYXxYXlr8mkWV
         fdvNF3l4dcS/YFNzCaFUElUGwSnM7Fh2v2qmeMLNYtTWr5tNoTqa7wfcv9AFTttDNugh
         dmJg==
X-Gm-Message-State: APjAAAWEZmeNy5ZK4sKHvW7egFmFyidVo4d70MA7Um9w+03l76cOzwTo
        TYBacmJCXPkMdWkHIPpy6hQ=
X-Google-Smtp-Source: APXvYqzs+rLqezkyQQfc/oLYUrHzC5HCMRdTcMMi0J9X+n0Og/xHbIlcNplQg4mJeBgO6vNW/Jo9aw==
X-Received: by 2002:a05:660c:6cd:: with SMTP id z13mr5575328itk.128.1556657782368;
        Tue, 30 Apr 2019 13:56:22 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id s7sm9799349ioo.17.2019.04.30.13.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 13:56:21 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 06/14] x86 topology: Define topology_die_id()
Date:   Tue, 30 Apr 2019 16:55:51 -0400
Message-Id: <6b241191bc9ec6924855b71ee4fc84906ccd4e6c.1553624867.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <75386dff62ee869eb7357dff1e60dfd9b3e68023.1553624867.git.len.brown@intel.com>
References: <75386dff62ee869eb7357dff1e60dfd9b3e68023.1553624867.git.len.brown@intel.com>
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
index 453cf38a1c33..281be6bbc80d 100644
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

