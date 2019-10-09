Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D155C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB2920679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DXNsQyTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731616AbfJIPZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:25:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39015 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbfJIPZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:25:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id n7so3977526qtb.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mASLNb/DzBMnYCk/BVkaomoauovjvnG9Kx9bKHkyDoI=;
        b=DXNsQyTptNLoOznPXTPe5neTJw23vokphUdG5j4/OW6dCq/JLR6wGuRE/sG+v6kLib
         5PWyWpqdjVQulOqJtsNQygbPf5upOtr5Ds2DvsrVPglKiBI88hos5lL6LbuAbEUZy08W
         BdM9IyveLD7FDMcoEuqiOl4LynIM8ZWMGN3tJa1RBhTm36UnM7MC+t7Xqc39xoYoJnEs
         4dLwvjerKSVR1XB4JECAAsUte9t9rLkxwvizRNlQ+ylBScJYug+LdNpJvFvDsmDZHcMT
         DANwTbNra7CZ1zJC5iRY4MxvOqYkr1eRYBs3W3f7YnppL/sSgADL2ZgcQW9/9zeW/IOn
         k7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mASLNb/DzBMnYCk/BVkaomoauovjvnG9Kx9bKHkyDoI=;
        b=llHxqWoCwKpPy7V3aY7rmDfW9kBn4eFM/DJl0pELQSpIaGjR16sISXWSPjFGxTxYhK
         BxzSWeN2XWAakoeAwAPGDZxSi0EKdSm2LY9bMpAiqdUC1mCw7eCv/wdP+Y1oufoUWQta
         rI/yifIEMlDxyAJybbpmT/TTpYubI53ObchCA3mhpqSa01uUzs8LV7v5C2Fjl+G3md+T
         uaYXRmL7m9yWAnbOERtCd34OYDWi2c/VebrFwZnLeKCkSi46+RkadKk0BdwBFIAD6Kie
         msRnnJwaRGgkRU5k6vXtPqGAZEYBRiZ2MdNIYkKYPWApbX3NcKxeCIcs7rH+04B/ViV/
         VbuA==
X-Gm-Message-State: APjAAAX+EcnXCp03QV4hordavzsnbrneM6vktDQJS4wp9LHdU9+wDIOL
        2Bzsr1hg6Mc0ODhNT4qO7KyUyg==
X-Google-Smtp-Source: APXvYqxVdCG1CtLLq36ET7pEvEabQeeAN1lZ5oSuIi67A/BAJPzCEtDpdFrmRIoq3sTKWrMSnTlr5g==
X-Received: by 2002:ac8:35bc:: with SMTP id k57mr4311381qtb.245.1570634741127;
        Wed, 09 Oct 2019 08:25:41 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a4sm1131289qkf.91.2019.10.09.08.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 08:25:40 -0700 (PDT)
Message-ID: <1570634738.5937.12.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Wed, 09 Oct 2019 11:25:38 -0400
In-Reply-To: <1157b3ae-006e-5b8e-71f0-883918992ecc@linux.ibm.com>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
         <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
         <20191007144937.GO2381@dhcp22.suse.cz>
         <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
         <20191008082752.GB6681@dhcp22.suse.cz>
         <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
         <1570550917.5576.303.camel@lca.pw>
         <1157b3ae-006e-5b8e-71f0-883918992ecc@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-09 at 15:56 +0200, Peter Oberparleiter wrote:
> On 08.10.2019 18:08, Qian Cai wrote:
> > On Tue, 2019-10-08 at 14:56 +0200, Christian Borntraeger wrote:
> > > Adding Peter Oberparleiter.
> > > Peter, can you have a look?
> > > 
> > > On 08.10.19 10:27, Michal Hocko wrote:
> > > > On Tue 08-10-19 09:43:57, Petr Mladek wrote:
> > > > > On Mon 2019-10-07 16:49:37, Michal Hocko wrote:
> > > > > > [Cc s390 maintainers - the lockdep is http://lkml.kernel.org/r/1570228005-24979-1-git-send-email-cai@lca.pw
> > > > > >  Petr has explained it is a false positive
> > > > > >  http://lkml.kernel.org/r/20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz]
> > > > > > On Mon 07-10-19 16:30:02, Petr Mladek wrote:
> > > > > > [...]
> > > > > > > I believe that it cannot really happen because:
> > > > > > > 
> > > > > > > 	static int __init
> > > > > > > 	sclp_console_init(void)
> > > > > > > 	{
> > > > > > > 	[...]
> > > > > > > 		rc = sclp_rw_init();
> > > > > > > 	[...]
> > > > > > > 		register_console(&sclp_console);
> > > > > > > 		return 0;
> > > > > > > 	}
> > > > > > > 
> > > > > > > sclp_rw_init() is called before register_console(). And
> > > > > > > console_unlock() will never call sclp_console_write() before
> > > > > > > the console is registered.
> > > > > > > 
> > > > > > > AFAIK, lockdep only compares existing chain of locks. It does
> > > > > > > not know about console registration that would make some
> > > > > > > code paths mutually exclusive.
> > > > > > > 
> > > > > > > I believe that it is a false positive. I do not know how to
> > > > > > > avoid this lockdep report. I hope that it will disappear
> > > > > > > by deferring all printk() calls rather soon.
> > > > > > 
> > > > > > Thanks a lot for looking into this Petr. I have also checked the code
> > > > > > and I really fail to see why the allocation has to be done under the
> > > > > > lock in the first place. sclp_read_sccb and sclp_init_sccb are global
> > > > > > variables but I strongly suspect that they need a synchronization during
> > > > > > early init, callbacks are registered only later IIUC:
> > > > > 
> > > > > Good idea. It would work when the init function is called only once.
> > > > > But see below.
> > > > > 
> > > > > > diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
> > > > > > index d2ab3f07c008..4b1c033e3255 100644
> > > > > > --- a/drivers/s390/char/sclp.c
> > > > > > +++ b/drivers/s390/char/sclp.c
> > > > > > @@ -1169,13 +1169,13 @@ sclp_init(void)
> > > > > >  	unsigned long flags;
> > > > > >  	int rc = 0;
> > > > > >  
> > > > > > +	sclp_read_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
> > > > > > +	sclp_init_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
> > > > > >  	spin_lock_irqsave(&sclp_lock, flags);
> > > > > >  	/* Check for previous or running initialization */
> > > > > >  	if (sclp_init_state != sclp_init_state_uninitialized)
> > > > > >  		goto fail_unlock;
> > > > > 
> > > > > It seems that sclp_init() could be called several times in parallel.
> > > > > I see it called from sclp_register() and sclp_initcall().
> > > > 
> > > > Interesting. Something for s390 people to answer I guess.
> > > > Anyway, this should be quite trivial to workaround by a cmpxch or alike.
> > > > 
> > 
> > The above fix is simply insufficient,
> > 
> > 00: [    3.654307] WARNING: possible circular locking dependency detected       
> > 00: [    3.654309] 5.4.0-rc1-next-20191004+ #4 Not tainted                      
> > 00: [    3.654311] ------------------------------------------------------       
> > 00: [    3.654313] swapper/0/1 is trying to acquire lock:                       
> > 00: [    3.654314] 00000000553f3fb8 (sclp_lock){-.-.}, at: sclp_add_request+0x34
> > 00: /0x308                                                                      
> > 00: [    3.654320]                                                              
> > 00: [    3.654322] but task is already holding lock:                            
> > 00: [    3.654323] 00000000550c9fc0 (console_owner){....}, at: console_unlock+0x
> > 00: 328/0xa30                                                                   
> > 00: [    3.654329]                                                              
> > 00: [    3.654331] which lock already depends on the new lock.                  
> 
> I can confirm that both this lockdep warning as well as the original one
> are both false positives: lockdep warns that code in sclp_init could
> trigger a deadlock via the chain
> 
>    sclp_lock --> &(&zone->lock)->rlock --> console_owner
> 
> but
> 
>   a) before sclp_init successfully completes, register_console is not
>      called, so there is no connection between console_owner -> sclp_lock
>   b) after sclp_init completed, it won't be called again, so any
>      dependency that requires a call-chain including sclp_init is
>      impossible to achieve
> 
> Apparently lockdep cannot determine that sclp_init won't be called again.
> I'm attaching a patch that moves sclp_init to __init so that lockdep has
> a chance of knowing that the function will be gone after init.
> 
> This patch is intended for testing only though, to see if there are other
> paths to similar possible deadlocks. I still need to decide if its worth
> changing the code to remove false positives in lockdep.
> 
> A generic solution would be preferable from my point of view though,
> because otherwise each console driver owner would need to ensure that any
> lock taken in their console.write implementation is never held while
> memory is allocated/released.
> 
> diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
> index d2ab3f07c008..13219e43d488 100644
> --- a/drivers/s390/char/sclp.c
> +++ b/drivers/s390/char/sclp.c
> @@ -140,7 +140,6 @@ static void sclp_request_timeout(bool force_restart);
>  static void sclp_process_queue(void);
>  static void __sclp_make_read_req(void);
>  static int sclp_init_mask(int calculate);
> -static int sclp_init(void);
> 
>  static void
>  __sclp_queue_read_req(void)
> @@ -670,7 +669,8 @@ __sclp_get_mask(sccb_mask_t *receive_mask, sccb_mask_t *send_mask)
>  	}
>  }
> 
> -/* Register event listener. Return 0 on success, non-zero otherwise. */
> +/* Register event listener. Return 0 on success, non-zero otherwise. Early
> + * callers (<= arch_initcall) must call sclp_init() first. */
>  int
>  sclp_register(struct sclp_register *reg)
>  {
> @@ -679,9 +679,8 @@ sclp_register(struct sclp_register *reg)
>  	sccb_mask_t send_mask;
>  	int rc;
> 
> -	rc = sclp_init();
> -	if (rc)
> -		return rc;
> +	if (sclp_init_state != sclp_init_state_initialized)
> +		return -EINVAL;
>  	spin_lock_irqsave(&sclp_lock, flags);
>  	/* Check event mask for collisions */
>  	__sclp_get_mask(&receive_mask, &send_mask);
> @@ -1163,8 +1162,7 @@ static struct platform_device *sclp_pdev;
> 
>  /* Initialize SCLP driver. Return zero if driver is operational, non-zero
>   * otherwise. */
> -static int
> -sclp_init(void)
> +int __init sclp_init(void)
>  {
>  	unsigned long flags;
>  	int rc = 0;
> diff --git a/drivers/s390/char/sclp.h b/drivers/s390/char/sclp.h
> index 196333013e54..463660261379 100644
> --- a/drivers/s390/char/sclp.h
> +++ b/drivers/s390/char/sclp.h
> @@ -296,6 +296,7 @@ struct sclp_register {
>  };
> 
>  /* externals from sclp.c */
> +int __init sclp_init(void);
>  int sclp_add_request(struct sclp_req *req);
>  void sclp_sync_wait(void);
>  int sclp_register(struct sclp_register *reg);
> diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
> index 8966a1c1b548..a08ef2c8379e 100644
> --- a/drivers/s390/char/sclp_con.c
> +++ b/drivers/s390/char/sclp_con.c
> @@ -319,6 +319,9 @@ sclp_console_init(void)
>  	/* SCLP consoles are handled together */
>  	if (!(CONSOLE_IS_SCLP || CONSOLE_IS_VT220))
>  		return 0;
> +	rc = sclp_init();
> +	if (rc)
> +		return rc;
>  	rc = sclp_rw_init();
>  	if (rc)
>  		return rc;
> diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
> index 3f9a6ef650fa..28b23e22248b 100644
> --- a/drivers/s390/char/sclp_vt220.c
> +++ b/drivers/s390/char/sclp_vt220.c
> @@ -694,6 +694,11 @@ static int __init __sclp_vt220_init(int num_pages)
>  	sclp_vt220_init_count++;
>  	if (sclp_vt220_init_count != 1)
>  		return 0;
> +	rc = sclp_init();
> +	if (rc) {
> +		sclp_vt220_init_count--;
> +		return rc;
> +	}
>  	spin_lock_init(&sclp_vt220_lock);
>  	INIT_LIST_HEAD(&sclp_vt220_empty);
>  	INIT_LIST_HEAD(&sclp_vt220_outqueue);

Unfortunately, the patch does not help here. I guess the lockdep does not really
differential __init or not because those places can still have a chance to
deadlock in general after interrupt and preempt are enabled even during the boot
but it is just not the case here.

00: [    2.812088] WARNING: possible circular locking dependency detected       
00: [    2.812090] 5.4.0-rc2-next-20191009+ #4 Not tainted                      
00: [    2.812092] ------------------------------------------------------       
00: [    2.812094] swapper/0/1 is trying to acquire lock:                       
00: [    2.812095] 0000000036a07ed8 (sclp_lock){-.-.}, at: sclp_add_request+0x34
00: /0x308                                                                      
00: [    2.812102]                                                              
00: [    2.812103] but task is already holding lock:                            
00: [    2.812105] 00000000366d9ec0 (console_owner){....}, at: console_unlock+0x
00: 328/0xa30                                                                   
00: [    2.812111]                                                              
00: [    2.812113] which lock already depends on the new lock.                  
00: [    2.812114]                                                              
00: [    2.812115]                                                              
00: [    2.812117] the existing dependency chain (in reverse order) is:         
00: [    2.812118]                                                              
00: [    2.812120] -> #2 (console_owner){....}:                                 
00: [    2.812126]        lock_acquire+0x21a/0x468                              
00: [    2.812127]        console_unlock+0x3a6/0xa30                            
00: [    2.812129]        vprintk_emit+0x184/0x3c8                              
00: [    2.812131]        vprintk_default+0x44/0x50                             
00: [    2.812132]        printk+0xa8/0xc0                                      
00: [    2.812134]        get_random_u64+0x40/0x108                             
00: [    2.812135]        add_to_free_area_random+0x188/0x1c0                   
00: [    2.812137]        free_one_page+0x72/0x128                              
00: [    2.812139]        __free_pages_ok+0x51c/0xc90                           
00: [    2.812141]        memblock_free_all+0x30a/0x3b0                         
00: [    2.812142]        mem_init+0x84/0x200                                   
00: [    2.812144]        start_kernel+0x384/0x6a0                              
00: [    2.812145]        startup_continue+0x70/0xd0                            
00: [    2.812146]                                                              
00: [    2.812147] -> #1 (&(&zone->lock)->rlock){....}:                         
00: [    2.812154]        lock_acquire+0x21a/0x468                              
00: [    2.812155]        _raw_spin_lock+0x54/0x68                              
00: [    2.812157]        get_page_from_freelist+0x8b6/0x2d28                   
00: [    2.812159]        __alloc_pages_nodemask+0x246/0x658                    
00: [    2.812161]        __get_free_pages+0x34/0x78                            
00: [    2.812162]        sclp_init+0xce/0x640                                  
00: [    2.812164]        sclp_console_init+0x4e/0x1c0                          
00: [    2.812166]        console_init+0x2c8/0x410                              
00: [    2.812168]        start_kernel+0x530/0x6a0                              
00: [    2.812169]        startup_continue+0x70/0xd0                            
00: [    2.812170]                                                              
00: [    2.812171] -> #0 (sclp_lock){-.-.}:                                     
00: [    2.812177]        check_noncircular+0x338/0x3e0                         
00: [    2.812179]        __lock_acquire+0x1e66/0x2d88                          
00: [    2.812181]        lock_acquire+0x21a/0x468                              
00: [    2.812182]        _raw_spin_lock_irqsave+0xcc/0xe8                      
00: [    2.812184]        sclp_add_request+0x34/0x308                           
00: [    2.812186]        sclp_conbuf_emit+0x100/0x138                          
00: [    2.812187]        sclp_console_write+0x96/0x3b8                         
00: [    2.812189]        console_unlock+0x6dc/0xa30                            
00: [    2.812191]        vprintk_emit+0x184/0x3c8                              
00: [    2.812192]        vprintk_default+0x44/0x50                             
00: [    2.812194]        printk+0xa8/0xc0                                      
00: [    2.812196]        iommu_debugfs_setup+0xf2/0x108                        
00: [    2.812198]        iommu_init+0x6c/0x78                                  
00: [    2.812200]        do_one_initcall+0x162/0x680                           
00: [    2.812201]        kernel_init_freeable+0x4e8/0x5a8                      
00: [    2.812203]        kernel_init+0x2a/0x188                                
00: [    2.812205]        ret_from_fork+0x30/0x34                               
00: [    2.812206]        kernel_thread_starter+0x0/0xc                         
00: [    2.812207]                                                              
00: [    2.812209] other info that might help us debug this:                    
00: [    2.812210]                                                              
00: [    2.812211] Chain exists of:                                             
00: [    2.812212]   sclp_lock --> &(&zone->lock)->rlock --> console_owner      
00: [    2.812221]                                                              
00: [    2.812222]  Possible unsafe locking scenario:                           
00: [    2.812223]                                                              
00: [    2.812225]        CPU0                    CPU1                          
00: [    2.812227]        ----                    ----                          
00: [    2.812228]   lock(console_owner);                                       
00: [    2.812232]                                lock(&(&zone->lock)->rlock);  
00: [    2.812236]                                lock(console_owner);          
00: [    2.812239]   lock(sclp_lock);                                           
00: [    2.812243]                                                              
00: [    2.812244]  *** DEADLOCK ***                                            
00: [    2.812245]                                                              
00: [    2.812247] 2 locks held by swapper/0/1:                                 
00: [    2.812248]  #0: 00000000366da100 (console_lock){+.+.}, at: vprintk_emit+
00: 0x178/0x3c8                                                                 
00: [    2.812255]  #1: 00000000366d9ec0 (console_owner){....}, at: console_unlo
00: ck+0x328/0xa30                                                              
00: [    2.812262]                                                              
00: [    2.812264] stack backtrace:                                             
00: [    2.812266] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc2-next-2019
00: 1009+ #4                                                                    
00: [    2.812268] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)                 
00: [    2.812269] Call Trace:                                                  
00: [    2.812271] ([<000000003591e230>] show_stack+0x110/0x1b0)                
00: [    2.812273]  [<00000000361e025e>] dump_stack+0x126/0x178                 
00: [    2.812276]  [<0000000035a149b8>] check_noncircular+0x338/0x3e0          
00: [    2.812277]  [<0000000035a1a9a6>] __lock_acquire+0x1e66/0x2d88           
00: [    2.812279]  [<0000000035a17cc2>] lock_acquire+0x21a/0x468               
00: [    2.812281]  [<000000003621bce4>] _raw_spin_lock_irqsave+0xcc/0xe8       
00: [    2.812283]  [<0000000035ff534c>] sclp_add_request+0x34/0x308            
00: [    2.812285]  [<0000000035ffc6b8>] sclp_conbuf_emit+0x100/0x138           
00: [    2.812287]  [<0000000035ffc7d6>] sclp_console_write+0x96/0x3b8          
00: [    2.812289]  [<0000000035a2b4fc>] console_unlock+0x6dc/0xa30             
00: [    2.812291]  [<0000000035a2dd0c>] vprintk_emit+0x184/0x3c8               
00: [    2.812293]  [<0000000035a2df94>] vprintk_default+0x44/0x50              
00: [    2.812295]  [<0000000035a2ea40>] printk+0xa8/0xc0                       
00: [    2.812297]  [<0000000035f4e5ea>] iommu_debugfs_setup+0xf2/0x108         
00: [    2.812299]  [<0000000036b90554>] iommu_init+0x6c/0x78                   
00: [    2.812301]  [<0000000035900fda>] do_one_initcall+0x162/0x680            
00: [    2.812303]  [<0000000036b4f9f0>] kernel_init_freeable+0x4e8/0x5a8       
00: [    2.812305]  [<0000000036206bda>] kernel_init+0x2a/0x188                 
00: [    2.812306]  [<000000003621cfdc>] ret_from_fork+0x30/0x34                
00: [    2.812308]  [<000000003621cfe0>] kernel_thread_starter+0x0/0xc          
00: [    2.812310] INFO: lockdep is turned off.
