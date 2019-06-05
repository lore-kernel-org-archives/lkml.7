Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB70C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA7420866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8ZvxiH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfFEGCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:02:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34067 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfFEGCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:02:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id h2so8550260pgg.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 23:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+mL4FgQ19EroXhijChjGHOiTYmNvNkGMP7gXP3vKz00=;
        b=d8ZvxiH89al4I/4f5vPjsl6RJCAYuBwyr5JZ86FJPZePkQ9Ev2NOSlwuv3X66y/Z4D
         q/B05M4hwLcOu9pDU6heJbhMtQvWUr/2vdCxtp0DhHcfYmxse5+gHlic6msQL3HiA67c
         beApp4NKO1NfGHj+p2P+yLS8IVF3dHavOE2fPO8TuwbbdCzanev+M2ehx/kiTWjgDbGS
         c2zxtr9M8BPnA4tzU81hgiHhp6oquEpttG7B3NxRng1Vwz1NZK77vTKlPhMsgFTKEoWC
         +9ma7/4q7NrrIhyY2pJ+E+zgExMUrRzbJnrOhorpSulak1udo/aReyAYc8MsXpr1AtQ6
         3oJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+mL4FgQ19EroXhijChjGHOiTYmNvNkGMP7gXP3vKz00=;
        b=l4b0ARbzjYDYfn49pGvCzV+EtonLf4r2UT6eS+m0w1pGGfG+ZyBul6HQqPHUYo6f3U
         xl38WF5yPFIdhofxXQdQ3jnYzKFZEBFErl1va92/FQFajI7m15HFHvxzjMlMDqMpXEIs
         irdwenqE0e24j8wOduNOPKaSmOfa+HeeB0RjKUWWaNnTBU50qAFYhXpY6iQr9unMf2ga
         Cj3oV9VPE+M2IVCbigXx8gRzWRpFQXdE1Okse9nvI94+2169WTE1n8gIVoKuJvlBklsh
         T/X+kjnL0Fs90E28HYgCmJW8EZw8VqSGPcAzeSra+bLcvsdXRyReQP22oEDhpyK5H2dJ
         n2fA==
X-Gm-Message-State: APjAAAVX5iR2ru7IRrlOHoB4RYnLcv7TTbSNYRmO16Cme5+gVEmkivhx
        1hUN2ZLlKF59Hi4XzlCPT3Y=
X-Google-Smtp-Source: APXvYqwOzv0XDxxLIsCmIFRx2hA1nEXey9WmOKU0t6xsnmkEzGTrpoAGAeqHpapGRiSK90VIqiHW1A==
X-Received: by 2002:a63:fe51:: with SMTP id x17mr2094853pgj.339.1559714556080;
        Tue, 04 Jun 2019 23:02:36 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.36])
        by smtp.gmail.com with ESMTPSA id u184sm871872pfb.32.2019.06.04.23.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 23:02:35 -0700 (PDT)
Date:   Wed, 5 Jun 2019 11:32:29 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        rientjes@google.com
Cc:     khalid.aziz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Remove VM_BUG_ON in __alloc_pages_node
Message-ID: <20190605060229.GA9468@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __alloc_pages_node, there is a VM_BUG_ON on the condition (nid < 0 ||
nid >= MAX_NUMNODES). Remove this VM_BUG_ON and add a VM_WARN_ON, if the
condition fails and fail the allocation if an invalid NUMA node id is
passed to __alloc_pages_node.

The check (nid < 0 || nid >= MAX_NUMNODES) also considers NUMA_NO_NODE
as an invalid nid, but the caller of __alloc_pages_node is assumed to
have checked for the case where nid == NUMA_NO_NODE.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 include/linux/gfp.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 5f5e25f..075bdaf 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -480,7 +480,11 @@ __alloc_pages(gfp_t gfp_mask, unsigned int order, int preferred_nid)
 static inline struct page *
 __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
 {
-	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
+	if (nid < 0 || nid >= MAX_NUMNODES) {
+		VM_WARN_ON(nid < 0 || nid >= MAX_NUMNODES);
+		return NULL; 
+	}
+
 	VM_WARN_ON((gfp_mask & __GFP_THISNODE) && !node_online(nid));
 
 	return __alloc_pages(gfp_mask, order, nid);
-- 
2.7.4

