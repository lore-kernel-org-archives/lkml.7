Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0698FC432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 14:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFCC20867
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 14:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575211795;
	bh=By8n7lH0xdSqfgzGfkiJR3XC8wq1WaUy5KWTu+rAbOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kU8E9+1soLZFKXWKSvW+qGKFxARNrfUSgkS7si0833ASjDyqXG5TrCErmapuIwmWj
	 r9lSXZRj8GP9BS3H7c1BT2YbTnctUadJqxjGVsLEK7gwqGuc8r9ym+m/o+8RmCiQW5
	 hC5f8yAnpCd6jTEceo5i/9fnrz8D3WavS5P++9+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfLAOty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 09:49:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35954 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfLAOtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 09:49:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so40874549wru.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 06:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ylvN6ZtZY+4rnmTAVGH02rck7RX+bjDfkLlS5Rtampg=;
        b=NhPA7LccPkJhXHjbmnBeCwpp3V8V1hSOHH6PA48pKkvnkTwEYWucW8RjHN0KkeAWxr
         LGLQ+55Ii2pVdFwNcYRs07j3J4ZbvGNBPzKTaj8Cr5jG4ORdBqIcMen84cR45mjH9rqh
         IIspqOENV/M8Nbb4EYyNkHcSps197A9znvSEGA5EGDm8vFlCCQ4mxsErBGWR5e/3nuPm
         W0G3sli3/S4LJmL4UI5xd67HjjooPllGmgbE/o3UVoSsMMXP/yVbF2V4CiSCLuKA0DWA
         QakwAWXzmeCwMm3UNxcO45tCTTdoDj9Y7KA4Y6G6Rc21zhpkRm4PicMWqdlxS11EiRxt
         SAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ylvN6ZtZY+4rnmTAVGH02rck7RX+bjDfkLlS5Rtampg=;
        b=Hk9QYybo6YBfg0poqjqVdZXXbkBftR+JkORPuoaUDH0JvmJTLkX90+ICpNj+m10OYW
         wCwn3UlQ47nZV2tw9M6Sy8O3zzYAgTaBUmM9j8AXBWjxm8dMcIRkyqDYW1gQFAcbMkCY
         gQQye67ud8wI6fUpmWfI1qFqzvhgr5aTgSjq07C3lEYTMjME1DHt4jkygKB7QmG/1szq
         fsZmvqZ4dfx2dMyKFncLuVz0d7k8/wZ15d7tbqfw4B9VTo5pzhkHGrcN+OBdJ3SLvfse
         epIhxzDU0ziPK4RiryLKrvjqAKrlth8yzw/7S71s5dGWIp0ogg2B0ONORnRsPRbyWFXx
         wgWg==
X-Gm-Message-State: APjAAAVCtJiljaZUIOahH1U1lywL1YKB4kuxP4sCurk+ABI0jA1zVFRI
        38ed1ddttl8l4TWiwFBZne4=
X-Google-Smtp-Source: APXvYqwfmzYEgn0HuzDY1kNCGb4OQ2f9ez2/DWEx0EJhGAPQkqegEavMfQK/EBau3t+lFFtB+TeH+w==
X-Received: by 2002:a5d:5345:: with SMTP id t5mr28419050wrv.0.1575211790646;
        Sun, 01 Dec 2019 06:49:50 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id p9sm35707225wrs.55.2019.12.01.06.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2019 06:49:49 -0800 (PST)
Date:   Sun, 1 Dec 2019 15:49:47 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mceier@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        kernel test robot <rong.a.chen@intel.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: [PATCH] x86/pat: Fix off-by-one bugs in interval tree search
Message-ID: <20191201144947.GA4167@gmail.com>
References: <20191127005312.GD20422@shao2-debian>
 <CAJTyqKPstH9PYk1nMuRJWnXUPTf9wAkphPFi9Yfz6PApLVVE0Q@mail.gmail.com>
 <20191130212729.ykxstm5kj2p5ir6q@linux-p48b>
 <CAJTyqKOp+mV1CfpasschSDO4vEDbshE4GPCB6+aX4rJOYSF=7A@mail.gmail.com>
 <CAHk-=wh--xwpatv_Rcp3WtCPQtg-RVoXYQj8O+1TSw8os7Jtvw@mail.gmail.com>
 <20191201104624.GA51279@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191201104624.GA51279@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> * Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > But the final difference is a real difference where it used to be WC,
> > and is now UC-:
> > 
> >     -write-combining @ 0x2000000000-0x2100000000
> >     -write-combining @ 0x2000000000-0x2100000000
> >     +uncached-minus @ 0x2000000000-0x2100000000
> >     +uncached-minus @ 0x2000000000-0x2100000000
> > 
> > which certainly could easily explain the huge performance degradation.

> It's not an unconditional regression, as both Boris and me tried to 
> reproduce it on different systems that do ioremap_wc() as well and didn't 
> measure a slowdown, but something about the memory layout probably 
> triggers the tree management bug.

Ok, I think I found at least one bug in the new PAT code, the conversion 
of memtype_check_conflict() is buggy I think:

   8d04a5f97a5f: ("x86/mm/pat: Convert the PAT tree to a generic interval tree")

        dprintk("Overlap at 0x%Lx-0x%Lx\n", match->start, match->end);
        found_type = match->type;
 
-       node = rb_next(&match->rb);
-       while (node) {
-               match = rb_entry(node, struct memtype, rb);
-
-               if (match->start >= end) /* Checked all possible matches */
-                       goto success;
-
-               if (is_node_overlap(match, start, end) &&
-                   match->type != found_type) {
+       match = memtype_interval_iter_next(match, start, end);
+       while (match) {
+               if (match->type != found_type)
                        goto failure;
-               }
 
-               node = rb_next(&match->rb);
+               match = memtype_interval_iter_next(match, start, end);
        }


Note how the '>= end' condition to end the interval check, got converted 
into:

+       match = memtype_interval_iter_next(match, start, end);

This is subtly off by one, because the interval trees interfaces require 
closed interval parameters:

  include/linux/interval_tree_generic.h

 /*                                                                            \
  * Iterate over intervals intersecting [start;last]                           \
  *                                                                            \
  * Note that a node's interval intersects [start;last] iff:                   \
  *   Cond1: ITSTART(node) <= last                                             \
  * and                                                                        \
  *   Cond2: start <= ITLAST(node)                                             \
  */                                                                           \

  ...

                if (ITSTART(node) <= last) {            /* Cond1 */           \
                        if (start <= ITLAST(node))      /* Cond2 */           \
                                return node;    /* node is leftmost match */  \

[start;last] is a closed interval (note that '<= last' check) - while the 
PAT 'end' parameter is 1 byte beyond the end of the range, because 
ioremap() and the other mapping APIs usually use the [start,end) 
half-open interval, derived from 'size'.

This is what ioremap() does for example:

        /*
         * Mappings have to be page-aligned
         */
        offset = phys_addr & ~PAGE_MASK;
        phys_addr &= PHYSICAL_PAGE_MASK;
        size = PAGE_ALIGN(last_addr+1) - phys_addr;

        retval = reserve_memtype(phys_addr, (u64)phys_addr + size,
                                                pcm, &new_pcm);


phys_addr+size will be on a page boundary, after the last byte of the 
mapped interval.

So the correct parameter to use in the interval tree searches is not 
'end' but 'end-1'.

This could have relevance if conflicting PAT ranges are exactly adjacent, 
for example a future WC region is followed immediately by an already 
mapped UC- region - in this case memtype_check_conflict() would 
incorrectly deny the WC memtype region and downgrade the memtype to UC-.

BTW., rather annoyingly this downgrading is done silently in 
memtype_check_insert():

int memtype_check_insert(struct memtype *new,
                         enum page_cache_mode *ret_type)
{
        int err = 0;

        err = memtype_check_conflict(new->start, new->end, new->type, ret_type);
        if (err)
                return err;

        if (ret_type)
                new->type = *ret_type;

        memtype_interval_insert(new, &memtype_rbroot);
        return 0;
}


So on such a conflict we'd just silently get UC- in *ret_type, and write 
it into the new region, never the wiser ...

So assuming that the patch below fixes the primary bug the diagnostics 
side of ioremap() cache attribute downgrades would be another thing to 
fix.

Anyway, I checked all the interval-tree iterations, and most of them are 
off by one - but I think the one related to memtype_check_conflict() is 
the one causing this particular performance regression.

The only correct interval-tree searches were these two:

arch/x86/mm/pat_interval.c:     match = memtype_interval_iter_first(&memtype_rbroot, 0, ULONG_MAX);
arch/x86/mm/pat_interval.c:             match = memtype_interval_iter_next(match, 0, ULONG_MAX);

The ULONG_MAX was hiding the off-by-one in plain sight. :-)

So it would be nice if everyone who is seeing this bug could test the 
patch below against Linus's latest tree - does it fix the regression?

If not then please send the before/after dump of 
/sys/kernel/debug/x86/pat_memtype_list - and even if it works please send 
the dumps so we can double check it all.

Note that the bug was benign in the sense of implementing a too strict 
cache attribute conflict policy and downgrading cache attributes - so 
AFAICS the worst outcome of this bug would be a performance regression.

Patch is only lightly tested, so take care. (Patch is emphatically not 
signed off yet, because I spent most of the day on this and I don't yet 
trust my fix - all of the affected sites need to be reviewed more 
carefully.)

Thanks,

	Ingo


====================>
From: Ingo Molnar <mingo@kernel.org>
Date: Sun, 1 Dec 2019 15:25:50 +0100
Subject: [PATCH] x86/pat: Fix off-by-one bugs in interval tree search

NOT-Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pat_interval.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pat_interval.c b/arch/x86/mm/pat_interval.c
index 47a1bf30748f..6855362eaf21 100644
--- a/arch/x86/mm/pat_interval.c
+++ b/arch/x86/mm/pat_interval.c
@@ -56,7 +56,7 @@ static struct memtype *memtype_match(u64 start, u64 end, int match_type)
 {
 	struct memtype *match;
 
-	match = memtype_interval_iter_first(&memtype_rbroot, start, end);
+	match = memtype_interval_iter_first(&memtype_rbroot, start, end-1);
 	while (match != NULL && match->start < end) {
 		if ((match_type == MEMTYPE_EXACT_MATCH) &&
 		    (match->start == start) && (match->end == end))
@@ -66,7 +66,7 @@ static struct memtype *memtype_match(u64 start, u64 end, int match_type)
 		    (match->start < start) && (match->end == end))
 			return match;
 
-		match = memtype_interval_iter_next(match, start, end);
+		match = memtype_interval_iter_next(match, start, end-1);
 	}
 
 	return NULL; /* Returns NULL if there is no match */
@@ -79,7 +79,7 @@ static int memtype_check_conflict(u64 start, u64 end,
 	struct memtype *match;
 	enum page_cache_mode found_type = reqtype;
 
-	match = memtype_interval_iter_first(&memtype_rbroot, start, end);
+	match = memtype_interval_iter_first(&memtype_rbroot, start, end-1);
 	if (match == NULL)
 		goto success;
 
@@ -89,12 +89,12 @@ static int memtype_check_conflict(u64 start, u64 end,
 	dprintk("Overlap at 0x%Lx-0x%Lx\n", match->start, match->end);
 	found_type = match->type;
 
-	match = memtype_interval_iter_next(match, start, end);
+	match = memtype_interval_iter_next(match, start, end-1);
 	while (match) {
 		if (match->type != found_type)
 			goto failure;
 
-		match = memtype_interval_iter_next(match, start, end);
+		match = memtype_interval_iter_next(match, start, end-1);
 	}
 success:
 	if (newtype)
@@ -160,7 +160,7 @@ struct memtype *memtype_erase(u64 start, u64 end)
 struct memtype *memtype_lookup(u64 addr)
 {
 	return memtype_interval_iter_first(&memtype_rbroot, addr,
-					   addr + PAGE_SIZE);
+					   addr + PAGE_SIZE-1);
 }
 
 #if defined(CONFIG_DEBUG_FS)
