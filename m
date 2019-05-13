Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15EFC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59C32168B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557770364;
	bh=B1BySDmpD75Bv69AxNOFeAGE5mVaN5HI4Uo27hl4AJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=2Ec0KmbMxE5j53L7v3HFam87RMSbEDnC5ep6pymLIBzldkDugj//EWkx8iLo3GquL
	 HCF+7ZdciqWDVM+zGXXfjPabftoytHm7SqXD63XRMBWigAfmnJ0fTsdDDLgN6pL4nN
	 brNTgPbW4ljdMWiGIzonNM3FiF1ygkiXP62EQkyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbfEMR7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:59:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38589 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732029AbfEMR7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:59:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id y2so2144164pfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=yIImtsMNTtBSlvN1QNVma82QIGt0h9DTz+k1trYzhKw=;
        b=NgxWf0cD8rKV/FIt1+SAehvjMKppD254dxK8k5PeEf4Q7dv6zM8/UQMZe9fpv3lljE
         ur+q65soOJSCDvS+0AGuCbEFl4X7ttsoQ3SIJFzNkWXDeui3hdM1vPU7Ngfz+zXfkrD/
         7m4GH1QmlZXJuUpB1rRjqrKlVnzHj68i+xsVdJVcWJiwdFafVSbEyjU0hdPz+RX1wHzb
         bFUTRhXrehkdefyLbXsT9TbEp5p6e1bqZTC59QReY4DtmKMgEoAUa+urIPVHIGtt4RuE
         LRgItPrArzJ69EF/iPxWGAd/IKBkLii4C2ARl4/2nkRKmz+9RA5gNUz6q5WQbkP3TQHS
         BuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=yIImtsMNTtBSlvN1QNVma82QIGt0h9DTz+k1trYzhKw=;
        b=eLdU+h+m+dXh/T7kFZDZqsMCik0FhWrjKLq8kc/uMzVxaA3BquHUVxSJ9rzY/B7A+o
         SlmQz0zYCGl3li6OVk4AhISOM/eNZ/wFqSQ78yGKUILYWzxJobSTa+OdPuixyepDdC+1
         S8zv1w/C1igxFmG/QMBo2RbDin7LMMmX2uzu52g3N2/zw3Jn3QNoSuDEY7xsvk8W6eCV
         +/+J5dLsceLxjLZaUe4fHL6PoLZskgBGoZgVoQxuVK9WuzG95j3vZcG3teWVTwi+VWrL
         qY9CLSh8XFG6fKtBdVfufgEZbHgLzf58Sfy+oPZw+uQLwcRjIcJ52ngT1aSFRFD1BvTr
         0i2g==
X-Gm-Message-State: APjAAAXhH34vpLsbtbtjwcuJgJdCOs4NlyJ6swrFTaXt/ocv3/X+6Ui6
        keqMIzAGSUzkG1HegMSWuY6TCJig
X-Google-Smtp-Source: APXvYqwI7yL1rRtTECqv01BhvG0x4SGnUzzcwGky4wMGiQFklGsbuqEynXMVwTI5g6tpwe3cOfuksQ==
X-Received: by 2002:a62:3381:: with SMTP id z123mr36371965pfz.42.1557770360877;
        Mon, 13 May 2019 10:59:20 -0700 (PDT)
Received: from localhost.localdomain ([96.79.124.202])
        by smtp.gmail.com with ESMTPSA id s12sm9536266pfd.152.2019.05.13.10.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:59:20 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 04/19] x86 topology: Define topology_die_id()
Date:   Mon, 13 May 2019 13:58:48 -0400
Message-Id: <6463bc422b1b05445a502dc505c1d7c6756bda6a.1557769318.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
References: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
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

