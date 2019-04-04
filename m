Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60B9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB0820882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfDDVQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:16:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727310AbfDDVQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:16:28 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34L48I9027881
        for <linux-kernel@vger.kernel.org>; Thu, 4 Apr 2019 17:16:26 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rnr6ukqj5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 17:16:26 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 4 Apr 2019 22:16:25 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Apr 2019 22:16:18 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x34LGH5t22806578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Apr 2019 21:16:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7BCCB206B;
        Thu,  4 Apr 2019 21:16:17 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88263B2064;
        Thu,  4 Apr 2019 21:16:17 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  4 Apr 2019 21:16:17 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7C63616C5F74; Thu,  4 Apr 2019 14:16:19 -0700 (PDT)
Date:   Thu, 4 Apr 2019 14:16:19 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "dipankar@in.ibm.com" <dipankar@in.ibm.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC tip/core/rcu 3/4] drivers/gpu/drm/amd: Dynamically
 allocate kfd_processes_srcu
Reply-To: paulmck@linux.ibm.com
References: <20190402142816.GA13084@linux.ibm.com>
 <20190402142933.14547-3-paulmck@linux.ibm.com>
 <474488ce-75a1-06d9-768a-66008648c70e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <474488ce-75a1-06d9-768a-66008648c70e@amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040421-2213-0000-0000-000003718A66
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010873; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01184371; UDB=6.00620134; IPR=6.00965125;
 MB=3.00026298; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-04 21:16:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040421-2214-0000-0000-00005DE7C5E0
Message-Id: <20190404211619.GP14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=960 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 05:40:54PM +0000, Kuehling, Felix wrote:
> On 2019-04-02 10:29 a.m., Paul E. McKenney wrote:
> > Having DEFINE_SRCU() or DEFINE_STATIC_SRCU() in a loadable module
> > requires that the size of the reserved region be increased, which is
> > not something we really want to be doing.  This commit therefore removes
> > the DEFINE_STATIC_SRCU() from drivers/gpu/drm/amd/amdkfd/kfd_process.c in
> > favor of defining kfd_processes_srcu as a simple srcu_struct, initializing
> > it in amdgpu_amdkfd_init(), and cleaning it up in amdgpu_amdkfd_fini().
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > Tested-by: kbuild test robot <lkp@intel.com>
> > Cc: Oded Gabbay <oded.gabbay@gmail.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com
> > Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: <dri-devel@lists.freedesktop.org>
> > Cc: <amd-gfx@lists.freedesktop.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 +++++
> >   drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 2 +-
> >   2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > index fe1d7368c1e6..eadb20dee867 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > @@ -28,6 +28,8 @@
> >   #include <linux/module.h>
> >   #include <linux/dma-buf.h>
> >   
> > +extern struct srcu_struct kfd_processes_srcu;
> > +
> >   static const unsigned int compute_vmid_bitmap = 0xFF00;
> >   
> >   /* Total memory size in system memory and all GPU VRAM. Used to
> > @@ -40,6 +42,8 @@ int amdgpu_amdkfd_init(void)
> >   	struct sysinfo si;
> >   	int ret;
> >   
> > +	ret = init_srcu_struct(&kfd_processes_srcu);
> > +	WARN_ON(ret);
> 
> kfd_processes_srcu only exists if kfd_process.c is compiled in. That 
> depends on CONFIG_HSA_AMD. So this should at least move into #ifdef a 
> few lines below.
> 
> However, it would be cleaner to move this initialization into kfd_init 
> in kfd_module.c, or better yet, into kfd_process_create_wq in 
> kfd_process.c. Then kfd_process_create_wq should be renamed to something 
> more generic, such as kfd_process_init.
> 
> 
> >   	si_meminfo(&si);
> >   	amdgpu_amdkfd_total_mem_size = si.totalram - si.totalhigh;
> >   	amdgpu_amdkfd_total_mem_size *= si.mem_unit;
> > @@ -57,6 +61,7 @@ int amdgpu_amdkfd_init(void)
> >   void amdgpu_amdkfd_fini(void)
> >   {
> >   	kgd2kfd_exit();
> > +	cleanup_srcu_struct(&kfd_processes_srcu);
> 
> Similarly, this would be cleaner in kfd_exit in kfd_module.c or 
> kfd_process_destroy_wq in kfd_process.c, with that function similarly 
> renamed to kfd_process_fini.
> 
> I'm attaching a revised patch. It's only compile tested.

Thank you, Felix!  I have reverted my original and applied your revised
version.

							Thanx, Paul

> Regards,
>    Felix
> 
> 
> >   }
> >   
> >   void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev)
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > index 4bdae78bab8e..98b694068b8a 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > @@ -47,7 +47,7 @@ struct mm_struct;
> >   DEFINE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
> >   static DEFINE_MUTEX(kfd_processes_mutex);
> >   
> > -DEFINE_SRCU(kfd_processes_srcu);
> > +struct srcu_struct kfd_processes_srcu;
> >   
> >   /* For process termination handling */
> >   static struct workqueue_struct *kfd_process_wq;

> From 5857a9aa63957a5755ff81ae5c46533bca408c12 Mon Sep 17 00:00:00 2001
> From: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Date: Tue, 2 Apr 2019 07:29:32 -0700
> Subject: [PATCH 1/1] drivers/gpu/drm/amd: Dynamically allocate
>  kfd_processes_srcu v2
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Having DEFINE_SRCU() or DEFINE_STATIC_SRCU() in a loadable module
> requires that the size of the reserved region be increased, which is
> not something we really want to be doing.  This commit therefore removes
> the DEFINE_STATIC_SRCU() from drivers/gpu/drm/amd/amdkfd/kfd_process.c in
> favor of defining kfd_processes_srcu as a simple srcu_struct, initializing
> it in kfd_process_init(), and cleaning it up in kfd_process_fini().
> 
> v2 (Felix Kuehling): Move srcu init and cleanup into kfd_process.c
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Tested-by (v1): kbuild test robot <lkp@intel.com>
> Cc: Oded Gabbay <oded.gabbay@gmail.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K??nig" <christian.koenig@amd.com>
> Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: <dri-devel@lists.freedesktop.org>
> Cc: <amd-gfx@lists.freedesktop.org>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_module.c  |  8 ++++----
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  4 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 19 ++++++++++++-------
>  3 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> index 932007e..e8e2c15 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> @@ -52,15 +52,15 @@ static int kfd_init(void)
>  	if (err < 0)
>  		goto err_topology;
>  
> -	err = kfd_process_create_wq();
> +	err = kfd_process_init();
>  	if (err < 0)
> -		goto err_create_wq;
> +		goto err_process;
>  
>  	kfd_debugfs_init();
>  
>  	return 0;
>  
> -err_create_wq:
> +err_process:
>  	kfd_topology_shutdown();
>  err_topology:
>  	kfd_chardev_exit();
> @@ -71,7 +71,7 @@ static int kfd_init(void)
>  static void kfd_exit(void)
>  {
>  	kfd_debugfs_fini();
> -	kfd_process_destroy_wq();
> +	kfd_process_fini();
>  	kfd_topology_shutdown();
>  	kfd_chardev_exit();
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 9e02309..9dd187c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -708,8 +708,8 @@ struct amdkfd_ioctl_desc {
>  };
>  bool kfd_dev_is_large_bar(struct kfd_dev *dev);
>  
> -int kfd_process_create_wq(void);
> -void kfd_process_destroy_wq(void);
> +int kfd_process_init(void);
> +void kfd_process_fini(void);
>  struct kfd_process *kfd_create_process(struct file *filep);
>  struct kfd_process *kfd_get_process(const struct task_struct *);
>  struct kfd_process *kfd_lookup_process_by_pasid(unsigned int pasid);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 4bdae78..f810911 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -47,7 +47,7 @@ struct mm_struct;
>  DEFINE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
>  static DEFINE_MUTEX(kfd_processes_mutex);
>  
> -DEFINE_SRCU(kfd_processes_srcu);
> +struct srcu_struct kfd_processes_srcu;
>  
>  /* For process termination handling */
>  static struct workqueue_struct *kfd_process_wq;
> @@ -69,22 +69,25 @@ static void evict_process_worker(struct work_struct *work);
>  static void restore_process_worker(struct work_struct *work);
>  
>  
> -int kfd_process_create_wq(void)
> +int kfd_process_init(void)
>  {
> +	int ret;
> +
>  	if (!kfd_process_wq)
>  		kfd_process_wq = alloc_workqueue("kfd_process_wq", 0, 0);
>  	if (!kfd_restore_wq)
>  		kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq", 0);
>  
> -	if (!kfd_process_wq || !kfd_restore_wq) {
> -		kfd_process_destroy_wq();
> +	if (!kfd_process_wq || !kfd_restore_wq)
>  		return -ENOMEM;
> -	}
>  
> -	return 0;
> +	ret = init_srcu_struct(&kfd_processes_srcu);
> +	WARN_ON(ret);
> +
> +	return ret;
>  }
>  
> -void kfd_process_destroy_wq(void)
> +void kfd_process_fini(void)
>  {
>  	if (kfd_process_wq) {
>  		destroy_workqueue(kfd_process_wq);
> @@ -94,6 +97,8 @@ void kfd_process_destroy_wq(void)
>  		destroy_workqueue(kfd_restore_wq);
>  		kfd_restore_wq = NULL;
>  	}
> +
> +	cleanup_srcu_struct(&kfd_processes_srcu);
>  }
>  
>  static void kfd_process_free_gpuvm(struct kgd_mem *mem,
> -- 
> 2.7.4
> 

