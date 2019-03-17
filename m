Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DC5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F3D20857
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="BAR3XUVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfCQS1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 14:27:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50271 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfCQS1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 14:27:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so2357088wmi.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=KQXbIgwURYXqhCAoG41rtpxoVVDT42+Z8WntBJzAedQ=;
        b=BAR3XUVCXcwcF/ypzhlqYdYqT2hDtP5mmEF63hcf4AZb3zWj8TA7N04JzVt8PZ6ZcJ
         pYQJPkOS4ecR75F4PgpAvblSMdxo+ZQwSgDoRHnEY6cSjasNfLTY/7MX+wOfX3Iz5ezo
         TK4DaJ6HI6Q19HL2juZ2f0OrjfKoLQ2+XqHkwqScnlJ+jJQoTt+bpms0sESScRlsmI9k
         MOjfVbVC9kojIm7gMWLaZb38/67LuzrzTPl4ugwTlIIbZ9n9UUnBOO0raadvQzPsUTJH
         sLV/DGnFHEbhSPB821CxeVoai4uvLBAuFXMZPP7khRN5gFCWdwKN6uELsti3CIwjxHiJ
         +G1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=KQXbIgwURYXqhCAoG41rtpxoVVDT42+Z8WntBJzAedQ=;
        b=RuylQDt9j9F5wQGqMfkWlbhsT9eX2H3VXFMix0VzOa/XAK5OUS2h7FK1urZ1+MK3Fe
         mzCUV4SdplMej7mlhmSaJMXf0E8z98PP3DIzA34KzAqfYzSQq3h/V0zMUwt/DEBYH9lJ
         k8TOhYsTAAQ9GgiHLH5eOECDolFw4dTfj7QICcBWNxjdmqbXtTCUmkPmJ+1izoC+5E7e
         pq3iWJdbhcL0BksK556NnszzgphhJS8u31vXDjVGRV4ZznoBWJtgCm1VJ2S/lQg/LCjH
         UtSzpaMAmzQditO1knj1E4k1vcger/m2UlFQ9WdNuAzSpNN+Y/TigarcA8uJMb2V3mB0
         edkg==
X-Gm-Message-State: APjAAAWTPnmXT5EHtWzT4dBLQL8XU5xbtQ+lOTFXpnmmtzeRdyuXzhZd
        GSCtzx1Mp8leBgzUFK0qKw7FMA==
X-Google-Smtp-Source: APXvYqy1pp+6pkwXDGWhObjYiHStvXvyJZOMeGqqtCzT2oXnBdGmPhLIzAK5W2SGPouM47fFcfVE3A==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr8974811wmj.0.1552847272984;
        Sun, 17 Mar 2019 11:27:52 -0700 (PDT)
Received: from linux.fritz.box (p200300D993C7CF006FC1A9295AF99078.dip0.t-ipconnect.de. [2003:d9:93c7:cf00:6fc1:a929:5af9:9078])
        by smtp.googlemail.com with ESMTPSA id r10sm7374739wmh.21.2019.03.17.11.27.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 11:27:50 -0700 (PDT)
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
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <e780cb59-ef1b-5f56-1e92-394dff5d4e32@colorfullife.com>
Date:   Sun, 17 Mar 2019 19:27:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1551379645-819-4-git-send-email-longman@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------A4C6461DF8A7175F73D8A162"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A4C6461DF8A7175F73D8A162
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Waiman,

On 2/28/19 7:47 PM, Waiman Long wrote:
> For ipcmni_extend mode, the sequence number space is only 7 bits. So
> the chance of id reuse is relatively high compared with the non-extended
> mode.
>
> To alleviate this id reuse problem, the id allocation will be done
> cyclically to cycle through all the 24-bit id space before wrapping
> around when in ipcmni_extend mode. This may cause the use of more memory
> in term of the number of xa_nodes allocated as well as potentially more
> cachelines used as the xa_nodes may be spread more sparsely in this case.
>
> There is probably a slight memory and performance cost in doing cyclic
> id allocation. For applications that really need more than 32k unique IPC
> identifiers, this is a small price to pay to avoid the id reuse problem.

Have you measured it?

I have observed -3% for semop() for a 4 level radix tree compared to a 
1-level radix tree, and I'm a bit reluctant to accept that.
Especially as the percentage will increase if the syscall overhead goes 
down again (-> less spectre impact).

[...]

> --- a/ipc/util.c
> +++ b/ipc/util.c
> @@ -221,7 +221,12 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
>   	 */
>   
>   	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
> -		idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
> +		if (ipc_mni_extended)
> +			idx = idr_alloc_cyclic(&ids->ipcs_idr, new, 0, ipc_mni,
> +						GFP_NOWAIT);
> +		else
> +			idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
> +
>   		if ((idx <= ids->last_idx) && (++ids->seq > IPCID_SEQ_MAX))
>   			ids->seq = 0;

I don't like it that there are two different codepaths.

Attached is a different proposal:

Always use cyclic allocation, with some logic to minimize the additional 
radix tree levels.

What do you think?

--

     Manfred


--------------A4C6461DF8A7175F73D8A162
Content-Type: text/x-patch;
 name="0002-ipc-Do-cyclic-id-allocation-for-the-ipc-objects.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-ipc-Do-cyclic-id-allocation-for-the-ipc-objects.patch"

From 491ea87cc3022e50c02caae009f9aeba2b6ddcb4 Mon Sep 17 00:00:00 2001
From: Manfred Spraul <manfred@colorfullife.com>
Date: Sun, 17 Mar 2019 06:29:00 +0100
Subject: [PATCH 2/2] ipc: Do cyclic id allocation for the ipc objects.

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
observed < 1% performance impact. I consider this as a good
compromise.

Notes:
1) Normal "x=semget();y=semget();" is unaffected: Then the idx
  is e.g. a and a+1, regardless of idr_alloc() or idr_alloc_cyclic()
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

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/ipc_sysctl.c |  2 ++
 ipc/util.c       | 10 +++++++++-
 ipc/util.h       |  3 +++
 3 files changed, 14 insertions(+), 1 deletion(-)

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
index 6e0fe3410423..90764b67af51 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -221,9 +221,17 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 	 */
 
 	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
+		int max_idx;
+
+		max_idx = ids->in_use*3/2;
+		if (max_idx > ipc_mni)
+			max_idx = ipc_mni;
+		if (max_idx < ipc_min_cycle)
+			max_idx = ipc_min_cycle;
 
 		/* allocate the idx, with a NULL struct kern_ipc_perm */
-		idx = idr_alloc(&ids->ipcs_idr, NULL, 0, 0, GFP_NOWAIT);
+		idx = idr_alloc_cyclic(&ids->ipcs_idr, NULL, 0, max_idx,
+					GFP_NOWAIT);
 
 		if (idx >= 0) {
 			/*
diff --git a/ipc/util.h b/ipc/util.h
index 8c834ed39012..ef4e86bb2db8 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -27,12 +27,14 @@
  */
 #define IPCMNI_SHIFT		15
 #define IPCMNI_EXTEND_SHIFT	24
+#define IPCMNI_EXTEND_MIN_CYCLE	(2 << 12)
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


--------------A4C6461DF8A7175F73D8A162--
