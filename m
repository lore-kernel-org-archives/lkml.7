Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59629C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DDB20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbfCFSMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:12:37 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46256 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbfCFSMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:12:36 -0500
Received: by mail-qk1-f196.google.com with SMTP id i5so7343899qkd.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 10:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+g56LoNYrrU/7MCAJ2CuVVWILoeRU0Nfm2pHjCZg/so=;
        b=OhSjblUw12Q7HwwOrh/O3DsU4089SZzH//4NIV2pH89fOnkX2TeR63TRaxPf/BW26i
         LJUB6Y9zRW90XL2Y0qjCYY2teUhRVgdJsVd4Kgu7AIEqmDtQ+oJ7O2uccWqw9e9e2om9
         4k4KT6xfzBZewgYlpmIIrXYC4OyWVZ5m8Druww6O+JIwHJZ1L2LN5RlbBl/FBOkzVQcB
         5AKFGfMRfYyXyUx/4Z2439+HsY156Jr/eRbGK5mftv7vE84ZDJDowRVziAKSB2v2aP64
         SQFegYuwmFzlJC4DA1ua9UYo8pMg58scfej9D50jWn9s6Vg51J7F2yrj4Y48V3TWtvHp
         6QLQ==
X-Gm-Message-State: APjAAAXU/g6zVFDIj7rYWddCEgNaq0jq2seMsL5RY/O+EhyaebjpAh2b
        MjGIin9tFvT0/gyGwxRfk/i5pQ==
X-Google-Smtp-Source: APXvYqzJmET5AGPyC2VvmSieAA7RrcFTBFeu1yofPQrC8LGZ3gAKiQirPclJdBD06hUDX3eVVIpTAw==
X-Received: by 2002:ae9:c210:: with SMTP id j16mr6962337qkg.0.1551895955316;
        Wed, 06 Mar 2019 10:12:35 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id v26sm1349438qtk.22.2019.03.06.10.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 10:12:34 -0800 (PST)
Date:   Wed, 6 Mar 2019 13:12:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pbonzini@redhat.com, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com, yang.zhang.wz@gmail.com,
        riel@surriel.com, david@redhat.com, dodgen@google.com,
        konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com,
        alexander.duyck@gmail.com
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
Message-ID: <20190306130955-mutt-send-email-mst@kernel.org>
References: <20190306155048.12868-1-nitesh@redhat.com>
 <20190306110501-mutt-send-email-mst@kernel.org>
 <bd029eb2-501a-8d2d-5f75-5d2b229c7e75@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd029eb2-501a-8d2d-5f75-5d2b229c7e75@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 01:07:50PM -0500, Nitesh Narayan Lal wrote:
> 
> On 3/6/19 11:09 AM, Michael S. Tsirkin wrote:
> > On Wed, Mar 06, 2019 at 10:50:42AM -0500, Nitesh Narayan Lal wrote:
> >> The following patch-set proposes an efficient mechanism for handing freed memory between the guest and the host. It enables the guests with no page cache to rapidly free and reclaims memory to and from the host respectively.
> >>
> >> Benefit:
> >> With this patch-series, in our test-case, executed on a single system and single NUMA node with 15GB memory, we were able to successfully launch 5 guests(each with 5 GB memory) when page hinting was enabled and 3 without it. (Detailed explanation of the test procedure is provided at the bottom under Test - 1).
> >>
> >> Changelog in v9:
> >> 	* Guest free page hinting hook is now invoked after a page has been merged in the buddy.
> >>         * Free pages only with order FREE_PAGE_HINTING_MIN_ORDER(currently defined as MAX_ORDER - 1) are captured.
> >> 	* Removed kthread which was earlier used to perform the scanning, isolation & reporting of free pages.
> >> 	* Pages, captured in the per cpu array are sorted based on the zone numbers. This is to avoid redundancy of acquiring zone locks.
> >>         * Dynamically allocated space is used to hold the isolated guest free pages.
> >>         * All the pages are reported asynchronously to the host via virtio driver.
> >>         * Pages are returned back to the guest buddy free list only when the host response is received.
> >>
> >> Pending items:
> >>         * Make sure that the guest free page hinting's current implementation doesn't break hugepages or device assigned guests.
> >> 	* Follow up on VIRTIO_BALLOON_F_PAGE_POISON's device side support. (It is currently missing)
> >>         * Compare reporting free pages via vring with vhost.
> >>         * Decide between MADV_DONTNEED and MADV_FREE.
> >> 	* Analyze overall performance impact due to guest free page hinting.
> >> 	* Come up with proper/traceable error-message/logs.
> >>
> >> Tests:
> >> 1. Use-case - Number of guests we can launch
> >>
> >> 	NUMA Nodes = 1 with 15 GB memory
> >> 	Guest Memory = 5 GB
> >> 	Number of cores in guest = 1
> >> 	Workload = test allocation program allocates 4GB memory, touches it via memset and exits.
> >> 	Procedure =
> >> 	The first guest is launched and once its console is up, the test allocation program is executed with 4 GB memory request (Due to this the guest occupies almost 4-5 GB of memory in the host in a system without page hinting). Once this program exits at that time another guest is launched in the host and the same process is followed. We continue launching the guests until a guest gets killed due to low memory condition in the host.
> >>
> >> 	Results:
> >> 	Without hinting = 3
> >> 	With hinting = 5
> >>
> >> 2. Hackbench
> >> 	Guest Memory = 5 GB 
> >> 	Number of cores = 4
> >> 	Number of tasks		Time with Hinting	Time without Hinting
> >> 	4000			19.540			17.818
> >>
> > How about memhog btw?
> > Alex reported:
> >
> > 	My testing up till now has consisted of setting up 4 8GB VMs on a system
> > 	with 32GB of memory and 4GB of swap. To stress the memory on the system I
> > 	would run "memhog 8G" sequentially on each of the guests and observe how
> > 	long it took to complete the run. The observed behavior is that on the
> > 	systems with these patches applied in both the guest and on the host I was
> > 	able to complete the test with a time of 5 to 7 seconds per guest. On a
> > 	system without these patches the time ranged from 7 to 49 seconds per
> > 	guest. I am assuming the variability is due to time being spent writing
> > 	pages out to disk in order to free up space for the guest.
> >
> Here are the results:
> 
> Procedure: 3 Guests of size 5GB is launched on a single NUMA node with
> total memory of 15GB and no swap. In each of the guest, memhog is run
> with 5GB. Post-execution of memhog, Host memory usage is monitored by
> using Free command.
> 
> Without Hinting:
>                  Time of execution    Host used memory
> Guest 1:        45 seconds            5.4 GB
> Guest 2:        45 seconds            10 GB
> Guest 3:        1  minute               15 GB
> 
> With Hinting:
>                 Time of execution     Host used memory
> Guest 1:        49 seconds            2.4 GB
> Guest 2:        40 seconds            4.3 GB
> Guest 3:        50 seconds            6.3 GB

OK so no improvement. OTOH Alex's patches cut time down to 5-7 seconds
which seems better. Want to try testing Alex's patches for comparison?

-- 
MST
