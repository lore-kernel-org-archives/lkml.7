Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC19C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFA520673
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lastninja.net header.i=@lastninja.net header.b="gyWT9H5i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C8aTVdD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfE0M0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:26:31 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47933 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbfE0M0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:26:31 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E0EEB2223B;
        Mon, 27 May 2019 08:26:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 27 May 2019 08:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lastninja.net;
         h=date:from:to:cc:subject:message-id:mime-version:content-type;
         s=fm3; bh=MQRdEUqHNON0d9+HEUek8+Hos4n56QXlf+ItsvjRdf8=; b=gyWT9
        H5ilXr8Dr9PWg3snHCL97F3PmlRcy2SDM3coRsnUw3Y61b4alosC2r50VreIl7nW
        ST7bGIF9Krjrp8VW6WR/4wemxGN/JSgcEXcOKHhI0CkkHZFxYQH/zR5ieDnRq5H4
        uYZL876TGKotqw2F0GMF30iBfK7wwn7CuciGKN4onq9mfRfOFuXZ3DVyQVBJe5e/
        5RXx0ziCAsWmR1RCUazhtHwzZSvbmzbMW4Bdp2zUQb+bDFYOIV9g4tf87jtXY8JZ
        Ub+mVvwJ6I+kG6+q+hzwraVA8CnsNvzV1X2ZZ2O2EzNjVJFw4uvwZS8gQMFgt7th
        PLP4rpoJLeXd3RMHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=MQRdEUqHNON0d9+HEUek8+Hos4n56
        QXlf+ItsvjRdf8=; b=C8aTVdD3cYCN1Qk64ou80w/wSz5oOUDUZMw1l4LDY8H/o
        ewTXim2Ub30A4yOEBeOmEg/r0sIULIkFgjBBX/idpgtX5JuNeiadYUuqdgPijJej
        Z1PcQGb+kHVUdQxgsTpNZ9bDb2TPzWakqHKNk3whRbEEB48cel0kuvpUCyXliNOg
        MIHNsts7Ax2P2YsNJ+bS+jSXmj4cSg7lApLIaR2W7HnY8VcoRkVJ/Ur0g379SRJS
        s8YrfsNfayXFFww1DAUggMM9JfENJIYSqoK5G7oxRaukSA5fPaBSq/HEgSW/Q+9Q
        uuOC1JmjfgUcnq7mL6cYa9UrDKbhtgmDSri+GMiZg==
X-ME-Sender: <xms:ddfrXIY7aDN9U5YkDxfj61CT0nDT46cTatu_60qTEdf2iUErKg8V6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddvvddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfggtggufgesthdtredttdervdenucfhrhhomheppfgrvhgvvghn
    ucfprghthhgrnhcuoehnrghvvggvnheslhgrshhtnhhinhhjrgdrnhgvtheqnecuffhomh
    grihhnpehfrggtthhorhgrsghlvgdrnhgvthenucfkphepudeihedrvddvrdegjedrudek
    geenucfrrghrrghmpehmrghilhhfrhhomhepnhgrvhgvvghnsehlrghsthhnihhnjhgrrd
    hnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ddfrXHqxiD2OpE7mKxixVvDfpC1SMAL9n1P1Ft1uw7ijRJziqbjuhw>
    <xmx:ddfrXN8Zyiz__mzmm1rEQ0NPkjzJGKeqrygli4GMAMVH9aU_FTTu9g>
    <xmx:ddfrXG9n3u8csF_TjTj-AZ618fo5SqDcUz2_DJ54dnGxNsTQze-nXg>
    <xmx:ddfrXNr4sGdlI6SJiBfknZem3sscAxMVCViInBlJbDNHwfbxx2_9rw>
Received: from u (unknown [165.22.47.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id 01EC5380088;
        Mon, 27 May 2019 08:26:29 -0400 (EDT)
Date:   Mon, 27 May 2019 12:26:28 +0000
From:   Naveen Nathan <naveen@lastninja.net>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kevin Easton <kevin@guarana.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] random: urandom reads block when CRNG is not initialized.
Message-ID: <20190527122627.GA15618@u>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a compile-time option to ensure urandom reads block until
the cryptographic random number generator (CRNG) is initialized.

This fixes a long standing security issue, the so called boot-time
entropy hole, where systems (particularly headless and embededd)
generate cryptographic keys before the CRNG has been iniitalised,
as exhibited in the work at https://factorable.net/.

This is deliberately a compile-time option without a corresponding
command line option to toggle urandom blocking behavior to prevent
system builders shooting themselves in the foot by
accidently/deliberately/maliciously toggling the option off in
production builds.

Signed-off-by: Naveen Nathan <naveen@lastninja.net>
---
 drivers/char/Kconfig  |  9 ++++++++
 drivers/char/random.c | 48 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 466ebd84ad17..9a09fdb37040 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -559,6 +559,15 @@ config ADI
 
 endmenu
 
+config ALWAYS_SECURE_URANDOM
+	bool "Ensure /dev/urandom always produces secure randomness"
+	default n
+	help
+	  Ensure reads to /dev/urandom block until Linux CRNG is initialized.
+	  All reads after initialization are non-blocking. This protects
+	  readers of /dev/urandom from receiving insecure randomness on cold
+	  start when the entropy pool isn't initially filled.
+
 config RANDOM_TRUST_CPU
 	bool "Trust the CPU manufacturer to initialize Linux's CRNG"
 	depends on X86 || S390 || PPC
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5d5ea4ce1442..c2bca7fbca5e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -473,6 +473,10 @@ static const struct poolinfo {
  */
 static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
 static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
+#if IS_ENABLED(CONFIG_ALWAYS_SECURE_URANDOM)
+static DECLARE_WAIT_QUEUE_HEAD(urandom_read_wait);
+static DECLARE_WAIT_QUEUE_HEAD(urandom_write_wait);
+#endif
 static struct fasync_struct *fasync;
 
 static DEFINE_SPINLOCK(random_ready_list_lock);
@@ -1966,15 +1970,23 @@ urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 	static int maxwarn = 10;
 	int ret;
 
-	if (!crng_ready() && maxwarn > 0) {
-		maxwarn--;
-		if (__ratelimit(&urandom_warning))
-			printk(KERN_NOTICE "random: %s: uninitialized "
-			       "urandom read (%zd bytes read)\n",
-			       current->comm, nbytes);
-		spin_lock_irqsave(&primary_crng.lock, flags);
-		crng_init_cnt = 0;
-		spin_unlock_irqrestore(&primary_crng.lock, flags);
+	if (!crng_ready()) {
+		if (IS_ENABLED(CONFIG_ALWAYS_SECURE_URANDOM)) {
+			if (file->f_flags & O_NONBLOCK)
+				return -EAGAIN;
+			ret = wait_for_random_bytes();
+			if (unlikely(ret))
+				return ret;
+		} else if (maxwarn > 0) {
+			maxwarn--;
+			if (__ratelimit(&urandom_warning))
+				pr_notice("random: %s: uninitialized "
+				       "urandom read (%zd bytes read)\n",
+				       current->comm, nbytes);
+			spin_lock_irqsave(&primary_crng.lock, flags);
+			crng_init_cnt = 0;
+			spin_unlock_irqrestore(&primary_crng.lock, flags);
+		}
 	}
 	nbytes = min_t(size_t, nbytes, INT_MAX >> (ENTROPY_SHIFT + 3));
 	ret = extract_crng_user(buf, nbytes);
@@ -1997,6 +2009,21 @@ random_poll(struct file *file, poll_table * wait)
 	return mask;
 }
 
+#if IS_ENABLED(CONFIG_ALWAYS_SECURE_URANDOM)
+static __poll_t
+urandom_poll(struct file *file, poll_table *wait)
+{
+	__poll_t mask;
+
+	poll_wait(file, &urandom_read_wait, wait);
+	poll_wait(file, &urandom_write_wait, wait);
+	mask = EPOLLOUT | EPOLLWRNORM;
+	if (crng_ready())
+		mask |= EPOLLIN | EPOLLRDNORM;
+	return mask;
+}
+#endif
+
 static int
 write_pool(struct entropy_store *r, const char __user *buffer, size_t count)
 {
@@ -2113,6 +2140,9 @@ const struct file_operations random_fops = {
 const struct file_operations urandom_fops = {
 	.read  = urandom_read,
 	.write = random_write,
+#if IS_ENABLED(CONFIG_ALWAYS_SECURE_URANDOM)
+	.poll  = urandom_poll,
+#endif
 	.unlocked_ioctl = random_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
-- 
2.17.1

