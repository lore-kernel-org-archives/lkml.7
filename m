Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C4BC282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808C320850
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="iFuPvSoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfDTLex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 07:34:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49102 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfDTLex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 07:34:53 -0400
Received: from zn.tnic (p200300EC2F112E00718873C84F24A365.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:7188:73c8:4f24:a365])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B10521EC023E;
        Sat, 20 Apr 2019 13:34:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555760090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JfyP/Kkhj228wRApkUcncrlNU0Z4l9io7YpRHyjIx0Y=;
        b=iFuPvSoZTwOopoUXbtUw8LjyhnsVVU0OTc7pVbKvDhUXyhA6Y88hdW2ueerheE/3Gv16+h
        k/9BpAlxngF9Ue5iqG5tHl20ww1U2Rozbh/nq+ic6YLYTEby9C8pxvWpZ8o08fVYa+p8MN
        +ETheSmEvKlgU1iYiJNuNaYkotiiT6I=
Date:   Sat, 20 Apr 2019 13:34:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/2] ras: fix an off-by-one error in __find_elem()
Message-ID: <20190420113444.GC29704@zn.tnic>
References: <20190416213351.28999-1-xiyou.wangcong@gmail.com>
 <20190416214634.GP31772@zn.tnic>
 <CAM_iQpVd02zkVJ846cj-Fg1yUNuz6tY5q1Vpj4LrXmE06dPYYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM_iQpVd02zkVJ846cj-Fg1yUNuz6tY5q1Vpj4LrXmE06dPYYg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 04:16:08PM -0700, Cong Wang wrote:
> It is actually fairly easy:
> 
> 1) Fill the whole page with PFN's:
> for i in `seq 0 511`; do echo $i >> /sys/kernel/debug/ras/cec/pfn; done
> 
> 2) Set thresh to 1 in order to trigger the deletion:
> echo 1 > /sys/kernel/debug/ras/cec/count_threshold
> 
> 3) Repeatedly add and remove the last element:
> echo 512 >> /sys/kernel/debug/ras/cec/pfn
> (until you get a crash.)

Thanks, I was able to reproduce with that. Below is a conglomerate patch
which converts __find_elem() to using Donald Knuth's binary search
version. I don't know what I was thinking then and why I didn't use
it from the get-go. The textbook even says that one can easily get it
wrong...

Anyway, see below. It has some debug output for easier debugging, that
will be removed in the final version, of course. With it, the injection
pattern above works as expected and I'll continue hammering on it to see
if there are more funky issues.

For easier experimenting, the whole branch is also here:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-ras-core-cec

Thx.

---
From: Borislav Petkov <bp@suse.de>
Date: Sat, 20 Apr 2019 13:27:51 +0200
Subject: [PATCH] WIP

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/ras/cec.c | 83 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 21 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 3e9f62b84378..946e52751ae2 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -185,31 +185,42 @@ static void cec_work_fn(struct work_struct *work)
  */
 static int __find_elem(struct ce_array *ca, u64 pfn, unsigned int *to)
 {
+	int min = 0, max = ca->n - 1;
 	u64 this_pfn;
-	int min = 0, max = ca->n;
 
-	while (min < max) {
-		int tmp = (max + min) >> 1;
+	pr_info("%s: entry %llu in [%d:%d]?\n", __func__, pfn, min, max);
 
-		this_pfn = PFN(ca->array[tmp]);
+	while (min <= max) {
+		int i = (min + max) >> 1;
+
+		this_pfn = PFN(ca->array[i]);
+
+		pr_info("%s: ... this_pfn: %3llu, [%3d:%3d:%3d]\n",
+			__func__, this_pfn, min, i, max);
 
 		if (this_pfn < pfn)
-			min = tmp + 1;
+			min = i + 1;
 		else if (this_pfn > pfn)
-			max = tmp;
-		else {
-			min = tmp;
-			break;
+			max = i - 1;
+		else if (this_pfn == pfn) {
+			pr_info("%s: .. FOUND at %d\n", __func__, i);
+
+			if (to)
+				*to = i;
+
+			return i;
 		}
 	}
 
-	if (to)
-		*to = min;
-
-	this_pfn = PFN(ca->array[min]);
+	/*
+	 * When the loop terminates without finding @pfn, min has the index of
+	 * the element slot where the new @pfn should be inserted.
+	 */
 
-	if (this_pfn == pfn)
-		return min;
+	if (to) {
+		*to = min;
+		pr_info("%s: [%d:%d]\n", __func__, min, max);
+	}
 
 	return -ENOKEY;
 }
@@ -234,6 +245,8 @@ static void del_elem(struct ce_array *ca, int idx)
 			(ca->n - (idx + 1)) * sizeof(u64));
 
 	ca->n--;
+
+	pr_info("%s: idx: %d, ca->n: %d\n", __func__, idx, ca->n);
 }
 
 static u64 del_lru_elem_unlocked(struct ce_array *ca)
@@ -274,13 +287,43 @@ static u64 __maybe_unused del_lru_elem(void)
 	return pfn;
 }
 
+static bool sanity_check(struct ce_array *ca)
+{
+	bool ret = false;
+	u64 prev = 0;
+	int i;
+
+	for (i = 0; i < ca->n; i++) {
+		u64 this = PFN(ca->array[i]);
+
+		if (WARN(prev > this, "prev: 0x%016llx <-> this: 0x%016llx\n", prev, this))
+			ret = true;
+
+		prev = this;
+	}
+
+	if (!ret)
+		return ret;
+
+	pr_info("Sanity check:\n{ n: %d\n", ca->n);
+	for (i = 0; i < ca->n; i++) {
+		u64 this = PFN(ca->array[i]);
+		pr_info(" %03d: [%016llx|%03llx]\n", i, this, FULL_COUNT(ca->array[i]));
+	}
+	pr_info("}\n");
+
+	return ret;
+}
 
 int cec_add_elem(u64 pfn)
 {
 	struct ce_array *ca = &ce_arr;
-	unsigned int to;
+	unsigned int to = 0;
 	int count, ret = 0;
 
+	pr_info("===============================================\n");
+	pr_info("%s: entry, pfn: %lld, ca->n: %d\n", __func__, pfn, ca->n);
+
 	/*
 	 * We can be called very early on the identify_cpu() path where we are
 	 * not initialized yet. We ignore the error for simplicity.
@@ -296,6 +339,7 @@ int cec_add_elem(u64 pfn)
 		WARN_ON(!del_lru_elem_unlocked(ca));
 
 	ret = find_elem(ca, pfn, &to);
+	pr_info("%s: find_elem: ret: %d: to: %d\n", __func__, ret, to);
 	if (ret < 0) {
 		/*
 		 * Shift range [to-end] to make room for one more element.
@@ -350,6 +394,8 @@ int cec_add_elem(u64 pfn)
 	if (ca->decay_count >= CLEAN_ELEMS)
 		do_spring_cleaning(ca);
 
+	WARN_ON_ONCE(sanity_check(ca));
+
 unlock:
 	mutex_unlock(&ce_mutex);
 
@@ -407,7 +453,6 @@ DEFINE_DEBUGFS_ATTRIBUTE(count_threshold_ops, pfn_get, count_threshold_set, "%ll
 static int array_dump(struct seq_file *m, void *v)
 {
 	struct ce_array *ca = &ce_arr;
-	u64 prev = 0;
 	int i;
 
 	mutex_lock(&ce_mutex);
@@ -417,10 +462,6 @@ static int array_dump(struct seq_file *m, void *v)
 		u64 this = PFN(ca->array[i]);
 
 		seq_printf(m, " %03d: [%016llx|%03llx]\n", i, this, FULL_COUNT(ca->array[i]));
-
-		WARN_ON(prev > this);
-
-		prev = this;
 	}
 
 	seq_printf(m, "}\n");
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
