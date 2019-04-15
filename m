Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C19C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF832075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfDORJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:09:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38250 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbfDORJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:09:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so8883235plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 10:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJcAmVaDYK4vGwlBAXjpdNHJfUAjCCsF7pjOY/brTBk=;
        b=UZN7oF6j35wlTMLaX+M8l3AF11VIwqR6ZpP5RqqmD8/IjCtqgLejzpxp9iCk5O8ck8
         Qelqy9ehH/UmtSyflyLGbnC+Kixe5bKIBtntb/VEnJuhgSjLBvTkU3i3ouZefDWNrul0
         W7wYb/jjpFFj60/KoT78T0KOQo//t6HKuqDQ2lnqU1lpMqFz+PxVmmWF0jYJbj77rC0M
         MBqUVnUYawb3oXzvOzpMCgdI5k6vU1ZtySBLdFYpnzapBg0kFQ3iVmt2C8Lv2EF4FZyL
         E9i2dxZMgImHHpz6+pbqSPWo0TLn9qNBYwaqLLvAetCMleHJa0o2CsWFE7tirqGMnTJc
         0y0w==
X-Gm-Message-State: APjAAAUt3+iKVMP2mrZRzF1zGHFC3+V3HmNr524cW36+MjGx2iau2nnM
        gQNCUj2p1cOK5uproLtih7o=
X-Google-Smtp-Source: APXvYqwWDEyA8vSHfYkLPEtusVHIquAdZjPLaseV+cTdxdArsJT0DgAJLNYBSviMCqCLlo65Ll9JoQ==
X-Received: by 2002:a17:902:8c97:: with SMTP id t23mr76499930plo.110.1555348188248;
        Mon, 15 Apr 2019 10:09:48 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id l4sm33180500pgh.17.2019.04.15.10.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 10:09:47 -0700 (PDT)
Message-ID: <1555348186.161891.104.camel@acm.org>
Subject: Re: [PATCH] kernel/workqueue: Verify alloc_workqueue() argument
 list consistency
From:   Bart Van Assche <bvanassche@acm.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 15 Apr 2019 10:09:46 -0700
In-Reply-To: <20190319174047.89815-1-bvanassche@acm.org>
References: <20190319174047.89815-1-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 10:40 -0700, Bart Van Assche wrote:
+AD4 This patch avoids that gcc reports the following warning when building
+AD4 with W+AD0-1:
+AD4 
+AD4 kernel/workqueue.c:4250:2: warning: function alloc+AF8-workqueue might be a candidate for gnu+AF8-printf format attribute +AFs--Wsuggest-attribute+AD0-format+AF0
+AD4   vsnprintf(wq-+AD4-name, sizeof(wq-+AD4-name), fmt, args)+ADs
+AD4 
+AD4 Cc: Lai Jiangshan +ADw-jiangshanlai+AEA-gmail.com+AD4
+AD4 Cc: Alexander Duyck +ADw-alexander.h.duyck+AEA-linux.intel.com+AD4
+AD4 Cc: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4
+AD4 Fixes: 669de8bda87b (+ACI-kernel/workqueue: Use dynamic lockdep keys for workqueues+ACI)
+AD4 Signed-off-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 ---
+AD4  include/linux/workqueue.h +AHw 1 
+AD4  1 file changed, 1 insertion()
+AD4 
+AD4 diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
+AD4 index d59525fca4d3..30737b5183c0 100644
+AD4 --- a/include/linux/workqueue.h
+AD4 +++b/include/linux/workqueueh4046 +404,7 +AEAAQA extern struct workqueue+AF8-struct +ACo-system+AF8-freezable+AF8-power+AF8-efficient+AF8-wq+ADs
+AD4   +ACo RETURNS:
+AD4   +ACo Pointer to the allocated workqueue on success, +ACU-NULL on failure.
+AD4   +ACo-/
+AD4 +AF8AXw-printf(1, 4)
+AD4  struct workqueue+AF8-struct +ACo-alloc+AF8-workqueue(const char +ACo-fmt,
+AD4  					 unsigned int flags,
+AD4  					 int max+AF8-active, ...)+ADs

Ping?

Bart.
