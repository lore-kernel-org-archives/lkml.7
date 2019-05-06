Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0006EC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10AA214AE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557177991;
	bh=g3M/5b15eERHdZTOti1ql2/n1RS20eeqRM8IM0ukWMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=Pdn8cHGoMUPCOdBXEHKnk4zwMu9DwmeLteMwj5ekr8qzR/J/AMKbcBvCAiEM/bfRu
	 88J5lbatP2ePdSDC4RklkkwNvUHLtiUd+M2ibtTAQF4h39qhr3aUryaWUSQwMWeDvu
	 RDTIRBY4pLXPqRfAfieAaa1EMNctPtnCtoNqfEQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfEFV0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:26:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38347 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfEFV01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:26:27 -0400
Received: by mail-io1-f66.google.com with SMTP id y6so12454794ior.5;
        Mon, 06 May 2019 14:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=Nk48nKxFrzVCbK/utRpRT/1210jzyM5INfoRqpnVTi0=;
        b=rGd1Vd6BUzg7k8DDU7knurKWozulQERAdpFEsKnTzTnq5LKtUwHmYCkcFwmdEf3qe5
         v3OogjZzdOjpvoVrNU7y01Cy1iY430JuBB0/sqYfMndT4aAmCZuO4NAVK5c4lKWU83EM
         VZIdl48D+zR+K4YpM8Zbi0pIuXLWAPxl+8FF42f3Zu3CWDnEjZjSjOY7QGLQJguq3eYo
         eauGoz/JG2c68fc/EqnJjkf2Ix81l1u8ZjMyisCZCNWjftYy7+J2pLZV5UsrueeEsj4O
         YOnL/w557l/gL2IQrIk/JeZIxUb6N8BH56UnJOSCxk7s3+zaBH/QMt7WA6rftLR56QQ8
         E3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=Nk48nKxFrzVCbK/utRpRT/1210jzyM5INfoRqpnVTi0=;
        b=AI73rgmqNtzwjMj7GmyfO9wDf+eePV/P0AY4okxuU2WIvzbhfjFQyAtW5Ihbbn0Ifd
         aRED8OBNxKqtQlv5XsPOUXmFgC5JKG09ywLRL+xr+G6Tp+9wGfVdvewHwl/UGtY7wraD
         exHABTZgwK3pQxbpQVaiKwXBBlBqhTvXwoCf0ODouiVwI7vjQQ9sA1An6c/WbpzwPoOv
         AyvUvgHHKBUbOYDpTZ7nh1698UqqJA+MqkJpA6WK8GfLfRud3121Ka9ExxzOLjGxcrfF
         EXD09/WNTv83+0S5PwZNMWC3yBx5i5TD1jDTEqm6OLfZlqoMPoHVq5kNKnP4ppWSDi0w
         4I2g==
X-Gm-Message-State: APjAAAVkkl7b2K6BFZGuz5C9MSNEgDYpcc6C8YBziPVRAzv/UkSYCSL0
        ly8ifmeOAvJfYWQ0jLrjN40=
X-Google-Smtp-Source: APXvYqyv1kph+1yFc+KvhlFyTynQH1GCktm63ghyPrCOcylDQr/3kg7x5puRL6TNcpCSnIFGCxuP6w==
X-Received: by 2002:a5d:9cd0:: with SMTP id w16mr2334425iow.272.1557177986257;
        Mon, 06 May 2019 14:26:26 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:25 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 01/22] x86 topology: Fix doc typo
Date:   Mon,  6 May 2019 17:25:56 -0400
Message-Id: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <20190506212617.23674-1-lenb@kernel.org>
References: <20190506212617.23674-1-lenb@kernel.org>
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

