Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640D3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAF3214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="dp0W2MNX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfCLHt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:49:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38897 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfCLHtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:49:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id m2so1190772pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/olhjbpJtT1r+7uavB4KWlJpqCZECUEc8ErNDYVV/Hk=;
        b=dp0W2MNXHHwMurb7064PydUXyMqSIuX9WHN8wbk1FpKFfs4OSrPwv7gmXApzlzCY2d
         GbbBJMVpiYY2uZEAAZkZHZlQEcn6et3K8/ApQZ+AJo72JyN+d/lPasNL5as3MpAt+37N
         J1q2apNjiRCSEBFvuFoVBn9oMKRzzx1ccQ/3yoBjkjweP2R8E9kNu4A3BZwXtmDNPYUc
         BFvryNedtwL8eFbTaB9tqxqIprA7NJBu6Fa+m5yuAFOBcbnfMPeiRxIp8HL4Pb2jMb8/
         pyegpYg2Sae3wkHR/n1VnhwN5fk7MQGU3ivU1LKCIPnZ1EUZaFByAGTW3vnECAXEyRyW
         f9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/olhjbpJtT1r+7uavB4KWlJpqCZECUEc8ErNDYVV/Hk=;
        b=mdEWv4DD1H1GVv+HDmXx/qzQNcpmRG4oAXrYpySMK1R/2YZU6HN2zuqTJv5nkW5m+J
         PCSvfD8+Efz45fDNJMAH6C0gdtNQ5e9vQp0or9pBS0wTU2EmskM8RcUk+HSjUCaR7X5g
         2RRTIn4wBJCRBDm8CEn+Q9J9eNSfmby0vCeU6wupLPfna7fPwmhCSqjxAhdIg8k8KNjR
         1tmo00S8r5kVwBj4I8a2HTGBX7rfsSRE+6tQYcuhdcAzeNRTqxewmPSTQo7OnRGSUzv+
         THWa3oZZmPbO+2OGbLXa3iWt0vOAdcwXKExc1svH1RuHTuNphAeS5BGbKA3LQUd3K+Si
         dpvw==
X-Gm-Message-State: APjAAAVKAOCWfmx+I1cHOI9lbUlnPF8ZckCOnkfZK6CsxIfzsW9jecP2
        EmGBD8b+otiOUB+BaLFKa8z8gg==
X-Google-Smtp-Source: APXvYqxhoObJjZuttW1IPJrOnClfmIL5opPUfwHN9lGtlRAK/7XJitiZM5dBu2mlrfC7DZuBgNTIUQ==
X-Received: by 2002:aa7:8d42:: with SMTP id s2mr37450966pfe.116.1552376994892;
        Tue, 12 Mar 2019 00:49:54 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id x1sm13580445pge.73.2019.03.12.00.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 00:49:54 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id B21DA3011CA; Tue, 12 Mar 2019 10:49:51 +0300 (+03)
Date:   Tue, 12 Mar 2019 10:49:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        kvm@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>, linux-mm@kvack.org,
        Marty McFadden <mcfadden8@llnl.gov>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@suse.de>, linux-fsdevel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 0/3] userfaultfd: allow to forbid unprivileged users
Message-ID: <20190312074951.i2md3npcjcceywqj@kshutemo-mobl1>
References: <20190311093701.15734-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311093701.15734-1-peterx@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 05:36:58PM +0800, Peter Xu wrote:
> Hi,
> 
> (The idea comes from Andrea, and following discussions with Mike and
>  other people)
> 
> This patchset introduces a new sysctl flag to allow the admin to
> forbid users from using userfaultfd:
> 
>   $ cat /proc/sys/vm/unprivileged_userfaultfd
>   [disabled] enabled kvm

CC linux-api@

This is unusual way to return current value for sysctl. Does it work fine
with sysctl tool?

Have you considered to place the switch into /sys/kernel/mm instead?
I doubt it's the last tunable for userfaultfd. Maybe we should have an
directory for it under /sys/kernel/mm?

>   - When set to "disabled", all unprivileged users are forbidden to
>     use userfaultfd syscalls.
> 
>   - When set to "enabled", all users are allowed to use userfaultfd
>     syscalls.
> 
>   - When set to "kvm", all unprivileged users are forbidden to use the
>     userfaultfd syscalls, except the user who has permission to open
>     /dev/kvm.
> 
> This new flag can add one more layer of security to reduce the attack
> surface of the kernel by abusing userfaultfd.  Here we grant the
> thread userfaultfd permission by checking against CAP_SYS_PTRACE
> capability.  By default, the value is "disabled" which is the most
> strict policy.  Distributions can have their own perferred value.
> 
> The "kvm" entry is a bit special here only to make sure that existing
> users like QEMU/KVM won't break by this newly introduced flag.  What
> we need to do is simply set the "unprivileged_userfaultfd" flag to
> "kvm" here to automatically grant userfaultfd permission for processes
> like QEMU/KVM without extra code to tweak these flags in the admin
> code.
> 
> Patch 1:  The interface patch to introduce the flag
> 
> Patch 2:  The KVM related changes to detect opening of /dev/kvm
> 
> Patch 3:  Apply the flag to userfaultfd syscalls
> 
> All comments would be greatly welcomed.  Thanks,
> 
> Peter Xu (3):
>   userfaultfd/sysctl: introduce unprivileged_userfaultfd
>   kvm/mm: introduce MMF_USERFAULTFD_ALLOW flag
>   userfaultfd: apply unprivileged_userfaultfd check
> 
>  fs/userfaultfd.c               | 121 +++++++++++++++++++++++++++++++++
>  include/linux/sched/coredump.h |   1 +
>  include/linux/userfaultfd_k.h  |   5 ++
>  init/Kconfig                   |  11 +++
>  kernel/sysctl.c                |  11 +++
>  virt/kvm/kvm_main.c            |   7 ++
>  6 files changed, 156 insertions(+)
> 
> -- 
> 2.17.1
> 

-- 
 Kirill A. Shutemov
