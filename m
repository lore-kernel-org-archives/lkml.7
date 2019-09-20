Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A31C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519F321D56
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569012195;
	bh=QWMaLTqP3/LxXruIwbroZ/ESvTqpOR3SRfg8+Zftu4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rYoeE2pnlHkr0foiPIrU21f4Yr7BxszQmIOlt7aWv8Reykm+5oXTP0yHTw1NDalSD
	 skVEuJXc9Qbp+DoWUbzr2JdI16vkXctipcZkuI0TRY2842Hg/Zw1iLt7TUkjuROs9d
	 JBZgtDULjFlCt20EkJdqe5V/gRDECorff8hla+dE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfITUnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 16:43:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34916 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbfITUnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 16:43:13 -0400
Received: by mail-qk1-f193.google.com with SMTP id w2so8686901qkf.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 13:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IYIa5ntznE0dmjCmjmfdo8J7Ibu+T8FOVCVdzrpU3Rs=;
        b=GKWGrElt2tvEmihOLyxf+tMC/itQAV7aN6Wt0DXFZY9PyAp0h+DDhiORelGLCR2gRO
         PzC4vNgPTJTdmOXuE9k655rd8cQVT0gB96setc4rH3O8mtTJuSlnUhq905YCejiLGy9z
         brcu/n377xZFaIhwSg+SdpPZrNqVyBjx+50zw5s/uNO8zWMaOpvFbFIWEIaQbAzGvgrx
         gul4vt1NlMdwb4eAm7/Fp1C4f7VE/kWC4QSLoqP5rO+IgzQFQHoi784L8T6CTeSU2KES
         p7xBqgp3ND0IF2z/xbtSngzZENnpyzgCQZFOhIuXbWoBqY2YZtRUOyG5fRr5OQX09d65
         kxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IYIa5ntznE0dmjCmjmfdo8J7Ibu+T8FOVCVdzrpU3Rs=;
        b=XIO6GS6s7VEfrk3zXbm+liqBJgViIIhmg25Hl0TOMLLSkSVpB+VLqTRPfh2R8JrIEm
         Nk3l5ZBZilgCCPYMkamndTgb5VCpc5FaeO6XwGNc/V731uQaJ/ZUddtqgIunJzIRL31F
         EkIBA1insx4dbWKGQCj1IRpuHMrxGEbDHv/y9osAjOH0NCXHHg3WwiRl/qx1wXYKMnlw
         fnkPgZNpZDs7rsrmBVZuVBD2+Ld7iK6xwcUtpX+vWU8dADcTE4lR8zGQG7M/L6gSEUSy
         5jQlHBH2iqwtGfUY73zzxJQ9EaG8kdpfn+WrCZiUaxMyIX73QpR7hJP1EyPysoyjbU0S
         KUFA==
X-Gm-Message-State: APjAAAXaBZLTpsLbs5E42QIQkgIukhEzL1weXCEY2fTYdmZ6a5lg1gUu
        cgT380Oq2H5cYjsUu/1X7x8=
X-Google-Smtp-Source: APXvYqx+LXB4P+vtWgN15Kr4T8WHI7x/UfPkeML48Xgxp+ygTqKbvtszIKlKPFZdFg7jci15zST4pQ==
X-Received: by 2002:a05:620a:1335:: with SMTP id p21mr5560686qkj.321.1569012192697;
        Fri, 20 Sep 2019 13:43:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::7520])
        by smtp.gmail.com with ESMTPSA id y26sm1619402qkj.75.2019.09.20.13.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 13:43:11 -0700 (PDT)
Date:   Fri, 20 Sep 2019 13:43:09 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Marcin Pawlowski <mpawlowski@fb.com>,
        "Williams, Gerald S" <gerald.s.williams@intel.com>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH wq/for-5.4-fixes] workqueue: Fix missing kfree(rescuer) in
 destroy_workqueue()
Message-ID: <20190920204309.GA2233839@devbig004.ftw2.facebook.com>
References: <1569011160.5576.205.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569011160.5576.205.camel@lca.pw>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 8efe1223d73c218ce7e8b2e0e9aadb974b582d7f Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 20 Sep 2019 13:39:57 -0700

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Qian Cai <cai@lca.pw>
Fixes: def98c84b6cd ("workqueue: Fix spurious sanity check failures in destroy_workqueue()")
---
Applied to wq/for-5.4-fixes.

Thanks.

 kernel/workqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 93e20f5330fc..3f067f1d72e3 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4345,6 +4345,7 @@ void destroy_workqueue(struct workqueue_struct *wq)
 
 		/* rescuer will empty maydays list before exiting */
 		kthread_stop(rescuer->task);
+		kfree(rescuer);
 	}
 
 	/* sanity checks */
-- 
2.17.1

