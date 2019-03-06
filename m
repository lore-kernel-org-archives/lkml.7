Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42251C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E56C208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbfCFPvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:51:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbfCFPvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:51:10 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B703181E16;
        Wed,  6 Mar 2019 15:51:09 +0000 (UTC)
Received: from virtlab420.virt.lab.eng.bos.redhat.com (virtlab420.virt.lab.eng.bos.redhat.com [10.19.152.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FFB51001DF0;
        Wed,  6 Mar 2019 15:50:55 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pbonzini@redhat.com, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com, yang.zhang.wz@gmail.com,
        riel@surriel.com, david@redhat.com, mst@redhat.com,
        dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
        aarcange@redhat.com, alexander.duyck@gmail.com
Subject: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
Date:   Wed,  6 Mar 2019 10:50:42 -0500
Message-Id: <20190306155048.12868-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 06 Mar 2019 15:51:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch-set proposes an efficient mechanism for handing freed memory between the guest and the host. It enables the guests with no page cache to rapidly free and reclaims memory to and from the host respectively.

Benefit:
With this patch-series, in our test-case, executed on a single system and single NUMA node with 15GB memory, we were able to successfully launch 5 guests(each with 5 GB memory) when page hinting was enabled and 3 without it. (Detailed explanation of the test procedure is provided at the bottom under Test - 1).

Changelog in v9:
	* Guest free page hinting hook is now invoked after a page has been merged in the buddy.
        * Free pages only with order FREE_PAGE_HINTING_MIN_ORDER(currently defined as MAX_ORDER - 1) are captured.
	* Removed kthread which was earlier used to perform the scanning, isolation & reporting of free pages.
	* Pages, captured in the per cpu array are sorted based on the zone numbers. This is to avoid redundancy of acquiring zone locks.
        * Dynamically allocated space is used to hold the isolated guest free pages.
        * All the pages are reported asynchronously to the host via virtio driver.
        * Pages are returned back to the guest buddy free list only when the host response is received.

Pending items:
        * Make sure that the guest free page hinting's current implementation doesn't break hugepages or device assigned guests.
	* Follow up on VIRTIO_BALLOON_F_PAGE_POISON's device side support. (It is currently missing)
        * Compare reporting free pages via vring with vhost.
        * Decide between MADV_DONTNEED and MADV_FREE.
	* Analyze overall performance impact due to guest free page hinting.
	* Come up with proper/traceable error-message/logs.

Tests:
1. Use-case - Number of guests we can launch

	NUMA Nodes = 1 with 15 GB memory
	Guest Memory = 5 GB
	Number of cores in guest = 1
	Workload = test allocation program allocates 4GB memory, touches it via memset and exits.
	Procedure =
	The first guest is launched and once its console is up, the test allocation program is executed with 4 GB memory request (Due to this the guest occupies almost 4-5 GB of memory in the host in a system without page hinting). Once this program exits at that time another guest is launched in the host and the same process is followed. We continue launching the guests until a guest gets killed due to low memory condition in the host.

	Results:
	Without hinting = 3
	With hinting = 5

2. Hackbench
	Guest Memory = 5 GB 
	Number of cores = 4
	Number of tasks		Time with Hinting	Time without Hinting
	4000			19.540			17.818


