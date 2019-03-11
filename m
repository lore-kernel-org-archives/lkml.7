Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAD1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 03:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7B520657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 03:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="keehgDIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfCKDfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 23:35:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49904 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfCKDfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 23:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G0UV+6QfJ8G1Ev3WxxjVfXJfM2E9oz/BceVfJ2Bztyo=; b=keehgDIXv/bay5VQbyo0DH6Re
        2gqSiuaS2ZbNPKNHOxy0S1dq+CWO9BM3Ql7jCzgOBtErhQCOA9Gm10zg/Y1LnlFjThTEZWv4QVFi8
        aF+JoczA/30GAvPwvcnKxV9tszxAlRaZcm+mxtZME6NfxOMb86Tsgc3Pw0v+5l4NbWx/QQqrZz0/g
        k4JMO/7+HSF0lsOuWhTNNGPvUSh/PEojYjLfmnxtGcmiWI1pikJzLS/MxWNJrAg1hsw7QLJF4Hxs9
        wlkEJuDeaa8WausdaIubXdg70olEF1nBeCF5t0K2awJTXNm5Mptztkaf2WTuLdeomTvAQ5eHHtovk
        AmbcvY3Xw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h3BiY-00069z-Np; Mon, 11 Mar 2019 03:35:10 +0000
Date:   Sun, 10 Mar 2019 20:35:10 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH-next] ipc: Fix race condition in ipc_idr_alloc()
Message-ID: <20190311033510.GB19508@bombadil.infradead.org>
References: <20190311012536.21747-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311012536.21747-1-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 09:25:36PM -0400, Waiman Long wrote:
> @@ -221,15 +221,34 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
>  	 */
>  
>  	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
> +		/*
> +		 * It is possible that another thread of the same
> +		 * kern_ipc_perm may have called ipc_obtain_object_check()
> +		 * concurrently with a recently deleted IPC id (idx|seq).
> +		 * If idr_alloc() happens to allocate this deleted idx value,
> +		 * the other thread may incorrectly get a handle to the new
> +		 * IPC id.
> +		 *
> +		 * To prevent this race condition from happening, we will
> +		 * always store a new sequence number into the kern_ipc_perm
> +		 * object before calling idr_alloc(). If we find out that we
> +		 * don't need to change seq, we write back the right value.
> +		 */
> +		new->seq = ids->seq + 1;
> +		if (new->seq > IPCID_SEQ_MAX)
> +			new->seq = 0;
> +
>  		if (ipc_mni_extended)
>  			idx = idr_alloc_cyclic(&ids->ipcs_idr, new, 0, ipc_mni,
>  						GFP_NOWAIT);
>  		else
>  			idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
>  
> -		if ((idx <= ids->last_idx) && (++ids->seq > IPCID_SEQ_MAX))
> -			ids->seq = 0;
> -		new->seq = ids->seq;
> +		/* Make ids->seq and new->seq stay in sync */
> +		if (idx <= ids->last_idx)
> +			ids->seq = new->seq;
> +		else
> +			new->seq = ids->seq;

This can't possibly be right.  It's no better to occasionally find the
wrong ID than to find an uninitialised ID.

The normal pattern for solving this kind of problem is to idr_alloc()
a NULL pointer, initialise new->seq, then call idr_replace() to turn
that NULL pointer into the actual pointer you want.
