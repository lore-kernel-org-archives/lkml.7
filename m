Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E547AC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 19:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5B42075A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 19:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nzYb4j+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfK3Tgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 14:36:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfK3Tgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 14:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rQO7nvEmCSTDzgzoKpcBFISQsdKk+XVsuDPS6y48qVU=; b=nzYb4j+0RcrcK4wFm3V0QFliC
        cPKNagy9XImaHaOA4+Asmg46Nk2koJFaxUuliqrTJAFTtZoe8Z1VznbSoir/nCiZ2NcyfHIh3nXfW
        /eMUPc3nf8RHiFONSG+eLA2A+mqmZKZutAY03I5n1MWHr4TdW4+DfQVVRzWYBYi5L3qLYzrTN7Fos
        wC4N+FQEedvg1Y/e28HVgcRz17O22It335Xiv4vOTazZq+rc22JkzWe7pIPryl5mSqNeT4Sl8PB5I
        s+Jzp27ur6p+Ps6AnXq38cTR/XSqD1HcSSUlWWtlcQ7ZX2iSSB6Ggh86MV30wmfYVWfNCujYkROMc
        MO2+WKI6w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ib8XP-0001xZ-Op; Sat, 30 Nov 2019 19:36:15 +0000
Date:   Sat, 30 Nov 2019 11:36:15 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        viro@zeniv.linux.org.uk, rostedt@goodmis.org, oleg@redhat.com,
        mchehab+samsung@kernel.org, corbet@lwn.net, tytso@mit.edu,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, zhengbin13@huawei.com,
        yi.zhang@huawei.com, chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [PATCH V2 1/3] dcache: add a new enum type for
 'dentry_d_lock_class'
Message-ID: <20191130193615.GJ20752@bombadil.infradead.org>
References: <20191130020225.20239-1-yukuai3@huawei.com>
 <20191130020225.20239-2-yukuai3@huawei.com>
 <20191130034339.GI20752@bombadil.infradead.org>
 <e2e7c9f1-7152-1d74-c434-c2c4d57d0422@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2e7c9f1-7152-1d74-c434-c2c4d57d0422@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2019 at 03:53:10PM +0800, yukuai (C) wrote:
> On 2019/11/30 11:43, Matthew Wilcox wrote:
> > On Sat, Nov 30, 2019 at 10:02:23AM +0800, yu kuai wrote:
> > > However, a single 'DENTRY_D_LOCK_NESTED' may not be enough if more than
> > > two dentry are involed. So, add in 'DENTRY_D_LOCK_NESTED_TWICE'.
> > 
> > No.  These need meaningful names.  Indeed, I think D_LOCK_NESTED is
> > a terrible name.
> > 
> > The exception is __d_move() where I think we should actually name the
> > different lock classes instead of using a bare '2' and '3'.  Something
> > like this, perhaps:
> 
> Thanks for looking into this, do you mind if I replace your patch with the
> first two patches in the patchset?

That's fine by me, but I think we should wait for Al to give his approval
before submitting a new version.

I'm also not entirely content with the explanation I wrote last night.
Maybe this instead ...

 /*
- * dentry->d_lock spinlock nesting subclasses:
+ * dentry->d_lock spinlock nesting subclasses.  Always taken in increasing
+ * order although some subclasses may be skipped.  If one dentry is the
+ * ancestor of another, then the ancestor's d_lock is taken before the
+ * descendent.  If NORMAL and PARENT_2 do not have a hierarchical relationship
+ * then you must hold the s_vfs_rename_mutex to prevent another thread taking
+ * the locks in the opposite order, or NORMAL and PARENT_2 becoming
+ * hierarchical through a rename operation.
  *
  * 0: normal
- * 1: nested
+ * 1: either a descendent of "normal" or a cousin.
+ * 2: child of the "normal" dentry
+ * 3: child of the "parent2" dentry
  */
 enum dentry_d_lock_class
 {
-       DENTRY_D_LOCK_NORMAL, /* implicitly used by plain spin_lock() APIs. */
-       DENTRY_D_LOCK_NESTED
+       DENTRY_D_LOCK_NORMAL,   /* implicitly used by plain spin_lock() APIs */
+       DENTRY_D_LOCK_PARENT_2, /* not an ancestor of normal */
+       DENTRY_D_LOCK_CHILD,    /* nests under parent's lock */
+       DENTRY_D_LOCK_CHILD_2,  /* PARENT_2's child */
 };

