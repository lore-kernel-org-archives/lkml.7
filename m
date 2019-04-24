Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC3CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E3B204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129354;
	bh=2SErRLCqs0eCxuxqFUVpnt/ed7rfWF9J62ePGQWR4as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L4P3U5NlnYGhCdPPVREcXJe9NsJD/ykpwR0a9VQKFCEeYRJs2p/LRDH5s6NEt56Cs
	 McnkQ/6Dd9YDyndvt9j9va3O+q+J1cVD0p1dXPRVTOPWlM/U/HoBxvcqdQNkMs0dWC
	 UI/QgJ2SU4QsOwCL4+6roKVRpaGbw3uuaI9jXXyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389094AbfDXSJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388231AbfDXRP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:15:27 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D74C621909;
        Wed, 24 Apr 2019 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126127;
        bh=2SErRLCqs0eCxuxqFUVpnt/ed7rfWF9J62ePGQWR4as=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TaByP99sCWMOw0moRRrIbRchx/9RFAbx1OiWgfFSHskNzdrJZnndm1iqeUXim6X9u
         jpeJs9qKWD4huvhzXP2zgC0RTQL4sSbPYR8HLPingQ2Iqj5AtWY8cExjseL3+zQy7Q
         W83zxomrxoS0vUjmgxnkDW9xGfjzz+aswZe2VteA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 3.18 104/104] device_cgroup: fix RCU imbalance in error case
Date:   Wed, 24 Apr 2019 19:10:01 +0200
Message-Id: <20190424170910.915755642@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
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


