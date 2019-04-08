Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E140BC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E772148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fy4t1CyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfDHT6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:58:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33775 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfDHT6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:58:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id k19so7920889pgh.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=29W9ucIOqItYnzmL2gQIQ5ExGyQgwi2PVG1yglWaKBM=;
        b=Fy4t1CyUr8Vd/Tq1kRsSKxv77weNKQj5DhgPy9nD2bCEsiBn3FEGyA8sZ83Fpwo6bW
         tRb1hXjVG3V8vMhxBjeLI6C1RvZMzNOtU33E4GDSDs0Ps0T0NgRjLBkn9n5ALGsshrwb
         Oxspjm1t7dapzNkUm1UBxH7cqGC7RV4j4v9uZukrNkd09KxA+zKmao0FCp1YBCvYdbAN
         76r1I75mjP8bgo4nUEuuqhIjwkoGsrIzEzuTrPl0JUP+dwFcE0tW06qlb0KlIOOev7tg
         5f+JD1JqYlb1nfbuCaPOdDZFwIKIgmIe2jO8gc4TX04rNrLUFEsId6g6YZYGYoCqlm2Z
         r0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=29W9ucIOqItYnzmL2gQIQ5ExGyQgwi2PVG1yglWaKBM=;
        b=eJBI8TPFs1aTbOWfB/YuJqm66XS/2OA34OLlJ/0GrN9AgakOWt3Cqn2WeVMtcU7nXx
         rDLhyjpCi4UkS/brAPr6d4hayO4MsqastyrWk2Rs0mB4nKtPc4TQ1qjQDyB3SQQAxebW
         pYwt+f9QTBat7/dgo/S+z+bgCD90WbxSkWrIqYBZn2LGsBgDcdVQZ61+ecrlTeyZm8Hn
         VBisOyv+IgoiXh3oo/2jxaRmClV3wWklyDm+h4oI5EYsCWFDjloHTgYPKAYc4K+26Trf
         XWgH/DPHEfyjv6GGK5JN3nDjhsDNgX5+ZZF2svFKTOdE937d4TpmrjWkPQ1Btvx5YU6C
         OdzQ==
X-Gm-Message-State: APjAAAWUEm5KEhMrRuXtkyrxxmnkbrbRGKEFzP9B6b4zKDk4WqMZ30yI
        zB82G2P1fJ+CKOnfGEPgOTfdWQ==
X-Google-Smtp-Source: APXvYqwgOOpcElBS1UxKQNb+mYhbX92mCmLobuI2RnT22NAeFYi++VncsNYP/Uv6ILgmoBb2UinsgQ==
X-Received: by 2002:a62:209c:: with SMTP id m28mr31113893pfj.233.1554753496623;
        Mon, 08 Apr 2019 12:58:16 -0700 (PDT)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id l5sm55488310pfi.97.2019.04.08.12.58.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 12:58:15 -0700 (PDT)
Date:   Mon, 8 Apr 2019 12:58:14 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Kelley Nielsen <kelleynnn@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 2/4] mm: swapoff: remove too limiting SWAP_UNUSE_MAX_TRIES
In-Reply-To: <alpine.LSU.2.11.1904081249370.1523@eggly.anvils>
Message-ID: <alpine.LSU.2.11.1904081256170.1523@eggly.anvils>
References: <alpine.LSU.2.11.1904081249370.1523@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWAP_UNUSE_MAX_TRIES 3 appeared to work well in earlier testing, but
further testing has proved it to be a source of unnecessary swapoff
EBUSY failures (which can then be followed by unmount EBUSY failures).

When mmget_not_zero() or shmem's igrab() fails, there is an mm exiting
or inode being evicted, freeing up swap independent of try_to_unuse().
Those typically completed much sooner than the old quadratic swapoff,
but now it's more common that swapoff may need to wait for them.

It's possible to move those cases from init_mm.mmlist and shmem_swaplist
to separate "exiting" swaplists, and try_to_unuse() then wait for those
lists to be emptied; but we've not bothered with that in the past, and
don't want to risk missing some other forgotten case. So just revert
to cycling around until the swap is gone, without any retries limit.

Fixes: b56a2d8af914 ("mm: rid swapoff of quadratic complexity")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/swapfile.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- 5.1-rc4/mm/swapfile.c	2019-03-17 16:18:15.713823942 -0700
+++ linux/mm/swapfile.c	2019-04-07 19:15:01.269054187 -0700
@@ -2023,7 +2023,6 @@ static unsigned int find_next_to_unuse(s
  * If the boolean frontswap is true, only unuse pages_to_unuse pages;
  * pages_to_unuse==0 means all pages; ignored if frontswap is false
  */
-#define SWAP_UNUSE_MAX_TRIES 3
 int try_to_unuse(unsigned int type, bool frontswap,
 		 unsigned long pages_to_unuse)
 {
@@ -2035,7 +2034,6 @@ int try_to_unuse(unsigned int type, bool
 	struct page *page;
 	swp_entry_t entry;
 	unsigned int i;
-	int retries = 0;
 
 	if (!si->inuse_pages)
 		return 0;
@@ -2117,14 +2115,16 @@ retry:
 	 * If yes, we would need to do retry the unuse logic again.
 	 * Under global memory pressure, swap entries can be reinserted back
 	 * into process space after the mmlist loop above passes over them.
-	 * Its not worth continuosuly retrying to unuse the swap in this case.
-	 * So we try SWAP_UNUSE_MAX_TRIES times.
+	 *
+	 * Limit the number of retries? No: when shmem_unuse()'s igrab() fails,
+	 * a shmem inode using swap is being evicted; and when mmget_not_zero()
+	 * above fails, that mm is likely to be freeing swap from exit_mmap().
+	 * Both proceed at their own independent pace: we could move them to
+	 * separate lists, and wait for those lists to be emptied; but it's
+	 * easier and more robust (though cpu-intensive) just to keep retrying.
 	 */
-	if (++retries >= SWAP_UNUSE_MAX_TRIES)
-		retval = -EBUSY;
-	else if (si->inuse_pages)
+	if (si->inuse_pages)
 		goto retry;
-
 out:
 	return (retval == FRONTSWAP_PAGES_UNUSED) ? 0 : retval;
 }
