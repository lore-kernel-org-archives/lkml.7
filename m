Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6CFC28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382D62799D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559497488;
	bh=r1svMKtWWEj8hbQmPKnP5QKzihPa74uFb4SeD/xsXA0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=jF5Vj2M41s2w6Lb7jx3biUbcYYxehgMgMAzileY3mMGpA/8p/Cmmybg4u+LR72t16
	 17WkHOzES1x6trHGVWSTVsadpE3AC/eRx05IBlp4aL+cF+Q0MD/MchNyn5jNQFzA4N
	 ACKdWNOT9zAuUYgWGPhB0vVa06BFHC9z+QGGAbrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfFBRor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 13:44:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34523 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFBRor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 13:44:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id e16so1510894wrn.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=r1J8a/RNCwMUi6bqaH9PxiQN6J6KPYnt+nuirbzJvhg=;
        b=TWsmvjKh381ZjYUKsK15ApL8U2uXKUOZzeB45ixb3foFEz+nkHNWPPbS5zVQMjuZqM
         Z508pODxWuRko0FWpjRISdDJphMAZxjhmO74bKTgSNIPogL16Xdsig4IUvlxBveUQILi
         215Pn4X+KJLGTnl20oGcE2d3eHSHWu4M8KPbXVyVDF35Y1c8kXK/O0ks40qo5NBOw8Bg
         6CMYVqkWLaAHmbmGZz98yyfle5QIxas6mY0LBe0BTq0iOTvwDT7vn3Cm32hoNxRRVYiV
         5UUxMYJD+WDz5UUKYh1JyKggha/oTT7aXtHbEdCHkHqFsPrrYx8NwyLKHEqSN0QzyHiF
         Ydzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=r1J8a/RNCwMUi6bqaH9PxiQN6J6KPYnt+nuirbzJvhg=;
        b=UAIMS3y6Xk+0uUeqcpWAckOgcaRjySzLVJqfkL3Brya3z3wr6k8IKrPWNL4+f8uv0R
         76qRZBCfdytxOsA9g/rWRi6UZntjbLwfDNGLLKbl38isZL869mi419cKL22SHYC6MrG9
         OieK7lesvMMVwsGjkrtzDQFhFTGZ8XBt3ledo5rv97uJSrXD02qA7JnN0l9isPfdHBgf
         SoCslMo2T7tBxgUE9FVphYtTjal52g8Y8xCyXXGHQbul0YIY7Z5Ihpaxl4qmjawq1/wU
         78XGVJeRF8bYCG7A95C5ACcpsjsTt1NSVyxtXybXtOCwUMesdptNM+hxHONJE+VKaDGn
         kAlQ==
X-Gm-Message-State: APjAAAWUy72GQ4ONHygwV7DxPRxF4ySt/R9+cKyqncSESPLmckNfL1HA
        UOprlf/yQgi9NlYhI64Yt4c=
X-Google-Smtp-Source: APXvYqxqaOJ8W2oiGeTHxjCMxv6/Flt8+B9R+GiVqW59bajTo/paM5Ud2S8BJoVWLa/cmuzZcwNjhA==
X-Received: by 2002:adf:e649:: with SMTP id b9mr13441808wrn.195.1559497485209;
        Sun, 02 Jun 2019 10:44:45 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q9sm15518773wmq.9.2019.06.02.10.44.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 10:44:44 -0700 (PDT)
Date:   Sun, 2 Jun 2019 19:44:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20190602174442.GA34993@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: 2ac44ab608705948564791ce1d15d43ba81a1e38 x86/CPU/AMD: Don't force the CPB cap when running under a hypervisor

Two fixes: a quirk for KVM guests running on certain AMD CPUs, and a 
KASAN related build fix.

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (1):
      x86/boot: Provide KASAN compatible aliases for string routines

Frank van der Linden (1):
      x86/CPU/AMD: Don't force the CPB cap when running under a hypervisor


 arch/x86/boot/compressed/string.c | 14 ++++++++++----
 arch/x86/kernel/cpu/amd.c         |  7 +++++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/string.c b/arch/x86/boot/compressed/string.c
index 19dbbcdd1a53..81fc1eaa3229 100644
--- a/arch/x86/boot/compressed/string.c
+++ b/arch/x86/boot/compressed/string.c
@@ -11,7 +11,7 @@
 #include "../string.c"
 
 #ifdef CONFIG_X86_32
-static void *__memcpy(void *dest, const void *src, size_t n)
+static void *____memcpy(void *dest, const void *src, size_t n)
 {
 	int d0, d1, d2;
 	asm volatile(
@@ -25,7 +25,7 @@ static void *__memcpy(void *dest, const void *src, size_t n)
 	return dest;
 }
 #else
-static void *__memcpy(void *dest, const void *src, size_t n)
+static void *____memcpy(void *dest, const void *src, size_t n)
 {
 	long d0, d1, d2;
 	asm volatile(
@@ -56,7 +56,7 @@ void *memmove(void *dest, const void *src, size_t n)
 	const unsigned char *s = src;
 
 	if (d <= s || d - s >= n)
-		return __memcpy(dest, src, n);
+		return ____memcpy(dest, src, n);
 
 	while (n-- > 0)
 		d[n] = s[n];
@@ -71,5 +71,11 @@ void *memcpy(void *dest, const void *src, size_t n)
 		warn("Avoiding potentially unsafe overlapping memcpy()!");
 		return memmove(dest, src, n);
 	}
-	return __memcpy(dest, src, n);
+	return ____memcpy(dest, src, n);
 }
+
+#ifdef CONFIG_KASAN
+extern void *__memset(void *s, int c, size_t n) __alias(memset);
+extern void *__memmove(void *dest, const void *src, size_t n) __alias(memmove);
+extern void *__memcpy(void *dest, const void *src, size_t n) __alias(memcpy);
+#endif
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 80a405c2048a..8d4e50428b68 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -824,8 +824,11 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
 {
 	set_cpu_cap(c, X86_FEATURE_ZEN);
 
-	/* Fix erratum 1076: CPB feature bit not being set in CPUID. */
-	if (!cpu_has(c, X86_FEATURE_CPB))
+	/*
+	 * Fix erratum 1076: CPB feature bit not being set in CPUID.
+	 * Always set it, except when running under a hypervisor.
+	 */
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && !cpu_has(c, X86_FEATURE_CPB))
 		set_cpu_cap(c, X86_FEATURE_CPB);
 }
 
