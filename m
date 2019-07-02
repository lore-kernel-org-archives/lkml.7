Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619C6C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361572089C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mBLQgYkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfGCAyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:54:36 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:44178 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfGCAyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:54:35 -0400
Received: by mail-ot1-f73.google.com with SMTP id q16so416254otn.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 17:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R48TQi9q1FK2+H6bY660z2znRHgaYhNpT8f8fUMByQw=;
        b=mBLQgYkxMEYzGqUznWDGxambBtuhZyiOOJORpyP891jPKRAhRjUBbORNd+4DveyMeD
         rGZ3DeH9paDarY7J+YcNLIlYdogJBVNEJKYgDw+S6n1p9yHE06ZYNNVgi++pBAmRFG/v
         rjO2ylNX11c0/iLdV/4/sLLWlx34EOzgETHmr/fYlkrJmVTXymJmHBBZhFl2QT6PpdCU
         IFOReC8/kxoOUztR6XJtbeONmYjlCu8W0aKlHJKEpIfHJv0Tux8zLMjt2JtmJAp35Mlb
         d1cbsotsN2YitgBnWkr+C909Etlm7N0KjWV5gNA1tpvHAhnYmcinusuyfNvhKkIgrINt
         FOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R48TQi9q1FK2+H6bY660z2znRHgaYhNpT8f8fUMByQw=;
        b=JOCHvNk+gnuLe1n7FzgfTuVc3h/YqCxkN0ilw1CUWwyKYz9dwOXQYTzBnZECWGU07W
         iRMTbRa/36xmRGzsiG1BpU08Cb3FFmbzzCmDP98t/wqWtvcOEPuOLp90TUP+G8oyfsOn
         zvIs3u+/jfByRkLOXhOdVjE3Gz21E9CRWIYdWERB2UmPa/5cZXJDsJGchg3EUglCAc6Y
         p4Fvy53f40uNHbxSalZ/YSy8crei9gdXAPQ+UWT75wuX7YLItpUEXd8Fcy9z2NED8FhT
         9j5OGNJO3pNYPezzO7i6/jNNCq21uUR9bd26gAIknc71+yx9XHQ2cgkJfPlXgxcuh0/0
         jnYQ==
X-Gm-Message-State: APjAAAUsmaRuHBWDv+ynINvrBPi418RX4fYJaefUDsqAJR/UAgwFxVr/
        ZqxqwH6J8/hMvq/7LfpjvKp00VaS1w==
X-Google-Smtp-Source: APXvYqxlTTxA9kVd7nmSx/MlM/hqPfeDUWd1gdGvu4tmxQfmIm2aDz4ezGffhECd1ECKMzycYcMzcnsBww==
X-Received: by 2002:a63:6c04:: with SMTP id h4mr2529866pgc.94.1562111113724;
 Tue, 02 Jul 2019 16:45:13 -0700 (PDT)
Date:   Tue,  2 Jul 2019 16:41:35 -0700
In-Reply-To: <CAJkfWY4yvVVmJoQ0WwyoFBkWYsUJnnQPNU+-g23-m-L3ETe_hQ@mail.gmail.com>
Message-Id: <20190702234135.78780-1-nhuck@google.com>
Mime-Version: 1.0
References: <CAJkfWY4yvVVmJoQ0WwyoFBkWYsUJnnQPNU+-g23-m-L3ETe_hQ@mail.gmail.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2] arm64: mm: Fix dead assignment of old_pte
From:   Nathan Huckleberry <nhuck@google.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When analyzed with the clang static analyzer the
following warning occurs

line 251, column 2
Value stored to 'old_pte' is never read

This warning is repeated every time pgtable.h is
included by another file and produces ~3500
extra warnings.

Moving old_pte into preprocessor guard.

Cc: clang-built-linux@googlegroups.com
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
Changes from v1 -> v2
* Added scope to avoid [-Wdeclaration-after-statement]
 arch/arm64/include/asm/pgtable.h | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index fca26759081a..12b7f08db40d 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -238,8 +238,6 @@ extern void __sync_icache_dcache(pte_t pteval);
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
-	pte_t old_pte;
-
 	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
 		__sync_icache_dcache(pte);
 
@@ -248,16 +246,23 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	 * hardware updates of the pte (ptep_set_access_flags safely changes
 	 * valid ptes without going through an invalid entry).
 	 */
-	old_pte = READ_ONCE(*ptep);
-	if (IS_ENABLED(CONFIG_DEBUG_VM) && pte_valid(old_pte) && pte_valid(pte) &&
-	   (mm == current->active_mm || atomic_read(&mm->mm_users) > 1)) {
-		VM_WARN_ONCE(!pte_young(pte),
-			     "%s: racy access flag clearing: 0x%016llx -> 0x%016llx",
-			     __func__, pte_val(old_pte), pte_val(pte));
-		VM_WARN_ONCE(pte_write(old_pte) && !pte_dirty(pte),
-			     "%s: racy dirty state clearing: 0x%016llx -> 0x%016llx",
-			     __func__, pte_val(old_pte), pte_val(pte));
+	#if IS_ENABLED(CONFIG_DEBUG_VM)
+	{
+		pte_t old_pte;
+
+		old_pte = READ_ONCE(*ptep);
+		if (pte_valid(old_pte) && pte_valid(pte) &&
+		  (mm == current->active_mm ||
+		   atomic_read(&mm->mm_users) > 1)) {
+			VM_WARN_ONCE(!pte_young(pte),
+				     "%s: racy access flag clearing: 0x%016llx -> 0x%016llx",
+				     __func__, pte_val(old_pte), pte_val(pte));
+			VM_WARN_ONCE(pte_write(old_pte) && !pte_dirty(pte),
+				     "%s: racy dirty state clearing: 0x%016llx -> 0x%016llx",
+				     __func__, pte_val(old_pte), pte_val(pte));
+		}
 	}
+	#endif
 
 	set_pte(ptep, pte);
 }
-- 
2.22.0.410.gd8fdbe21b5-goog

