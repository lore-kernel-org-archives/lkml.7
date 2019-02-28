Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FD1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6901821850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbfB1K6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:58:49 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:22499 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfB1K6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:58:48 -0500
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1SAwX8G023314;
        Thu, 28 Feb 2019 19:58:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Thu, 28 Feb 2019 19:58:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1SAwWTQ023309
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 28 Feb 2019 19:58:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: kernel panic: MAC Initialization failed.
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>
References: <0000000000001c63c80582e32294@google.com>
 <8d94063c-e10c-c470-8ce0-1f86c517b1b4@i-love.sakura.ne.jp>
 <CACT4Y+ZqjoXftDAby9s-YUrOv8txBFqKukRcxP6ty3LLKz_+Hw@mail.gmail.com>
 <722a3390-3112-0067-282c-b94a8be53aa0@i-love.sakura.ne.jp>
 <CACT4Y+aXA4fh9Z=vKKVi-vids4O_npkUDqccD1eUS+gNV7WyGA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ebfd7dae-d90a-059c-8ace-643c2228e7d0@i-love.sakura.ne.jp>
Date:   Thu, 28 Feb 2019 19:58:29 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aXA4fh9Z=vKKVi-vids4O_npkUDqccD1eUS+gNV7WyGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/02/28 19:23, Dmitry Vyukov wrote:
> On Thu, Feb 28, 2019 at 11:20 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> On 2019/02/28 15:51, Dmitry Vyukov wrote:
>>> On Wed, Feb 27, 2019 at 11:37 PM Tetsuo Handa
>>>>
>>>> Thank you. The LSM stacking seems to be working as expected.
>>>> But this one should not be considered as a bug.
>>>>
>>>> If something went wrong before loading access control rules,
>>>> it is pointless to continue. Thus, stopping with kernel panic.
>>>
>>> Hi Tetsuo,
>>>
>>> What misconfiguration you mean?
>>
>> To use security modules, access control rules need to be loaded. Regarding
>> TOMOYO, access control rules can be loaded from the kernel itself (built-in)
>> and/or from /etc/tomoyo/ directory via /sbin/tomoyo-init (run-time).
>>
>> Since the kernel is built without built-in policy and /sbin/tomoyo-init does
>> not exist, memory allocation failure is handled as a fatal problem.
>>
>> But if syzbot cannot test other paths due to hitting this path, we need to somehow
>> avoid panic(). Can you add tomoyo-tools package into your rootfs images? It is
>> explained at https://tomoyo.osdn.jp/2.6/chapter-3.html .
> 
> 
> Is installing the package everything that needs to be done? It's not a
> standard package, right?
> What does it do? Frequently there is like 3 DVD's of some software,
> but everything that needs to be done is a single system call? What
> exactly from kernel perspective we need to do?
> 

 From kernel perspective, just building the kernels with
CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER=y after doing

echo 'PROFILE_VERSION=20150505' > security/tomoyo/policy/profile.conf
echo '0-CONFIG={ mode=learning grant_log=no reject_log=yes }' >> security/tomoyo/policy/profile.conf

 from the kernel source tree is needed.

But the problem is that since syzbot is automated, there is no chance to
edit the content of security/tomoyo/policy/ directory when building the
kernels. Therefore, I expected that we can add tomoyo-tools package and
/etc/tomoyo/ directory generated by executing /usr/lib/tomoyo/init_policy
into the rootfs images. tomoyo-tools package is easy to install because of
little dependency (e.g. glibc and ncurses).

Maybe disabling panic() if CONFIG_FAULT_INJECTION=y is simpler...

diff --git a/security/tomoyo/memory.c b/security/tomoyo/memory.c
index 2e7fcfa..2b2d5898 100644
--- a/security/tomoyo/memory.c
+++ b/security/tomoyo/memory.c
@@ -24,7 +24,7 @@ void tomoyo_warn_oom(const char *function)
 		pr_warn("ERROR: Out of memory at %s.\n", function);
 		tomoyo_last_pid = pid;
 	}
-	if (!tomoyo_policy_loaded)
+	if (!IS_ENABLED(CONFIG_FAULT_INJECTION) && !tomoyo_policy_loaded)
 		panic("MAC Initialization failed.\n");
 }
 
