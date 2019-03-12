Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E911BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904FC214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmFxLs3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfCLNu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:50:59 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35500 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfCLNu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:50:59 -0400
Received: by mail-qk1-f194.google.com with SMTP id z13so1456602qki.2;
        Tue, 12 Mar 2019 06:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K2qgQ7sEFSYO1X587IGodc/KWRxiWDjVpDlAM1xtiSk=;
        b=lmFxLs3g+gXYt34EYN8jhSyFoeStX79QyS70HaS48ZWBJNA4e2SoWVdUQKN2/41JDo
         6Uu6h7qiasbCjUwrVS5hp2p7+VA5+/HZ/MvQq4h+Pa+jkNmTRdi6qiiMJ/sRxeK/5EPz
         gbPnySrQMbXLfcOFSXNzf6e7rFyRc1liY4kbJa2QLuUswodxOHD4kNzDObkhcMSvJQQg
         fe82M6Jg/Q2gSkX5y+oeZxXX9uK6ZLN0f9PXtMjJvomE02gt+L4VS1M4tkbvpAs1yQkh
         5EA8tSTVNB3xYKuAXSK5tyRzue2HZC0kExzKNe+7ER36+QcIOulV4tOXoCOv7xUOZFgE
         m6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K2qgQ7sEFSYO1X587IGodc/KWRxiWDjVpDlAM1xtiSk=;
        b=BNGXczwI4Ju7uukZm1ps0vd+OZpOpIi2OA/2V5WeCXlFyFS5U7tCrJKYJ2Y/B2Np4u
         7hga2qdN8quNDLCgmS4jis2d2tQZYteVp7rQJ1m+k2XxXjPbePGRNdeH9JN8V24QLRma
         5ZQeRmcgjioj/64DWDtzOSedssREK4Sw5Zh2DtTIv19ddbpV78GUUckjvd82I2T9uxx7
         Wt4fqJwW6wXXDJJBXsuOWtk4y/SMQfLKckDrwegtnQzk5StQpDo6G8ImfpMD8f0bTrtE
         soj/kGzT/tibGY/1qqXKlz9G1oOG6nMSTqa9AO256nWraJuuDc6O3C6jPzCJwNC7PWf8
         vfRg==
X-Gm-Message-State: APjAAAWqFmjBQkC/RVS6pbcACF6BIi5BcMfUqExH5oZCupRGoWa696T7
        Lx9Q321Ms/kRXaQUrQqPbzo=
X-Google-Smtp-Source: APXvYqxK+YLnjfXETTmH/kwdPm5TDEWVCiPeZZFVecXEm3qFgfmH9igZvQPDFPYN5kUDfhGUIy8XPg==
X-Received: by 2002:a37:6312:: with SMTP id x18mr13157267qkb.150.1552398657472;
        Tue, 12 Mar 2019 06:50:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net (177-59-123-113.3g.claro.net.br. [177.59.123.113])
        by smtp.gmail.com with ESMTPSA id z140sm5011159qka.81.2019.03.12.06.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 06:50:56 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5FE514039C; Tue, 12 Mar 2019 10:50:52 -0300 (-03)
Date:   Tue, 12 Mar 2019 10:50:52 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org, sdf@fomichev.me
Subject: Re: [PATCH v9 perf,bpf 02/15] bpf: libbpf: introduce
 bpf_program__get_prog_info_linear()
Message-ID: <20190312135052.GC4939@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312053051.2690567-3-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 10:30:38PM -0700, Song Liu escreveu:
> Currently, bpf_prog_info includes 9 arrays. The user has the option to
> fetch any combination of these arrays. However, this requires a lot of
> handling of these arrays. This work becomes more tricky when we need to
> store bpf_prog_info to a file, because these arrays are allocated
> independently.
> 
> This patch introduces struct bpf_prog_info_linear, which stores arrays
> of bpf_prog_info in continues memory. Helper functions are introduced
> to unify the work to get different information of bpf_prog_info.
> Specifically, bpf_program__get_prog_info_linear() allows the user to
> select which arrays to fetch, and handles details for the user.
> 
> Plesae see the comments before enum bpf_prog_info_array for more details
> and examples.
> 
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/lib/bpf/libbpf.c   | 251 +++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  63 ++++++++++
>  tools/lib/bpf/libbpf.map |   3 +
>  3 files changed, 317 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index d5b830d60601..98ec9a8cd7af 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -112,6 +112,11 @@ void libbpf_print(enum libbpf_print_level level, const char *format, ...)
>  # define LIBBPF_ELF_C_READ_MMAP ELF_C_READ
>  #endif
>  
> +static inline __u64 ptr_to_u64(const void *ptr)
> +{
> +	return (__u64) (unsigned long) ptr;
> +}
> +
>  struct bpf_capabilities {
>  	/* v4.14: kernel support for program & map names. */
>  	__u32 name:1;
> @@ -2999,3 +3004,249 @@ bpf_perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
>  	ring_buffer_write_tail(header, data_tail);
>  	return ret;
>  }
> +
> +struct bpf_prog_info_array_desc {
> +	int	array_offset;	/* e.g. offset of jited_prog_insns */
> +	int	count_offset;	/* e.g. offset of jited_prog_len */
> +	int	size_offset;	/* > 0: offset of rec size,
> +				 * < 0: fix size of -size_offset
> +				 */
> +};
> +
> +static struct bpf_prog_info_array_desc bpf_prog_info_array_desc[] = {
> +	[BPF_PROG_INFO_JITED_INSNS] = {
> +		offsetof(struct bpf_prog_info, jited_prog_insns),
> +		offsetof(struct bpf_prog_info, jited_prog_len),
> +		-1,
> +	},
> +	[BPF_PROG_INFO_XLATED_INSNS] = {
> +		offsetof(struct bpf_prog_info, xlated_prog_insns),
> +		offsetof(struct bpf_prog_info, xlated_prog_len),
> +		-1,
> +	},

Can be done on top, but this is too much boilerplate, later we can use
something like:

@define BPF_PROG_INFO_ENTRY(idx, array, count, offset) \
	[BPF_PROG_INFO ## index_name] = { \
		offsetof(struct bpf_prog_info, array), \ 
		offsetof(struct bpf_prog_info, count), \ 
		(int)offset \
	}

And then have a more compact

	static struct bpf_prog_info_array_desc bpf_prog_info_array_desc[] = {
		BPF_PROG_INFO_ENTRY(JITED_INSNS, jited_prog_insns, jided_prog_len, -1 );
		BPF_PROG_INFO_ENTRY(MAP_IDS, map_ids, nr_map_ids, -sizeof(__u32));

	etc.

Anyway, processing it as-is for now.


> +	[BPF_PROG_INFO_MAP_IDS] = {
> +		offsetof(struct bpf_prog_info, map_ids),
> +		offsetof(struct bpf_prog_info, nr_map_ids),
> +		-(int)sizeof(__u32),
> +	},
> +	[BPF_PROG_INFO_JITED_KSYMS] = {
> +		offsetof(struct bpf_prog_info, jited_ksyms),
> +		offsetof(struct bpf_prog_info, nr_jited_ksyms),
> +		-(int)sizeof(__u64),
> +	},
> +	[BPF_PROG_INFO_JITED_FUNC_LENS] = {
> +		offsetof(struct bpf_prog_info, jited_func_lens),
> +		offsetof(struct bpf_prog_info, nr_jited_func_lens),
> +		-(int)sizeof(__u32),
> +	},
> +	[BPF_PROG_INFO_FUNC_INFO] = {
> +		offsetof(struct bpf_prog_info, func_info),
> +		offsetof(struct bpf_prog_info, nr_func_info),
> +		offsetof(struct bpf_prog_info, func_info_rec_size),
> +	},
> +	[BPF_PROG_INFO_LINE_INFO] = {
> +		offsetof(struct bpf_prog_info, line_info),
> +		offsetof(struct bpf_prog_info, nr_line_info),
> +		offsetof(struct bpf_prog_info, line_info_rec_size),
> +	},
> +	[BPF_PROG_INFO_JITED_LINE_INFO] = {
> +		offsetof(struct bpf_prog_info, jited_line_info),
> +		offsetof(struct bpf_prog_info, nr_jited_line_info),
> +		offsetof(struct bpf_prog_info, jited_line_info_rec_size),
> +	},
> +	[BPF_PROG_INFO_PROG_TAGS] = {
> +		offsetof(struct bpf_prog_info, prog_tags),
> +		offsetof(struct bpf_prog_info, nr_prog_tags),
> +		-(int)sizeof(__u8) * BPF_TAG_SIZE,
> +	},
> +
> +};
> +
> +static __u32 bpf_prog_info_read_offset_u32(struct bpf_prog_info *info, int offset)
> +{
> +	__u32 *array = (__u32 *)info;
> +
> +	if (offset >= 0)
> +		return array[offset / sizeof(__u32)];
> +	return -(int)offset;
> +}
> +
> +static __u64 bpf_prog_info_read_offset_u64(struct bpf_prog_info *info, int offset)
> +{
> +	__u64 *array = (__u64 *)info;
> +
> +	if (offset >= 0)
> +		return array[offset / sizeof(__u64)];
> +	return -(int)offset;
> +}
> +
> +static void bpf_prog_info_set_offset_u32(struct bpf_prog_info *info, int offset,
> +					 __u32 val)
> +{
> +	__u32 *array = (__u32 *)info;
> +
> +	if (offset >= 0)
> +		array[offset / sizeof(__u32)] = val;
> +}
> +
> +static void bpf_prog_info_set_offset_u64(struct bpf_prog_info *info, int offset,
> +					 __u64 val)
> +{
> +	__u64 *array = (__u64 *)info;
> +
> +	if (offset >= 0)
> +		array[offset / sizeof(__u64)] = val;
> +}
> +
> +struct bpf_prog_info_linear *
> +bpf_program__get_prog_info_linear(int fd, __u64 arrays)
> +{
> +	struct bpf_prog_info_linear *info_linear;
> +	struct bpf_prog_info info = {};
> +	__u32 info_len = sizeof(info);
> +	__u32 data_len = 0;
> +	int i, err;
> +	void *ptr;
> +
> +	if (arrays >> BPF_PROG_INFO_LAST_ARRAY)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* step 1: get array dimensions */
> +	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
> +	if (err) {
> +		pr_debug("can't get prog info: %s", strerror(errno));
> +		return ERR_PTR(-EFAULT);
> +	}
> +
> +	/* step 2: calculate total size of all arrays */
> +	for (i = BPF_PROG_INFO_FIRST_ARRAY; i < BPF_PROG_INFO_LAST_ARRAY; ++i) {
> +		bool include_array = (arrays & (1UL << i)) > 0;
> +		struct bpf_prog_info_array_desc *desc;
> +		__u32 count, size;
> +
> +		desc = bpf_prog_info_array_desc + i;
> +
> +		/* kernel is too old to support this field */
> +		if (info_len < desc->array_offset + sizeof(__u32) ||
> +		    info_len < desc->count_offset + sizeof(__u32) ||
> +		    (desc->size_offset > 0 && info_len < desc->size_offset))
> +			include_array = false;
> +
> +		if (!include_array) {
> +			arrays &= ~(1UL << i);	/* clear the bit */
> +			continue;
> +		}
> +
> +		count = bpf_prog_info_read_offset_u32(&info, desc->count_offset);
> +		size = bpf_prog_info_read_offset_u32(&info, desc->size_offset);
> +
> +		data_len += count * size;
> +	}
> +
> +	/* step 3: allocate continuous memory */
> +	data_len = roundup(data_len, sizeof(__u64));
> +	info_linear = malloc(sizeof(struct bpf_prog_info_linear) + data_len);
> +	if (!info_linear)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* step 4: fill data to info_linear->info */
> +	info_linear->arrays = arrays;
> +	memset(&info_linear->info, 0, sizeof(info));
> +	ptr = info_linear->data;
> +
> +	for (i = BPF_PROG_INFO_FIRST_ARRAY; i < BPF_PROG_INFO_LAST_ARRAY; ++i) {
> +		struct bpf_prog_info_array_desc *desc;
> +		__u32 count, size;
> +
> +		if ((arrays & (1UL << i)) == 0)
> +			continue;
> +
> +		desc = bpf_prog_info_array_desc + i;
> +		count = bpf_prog_info_read_offset_u32(&info, desc->count_offset);
> +		size = bpf_prog_info_read_offset_u32(&info, desc->size_offset);
> +		bpf_prog_info_set_offset_u32(&info_linear->info,
> +					     desc->count_offset, count);
> +		bpf_prog_info_set_offset_u32(&info_linear->info,
> +					     desc->size_offset, size);
> +		bpf_prog_info_set_offset_u64(&info_linear->info,
> +					     desc->array_offset,
> +					     ptr_to_u64(ptr));
> +		ptr += count * size;
> +	}
> +
> +	/* step 5: call syscall again to get required arrays */
> +	err = bpf_obj_get_info_by_fd(fd, &info_linear->info, &info_len);
> +	if (err) {
> +		pr_debug("can't get prog info: %s", strerror(errno));
> +		free(info_linear);
> +		return ERR_PTR(-EFAULT);
> +	}
> +
> +	/* step 6: verify the data */
> +	for (i = BPF_PROG_INFO_FIRST_ARRAY; i < BPF_PROG_INFO_LAST_ARRAY; ++i) {
> +		struct bpf_prog_info_array_desc *desc;
> +		__u32 v1, v2;
> +
> +		if ((arrays & (1UL << i)) == 0)
> +			continue;
> +
> +		desc = bpf_prog_info_array_desc + i;
> +		v1 = bpf_prog_info_read_offset_u32(&info, desc->count_offset);
> +		v2 = bpf_prog_info_read_offset_u32(&info_linear->info,
> +						   desc->count_offset);
> +		if (v1 != v2)
> +			pr_warning("%s: mismatch in element count\n", __func__);
> +
> +		v1 = bpf_prog_info_read_offset_u32(&info, desc->size_offset);
> +		v2 = bpf_prog_info_read_offset_u32(&info_linear->info,
> +						   desc->size_offset);
> +		if (v1 != v2)
> +			pr_warning("%s: mismatch in rec size\n", __func__);
> +	}
> +
> +	/* step 7: update info_len and data_len */
> +	info_linear->info_len = sizeof(struct bpf_prog_info);
> +	info_linear->data_len = data_len;
> +
> +	return info_linear;
> +}
> +
> +void bpf_program__bpil_addr_to_offs(struct bpf_prog_info_linear *info_linear)
> +{
> +	int i;
> +
> +	for (i = BPF_PROG_INFO_FIRST_ARRAY; i < BPF_PROG_INFO_LAST_ARRAY; ++i) {
> +		struct bpf_prog_info_array_desc *desc;
> +		__u64 addr, offs;
> +
> +		if ((info_linear->arrays & (1UL << i)) == 0)
> +			continue;
> +
> +		desc = bpf_prog_info_array_desc + i;
> +		addr = bpf_prog_info_read_offset_u64(&info_linear->info,
> +						     desc->array_offset);
> +		offs = addr - ptr_to_u64(info_linear->data);
> +		bpf_prog_info_set_offset_u64(&info_linear->info,
> +					     desc->array_offset, offs);
> +	}
> +}
> +
> +void bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear)
> +{
> +	int i;
> +
> +	for (i = BPF_PROG_INFO_FIRST_ARRAY; i < BPF_PROG_INFO_LAST_ARRAY; ++i) {
> +		struct bpf_prog_info_array_desc *desc;
> +		__u64 addr, offs;
> +
> +		if ((info_linear->arrays & (1UL << i)) == 0)
> +			continue;
> +
> +		desc = bpf_prog_info_array_desc + i;
> +		offs = bpf_prog_info_read_offset_u64(&info_linear->info,
> +						     desc->array_offset);
> +		addr = offs + ptr_to_u64(info_linear->data);
> +		bpf_prog_info_set_offset_u64(&info_linear->info,
> +					     desc->array_offset, addr);
> +	}
> +}
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b4652aa1a58a..c7645a5e1ac0 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -377,6 +377,69 @@ LIBBPF_API bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex);
>  LIBBPF_API bool bpf_probe_helper(enum bpf_func_id id,
>  				 enum bpf_prog_type prog_type, __u32 ifindex);
>  
> +/*
> + * Get bpf_prog_info in continuous memory
> + *
> + * struct bpf_prog_info has multiple arrays. The user has option to choose
> + * arrays to fetch from kernel. The following APIs provide uniform way to
> + * fetch these data. All arrays in bpf_prog_info are stored in singile
> + * continuous memory region. This makes it easy to store the info in a
> + * file.
> + *
> + * Before writing bpf_prog_info_linear to files, it is necessary to
> + * translate pointers bpf_prog_info to offsets. Helper functions
> + * bpf_program__bpil_addr_to_offs() and bpf_program__bpil_offs_to_addr()
> + * are introduced to switch between pointers and offsets.
> + *
> + * Examples:
> + *   # To fetch map_ids and prog_tags:
> + *   __u64 arrays = (1UL << BPF_PROG_INFO_MAP_IDS) |
> + *           (1UL << BPF_PROG_INFO_PROG_TAGS);
> + *   struct bpf_prog_info_linear *info_linear =
> + *           bpf_program__get_prog_info_linear(fd, arrays);
> + *
> + *   # To save data in file
> + *   bpf_program__bpil_addr_to_offs(info_linear);
> + *   write(f, info_linear, sizeof(*info_linear) + info_linear->data_len);
> + *
> + *   # To read data from file
> + *   read(f, info_linear, <proper_size>);
> + *   bpf_program__bpil_offs_to_addr(info_linear);
> + */
> +enum bpf_prog_info_array {
> +	BPF_PROG_INFO_FIRST_ARRAY = 0,
> +	BPF_PROG_INFO_JITED_INSNS = 0,
> +	BPF_PROG_INFO_XLATED_INSNS,
> +	BPF_PROG_INFO_MAP_IDS,
> +	BPF_PROG_INFO_JITED_KSYMS,
> +	BPF_PROG_INFO_JITED_FUNC_LENS,
> +	BPF_PROG_INFO_FUNC_INFO,
> +	BPF_PROG_INFO_LINE_INFO,
> +	BPF_PROG_INFO_JITED_LINE_INFO,
> +	BPF_PROG_INFO_PROG_TAGS,
> +	BPF_PROG_INFO_LAST_ARRAY,
> +};
> +
> +struct bpf_prog_info_linear {
> +	/* size of struct bpf_prog_info, when the tool is compiled */
> +	__u32			info_len;
> +	/* total bytes allocated for data, round up to 8 bytes */
> +	__u32			data_len;
> +	/* which arrays are included in data */
> +	__u64			arrays;
> +	struct bpf_prog_info	info;
> +	__u8			data[];
> +};
> +
> +LIBBPF_API struct bpf_prog_info_linear *
> +bpf_program__get_prog_info_linear(int fd, __u64 arrays);
> +
> +LIBBPF_API void
> +bpf_program__bpil_addr_to_offs(struct bpf_prog_info_linear *info_linear);
> +
> +LIBBPF_API void
> +bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear);
> +
>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 778a26702a70..f3ce50500cf2 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -153,4 +153,7 @@ LIBBPF_0.0.2 {
>  		xsk_socket__delete;
>  		xsk_umem__fd;
>  		xsk_socket__fd;
> +		bpf_program__get_prog_info_linear;
> +		bpf_program__bpil_addr_to_offs;
> +		bpf_program__bpil_offs_to_addr;
>  } LIBBPF_0.0.1;
> -- 
> 2.17.1

-- 

- Arnaldo
