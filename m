Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D647C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A9A217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfCSSqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:46:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfCSSqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:46:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CBF1A7F7B2;
        Tue, 19 Mar 2019 18:46:16 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-19.bos.redhat.com [10.18.17.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 233256248B;
        Tue, 19 Mar 2019 18:46:15 +0000 (UTC)
Subject: Re: [PATCH v12 3/3] ipc: Do cyclic id allocation with ipcmni_extend
 mode
To:     Manfred Spraul <manfred@colorfullife.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>
References: <1551379645-819-1-git-send-email-longman@redhat.com>
 <1551379645-819-4-git-send-email-longman@redhat.com>
 <e780cb59-ef1b-5f56-1e92-394dff5d4e32@colorfullife.com>
 <728b5e85-3129-9707-3802-306f66093c78@redhat.com>
 <28571549-344f-8423-a20d-aeccff0e838a@colorfullife.com>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <608e8d93-0ad2-8fd2-9edb-28fa820399c6@redhat.com>
Date:   Tue, 19 Mar 2019 14:46:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <28571549-344f-8423-a20d-aeccff0e838a@colorfullife.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 19 Mar 2019 18:46:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19/2019 02:18 PM, Manfred Spraul wrote:
> From 844c9d78cea41983a89c820bd5265ceded59883b Mon Sep 17 00:00:00 2001
> From: Manfred Spraul <manfred@colorfullife.com>
> Date: Sun, 17 Mar 2019 06:29:00 +0100
> Subject: [PATCH 2/2] ipc: Do cyclic id allocation for the ipc object.
>
> For ipcmni_extend mode, the sequence number space is only 7 bits. So
> the chance of id reuse is relatively high compared with the non-extended
> mode.
>
> To alleviate this id reuse problem, this patch enables cyclic allocation
> for the index to the radix tree (idx).
> The disadvantage is that this can cause a slight slow-down of the fast
> path, as the radix tree could be higher than necessary.
>
> To limit the radix tree height, I have chosen the following limits:
> - 1) The cycling is done over in_use*1.5.
> - 2) At least, the cycling is done over
>    "normal" ipcnmi mode: RADIX_TREE_MAP_SIZE elements
>    "ipcmni_extended": 4096 elements
>
> Result:
> - for normal mode:
> 	No change for <= 42 active ipc elements. With more than 42
> 	active ipc elements, a 2nd level would be added to the radix
> 	tree.
> 	Without cyclic allocation, a 2nd level would be added only with
> 	more than 63 active elements.
>
> - for extended mode:
> 	Cycling creates always at least a 2-level radix tree.
> 	With more than 2730 active objects, a 3rd level would be
> 	added, instead of > 4095 active objects until the 3rd level
> 	is added without cyclic allocation.
>
> For a 2-level radix tree compared to a 1-level radix tree, I have
> observed < 1% performance impact.
>
> Notes:
> 1) Normal "x=semget();y=semget();" is unaffected: Then the idx
>   is e.g. a and a+1, regardless if idr_alloc() or idr_alloc_cyclic()
>   is used.
>
> 2) The -1% happens in a microbenchmark after this situation:
> 	x=semget();
> 	for(i=0;i<4000;i++) {t=semget();semctl(t,0,IPC_RMID);}
> 	y=semget();
> 	Now perform semget calls on x and y that do not sleep.
>
> 3) The worst-case reuse cycle time is unfortunately unaffected:
>    If you have 2^24-1 ipc objects allocated, and get/remove the last
>    possible element in a loop, then the id is reused after 128
>    get/remove pairs.
>
> Performance check:
> A microbenchmark that performes no-op semop() randomly on two IDs,
> with only these two IDs allocated.
> The IDs were set using /proc/sys/kernel/sem_next_id.
> The test was run 5 times, averages are shown.
>
> 1 & 2: Base (6.22 seconds for 10.000.000 semops)
> 1 & 40: -0.2%
> 1 & 3348: - 0.8%
> 1 & 27348: - 1.6%
> 1 & 15777204: - 3.2%
>
> Or: ~12.6 cpu cycles per additional radix tree level.
> The cpu is an Intel I3-5010U. ~1300 cpu cycles/syscall is slower
> than what I remember (spectre impact?).
>
> V2 of the patch:
> - use "min" and "max"
> - use RADIX_TREE_MAP_SIZE * RADIX_TREE_MAP_SIZE instead of
> 	(2<<12).
>
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> ---
>  ipc/ipc_sysctl.c | 2 ++
>  ipc/util.c       | 7 ++++++-
>  ipc/util.h       | 3 +++
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index 73b7782eccf4..bfaae457810c 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -122,6 +122,7 @@ static int one = 1;
>  static int int_max = INT_MAX;
>  int ipc_mni = IPCMNI;
>  int ipc_mni_shift = IPCMNI_SHIFT;
> +int ipc_min_cycle = RADIX_TREE_MAP_SIZE;
>  
>  static struct ctl_table ipc_kern_table[] = {
>  	{
> @@ -252,6 +253,7 @@ static int __init ipc_mni_extend(char *str)
>  {
>  	ipc_mni = IPCMNI_EXTEND;
>  	ipc_mni_shift = IPCMNI_EXTEND_SHIFT;
> +	ipc_min_cycle = IPCMNI_EXTEND_MIN_CYCLE;
>  	pr_info("IPCMNI extended to %d.\n", ipc_mni);
>  	return 0;
>  }
> diff --git a/ipc/util.c b/ipc/util.c
> index 6e0fe3410423..1a492afb1d8b 100644
> --- a/ipc/util.c
> +++ b/ipc/util.c
> @@ -221,9 +221,14 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
>  	 */
>  
>  	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
> +		int max_idx;
> +
> +		max_idx = max(ids->in_use*3/2, ipc_min_cycle);
> +		max_idx = min(max_idx, ipc_mni);
>  
>  		/* allocate the idx, with a NULL struct kern_ipc_perm */
> -		idx = idr_alloc(&ids->ipcs_idr, NULL, 0, 0, GFP_NOWAIT);
> +		idx = idr_alloc_cyclic(&ids->ipcs_idr, NULL, 0, max_idx,
> +					GFP_NOWAIT);
>  
>  		if (idx >= 0) {
>  			/*
> diff --git a/ipc/util.h b/ipc/util.h
> index 8c834ed39012..d316399f0c32 100644
> --- a/ipc/util.h
> +++ b/ipc/util.h
> @@ -27,12 +27,14 @@
>   */
>  #define IPCMNI_SHIFT		15
>  #define IPCMNI_EXTEND_SHIFT	24
> +#define IPCMNI_EXTEND_MIN_CYCLE	(RADIX_TREE_MAP_SIZE * RADIX_TREE_MAP_SIZE)
>  #define IPCMNI			(1 << IPCMNI_SHIFT)
>  #define IPCMNI_EXTEND		(1 << IPCMNI_EXTEND_SHIFT)
>  
>  #ifdef CONFIG_SYSVIPC_SYSCTL
>  extern int ipc_mni;
>  extern int ipc_mni_shift;
> +extern int ipc_min_cycle;
>  
>  #define ipcmni_seq_shift()	ipc_mni_shift
>  #define IPCMNI_IDX_MASK		((1 << ipc_mni_shift) - 1)
> @@ -40,6 +42,7 @@ extern int ipc_mni_shift;
>  #else /* CONFIG_SYSVIPC_SYSCTL */
>  
>  #define ipc_mni			IPCMNI
> +#define ipc_min_cycle		RADIX_TREE_MAP_SIZE
>  #define ipcmni_seq_shift()	IPCMNI_SHIFT
>  #define IPCMNI_IDX_MASK		((1 << IPCMNI_SHIFT) - 1)
>  #endif /* CONFIG_SYSVIPC_SYSCTL */
> -- 2.17.2

Acked-by: Waiman Long <longman@redhat.com>

