Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A67BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9122082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255161;
	bh=UrdbJKzWCw7bPaULAljgKiCI7e/0hno4al6vVLtHVhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=svzoKQgOsKm0P8WM0L/5EFnx1N+g3U4zHGA7XC3yb6HaHeVmuka0mR8KeSW1rCtvF
	 AXnTxXZ36sty5D10+eVLmqwDJ1afhv0Jo+blFe7wrOd9gnbRz01++EeiIDhszO7wbt
	 gsf+2M+UfEzu9bUmCVX3cHXoHN9fp/wchHHxj6WY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbfCVLp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:45:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731549AbfCVLp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:45:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C4EA2082C;
        Fri, 22 Mar 2019 11:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255156;
        bh=UrdbJKzWCw7bPaULAljgKiCI7e/0hno4al6vVLtHVhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lyicUUlHFWx9JVecPnrJkMB1QKBCRRs0ziWToIm5mJSSfvU04Rw42Pc9d8xB2TJLs
         5yjMtpXqrdW3Tmx+bNrcADU8HPETGT+RynQXQ/grbHizUux6VcGqjwv7fUqkqB9a/x
         s9K8r4ndoa9u3aP4nK7ezPHa0nVCQef/0zY/wOXw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.9 106/118] PM / wakeup: Rework wakeup source timer cancellation
Date:   Fri, 22 Mar 2019 12:16:18 +0100
Message-Id: <20190322111223.823769902@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 1fad17fb1bbcd73159c2b992668a6957ecc5af8a upstream.

If wakeup_source_add() is called right after wakeup_source_remove()
for the same wakeup source, timer_setup() may be called for a
potentially scheduled timer which is incorrect.

To avoid that, move the wakeup source timer cancellation from
wakeup_source_drop() to wakeup_source_remove().

Moreover, make wakeup_source_remove() clear the timer function after
canceling the timer to let wakeup_source_not_registered() treat
unregistered wakeup sources in the same way as the ones that have
never been registered.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: 4.4+ <stable@vger.kernel.org> # 4.4+
[ rjw: Subject, changelog, merged two patches together ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/power/wakeup.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -113,7 +113,6 @@ void wakeup_source_drop(struct wakeup_so
 	if (!ws)
 		return;
 
-	del_timer_sync(&ws->timer);
 	__pm_relax(ws);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_drop);
@@ -201,6 +200,13 @@ void wakeup_source_remove(struct wakeup_
 	list_del_rcu(&ws->entry);
 	spin_unlock_irqrestore(&events_lock, flags);
 	synchronize_srcu(&wakeup_srcu);
+
+	del_timer_sync(&ws->timer);
+	/*
+	 * Clear timer.function to make wakeup_source_not_registered() treat
+	 * this wakeup source as not registered.
+	 */
+	ws->timer.function = NULL;
 }
 EXPORT_SYMBOL_GPL(wakeup_source_remove);
 


