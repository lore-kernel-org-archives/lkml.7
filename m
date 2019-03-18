Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225F1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E337020989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfCRTAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:00:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfCRTAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:00:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20C7A30821FF;
        Mon, 18 Mar 2019 19:00:15 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-19.bos.redhat.com [10.18.17.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15DAE19C67;
        Mon, 18 Mar 2019 19:00:13 +0000 (UTC)
Subject: Re: [PATCH v12 2/3] ipc: Conserve sequence numbers in ipcmni_extend
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
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        1vier1@web.de
References: <1551379645-819-1-git-send-email-longman@redhat.com>
 <1551379645-819-3-git-send-email-longman@redhat.com>
 <398a8bcb-7568-0a5b-c6cb-77420de445b9@colorfullife.com>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <7dfac353-da52-8a11-d145-7704c777daeb@redhat.com>
Date:   Mon, 18 Mar 2019 15:00:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <398a8bcb-7568-0a5b-c6cb-77420de445b9@colorfullife.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 18 Mar 2019 19:00:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16/2019 02:52 PM, Manfred Spraul wrote:
> From edee319b2d5c96af14b8b8899e5dde324861e4e4 Mon Sep 17 00:00:00 2001
> From: Manfred Spraul <manfred@colorfullife.com>
> Date: Sat, 16 Mar 2019 10:18:53 +0100
> Subject: [PATCH] ipc: Conserve sequence numbers in ipcmni_extend mode
>
> Rewrite, based on the patch from Waiman Long:
>
> The mixing in of a sequence number into the IPC IDs is probably to
> avoid ID reuse in userspace as much as possible. With ipcmni_extend
> mode, the number of usable sequence numbers is greatly reduced leading
> to higher chance of ID reuse.
>
> To address this issue, we need to conserve the sequence number space
> as much as possible. Right now, the sequence number is incremented for
> every new ID created. In reality, we only need to increment the sequence
> number when new allocated ID is not greater than the last one allocated.
> It is in such case that the new ID may collide with an existing one.
> This is being done irrespective of the ipcmni mode.
>
> In order to avoid any races, the index is first allocated and
> then the pointer is replaced.
>
> Changes compared to the initial patch:
> - Handle failures from idr_alloc().
> - Avoid that concurrent operations can see the wrong
>   sequence number.
> (This is achieved by using idr_replace()).
> - IPCMNI_SEQ_SHIFT is not a constant, thus renamed to
> 	ipcmni_seq_shift().
> - IPCMNI_SEQ_MAX is not a constant, thus renamed to
> 	ipcmni_seq_max().
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Original-patch-from: Waiman Long <longman@redhat.com>
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> ---
>  include/linux/ipc_namespace.h |  1 +
>  ipc/util.c                    | 35 ++++++++++++++++++++++++++++++-----
>  ipc/util.h                    |  8 ++++----
>  3 files changed, 35 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
> index 6ab8c1bada3f..c309f43bde45 100644
> --- a/include/linux/ipc_namespace.h
> +++ b/include/linux/ipc_namespace.h
> @@ -19,6 +19,7 @@ struct ipc_ids {
>  	struct rw_semaphore rwsem;
>  	struct idr ipcs_idr;
>  	int max_idx;
> +	int last_idx;	/* For wrap around detection */
>  #ifdef CONFIG_CHECKPOINT_RESTORE
>  	int next_id;
>  #endif
> diff --git a/ipc/util.c b/ipc/util.c
> index 07ae117ccdc0..6e0fe3410423 100644
> --- a/ipc/util.c
> +++ b/ipc/util.c
> @@ -120,6 +120,7 @@ void ipc_init_ids(struct ipc_ids *ids)
>  	rhashtable_init(&ids->key_ht, &ipc_kht_params);
>  	idr_init(&ids->ipcs_idr);
>  	ids->max_idx = -1;
> +	ids->last_idx = -1;
>  #ifdef CONFIG_CHECKPOINT_RESTORE
>  	ids->next_id = -1;
>  #endif
> @@ -193,6 +194,10 @@ static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
>   *
>   * The caller must own kern_ipc_perm.lock.of the new object.
>   * On error, the function returns a (negative) error code.
> + *
> + * To conserve sequence number space, especially with extended ipc_mni,
> + * the sequence number is incremented only when the returned ID is less than
> + * the last one.
>   */
>  static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
>  {
> @@ -216,17 +221,37 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
>  	 */
>  
>  	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
> -		new->seq = ids->seq++;
> -		if (ids->seq > IPCID_SEQ_MAX)
> -			ids->seq = 0;
> -		idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
> +
> +		/* allocate the idx, with a NULL struct kern_ipc_perm */
> +		idx = idr_alloc(&ids->ipcs_idr, NULL, 0, 0, GFP_NOWAIT);
> +
> +		if (idx >= 0) {
> +			/*
> +			 * idx got allocated successfully.
> +			 * Now calculate the sequence number and set the
> +			 * pointer for real.
> +			 */
> +			if (idx <= ids->last_idx) {
> +				ids->seq++;
> +				if (ids->seq >= ipcid_seq_max())
> +					ids->seq = 0;
> +			}
> +			ids->last_idx = idx;
> +
> +			new->seq = ids->seq;
> +			/* no need for smp_wmb(), this is done
> +			 * inside idr_replace, as part of
> +			 * rcu_assign_pointer
> +			 */
> +			idr_replace(&ids->ipcs_idr, new, idx);
> +		}
>  	} else {
>  		new->seq = ipcid_to_seqx(next_id);
>  		idx = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
>  				0, GFP_NOWAIT);
>  	}
>  	if (idx >= 0)
> -		new->id = (new->seq << IPCMNI_SEQ_SHIFT) + idx;
> +		new->id = (new->seq << ipcmni_seq_shift()) + idx;
>  	return idx;
>  }
>  
> diff --git a/ipc/util.h b/ipc/util.h
> index 9746886757de..8c834ed39012 100644
> --- a/ipc/util.h
> +++ b/ipc/util.h
> @@ -34,13 +34,13 @@
>  extern int ipc_mni;
>  extern int ipc_mni_shift;
>  
> -#define IPCMNI_SEQ_SHIFT	ipc_mni_shift
> +#define ipcmni_seq_shift()	ipc_mni_shift
>  #define IPCMNI_IDX_MASK		((1 << ipc_mni_shift) - 1)
>  
>  #else /* CONFIG_SYSVIPC_SYSCTL */
>  
>  #define ipc_mni			IPCMNI
> -#define IPCMNI_SEQ_SHIFT	IPCMNI_SHIFT
> +#define ipcmni_seq_shift()	IPCMNI_SHIFT
>  #define IPCMNI_IDX_MASK		((1 << IPCMNI_SHIFT) - 1)
>  #endif /* CONFIG_SYSVIPC_SYSCTL */
>  
> @@ -123,8 +123,8 @@ struct pid_namespace *ipc_seq_pid_ns(struct seq_file *);
>  #define IPC_SHM_IDS	2
>  
>  #define ipcid_to_idx(id)  ((id) & IPCMNI_IDX_MASK)
> -#define ipcid_to_seqx(id) ((id) >> IPCMNI_SEQ_SHIFT)
> -#define IPCID_SEQ_MAX	  (INT_MAX >> IPCMNI_SEQ_SHIFT)
> +#define ipcid_to_seqx(id) ((id) >> ipcmni_seq_shift())
> +#define ipcid_seq_max()	  (INT_MAX >> ipcmni_seq_shift())
>  
>  /* must be called with ids->rwsem acquired for writing */
>  int ipc_addid(struct ipc_ids *, struct kern_ipc_perm *, int);

Acked-by: Waiman Long <longman@redhat.com>

I am fine with this patch replacing mine.

Cheers,
Longman

