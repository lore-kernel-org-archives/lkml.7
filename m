Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455F8C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053CB2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="syvP+KIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgAHPIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:08:34 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38693 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgAHPId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:08:33 -0500
Received: by mail-qk1-f196.google.com with SMTP id k6so2903438qki.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 07:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GGHROpn+qkJpfSwTxw1ZYvNqwfwl7HgPI9D+cQjSbeU=;
        b=syvP+KIrpBTv+bp/h1b1DxsO5GQQp071NKkh4Z6ewY2JMs68o96jx511l8T5TeX3XT
         mtEQqlwbWwntsvHd8MFqgSqfcq0S2IhQqEyzLqnP19BbL4y9PokSSUkWAcMRo6Z6Zgr2
         MdsCsJAHkb5v32J/cC9K2CHzdAX98pLRkrgIdxGRTAY6uIfCSn1TYZzAS+h5fXBDYMoA
         VVxlH5/ytj4Q6Z1DtzhBOMIbdGDoD8TRg2V+HDss+BUD7ve/FCGEV5WVJOEBS05sr752
         YlmXJcaHF01jwsY15HEbZtuJbJlEBWkkYGQSaSFAqLsR6O07KtbBHkJhu+2oNFz14C22
         jUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GGHROpn+qkJpfSwTxw1ZYvNqwfwl7HgPI9D+cQjSbeU=;
        b=BO66jsmWNiQhEJ9TmN8Bm8o4t34qp44wQRkiZM8HfQZPRrR6WMDx8vlv1FJjSpFL3p
         0RoDgZzMIJoLSYZ25kdMGdPxQcPB/ziuBnBiddoxtlJTpBmWZCyaUBpIWipjXunu7T1H
         ImehCGPMCEuS5QKkauaNiu4EWtnc+jltV3Mnnw6mfS7f94zwDzOuOugApDPPUqc8PdeV
         EytHGZE9Hxj2hByJEwX6iPwyOZi9OY+nTCzUG8GrUsz275Rwfl9vD0vxKb7rnb0+IfIX
         I41PDjbhJmnyeoqhm8xc/sHh1waL8Y9mU5mpwzk+mdMVF3fDXqe4AuGld6RXGLyWv3bu
         qneQ==
X-Gm-Message-State: APjAAAX8MnPQeT+NW1wk0lBoxOod18WC4pNQB36w1nIMqsF7pgLPHDEk
        d86ndaC6jO+2z6JUrOhFWyCxEg9yPZPdmQ==
X-Google-Smtp-Source: APXvYqwNvmAkcUnnB7ZC91xdOoNHhJPveb6Ipl9x0X6WQ9eulyTBUT2u/lk5hcpSSDDckjKtWnQ0aQ==
X-Received: by 2002:a37:308:: with SMTP id 8mr4602335qkd.98.1578496112003;
        Wed, 08 Jan 2020 07:08:32 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::f832])
        by smtp.gmail.com with ESMTPSA id g53sm1661347qtk.76.2020.01.08.07.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 07:08:30 -0800 (PST)
Subject: Re: [PATCH v4] btrfs: Use larger zlib buffer for s390 hardware
 compression
To:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
Cc:     Richard Purdie <rpurdie@rpsys.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200107143058.GU3929@twin.jikos.cz>
 <20200108105103.29028-1-zaslonko@linux.ibm.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <75a2d45c-fd7b-9542-403d-caea7d977add@toxicpanda.com>
Date:   Wed, 8 Jan 2020 10:08:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108105103.29028-1-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/20 5:51 AM, Mikhail Zaslonko wrote:
> In order to benefit from s390 zlib hardware compression support,
> increase the btrfs zlib workspace buffer size from 1 to 4 pages (if
> s390 zlib hardware support is enabled on the machine). This brings up
> to 60% better performance in hardware on s390 compared to the PAGE_SIZE
> buffer and much more compared to the software zlib processing in btrfs.
> In case of memory pressure, fall back to a single page buffer during
> workspace allocation.
> The data compressed with larger input buffers will still conform to zlib
> standard and thus can be decompressed also on a systems that uses only
> PAGE_SIZE buffer for btrfs zlib.
> 
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>


> ---
>   fs/btrfs/compression.c |   2 +-
>   fs/btrfs/zlib.c        | 135 ++++++++++++++++++++++++++++++-----------
>   2 files changed, 101 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index ee834ef7beb4..6bd0e75a822c 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -1285,7 +1285,7 @@ int btrfs_decompress_buf2page(const char *buf, unsigned long buf_start,
>   	/* copy bytes from the working buffer into the pages */
>   	while (working_bytes > 0) {
>   		bytes = min_t(unsigned long, bvec.bv_len,
> -				PAGE_SIZE - buf_offset);
> +				PAGE_SIZE - (buf_offset % PAGE_SIZE));
>   		bytes = min(bytes, working_bytes);
>   
>   		kaddr = kmap_atomic(bvec.bv_page);
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index a6c90a003c12..05615a1099db 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -20,9 +20,13 @@
>   #include <linux/refcount.h>
>   #include "compression.h"
>   
> +/* workspace buffer size for s390 zlib hardware support */
> +#define ZLIB_DFLTCC_BUF_SIZE    (4 * PAGE_SIZE)
> +
>   struct workspace {
>   	z_stream strm;
>   	char *buf;
> +	unsigned int buf_size;
>   	struct list_head list;
>   	int level;
>   };
> @@ -61,7 +65,21 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
>   			zlib_inflate_workspacesize());
>   	workspace->strm.workspace = kvmalloc(workspacesize, GFP_KERNEL);
>   	workspace->level = level;
> -	workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	workspace->buf = NULL;
> +	/*
> +	 * In case of s390 zlib hardware support, allocate lager workspace
> +	 * buffer. If allocator fails, fall back to a single page buffer.
> +	 */
> +	if (zlib_deflate_dfltcc_enabled()) {
> +		workspace->buf = kmalloc(ZLIB_DFLTCC_BUF_SIZE,
> +					 __GFP_NOMEMALLOC | __GFP_NORETRY |
> +					 __GFP_NOWARN | GFP_NOIO);
> +		workspace->buf_size = ZLIB_DFLTCC_BUF_SIZE;
> +	}
> +	if (!workspace->buf) {
> +		workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +		workspace->buf_size = PAGE_SIZE;
> +	}
>   	if (!workspace->strm.workspace || !workspace->buf)
>   		goto fail;
>   
> @@ -85,6 +103,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>   	struct page *in_page = NULL;
>   	struct page *out_page = NULL;
>   	unsigned long bytes_left;
> +	unsigned int in_buf_pages;
>   	unsigned long len = *total_out;
>   	unsigned long nr_dest_pages = *out_pages;
>   	const unsigned long max_out = nr_dest_pages * PAGE_SIZE;
> @@ -102,9 +121,6 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>   	workspace->strm.total_in = 0;
>   	workspace->strm.total_out = 0;
>   
> -	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
> -	data_in = kmap(in_page);
> -
>   	out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>   	if (out_page == NULL) {
>   		ret = -ENOMEM;
> @@ -114,12 +130,51 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>   	pages[0] = out_page;
>   	nr_pages = 1;
>   
> -	workspace->strm.next_in = data_in;
> +	workspace->strm.next_in = workspace->buf;
> +	workspace->strm.avail_in = 0;
>   	workspace->strm.next_out = cpage_out;
>   	workspace->strm.avail_out = PAGE_SIZE;
> -	workspace->strm.avail_in = min(len, PAGE_SIZE);
>   
>   	while (workspace->strm.total_in < len) {
> +		/*
> +		 * Get next input pages and copy the contents to
> +		 * the workspace buffer if required.
> +		 */
> +		if (workspace->strm.avail_in == 0) {
> +			bytes_left = len - workspace->strm.total_in;
> +			in_buf_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
> +					   workspace->buf_size / PAGE_SIZE);
> +			if (in_buf_pages > 1) {
> +				int i;
> +
> +				for (i = 0; i < in_buf_pages; i++) {
> +					if (in_page) {
> +						kunmap(in_page);
> +						put_page(in_page);
> +					}
> +					in_page = find_get_page(mapping,
> +								start >> PAGE_SHIFT);
> +					data_in = kmap(in_page);
> +					memcpy(workspace->buf + i * PAGE_SIZE,
> +					       data_in, PAGE_SIZE);
> +					start += PAGE_SIZE;
> +				}
> +				workspace->strm.next_in = workspace->buf;
> +			} else {
> +				if (in_page) {
> +					kunmap(in_page);
> +					put_page(in_page);
> +				}
> +				in_page = find_get_page(mapping,
> +							start >> PAGE_SHIFT);
> +				data_in = kmap(in_page);
> +				start += PAGE_SIZE;
> +				workspace->strm.next_in = data_in;
> +			}
> +			workspace->strm.avail_in = min(bytes_left,
> +						       (unsigned long) workspace->buf_size);
> +		}
> +
>   		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
>   		if (ret != Z_OK) {
>   			pr_debug("BTRFS: deflate in loop returned %d\n",
> @@ -161,33 +216,43 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>   		/* we're all done */
>   		if (workspace->strm.total_in >= len)
>   			break;
> -
> -		/* we've read in a full page, get a new one */
> -		if (workspace->strm.avail_in == 0) {
> -			if (workspace->strm.total_out > max_out)
> -				break;
> -
> -			bytes_left = len - workspace->strm.total_in;
> -			kunmap(in_page);
> -			put_page(in_page);
> -
> -			start += PAGE_SIZE;
> -			in_page = find_get_page(mapping,
> -						start >> PAGE_SHIFT);
> -			data_in = kmap(in_page);
> -			workspace->strm.avail_in = min(bytes_left,
> -							   PAGE_SIZE);
> -			workspace->strm.next_in = data_in;
> -		}
> +		if (workspace->strm.total_out > max_out)
> +			break;
>   	}
>   	workspace->strm.avail_in = 0;
> -	ret = zlib_deflate(&workspace->strm, Z_FINISH);
> -	zlib_deflateEnd(&workspace->strm);
> -
> -	if (ret != Z_STREAM_END) {
> -		ret = -EIO;
> -		goto out;
> +	/*
> +	 * Call deflate with Z_FINISH flush parameter providing more output
> +	 * space but no more input data, until it returns with Z_STREAM_END.
> +	 */
> +	while (ret != Z_STREAM_END) {
> +		ret = zlib_deflate(&workspace->strm, Z_FINISH);
> +		if (ret == Z_STREAM_END)
> +			break;
> +		if (ret != Z_OK && ret != Z_BUF_ERROR) {
> +			zlib_deflateEnd(&workspace->strm);
> +			ret = -EIO;
> +			goto out;
> +		} else if (workspace->strm.avail_out == 0) {
> +			/* get another page for the stream end */
> +			kunmap(out_page);
> +			if (nr_pages == nr_dest_pages) {
> +				out_page = NULL;
> +				ret = -E2BIG;
> +				goto out;
> +			}
> +			out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> +			if (out_page == NULL) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}

Do we need zlib_deflateEnd() for the above error cases?  Thanks,

Josef
