Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC780C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D7A2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfCKOOb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:14:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50893 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfCKOOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:14:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16A9A85376;
        Mon, 11 Mar 2019 14:14:30 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-221.bos.redhat.com [10.18.17.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8135A60C9D;
        Mon, 11 Mar 2019 14:14:28 +0000 (UTC)
Subject: Re: [PATCH-next] ipc: Fix race condition in ipc_idr_alloc()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>
References: <20190311012536.21747-1-longman@redhat.com>
 <20190311033510.GB19508@bombadil.infradead.org>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <63054a6a-d0ea-c112-8422-0424e5dee704@redhat.com>
Date:   Mon, 11 Mar 2019 10:14:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190311033510.GB19508@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 11 Mar 2019 14:14:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2019 11:35 PM, Matthew Wilcox wrote:
> On Sun, Mar 10, 2019 at 09:25:36PM -0400, Waiman Long wrote:
>> @@ -221,15 +221,34 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
>>  	 */
>>  
>>  	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
>> +		/*
>> +		 * It is possible that another thread of the same
>> +		 * kern_ipc_perm may have called ipc_obtain_object_check()
>> +		 * concurrently with a recently deleted IPC id (idx|seq).
>> +		 * If idr_alloc() happens to allocate this deleted idx value,
>> +		 * the other thread may incorrectly get a handle to the new
>> +		 * IPC id.
>> +		 *
>> +		 * To prevent this race condition from happening, we will
>> +		 * always store a new sequence number into the kern_ipc_perm
>> +		 * object before calling idr_alloc(). If we find out that we
>> +		 * don't need to change seq, we write back the right value.
>> +		 */
>> +		new->seq = ids->seq + 1;
>> +		if (new->seq > IPCID_SEQ_MAX)
>> +			new->seq = 0;
>> +
>>  		if (ipc_mni_extended)
>>  			idx = idr_alloc_cyclic(&ids->ipcs_idr, new, 0, ipc_mni,
>>  						GFP_NOWAIT);
>>  		else
>>  			idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
>>  
>> -		if ((idx <= ids->last_idx) && (++ids->seq > IPCID_SEQ_MAX))
>> -			ids->seq = 0;
>> -		new->seq = ids->seq;
>> +		/* Make ids->seq and new->seq stay in sync */
>> +		if (idx <= ids->last_idx)
>> +			ids->seq = new->seq;
>> +		else
>> +			new->seq = ids->seq;
> This can't possibly be right.  It's no better to occasionally find the
> wrong ID than to find an uninitialised ID.

The kern_ipc_perm object isn't uninitialized. The seq value, however, is
tentative rather than final.

> The normal pattern for solving this kind of problem is to idr_alloc()
> a NULL pointer, initialise new->seq, then call idr_replace() to turn
> that NULL pointer into the actual pointer you want.

That will work too, I think. My only concern is that it will slow down
ipc_idr_alloc() process as each idr_*() call can be pretty expensive.
Even though it is in the slow path, we still don't want to introduce
unnecessary overhead.

Actually, it is no different from what ipc_idr_alloc() used to be. The
seq value in kern_ipc_perm was updated every time ipc_idr_alloc() was
called. So older IPC id would fail ipc_checkid(). This patch guarantees
that it will happen again. The new IPC id won't be returned until the
kern_ipc_perm object is correctly set. So there is no danger of new IPC
id failing the test. I will update my patch to better discuss the
rationale for this change.

Cheers,
Longman


