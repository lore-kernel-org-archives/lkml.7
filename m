Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44CAC4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E1522472
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfJEQrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 12:47:05 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:45604 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725826AbfJEQrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 12:47:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 8EF2118224D7B;
        Sat,  5 Oct 2019 16:47:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: scent99_2ccc9c5de409
X-Filterd-Recvd-Size: 4354
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat,  5 Oct 2019 16:46:59 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>, x86@kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux@googlegroups.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 3/4] Documentation/process: Add fallthrough pseudo-keyword
Date:   Sat,  5 Oct 2019 09:46:43 -0700
Message-Id: <09a42c7275afa7e6e9e3fc57a15122201fccd6f7.1570292505.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1570292505.git.joe@perches.com>
References: <cover.1570292505.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe the fallthrough pseudo-keyword.

Convert the coding-style.rst example to the keyword style.
Add description and links to deprecated.rst.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/process/coding-style.rst |  2 +-
 Documentation/process/deprecated.rst   | 33 +++++++++++++++++++++++----------
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index f4a2198187f9..ada573b7d703 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -56,7 +56,7 @@ instead of ``double-indenting`` the ``case`` labels.  E.g.:
 	case 'K':
 	case 'k':
 		mem <<= 10;
-		/* fall through */
+		fallthrough;
 	default:
 		break;
 	}
diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 56280e108d5a..a0ffdc8daef3 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -122,14 +122,27 @@ memory adjacent to the stack (when built without `CONFIG_VMAP_STACK=y`)
 
 Implicit switch case fall-through
 ---------------------------------
-The C language allows switch cases to "fall through" when
-a "break" statement is missing at the end of a case. This,
-however, introduces ambiguity in the code, as it's not always
-clear if the missing break is intentional or a bug. As there
-have been a long list of flaws `due to missing "break" statements
+The C language allows switch cases to "fall-through" when a "break" statement
+is missing at the end of a case. This, however, introduces ambiguity in the
+code, as it's not always clear if the missing break is intentional or a bug.
+
+As there have been a long list of flaws `due to missing "break" statements
 <https://cwe.mitre.org/data/definitions/484.html>`_, we no longer allow
-"implicit fall-through". In order to identify an intentional fall-through
-case, we have adopted the marking used by static analyzers: a comment
-saying `/* Fall through */`. Once the C++17 `__attribute__((fallthrough))`
-is more widely handled by C compilers, static analyzers, and IDEs, we can
-switch to using that instead.
+"implicit fall-through".
+
+In order to identify intentional fall-through cases, we have adopted a
+pseudo-keyword macro 'fallthrough' which expands to gcc's extension
+__attribute__((__fallthrough__)).  `Statement Attributes
+<https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html>`_
+
+When the C17/C18  [[fallthrough]] syntax is more commonly supported by
+C compilers, static analyzers, and IDEs, we can switch to using that syntax
+for the macro pseudo-keyword.
+
+All switch/case blocks must end in one of:
+
+	break;
+	fallthrough;
+	continue;
+	goto <label>;
+	return [expression];
-- 
2.15.0

