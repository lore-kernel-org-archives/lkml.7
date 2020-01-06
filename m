Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5428C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3ECC2072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="azrNAJ/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgAFWqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:46:55 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:41945 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgAFWqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:46:55 -0500
Received: by mail-vk1-f193.google.com with SMTP id p191so2889220vkf.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mziUzibu7VLVDwY8yEp20Vq+KwzBjLeq76cwdTMo5x4=;
        b=azrNAJ/0EtMbREH1NtA0iDE9tkgz+lezr6yJohafJy+P8F+wCOpe5etiWW5zbeenJ8
         BuUxEouYLUyZamI6Sj/f7QE7Do55ZUW5U1nbPK0JY+m4cgfaVZ5Ua3yhylQ7vHbM/LDP
         rEDv6PYjAEDVr0CZXi10Ou2j3P0KGuClTRSWAE3/Nate8bvsUsFTodfIeRQYyInfqjxO
         BJV2lH8lf3na4nwz7QYAPpWRRuPhBPR+Hei/s1G/JBLAru3SvRfatYHmqBZ+VQFrcu7j
         NcNJrRGiB8g1SMnEZQFMCIjaXG7+JowagU8FQW7gv2gxE4/WZT5ef9WhsSsnAUomthRc
         nekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mziUzibu7VLVDwY8yEp20Vq+KwzBjLeq76cwdTMo5x4=;
        b=sTN8euFPNJAAIo+11Bc7C/S+MSayzSjl8uxFVHpZRuTjId9AYwiL1FxPkUQAOWWC19
         Q9G5ZFdmFINuxEjgBs6PwzGqvLEr+gUTXCc8oJpAgm/1FBjxxnAeDtEnRtCLD4hicVI4
         2Cfxa8kn5ejfMeYCzrEjuIWhY7Cs6F4dCEl/jj0UCvclgzqSla9RlXDiuXOaJ7XxYeqQ
         Q0yHMnSDimDScMOwxGJmaSlf+jkPEajyOH9SeC/ulzzETSqXxiqdBMU5kubjXvYqz0xD
         BToEV/mEtSjDRxLdgx86zleup3t/HMrVy5Cr47T1tYVe7uwdArJTvMcg0VDbn15q5An6
         SGFg==
X-Gm-Message-State: APjAAAXxHpK+MgsGTW31UhCWsXwGB+ZdhsDbaateZC5Msbuqx2tKbx2Z
        UFCflA+AtLoh/Ro7hwSVrTUFETxC1U+2gZaHuuAnMceM
X-Google-Smtp-Source: APXvYqxrbtzAinZlDXcCjYPK6LBCByV8b5PSRzrqMiqxqAMCfpyAe3z+ilcUjrsjXoMao63ZvkkvzsfE1n1YT0zDASA=
X-Received: by 2002:a1f:1fd1:: with SMTP id f200mr3881672vkf.21.1578350813834;
 Mon, 06 Jan 2020 14:46:53 -0800 (PST)
MIME-Version: 1.0
References: <20191216213901.106941-1-bgardon@google.com>
In-Reply-To: <20191216213901.106941-1-bgardon@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 6 Jan 2020 14:46:42 -0800
Message-ID: <CANgfPd-vDhHeBxCeJNfT7m75KYvGZTi+wHTAuZKO3ZchxMsBxw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Create a userfaultfd demand paging test
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>, Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If anyone has a chance to re-review this test patch series I'd be
grateful. I responded to most of the feedback I received in the first
series, and believe this test will be a useful performance benchmark
for future development.

On Mon, Dec 16, 2019 at 1:39 PM Ben Gardon <bgardon@google.com> wrote:
>
> When handling page faults for many vCPUs during demand paging, KVM's MMU
> lock becomes highly contended. This series creates a test with a naive
> userfaultfd based demand paging implementation to demonstrate that
> contention. This test serves both as a functional test of userfaultfd
> and a microbenchmark of demand paging performance with a variable number
> of vCPUs and memory per vCPU.
>
> The test creates N userfaultfd threads, N vCPUs, and a region of memory
> with M pages per vCPU. The N userfaultfd polling threads are each set up
> to serve faults on a region of memory corresponding to one of the vCPUs.
> Each of the vCPUs is then started, and touches each page of its disjoint
> memory region, sequentially. In response to faults, the userfaultfd
> threads copy a static buffer into the guest's memory. This creates a
> worst case for MMU lock contention as we have removed most of the
> contention between the userfaultfd threads and there is no time required
> to fetch the contents of guest memory.
>
> This test was run successfully on Intel Haswell, Broadwell, and
> Cascadelake hosts with a variety of vCPU counts and memory sizes.
>
> This test was adapted from the dirty_log_test.
>
> The series can also be viewed in Gerrit here:
> https://linux-review.googlesource.com/c/virt/kvm/kvm/+/1464
> (Thanks to Dmitry Vyukov <dvyukov@google.com> for setting up the Gerrit
> instance)
>
> Ben Gardon (9):
>   KVM: selftests: Create a demand paging test
>   KVM: selftests: Add demand paging content to the demand paging test
>   KVM: selftests: Add memory size parameter to the demand paging test
>   KVM: selftests: Pass args to vCPU instead of using globals
>   KVM: selftests: Support multiple vCPUs in demand paging test
>   KVM: selftests: Time guest demand paging
>   KVM: selftests: Add parameter to _vm_create for memslot 0 base paddr
>   KVM: selftests: Support large VMs in demand paging test
>   Add static flag
>
>  tools/testing/selftests/kvm/.gitignore        |   1 +
>  tools/testing/selftests/kvm/Makefile          |   4 +-
>  .../selftests/kvm/demand_paging_test.c        | 610 ++++++++++++++++++
>  tools/testing/selftests/kvm/dirty_log_test.c  |   2 +-
>  .../testing/selftests/kvm/include/kvm_util.h  |   3 +-
>  tools/testing/selftests/kvm/lib/kvm_util.c    |   7 +-
>  6 files changed, 621 insertions(+), 6 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/demand_paging_test.c
>
> --
> 2.23.0.444.g18eeb5a265-goog
>
