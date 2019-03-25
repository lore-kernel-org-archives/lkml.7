Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486ECC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2242F20811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfCYVGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:06:23 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:41328 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYVGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:06:22 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2PL5wHn010870;
        Tue, 26 Mar 2019 06:05:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Tue, 26 Mar 2019 06:05:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126094122116.bbtec.net [126.94.122.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2PL5rJm010855
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 26 Mar 2019 06:05:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: Linux 5.1-rc2
To:     James Morris <jmorris@namei.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <CAHk-=wgg_PRWs3a6u2gnFLQjhxOJcrFkqqWVnLw60eQAwD-DNw@mail.gmail.com>
 <2d4f3bfa-22c7-a18c-3902-fe1b6ac401f7@infradead.org>
 <alpine.LRH.2.21.1903260607500.13529@namei.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <8811b2e4-28e1-2f01-024b-fb7d0196483f@i-love.sakura.ne.jp>
Date:   Tue, 26 Mar 2019 06:05:51 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1903260607500.13529@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/26 4:08, James Morris wrote:
> On Sun, 24 Mar 2019, Randy Dunlap wrote:
> 
>> On 3/24/19 2:26 PM, Linus Torvalds wrote:
>>> Well, we're a week away from the merge window close, and here's rc2.
>>> Things look fairly normal, but honestly, rc2 is usually too early to
>>> tell.  People haven't necessarily had time to notice problems yet.
>>> Which is just another way of saying "please test harder".
>>>
>>> Nothing particularly stands out. Yes, we had some fixes for the new
>>> io_ring code for issues that were discussed when merging it. Other
>>> than that, worth noting is that the bulk of the patches are for
>>> tooling, not the core kernel. In fact, about two thirds of the patch
>>> is just for the tools/ subdirectory, most of it due to some late perf
>>> tool updates. The people involved promise they're done.
>>
>> Hmph.  I'm still looking for the patch that restores the various
>> CONFIG_DEFAULT_<security> kconfig options to be merged.
>>
>> https://lore.kernel.org/linux-security-module/2bf23acd-22c4-a260-7648-845887a409d5@i-love.sakura.ne.jp/
>>
>> since commit 70b62c25665f636c9f6c700b26af7df296b0887e dropped them somehow.
> 
> AFAICT we don't have a finalized version of the patch yet.
> 
> Kees?
> 

As far as I can tell, Kees's comment

  It breaks the backward-compat for the "security=" line. If a system is
  booted with CONFIG_LSM="minors...,apparmor" and "security=selinux",
  neither apparmor nor selinux will be initialized. The logic on
  "security=..." depends on the other LSMs being present in the list.

was just a confusion, and I think that this version can become
the finalized version.

From 72f5f21b800c87f9ec3600f6e3acfb654690d8f0 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Tue, 26 Mar 2019 05:56:30 +0900
Subject: [PATCH] LSM: Revive CONFIG_DEFAULT_SECURITY_* for "make oldconfig"

Commit 70b62c25665f636c ("LoadPin: Initialize as ordered LSM") removed
CONFIG_DEFAULT_SECURITY_{SELINUX,SMACK,TOMOYO,APPARMOR,DAC} from
security/Kconfig and changed CONFIG_LSM to provide a fixed ordering as a
default value. That commit expected that existing users (upgrading from
Linux 5.0 and earlier) will edit CONFIG_LSM value in accordance with
their CONFIG_DEFAULT_SECURITY_* choice in their old kernel configs. But
since users might forget to edit CONFIG_LSM value, this patch revives
the choice (only for providing the default value for CONFIG_LSM) in order
to make sure that CONFIG_LSM reflects CONFIG_DEFAULT_SECURITY_* from their
old kernel configs.

Reported-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/Kconfig | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/security/Kconfig b/security/Kconfig
index 1d6463f..2f29805 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -239,9 +239,44 @@ source "security/safesetid/Kconfig"
 
 source "security/integrity/Kconfig"
 
+choice
+	prompt "Default security module [superseded by 'Ordered list of enabled LSMs' below]"
+	default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
+	default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
+	default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
+	default DEFAULT_SECURITY_APPARMOR if SECURITY_APPARMOR
+	default DEFAULT_SECURITY_DAC
+
+	help
+	  This choice is there only for converting CONFIG_DEFAULT_SECURITY in old
+	  kernel config to CONFIG_LSM in new kernel config. Don't change this choice
+	  unless you are creating a fresh kernel config, for this choice will be
+	  ignored after CONFIG_LSM is once defined.
+
+	config DEFAULT_SECURITY_SELINUX
+		bool "SELinux" if SECURITY_SELINUX=y
+
+	config DEFAULT_SECURITY_SMACK
+		bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
+
+	config DEFAULT_SECURITY_TOMOYO
+		bool "TOMOYO" if SECURITY_TOMOYO=y
+
+	config DEFAULT_SECURITY_APPARMOR
+		bool "AppArmor" if SECURITY_APPARMOR=y
+
+	config DEFAULT_SECURITY_DAC
+		bool "Unix Discretionary Access Controls"
+
+endchoice
+
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
+	default "yama,loadpin,safesetid,integrity,selinux" if DEFAULT_SECURITY_SELINUX
+	default "yama,loadpin,safesetid,integrity,smack" if DEFAULT_SECURITY_SMACK
+	default "yama,loadpin,safesetid,integrity,tomoyo" if DEFAULT_SECURITY_TOMOYO
+	default "yama,loadpin,safesetid,integrity,apparmor" if DEFAULT_SECURITY_APPARMOR
+	default "yama,loadpin,safesetid,integrity"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
-- 
1.8.3.1
