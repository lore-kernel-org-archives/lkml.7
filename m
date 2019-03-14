Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744B8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA8120643
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfCNIj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:39:59 -0400
Received: from www62.your-server.de ([213.133.104.62]:48112 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfCNIj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:39:58 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h4Lto-0005Ex-QQ; Thu, 14 Mar 2019 09:39:36 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h4Lto-0000VZ-HL; Thu, 14 Mar 2019 09:39:36 +0100
Subject: Re: [LKP] [x86, retpolines] ce02ef06fc: will-it-scale.per_thread_ops
 3.1% improvement
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org, greg@kroah.com
References: <20190313052715.GB8429@shao2-debian>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <aa1de169-1c61-f8bc-10db-437f4e6ce6b3@iogearbox.net>
Date:   Thu, 14 Mar 2019 09:39:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190313052715.GB8429@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25387/Wed Mar 13 12:24:46 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/2019 06:27 AM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a 3.1% improvement of will-it-scale.per_thread_ops due to commit:
> 
> 
> commit: ce02ef06fcf7a399a6276adb83f37373d10cbbe1 ("x86, retpolines: Raise limit for generating indirect calls from switch-case")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: will-it-scale
> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory
> with following parameters:
> 
> 	nr_task: 100%
> 	mode: thread
> 	test: futex3
> 	cpufreq_governor: performance
> 	ucode: 0xb00002e
> 
> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale
> 
> In addition to that, the commit also has significant impact on the following tests:

Any thoughts on whether the above one-liner gcc work-around should be backported
to stable as well given these gains?

Thanks,
Daniel

> +------------------+---------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_process_ops 4.3% improvement             |
> | test machine     | 112 threads Intel(R) Xeon(R) Platinum 8170 CPU @ 2.10GHz with 128G memory |
> | test parameters  | cpufreq_governor=performance                                              |
> |                  | mode=process                                                              |
> |                  | nr_task=50%                                                               |
> |                  | test=futex3                                                               |
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_process_ops 2.5% improvement             |
> | test machine     | 112 threads Intel(R) Xeon(R) Platinum 8170 CPU @ 2.10GHz with 128G memory |
> | test parameters  | cpufreq_governor=performance                                              |
> |                  | mode=process                                                              |
> |                  | nr_task=50%                                                               |
> |                  | test=futex1                                                               |
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_process_ops 5.8% improvement             |
> | test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory      |
> | test parameters  | cpufreq_governor=performance                                              |
> |                  | mode=process                                                              |
> |                  | nr_task=50%                                                               |
> |                  | test=futex3                                                               |
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_process_ops 2.6% improvement             |
> | test machine     | 160 threads Intel(R) Xeon(R) CPU E7-8890 v4 @ 2.20GHz with 256G memory    |
> | test parameters  | cpufreq_governor=performance                                              |
> |                  | test=futex1                                                               |
> |                  | ucode=0xb00002e                                                           |
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_process_ops 2.5% improvement             |
> | test machine     | 112 threads Intel(R) Xeon(R) Platinum 8170 CPU @ 2.10GHz with 128G memory |
> | test parameters  | cpufreq_governor=performance                                              |
> |                  | mode=process                                                              |
> |                  | nr_task=50%                                                               |
> |                  | test=futex2                                                               |
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_thread_ops 3.1% improvement              |
> | test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory      |
> | test parameters  | cpufreq_governor=performance                                              |
> |                  | mode=thread                                                               |
> |                  | nr_task=50%                                                               |
> |                  | test=futex4                                                               |
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_thread_ops 5.4% improvement              |
> | test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory      |
> | test parameters  | cpufreq_governor=performance                                              |
> |                  | mode=thread                                                               |
> |                  | nr_task=16                                                                |
> |                  | test=futex3                                                               |
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_thread_ops 3.0% improvement              |
> | test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory      |
> | test parameters  | cpufreq_governor=performance                                              |
> |                  | mode=thread                                                               |
> |                  | nr_task=16                                                                |
> |                  | test=futex4                                                               |
> +------------------+---------------------------------------------------------------------------+
