Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE15C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374232084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-cmu-edu.20150623.gappssmtp.com header.i=@cs-cmu-edu.20150623.gappssmtp.com header.b="YGbwj8fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbfDBTRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:17:08 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41064 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDBTRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:17:08 -0400
Received: by mail-qk1-f194.google.com with SMTP id o129so8621643qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 12:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs-cmu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9+rcSupZWZzeyDVwPpQBMVUt6g4qM30iac0BTZcOAdo=;
        b=YGbwj8fjeTBePOoULeB0rorVsaEyzV8P3Sjb9KPkFc3R4q35hE0wiO0iInZdrgNb6M
         Y2X/UBWclNFDu5cWzXcWSns7l5I2MX5eLMoUnIRP79WhwN33dLTAqrGXEjQeK+Fv8xbw
         kvIyo7KAXT/ccGszSFYBQUrgecI3LRJAFcyFMK9nkw2bMG2Wn7xTJ0w6VE+sIeCWXCGg
         SOLpeQrYC5JFhEO8h4GFRu5Su+hmKh7OYSvRsZcPOr2nYRb7Y6ZlCT2dSamWv0/FmbgX
         QfejxHxiiOIcC09tgEiyy7EEii1Fh6mb+eqwRTQknfqQQCHvCk6VRRDvvjHZ9tkVQeA2
         M5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9+rcSupZWZzeyDVwPpQBMVUt6g4qM30iac0BTZcOAdo=;
        b=D93irX8pLkKXV8SrBU+URRGKlzHsteryXP17z41DJcGz0PWLZukIXFUkeG95aQ4ySk
         a55lVkRx+pgrVNXCVk4wGQFaOKMiovSE4e/8sG9njGbvld3WIWbETm2aDI+r/GovGbKL
         /PplPG/tHGCnihsLBZrF+xQgFoLZ3s7qLevijLnPGgsYG+lc4BRMWBCqs4iQjv1/dW1z
         Z6fx9m13fnZT+sG5CX8CoEnlue3ak25gj88owGez0Wp7yXQ5QstyVZ7wXecVZ1ph7eag
         CsnQSIr91eySIszVnP5COlzCUqeSTHWpCOrQQCUBkaCZ3MMQW7Hm/7Yao/1dHYCoqac+
         sLtA==
X-Gm-Message-State: APjAAAVx6et1Yltyg5JqsIy9EhzGV7zsVtM7nAvTEOv2skGqAzUWVP/x
        GWxndtUWYSloBCGdjkMLjq3KRw==
X-Google-Smtp-Source: APXvYqz/Gvj3vBEBoRfNrhK+FQUS6q6rjfUHkP5yj7Px6xlYnM7fEw2HIyPbe/WdOPIPzSjBSbAilw==
X-Received: by 2002:ae9:c219:: with SMTP id j25mr40499403qkg.82.1554232626942;
        Tue, 02 Apr 2019 12:17:06 -0700 (PDT)
Received: from cs.cmu.edu (tunnel29655-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:582::2])
        by smtp.gmail.com with ESMTPSA id s189sm8049077qkh.19.2019.04.02.12.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 12:17:06 -0700 (PDT)
Date:   Tue, 2 Apr 2019 15:17:03 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Pedro Cuadra Chamorro <pcuadrac@cs.cmu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: fs/coda oops bisected to (925b9cd1b8) "locking/rwsem: Make owner
 store task pointer of last owni
Message-ID: <20190402191702.akrg64fqtqrnu7tr@cs.cmu.edu>
References: <20190331040023.qbx52lwzufkxg3kw@cs.cmu.edu>
 <497db260-fb1e-4b37-319f-6806df87f270@redhat.com>
 <20190331191347.irnmkv6ocwsq4r5r@cs.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331191347.irnmkv6ocwsq4r5r@cs.cmu.edu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 03:13:47PM -0400, Jan Harkes wrote:
> On Sun, Mar 31, 2019 at 02:14:13PM -0400, Waiman Long wrote:
> > One possibility is that there is a previous reference to the memory
> > currently occupied by the spinlock. If the memory location is previously
> > part of a rwsem structure and someone is still using it, you may get
> > memory corruption.
> 
> Ah, I hadn't even thought of that possibility. Good, it will open up

First of all, I have to thank you for your original patch because
otherwise I probably would never have discovered that something was
seriously wrong. Your patch made the problem visible.

I ended up changing 'owner' to '_RET_IP_' and dumping the value of the
clobbered coda inode spinlock and surrounding memory and found that the
'culprit' is in ext4_filemap_fault and despite it being in ext4, it is
still a Coda specific problem.

Effectively Coda overlays other filesystems' inodes for mmap, but
the vma->vm_file still points at Coda's file. So when we use
file_inode() in ext4_filemap_fault we end up with the Coda inode instead
of the ext4 inode and when trying to grab ext4's mmap_sem we really just
scribble over the memory region that happens to contain the Coda inode
spinlock. A fix is to use vm_file->f_mapping->host instead of
file_inode(vm_file).

Of course everyone looks at ext4 as a canonical example so this problem
has spread pretty much everywhere and I'm wondering how to best resolve
this.

- change file_inode() to follow file->f_mapping->host

  would fix most places, but maybe f_mapping is not always guaranteed to
  point at a usable place?

- change Coda's mmap to replace vma->vm_file with the host file

  we'd probably no longer get notified when the last reference to the
  host file goes away, so we'd call coda_release and notify userspace on
  close() even when there are still active mmap regions.

- fix every in-tree file system to use vma->vm_file->f_mapping->host.

Jan


diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 69d65d49837b..122d691d3eda 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -284,7 +284,7 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
 	vm_fault_t result;
 	int retries = 0;
 	handle_t *handle = NULL;
-	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct inode *inode = vmf->vma->vm_file->f_mapping->host;
 	struct super_block *sb = inode->i_sb;
 
 	/*
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b54b261ded36..62a0025ce7f8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6211,7 +6211,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	int err;
 	vm_fault_t ret;
 	struct file *file = vma->vm_file;
-	struct inode *inode = file_inode(file);
+	struct inode *inode = file->f_mapping->host;
 	struct address_space *mapping = inode->i_mapping;
 	handle_t *handle;
 	get_block_t *get_block;
@@ -6302,7 +6302,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 
 vm_fault_t ext4_filemap_fault(struct vm_fault *vmf)
 {
-	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct inode *inode = vmf->vma->vm_file->f_mapping->host;
 	vm_fault_t ret;
 
 	down_read(&EXT4_I(inode)->i_mmap_sem);
