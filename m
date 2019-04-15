Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB48C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074662183F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="PVLOMYOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfDOQ75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:59:57 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42081 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfDOQ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:59:57 -0400
Received: by mail-qt1-f193.google.com with SMTP id p20so19931311qtc.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=B5wDF96ljXD7MeDicBsaVlV3xHRFod2qK1sMxjOR97k=;
        b=PVLOMYOQrQfdic7NCnK0nxC4HyVTQ9baMCSMxw7k0Pp0qbfbwVvTplUgi/e68T4/Xi
         ZQLygLHyHwqJ3Zx9eWaMjnuqlUS0mRKw9HZ+u0Rh82ymmdHjN90bj69LNWGONGWasF0k
         uI/fj5vN82cjx9bFwFVZqJuVMY2/mdAXtgYac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B5wDF96ljXD7MeDicBsaVlV3xHRFod2qK1sMxjOR97k=;
        b=WrNTNpDRBsFvu5H5Uk/gN8KX85M0m9Eb6xuuHtlOnPI3NmmQjz1TmPHlKdRjUR+i4G
         PIfFsJNDf0W16OuhnZuMSNH//XW7Ce+oHGt+zgulRkqxI3UfM/TEFxMJtr6BZuajVayl
         fD+vmI0d4qohzvY3EoP27hBGp6Eu76/JtbZCQFUUw2Kawc60HFVzJpKagOSgdKaKVcqf
         2QZ5eKPsMKGZoeOKjpu822P9l9WhQ56g8WMPsKxXvD2Ti6W0WPzbo1yGQxVryUwk6y3w
         3kr/Y360sugLoPKAqe2IXcCMg8KcqaAVlEe4cyVXFXwvSbHNXkCBQkGlNtTmoeMkgZxn
         gHaw==
X-Gm-Message-State: APjAAAXX7b3YvuoUreS6vJMsm4+lEO88Bc/meEm0fwdaR264su/f0lZQ
        w1nDHXsu8yfZ8mo7dGu0BlciPw==
X-Google-Smtp-Source: APXvYqyXv4RwxBJyUrDxvSLiHy8obaCC8IDVTSSkeUmsfp5Ysz4cLq/spJDhkl80/CMknnWELvOh8g==
X-Received: by 2002:ac8:29f8:: with SMTP id 53mr58856872qtt.71.1555347595350;
        Mon, 15 Apr 2019 09:59:55 -0700 (PDT)
Received: from sinkpad (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id w20sm25156152qkj.31.2019.04.15.09.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 09:59:53 -0700 (PDT)
Date:   Mon, 15 Apr 2019 12:59:37 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aubrey Li <aubrey.intel@gmail.com>
Subject: Re: [RFC][PATCH 13/16] sched: Add core wide task selection and
 scheduling.
Message-ID: <20190415165937.GA26890@sinkpad>
References: <20190218165620.383905466@infradead.org>
 <20190218173514.667598558@infradead.org>
 <20190402064612.GA46500@aaronlu>
 <20190402082812.GJ12232@hirez.programming.kicks-ass.net>
 <20190405145530.GA453@aaronlu>
 <460ce6fb-6a40-4a72-47e8-cf9c7c409bef@linux.intel.com>
 <20190410080630.GY11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190410080630.GY11158@hirez.programming.kicks-ass.net>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-Apr-2019 10:06:30 AM, Peter Zijlstra wrote:
> while you're all having fun playing with this, I've not yet had answers
> to the important questions of how L1TF complete we want to be and if all
> this crud actually matters one way or the other.
> 
> Also, I still don't see this stuff working for high context switch rate
> workloads, and that is exactly what some people were aiming for..

We have been running scaling tests on highly loaded systems (with all
the fixes and suggestions applied) and here are the results.

On a system with 2x6 cores (12 hardware threads per NUMA node), with one
12-vcpus-32gb VM per NUMA node running a CPU-intensive workload
(linpack):
- Baseline: 864 gflops
- Core scheduling: 864 gflops
- nosmt (switch to 6 hardware threads per node): 298 gflops (-65%)

In this test, the VMs are basically alone on their own NUMA node, so
they are only competing with themselves, so for the next test we moved
the 2 VMs to the same node:
- Baseline: 340 gflops, about 586k context switches/sec
- Core scheduling: 322 gflops (-5%), about 575k context switches/sec
- nosmt: 146 gflops (-57%), about 284k context switches/sec

In terms of isolation, CPU-intensive VMs share their core with a
"foreign process" (not tagged or tagged with a different tag) less than
2% of the time (sum of the time spent with a lot of different
processes). For reference, this could add up to 60% without core
scheduling and smt on. We are working on identifying the various cases
where there is unwanted co-scheduling so we can address those.

With a more heterogeneous benchmark (MySQL benchmark with a remote
client, 1 12-vcpus MySQL VM on each NUMA node), we don’t measure any
performance degradation when there is more hardware threads available
than vcpus (same with nosmt), but when we add noise VMs (sleep(15);
collect metrics; send them over a VPN; repeat) with an overcommit ratio
of 3 vcpus to 1 hardware thread, core scheduling can have up to 25%
performance degradation, whereas nosmt has 15% impact.

So the performance impact varies depending on the type of workload, but
since the CPU-intensive workloads are the ones most impacted when we
disable SMT, this is very encouraging and is a worthwhile effort.

Thanks,

Julien
