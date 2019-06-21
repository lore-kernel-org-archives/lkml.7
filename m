Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B52C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FAA206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="MMv0Ydn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfFUNjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:39:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35609 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfFUNjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:39:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id w20so2568952edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AdpAsciClW5VStBwxplQLFyT5xLaWG5vW4nBjzS9ue8=;
        b=MMv0Ydn948bMlAsUr3EOQTiiiIsndLshwaLg99cYJeSWvgk03QQ2LSLT1DwHnI+ttt
         fYLpn0rHMLs5dRVqs577Vdjp9fQVNg1AI7YMotlVBRgN2G+jxYa30fNPDT4cxuIBbnbv
         dvkhiikckPj8I9WO4qszbrxQqjT4JDmftO4ZkqoU6ylL3W02f46VZgCH18TT1nSpqoIR
         iYL16BfVrpSfbVFU4fdiZv/1CJyG5zDKZV62sGCL+E2XVUEGFbl4jyZB5dUrvDb+Wm2X
         ESnK59f5G2A768/OcKoYqJIV3GVjhBwChxmegwrnBe1M3OaBl4qF1jOpFlqBJ6y5eTG+
         g4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AdpAsciClW5VStBwxplQLFyT5xLaWG5vW4nBjzS9ue8=;
        b=SnXyjwC/+oOaRx5+CI1cAeM/59SpwKEpBuzPsnIPOWI8mp4JT8AhK6XRfxg1YeUlR/
         FDQ+XCciQh4VkYnuAxWzzm9mtBXraE0Z7Qbr+lpFO9IqprkwaeTfiEpcyMlWl+nlf+H3
         k/oc21ZEzZJPAU2mX6+H6CDxhcbAB4Ep4mBeU6fcGW3aTMwYD2Dp6u7Q+CG2f2GkQJoQ
         /rAWdmOFObohBSulcGkc5UjLvk+5mP9ceeTENwNcjegbdgZ6u4x696gF7pMnzvQe2l2s
         vpZr01wCUXTorq28ioSo3yMIcq+VDBZmsM8/SDRvc2rdlj9blbYvAswXoN6sTlXS15E4
         lvHg==
X-Gm-Message-State: APjAAAX0E8w3jrf4HXcqaQy818ri8uca0HWSLduK0D4Evn60JuQ5/Nk3
        Vk5qjRFjmCOj4anqQD6ZbsAebA==
X-Google-Smtp-Source: APXvYqyfo29+EXbgAlEhNY5mM3p5DZaIm16f0XKm7106HMmSS3lHu91bLkjtSP71e9ueQByDkzUQEg==
X-Received: by 2002:a50:974b:: with SMTP id d11mr110357427edb.24.1561124387072;
        Fri, 21 Jun 2019 06:39:47 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c49sm856113eda.74.2019.06.21.06.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 06:39:46 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 779E810289C; Fri, 21 Jun 2019 16:39:48 +0300 (+03)
Date:   Fri, 21 Jun 2019 16:39:48 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 6/6] mm,thp: avoid writes to file with THP in pagecache
Message-ID: <20190621133948.2pvagzfwpwwk6rho@box>
References: <20190620205348.3980213-1-songliubraving@fb.com>
 <20190620205348.3980213-7-songliubraving@fb.com>
 <20190621130740.ehobvjjj7gjiazjw@box>
 <ABE906A7-719A-4AFF-8683-B413397C9865@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ABE906A7-719A-4AFF-8683-B413397C9865@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 01:10:54PM +0000, Song Liu wrote:
> 
> 
> > On Jun 21, 2019, at 6:07 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > 
> > On Thu, Jun 20, 2019 at 01:53:48PM -0700, Song Liu wrote:
> >> In previous patch, an application could put part of its text section in
> >> THP via madvise(). These THPs will be protected from writes when the
> >> application is still running (TXTBSY). However, after the application
> >> exits, the file is available for writes.
> >> 
> >> This patch avoids writes to file THP by dropping page cache for the file
> >> when the file is open for write. A new counter nr_thps is added to struct
> >> address_space. In do_last(), if the file is open for write and nr_thps
> >> is non-zero, we drop page cache for the whole file.
> >> 
> >> Signed-off-by: Song Liu <songliubraving@fb.com>
> >> ---
> >> fs/inode.c         |  3 +++
> >> fs/namei.c         | 22 +++++++++++++++++++++-
> >> include/linux/fs.h | 31 +++++++++++++++++++++++++++++++
> >> mm/filemap.c       |  1 +
> >> mm/khugepaged.c    |  4 +++-
> >> 5 files changed, 59 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/fs/inode.c b/fs/inode.c
> >> index df6542ec3b88..518113a4e219 100644
> >> --- a/fs/inode.c
> >> +++ b/fs/inode.c
> >> @@ -181,6 +181,9 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
> >> 	mapping->flags = 0;
> >> 	mapping->wb_err = 0;
> >> 	atomic_set(&mapping->i_mmap_writable, 0);
> >> +#ifdef CONFIG_READ_ONLY_THP_FOR_FS
> >> +	atomic_set(&mapping->nr_thps, 0);
> >> +#endif
> >> 	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
> >> 	mapping->private_data = NULL;
> >> 	mapping->writeback_index = 0;
> >> diff --git a/fs/namei.c b/fs/namei.c
> >> index 20831c2fbb34..de64f24b58e9 100644
> >> --- a/fs/namei.c
> >> +++ b/fs/namei.c
> >> @@ -3249,6 +3249,22 @@ static int lookup_open(struct nameidata *nd, struct path *path,
> >> 	return error;
> >> }
> >> 
> >> +/*
> >> + * The file is open for write, so it is not mmapped with VM_DENYWRITE. If
> >> + * it still has THP in page cache, drop the whole file from pagecache
> >> + * before processing writes. This helps us avoid handling write back of
> >> + * THP for now.
> >> + */
> >> +static inline void release_file_thp(struct file *file)
> >> +{
> >> +#ifdef CONFIG_READ_ONLY_THP_FOR_FS
> >> +	struct inode *inode = file_inode(file);
> >> +
> >> +	if (inode_is_open_for_write(inode) && filemap_nr_thps(inode->i_mapping))
> >> +		truncate_pagecache(inode, 0);
> >> +#endif
> >> +}
> >> +
> >> /*
> >>  * Handle the last step of open()
> >>  */
> >> @@ -3418,7 +3434,11 @@ static int do_last(struct nameidata *nd,
> >> 		goto out;
> >> opened:
> >> 	error = ima_file_check(file, op->acc_mode);
> >> -	if (!error && will_truncate)
> >> +	if (error)
> >> +		goto out;
> >> +
> >> +	release_file_thp(file);
> > 
> > What protects against re-fill the file with THP in parallel?
> 
> khugepaged would only process vma with VM_DENYWRITE. So once the
> file is open for write (i_write_count > 0), khugepage will not 
> collapse the pages. 

I have not look at the patch very closely. Do you only create THP by
khugepaged? Not in fault path?

-- 
 Kirill A. Shutemov
