Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD2DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB4A2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbfB1LKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:10:31 -0500
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:59346 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730906AbfB1LKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:10:30 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id A28201C1D71
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 11:10:25 +0000 (GMT)
Received: (qmail 13883 invoked from network); 28 Feb 2019 11:10:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Feb 2019 11:10:25 -0000
Date:   Thu, 28 Feb 2019 11:10:23 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [LKP] [sched/fair]  2c83362734:  pft.faults_per_sec_per_cpu
 -41.4% regression
Message-ID: <20190228111023.GC9565@techsingularity.net>
References: <20190228071751.GE10770@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190228071751.GE10770@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 03:17:51PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -41.4% regression of pft.faults_per_sec_per_cpu due to commit:
> 
> 
> commit: 2c83362734dad8e48ccc0710b5cd2436a0323893 ("sched/fair: Consider SD_NUMA when selecting the most idle group to schedule on")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: pft
> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory
> with following parameters:
> 
> 	runtime: 300s
> 	nr_task: 50%
> 	cpufreq_governor: performance
> 	ucode: 0xb00002e
> 

The headline regression looks high but it's also a known consequence for
some microbenchmarks, particularly those that are short-lived and consist
of non-communicating tasks.

The impact of the patch is to favour starting a new task on the local
node unless the socket is saturated. This is to avoid a pattern where a
task that clones a helper that it communicates with starts on a remote
node. Starting remote negatively impacts basis workloads like
shellscripts, client/server workloads or pipelined tasks. The workloads
that benefit from spreading early are parallelised tasks that do not
communicate until end of the task.

PFT is an example of the latter. If spread early, it maximises the total
memory bandwidth of the machine early in the lifetime of the machine. It
would quickly recover if it run long enough, the early measurements are
low as it saturates the bandwidth of the local node. This configuration
is at 50% and the machine is likely to be 2-socket so it has half the
bandwidth in all likelihood and hence the 41.4% regression (very close
to half so some tasks probably got load-balanced).

On to the other examples;

> test-description: Pft is the page fault test micro benchmark.
> test-url: https://github.com/gormanm/pft
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+--------------------------------------------------------------------------+
> | testcase: change | stream:                                                                  |
> | test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory    |
> | test parameters  | array_size=10000000                                                      |
> |                  | cpufreq_governor=performance                                             |
> |                  | nr_threads=25%                                                           |
> |                  | omp=true                                                                 |
> |                  | ucode=0xb00002e                                                          |

STREAM is typically short-lived. Again, it benefits from spreading early
to maximise memory bandwidth. 25% of threads would fit in one node. For
parallelised stream tests it's usually the case that OMP is used to bind 1
thread per memory channel using the openmp directives to measure the total
machine memory bandwidth rather than using it as a scaling tests. I'm
guessing this machine didn't have 22 memory channels that would make
nr_thread=25% a sensible configuration.

> +------------------+--------------------------------------------------------------------------+
> | testcase: change | reaim: reaim.jobs_per_min 1.3% improvement                               |
> | test machine     | 72 threads Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz with 256G memory    |
> | test parameters  | cpufreq_governor=performance                                             |
> |                  | nr_job=3000                                                              |
> |                  | nr_task=100%                                                             |
> |                  | runtime=300s                                                             |
> |                  | test=custom                                                              |
> |                  | ucode=0x3d                                                               |

reaim is generally a mess so in this case it's unclear. The load is a
mix of task creation, IO operations, signal and others. It might have
benefitted slightly from running local. One reason I don't particularly
like reaim is that historically it was dominated by sending/receiving
signals. In my own tests, signal is typically removed as well as it's
tendency to sync the entire filesystem at high frequency.

> +------------------+--------------------------------------------------------------------------+
> | testcase: change | stream: stream.add_bandwidth_MBps -32.0% regression                      |
> | test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory    |
> | test parameters  | array_size=10000000                                                      |
> |                  | cpufreq_governor=performance                                             |
> |                  | nr_threads=50%                                                           |
> |                  | omp=true                                                                 |
> |                  | ucode=0xb00002e                                                          |

STREAM covered already other than noting that it's unlikely it has 44
memory channels to work with so any imbalance in the task distribution
should show up as a regression. Again, the patch favours using local node
first which would saturate the local memory channel earlier.

> +------------------+--------------------------------------------------------------------------+
> | testcase: change | plzip:                                                                   |
> | test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory    |
> | test parameters  | cpufreq_governor=performance                                             |
> |                  | nr_threads=100%                                                          |
> |                  | ucode=0xb00002e                                                          |

Doesn't state what change happened be it positive or negative.

> +------------------+--------------------------------------------------------------------------+
> | testcase: change | reaim: reaim.jobs_per_min -11.9% regression                              |
> | test machine     | 192 threads Intel(R) Xeon(R) CPU E7-8890 v4 @ 2.20GHz with 512G memory   |
> | test parameters  | cpufreq_governor=performance                                             |
> |                  | nr_task=100%                                                             |
> |                  | runtime=300s                                                             |
> |                  | test=all_utime                                                           |
> |                  | ucode=0xb00002e                                                          |

This is completely user-space bound running basic math operations. Not
clear why it would suffer *but* if hyperthreading is enabled, the patch
might mean that hyperthread siblings were used early due to favouring
the local node.

> +------------------+--------------------------------------------------------------------------+
> | testcase: change | hackbench: hackbench.throughput -7.3% regression                         |
> | test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory     |
> | test parameters  | cpufreq_governor=performance                                             |
> |                  | ipc=pipe                                                                 |
> |                  | mode=process                                                             |
> |                  | nr_threads=1600%                                                         |
> |                  | ucode=0xb00002e                                                          |

Hackbench very short-lived but the workload is also heavily saturating the
machine to an extent where it would be hard to tell from this report if
the 7.3% is statically significant or not. The patch might mean a socket
is severely over-saturated in the very early phases of the workload.

> +------------------+--------------------------------------------------------------------------+
> | testcase: change | reaim: reaim.std_dev_percent 11.4% undefined                             |
> | test machine     | 104 threads Intel(R) Xeon(R) Platinum 8170 CPU @ 2.10GHz with 64G memory |
> | test parameters  | cpufreq_governor=performance                                             |
> |                  | nr_task=100%                                                             |
> |                  | runtime=300s                                                             |
> |                  | test=custom                                                              |
> |                  | ucode=0x200004d                                                          |

Not sure what the change is saying. Possibly that it's less variable.

> +------------------+--------------------------------------------------------------------------+
> | testcase: change | reaim: boot-time.boot 95.3% regression                                   |
> | test machine     | 104 threads Intel(R) Xeon(R) Platinum 8170 CPU @ 2.10GHz with 64G memory |
> | test parameters  | cpufreq_governor=performance                                             |
> |                  | nr_task=100%                                                             |
> |                  | runtime=300s                                                             |
> |                  | test=alltests                                                            |
> |                  | ucode=0x200004d                                                          |

boot-time.boot?

> +------------------+--------------------------------------------------------------------------+
> | testcase: change | pft: pft.faults_per_sec_per_cpu -42.7% regression                        |
> | test machine     | 104 threads Intel(R) Xeon(R) Platinum 8170 CPU @ 2.10GHz with 64G memory |
> | test parameters  | cpufreq_governor=performance                                             |
> |                  | nr_task=50%                                                              |
> |                  | runtime=300s                                                             |
> |                  | ucode=0x200004d                                                          |

PFT already discussed.

> +------------------+--------------------------------------------------------------------------+
> | testcase: change | stream: stream.add_bandwidth_MBps -28.8% regression                      |
> | test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory    |
> | test parameters  | array_size=50000000                                                      |
> |                  | cpufreq_governor=performance                                             |
> |                  | nr_threads=50%                                                           |
> |                  | omp=true                                                                 |
> +------------------+--------------------------------------------------------------------------+
> | testcase: change | stream: stream.add_bandwidth_MBps -30.6% regression                      |
> | test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory    |
> | test parameters  | array_size=10000000                                                      |
> |                  | cpufreq_governor=performance                                             |
> |                  | nr_threads=50%                                                           |
> |                  | omp=true                                                                 |
> +------------------+--------------------------------------------------------------------------+
> | testcase: change | pft: pft.faults_per_sec_per_cpu -42.5% regression                        |
> | test machine     | 104 threads Intel(R) Xeon(R) Platinum 8170 CPU @ 2.10GHz with 64G memory |
> | test parameters  | cpufreq_governor=performance                                             |
> |                  | nr_task=50%                                                              |
> |                  | runtime=300s                                                             |

Already discussed.

> +------------------+--------------------------------------------------------------------------+
> | testcase: change | reaim: reaim.child_systime -1.4% undefined                               |
> | test machine     | 144 threads Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory   |
> | test parameters  | cpufreq_governor=performance                                             |
> |                  | iterations=30                                                            |
> |                  | nr_task=1600%                                                            |
> |                  | test=compute                                                             |

1.4% change in system time could be overhead in the fork phase as it
looks for local idle cores then remote idle cores early but the
difference is tiny.

> +------------------+--------------------------------------------------------------------------+
> | testcase: change | stress-ng: stress-ng.fifo.ops_per_sec 76.2% improvement                  |
> | test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory    |
> | test parameters  | class=pipe                                                               |
> |                  | cpufreq_governor=performance                                             |
> |                  | nr_threads=100%                                                          |
> |                  | testtime=1s                                                              |

A case where short-lived communicating tasks benefit by starting local.

> +------------------+--------------------------------------------------------------------------+
> | testcase: change | stress-ng: stress-ng.tsearch.ops_per_sec -17.1% regression               |
> | test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory    |
> | test parameters  | class=cpu                                                                |
> |                  | cpufreq_governor=performance                                             |
> |                  | nr_threads=100%                                                          |
> |                  | testtime=1s                                                              |
> +------------------+--------------------------------------------------------------------------+
> 

Given full machine utilisation and a 1 second duration, it's a case
where saturating the local node early was sub-optimal and 1 second is
too long for load balancing or other factors to correct it.

Bottom line, the patch is a trade off but from a range of tests, I found
that on balance we benefit more from having tasks start local until
there is evidence that the kernel is justified to spread the load to
remote nodes.

-- 
Mel Gorman
SUSE Labs
