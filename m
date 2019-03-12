Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0606C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EEE214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfCLG6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:58:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727301AbfCLG6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:58:45 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2C6uvts079687
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:58:44 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r64ht1957-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:58:43 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 12 Mar 2019 06:58:41 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Mar 2019 06:58:34 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2C6wXce37879836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Mar 2019 06:58:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEC47A4057;
        Tue, 12 Mar 2019 06:58:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E1FCA4040;
        Tue, 12 Mar 2019 06:58:32 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Mar 2019 06:58:32 +0000 (GMT)
Date:   Tue, 12 Mar 2019 08:58:30 +0200
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
Subject: Re: [PATCH 1/3] userfaultfd/sysctl: introduce
 unprivileged_userfaultfd
References: <20190311093701.15734-1-peterx@redhat.com>
 <20190311093701.15734-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311093701.15734-2-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19031206-0016-0000-0000-00000260CE27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031206-0017-0000-0000-000032BB70EE
Message-Id: <20190312065830.GB9497@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903120052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 05:36:59PM +0800, Peter Xu wrote:
> Introduce a new sysctl called "vm.unprivileged_userfaultfd" that can
> be used to decide whether userfaultfd syscalls are allowed by
> unprivileged users.  It'll allow three modes:
> 
>   - disabled: disallow unprivileged users to use uffd
> 
>   - enabled:  allow unprivileged users to use uffd
> 
>   - kvm:      allow unprivileged users to use uffd only if the user
>               had enough permission to open /dev/kvm (this option only
>               exists if the kernel turned on KVM).
> 
> This patch only introduce the new interface but not yet applied it to
> the userfaultfd syscalls, which will be done in the follow up patch.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/userfaultfd.c              | 96 +++++++++++++++++++++++++++++++++++
>  include/linux/userfaultfd_k.h |  5 ++
>  init/Kconfig                  | 11 ++++
>  kernel/sysctl.c               | 11 ++++
>  4 files changed, 123 insertions(+)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 89800fc7dc9d..c2188464555a 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -29,6 +29,8 @@
>  #include <linux/ioctl.h>
>  #include <linux/security.h>
>  #include <linux/hugetlb.h>
> +#include <linux/sysctl.h>
> +#include <linux/string.h>
> 
>  static struct kmem_cache *userfaultfd_ctx_cachep __read_mostly;
> 
> @@ -93,6 +95,95 @@ struct userfaultfd_wake_range {
>  	unsigned long len;
>  };
> 
> +enum unprivileged_userfaultfd {
> +	/* Disallow unprivileged users to use userfaultfd syscalls */
> +	UFFD_UNPRIV_DISABLED = 0,
> +	/* Allow unprivileged users to use userfaultfd syscalls */
> +	UFFD_UNPRIV_ENABLED,
> +#if IS_ENABLED(CONFIG_KVM)
> +	/*
> +	 * Allow unprivileged users to use userfaultfd syscalls only
> +	 * if the user had enough permission to open /dev/kvm
> +	 */
> +	UFFD_UNPRIV_KVM,
> +#endif
> +	UFFD_UNPRIV_NUM,
> +};
> +
> +static int unprivileged_userfaultfd __read_mostly;
> +static const char *unprivileged_userfaultfd_str[UFFD_UNPRIV_NUM] = {
> +	"disabled", "enabled",
> +#if IS_ENABLED(CONFIG_KVM)
> +	"kvm",
> +#endif
> +};
> +
> +static int unprivileged_uffd_parse(char *buf, size_t size)
> +{
> +	int i;
> +
> +	for (i = 0; i < UFFD_UNPRIV_NUM; i++) {
> +		if (!strncmp(unprivileged_userfaultfd_str[i], buf, size)) {
> +			unprivileged_userfaultfd = i;
> +			return 0;
> +		}
> +	}
> +
> +	return -EFAULT;
> +}
> +
> +static void unprivileged_uffd_dump(char *buf, size_t size)
> +{
> +	int i;
> +
> +	*buf = 0x00;
> +	for (i = 0; i < UFFD_UNPRIV_NUM; i++) {
> +		if (i == unprivileged_userfaultfd)
> +			strncat(buf, "[", size - strlen(buf));
> +		strncat(buf, unprivileged_userfaultfd_str[i],
> +			size - strlen(buf));
> +		if (i == unprivileged_userfaultfd)
> +			strncat(buf, "]", size - strlen(buf));
> +		strncat(buf, " ", size - strlen(buf));
> +	}
> +
> +}
> +
> +int proc_unprivileged_userfaultfd(struct ctl_table *table, int write,
> +				  void __user *buffer, size_t *lenp,
> +				  loff_t *ppos)
> +{
> +	struct ctl_table tmp_table = { .maxlen = 0 };
> +	int ret;
> +
> +	if (write) {
> +		tmp_table.maxlen = UFFD_UNPRIV_STRLEN;
> +		tmp_table.data = kmalloc(UFFD_UNPRIV_STRLEN, GFP_KERNEL);
> +
> +		ret = proc_dostring(&tmp_table, write, buffer, lenp, ppos);
> +		if (ret)
> +			goto out;
> +
> +		ret = unprivileged_uffd_parse(tmp_table.data,
> +					      UFFD_UNPRIV_STRLEN);
> +	} else {
> +		/* Leave space for "[]" */
> +		int len = UFFD_UNPRIV_STRLEN * UFFD_UNPRIV_NUM + 2;
> +
> +		tmp_table.maxlen = len;
> +		tmp_table.data = kmalloc(len, GFP_KERNEL);
> +
> +		unprivileged_uffd_dump(tmp_table.data, len);
> +
> +		ret = proc_dostring(&tmp_table, write, buffer, lenp, ppos);
> +	}
> +
> +out:
> +	if (tmp_table.data)
> +		kfree(tmp_table.data);
> +	return ret;
> +}
> +
>  static int userfaultfd_wake_function(wait_queue_entry_t *wq, unsigned mode,
>  				     int wake_flags, void *key)
>  {
> @@ -1955,6 +2046,11 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
> 
>  static int __init userfaultfd_init(void)
>  {
> +	char unpriv_uffd[UFFD_UNPRIV_STRLEN] =
> +	    CONFIG_USERFAULTFD_UNPRIVILEGED_DEFAULT;
> +
> +	unprivileged_uffd_parse(unpriv_uffd, sizeof(unpriv_uffd));
> +
>  	userfaultfd_ctx_cachep = kmem_cache_create("userfaultfd_ctx_cache",
>  						sizeof(struct userfaultfd_ctx),
>  						0,
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 37c9eba75c98..f53bc02ccffc 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -28,6 +28,11 @@
>  #define UFFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
>  #define UFFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS)
> 
> +#define UFFD_UNPRIV_STRLEN 16
> +int proc_unprivileged_userfaultfd(struct ctl_table *table, int write,
> +				  void __user *buffer, size_t *lenp,
> +				  loff_t *ppos);
> +
>  extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
> 
>  extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
> diff --git a/init/Kconfig b/init/Kconfig
> index c9386a365eea..d90caa4fed17 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1512,6 +1512,17 @@ config USERFAULTFD
>  	  Enable the userfaultfd() system call that allows to intercept and
>  	  handle page faults in userland.
> 
> +config USERFAULTFD_UNPRIVILEGED_DEFAULT
> +        string "Default behavior for unprivileged userfault syscalls"
> +        depends on USERFAULTFD
> +        default "disabled"
> +        help
> +          Set this to "enabled" to allow userfaultfd syscalls from
> +          unprivileged users.  Set this to "disabled" to forbid
> +          userfaultfd syscalls from unprivileged users.  Set this to
> +          "kvm" to forbid unpriviledged users but still allow users
> +          who had enough permission to open /dev/kvm.

I'd phrase it a bit differently:

This option controls privilege level required to execute userfaultfd
system call.

Set this to "enabled" to allow userfaultfd system call from unprivileged
users. 
Set this to "disabled" to allow userfaultfd system call only for users who
have ptrace capability.
Set this to "kvm" to restrict userfaultfd system call usage to users with
permissions to open "/dev/kvm".
 
> +
>  config ARCH_HAS_MEMBARRIER_CALLBACKS
>  	bool
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 7578e21a711b..5dc9f3d283dd 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -96,6 +96,9 @@
>  #ifdef CONFIG_LOCKUP_DETECTOR
>  #include <linux/nmi.h>
>  #endif
> +#ifdef CONFIG_USERFAULTFD
> +#include <linux/userfaultfd_k.h>
> +#endif
> 
>  #if defined(CONFIG_SYSCTL)
> 
> @@ -1704,6 +1707,14 @@ static struct ctl_table vm_table[] = {
>  		.extra1		= (void *)&mmap_rnd_compat_bits_min,
>  		.extra2		= (void *)&mmap_rnd_compat_bits_max,
>  	},
> +#endif
> +#ifdef CONFIG_USERFAULTFD
> +	{
> +		.procname	= "unprivileged_userfaultfd",
> +		.maxlen		= UFFD_UNPRIV_STRLEN,
> +		.mode		= 0644,
> +		.proc_handler	= proc_unprivileged_userfaultfd,
> +	},
>  #endif
>  	{ }
>  };
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

