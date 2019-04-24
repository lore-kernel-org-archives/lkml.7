Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70ACC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859EF21915
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127498;
	bh=b+oR/mK6zwMUE6kxKjk4NmNv54U9v+ROyYUlUBBLufM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QF3ez8WG7Ps0ZKDOOTWw0UUvkKr+zPrjI8UYft5sIzjerttKVM9m1eU87ifZccuQc
	 o13+7c7O208RzmSD5A3hQQoiKrazl7c/11CQt7QCajYuLd/kd4ULU7JlEhizoNAx+K
	 lOlyuhtXIIRKiHmj8y//LG8gKBf6N4P/3gKX8I3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392380AbfDXRiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403987AbfDXRiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:38:13 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E802E218B0;
        Wed, 24 Apr 2019 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127492;
        bh=b+oR/mK6zwMUE6kxKjk4NmNv54U9v+ROyYUlUBBLufM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NnLzEwJPueNu1CuhUK35udzIEHxaNmK/7c/czWxJPcZnKs2XE7SL/XoO+JvoHgQ73
         RaUoDIPv0/CUovRwEEIULZGa1W/+qx8MckBA62IEoKoY3oi0dE5cnsw8lRPdTho4/w
         ERGxx3fRohwmPmwVNposqiSKSvILruFvQ0xBRW6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 5.0 110/115] device_cgroup: fix RCU imbalance in error case
Date:   Wed, 24 Apr 2019 19:10:46 +0200
Message-Id: <20190424170931.112799075@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
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
@@ -560,7 +560,7 @@ static int propagate_exception(struct de
 		    devcg->behavior == DEVCG_DEFAULT_ALLOW) {
 			rc = dev_exception_add(devcg, ex);
 			if (rc)
-				break;
+				return rc;
 		} else {
 			/*
 			 * in the other possible cases:


