Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD1DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509D32467A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxfVe940"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfLJC2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:28:30 -0500
Received: from mail-il1-f181.google.com ([209.85.166.181]:39471 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfLJC22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:28:28 -0500
Received: by mail-il1-f181.google.com with SMTP id n1so185739ilm.6;
        Mon, 09 Dec 2019 18:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2hpIeNO/rrHxqmmLp7RAfiIu08DiGGroLpGDwIlCW7M=;
        b=YxfVe9409xO7A5aYrBrGlRbGsh3ogIpVMwfBvOJbUU1hOJuGCoXs6DuorJkBBeaV0n
         QqzdqSNv6ChBrX37YFBPycflHz7YtU389hoxCMOgre83Hbei1HFeFm9XtEfVRENaoVUd
         CpDYGjtTkLhsgi+8iY8JJP+xHWNgLZRDyuU0M6KOyG2SmcpO4Hz/rhFht1m4vPpk9Haw
         sdU3lBV5+Rfg/N30nqla35JFGaHQb0/ca+3klW0B9InhJKJe3sM1eeFSFwm6Un8M2V0C
         ktYaRgqIV7HVGfc+SkzvWHYKCz0vc7Xhja+Fwn33a6ebdU4k+2NKJJdYEpb7GcAaUtJW
         Dtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2hpIeNO/rrHxqmmLp7RAfiIu08DiGGroLpGDwIlCW7M=;
        b=CxLwwigdv5ousu1pgKV2ve+06rq09KaXHbs47USj0Oa9TfgSw7fvvMGSZpjJn8E27H
         C6HrKpIRW6aL13fJml4fQaNDesbezNsg+ImzpHAzz2OLuhuTscJl0u2qdzmWHxIX0PGY
         za9t0BflPy/YaaFA6XgC1mF23/jm/ohk1Qb4jw8k3zMqVDkBzmOHe3W3+pnQKxuRAHE6
         M+C1kDvjJP7U0kn81w0q0L8WnsnYKlPMQ3GhkV9EGQNwWH+jiKkDbK+tYWd34UX+7Z7p
         eT+AwbVlqK/ix8ch7n1ne1A5Pq2WIPQ7Vwlcosu7PgwJzXA4hYwbQct03ZWn43VIpErP
         dYNQ==
X-Gm-Message-State: APjAAAUHP2w2IlX3QtAUj+CissPRS4E//dWpSrIjWP8M2PnYWWzN34YW
        0Ck41K6mvymknUzzPU4L3UU=
X-Google-Smtp-Source: APXvYqzwVWp8IMBdFafor44ohxIbKVcdqcIfrBIyqNMllFu8rH/d3bjfi22FyqoCN3doitIt/93opw==
X-Received: by 2002:a92:7e90:: with SMTP id q16mr5399043ill.1.1575944907615;
        Mon, 09 Dec 2019 18:28:27 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l9sm334052ioh.77.2019.12.09.18.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 18:28:27 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v4 15/16] dyndbg: allow negating flag-chars in modflags
Date:   Mon,  9 Dec 2019 19:27:41 -0700
Message-Id: <20191210022742.822686-16-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210022742.822686-1-jim.cromie@gmail.com>
References: <20191210022742.822686-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend flags modifications to allow [PFMLTU] inverted flags.
This allows control-queries like:

  #> Q () { echo file inode.c $* > control } # to type less
  #> Q -P	# same as +p
  #> Q +U	# same as -u
  #> Q u-P	# same as u+p

This allows flags in a callsite to be simultaneously set and cleared,
while still starting with the current flagstate (with +- ops).
Generally, you chose -p or +p 1st, then set or clear flags
accordingly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 10 ++++++----
 lib/dynamic_debug.c                               |  6 ++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 9f68062ba316..5c170e49121d 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -249,9 +249,11 @@ only callsites with ``u`` and ``f`` cleared.
 
 Flagsets cannot contain ``pP`` etc, a flag cannot be true and false.
 
-modflags containing upper-case flags is reserved/undefined for now.
-inverted-flags are currently ignored, usage gets trickier if given
-``-pXy``, it should leave x set.
+modflags may contain upper-case flags also, using these lets you
+invert the flag setting implied by the OP; '-pU' means disable
+printing, and mark that callsite with the user-flag to create a group,
+for optional further manipulation.  Generally, '+p' and '-p' is your
+main choice, and use of negating flags in modflags is rare.
 
 Notes::
 
@@ -261,7 +263,7 @@ For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only
 For display, the flags are preceded by ``=``
 (mnemonic: what the flags are currently equal to).
 
-Note the regexp ``^[-+=][flmptu_]+$`` matches a flags specification.
+Note the regexp ``/^[-+=][flmptu_]+$/i`` matches a flags specification.
 To clear all flags at once, use ``=_`` or ``-flmptu``.
 
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 736895efe17d..15bb9939df97 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -486,15 +486,17 @@ static int ddebug_parse_flags(const char *str,
 
 	/* calculate final mods: flags, mask based upon op */
 	switch (op) {
+		unsigned int tmp;
 	case '=':
 		mods->mask = 0;
 		break;
 	case '+':
-		mods->mask = ~0U;
+		mods->mask = ~mods->mask;
 		break;
 	case '-':
+		tmp = mods->mask;
 		mods->mask = ~mods->flags;
-		mods->flags = 0;
+		mods->flags = tmp;
 		break;
 	}
 
-- 
2.23.0

