Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3E3C10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE63218FC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="fmAeJrRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfCPSwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 14:52:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38363 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbfCPSwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 14:52:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so12839881wrm.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=KhrccLgD/01f0AIuQXhuzC3qXpyICQORZfPQyNLqP90=;
        b=fmAeJrRE8Hjn+GGMwMlHyKYlfUGgMRo3H7QGBBgHZSeGWBPXrA2LJn+i7EzI33Pg+X
         5uziOfrPwCaTpQ7ceA1CHexwf1Mw4LFLb0W+jFranHKkjSvoG/6CfDcmJZG4ip2fzAo0
         aF1gZwsdJDWiopvFcikkXAH0K9M8bpbZR+xBJcXqSW+a4dGGqSlqCV5J9dVnE18HIMia
         yhSMT1ndBxOhKEPAG2LIE9ZS5p0gFAlouj6YsZH6TAfS9HXoQBtLKn4xRNAlcwBDsyfR
         E6tQPIBirAp5oTGEzd3ewTFHkZAoLV0/9uD/8ShiXcUin+unrcWOobwK8cE/G473wKDA
         /GEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=KhrccLgD/01f0AIuQXhuzC3qXpyICQORZfPQyNLqP90=;
        b=cHETy2HYECWFMrEZ8fyw9r3vRXWCjjcBAhPYPFtdPS7TpCoVOUosx/V3Ce3PEyfdUK
         Gbqle6wCYpMP1ywzaNykpwt0dhZvVKCRw5X9CMCcrqtHhbXdAmwo62pIaS1JX6TY2RQa
         zZ8AaVKL/swP9y0GPjWlEHUzSVEeY0F0+rQ3wb9y++WSqMg9yyqsfH/aC4SF/p6TWfSy
         Fr4p5DElD2XYIi94lQtRUvgVUPwXNsLBnOqQNPk1c/JDOLGF02CaPUInbr6XdeiwwLfr
         DqUGxop3QL12f+2gy3xMGHbmpDtcLKq7Qq2MblLIve6a7x3YEkxHqp9D51noaX7X4Jh/
         wOmg==
X-Gm-Message-State: APjAAAVZ0Lhp5zaXTi01OaJEuSos6q5pJ6+43/Fp1qBzXI3bxvsG2PI1
        VwRgaSdpm6SOGMSgxFFA5ZUINw==
X-Google-Smtp-Source: APXvYqzjkx6vCnrSpwpYdR2iyXntrpynL7puJ+uuBc24aKZmn9SfOgST5O+9h+pBnKxF83crIL5hfg==
X-Received: by 2002:a5d:4110:: with SMTP id l16mr6920608wrp.129.1552762361468;
        Sat, 16 Mar 2019 11:52:41 -0700 (PDT)
Received: from linux-2.fritz.box (p200300D993F84200A1D7112AEB672F40.dip0.t-ipconnect.de. [2003:d9:93f8:4200:a1d7:112a:eb67:2f40])
        by smtp.googlemail.com with ESMTPSA id b3sm6619681wmj.15.2019.03.16.11.52.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 11:52:40 -0700 (PDT)
Subject: Re: [PATCH v12 2/3] ipc: Conserve sequence numbers in ipcmni_extend
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
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        1vier1@web.de
References: <1551379645-819-1-git-send-email-longman@redhat.com>
 <1551379645-819-3-git-send-email-longman@redhat.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <398a8bcb-7568-0a5b-c6cb-77420de445b9@colorfullife.com>
Date:   Sat, 16 Mar 2019 19:52:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1551379645-819-3-git-send-email-longman@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------42211600C7F53E83FD83F742"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------42211600C7F53E83FD83F742
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 2/28/19 7:47 PM, Waiman Long wrote:
> @@ -216,10 +221,11 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
>   	 */
>   
>   	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
> -		new->seq = ids->seq++;
> -		if (ids->seq > IPCID_SEQ_MAX)
> -			ids->seq = 0;
>   		idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
> +		if ((idx <= ids->last_idx) && (++ids->seq > IPCID_SEQ_MAX))
> +			ids->seq = 0;

I'm always impressed by such lines:

Everything in just two lines, use "++a", etc.

But: How did you test it?

idr_alloc() can fail, the code doesn't handle that :-(


> +		new->seq = ids->seq;

As written this morning:

Writing new->seq after inserting "new" into the idr creates races 
without any good reason.

I could not spot a bug, even find_alloc_undo() appears to be safe, but 
why should we take this risk?


Attached is:

- proposed replacement for this patch.

- the test patch that I have used to check the error handling.


--

     Manfred


--------------42211600C7F53E83FD83F742
Content-Type: text/plain; charset=UTF-8;
 name="patch-debug-idr_alloc_failure"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch-debug-idr_alloc_failure"

ZGlmZiAtLWdpdCBhL2lwYy91dGlsLmMgYi9pcGMvdXRpbC5jCmluZGV4IDZlMGZlMzQxMDQy
My4uNWRhZmU0YmM3OGExIDEwMDY0NAotLS0gYS9pcGMvdXRpbC5jCisrKyBiL2lwYy91dGls
LmMKQEAgLTMwOSw2ICszMDksNyBAQCBpbnQgaXBjX2FkZGlkKHN0cnVjdCBpcGNfaWRzICpp
ZHMsIHN0cnVjdCBrZXJuX2lwY19wZXJtICpuZXcsIGludCBsaW1pdCkKIAkJfQogCX0KIAlp
ZiAoaWR4IDwgMCkgeworcHJfaW5mbygiZmFpbGVkIGFsbG9jYXRpb24uXG4iKTsKIAkJbmV3
LT5kZWxldGVkID0gdHJ1ZTsKIAkJc3Bpbl91bmxvY2soJm5ldy0+bG9jayk7CiAJCXJjdV9y
ZWFkX3VubG9jaygpOwpkaWZmIC0tZ2l0IGEvbGliL2lkci5jIGIvbGliL2lkci5jCmluZGV4
IGNiMWRiOWI4ZDNmNi4uYmEyNzRiYWE4N2UzIDEwMDY0NAotLS0gYS9saWIvaWRyLmMKKysr
IGIvbGliL2lkci5jCkBAIC04Myw2ICs4MywxNyBAQCBpbnQgaWRyX2FsbG9jKHN0cnVjdCBp
ZHIgKmlkciwgdm9pZCAqcHRyLCBpbnQgc3RhcnQsIGludCBlbmQsIGdmcF90IGdmcCkKIAlp
ZiAoV0FSTl9PTl9PTkNFKHN0YXJ0IDwgMCkpCiAJCXJldHVybiAtRUlOVkFMOwogCisJewor
CQl1NjQgYSA9IGdldF9qaWZmaWVzXzY0KCk7CisKKwkJaWYgKHRpbWVfYWZ0ZXI2NChhLCAo
dTY0KUlOSVRJQUxfSklGRklFUys0MCpIWikpIHsKKwkJCWlmIChhJTUgPCAyKSB7CisJCQkJ
cHJfaW5mbygiaWRyX2FsbG9jOkZhaWxpbmcuXG4iKTsKKwkJCQlyZXR1cm4gLUVOT1NQQzsK
KwkJCX0KKwkJfQorCX0KKwogCXJldCA9IGlkcl9hbGxvY191MzIoaWRyLCBwdHIsICZpZCwg
ZW5kID4gMCA/IGVuZCAtIDEgOiBJTlRfTUFYLCBnZnApOwogCWlmIChyZXQpCiAJCXJldHVy
biByZXQ7Cg==
--------------42211600C7F53E83FD83F742
Content-Type: text/x-patch;
 name="0001-ipc-Conserve-sequence-numbers-in-ipcmni_extend-mode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ipc-Conserve-sequence-numbers-in-ipcmni_extend-mode.pat";
 filename*1="ch"

From edee319b2d5c96af14b8b8899e5dde324861e4e4 Mon Sep 17 00:00:00 2001
From: Manfred Spraul <manfred@colorfullife.com>
Date: Sat, 16 Mar 2019 10:18:53 +0100
Subject: [PATCH] ipc: Conserve sequence numbers in ipcmni_extend mode

Rewrite, based on the patch from Waiman Long:

The mixing in of a sequence number into the IPC IDs is probably to
avoid ID reuse in userspace as much as possible. With ipcmni_extend
mode, the number of usable sequence numbers is greatly reduced leading
to higher chance of ID reuse.

To address this issue, we need to conserve the sequence number space
as much as possible. Right now, the sequence number is incremented for
every new ID created. In reality, we only need to increment the sequence
number when new allocated ID is not greater than the last one allocated.
It is in such case that the new ID may collide with an existing one.
This is being done irrespective of the ipcmni mode.

In order to avoid any races, the index is first allocated and
then the pointer is replaced.

Changes compared to the initial patch:
- Handle failures from idr_alloc().
- Avoid that concurrent operations can see the wrong
  sequence number.
(This is achieved by using idr_replace()).
- IPCMNI_SEQ_SHIFT is not a constant, thus renamed to
	ipcmni_seq_shift().
- IPCMNI_SEQ_MAX is not a constant, thus renamed to
	ipcmni_seq_max().

Suggested-by: Matthew Wilcox <willy@infradead.org>
Original-patch-from: Waiman Long <longman@redhat.com>
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 include/linux/ipc_namespace.h |  1 +
 ipc/util.c                    | 35 ++++++++++++++++++++++++++++++-----
 ipc/util.h                    |  8 ++++----
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index 6ab8c1bada3f..c309f43bde45 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -19,6 +19,7 @@ struct ipc_ids {
 	struct rw_semaphore rwsem;
 	struct idr ipcs_idr;
 	int max_idx;
+	int last_idx;	/* For wrap around detection */
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	int next_id;
 #endif
diff --git a/ipc/util.c b/ipc/util.c
index 07ae117ccdc0..6e0fe3410423 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -120,6 +120,7 @@ void ipc_init_ids(struct ipc_ids *ids)
 	rhashtable_init(&ids->key_ht, &ipc_kht_params);
 	idr_init(&ids->ipcs_idr);
 	ids->max_idx = -1;
+	ids->last_idx = -1;
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	ids->next_id = -1;
 #endif
@@ -193,6 +194,10 @@ static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
  *
  * The caller must own kern_ipc_perm.lock.of the new object.
  * On error, the function returns a (negative) error code.
+ *
+ * To conserve sequence number space, especially with extended ipc_mni,
+ * the sequence number is incremented only when the returned ID is less than
+ * the last one.
  */
 static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 {
@@ -216,17 +221,37 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 	 */
 
 	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
-		new->seq = ids->seq++;
-		if (ids->seq > IPCID_SEQ_MAX)
-			ids->seq = 0;
-		idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
+
+		/* allocate the idx, with a NULL struct kern_ipc_perm */
+		idx = idr_alloc(&ids->ipcs_idr, NULL, 0, 0, GFP_NOWAIT);
+
+		if (idx >= 0) {
+			/*
+			 * idx got allocated successfully.
+			 * Now calculate the sequence number and set the
+			 * pointer for real.
+			 */
+			if (idx <= ids->last_idx) {
+				ids->seq++;
+				if (ids->seq >= ipcid_seq_max())
+					ids->seq = 0;
+			}
+			ids->last_idx = idx;
+
+			new->seq = ids->seq;
+			/* no need for smp_wmb(), this is done
+			 * inside idr_replace, as part of
+			 * rcu_assign_pointer
+			 */
+			idr_replace(&ids->ipcs_idr, new, idx);
+		}
 	} else {
 		new->seq = ipcid_to_seqx(next_id);
 		idx = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
 				0, GFP_NOWAIT);
 	}
 	if (idx >= 0)
-		new->id = (new->seq << IPCMNI_SEQ_SHIFT) + idx;
+		new->id = (new->seq << ipcmni_seq_shift()) + idx;
 	return idx;
 }
 
diff --git a/ipc/util.h b/ipc/util.h
index 9746886757de..8c834ed39012 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -34,13 +34,13 @@
 extern int ipc_mni;
 extern int ipc_mni_shift;
 
-#define IPCMNI_SEQ_SHIFT	ipc_mni_shift
+#define ipcmni_seq_shift()	ipc_mni_shift
 #define IPCMNI_IDX_MASK		((1 << ipc_mni_shift) - 1)
 
 #else /* CONFIG_SYSVIPC_SYSCTL */
 
 #define ipc_mni			IPCMNI
-#define IPCMNI_SEQ_SHIFT	IPCMNI_SHIFT
+#define ipcmni_seq_shift()	IPCMNI_SHIFT
 #define IPCMNI_IDX_MASK		((1 << IPCMNI_SHIFT) - 1)
 #endif /* CONFIG_SYSVIPC_SYSCTL */
 
@@ -123,8 +123,8 @@ struct pid_namespace *ipc_seq_pid_ns(struct seq_file *);
 #define IPC_SHM_IDS	2
 
 #define ipcid_to_idx(id)  ((id) & IPCMNI_IDX_MASK)
-#define ipcid_to_seqx(id) ((id) >> IPCMNI_SEQ_SHIFT)
-#define IPCID_SEQ_MAX	  (INT_MAX >> IPCMNI_SEQ_SHIFT)
+#define ipcid_to_seqx(id) ((id) >> ipcmni_seq_shift())
+#define ipcid_seq_max()	  (INT_MAX >> ipcmni_seq_shift())
 
 /* must be called with ids->rwsem acquired for writing */
 int ipc_addid(struct ipc_ids *, struct kern_ipc_perm *, int);
-- 
2.17.2


--------------42211600C7F53E83FD83F742--
