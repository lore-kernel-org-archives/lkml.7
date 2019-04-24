Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B15EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D036520835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126739;
	bh=2SErRLCqs0eCxuxqFUVpnt/ed7rfWF9J62ePGQWR4as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wyio6Ujh/F2yCER1YHI0Npq0FbA2hgCTa6/RqM4OxhV5E/AaWH4EFhHl4lhkIy6mH
	 LqPl8LUPKv4V1k5neQDr7lAUnhHyDc+p95buD65yEEgWGS5LjR4eX5GJ1L7hn3qlqd
	 Fj65/pDfIP1i+bcxX9MmVOCw7AZieDkvUK+o7fq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390071AbfDXRZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389695AbfDXRZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:25:35 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11DE420835;
        Wed, 24 Apr 2019 17:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126734;
        bh=2SErRLCqs0eCxuxqFUVpnt/ed7rfWF9J62ePGQWR4as=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+/H3C2LuBjG4pHlAe2Yf+8nhRRE0wgE5nSXwjuWBRtVdufBNhLqG35rGUmzw6bJ4
         y6USJwSdnBRllN7+V1hbbXNJiRYbGKEReD8zsyNX3WraSrgdr0nraoRevZTY7bwJkg
         HEXzArrL1widReBu7gwcrhjgb4m0GLXYXWamnquQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.9 40/44] device_cgroup: fix RCU imbalance in error case
Date:   Wed, 24 Apr 2019 19:10:18 +0200
Message-Id: <20190424170901.216160996@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.924291114@linuxfoundation.org>
References: <20190424170839.924291114@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

commit 0fcc4c8c044e117ac126ab6df4138ea9a67fa2a9 upstream.

When dev_exception_add() returns an error (due to a failed memory
allocation), make sure that we move the RCU preemption count back to where
it was before we were called. We dropped the RCU read lock inside the loop
body, so we can't just "break".

sparse complains about this, too:

$ make -s C=2 security/device_cgroup.o
./include/linux/rcupdate.h:647:9: warning: context imbalance in
'propagate_exception' - unexpected unlock

Fixes: d591fb56618f ("device_cgroup: simplify cgroup tree walk in propagate_exception()")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/device_cgroup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -568,7 +568,7 @@ static int propagate_exception(struct de
 		    devcg->behavior == DEVCG_DEFAULT_ALLOW) {
 			rc = dev_exception_add(devcg, ex);
 			if (rc)
-				break;
+				return rc;
 		} else {
 			/*
 			 * in the other possible cases:


