Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1463C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF4B214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfCLHCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:02:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726923AbfCLHCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:02:02 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2C6tu64095180
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 03:02:01 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r66jectd5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 03:02:01 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 12 Mar 2019 07:01:58 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Mar 2019 07:01:51 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2C71oPe55771332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 07:01:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C76D34C194;
        Tue, 12 Mar 2019 07:01:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 237144C191;
        Tue, 12 Mar 2019 07:01:49 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Mar 2019 07:01:49 +0000 (GMT)
Date:   Tue, 12 Mar 2019 09:01:47 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
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
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-fsdevel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/3] userfaultfd: allow to forbid unprivileged users
References: <20190311093701.15734-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311093701.15734-1-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19031207-0020-0000-0000-000003218323
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031207-0021-0000-0000-00002173AB87
Message-Id: <20190312070147.GC9497@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=739 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903120052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

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
> 
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
 
I'd appreciate to see "Patch 4: documentation update" ;-)
It'd be also great to update the man pages after this is merged.

Except for the comment to patch 1, feel free to add

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

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
Sincerely yours,
Mike.

