Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AD7C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4418120866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556684760;
	bh=g3M/5b15eERHdZTOti1ql2/n1RS20eeqRM8IM0ukWMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=yv1aRCCIHrFixb7+cKMNszPCTcZ9vAoASd/qB1+fzNcPtIyDNgku6rIEZqR+tW3O2
	 wAc05vtaAKX0M6JcLxwZgN3mv/yLJmGNr9m5w/+MBdHVtc0zuxHrONyDT0SQEGRUKg
	 hpDVfIerZ+Bk1il1D2U3OG1YWGioAIXBLTEA+eXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfEAEYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:24:40 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50857 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfEAEYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:24:35 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so8375221itk.0;
        Tue, 30 Apr 2019 21:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=Nk48nKxFrzVCbK/utRpRT/1210jzyM5INfoRqpnVTi0=;
        b=hAjGPJJwuCRGfx7J5DNr7yixJbVMhYzPBZftMDPiFmRzYV2GTkZynFtEWe7oki+5LX
         d/4twZjqbNISjooUyKgalqeHdcZF0c5pvEr/Jkn5pOJyEROW9EnLQjzlG/pyZ6zYo1oN
         DajJB8QL5feM8TkJpmbDyjR/6Q1gV19JzbAeVlNnfFYGBwqKulvrNgbY8DZyEZV9yOPT
         F3UZjQuKA4r/M0KXBpNL5cGbI7HUUr9RPG9OUwZL1lZ6ulsG87W3k4mgsYAVTzDAH5Qx
         waYgVeb68BYyjzvSr/rLMltXFUHczwu/fQKn1c5RWth+eMWvKzkbhT4ExSn9Fgv4xlyP
         Z2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=Nk48nKxFrzVCbK/utRpRT/1210jzyM5INfoRqpnVTi0=;
        b=p9NeGFbYZxXWx3Z41vwloO4DLjae6E/UwZuVWfV7Ssguyf2ACQ781XTIRwmgk8oHvY
         6nUsn3vEzcjaAE8bu5KsY9AD2gDGJycK7lAtqUZAmEfaxgVHsjIMaiktFL+P5BxNxudm
         c1Nn2wK2rE+h4VY9bTdPY78hxewDadCUYv7uEMaV0PGBpdSWearDd++on5j6/HSDCKKt
         ervA80CvMbJfA2eZI4xqNM6hVlOfcsHCQNaM4AeUtyqc43P7O3WDw7W9AKtKr9szW5yu
         eHKf8Fj9UzdUJo9UZcpEsj1P3z8MIz9cO4IbdgId2uTFBjOazncJMD77/W8Zw+Basuxf
         kXqQ==
X-Gm-Message-State: APjAAAWFWs+YoQN5g6hI4JJy6Hn7WekJYJhzRRjP75tnPnoQo/YzgqW/
        HM8jtbgspr+NRMs1mz6hn2o=
X-Google-Smtp-Source: APXvYqwWa2ZAqJt4ecnI9pcgMvcwq1G4EZn6BY/+uHQYojEevrJIVmj0qsNp2jOhfMoHIObotM6eqQ==
X-Received: by 2002:a24:9414:: with SMTP id j20mr6385601ite.91.1556684674965;
        Tue, 30 Apr 2019 21:24:34 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id b8sm2569728itb.20.2019.04.30.21.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:24:34 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 01/18] x86 topology: Fix doc typo
Date:   Wed,  1 May 2019 00:24:10 -0400
Message-Id: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <20190501042427.13156-1-lenb@kernel.org>
References: <20190501042427.13156-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Syntax only, no functional or semantic change.

reflect actual cpuinfo_x86 field name:

s/logical_id/logical_proc_id/

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org
---
 Documentation/x86/topology.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/topology.txt b/Documentation/x86/topology.txt
index 2953e3ec9a02..06b3cdbc4048 100644
--- a/Documentation/x86/topology.txt
+++ b/Documentation/x86/topology.txt
@@ -51,7 +51,7 @@ The topology of a system is described in the units of:
     The physical ID of the package. This information is retrieved via CPUID
     and deduced from the APIC IDs of the cores in the package.
 
-  - cpuinfo_x86.logical_id:
+  - cpuinfo_x86.logical_proc_id:
 
     The logical ID of the package. As we do not trust BIOSes to enumerate the
     packages in a consistent way, we introduced the concept of logical package
-- 
2.18.0-rc0

