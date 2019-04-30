Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09005C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCE6217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556657781;
	bh=g3M/5b15eERHdZTOti1ql2/n1RS20eeqRM8IM0ukWMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=ClC98HRzqZi/kB3xqL3obMY0rwkawwj6m/cTGZcL6kCWD9uLSFMaMR/0+zvCQwhlD
	 qxSitZ3isbc8bFqgcYHp2kK6aap7KW82kXK+qOeYtNPTKEa3JV8PFCOd22QweMjmNP
	 Ve7DybtoBDwWt6MaNzh5kFFXbPNoym5qyVpLdppM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfD3U4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:56:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43318 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfD3U4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:56:17 -0400
Received: by mail-io1-f66.google.com with SMTP id v9so13431056iol.10;
        Tue, 30 Apr 2019 13:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=Nk48nKxFrzVCbK/utRpRT/1210jzyM5INfoRqpnVTi0=;
        b=JC9RP1PAJ4wPslne3YxWdgFBhxdcrznJ3DVy3eYjVtyMdLTSuli4n9I4YFo4CCjas5
         qh8q/skC0vqJxWhUATvrkZJu6U5yd1aYksIbi3M/l05SPjPed4RCAV60rA15m8uXD23O
         SD/QHVG5qNnaAsMKvUUVY1G7KuFNXDvN7ttytEMPIMCv7TYr7ZbdICk850cnVIf2Ue7s
         duxulTxg77YZeQJRiV42Uta/L2U3phmf7BayD1sdWELI1eC12f+x3o7WsgD2q0UMTwc9
         OiKI00d745wVfj+7s+AuWnYFpruQJOLDjbc96v7dsv4V007TxLOcFZCVfAvfkEhn1oNW
         TaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=Nk48nKxFrzVCbK/utRpRT/1210jzyM5INfoRqpnVTi0=;
        b=uQfFJsqCfe14vf5rm2mhJY8V8NQ6HlWMTah9jHQPMdqGF8hlQsC6TMSrJF3STY78p7
         xciYjvVmn/hAgwOk/JTyhUzsbOIQDo2w6iPdQ1Rqxeod9uF7Bl3lGno4atrKfk5zrEq/
         JUQObh8SZOEWDPXwIMr6BATwKq6NSkfscQSFePnl+CCSNyan04rKfqP5XZUQp1obbNne
         wHiE3HqSkZhEmxwFPCKo1FkQAGnKMjpABPoIFeP5XWXDcXS7XbkRlOZ+qwk7vUw8FSSS
         yFo3JWmHEYSQqMyWU4h30mcbJWhO/T91k1ChwYw2QhQYrIzi8pvTiwEPZsCKVd0voFDj
         EmIA==
X-Gm-Message-State: APjAAAV2v89k0RvP/I70MIuJ0ibz5gmoPjdyq+ISfRBgTXyHGMZi6zAe
        kZXb9hWfx7OvbzzuDU2QZ61tPWBs
X-Google-Smtp-Source: APXvYqysNVvwAWKWk+F/FWqYbfu128lG9yApZDobXbPKb0ChNtihLllDRiGhHIl5HRX5FF9ZD2Elhw==
X-Received: by 2002:a6b:7d08:: with SMTP id c8mr2501993ioq.259.1556657776258;
        Tue, 30 Apr 2019 13:56:16 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id s7sm9799349ioo.17.2019.04.30.13.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 13:56:15 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 01/14] x86 topology: Fix doc typo
Date:   Tue, 30 Apr 2019 16:55:46 -0400
Message-Id: <75386dff62ee869eb7357dff1e60dfd9b3e68023.1553624867.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <20190430205559.30226-1-lenb@kernel.org>
References: <20190430205559.30226-1-lenb@kernel.org>
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

