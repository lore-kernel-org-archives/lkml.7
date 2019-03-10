Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC782C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 12:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7185F2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 12:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="pjAH8NZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfCJMrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 08:47:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52808 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfCJMrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 08:47:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id f65so1762633wma.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hw3h5Tc1oMss2Vxz5sBoGj4c62f4Jidpji5KAl6heTw=;
        b=pjAH8NZEblZvqXqMQ09JdmT99EPf57uKtGNbnuasyIHEyIm7eH0pvC+V7uw9kwX8I0
         Kd9MZlfGvK1vdKSocJSWn/1OnGe0dDNTvXFLkGNDi87N2toCYNRw2W/iQAnMTpVXf55l
         PBsGW1jJkIq+xRemX+6YX5jzOzj5yiKtzFaUq/R02Ggxry1TEJFye3/wmSZF5Rm0XC7t
         C3sYmVB5aCWu7Zka5j1V/yli4mAcqASj/Y3j9+hFZTesLORYLg5qqPVVsUK+tz2qZ/1i
         UrIgZoVs9sKsw+0DoTNmIBZGd6ts1xjxwJJOTS5/pNHrjFX/+RyN65U2vO+SMmZ2iKV1
         HQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hw3h5Tc1oMss2Vxz5sBoGj4c62f4Jidpji5KAl6heTw=;
        b=se4FDvqOJsZFyXgSdxIdkqQ7nYdbkhvnpvxm5vupccuxYouZC6xz6iKvwUOlYNLrhj
         Et3nSWZlTqr9nhtAU6AsDqolEMJIZuFP3VR4NveVdtWcpfNm2NEYdwV3iVxtqqpSyawA
         FQ8IkYXZJ4PlGZvhBCek62NCnhO9F3MG0LIEufHIgyugQGM3N4WaXVC7CfXqMQM95GTO
         /2fOpXYnheaxHu6s/IjzwgvtrUWN5du6sE5VstTDQBqAh8xaWbSKh3WXg7te7O3pjE4N
         4+nLrEfAt1ovQEPMvUkeu+mk8jAFvbefEesGDkyxKlFE9URhaMSTzNY3eaOuhx+Csvsz
         gLUw==
X-Gm-Message-State: APjAAAWMPyopfMdhdVUT/VlAs74opiFbDPU0Zv+vXwR/+RFBabr8sDDd
        ntnPC7/PgqaViK+7p3XVbrTsgA==
X-Google-Smtp-Source: APXvYqzmMAbG6w6C0WrpcwHr2eY7o6SmzGOmr0Iuo39wYwpFb1nFXGST3yLxSvAFNuaHalU2Iasm+Q==
X-Received: by 2002:a1c:6684:: with SMTP id a126mr13674168wmc.47.1552222033911;
        Sun, 10 Mar 2019 05:47:13 -0700 (PDT)
Received: from linux.fritz.box (p200300D993E5320070FBF3E9437DCDE3.dip0.t-ipconnect.de. [2003:d9:93e5:3200:70fb:f3e9:437d:cde3])
        by smtp.googlemail.com with ESMTPSA id r70sm8677616wme.46.2019.03.10.05.47.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 05:47:12 -0700 (PDT)
Subject: Re: [PATCH v11 2/3] ipc: Conserve sequence numbers in ipcmni_extend
 mode
To:     Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>
References: <1541794292-19425-1-git-send-email-longman@redhat.com>
 <1541794292-19425-3-git-send-email-longman@redhat.com>
 <20181110074125.GB21824@bombadil.infradead.org>
 <c589992a-0c7e-ecf2-9544-3c82dfb96f9f@colorfullife.com>
 <0dd6a66b-4c7f-5224-bcf9-646b3a012a10@redhat.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <25499e14-1731-07a3-c4ec-3a064f6368ee@colorfullife.com>
Date:   Sun, 10 Mar 2019 13:47:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <0dd6a66b-4c7f-5224-bcf9-646b3a012a10@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/19 9:30 PM, Waiman Long wrote:
> On 11/20/2018 02:41 PM, Manfred Spraul wrote:
>>  From 6bbade73d21884258a995698f21ad3128df8e98a Mon Sep 17 00:00:00 2001
>> From: Manfred Spraul<manfred@colorfullife.com>
>> Date: Sat, 29 Sep 2018 15:43:28 +0200
>> Subject: [PATCH 2/2] ipc/util.c: use idr_alloc_cyclic() for ipc allocations
>>
>> A bit related to the patch that increases IPC_MNI, and
>> partially based on the mail fromwilly@infradead.org:
>>
>> (User space) id reuse create the risk of data corruption:
>>
>> Process A: calls ipc function
>> Process A: sleeps just at the beginning of the syscall
>> Process B: Frees the ipc object (i.e.: calls ...ctl(IPC_RMID)
>> Process B: Creates a new ipc object (i.e.: calls ...get())
>> 	<If new object and old object have the same id>
>> Process A: is woken up, and accesses the new object
>>
>> To reduce the probability that the new and the old object have the
>> same id, the current implementation adds a sequence number to the
>> index of the object in the idr tree.
>>
>> To further reduce the probability for a reuse, perform a cyclic
>> allocation, and increase the sequence number only when there is
>> a wrap-around. Unfortunately, idr_alloc_cyclic cannot be used,
>> because the sequence number must be increased when a wrap-around
>> occurs.
>>
>> The patch cycles over at least RADIX_TREE_MAP_SIZE, i.e.
>> if there is only a small number of objects, the accesses
>> continue to be direct.
>>
>> Signed-off-by: Manfred Spraul<manfred@colorfullife.com>
>> ---
>>   ipc/util.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 44 insertions(+), 4 deletions(-)
>>
>> diff --git a/ipc/util.c b/ipc/util.c
>> index 07ae117ccdc0..fa7b8fa7a14c 100644
>> --- a/ipc/util.c
>> +++ b/ipc/util.c
>> @@ -216,10 +216,49 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
>>   	 */
>>   
>>   	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
>> -		new->seq = ids->seq++;
>> -		if (ids->seq > IPCID_SEQ_MAX)
>> -			ids->seq = 0;
>> -		idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
>> +		int idx_max;
>> +
>> +		/*
>> +		 * If a user space visible id is reused, then this creates a
>> +		 * risk for data corruption. To reduce the probability that
>> +		 * a number is reused, three approaches are used:
>> +		 * 1) the idr index is allocated cyclically.
>> +		 * 2) the use space id is build by concatenating the
>> +		 *    internal idr index with a sequence number.
>> +		 * 3) The sequence number is only increased when the index
>> +		 *    wraps around.
>> +		 * Note that this code cannot use idr_alloc_cyclic:
>> +		 * new->seq must be set before the entry is inserted in the
>> +		 * idr.
>
> I don't think that is true. The IDR code just need to associate a 
> pointer to the given ID. It is not going to access anything inside. So 
> we don't need to set the seq number first before calling idr_alloc().
>
We must, sorry - there is even a CVE associate to that bug:

CVE-2015-7613, 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b9a532277938798b53178d5a66af6e2915cb27cf

The problem is not the IDR code, the problem is that 
ipc_obtain_object_check() calls ipc_checkid(), and ipc_checkid() 
accesses ipcp->seq.

And since the ipc_checkid() is called before acquiring any locks, 
everything must be fully initialized before idr_alloc().

>> +		 */
>> +		idx_max = ids->in_use*2;
>> +		if (idx_max < RADIX_TREE_MAP_SIZE)
>> +			idx_max = RADIX_TREE_MAP_SIZE;
>> +		if (idx_max > ipc_mni)
>> +			idx_max = ipc_mni;
>> +
>> +		if (ids->ipcs_idr.idr_next <= idx_max) {
>> +			new->seq = ids->seq;
>> +			idx = idr_alloc(&ids->ipcs_idr, new,
>> +						ids->ipcs_idr.idr_next,
>> +						idx_max, GFP_NOWAIT);
>> +		}
>> +
>> +		if ((idx == -ENOSPC) && (ids->ipcs_idr.idr_next > 0)) {
>> +			/*
>> +			 * A wrap around occurred.
>> +			 * Increase ids->seq, update new->seq
>> +			 */
>> +			ids->seq++;
>> +			if (ids->seq > IPCID_SEQ_MAX)
>> +				ids->seq = 0;
>> +			new->seq = ids->seq;
>> +
>> +			idx = idr_alloc(&ids->ipcs_idr, new, 0, idx_max,
>> +						GFP_NOWAIT);
>> +		}
>> +		if (idx >= 0)
>> +			ids->ipcs_idr.idr_next = idx+1;
>
> This code has dependence on the internal implementation of the IDR 
> code. So if the IDR code is changed and the one who does it forgets to 
> update the IPC code, we may have a problem. Using idr_alloc_cyclic() 
> for all will likely increase memory footprint which can be a problem 
> on IoT devices that have little memory. That is the main reason why I 
> opted to use idr_alloc_cyclic() only when in ipcmni_extend mode which 
> I am sure won't be activated on systems with little memory.
>
I know.

But IoT devices with little memory will compile out sysv (as it is done 
by Android).


--

     Manfred

