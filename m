Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C585C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3331217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555507777;
	bh=0xJnJZYcgd0q+PpUhdPcfaC9aLx6V78fhgRRB1mEoMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j6O5zequVm+zRXdBsH9ek5x9M6ZxmINCiCqaX+LZkYeLKIhOrCpljokUE51v+bKY9
	 i2cDr9JINsKwH53TiFtI5W5ESP+o6PJPgdNloepMYqE17FPewpIcW52pK6et3iWuAD
	 DqOji/Bf+01huJ8UbqTW3c0xxORal0gfEmaVd5rQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbfDQN3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbfDQN3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:29:35 -0400
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 655C72173C;
        Wed, 17 Apr 2019 13:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555507774;
        bh=0xJnJZYcgd0q+PpUhdPcfaC9aLx6V78fhgRRB1mEoMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uoNwipDx1HX3uEz2u3yaItHobSLLQ/0QXLuhaUOmRGGBhP8yLFszHDQ2fyP/Qd9C6
         oF0X93LjGfK00Z70keih5xxx+48yoTecUC3dROMESmURbKStfr4V7TjSLW1vT/d4WL
         4JAu/5IIYYzOmO1tZkQ2/dbBplQjtMvdXQzLIAH8=
Date:   Wed, 17 Apr 2019 15:29:29 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        rcu@vger.kernel.org, kernel-hardening@lists.openwall.com,
        kernel-team@android.com, keescook@chromium.org
Subject: Re: [PATCH v3 1/3] module: Prepare for addition of new ro_after_init
 sections
Message-ID: <20190417132929.GC17099@linux-8ccs>
References: <20190410195708.162185-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190410195708.162185-1-joel@joelfernandes.org>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Joel Fernandes (Google) [10/04/19 15:57 -0400]:
>For the purposes of hardening modules by adding sections to
>ro_after_init sections, prepare for addition of new ro_after_init
>entries which we do in future patches. Create a table to which new
>entries could be added later. This makes it less error prone and reduce
>code duplication.
>
>Cc: paulmck@linux.vnet.ibm.com
>Cc: rostedt@goodmis.org
>Cc: mathieu.desnoyers@efficios.com
>Cc: rcu@vger.kernel.org
>Cc: kernel-hardening@lists.openwall.com
>Cc: kernel-team@android.com
>Suggested-by: keescook@chromium.org
>Reviewed-by: keescook@chromium.org
>Acked-by: rostedt@goodmis.org
>Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Hi Joel!

Thanks for the patchset! Apologies for the late reply, I've returned
from vacation this week and am catching up on the previous threads..

And if I'm all caught up now, it looks like the plan now is to drop
this patchset in favor of just marking the srcu pointer array const,
is that correct? That should put it in a rodata section (ie., a
section without SHF_WRITE) and the module loader will mark it RO
appropriately after relocations are applied, so it really doesn't have
to be a ro_after_init section then if I'm understanding correctly.

Jessica

>---
> kernel/module.c | 41 +++++++++++++++++++++++------------------
> 1 file changed, 23 insertions(+), 18 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 524da609c884..42e4e289d6c7 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -3300,11 +3300,27 @@ static bool blacklisted(const char *module_name)
> }
> core_param(module_blacklist, module_blacklist, charp, 0400);
>
>+/*
>+ * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
>+ * layout_sections() can put it in the right place.
>+ * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
>+ */
>+static const char * const ro_after_init_sections[] = {
>+	".data..ro_after_init",
>+
>+	/*
>+	 * __jump_table structures are never modified, with the exception of
>+	 * entries that refer to code in the __init section, which are
>+	 * annotated as such at module load time.
>+	 */
>+	"__jump_table",
>+};
>+
> static struct module *layout_and_allocate(struct load_info *info, int flags)
> {
> 	struct module *mod;
> 	unsigned int ndx;
>-	int err;
>+	int err, i;
>
> 	err = check_modinfo(info->mod, info, flags);
> 	if (err)
>@@ -3319,23 +3335,12 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
> 	/* We will do a special allocation for per-cpu sections later. */
> 	info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
>
>-	/*
>-	 * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
>-	 * layout_sections() can put it in the right place.
>-	 * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
>-	 */
>-	ndx = find_sec(info, ".data..ro_after_init");
>-	if (ndx)
>-		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
>-	/*
>-	 * Mark the __jump_table section as ro_after_init as well: these data
>-	 * structures are never modified, with the exception of entries that
>-	 * refer to code in the __init section, which are annotated as such
>-	 * at module load time.
>-	 */
>-	ndx = find_sec(info, "__jump_table");
>-	if (ndx)
>-		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
>+	/* Set sh_flags for read-only after init sections */
>+	for (i = 0; i < ARRAY_SIZE(ro_after_init_sections); i++) {
>+		ndx = find_sec(info, ro_after_init_sections[i]);
>+		if (ndx)
>+			info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
>+	}
>
> 	/* Determine total sizes, and put offsets in sh_entsize.  For now
> 	   this is done generically; there doesn't appear to be any
>-- 
>2.21.0.392.gf8f6787159e-goog
>
