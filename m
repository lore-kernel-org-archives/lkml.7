Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F9EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A0D20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551988446;
	bh=yrrqD8L0aFKquKjy6Fw+wsLPmI1G+ZfTrMwYkdhZPLY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=i69ZNvkpeM4BQvf9wWnS2cqFN7j+ltAaEe82AWCbVafu4xE/6v6SnQWS4xcYcE3sE
	 S/FNY1KFVO2g1j8iIghdIibstUTKE+FYq15hKJXPhUwS/y/krd+3VoiwckQb40E3Wm
	 lx+wCzmPB8Km3kugM/TUeg5Yi+nS6G7XnKNU/KX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfCGTyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:54:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42678 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfCGTyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:54:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id r5so18886560wrg.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 11:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WQyQmja2ae3D5kGmpQXvyk1KJCwj//VzuS1oFvg6xmo=;
        b=OvUyJMUQBJx3fI3Abxc9ZJzeUdQNi8axfxHFj33Lg2ULGaWJiT9WqX2JUuZO63eODU
         x3uNuv1VjgSilFttNq/P7C+5cy0PdvX3gWqYo8y8rcr87AniocnU4MqZD7xkRDNLLJgx
         6Cbt0liGssop06GVKLbifpT5Pivz6y6d0jmqMuaaCzC1nmplf1+vM0vLcRGiKz7aD0EM
         +PH1rnNkbuEH6xbrFbKgcyPSqv2OXJV0R/KTO469ovnCZjWDQbS5+AcMOR8VXFU9UubH
         SBChef1ZMyC7iZaLm4nTGoRJjEpriq+6HdMxdQSaK/04S273/5nhQbgZd1rUtng1a0lB
         zRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=WQyQmja2ae3D5kGmpQXvyk1KJCwj//VzuS1oFvg6xmo=;
        b=Qv6i1e8yAlYkmB7JYuBo5amVvlnRtY6mljvkesiB5fho52pNgj9kBB7oCY3ZMDHoTo
         aSDsSAnUP+QoA6dMMd1PHEDQZGIejkSanDlXgr0xcUFWQ+KE7YSPoC4I31qnZ36FfR+p
         OHQtqWdQpqxb6RuPyBp6hohBcWOhI28tIzpsmE3IqS8UreKQKd4aNFInVbZvh+d2qNKO
         SVkNsZtvfXQu7tUc+cqNwi6WlVgLrdlAfa2iVKV1IfxU4A+doS2E+CtgrDWsuCYkDvtC
         bV8Hg1SaOX/TmtIn9peysYWcPpvobK5EnN1cbB+fxeEDM0i6Oq4/FCbD06b/oS/EagKt
         c2Mw==
X-Gm-Message-State: APjAAAXWnFa53JKwvMCP/rQxN9cSe2gLTBGLdPW9mXjtrlxsf/snQprM
        DFe1VhjnaadtCKQ9nTGGALI=
X-Google-Smtp-Source: APXvYqxYZEVsTIQLIHq/sVY5BD8twXnXFvbBNG54w3bc5xWZzVWFZ3f8JJbk4Ah8AAE1hAErc0O5Iw==
X-Received: by 2002:adf:9f54:: with SMTP id f20mr8312581wrg.88.1551988442792;
        Thu, 07 Mar 2019 11:54:02 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id k20sm5858301wre.41.2019.03.07.11.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 11:54:02 -0800 (PST)
Date:   Thu, 7 Mar 2019 20:54:00 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/mm change for v5.1
Message-ID: <20190307195400.GA72443@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-mm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus

   # HEAD: ad8cfb9c42ef83ecf4079bc7d77e6557648e952b mm/gup: Remove the 'write' parameter from gup_fast_permitted()

A single GUP cleanup.

  out-of-topic modifications in x86-mm-for-linus:
  -------------------------------------------------
  mm/gup.c                           # ad8cfb9c42ef: mm/gup: Remove the 'write' p

 Thanks,

	Ingo

------------------>
Ira Weiny (1):
      mm/gup: Remove the 'write' parameter from gup_fast_permitted()


 arch/x86/include/asm/pgtable_64.h | 3 +--
 mm/gup.c                          | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 9c85b54bf03c..0bb566315621 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -259,8 +259,7 @@ extern void init_extra_mapping_uc(unsigned long phys, unsigned long size);
 extern void init_extra_mapping_wb(unsigned long phys, unsigned long size);
 
 #define gup_fast_permitted gup_fast_permitted
-static inline bool gup_fast_permitted(unsigned long start, int nr_pages,
-		int write)
+static inline bool gup_fast_permitted(unsigned long start, int nr_pages)
 {
 	unsigned long len, end;
 
diff --git a/mm/gup.c b/mm/gup.c
index 05acd7e2eb22..b63e88eca31b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1786,7 +1786,7 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
  * Check if it's allowed to use __get_user_pages_fast() for the range, or
  * we need to fall back to the slow version:
  */
-bool gup_fast_permitted(unsigned long start, int nr_pages, int write)
+bool gup_fast_permitted(unsigned long start, int nr_pages)
 {
 	unsigned long len, end;
 
@@ -1828,7 +1828,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	 * block IPIs that come from THPs splitting.
 	 */
 
-	if (gup_fast_permitted(start, nr_pages, write)) {
+	if (gup_fast_permitted(start, nr_pages)) {
 		local_irq_save(flags);
 		gup_pgd_range(start, end, write, pages, &nr);
 		local_irq_restore(flags);
@@ -1870,7 +1870,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	if (unlikely(!access_ok((void __user *)start, len)))
 		return -EFAULT;
 
-	if (gup_fast_permitted(start, nr_pages, write)) {
+	if (gup_fast_permitted(start, nr_pages)) {
 		local_irq_disable();
 		gup_pgd_range(addr, end, write, pages, &nr);
 		local_irq_enable();

