Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14206C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72522075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aw7SYKnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfECT2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 15:28:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40547 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfECT2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 15:28:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id d15so6155180ljc.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 12:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7NdnaxSYEwFqQM1A2dvIwgo6CZE7Yr86uKlcHuY6AlE=;
        b=Aw7SYKnVa73yaHvboYicKd3rAYDUGCaqOTofJyY26kY981TiuCNb2Z/RFyI/CTOX+7
         lMzNzbS1IO6yoFz7FWXXsjbpQdeQZsqL03/ZjDk5QygJnwk+yzNPQ26m6C+sn7CzPgI9
         Po+aDIsejRHuA9Sz+EEThT0dvr7JBrzBj5D7sVOZR9zRc6rp35WxqsSbd95+ej9k/yBp
         NS4rwr86UTHHIIvaDt3Pi2+zFAf1xB57cBRcUK5h2i0zUb+1YIMrmlEr8ulTAmpJYvhT
         kg/tT8mSSL/jQ7ECQgKywOOgy0RdjXdIdL7R/aYn4ZScjq1aZT+DgaNzTnaA06TDJqBd
         /cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7NdnaxSYEwFqQM1A2dvIwgo6CZE7Yr86uKlcHuY6AlE=;
        b=e1Atxn2UElnj8x2iIurIBYdYubWrj1XVQ7utmntQnmrCK4Peki5+aKK8vDpNLxwwpz
         aMpS1La0GzAWdDNABWyFvJvkNDB0/1D0VR2I+V+iR/0T+rKAtd5+N8h5Azm5MvSRFuJR
         iYpRA+JgaXUQFKk3v+TAbZ7QrkvyPCOPh50Qx/rpSOKeEWgPdQ+5ziHqjTSPA+e61t4z
         VKJTmDFzXeKuPN+7SJUrnj4Iib3fWvWWBIvV+6Y1xvhemeYrAmoJSAOwQ6rC5PuL1dMp
         w2noPhPzTPqp57em3Cob1qMGaZJDARlIPetV093AH1IvqhWGMti3Wt397o6gaWo6rSoQ
         nPIA==
X-Gm-Message-State: APjAAAW60oZhkLZZx/qf02qoMSxWXbW9oQ9oXOF9H+PRkVj/PcRfsvxL
        kf8TMuIQ7vMSbhIjZBgXX6Ch2XY=
X-Google-Smtp-Source: APXvYqxzhBaC1coS99tgYfTL+0z3t8sQGSV0fTZ4SOS93HwXR4Zu0FV5NQW6U1FR5jNd76JNJfLWrA==
X-Received: by 2002:a2e:810d:: with SMTP id d13mr4853308ljg.93.1556911684905;
        Fri, 03 May 2019 12:28:04 -0700 (PDT)
Received: from avx2 ([46.53.252.190])
        by smtp.gmail.com with ESMTPSA id t8sm580950lfl.73.2019.05.03.12.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 12:28:04 -0700 (PDT)
Date:   Fri, 3 May 2019 22:28:00 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] signal: reorder struct sighand_struct
Message-ID: <20190503192800.GA18004@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct sighand_struct::siglock field is the most used field by far,
put it first so that is can be accessed without IMM8 or IMM32 encoding
on x86_64.

Space savings (on trimmed down VM test config):

add/remove: 0/0 grow/shrink: 8/68 up/down: 49/-1147 (-1098)
Function                                     old     new   delta
complete_signal                              512     533     +21
do_signalfd4                                 335     346     +11
__cleanup_sighand                             39      43      +4
unhandled_signal                              49      52      +3
prepare_signal                               692     695      +3
ignore_signals                                37      40      +3
__tty_check_change.part                      248     251      +3
ksys_unshare                                 780     781      +1
sighand_ctor                                  33      29      -4
ptrace_trap_notify                            60      56      -4
sigqueue_free                                 98      91      -7
run_posix_cpu_timers                        1389    1382      -7
proc_pid_status                             2448    2441      -7
proc_pid_limits                              344     337      -7
posix_cpu_timer_rearm                        222     215      -7
posix_cpu_timer_get                          249     242      -7
kill_pid_info_as_cred                        243     236      -7
freeze_task                                  197     190      -7
flush_old_exec                              1873    1866      -7
do_task_stat                                3363    3356      -7
do_send_sig_info                              98      91      -7
do_group_exit                                147     140      -7
init_sighand                                2088    2080      -8
do_notify_parent_cldstop                     399     391      -8
signalfd_cleanup                              50      41      -9
do_notify_parent                             557     545     -12
__send_signal                               1029    1017     -12
ptrace_stop                                  590     577     -13
get_signal                                  1576    1563     -13
__lock_task_sighand                          112      99     -13
zap_pid_ns_processes                         391     377     -14
update_rlimit_cpu                             78      64     -14
tty_signal_session_leader                    413     399     -14
tty_open_proc_set_tty                        149     135     -14
tty_jobctrl_ioctl                            936     922     -14
set_cpu_itimer                               339     325     -14
ptrace_resume                                226     212     -14
ptrace_notify                                110      96     -14
proc_clear_tty                                81      67     -14
posix_cpu_timer_del                          229     215     -14
kernel_sigaction                             156     142     -14
getrusage                                    977     963     -14
get_current_tty                               98      84     -14
force_sigsegv                                 89      75     -14
force_sig_info                               205     191     -14
flush_signals                                 83      69     -14
flush_itimer_signals                          85      71     -14
do_timer_create                             1120    1106     -14
do_sigpending                                 88      74     -14
do_signal_stop                               537     523     -14
cgroup_init_fs_context                       644     630     -14
call_usermodehelper_exec_async               402     388     -14
calculate_sigpending                          58      44     -14
__x64_sys_timer_delete                       248     234     -14
__set_current_blocked                         80      66     -14
__ptrace_unlink                              310     296     -14
__ptrace_detach.part                         187     173     -14
send_sigqueue                                362     347     -15
get_cpu_itimer                               214     199     -15
signalfd_poll                                175     159     -16
dequeue_signal                               340     323     -17
do_getitimer                                 192     174     -18
release_task.part                           1060    1040     -20
ptrace_peek_siginfo                          408     387     -21
posix_cpu_timer_set                          827     806     -21
exit_signals                                 437     416     -21
do_sigaction                                 541     520     -21
do_setitimer                                 485     464     -21
disassociate_ctty.part                       545     517     -28
__x64_sys_rt_sigtimedwait                    721     679     -42
__x64_sys_ptrace                            1319    1277     -42
ptrace_request                              1828    1782     -46
signalfd_read                                507     459     -48
wait_consider_task                          2027    1971     -56
do_coredump                                 3672    3616     -56
copy_process.part                           6936    6871     -65

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/sched/signal.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -15,10 +15,10 @@
  */
 
 struct sighand_struct {
-	refcount_t		count;
-	struct k_sigaction	action[_NSIG];
 	spinlock_t		siglock;
+	refcount_t		count;
 	wait_queue_head_t	signalfd_wqh;
+	struct k_sigaction	action[_NSIG];
 };
 
 /*
