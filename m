Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2239DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 05:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFBB22CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 05:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbcVpjSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392207AbfHWFyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 01:54:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43536 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391107AbfHWFyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 01:54:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so4922297pld.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 22:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JYdrN38S9pX3Kt9OGrfP0UvkETjqHCTHg0XMyDRyZNQ=;
        b=dbcVpjSe7xpnGlmxkpq5IYldl1pNnNIsHkRme5HUQFKj0okbjeM6mpWLOd4U1umoXV
         t9Qu+IMNo32To8nF+LKWaQYDun8zTh60bN08JA6GgBAGExlHEkmz/3ND63hHDzSuDXOH
         Ij5uL+Sopn92OmeJxfqc8DVSN8GGQiyMAAjZBfJpCrplI9LVy//j1+qGUaH32r1L8KXD
         TwzWfMO7GrCTqINI2VzGg0sG6zCnetQ4mFjON1WZiIK0iR2g39ognR5aZKF0TtcfXq8k
         hVN9xf+WRWRUud5xHf2o2pt7knBu0Z97+0ZjeaS76k2pfmfCl4eBGBKeeqTknaoNESqv
         WiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JYdrN38S9pX3Kt9OGrfP0UvkETjqHCTHg0XMyDRyZNQ=;
        b=GOjSvd/T+Eo09i4NJTHS3fwETp3elT3816RIZQjGcSpgK6lGvWtnfHWVUG5A0OxQq7
         eZ82Wxf6Fkwm9JMAD9ZVyk9800F8YtuD8tBkxZU4NMsnlqewt6eD/XTWs1Hxh+x2ROMo
         K0M+Q0y32AvVVEPdjKdO4P9MVtd8rrxDI016psFAPKiLEfsxedo9zC/zGykO2tSKtfEA
         CmlsLLrbBrDR+Ql4CsJc7kEHFPlRNuhXF+yXUlnJO29WAaOjUG7sRCpwvTYc8LLbnQza
         028MVYhloCcXqpNfTTnd6ptw0Qd97gzRClBWRCXasrcu7kVz99aC4G6Pc50Cg+8OOqMg
         lpvg==
X-Gm-Message-State: APjAAAX79kmEXAEChflNAv9CkJCsWfPh03Q6A4mhkSAsexhGFJoC8sbi
        JG+MeRUquF3IdcLGdS0VDmg=
X-Google-Smtp-Source: APXvYqxLa1zifNW17S3xYcmqoD1YLKHPN6jPFlUWMA7esSpguKvCD+bSAw6uIEfVEJuUVZeswU11UA==
X-Received: by 2002:a17:902:1e8:: with SMTP id b95mr2820490plb.28.1566539690463;
        Thu, 22 Aug 2019 22:54:50 -0700 (PDT)
Received: from localhost ([110.70.58.156])
        by smtp.gmail.com with ESMTPSA id i124sm1370403pfe.61.2019.08.22.22.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 22:54:49 -0700 (PDT)
Date:   Fri, 23 Aug 2019 14:54:45 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: comments style: Re: [RFC PATCH v4 1/9] printk-rb: add a new
 printk ringbuffer implementation
Message-ID: <20190823055445.GA7195@jagdpanzerIV>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190820085554.deuejmxn4kbqnq7n@pathway.suse.cz>
 <20190820092731.GA14137@jagdpanzerIV>
 <87a7c3f4uj.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7c3f4uj.fsf@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/21/19 07:46), John Ogness wrote:
[..]
> The labels are necessary for the technical documentation of the
> barriers. And, after spending much time in this, I find them very
> useful. But I agree that there needs to be a better way to assign label
> names.
[..]
> > Where dp stands for descriptor push. For dataring we can add a 'dr'
> > prefix, to avoid confusion with desc barriers, which have 'd' prefix.
> > And so on. Dunno.
> 
> Yeah, I spent a lot of time going in circles on this one.
[..]
> I hope that we can agree that the labels are important. And that a
> formal documentation of the barriers is also important. Yes, they are a
> lot of work, but I find it makes it a lot easier to go back to the code
> after I've been away for a while. Even now, as I go through your
> feedback on code that I wrote over a month ago, I find the formal
> comments critical to quickly understand _exactly_ why the memory
> barriers exist.

Yeah. I like those tagsi/labels, and appreciate your efforts.

Speaking about it in general, not necessarily related to printk patch set.
With or without labels/tags we still have to grep. But grep-ing is much
easier when we have labels/tags. Otherwise it's sometimes hard to understand
what to grep for - _acquire, _relaxed, smp barrier, write_once, or
anything else.

> Perhaps we should choose labels that are more clear, like:
> 
>     dataring_push:A
>     dataring_push:B
> 
> Then we would see comments like:
> 
>     Memory barrier involvement:
> 
>     If _dataring_pop:B reads from dataring_datablock_setid:A, then
>     _dataring_pop:C reads from dataring_push:G.
[..]
>     RELEASE from dataring_push:E to dataring_datablock_setid:A
>        matching
>     ACQUIRE from _dataring_pop:B to _dataring_pop:E

I thought about it. That's very informative, albeit pretty hard to maintain.
The same applies to drA or prA and any other context dependent prefix.

> But then how should the labels in the code look? Just the letter looks
> simple in code, but cannot be grepped.

Yes, good point.

>     dataring_push()
>     {
>         ...
>         /* E */
>         ...
>     }

If only there was something as cool as grep-ing, but cooler. Something
that "just sucks less". Something that even folks like myself could use.

Bare with me.

Apologies. This email is rather long; but it's pretty easy to read.
Let's see if this can fly.

So what I did.

I changed several LMM tags/labels definitions, so they have common format:

			LMM_TAG(name)

I don't insist on this particular naming scheme, it can be improved.

======================================================================
diff --git a/kernel/printk/dataring.c b/kernel/printk/dataring.c
index e48069dc27bc..54eb28d47d30 100644
--- a/kernel/printk/dataring.c
+++ b/kernel/printk/dataring.c
@@ -577,11 +577,11 @@ char *dataring_push(struct dataring *dr, unsigned long size,
 	to_db_size(&size);
 
 	do {
-		/* fA: */
+		/* LMM_TAG(fA) */
 		ret = get_new_lpos(dr, size, &begin_lpos, &next_lpos);
 
 		/*
-		 * fB:
+		 * LMM_TAG(fB)
 		 *
 		 * The data ringbuffer tail may have been pushed (by this or
 		 * any other task). The updated @tail_lpos must be visible to
@@ -621,7 +621,7 @@ char *dataring_push(struct dataring *dr, unsigned long size,
 
 		if (!ret) {
 			/*
-			 * fC:
+			 * LMM_TAG(fC)
 			 *
 			 * Force @desc permanently invalid to minimize risk
 			 * of the descriptor later unexpectedly being
@@ -631,14 +631,14 @@ char *dataring_push(struct dataring *dr, unsigned long size,
 			dataring_desc_init(desc);
 			return NULL;
 		}
-	/* fE: */
+	/* LMM_TAG(fE) */
 	} while (atomic_long_cmpxchg_relaxed(&dr->head_lpos, begin_lpos,
 					     next_lpos) != begin_lpos);
 
 	db = to_datablock(dr, begin_lpos);
 
 	/*
-	 * fF:
+	 * LMM_TAG(fF)
 	 *
 	 * @db->id is a garbage value and could possibly match the @id. This
 	 * would be a problem because the data block would be considered
@@ -648,7 +648,7 @@ char *dataring_push(struct dataring *dr, unsigned long size,
 	WRITE_ONCE(db->id, id - 1);
 
 	/*
-	 * fG:
+	 * LMM_TAG(fG)
 	 *
 	 * Ensure that @db->id is initialized to a wrong ID value before
 	 * setting @begin_lpos so that there is no risk of accidentally
@@ -668,7 +668,7 @@ char *dataring_push(struct dataring *dr, unsigned long size,
 	 */
 	smp_store_release(&desc->begin_lpos, begin_lpos);
 
-	/* fH: */
+	/* LMM_TAG(fH) */
 	WRITE_ONCE(desc->next_lpos, next_lpos);
 
 	/* If this data block wraps, use @data from the content data block. */
diff --git a/kernel/printk/numlist.c b/kernel/printk/numlist.c
index 16c6ffa74b01..285e0431dbf8 100644
--- a/kernel/printk/numlist.c
+++ b/kernel/printk/numlist.c
@@ -338,7 +338,7 @@ struct nl_node *numlist_pop(struct numlist *nl)
 	tail_id = atomic_long_read(&nl->tail_id);
 
 	for (;;) {
-		/* cB */
+		/* LMM_TAG(cB) */
 		while (!numlist_read(nl, tail_id, NULL, &next_id)) {
 			/*
 			 * @tail_id is invalid. Try again with an
@@ -357,6 +357,7 @@ struct nl_node *numlist_pop(struct numlist *nl)
 
 		/*
 		 * cC:
+		 * LMM_TAG(cD)
 		 *
 		 * Make sure the node is not busy.
 		 */
@@ -368,7 +369,7 @@ struct nl_node *numlist_pop(struct numlist *nl)
 		if (r == tail_id)
 			break;
 
-		/* cA: #3 */
+		/* LMM_TAG(cA) #3 */
 		tail_id = r;
 	}
 
======================================================================



Okay.
Next, I added the following simple quick-n-dirty perl script:

======================================================================
Subject: [PATCH] add LMM_TAG parser

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 scripts/ctags-parse-lmm.pl | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100755 scripts/ctags-parse-lmm.pl

diff --git a/scripts/ctags-parse-lmm.pl b/scripts/ctags-parse-lmm.pl
new file mode 100755
index 000000000000..785f6945c936
--- /dev/null
+++ b/scripts/ctags-parse-lmm.pl
@@ -0,0 +1,45 @@
+#!/usr/bin/perl
+#
+# SPDX-License-Identifier: GPL-2.0
+#
+# Parse Linux Memory Model tags and add corresponding entries to the ctags file
+#
+# LMM Über Alles!
+
+use strict;
+
+sub parse($$)
+{
+	my ($t, $f) = @_;
+	my $ctags;
+	my $file;
+
+	if (!open($ctags, '>>', $t)) {
+		print "Could not open $t: $!\n";
+		exit 1;
+	}
+
+	if (!open($file, '<', $f)) {
+		print "Could not open $f: $1\n";
+		exit 1;
+	}
+
+	while (my $row = <$file>) {
+		chomp $row;
+
+		if ($row =~ m/LMM_TAG\((.+)\)/) {
+			# yup...
+			print $ctags "$1\t$f\t/LMM_TAG($1)/;\"\td\n";
+		}
+	}
+	close($file);
+	close($ctags);
+}
+
+if ($#ARGV != 1) {
+	print "Usage:\n\tscripts/ctags-parse-lmm.pl tags C-file-to-parse\n";
+	exit 1;
+}
+
+parse($ARGV[0], $ARGV[1]);
+exit 0;
-- 
2.23.0
======================================================================




The next thing I did was

	./scripts/ctags-parse-lmm.pl ./tags kernel/printk/dataring.c
	./scripts/ctags-parse-lmm.pl ./tags kernel/printk/numlist.c
	./scripts/ctags-parse-lmm.pl ./tags kernel/printk/ringbuffer.c

These 3 commands added the following entries to the tags file
(I'm using ctags and vim)

======================================================================
$ tail tags
fA	kernel/printk/dataring.c	/LMM_TAG(fA)/;"	d
fB	kernel/printk/dataring.c	/LMM_TAG(fB)/;"	d
fC	kernel/printk/dataring.c	/LMM_TAG(fC)/;"	d
fE	kernel/printk/dataring.c	/LMM_TAG(fE)/;"	d
fF	kernel/printk/dataring.c	/LMM_TAG(fF)/;"	d
fG	kernel/printk/dataring.c	/LMM_TAG(fG)/;"	d
fH	kernel/printk/dataring.c	/LMM_TAG(fH)/;"	d
cB	kernel/printk/numlist.c	/LMM_TAG(cB)/;"	d
cD	kernel/printk/numlist.c	/LMM_TAG(cD)/;"	d
cA	kernel/printk/numlist.c	/LMM_TAG(cA)/;"	d
======================================================================


So now when I perform LMM tag search or jump to a tag definition, vim
goes exactly to the line where the corresponding LMM_TAG was defined.

Example:

kernel/printk/ringbuffer.c

        RELEASE from jA->cD->hA to jB	
                         ^
                         C-]                    // jump to tag under cursor

vim goes to kernel/printk/numlist.c

360			* LMM_TAG(cD)
				  ^

Exactly where cD was defined.

Welcome to the future!


> Andrea suggested that the documentation should be within the code, which
> I think is a good idea. Even if it means we have more comments than
> code.

I agree that such documentation is handy. It, probably, would be even better
if we could use some tooling to make it easier to use.

	-ss
