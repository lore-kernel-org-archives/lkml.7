Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA8AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671422084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfDBAcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 20:32:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:19675 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfDBAcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 20:32:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 17:32:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,298,1549958400"; 
   d="scan'208";a="127806276"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.107]) ([10.239.13.107])
  by orsmga007.jf.intel.com with ESMTP; 01 Apr 2019 17:32:17 -0700
Subject: Re: [rcu:dev.2019.03.20b 54/83]
 drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:50:1: error: type defaults
 to 'int' in declaration of 'DEFINE_SRCU'
To:     paulmck@linux.ibm.com, kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
References: <201903250225.RRMwkT3f%lkp@intel.com>
 <20190327195726.GF4102@linux.ibm.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <cad8bc52-a3ab-0d4e-bb13-c436510f684b@intel.com>
Date:   Tue, 2 Apr 2019 08:32:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190327195726.GF4102@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/19 3:57 AM, Paul E. McKenney wrote:
> On Mon, Mar 25, 2019 at 02:34:27AM +0800, kbuild test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.03.20b
>> head:   6d4434b4b4df791620743178e1419de882b44c7b
>> commit: eb89abcb30733e3a2343dda23cb6d81cc17c60b3 [54/83] rcu: Forbid DEFINE{,_STATIC}_SRCU() from modules
>> config: x86_64-randconfig-b0-03250021 (attached as .config)
>> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
>> reproduce:
>>          git checkout eb89abcb30733e3a2343dda23cb6d81cc17c60b3
>>          # save the attached .config to linux build tree
>>          make ARCH=x86_64
>>
>> All errors (new ones prefixed by >>):
>>
>>     drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:50:1: warning: data definition has no type or storage class
>>      DEFINE_SRCU(kfd_processes_srcu);
>>      ^~~~~~~~~~~
>>>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:50:1: error: type defaults to 'int' in declaration of 'DEFINE_SRCU' [-Werror=implicit-int]
>>     drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:50:1: warning: parameter names (without types) in function declaration
>>     cc1: some warnings being treated as errors
> I don't have that hardware, but does the following help?  (It at least
> builds for me, but your mileage may vary.)
>
> 							Thanx, Paul

Yes, the patch works for kbuild robot.

Thanks,
Rong Chen


>
> ------------------------------------------------------------------------
>
> commit b30be5a76070402912437fa23b43de11cb1973f4
> Author: Paul E. McKenney <paulmck@linux.ibm.com>
> Date:   Wed Mar 27 12:53:36 2019 -0700
>
>      drivers/gpu/drm/amd: Dynamically allocate kfd_processes_srcu
>      
>      Having DEFINE_SRCU() or DEFINE_STATIC_SRCU() in a loadable module
>      requires that the size of the reserved region be increased, which is
>      not something we really want to be doing.  This commit therefore removes
>      the DEFINE_STATIC_SRCU() from drivers/gpu/drm/amd/amdkfd/kfd_process.c in
>      favor of defining kfd_processes_srcu as a simple srcu_struct, initializing
>      it in amdgpu_amdkfd_init(), and cleaning it up in amdgpu_amdkfd_fini().
>      
>      Reported-by: kbuild test robot <lkp@intel.com>
>      Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
>      Cc: Oded Gabbay <oded.gabbay@gmail.com>
>      Cc: Alex Deucher <alexander.deucher@amd.com>
>      Cc: "Christian König" <christian.koenig@amd.com
>      Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
>      Cc: David Airlie <airlied@linux.ie>
>      Cc: Daniel Vetter <daniel@ffwll.ch>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index fe1d7368c1e6..eadb20dee867 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -28,6 +28,8 @@
>   #include <linux/module.h>
>   #include <linux/dma-buf.h>
>   
> +extern struct srcu_struct kfd_processes_srcu;
> +
>   static const unsigned int compute_vmid_bitmap = 0xFF00;
>   
>   /* Total memory size in system memory and all GPU VRAM. Used to
> @@ -40,6 +42,8 @@ int amdgpu_amdkfd_init(void)
>   	struct sysinfo si;
>   	int ret;
>   
> +	ret = init_srcu_struct(&kfd_processes_srcu);
> +	WARN_ON(ret);
>   	si_meminfo(&si);
>   	amdgpu_amdkfd_total_mem_size = si.totalram - si.totalhigh;
>   	amdgpu_amdkfd_total_mem_size *= si.mem_unit;
> @@ -57,6 +61,7 @@ int amdgpu_amdkfd_init(void)
>   void amdgpu_amdkfd_fini(void)
>   {
>   	kgd2kfd_exit();
> +	cleanup_srcu_struct(&kfd_processes_srcu);
>   }
>   
>   void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 4bdae78bab8e..98b694068b8a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -47,7 +47,7 @@ struct mm_struct;
>   DEFINE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
>   static DEFINE_MUTEX(kfd_processes_mutex);
>   
> -DEFINE_SRCU(kfd_processes_srcu);
> +struct srcu_struct kfd_processes_srcu;
>   
>   /* For process termination handling */
>   static struct workqueue_struct *kfd_process_wq;
>
