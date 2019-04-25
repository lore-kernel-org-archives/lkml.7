Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886A3C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4CC2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="M1qn47Eo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfDYOgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:36:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35843 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfDYOgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:36:53 -0400
Received: by mail-qt1-f193.google.com with SMTP id c35so336873qtk.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/IiAuR/yG1CgRbvu1CfSN4UcnI+hLTFsJSqCSSn4xbA=;
        b=M1qn47Eo1JnQPkhpxy9gwpAnssbsUT2IEFJGykKlS2nqF6IEtO9mGXjBPWWNAgaTNL
         FyukTUTRPUadxDEinCF7EbgTDC0mFEUkvEpVoe4lKfZD4+VQGIH26EJIff6zY+2ZVLzT
         1ugNPLkV2v8LB2V84surzF1BeNce7QcKVCJrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/IiAuR/yG1CgRbvu1CfSN4UcnI+hLTFsJSqCSSn4xbA=;
        b=nZkeqLp1T4vkdGPP4ZP/iEkGJO4DFpe+1vVUyl7kwe02VTQuT4sDpV4hbEsZwK8X6A
         fCTqH+n9VTZ1vWiN8VICBlrAoJMYySxZA9iNpxS1UQikGin8UgurhyeWNFv8s5V0WP0O
         ScJYSVobSa21WsH+u6Z8g6FsUlbkbbb2prJBO5XNkbDbDOc4mW1vEK4czI4u6FH7zlMK
         3dCU4/X1D3TVHFqzAzZUsBxAgFCZvOpg3z8d7Y3OUgEJz/toeyxRYUOZHD5/WNOapOkb
         RNV2lzpC5R8e03+qn6YZMtv2MexrIUiwM5jMnmGsfaWcxnkX7FoLlSxrQn+UTm0FkPRZ
         0aBQ==
X-Gm-Message-State: APjAAAUsOaR9PaISOCEgH5P95NRuiICd5vvmAt6/xjUGdWOwabnampYO
        jnkZOEfqijUPXXbnvzT15STs8Q==
X-Google-Smtp-Source: APXvYqxVfP8sKhk0K8ZzV4eXBJ0UBMnBanR9qxebp1BVjB6EKetZADPzooN3YeaSF5sOl40eYsm8fw==
X-Received: by 2002:a0c:9d02:: with SMTP id m2mr21955194qvf.32.1556203012444;
        Thu, 25 Apr 2019 07:36:52 -0700 (PDT)
Received: from sinkpad (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id k65sm6550220qkc.79.2019.04.25.07.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 07:36:51 -0700 (PDT)
Date:   Thu, 25 Apr 2019 10:36:44 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190425143644.GA13531@sinkpad>
References: <cover.1556025155.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-Apr-2019 04:18:05 PM, Vineeth Remanan Pillai wrote:
> Second iteration of the core-scheduling feature.
> 
> This version fixes apparent bugs and performance issues in v1. This
> doesn't fully address the issue of core sharing between processes
> with different tags. Core sharing still happens 1% to 5% of the time
> based on the nature of workload and timing of the runnable processes.
> 
> Changes in v2
> -------------
> - rebased on mainline commit: 6d906f99817951e2257d577656899da02bb33105

Here are our benchmark results.

Environment setup:
------------------
Skylake server, 2 numa nodes, total 72 CPUs with HT on
Workload in KVM virtual machines, one cpu cgroup per VM (including qemu
and vhost threads)


Case 1: MySQL TPC-C
-------------------
1 12-vcpus-32gb MySQL server per numa node (clients on another physical
machine)
96 semi-idle 1-vcpu-512mb VM per numa node (sending metrics over a VPN
every 15 seconds)
--> 3 vcpus per physical CPU
Average of 10 5-minutes runs.

- baseline:
  - avg tps: 1878
  - stdev tps: 47
- nosmt:
  - avg tps: 959 (-49% from baseline)
  - stdev tps: 35
- core scheduling:
  - avg tps: 1406 (-25% from baseline)
  - stdev tps: 48
  - Co-scheduling stats (5 minutes sample):
    - 48.9% VM threads
    - 49.6% idle
    - 1.3% foreign threads

So in the v2, the case with a very noisy test, benefits from core
scheduling (the baseline is also better compared to v1 so we probably
benefit from other changes in the kernel).


Case 2: linpack with enough room
--------------------------------
2 12-vcpus-32gb linpack VMs both pinned on the same NUMA node (36
hardware threads with SMT on).
100k context switches/sec.
Average of 5 15-minutes runs.

- baseline:
  - avg gflops: 403
  - stdev: 20
- nosmt:
  - avg gflops: 355 (-12% from baseline)
  - stdev: 28
- core scheduling:
  - avg gflops: 364 (-9% from baseline)
  - stdev: 59
  - Co-scheduling stats (5 minutes sample):
    - 39.3% VM threads
    - 59.3% idle
    - 0.07% foreign threads

No real difference between nosmt and core scheduling when there is
enough room to run a cpu-intensive workload even with smt off.


Case 3: full node linpack
-------------------------
3 12-vcpus-32gb linpack VMs all pinned on the same NUMA node (36
hardware threads with SMT on).
155k context switches/sec
Average of 5 15-minutes runs.

- baseline:
  - avg gflops: 270
  - stdev: 5
- nosmt (switching to 2:1 ratio of vcpu to hardware threads):
  - avg gflops: 209 (-22.46% from baseline)
  - stdev: 6.2
- core scheduling
  - avg gflops: 269 (-0.11% from baseline)
  - stdev: 5.7
  - Co-scheduling stats (5 minutes sample):
    - 93.7% VM threads
    - 6.3% idle
    - 0.04% foreign threads

Here the core scheduling is a major improvement in terms of performance
compared to nosmt.

Julien
