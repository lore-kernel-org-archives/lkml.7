Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65756C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F22A2196E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCPjqOKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404596AbfISUEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 16:04:41 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:44697 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390510AbfISUEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 16:04:40 -0400
Received: by mail-qk1-f202.google.com with SMTP id x77so5317330qka.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 13:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gtgAzLnc3RcqClKbOcZOPzy3aLAgaQlGmQMhkVqxZF4=;
        b=uCPjqOKCheB3JWBJrlfYuDkISHzv0G4Z6mrhos4FIWGt3TrIatsarZ/tMgUseEGtMR
         Pu0geTbVbLRjsPm5d2hAtrj8Js4k+fmCszhzK1ksVmS3J7LdjEWWQjjvPZQfSwtZ4dzo
         pvaimLN03VPSR3/pElOFiiH3JDPZIN+iUyKKWlFmsiAFRWdk7Ys96J7u3UKHGwr912hC
         iTv34MQmPRc3F1Okb7OfGJiF13QV5i2WZDGC8hG5On1nnkT8PX22E5gsxtpCk4pkuipk
         MkcxQZDVSYlfj1lH7aCGNOAkNZ0NtnaRYzkmeB3wyJ6ArqHTr4ZuUpDOrwMxQae3hOYu
         jAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gtgAzLnc3RcqClKbOcZOPzy3aLAgaQlGmQMhkVqxZF4=;
        b=GtLEHcquKHbDCDF55wNcpICH2avdGzeqXVsG070XFhxvwSwCg43wFCT5k5tUMpRcOd
         MN7dHO/+6WJqnXz90ksYdbM0t6AzMOtbdzpnhSMHQC8wVhNqi2v4ILVRK1p81UYuMNSE
         0Wc2NRVgutz1N3J4rOCLmhpYGfhpVm5ygrZb4p76j57HZYxAXSCFdss/YquyfcGI/pNn
         0sGwcS7GCwcIcj5eHLXS/baSO35eqYpCe1HmZu4XKNEIQ6L+OIWiJh28IqT6WTfsCe14
         ETEHqmXGOOlc6e5uCh4Qmwi0MEf73iDkPsytlH5oQobJqfY4Ma/iYWyHv/nuwPgE/EFJ
         Poow==
X-Gm-Message-State: APjAAAVH/RXUwYKYpGzWXq3wHY/UL7qC6Q/YltmHoCjErHm/m7SuImt+
        b0vPUyDU9BSik3tu33KgO5znnEdabUQyTXCkvg==
X-Google-Smtp-Source: APXvYqy4EO8/aLq3VaFLQjC6K64y37JXC1yIOLlXDl/8Vxv2N+fjR/v0HTS0Lgxe9P/FIqRA8uCA9fQSd4O9WIZNJw==
X-Received: by 2002:a37:be87:: with SMTP id o129mr5066942qkf.254.1568923478704;
 Thu, 19 Sep 2019 13:04:38 -0700 (PDT)
Date:   Thu, 19 Sep 2019 13:04:28 -0700
In-Reply-To: <20190919200428.188797-1-almasrymina@google.com>
Message-Id: <20190919200428.188797-3-almasrymina@google.com>
Mime-Version: 1.0
References: <20190919200428.188797-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH 2/2] hugetlb: remove duplicated code
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     almasrymina@google.com, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated code between region_chg and region_add, and refactor it into
a common function, add_reservation_in_range. This is mostly done because
there is a follow up change in another series that disables region
coalescing in region_add, and I want to make that change in one place
only. It should improve maintainability anyway on its own.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

---
 mm/hugetlb.c | 119 ++++++++++++++++++++++++---------------------------
 1 file changed, 57 insertions(+), 62 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a14f6047fc7e..052a2532528a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -244,6 +244,60 @@ struct file_region {
 	long to;
 };

+/* Must be called with resv->lock held. Calling this with count_only == true
+ * will count the number of pages to be added but will not modify the linked
+ * list.
+ */
+static long add_reservation_in_range(struct resv_map *resv, long f, long t,
+				     bool count_only)
+{
+	long chg = 0;
+	struct list_head *head = &resv->regions;
+	struct file_region *rg = NULL, *trg = NULL, *nrg = NULL;
+
+	/* Locate the region we are before or in. */
+	list_for_each_entry (rg, head, link)
+		if (f <= rg->to)
+			break;
+
+	/* Round our left edge to the current segment if it encloses us. */
+	if (f > rg->from)
+		f = rg->from;
+
+	chg = t - f;
+
+	/* Check for and consume any regions we now overlap with. */
+	nrg = rg;
+	list_for_each_entry_safe (rg, trg, rg->link.prev, link) {
+		if (&rg->link == head)
+			break;
+		if (rg->from > t)
+			break;
+
+		/* We overlap with this area, if it extends further than
+		 * us then we must extend ourselves.  Account for its
+		 * existing reservation.
+		 */
+		if (rg->to > t) {
+			chg += rg->to - t;
+			t = rg->to;
+		}
+		chg -= rg->to - rg->from;
+
+		if (!count_only && rg != nrg) {
+			list_del(&rg->link);
+			kfree(rg);
+		}
+	}
+
+	if (!count_only) {
+		nrg->from = f;
+		nrg->to = t;
+	}
+
+	return chg;
+}
+
 /*
  * Add the huge page range represented by [f, t) to the reserve
  * map.  Existing regions will be expanded to accommodate the specified
@@ -257,7 +311,7 @@ struct file_region {
 static long region_add(struct resv_map *resv, long f, long t)
 {
 	struct list_head *head = &resv->regions;
-	struct file_region *rg, *nrg, *trg;
+	struct file_region *rg, *nrg;
 	long add = 0;

 	spin_lock(&resv->lock);
@@ -287,38 +341,7 @@ static long region_add(struct resv_map *resv, long f, long t)
 		goto out_locked;
 	}

-	/* Round our left edge to the current segment if it encloses us. */
-	if (f > rg->from)
-		f = rg->from;
-
-	/* Check for and consume any regions we now overlap with. */
-	nrg = rg;
-	list_for_each_entry_safe(rg, trg, rg->link.prev, link) {
-		if (&rg->link == head)
-			break;
-		if (rg->from > t)
-			break;
-
-		/* If this area reaches higher then extend our area to
-		 * include it completely.  If this is not the first area
-		 * which we intend to reuse, free it. */
-		if (rg->to > t)
-			t = rg->to;
-		if (rg != nrg) {
-			/* Decrement return value by the deleted range.
-			 * Another range will span this area so that by
-			 * end of routine add will be >= zero
-			 */
-			add -= (rg->to - rg->from);
-			list_del(&rg->link);
-			kfree(rg);
-		}
-	}
-
-	add += (nrg->from - f);		/* Added to beginning of region */
-	nrg->from = f;
-	add += t - nrg->to;		/* Added to end of region */
-	nrg->to = t;
+	add = add_reservation_in_range(resv, f, t, false);

 out_locked:
 	resv->adds_in_progress--;
@@ -345,8 +368,6 @@ static long region_add(struct resv_map *resv, long f, long t)
  */
 static long region_chg(struct resv_map *resv, long f, long t)
 {
-	struct list_head *head = &resv->regions;
-	struct file_region *rg;
 	long chg = 0;

 	spin_lock(&resv->lock);
@@ -375,34 +396,8 @@ static long region_chg(struct resv_map *resv, long f, long t)
 		goto retry_locked;
 	}

-	/* Locate the region we are before or in. */
-	list_for_each_entry(rg, head, link)
-		if (f <= rg->to)
-			break;
-
-	/* Round our left edge to the current segment if it encloses us. */
-	if (f > rg->from)
-		f = rg->from;
-	chg = t - f;
-
-	/* Check for and consume any regions we now overlap with. */
-	list_for_each_entry(rg, rg->link.prev, link) {
-		if (&rg->link == head)
-			break;
-		if (rg->from > t)
-			goto out;
-
-		/* We overlap with this area, if it extends further than
-		 * us then we must extend ourselves.  Account for its
-		 * existing reservation. */
-		if (rg->to > t) {
-			chg += rg->to - t;
-			t = rg->to;
-		}
-		chg -= rg->to - rg->from;
-	}
+	chg = add_reservation_in_range(resv, f, t, true);

-out:
 	spin_unlock(&resv->lock);
 	return chg;
 }
--
2.23.0.351.gc4317032e6-goog
