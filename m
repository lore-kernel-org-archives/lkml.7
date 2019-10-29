Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF686CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913582083E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="efsmSO4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfJ2Ue6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:34:58 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39139 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfJ2Ue5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:34:57 -0400
Received: by mail-yw1-f68.google.com with SMTP id k127so78302ywc.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3e7RG+yymRb8+UsDjN9H9kt+0y+nm/jojOW5ivlVFvw=;
        b=efsmSO4ZMSKlzNExqN+trF4cPvgy7drS2gKPDQSANIsrX4igow0dM/O50BYeZbKDQM
         hiazdisICBi094slGKVMuxcYklIV2arLTepYlLiueeUMimvvjusFE9SSZRoC6ZOR/aoU
         +1dcTTm3FY/2R3dglgtSpuJI0IVzLNEfJFJWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3e7RG+yymRb8+UsDjN9H9kt+0y+nm/jojOW5ivlVFvw=;
        b=k6x6rk0pxzrDom/cMyrsCdU4dVZ50wbze8NjIWbEJfPEAs5ojWu5loCHelxZ+nD454
         6zdqXFIT9vXED3IpiKxPg5F7yVHDHEdAjgscrMFIKM3iY/qdOZw71RnqWqk/8DO62akQ
         WZEQSCzuRY3cT2v/BOv5NkVbLBEBjgTSdhRhg/E7LuoBp328w37FweO9hMdFgQnJrgyr
         J7XfYlN1dN9ogMrwOIp4cwQD0oT2VD4ONhe5pxil5mdV0vmghuIurEOaXwM4clVsCT43
         WLoZRInCKUtDFLcrAMoXU4BASp26q2+zuXjLDyN7XKcO/kPO46DudMFX2IebmWAzFx6N
         +jyg==
X-Gm-Message-State: APjAAAX0rReDhrgS6u1pm82DzN3NGkSxpuEEaeDrr8xEZNfP6Ro3IH1g
        tfGuXDR+VF5oCGB03s3gBhbOZg==
X-Google-Smtp-Source: APXvYqw53pPyegiei3tZ7Yzm+loCH8bzg7nHRm+d4aamBP2EMIXnNiwJny609a7DNSN6g3lneI+8Qg==
X-Received: by 2002:a81:bd05:: with SMTP id b5mr19023466ywi.243.1572381295382;
        Tue, 29 Oct 2019 13:34:55 -0700 (PDT)
Received: from sinkpad (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id l68sm4501863ywf.95.2019.10.29.13.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 13:34:54 -0700 (PDT)
Date:   Tue, 29 Oct 2019 16:34:47 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Dario Faggioli <dfaggioli@suse.com>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20191029203447.GA13345@sinkpad>
References: <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
 <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
 <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
 <20190911140204.GA52872@aaronlu>
 <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
 <20190912120400.GA16200@aaronlu>
 <CAERHkrsrszO4hJqVy=g7P74h9d_YJzW7GY4ptPKykTX-mc9Mdg@mail.gmail.com>
 <20190915141402.GA1349@aaronlu>
 <277737d6034b3da072d3b0b808d2fa6e110038b0.camel@suse.com>
 <d30d343a8d9bf2c2e2977be7ac8370f26fd4df3d.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d30d343a8d9bf2c2e2977be7ac8370f26fd4df3d.camel@suse.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-Oct-2019 10:20:57 AM, Dario Faggioli wrote:
> > Hello,
> > 
> > As anticipated, I've been trying to follow the development of this
> > feature and, in the meantime, I have done some benchmarks.
> > 
> > I actually have a lot of data (and am planning for more), so I am
> > sending a few emails, each one with a subset of the numbers in it,
> > instead than just one which would be beyond giant! :-)
> > 

Hi Dario,

Thank you for this comprehensive set of tests and analyses !

It confirms the trend we are seeing for the VM cases. Basically when the
CPUs are overcommitted, core scheduling helps compared to noHT. But when
we have I/O in the mix (sysbench-oltp), then it becomes a bit less
clear, it depends if the CPU is still overcommitted or not. About the
2nd VM that is doing the background noise, is it enough to fill up the
disk queues or is its disk throughput somewhat limited ? Have you
compared the results if you disable the disk noise ?

Our approach for bare-metal tests is a bit different, we are
constraining a set of processes only on a limited set of cpus, but I
like your approach because it pushes more the number of processes
against the whole system. And I have no explanation for why sysbench
thread vs process is so different.

And it also confirms, core scheduling has trouble scaling with the
number of threads, it works pretty well in VMs because the number of
threads is limited by the number of vcpus, but the bare-metal cases show
a major scaling issue (which is not too surprising).

I am curious, for the tagging in KVM, do you move all the vcpus into the
same cgroup before tagging ?  Did you leave the emulator threads
untagged at all time ?

For the overhead (without tagging), have you tried bisecting the
patchset to see which patch introduces the overhead ? it is more than I
had in mind.

And for the cases when core scheduling improves the performance compared
to the baseline numbers, could it be related to frequency scaling (more
work to do means a higher chance of running at a higher frequency) ?

We are almost ready to send the v4 patchset (most likely tomorrow), it
has been rebased on v5.3.5, so stay tuned and ready for another set of
tests ;-)

Thanks,

Julien
