Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268FEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5DA2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="pNSOQIQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfCSSSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:18:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38534 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfCSSSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:18:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id g12so22303094wrm.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 11:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=8bmYAqCxXPI39WwYcjuE0FBIo59wrsIlb3+fpsRjylI=;
        b=pNSOQIQdxS786wrvogH9ApZpMYOt3v7I/rBYdsYwuGQzmsnKOa+zQy6VdfmnqcPjLe
         UYL/ugOc27QSOGJ7Xb4Ibps08CgwqPcyNhQzuoONCD8He6nzPP4UMNwxUiTuLYZH1+Rc
         ZgpZQ3Iv0+d76TQr4/TUhbrT42MLfH9T2SNpjq1v5XSl7KzmZhg6dg9+sliwv/t2N4FI
         VnVszB8hJEEUwKbVPkvR3FXVtYg1/CC7zkJn8jUJWRVnB8Tv92XsrxyOZ/4HAUe7LkFi
         /XrOmR3a2MssAbwxIfYYXCNXuErcz3QSNT2uX4ZVhcIVg2EvuPFINYNrs0xLXE9RjyDD
         tr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=8bmYAqCxXPI39WwYcjuE0FBIo59wrsIlb3+fpsRjylI=;
        b=Mkixij0vgxkkNvKCYfI3M5RHoAKmsVN2JvuBbBRwpvhIcX8B+/qc0vrj1vIvZGMezv
         rDXBJB4wKE8Yd3po6XSYGhcEO/eQSWDHrzKjrwYy8FoXNHaWPcbiyRgfXd87ef1Obhp0
         rfHIR+K9luh6h0Tf4GfpKEGd0sOIM6oMhqGJP+mlUfwFqjY8Ji03YDAZepkkmbP9zOZb
         O6mO2w9K1DVfY00w9wH7Qi0Jj9FxnQtiIiqydvD8mFVxg6lKRM8TE67qt0e/wctsykRF
         gpV8ZP9HaxHYjl8R8xFmm3TZT3a3wo3m76OEncpSGAKIQ28bi11lcAdDK7N//RBb2Rra
         5z0A==
X-Gm-Message-State: APjAAAWVa/WxSBYak6yRMfRX43gN8Hs0eQs9VKuiLuU3JanYDnpLnCBn
        BktJKmjvjjFFc0LsdRBTFUd8kw==
X-Google-Smtp-Source: APXvYqxlQ9/165eL1BAwpy+GWOS96rKrBJKVHB96y2xjB0kFtfJ2aKERmian9mtiEXYUU68bp6sY8w==
X-Received: by 2002:a5d:570f:: with SMTP id a15mr19395959wrv.221.1553019523101;
        Tue, 19 Mar 2019 11:18:43 -0700 (PDT)
Received: from linux-2.fritz.box (p200300D993C63F00D0C10C25DF2C30ED.dip0.t-ipconnect.de. [2003:d9:93c6:3f00:d0c1:c25:df2c:30ed])
        by smtp.googlemail.com with ESMTPSA id v1sm11863115wrt.88.2019.03.19.11.18.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 11:18:40 -0700 (PDT)
Subject: Re: [PATCH v12 3/3] ipc: Do cyclic id allocation with ipcmni_extend
 mode
To:     Waiman Long <longman@redhat.com>,
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
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <28571549-344f-8423-a20d-aeccff0e838a@colorfullife.com>
Date:   Tue, 19 Mar 2019 19:18:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <728b5e85-3129-9707-3802-306f66093c78@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------A7D59D5DBD5C63499CFC89A0"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A7D59D5DBD5C63499CFC89A0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Waiman,


On 3/18/19 7:46 PM, Waiman Long wrote:
> --- a/ipc/util.c
>> +++ b/ipc/util.c
>> @@ -221,9 +221,17 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
>>   	 */
>>   
>>   	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
>> +		int max_idx;
>> +
>> +		max_idx = ids->in_use*3/2;
>> +		if (max_idx > ipc_mni)
>> +			max_idx = ipc_mni;
>> +		if (max_idx < ipc_min_cycle)
>> +			max_idx = ipc_min_cycle;
>
> Why don't you use the min() and max() macros which will make it easier 
> to read?
>
Changed.
>>   
>>   		/* allocate the idx, with a NULL struct kern_ipc_perm */
>> -		idx = idr_alloc(&ids->ipcs_idr, NULL, 0, 0, GFP_NOWAIT);
>> +		idx = idr_alloc_cyclic(&ids->ipcs_idr, NULL, 0, max_idx,
>> +					GFP_NOWAIT);
>>   
>>   		if (idx >= 0) {
>>   			/*
>> diff --git a/ipc/util.h b/ipc/util.h
>> index 8c834ed39012..ef4e86bb2db8 100644
>> --- a/ipc/util.h
>> +++ b/ipc/util.h
>> @@ -27,12 +27,14 @@
>>    */
>>   #define IPCMNI_SHIFT		15
>>   #define IPCMNI_EXTEND_SHIFT	24
>> +#define IPCMNI_EXTEND_MIN_CYCLE	(2 << 12)
>
> How about
>
> #define IPCMNI_EXTEND_MIN_CYCLE    (RADIX_TREE_MAP_SIZE * 
> RADIX_TREE_MAP_SIZE)
>
Good idea.
Actually, "2<<12" was the initial guess.

And then I noticed that this ends up as a two level radix tree during 
testing :-)


Updated patch attached.

--

     Manfred


--------------A7D59D5DBD5C63499CFC89A0
Content-Type: text/x-patch;
 name="0002-ipc-Do-cyclic-id-allocation-for-the-ipc-object.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-ipc-Do-cyclic-id-allocation-for-the-ipc-object.patch"

From 844c9d78cea41983a89c820bd5265ceded59883b Mon Sep 17 00:00:00 2001
From: Manfred Spraul <manfred@colorfullife.com>
Date: Sun, 17 Mar 2019 06:29:00 +0100
Subject: [PATCH 2/2] ipc: Do cyclic id allocation for the ipc object.

For ipcmni_extend mode, the sequence number space is only 7 bits. So
the chance of id reuse is relatively high compared with the non-extended
mode.

To alleviate this id reuse problem, this patch enables cyclic allocation
for the index to the radix tree (idx).
The disadvantage is that this can cause a slight slow-down of the fast
path, as the radix tree could be higher than necessary.

To limit the radix tree height, I have chosen the following limits:
- 1) The cycling is done over in_use*1.5.
- 2) At least, the cycling is done over
   "normal" ipcnmi mode: RADIX_TREE_MAP_SIZE elements
   "ipcmni_extended": 4096 elements

Result:
- for normal mode:
	No change for <= 42 active ipc elements. With more than 42
	active ipc elements, a 2nd level would be added to the radix
	tree.
	Without cyclic allocation, a 2nd level would be added only with
	more than 63 active elements.

- for extended mode:
	Cycling creates always at least a 2-level radix tree.
	With more than 2730 active objects, a 3rd level would be
	added, instead of > 4095 active objects until the 3rd level
	is added without cyclic allocation.

For a 2-level radix tree compared to a 1-level radix tree, I have
observed < 1% performance impact.

Notes:
1) Normal "x=semget();y=semget();" is unaffected: Then the idx
  is e.g. a and a+1, regardless if idr_alloc() or idr_alloc_cyclic()
  is used.

2) The -1% happens in a microbenchmark after this situation:
	x=semget();
	for(i=0;i<4000;i++) {t=semget();semctl(t,0,IPC_RMID);}
	y=semget();
	Now perform semget calls on x and y that do not sleep.

3) The worst-case reuse cycle time is unfortunately unaffected:
   If you have 2^24-1 ipc objects allocated, and get/remove the last
   possible element in a loop, then the id is reused after 128
   get/remove pairs.

Performance check:
A microbenchmark that performes no-op semop() randomly on two IDs,
with only these two IDs allocated.
The IDs were set using /proc/sys/kernel/sem_next_id.
The test was run 5 times, averages are shown.

1 & 2: Base (6.22 seconds for 10.000.000 semops)
1 & 40: -0.2%
1 & 3348: - 0.8%
1 & 27348: - 1.6%
1 & 15777204: - 3.2%

Or: ~12.6 cpu cycles per additional radix tree level.
The cpu is an Intel I3-5010U. ~1300 cpu cycles/syscall is slower
than what I remember (spectre impact?).

V2 of the patch:
- use "min" and "max"
- use RADIX_TREE_MAP_SIZE * RADIX_TREE_MAP_SIZE instead of
	(2<<12).

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/ipc_sysctl.c | 2 ++
 ipc/util.c       | 7 ++++++-
 ipc/util.h       | 3 +++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 73b7782eccf4..bfaae457810c 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -122,6 +122,7 @@ static int one = 1;
 static int int_max = INT_MAX;
 int ipc_mni = IPCMNI;
 int ipc_mni_shift = IPCMNI_SHIFT;
+int ipc_min_cycle = RADIX_TREE_MAP_SIZE;
 
 static struct ctl_table ipc_kern_table[] = {
 	{
@@ -252,6 +253,7 @@ static int __init ipc_mni_extend(char *str)
 {
 	ipc_mni = IPCMNI_EXTEND;
 	ipc_mni_shift = IPCMNI_EXTEND_SHIFT;
+	ipc_min_cycle = IPCMNI_EXTEND_MIN_CYCLE;
 	pr_info("IPCMNI extended to %d.\n", ipc_mni);
 	return 0;
 }
diff --git a/ipc/util.c b/ipc/util.c
index 6e0fe3410423..1a492afb1d8b 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -221,9 +221,14 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 	 */
 
 	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
+		int max_idx;
+
+		max_idx = max(ids->in_use*3/2, ipc_min_cycle);
+		max_idx = min(max_idx, ipc_mni);
 
 		/* allocate the idx, with a NULL struct kern_ipc_perm */
-		idx = idr_alloc(&ids->ipcs_idr, NULL, 0, 0, GFP_NOWAIT);
+		idx = idr_alloc_cyclic(&ids->ipcs_idr, NULL, 0, max_idx,
+					GFP_NOWAIT);
 
 		if (idx >= 0) {
 			/*
diff --git a/ipc/util.h b/ipc/util.h
index 8c834ed39012..d316399f0c32 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -27,12 +27,14 @@
  */
 #define IPCMNI_SHIFT		15
 #define IPCMNI_EXTEND_SHIFT	24
+#define IPCMNI_EXTEND_MIN_CYCLE	(RADIX_TREE_MAP_SIZE * RADIX_TREE_MAP_SIZE)
 #define IPCMNI			(1 << IPCMNI_SHIFT)
 #define IPCMNI_EXTEND		(1 << IPCMNI_EXTEND_SHIFT)
 
 #ifdef CONFIG_SYSVIPC_SYSCTL
 extern int ipc_mni;
 extern int ipc_mni_shift;
+extern int ipc_min_cycle;
 
 #define ipcmni_seq_shift()	ipc_mni_shift
 #define IPCMNI_IDX_MASK		((1 << ipc_mni_shift) - 1)
@@ -40,6 +42,7 @@ extern int ipc_mni_shift;
 #else /* CONFIG_SYSVIPC_SYSCTL */
 
 #define ipc_mni			IPCMNI
+#define ipc_min_cycle		RADIX_TREE_MAP_SIZE
 #define ipcmni_seq_shift()	IPCMNI_SHIFT
 #define IPCMNI_IDX_MASK		((1 << IPCMNI_SHIFT) - 1)
 #endif /* CONFIG_SYSVIPC_SYSCTL */
-- 
2.17.2


--------------A7D59D5DBD5C63499CFC89A0--
