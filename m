Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8E1C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF8A205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfH3EpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 00:45:05 -0400
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:54796 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725774AbfH3EpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 00:45:05 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 7BBF318027675;
        Fri, 30 Aug 2019 04:45:03 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 80AE78368F12;
        Fri, 30 Aug 2019 04:45:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: skin65_2ba1ffce8e74c
X-Filterd-Recvd-Size: 8183
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Aug 2019 04:44:59 +0000 (UTC)
Message-ID: <f2d5b474411b2940d62198490f06e77890fbdb32.camel@perches.com>
Subject: Re: [PATCH v2] kunit: fix failure to build without printk
From:   Joe Perches <joe@perches.com>
To:     shuah <shuah@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Thu, 29 Aug 2019 21:44:58 -0700
In-Reply-To: <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
References: <20190828093143.163302-1-brendanhiggins@google.com>
         <20190828094929.GA14038@jagdpanzerIV>
         <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-29 at 11:01 -0600, shuah wrote:
> On 8/28/19 3:49 AM, Sergey Senozhatsky wrote:
> > On (08/28/19 02:31), Brendan Higgins wrote:
> > [..]
> > > Previously KUnit assumed that printk would always be present, which is
> > > not a valid assumption to make. Fix that by removing call to
> > > vprintk_emit, and calling printk directly.
> > > 
> > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
> > > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > 
> > [..]
> > 
> > > -static void kunit_vprintk(const struct kunit *test,
> > > -			  const char *level,
> > > -			  struct va_format *vaf)
> > > -{
> > > -	kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
> > > -}
> > 
> > This patch looks good to me. I like the removal of recursive
> > vsprintf() (%pV).
> > 
> > 	-ss
> > 
> 
> Hi Sergey,
> 
> What are the guidelines for using printk(). I recall some discussion
> about not using printk(). I am seeing the following from checkpatch
> script:
> 
> 
> WARNING: Prefer [subsystem eg: netdev]_level([subsystem]dev, ... then 
> dev_level(dev, ... then pr_level(...  to printk(KERN_LEVEL ...
> #105: FILE: include/kunit/test.h:343:
> +	printk(KERN_LEVEL "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
> 
> 
> Is there supposed to be pr_level() - I can find dev_level()
> 
> cc'ing Joe Perches for his feedback on this message recommending
> pr_level() which isn't in 5.3.

I don't care for pr_level or KERN_LEVEL in a printk.

I think this is somewhat overly complicated.

I think I'd write it like:
---
 include/kunit/test.h | 11 ++++-----
 kunit/test.c         | 69 ++++++++++++++++------------------------------------
 2 files changed, 26 insertions(+), 54 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 8b7eb03d4971..aa4abf0a22a5 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -339,9 +339,8 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
 
 void kunit_cleanup(struct kunit *test);
 
-void __printf(3, 4) kunit_printk(const char *level,
-				 const struct kunit *test,
-				 const char *fmt, ...);
+__printf(2, 3)
+void kunit_printk(const struct kunit *test, const char *fmt, ...);
 
 /**
  * kunit_info() - Prints an INFO level message associated with @test.
@@ -353,7 +352,7 @@ void __printf(3, 4) kunit_printk(const char *level,
  * Takes a variable number of format parameters just like printk().
  */
 #define kunit_info(test, fmt, ...) \
-	kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
+	kunit_printk(test, KERN_INFO fmt, ##__VA_ARGS__)
 
 /**
  * kunit_warn() - Prints a WARN level message associated with @test.
@@ -364,7 +363,7 @@ void __printf(3, 4) kunit_printk(const char *level,
  * Prints a warning level message.
  */
 #define kunit_warn(test, fmt, ...) \
-	kunit_printk(KERN_WARNING, test, fmt, ##__VA_ARGS__)
+	kunit_printk(test, KERN_WARNING fmt, ##__VA_ARGS__)
 
 /**
  * kunit_err() - Prints an ERROR level message associated with @test.
@@ -375,7 +374,7 @@ void __printf(3, 4) kunit_printk(const char *level,
  * Prints an error level message.
  */
 #define kunit_err(test, fmt, ...) \
-	kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
+	kunit_printk(test, KERN_ERR fmt, ##__VA_ARGS__)
 
 /**
  * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clarity.
diff --git a/kunit/test.c b/kunit/test.c
index b2ca9b94c353..ddb9bffb5a5d 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -16,40 +16,6 @@ static void kunit_set_failure(struct kunit *test)
 	WRITE_ONCE(test->success, false);
 }
 
-static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
-{
-	return vprintk_emit(0, level, NULL, 0, fmt, args);
-}
-
-static int kunit_printk_emit(int level, const char *fmt, ...)
-{
-	va_list args;
-	int ret;
-
-	va_start(args, fmt);
-	ret = kunit_vprintk_emit(level, fmt, args);
-	va_end(args);
-
-	return ret;
-}
-
-static void kunit_vprintk(const struct kunit *test,
-			  const char *level,
-			  struct va_format *vaf)
-{
-	kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
-}
-
-static void kunit_print_tap_version(void)
-{
-	static bool kunit_has_printed_tap_version;
-
-	if (!kunit_has_printed_tap_version) {
-		kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");
-		kunit_has_printed_tap_version = true;
-	}
-}
-
 static size_t kunit_test_cases_len(struct kunit_case *test_cases)
 {
 	struct kunit_case *test_case;
@@ -63,11 +29,9 @@ static size_t kunit_test_cases_len(struct kunit_case *test_cases)
 
 static void kunit_print_subtest_start(struct kunit_suite *suite)
 {
-	kunit_print_tap_version();
-	kunit_printk_emit(LOGLEVEL_INFO, "\t# Subtest: %s\n", suite->name);
-	kunit_printk_emit(LOGLEVEL_INFO,
-			  "\t1..%zd\n",
-			  kunit_test_cases_len(suite->test_cases));
+	pr_info_once("TAP version 14\n");
+	pr_info("\t# Subtest: %s\n", suite->name);
+	pr_info("\t1..%zd\n", kunit_test_cases_len(suite->test_cases));
 }
 
 static void kunit_print_ok_not_ok(bool should_indent,
@@ -87,9 +51,8 @@ static void kunit_print_ok_not_ok(bool should_indent,
 	else
 		ok_not_ok = "not ok";
 
-	kunit_printk_emit(LOGLEVEL_INFO,
-			  "%s%s %zd - %s\n",
-			  indent, ok_not_ok, test_number, description);
+	pr_info("%s%s %zd - %s\n",
+		indent, ok_not_ok, test_number, description);
 }
 
 static bool kunit_suite_has_succeeded(struct kunit_suite *suite)
@@ -133,11 +96,11 @@ static void kunit_print_string_stream(struct kunit *test,
 		kunit_err(test,
 			  "Could not allocate buffer, dumping stream:\n");
 		list_for_each_entry(fragment, &stream->fragments, node) {
-			kunit_err(test, fragment->fragment);
+			kunit_err(test, "%s", fragment->fragment);
 		}
 		kunit_err(test, "\n");
 	} else {
-		kunit_err(test, buf);
+		kunit_err(test, "%s", buf);
 		kunit_kfree(test, buf);
 	}
 }
@@ -505,19 +468,29 @@ void kunit_cleanup(struct kunit *test)
 	}
 }
 
-void kunit_printk(const char *level,
-		  const struct kunit *test,
-		  const char *fmt, ...)
+void kunit_printk(const struct kunit *test, const char *fmt, ...)
 {
+	char lvl[PRINTK_MAX_SINGLE_HEADER_LEN + 1] = "\0";
 	struct va_format vaf;
 	va_list args;
+	int kern_level;
 
 	va_start(args, fmt);
 
+	while ((kern_level = printk_get_level(fmt)) != 0) {
+		size_t size = printk_skip_level(fmt) - fmt;
+
+		if (kern_level >= '0' && kern_level <= '7') {
+			memcpy(lvl, fmt,  size);
+			lvl[size] = '\0';
+		}
+		fmt += size;
+	}
+
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	kunit_vprintk(test, level, &vaf);
+	printk("%s\t# %s %pV\n", lvl, test->name, &vaf);
 
 	va_end(args);
 }


