Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929DFC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680EC23898
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfKMQMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:12:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:56589 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfKMQMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:12:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 08:12:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,300,1569308400"; 
   d="scan'208";a="229792339"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by fmsmga004.fm.intel.com with ESMTP; 13 Nov 2019 08:12:20 -0800
Date:   Thu, 14 Nov 2019 00:12:20 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        "David S. Miller" <davem@davemloft.net>, Willy Tarreau <w@1wt.eu>,
        Yue Cao <ycao009@ucr.edu>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: Re: [LKP] [net] 19f92a030c: apachebench.requests_per_second -37.9%
 regression
Message-ID: <20191113161220.GE65640@shbuild999.sh.intel.com>
References: <20191108083513.GB29418@shao2-debian>
 <20191113103501.GD65640@shbuild999.sh.intel.com>
 <CANn89iLnzk5bGzSD5RHa6yuny6c_iaRBE4MfKhTqbTzeX_aZ6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLnzk5bGzSD5RHa6yuny6c_iaRBE4MfKhTqbTzeX_aZ6A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Wed, Nov 13, 2019 at 06:33:44AM -0800, Eric Dumazet wrote:
> On Wed, Nov 13, 2019 at 2:35 AM Feng Tang <feng.tang@intel.com> wrote:
> >
> > Hi Eric,
> >
> > On Fri, Nov 08, 2019 at 04:35:13PM +0800, kernel test robot wrote:
> > > Greeting,
> > >
> > > FYI, we noticed a -37.9% regression of apachebench.requests_per_second due to commit:
> > >
> > > commit: 19f92a030ca6d772ab44b22ee6a01378a8cb32d4 ("net: increase SOMAXCONN to 4096")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > Any thought on this? The test is actually:
> >
> >         sysctl -w net.ipv4.tcp_syncookies=0
> 
>
> I have no plan trying to understand why anyone would disable syncookies .
> This is a non starter really, since this makes a server vulnerable to
> a trivial DOS attack.
>

Thanks for the prompt response.

This sysctl change was added to work around one old error when
running the apachebench. The error was "apr_socket_recv: Connection
reset by peer (104)"

I just removed the sysctl setting of "ipv4.tcp_synccookies" and 
re-run the same benchmark in 0day, the regression is still there. 

Thanks,
Feng

> 
> Since the test changes a sysctl, you also can change other sysctls if
> you really need to show a ' number of transactions' for a particular
> benchmark.
> 
> The change on SOMAXCONN was driven by a security issue, and security
> comes first.
> 
> 
> >         enable_apache_mod auth_basic authn_core authn_file authz_core authz_host authz_user access_compat
> >         systemctl restart apache2
> >         ab -k -q -t 300 -n 1000000 -c 4000 127.0.0.1/
> >
> > And some info about apachebench result is:
> >
> > w/o patch:
> >
> >         Connection Times (ms)
> >                       min  mean[+/-sd] median   max
> >         Connect:        0    0  19.5      0    7145
> >         Processing:     0    4 110.0      3   21647
> >         Waiting:        0    2  92.4      1   21646
> >         Total:          0    4 121.1      3   24762
> >
> > w/ patch:
> >
> >         Connection Times (ms)
> >                       min  mean[+/-sd] median   max
> >         Connect:        0    0  43.2      0    7143
> >         Processing:     0   19 640.4      3   38708
> >         Waiting:        0   24 796.5      1   38708
> >         Total:          0   19 657.5      3   39725
> >
> >
> > Thanks,
> > Feng
> >
> > >
> > > in testcase: apachebench
> > > on test machine: 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz with 48G memory
> > > with following parameters:
> > >
> > >       runtime: 300s
> > >       concurrency: 4000
> > >       cluster: cs-localhost
> > >       cpufreq_governor: performance
> > >       ucode: 0x7000019
> > >
> > > test-description: apachebench is a tool for benchmarking your Apache Hypertext Transfer Protocol (HTTP) server.
> > > test-url: https://httpd.apache.org/docs/2.4/programs/ab.html
> > >
> > > In addition to that, the commit also has significant impact on the following tests:
> > >
> > > +------------------+------------------------------------------------------------------+
> > > | testcase: change | apachebench: apachebench.requests_per_second -37.5% regression   |
> > > | test machine     | 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz with 48G memory |
> > > | test parameters  | cluster=cs-localhost                                             |
> > > |                  | concurrency=8000                                                 |
> > > |                  | cpufreq_governor=performance                                     |
> > > |                  | runtime=300s                                                     |
> > > |                  | ucode=0x7000019                                                  |
> > > +------------------+------------------------------------------------------------------+
> > >
> > >
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > >
> > >
> > > Details are as below:
> > > -------------------------------------------------------------------------------------------------->
> > >
> > >
> > > To reproduce:
> > >
> > >         git clone https://github.com/intel/lkp-tests.git
> > >         cd lkp-tests
> > >         bin/lkp install job.yaml  # job file is attached in this email
> > >         bin/lkp run     job.yaml
> > >
> > > =========================================================================================
> > > cluster/compiler/concurrency/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/testcase/ucode:
> > >   cs-localhost/gcc-7/4000/performance/x86_64-rhel-7.6/debian-x86_64-2019-09-23.cgz/300s/lkp-bdw-de1/apachebench/0x7000019
> > >
> > > commit:
> > >   6d6f0383b6 ("netdevsim: Fix use-after-free during device dismantle")
> > >   19f92a030c ("net: increase SOMAXCONN to 4096")
> > >
> > > 6d6f0383b697f004 19f92a030ca6d772ab44b22ee6a
> > > ---------------- ---------------------------
> > >          %stddev     %change         %stddev
> > >              \          |                \
> > >      22640 ±  4%     +71.1%      38734        apachebench.connection_time.processing.max
> > >      24701           +60.9%      39743        apachebench.connection_time.total.max
> > >      22639 ±  4%     +71.1%      38734        apachebench.connection_time.waiting.max
> > >      24701        +15042.0       39743        apachebench.max_latency.100%
> > >      40454           -37.9%      25128        apachebench.requests_per_second
> > >      25.69           +58.8%      40.79        apachebench.time.elapsed_time
> > >      25.69           +58.8%      40.79        apachebench.time.elapsed_time.max
> > >      79.00           -37.0%      49.75        apachebench.time.percent_of_cpu_this_job_got
> > >      98.88           +61.0%     159.18        apachebench.time_per_request
> > >     434631           -37.9%     269889        apachebench.transfer_rate
> > >    1.5e+08 ± 18%    +109.5%  3.141e+08 ± 27%  cpuidle.C3.time
> > >     578957 ±  7%     +64.1%     949934 ± 12%  cpuidle.C3.usage
> > >      79085 ±  4%     +24.8%      98720        meminfo.AnonHugePages
> > >      41176           +14.2%      47013        meminfo.PageTables
> > >      69429           -34.9%      45222        meminfo.max_used_kB
> > >      63.48           +12.7       76.15        mpstat.cpu.all.idle%
> > >       2.42 ±  2%      -0.9        1.56        mpstat.cpu.all.soft%
> > >      15.30            -5.2       10.13        mpstat.cpu.all.sys%
> > >      18.80            -6.6       12.16        mpstat.cpu.all.usr%
> > >      65.00           +17.7%      76.50        vmstat.cpu.id
> > >      17.00           -35.3%      11.00        vmstat.cpu.us
> > >       7.00 ± 24%     -50.0%       3.50 ± 14%  vmstat.procs.r
> > >      62957           -33.3%      42012        vmstat.system.cs
> > >      33174            -1.4%      32693        vmstat.system.in
