Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C39C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0855C218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556097301;
	bh=Yr/IDKMMqkGJbj7j5S0Z4HCvIM4RuYst75fudGbpuZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s0BB0CKykbi+21Vy1TCkSN34dH62Psx8pwFaUqFuxvJdPooErDftq08ZTCCP83XEX
	 jcepqK809ujTtaEvEm6WVVgE2Q8uF/9FzAxlxUxMpnVDTFgMwhtjl4E+ykkoteIz+G
	 OQ5S1Zpag53cib9bbO412ZVeMXdi/Eoy+Ctv9eqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfDXJO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfDXJO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:14:59 -0400
Received: from localhost (unknown [104.132.45.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 561FD20656;
        Wed, 24 Apr 2019 09:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556097298;
        bh=Yr/IDKMMqkGJbj7j5S0Z4HCvIM4RuYst75fudGbpuZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2UIJESRbkiSEH9tP3TuukI2IzKuHl49JHzDQBxbWsk0GRBoqmXs74y9lrNwP3MiI5
         6McJX8fkne2wT5cEKHpFt6JvB+PbDJVastLlGvvTt8H5JjioNmWTHmcYWJRZPOyNQv
         d2Cda/HaQvenGOvxDYzvJBQnfyaaeA1p2vvnJiZg=
Date:   Wed, 24 Apr 2019 10:14:56 +0100
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v2 4/5] f2fs: add tracepoint for f2fs_filemap_fault()
Message-ID: <20190424091456.GB38756@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190415072219.1613-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415072219.1613-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15, Chao Yu wrote:
> This patch adds tracepoint for f2fs_filemap_fault().
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - fix wrong type of @ret parameter
>  fs/f2fs/file.c              |  2 ++
>  include/trace/events/f2fs.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 30d49467578e..578486e03427 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -39,6 +39,8 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
>  	ret = filemap_fault(vmf);
>  	up_read(&F2FS_I(inode)->i_mmap_sem);
>  
> +	trace_f2fs_filemap_fault(inode, vmf->pgoff, ret);

In order to avoid wrong casting warning, how about this?

---
 include/trace/events/f2fs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index abe763cc1d0b..c29dea7ac0fe 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1286,7 +1286,7 @@ DEFINE_EVENT(f2fs__page, f2fs_commit_inmem_page,
 
 TRACE_EVENT(f2fs_filemap_fault,
 
-	TP_PROTO(struct inode *inode, pgoff_t index, enum vm_fault_reason ret),
+	TP_PROTO(struct inode *inode, pgoff_t index, vm_fault_t ret),
 
 	TP_ARGS(inode, index, ret),
 
@@ -1294,7 +1294,7 @@ TRACE_EVENT(f2fs_filemap_fault,
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
 		__field(pgoff_t, index)
-		__field(enum vm_fault_reason, ret)
+		__field(vm_fault_t, ret)
 	),
 
 	TP_fast_assign(
@@ -1304,10 +1304,10 @@ TRACE_EVENT(f2fs_filemap_fault,
 		__entry->ret	= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, index = %lu, ret = %u",
+	TP_printk("dev = (%d,%d), ino = %lu, index = %lu, ret = %lx",
 		show_dev_ino(__entry),
 		(unsigned long)__entry->index,
-		ret)
+		(unsigned long)__entry->ret)
 );
 
 TRACE_EVENT(f2fs_writepages,
-- 
2.19.0.605.g01d371f741-goog

