Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B8DC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A960C20850
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eVX3GU65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfEJMIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 08:08:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38020 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfEJMIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 08:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Xbd/XHZ9vV9GKgybvwEJORwb1R/x23yrxcHmqZFuFSk=; b=eVX3GU65h9zVukfNoyNmn3v9K
        KotJYDXOxzZ511Yfekoc4rVIcG5Npyn59dxY0XoNZweoVB2c1qaWOn7eYnOZxziQNaDxzZYL6uSaa
        gVNfmAJrYg0hKkkL7WykYpvBauAO/xeLHAAK3rpzJD8SgJccYXVkv2uGIkBHIt+0Uql2COYPkhKFr
        FNa0Rlj65cJf4JNiIJJX5qIbT8FRM5ruRjcnfQ1YN4RPF9lAFrRwlf/19cZTpb/I0IVFnu9qxatoB
        R3iln6KQ8db/rbIHJHSjhNEq+hL+YI7X0Bdn5SMa0a6fH8C65286/AsFJ7B1uXvdZSKSIo0CXZlT+
        ykwYsXEcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hP4K5-0005RE-Fp; Fri, 10 May 2019 12:08:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 925702029FA15; Fri, 10 May 2019 14:08:19 +0200 (CEST)
Date:   Fri, 10 May 2019 14:08:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        andrea.parri@amarulasolutions.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>, joelaf@google.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Question about sched_setaffinity()
Message-ID: <20190510120819.GR2589@hirez.programming.kicks-ass.net>
References: <20190427180246.GA15502@linux.ibm.com>
 <20190430100318.GP2623@hirez.programming.kicks-ass.net>
 <20190430105129.GA3923@linux.ibm.com>
 <20190430115551.GT2623@hirez.programming.kicks-ass.net>
 <20190501191213.GX3923@linux.ibm.com>
 <20190501151655.51469a4c@gandalf.local.home>
 <20190501202713.GY3923@linux.ibm.com>
 <20190507221613.GA11057@linux.ibm.com>
 <20190509173654.GA23530@linux.ibm.com>
 <20190509193625.GA12455@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509193625.GA12455@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 12:36:25PM -0700, Paul E. McKenney wrote:
> I forward-ported the relevant patches from -rcu and placed them on -rcu
> branch peterz.2019.05.09a, and this is what produced the output above.
> 
> Any other debugging thoughts?
> 
> Or, if you wish, you can reproduce by running the following:
> 
> nohup tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 2 --configs "TRIVIAL" --bootargs "trace_event=sched:sched_switch,sched:sched_wakeup ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop" --kconfig "CONFIG_FUNCTION_TRACER=y CONFIG_FUNCTION_GRAPH_TRACER=y"
> 
> This gets me the following summary output:
> 
>  --- Thu May  9 12:08:31 PDT 2019 Test summary:
>  Results directory: /home/git/linux-2.6-tip/tools/testing/selftests/rcutorture/res/2019.05.09-12:08:31
>  tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 2 --configs TRIVIAL --bootargs trace_event=sched:sched_switch,sched:sched_wakeup ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop --kconfig CONFIG_FUNCTION_TRACER=y CONFIG_FUNCTION_GRAPH_TRACER=y
>  TRIVIAL ------- 2177 GPs (18.1417/s) [trivial: g0 f0x0 ]
>  :CONFIG_HOTPLUG_CPU: improperly set
>  WARNING: BAD SEQ 2176:2176 last:2177 version 4
>      /home/git/linux-2.6-tip/tools/testing/selftests/rcutorture/res/2019.05.09-12:08:31/TRIVIAL/console.log
>      WARNING: Assertion failure in /home/git/linux-2.6-tip/tools/testing/selftests/rcutorture/res/2019.05.09-12:08:31/TRIVIAL/console.log
>      WARNING: Summary: Warnings: 1 Bugs: 1 Call Traces: 5 Stalls: 8

So I could reproduce...

I must first complain about your scripts; it does "make mrproper" on the
source tree every time you run it, this is not appreciated. For one, it
deletes my 'tags' file.

Getting it to not rebuild the whole kernel every time wasn't easy
either.

Aside from that it seems to 'work'.

The below trace explain the issue. Some Paul person did it, see below.
It's broken per construction :-)

$ rm -rf tools/testing/selftests/rcutorture/res/ ; tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 2 --configs "TRIVIAL" --bootargs "trace_event=sched:sched_switch,sched:sched_wakeup,sched:sched_migrate_task ftrace=function_graph ftrace_graph_filter=set_cpus_allowed_ptr,migration_cpu_stop" --kconfig "CONFIG_FUNCTION_TRACER=y CONFIG_FUNCTION_GRAPH_TRACER=y" --kmake-arg "-j8" --datestamp "ponies"



[  210.222389]  4)               |      /* __set_cpus_allowed_ptr: (A) current: 4 new_mask: 5 valid: 0-7 */
[  210.223205]  4)               |      do_set_cpus_allowed() {
[  210.224203]  4)               |        dequeue_task_fair() {
[  210.224678]  4)               |          update_curr() {
[  210.226504]  4)   0.119 us    |            __calc_delta();
[  210.227999]  4)   0.138 us    |            update_min_vruntime();
[  210.229617]  4)   0.122 us    |            cpuacct_charge();
[  210.230435]  4)   0.833 us    |          }
[  210.230822]  4)   0.131 us    |          __update_load_avg_se();
[  210.231892]  4)   0.124 us    |          __update_load_avg_cfs_rq();
[  210.233000]  4)   0.119 us    |          clear_buddies();
[  210.233498]  4)   0.133 us    |          account_entity_dequeue();
[  210.237359]  4)   0.113 us    |          update_cfs_group();
[  210.238355]  4)   2.260 us    |        }
[  210.239055]  4)               |        put_prev_task_fair() {
[  210.239521]  4)   0.119 us    |          put_prev_entity();
[  210.240847]  4)   0.336 us    |        }
[  210.241668]  4)   0.115 us    |        set_cpus_allowed_common();
[  210.243608]  4)               |        enqueue_task_fair() {
[  210.244564]  4)   0.125 us    |          update_curr();
[  210.247119]  4)   0.112 us    |          __update_load_avg_se();
[  210.248608]  4)   0.119 us    |          __update_load_avg_cfs_rq();
[  210.249789]  4)   0.111 us    |          update_cfs_group();
[  210.251499]  4)   0.127 us    |          account_entity_enqueue();
[  210.252704]  4)   0.116 us    |          __enqueue_entity();
[  210.254331]  4)   1.542 us    |        }
[  210.255703]  4)               |        set_curr_task_fair() {
[  210.256275]  4)               |          set_next_entity() {
[  210.257310]  4)   0.112 us    |            __update_load_avg_se();
[  210.258681]  4)   0.112 us    |            __update_load_avg_cfs_rq();
[  210.260781]  4)   0.565 us    |          }
[  210.262182]  4)   0.874 us    |        }
[  210.263485]  4)   5.843 us    |      }
[  210.266251]  4)               |      /* __set_cpus_allowed_ptr: (B) current: 5 new_mask: 5 valid: 0-7 */
[  210.267390]  4)               |      /* __set_cpus_allowed_ptr: (C) 5 */
[  210.269895]  4)   0.121 us    |      _raw_spin_unlock_irqrestore();
[  210.271482]  4)               |      stop_one_cpu() {
[  210.272518]  4)               |        cpu_stop_init_done() {
[  210.273052]  4)   0.110 us    |          __init_waitqueue_head();
[  210.274140]  4)   0.328 us    |        }
[  210.274936]  4)               |        cpu_stop_queue_work() {
[  210.275953]  4)   0.112 us    |          _raw_spin_lock_irqsave();
[  210.276970]  4)   0.116 us    |          wake_q_add();
[  210.278301]  4)   0.114 us    |          _raw_spin_unlock_irqrestore();
[  210.279405]  4)               |          wake_up_q() {
[  210.280276]  4)               |            try_to_wake_up() {
[  210.280751]  4)   0.195 us    |              _raw_spin_lock_irqsave();
[  210.282486]  4)   0.112 us    |              _raw_spin_lock();
[  210.283454]  4)   0.118 us    |              update_rq_clock.part.81();
[  210.285104]  4)               |              ttwu_do_activate.isra.85() {
[  210.286408]  4)               |                activate_task() {
[  210.288275]  4)   0.123 us    |                  enqueue_task_stop();
[  210.290128]  4)   0.348 us    |                }
[  210.290567]  4)               |                ttwu_do_wakeup.isra.84() {
[  210.291220]  4)               |                  check_preempt_curr() {
[  210.292790]  4)   0.113 us    |                    resched_curr();
[  210.293903]  4)   0.351 us    |                  }
[  210.295273]  4)               |                  /* sched_wakeup: comm=migration/4 pid=29 prio=0 target_cpu=004 */
[  210.297661]  4)   0.731 us    |                }
[  210.299030]  4)   1.392 us    |              }
[  210.300365]  4)   0.141 us    |              _raw_spin_unlock_irqrestore();
[  210.302745]  4)   2.625 us    |            }
[  210.304702]  4)   2.867 us    |          }
[  210.306291]  4)   3.753 us    |        }
[  210.306914]  4)               |        _cond_resched() {
[  210.307508]  4)               |          rcu_note_context_switch() {
[  210.309684]  4)   0.111 us    |            rcu_qs();
[  210.311011]  4)   0.328 us    |          }
[  210.312819]  4)   0.113 us    |          _raw_spin_lock();
[  210.314061]  4)               |          pick_next_task_stop() {
[  210.315791]  4)               |            put_prev_task_fair() {
[  210.316399]  4)               |              put_prev_entity() {
[  210.318532]  4)               |                update_curr() {
[  210.319375]  4)   0.116 us    |                  __calc_delta();
[  210.320421]  4)   0.117 us    |                  update_min_vruntime();
[  210.321319]  4)   0.113 us    |                  cpuacct_charge();
[  210.322131]  4)   0.782 us    |                }
[  210.324157]  4)   0.124 us    |                __enqueue_entity();
[  210.325997]  4)   0.117 us    |                __update_load_avg_se();
[  210.326996]  4)   0.116 us    |                __update_load_avg_cfs_rq();
[  210.329194]  4)   1.732 us    |              }
[  210.329655]  4)   1.947 us    |            }
[  210.330669]  4)   2.175 us    |          }
[  210.331114]  4)               |          /* sched_switch: prev_comm=rcu_torture_fak prev_pid=126 prev_prio=139 prev_state=R+ ==> next_comm=migration/4 next_pid=29 next_prio=0 */
[  210.333252]  4)   0.111 us    |          enter_lazy_tlb();
[  210.335410]  4)  rcu_tor-126   =>   migrati-29

[  210.335410]  4)  rcu_tor-126   =>   migrati-29
[  210.335410]  4)               |  migration_cpu_stop() {
[  210.337537]  4)   0.114 us    |    sched_ttwu_pending();
[  210.338411]  4)               |    _raw_spin_lock() {
[  210.339466]  4) + 28.614 us   |      queued_spin_lock_slowpath();

[  209.701653]  0)  rcu_tor-132   =>  torture-136

[  210.330101]  0)               |  set_cpus_allowed_ptr() {
[  210.332653]  0)               |    __set_cpus_allowed_ptr() {
[  210.333800]  0)               |      task_rq_lock() {
[  210.334293]  0)   0.198 us    |        _raw_spin_lock_irqsave();
[  210.334899]  0)   0.199 us    |        _raw_spin_lock();
[  210.338041]  0)   0.904 us    |      }
[  210.338908]  0)   0.236 us    |      update_rq_clock.part.81();
[  210.340061]  0)               |      /* __set_cpus_allowed_ptr: (A) current: 5 new_mask: 0-3,5-7 valid: 0-7 */
[  210.341300]  0)               |      do_set_cpus_allowed() {
[  210.342067]  0)               |        dequeue_task_fair() {
[  210.342992]  0)   0.217 us    |          update_curr();
[  210.343637]  0)   0.203 us    |          __update_load_avg_se();
[  210.344315]  0)   0.203 us    |          __update_load_avg_cfs_rq();
[  210.345165]  0)   0.176 us    |          clear_buddies();
[  210.345777]  0)   0.173 us    |          account_entity_dequeue();
[  210.346627]  0)   0.182 us    |          update_cfs_group();
[  210.347306]  0)   2.468 us    |        }
[  210.347874]  0)   0.189 us    |        set_cpus_allowed_common();
[  210.348561]  0)               |        enqueue_task_fair() {
[  210.349148]  0)   0.189 us    |          update_curr();
[  210.349635]  0)   0.174 us    |          __update_load_avg_se();
[  210.350185]  0)   0.182 us    |          __update_load_avg_cfs_rq();
[  210.352091]  0)   0.178 us    |          update_cfs_group();
[  210.353542]  0)   0.178 us    |          account_entity_enqueue();
[  210.354159]  0)   0.194 us    |          __enqueue_entity();
[  210.355814]  0)   2.360 us    |        }
[  210.356572]  0)   5.746 us    |      }
[  210.357591]  0)               |      /* __set_cpus_allowed_ptr: (B) current: 0-3,5-7 new_mask: 0-3,5-7 valid: 0-7 */
[  210.358523]  0)               |      /* __set_cpus_allowed_ptr: (C) 0 */
[  210.359130]  0)               |      move_queued_task.isra.86() {
[  210.359674]  0)               |        dequeue_task_fair() {
[  210.360172]  0)   0.192 us    |          update_curr();
[  210.360627]  0)   0.180 us    |          __update_load_avg_se();
[  210.361174]  0)   0.194 us    |          __update_load_avg_cfs_rq();
[  210.363072]  0)   0.178 us    |          clear_buddies();
[  210.364838]  0)   0.179 us    |          account_entity_dequeue();
[  210.367303]  0)   0.183 us    |          update_cfs_group();
[  210.368270]  0)   0.194 us    |          update_min_vruntime();
[  210.369911]  0)   2.791 us    |        }
[  210.370890]  0)               |        set_task_cpu() {
[  210.371802]  0)               |          /* sched_migrate_task: comm=rcu_torture_fak pid=126 prio=139 orig_cpu=4 dest_cpu=0 */
[  210.374814]  0)               |          migrate_task_rq_fair() {
[  210.375862]  0)               |            detach_entity_cfs_rq() {
[  210.376380]  0)   0.208 us    |              __update_load_avg_se();
[  210.377900]  0)   0.180 us    |              __update_load_avg_cfs_rq();
[  210.382398]  0)   4.007 us    |            }
[  210.383005]  0)   4.360 us    |          }
[  210.384378]  0)   0.177 us    |          set_task_rq_fair();
[  210.385721]  0)   5.872 us    |        }
[  210.386970]  0)   0.182 us    |        _raw_spin_lock();
[  210.388990]  0)   0.189 us    |        update_rq_clock.part.81();
[  210.390491]  0)               |        enqueue_task_fair() {
[  210.391030]  0)               |          update_curr() {
[  210.391861]  0)   0.305 us    |            update_min_vruntime();
[  210.399184]  0)   0.190 us    |            cpuacct_charge();
[  210.400219]  0)   6.009 us    |          }
[  210.401182]  0)   0.182 us    |          __update_load_avg_cfs_rq();
[  210.402201]  0)   0.194 us    |          attach_entity_load_avg();
[  210.403180]  0)   0.169 us    |          update_cfs_group();
[  210.404647]  0)   0.173 us    |          account_entity_enqueue();
[  210.406043]  0)   0.261 us    |          __enqueue_entity();
[  210.407171]  0)   8.265 us    |        }
[  210.408609]  0)               |        check_preempt_curr() {
[  210.409712]  0)               |          check_preempt_wakeup() {
[  210.410576]  0)   0.179 us    |            update_curr();
[  210.411104]  0)   0.185 us    |            wakeup_preempt_entity.isra.93();
[  210.412454]  0)   0.890 us    |          }
[  210.412845]  0)   1.270 us    |        }
[  210.413888]  0) + 19.818 us   |      }
[  210.414968]  0)   0.182 us    |      _raw_spin_unlock_irqrestore();
[  210.417043]  0) + 30.113 us   |    }
[  210.418607]  0) + 30.451 us   |  }

This looks like:

  kernel/torture.c:torture_shuffle_tasks()

Written by some Paul McKenney person, I'd to ask him :-)


[  210.416420]  4) + 28.901 us   |    }
[  210.418122]  4)   0.153 us    |    _raw_spin_lock();
[  210.420277]  4)               |  /* migration_cpu_stop: this: 4 p: 0 dest: 5 on_rq: 1 */
[  210.422796]  4) + 29.893 us   |  }
[  210.430554]  4)               |  /* sched_switch: prev_comm=migration/4 prev_pid=29 prev_prio=0 prev_state=S ==> next_comm=swapper/4 next_pid=0 next_prio=120 */

[  210.857115]  0)   migrati-11   =>  rcu_tor-126
[  210.857115]  0)   0.184 us    |          finish_task_switch();
[  210.863058]  0) # 2749.563 us |        } /* _cond_resched */
[  210.863616]  0)               |        wait_for_completion() {
[  210.864157]  0)   0.171 us    |          _raw_spin_lock_irq();
[  210.866866]  0)   0.556 us    |        }
[  210.867759]  0) # 2755.063 us |      } /* stop_one_cpu */
[  210.868774]  0) # 2763.608 us |    } /* __set_cpus_allowed_ptr */
[  210.869873]  0) # 2763.873 us |  } /* set_cpus_allowed_ptr */
[  210.871830]  0)               |  /* On unexpected CPU 0, expected 5!!! */
[  210.873981]  0)               |  /* Online CPUs: 0-7  Active CPUs: 0-7 */
[  210.876291]  0)               |  /* ret = 0, ->cpus_allowed 0-3,5-7 */



---
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 4b58c907b4b7..f06f1cad68c5 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -451,6 +451,7 @@ void rcu_request_urgent_qs_task(struct task_struct *t);
 enum rcutorture_type {
 	RCU_FLAVOR,
 	RCU_TASKS_FLAVOR,
+	RCU_TRIVIAL_FLAVOR,
 	SRCU_FLAVOR,
 	INVALID_RCU_FLAVOR
 };
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index efaa5b3f4d3f..0952efa55247 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -670,6 +670,66 @@ static struct rcu_torture_ops tasks_ops = {
 	.name		= "tasks"
 };
 
+/*
+ * Definitions for trivial CONFIG_PREEMPT=n-only torture testing.
+ */
+
+static void synchronize_rcu_trivial(void)
+{
+	static int dont_trace;
+	int destcpu, cpu, ret;
+
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		if (!READ_ONCE(dont_trace))
+			tracing_on();
+
+		trace_printk("switching to CPU: %d\n", cpu);
+		ret = set_cpus_allowed_ptr(current, cpumask_of(cpu));
+		WARN_ONCE(ret, "%s: sched_setaffinity() returned %d\n", __func__, ret);
+
+		destcpu = raw_smp_processor_id();
+		if (destcpu == cpu) {
+			tracing_off();
+		} else {
+			trace_printk("On unexpected CPU %d, expected %d!!!\n", destcpu, cpu);
+			trace_printk("Online CPUs: %*pbl  Active CPUs: %*pbl\n", cpumask_pr_args(cpu_online_mask), cpumask_pr_args(cpu_active_mask));
+			trace_printk("ret = %d, ->cpus_allowed %*pbl\n", ret, cpumask_pr_args(&current->cpus_allowed));
+			tracing_stop();
+			WRITE_ONCE(dont_trace, 1);
+			WARN_ON_ONCE(1);
+			rcu_ftrace_dump(DUMP_ALL);
+		}
+	}
+	cpus_read_unlock();
+}
+
+static int rcu_torture_read_lock_trivial(void) __acquires(RCU)
+{
+	preempt_disable();
+	return 0;
+}
+
+static void rcu_torture_read_unlock_trivial(int idx) __releases(RCU)
+{
+	preempt_enable();
+}
+
+static struct rcu_torture_ops trivial_ops = {
+	.ttype		= RCU_TRIVIAL_FLAVOR,
+	.init		= rcu_sync_torture_init,
+	.readlock	= rcu_torture_read_lock_trivial,
+	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
+	.readunlock	= rcu_torture_read_unlock_trivial,
+	.get_gp_seq	= rcu_no_completed,
+	.sync		= synchronize_rcu_trivial,
+	.exp_sync	= synchronize_rcu_trivial,
+	.fqs		= NULL,
+	.stats		= NULL,
+	.irq_capable	= 1,
+	.name		= "trivial"
+};
+
 static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
 {
 	if (!cur_ops->gp_diff)
@@ -1765,6 +1825,8 @@ static void rcu_torture_fwd_prog_cr(void)
 
 	if (READ_ONCE(rcu_fwd_emergency_stop))
 		return; /* Get out of the way quickly, no GP wait! */
+	if (!cur_ops->call)
+		return; /* Can't do call_rcu() fwd prog without ->call. */
 
 	/* Loop continuously posting RCU callbacks. */
 	WRITE_ONCE(rcu_fwd_cb_nodelay, true);
@@ -2240,7 +2302,7 @@ rcu_torture_init(void)
 	int firsterr = 0;
 	static struct rcu_torture_ops *torture_ops[] = {
 		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops,
-		&busted_srcud_ops, &tasks_ops,
+		&busted_srcud_ops, &tasks_ops, &trivial_ops,
 	};
 
 	if (!torture_init_begin(torture_type, verbose))
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b4d88a594785..4b53f0ed4e45 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3375,6 +3375,7 @@ void __init rcu_init(void)
 	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_par_gp_wq);
 	srcu_init();
+	tracing_off();
 }
 
 #include "tree_stall.h"
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 102dfcf0a29a..5dd84ce34528 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -996,8 +996,10 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
 				 struct task_struct *p, int dest_cpu)
 {
 	/* Affinity changed (again). */
-	if (!is_cpu_allowed(p, dest_cpu))
+	if (!is_cpu_allowed(p, dest_cpu)) {
+		trace_printk("%s: !allowed\n", __func__);
 		return rq;
+	}
 
 	update_rq_clock(rq);
 	rq = move_queued_task(rq, rf, p, dest_cpu);
@@ -1031,6 +1033,10 @@ static int migration_cpu_stop(void *data)
 
 	raw_spin_lock(&p->pi_lock);
 	rq_lock(rq, &rf);
+
+	trace_printk("%s: this: %d p: %d dest: %d on_rq: %x\n", __func__,
+			rq->cpu, task_cpu(p), arg->dest_cpu, p->on_rq);
+
 	/*
 	 * If task_rq(p) != rq, it cannot be migrated here, because we're
 	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued because
@@ -1116,6 +1122,11 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		cpu_valid_mask = cpu_online_mask;
 	}
 
+	trace_printk("%s: (A) current: %*pbl new_mask: %*pbl valid: %*pbl\n", __func__,
+			cpumask_pr_args(&p->cpus_allowed),
+			cpumask_pr_args(new_mask),
+			cpumask_pr_args(cpu_valid_mask));
+
 	/*
 	 * Must re-check here, to close a race against __kthread_bind(),
 	 * sched_setaffinity() is not guaranteed to observe the flag.
@@ -1145,11 +1156,19 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 			p->nr_cpus_allowed != 1);
 	}
 
+	trace_printk("%s: (B) current: %*pbl new_mask: %*pbl valid: %*pbl\n", __func__,
+			cpumask_pr_args(&p->cpus_allowed),
+			cpumask_pr_args(new_mask),
+			cpumask_pr_args(cpu_valid_mask));
+
 	/* Can the task run on the task's current CPU? If so, we're done */
 	if (cpumask_test_cpu(task_cpu(p), new_mask))
 		goto out;
 
 	dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
+
+	trace_printk("%s: (C) %d\n", __func__, dest_cpu);
+
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
 		struct migration_arg arg = { p, dest_cpu };
 		/* Need help from migration thread: drop lock and wait. */
@@ -1591,8 +1610,13 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
 	 * [ this allows ->select_task() to simply return task_cpu(p) and
 	 *   not worry about this generic constraint ]
 	 */
-	if (unlikely(!is_cpu_allowed(p, cpu)))
+	if (unlikely(!is_cpu_allowed(p, cpu))) {
+		trace_printk("%s: (A) cpus_allowed: %*pbl nr_cpus_allowed: %d cpu: %d\n", __func__,
+				cpumask_pr_args(&p->cpus_allowed), p->nr_cpus_allowed, cpu);
 		cpu = select_fallback_rq(task_cpu(p), p);
+		trace_printk("%s: (B) cpus_allowed: %*pbl nr_cpus_allowed: %d cpu: %d\n", __func__,
+				cpumask_pr_args(&p->cpus_allowed), p->nr_cpus_allowed, cpu);
+	}
 
 	return cpu;
 }
diff --git a/tools/testing/selftests/rcutorture/bin/configinit.sh b/tools/testing/selftests/rcutorture/bin/configinit.sh
index 40359486b3a8..d53d7bf52c1d 100755
--- a/tools/testing/selftests/rcutorture/bin/configinit.sh
+++ b/tools/testing/selftests/rcutorture/bin/configinit.sh
@@ -45,8 +45,8 @@ sed -e 's/^\(CONFIG[0-9A-Z_]*\)=.*$/grep -v "^# \1" |/' < $c > $T/u.sh
 sed -e 's/^\(CONFIG[0-9A-Z_]*=\).*$/grep -v \1 |/' < $c >> $T/u.sh
 grep '^grep' < $T/u.sh > $T/upd.sh
 echo "cat - $c" >> $T/upd.sh
-make mrproper
-make $buildloc distclean > $resdir/Make.distclean 2>&1
+#make mrproper
+#make $buildloc distclean > $resdir/Make.distclean 2>&1
 make $buildloc $TORTURE_DEFCONFIG > $resdir/Make.defconfig.out 2>&1
 mv $builddir/.config $builddir/.config.sav
 sh $T/upd.sh < $builddir/.config.sav > $builddir/.config
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
new file mode 100644
index 000000000000..4d8eb5bfb6f6
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
@@ -0,0 +1,14 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=8
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_HOTPLUG_CPU=n
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL.boot b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL.boot
new file mode 100644
index 000000000000..cab2dc4a708c
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL.boot
@@ -0,0 +1,2 @@
+rcutorture.torture_type=trivial
+rcutorture.onoff_interval=0
