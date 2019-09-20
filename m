Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B803C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279BC2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403836AbfITP2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:28:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37720 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391593AbfITP2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:28:34 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iBKpY-0000P5-0U; Fri, 20 Sep 2019 15:28:20 +0000
Date:   Fri, 20 Sep 2019 16:28:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     dwmw2@infradead.org, dilinger@queued.net, richard@nod.at,
        houtao1@huawei.com, bbrezillon@kernel.org, daniel.santos@pobox.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jffs2:freely allocate memory when parameters are invalid
Message-ID: <20190920152819.GO1131@ZenIV.linux.org.uk>
References: <1568962478-126260-1-git-send-email-nixiaoming@huawei.com>
 <20190920114336.GM1131@ZenIV.linux.org.uk>
 <206f8d57-dad9-26c3-6bf6-1d000f5698d4@huawei.com>
 <20190920124532.GN1131@ZenIV.linux.org.uk>
 <20190920125442.GA20754@ZenIV.linux.org.uk>
 <eb679ad2-4020-951c-e4d1-60cb059a5ca8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb679ad2-4020-951c-e4d1-60cb059a5ca8@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 10:13:53PM +0800, Xiaoming Ni wrote:
> 1. drivers/mtd/mtdsuper.c
> mount_mtd_aux() {
> ....
>    /* jffs2_sb_info is allocated in jffs2_fill_super, */
>     ret = fill_super(sb, data, flags & SB_SILENT ? 1 : 0);
>     if (ret < 0) {
>         deactivate_locked_super(sb); /* If the parameter is wrong, release it here*/
>         return ERR_PTR(ret);
>     }
> ...
> }
> 
> 2. fs/super.c
> deactivate_locked_super()
> ---> fs->kill_sb(s);
> 
> 3. fs/jffs2/super.c
>  jffs2_kill_sb()
>     kfree(c); /*release jffs2_sb_info allocated by jffs2_fill_super here
> 
> Here memory allocation and release,
> experienced the function of mount_mtd_aux/deactivate_locked_super/jffs2_kill_sb three different files,
> the path is relatively long,
> if any of the three functions between the errors,

If any of the three functions _what_?

> it will cause problems (such as memory leaks)
 
> I still think this is easier to understand:
>  Free the memory allocated by the current function in the failed branch

No.  Again, "failed" branch is going to be practically untested during
any later code changes.  The more you have to do in those, the faster they
rots.  And they _do_ rot - we'd seen that happening again and again.

As a general rule, the fewer cleanups are required on failure exits, the
better off we are.

> static void jffs2_kill_sb(struct super_block *sb)
> {
>     struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
>     if (c && !sb_rdonly(sb))
> 		/* If sb is not read only,
> 		 * then jffs2_stop_garbage_collect_thread() will be executed
> 		 * when the jffs2_fill_super parameter is invalid.
> 		 */
>         jffs2_stop_garbage_collect_thread(c);
>     kill_mtd_super(sb);
>     kfree(c);
> }
> 
> void jffs2_stop_garbage_collect_thread(struct jffs2_sb_info *c)
> {
>     int wait = 0;
> 	/* When the jffs2_fill_super parameter is invalid,
> 	 * this lock is not initialized.
> 	 * Is this a code problem ?
> 	 */
>     spin_lock(&c->erase_completion_lock);

Not in practice and gone in mainline this cycle.  But yes, those initializations
should've been done prior to any failure exits -
"jffs2: free jffs2_sb_info through jffs2_kill_sb()" ought to have moved them
prior to the call of jffs2_parse_options().
