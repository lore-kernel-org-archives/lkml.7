Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09448C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 01:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C073D208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 01:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="HfaBWEDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfEMBUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 21:20:25 -0400
Received: from sonic305-3.consmr.mail.bf2.yahoo.com ([74.6.133.42]:46720 "EHLO
        sonic305-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727131AbfEMBUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 21:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1557710422; bh=kmhcbfiUAPDcBNaPIgo8gEuwKeqhFA+LCiP83+sxgTg=; h=Date:From:Subject:To:Cc:From:Subject; b=HfaBWEDVcqfHssIjbJOfGi8sQT+nkHvPiT9GZAShc8nYefRyh9Hev0derFXlMhrR2QktghAxTgQ1hD5UnYtCLtU443sX8QbI8G3iYStPiV0c042Z8CWf6V0GR3DqqCcQRT7ye0h6Kbj/Kt/6tj76YRyIX6WrpLe/PLt3c/aAu5gedao5pzavy0EBeU0u7IP5g2PuQnwEKIkJZFupRn9ctcMxQ5jzpAoXN/XVC/xGecaxCAqP1zj9VWZ64DQWNGYwi55AtFozOsWx/jAnAzRSadKel/4F6JKF1fzWYA2svk8MLbqyU7UMTYP4gGW1KpN9Okr9TgNGS4DJheXQszg0bA==
X-YMail-OSG: iOu2uGIVM1knbRmq7g57uwvT6p0dEWonsZBuv.P48CJV_xjifZg_w0WTj.Gpj1f
 5DE43IgVVueovXOHw9b0.xBlUfEBHLMjIdivSjF.hxtG0yiY3989SXuPP01lXwcRuWNpR1QmgZ2N
 fANwCNjJH3jgId.C.pS.14TeL2yyeced3ujPyZTnwXDNoOaN6yMDWIhbb9DBKcfuaIdx1pdKUchL
 L.ichL5Rhb3GyzRHnWWZVfwsfLe3Qfu_kAue6Cg1EtzRVFJNoYx79EoX6btGMUu2mZ80.8rOiX3l
 AbG.JrcVJqXuM1kURgeBoG66Bt.HHFDiCQG6EWTDYBB5pRLSXHGBXOlj164RipYClMKTU1k.O_E9
 VBkQGipXRxO.S0Nl2Q9ODG8U68WosQik84GQ9A7piLeeJDdTuyM0.39a49rkN7mjpFUhQu9AwibI
 2zxHLdEkBDKMHCzmS6qToqoatg1W5ZLTNHI5WI3OtxHPAg0egSBwOnvViOunKLVfHEfqz.YbOHZs
 hUyJo3Gn1LLClfS5OK0IiSAJLd3l9yaZ8XDO4BnEgpEkGJduM.IRAtPty8iJDqfVF9BPjeLAQ4vz
 eKaq15OeeyRCoBNQoGWfG5jrz8iggxpU9fMajNgVI91PFU0dk8XDFdMVEE4bucczh7JTpFuPOZjN
 fyH4_IAgvd3fGYacIpSxweV3RVIi2nwnPeV0Z5chBFdWNsPis83HRArJb_EEq8MvxYWy7YSuMqxf
 TnLAueDeQDg7OGtzXvzi7OesIlrO5YCvtGCT1wahY3XvKvnzKc4DCVmf4lFAo74mhqjLYFCk3Tfg
 Sa2RKbbUTqhMoNLNl4D3dq0HoDLujoAPGAYuC5UvT0O5QBJR_Y9sHCL4PTCbvnJUs0EwD0W5dTuf
 TAEfz76QJesi9X0DzHdlGeJEQRkKEHEWMEIlnkErj871CdjZrzsk1D30TV9Er0240HHYcge0CCPv
 QijG8z.yZpX6fxjkUKbF8Ytu.A2vK4kue_CyhtScQtEbkF5y6j4u8MiXlKknXede3bbyA2Ho6Ufg
 iwfQdC2jj9jk98I65y4NfwLHVOdjrGKVggv0x8581W4QqK_SVfww63lBs.r10tX1IC3v3rIK2.21
 4v4Ba7i2.iZWFDBH9xRzmOtAlk1.HNpRkpHhy.VF4RGPDQBEBbMMtLY3zCg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Mon, 13 May 2019 01:20:22 +0000
Received: from CPE00fc8de26033-CM00fc8de26030.cpe.net.cable.rogers.com (EHLO localhost) ([99.228.156.240])
          by smtp406.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 10b57405150ea85529f4fce74da5bb61;
          Mon, 13 May 2019 01:20:18 +0000 (UTC)
Date:   Sun, 12 May 2019 21:20:12 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: [REGRESSION] ptrace broken from "cgroup: cgroup v2 freezer" (76f969e)
To:     linux-kernel@vger.kernel.org, tj@kernel.org, guro@fb.com
Cc:     oleg@redhat.com, kernel-team@fb.com
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1557709124.798rxdb4l3.astroid@alex-desktop.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was trying to use strace recently and found that it exhibited some=20
strange behavior. I produced this minimal test case:

#include <unistd.h>

int main() {
    write(1, "a", 1);
    return 0;
}

which, when run using "gcc test.c && strace ./a.out" produces this=20
strace output:

[ pre-main omitted ]
write(1, "a", 1)                        =3D ? ERESTARTSYS (To be restarted =
if SA_RESTART is set)
write(1, "a", 1)                        =3D ? ERESTARTSYS (To be restarted =
if SA_RESTART is set)
write(1, "a", 1)                        =3D ? ERESTARTSYS (To be restarted =
if SA_RESTART is set)
write(1, "a", 1)                        =3D ? ERESTARTSYS (To be restarted =
if SA_RESTART is set)
write(1, "a", 1)                        =3D ? ERESTARTSYS (To be restarted =
if SA_RESTART is set)
write(1, "a", 1)                        =3D ? ERESTARTSYS (To be restarted =
if SA_RESTART is set)
[ repeats forever ]

The correct result is of course:

[ pre-main omitted ]
write(1, "a", 1)                        =3D 1
exit_group(0)                           =3D ?
+++ exited with 0 +++

Strangely, this only occurs when outputting to a tty-like output.=20
Running "strace ./a.out" from a native Linux x86 console or a terminal=20
emulator causes the abnormal behavior. However, the following commands=20
work correctly:

- strace ./a.out >/dev/null
- strace ./a.out >/tmp/a # /tmp is a standard tmpfs
- strace ./a.out >&- # causes -1 EBADF (Bad file descriptor)

"strace -o /tmp/a ./a.out" hangs and produces the above (infinite)=20
output to /tmp/a.

I bisected this to 76f969e, "cgroup: cgroup v2 freezer". I reverted the=20
entire patchset (reverting only that one caused a conflict), which=20
resolved the issue. I skimmed the patch and came up with this=20
workaround, which also resolves the issue. I am not at all clear on the=20
technical workings of the patchset, but it seems to me like a process's=20
frozen status is supposed to be "suspended" when a frozen process is=20
ptraced, and "unsuspended" when ptracing ends. Therefore, it seems=20
suspicious to always "enter frozen" whether or not the cgroup is=20
actually frozen. It seems like the code should instead check if the=20
cgroup is actually frozen, and if so, restore the frozen status.

I am using systemd but not any other cgroup features. I tried in an=20
initramfs environment (no systemd, /init -> shell script) and reproduced=20
the failing test case.

Please CC me on replies.

Thanks,
Alex.

---
 kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 62f9aea4a15a..47145d9d89ca 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2110,7 +2110,7 @@ static void ptrace_stop(int exit_code, int why, int c=
lear_code, kernel_siginfo_t
                preempt_disable();
                read_unlock(&tasklist_lock);
                preempt_enable_no_resched();
-               cgroup_enter_frozen();
+               //cgroup_enter_frozen();
                freezable_schedule();
        } else {
                /*
@@ -2289,7 +2289,7 @@ static bool do_signal_stop(int signr)
                }
=20
                /* Now we don't run again until woken by SIGCONT or SIGKILL=
 */
-               cgroup_enter_frozen();
+               //cgroup_enter_frozen();
                freezable_schedule();
                return true;
        } else {
--=20
2.21.0
