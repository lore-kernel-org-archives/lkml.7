Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00C1C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA82223AF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfDPOCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:02:43 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55209 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfDPOCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:02:42 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3GE0iWI026102;
        Tue, 16 Apr 2019 23:00:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp);
 Tue, 16 Apr 2019 23:00:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157095162.bbtec.net [60.157.95.162])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3GE0hLw026099
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 16 Apr 2019 23:00:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: unregister_netdevice: waiting for DEV to become free (2)
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Julian Anastasov <ja@ssi.bg>, Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot <syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com>,
        ddstreet@ieee.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, David Ahern <dsahern@gmail.com>
References: <0000000000007d22100573d66078@google.com>
 <alpine.LFD.2.20.1808201527230.2758@ja.home.ssi.bg>
 <4684eef5-ea50-2965-86a0-492b8b1e4f52@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <9d430543-33c3-0d9b-dc77-3a179a8e3919@I-love.SAKURA.ne.jp>
Date:   Tue, 16 Apr 2019 23:00:44 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4684eef5-ea50-2965-86a0-492b8b1e4f52@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, David S. Miller.

I have a question regarding rt_flush_dev() introduced by commit caacf05e5ad1abf0
("ipv4: Properly purge netdev references on uncached routes.") which went to
Linux 3.6-rc1. That commit started replacing "a device to unregister" with
"a loopback device in that namespace", but there is no description why that
commit chose "a loopback device in that namespace". If a device to unregister
is "a loopback device in that namespace" itself, rt_flush_dev() becomes a no-op
because dev == net->loopback_dev from the beginning. Apart from a problem that
usage count keeps increasing because dev_put(rt->dst.dev) is not called after
rt->dst.dev was replaced with a loopback device, replacing "a device to unregister"
with "a loopback device in init namespace" (like shown below) avoids this problem.

----------
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index a5da63e..aff6a44 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1492,7 +1492,6 @@ static void ipv4_dst_destroy(struct dst_entry *dst)
 
 void rt_flush_dev(struct net_device *dev)
 {
-	struct net *net = dev_net(dev);
 	struct rtable *rt;
 	int cpu;
 
@@ -1503,7 +1502,7 @@ void rt_flush_dev(struct net_device *dev)
 		list_for_each_entry(rt, &ul->head, rt_uncached) {
 			if (rt->dst.dev != dev)
 				continue;
-			rt->dst.dev = net->loopback_dev;
+			rt->dst.dev = init_net.loopback_dev;
 			dev_hold(rt->dst.dev);
 			dev_put(dev);
 		}
----------

On 2019/04/15 22:36, Tetsuo Handa wrote:
> On 2018/08/20 21:55, Julian Anastasov wrote:
>> 	Well, only IPVS and tun in the game? But IPVS does not
>> take any dev references for sync threads. Can it be a problem
>> in tun? For example, a side effects from dst_cache_reset?
>> May be dst_release is called too late? Here is what should happen
>> on unregistration:
>>
>> - NETDEV_UNREGISTER event: rt_flush_dev changes dst->dev with lo
>> but dst is not released
>>
>> - ndo_uninit/ip_tunnel_uninit: dst_cache_reset is called which
>> does nothing!?! May be dst_release call is needed here.
>>
>> - no more references are expected here ...
>>
>> - netdev_run_todo -> netdev_wait_allrefs: loop here due to refcnt!=0
>>
>> - dev->priv_destructor (ip_tunnel_dev_free) calls dst_cache_destroy
>> where dst_release is used but it is not reached because we loop in
>> netdev_wait_allrefs above
>>
>> - dst_cache_destroy: really call dst_release
>>
>> 	In fact, after calling rt_flush_dev and replacing the
>> dst->dev we should reach dev->priv_destructor (ip_tunnel_dev_free)
>> for tun device where dst_release for lo should be called. But may be 
>> something prevents it, exit batching?
> 
> I traced using debug printk() patch shown below.
> 
> ----------------------------------------
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 26f69cf763f4..25f7acacf457 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3726,6 +3726,11 @@ void netdev_run_todo(void);
>   */
>  static inline void dev_put(struct net_device *dev)
>  {
> +	if (!strcmp(dev->name, "lo")) {
> +		int count = netdev_refcnt_read(dev);
> +		printk("dev_put(%p): %u->%u\n", dev, count, count - 1);
> +		dump_stack();
> +	}
>  	this_cpu_dec(*dev->pcpu_refcnt);
>  }
>  
> @@ -3737,6 +3742,11 @@ static inline void dev_put(struct net_device *dev)
>   */
>  static inline void dev_hold(struct net_device *dev)
>  {
> +	if (!strcmp(dev->name, "lo")) {
> +		int count = netdev_refcnt_read(dev);
> +		printk("dev_hold(%p): %u->%u\n", dev, count, count + 1);
> +		dump_stack();
> +	}
>  	this_cpu_inc(*dev->pcpu_refcnt);
>  }
>  
> diff --git a/net/core/dev.c b/net/core/dev.c
> index fdcff29df915..53ff4385c8f7 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -8897,9 +8897,9 @@ static void netdev_wait_allrefs(struct net_device *dev)
>  
>  		refcnt = netdev_refcnt_read(dev);
>  
> -		if (time_after(jiffies, warning_time + 10 * HZ)) {
> -			pr_emerg("unregister_netdevice: waiting for %s to become free. Usage count = %d\n",
> -				 dev->name, refcnt);
> +		if (time_after(jiffies, warning_time + HZ)) {
> +			pr_emerg("unregister_netdevice: waiting for %s to become free. Usage count = %d%s (%p)\n",
> +				 dev->name, refcnt, netdev_reg_state(dev), dev);
>  			warning_time = jiffies;
>  		}
>  	}
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index a5da63e5faa2..4c5baca105ed 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1503,6 +1503,7 @@ void rt_flush_dev(struct net_device *dev)
>  		list_for_each_entry(rt, &ul->head, rt_uncached) {
>  			if (rt->dst.dev != dev)
>  				continue;
> +			printk("rt_flush_dev(%p)->(%p)\n", dev, net->loopback_dev);
>  			rt->dst.dev = net->loopback_dev;
>  			dev_hold(rt->dst.dev);
>  			dev_put(dev);
> @@ -2560,6 +2561,7 @@ struct dst_entry *ipv4_blackhole_route(struct net *net, struct dst_entry *dst_or
>  		new->input = dst_discard;
>  		new->output = dst_discard_out;
>  
> +		printk("ipv4_blackhole_route(%p)->(%p)\n", new->dev, net->loopback_dev);
>  		new->dev = net->loopback_dev;
>  		if (new->dev)
>  			dev_hold(new->dev);
> ----------------------------------------
> 
> When a new loopback device in a new network namespace is created using unshare(),
> nothing is wrong.
> 
> [   60.873014][ T7306] dev_hold(00000000d9f4ea20): 0->1
> [   60.873019][ T7306] CPU: 4 PID: 7306 Comm: a.out Not tainted 5.1.0-rc5+ #177
> [   60.873021][ T7306] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
> [   60.873022][ T7306] Call Trace:
> [   60.873031][ T7306]  dump_stack+0xaa/0xd8
> [   60.873037][ T7306]  net_rx_queue_update_kobjects+0x1f5/0x200
> [   60.873042][ T7306]  netdev_register_kobject+0xf8/0x1a0
> [   60.873047][ T7306]  register_netdevice+0x4cc/0x650
> [   60.873052][ T7306]  register_netdev+0x23/0x40
> [   60.873056][ T7306]  loopback_net_init+0x50/0xc0
> [   60.873059][ T7306]  ? loopback_dev_init+0xa0/0xa0
> [   60.873064][ T7306]  ops_init+0x4f/0x140
> [   60.873068][ T7306]  setup_net+0xe7/0x250
> [   60.873072][ T7306]  copy_net_ns+0xee/0x1e0
> [   60.873077][ T7306]  create_new_namespaces+0x141/0x2a0
> [   60.873081][ T7306]  unshare_nsproxy_namespaces+0x7e/0xf0
> [   60.873086][ T7306]  ksys_unshare+0x268/0x4b0
> [   60.873090][ T7306]  __x64_sys_unshare+0x16/0x20
> [   60.873095][ T7306]  do_syscall_64+0x7c/0x180
> [   60.873099][ T7306]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> But when some device in a network namespace calls rt_flush_dev(),
> it gets a usage count on loopback device in that network namespace.
> 
> [   71.388104][ T7620] rt_flush_dev(00000000cd35e96a)->(00000000d9f4ea20)
> [   71.391757][ T7620] dev_hold(00000000d9f4ea20): 7->8
> [   71.394725][ T7620] CPU: 4 PID: 7620 Comm: a.out Not tainted 5.1.0-rc5+ #177
> [   71.398094][ T7620] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
> [   71.403711][ T7620] Call Trace:
> [   71.405912][ T7620]  dump_stack+0xaa/0xd8
> [   71.408252][ T7620]  rt_flush_dev+0x177/0x1b0
> [   71.410802][ T7620]  fib_netdev_event+0x150/0x1b0
> [   71.413270][ T7620]  notifier_call_chain+0x47/0xd0
> [   71.415849][ T7620]  raw_notifier_call_chain+0x2d/0x40
> [   71.418491][ T7620]  ? tun_show_group+0x90/0x90
> [   71.421108][ T7620]  call_netdevice_notifiers_info+0x32/0x70
> [   71.423854][ T7620]  rollback_registered_many+0x421/0x680
> [   71.426583][ T7620]  rollback_registered+0x68/0xb0
> [   71.429244][ T7620]  unregister_netdevice_queue+0xa5/0x100
> [   71.432191][ T7620]  __tun_detach+0x576/0x590
> [   71.435533][ T7620]  tun_chr_close+0x41/0x80
> [   71.437957][ T7620]  ? __tun_detach+0x590/0x590
> [   71.440500][ T7620]  __fput+0xeb/0x2d0
> [   71.442816][ T7620]  ____fput+0x15/0x20
> [   71.445090][ T7620]  task_work_run+0xa9/0xd0
> [   71.447467][ T7620]  do_exit+0x37a/0xf40
> [   71.449623][ T7620]  do_group_exit+0x57/0xe0
> [   71.451826][ T7620]  get_signal+0x114/0x950
> [   71.453989][ T7620]  do_signal+0x2f/0x700
> [   71.456126][ T7620]  ? handle_mm_fault+0x1a8/0x360
> [   71.458323][ T7620]  ? __x64_sys_futex+0x179/0x210
> [   71.460620][ T7620]  exit_to_usermode_loop+0x159/0x180
> [   71.462956][ T7620]  do_syscall_64+0x15d/0x180
> [   71.465110][ T7620]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> The usage count printed by "unregister_netdevice: waiting for lo to become free."
> seems to match number of rt_flush_dev() traces shown above. (Complete log is at
> http://I-love.SAKURA.ne.jp/tmp/serial-20190415.txt.xz .)
> 
> Although netdev_wait_allrefs() is periodically calling
> call_netdevice_notifiers(NETDEV_UNREGISTER, dev) in order to try to drop
> the usgae count,
> 
> 	list_for_each_entry(rt, &ul->head, rt_uncached) {
> 		if (rt->dst.dev != dev)
> 			continue;
> 		rt->dst.dev = net->loopback_dev;
> 		dev_hold(rt->dst.dev);
> 		dev_put(dev);
> 	}
> 
> in rt_flush_dev() becomes a no-op because dev == net->loopback_dev and
> therefore cannot drop the usage count forever. That is, netdev_wait_allrefs()
> on a loopback device cannot make forward progress.
> 
> [   95.502947][ T4478] unregister_netdevice: waiting for lo to become free. Usage count = 28 (unregistered) (00000000d9f4ea20)
> [   95.509108][ T4478] rt_flush_dev(00000000d9f4ea20)->(00000000d9f4ea20)
> [   95.512598][ T4478] dev_hold(00000000d9f4ea20): 28->29
> [   95.517241][ T4478] CPU: 5 PID: 4478 Comm: kworker/u128:28 Not tainted 5.1.0-rc5+ #177
> [   95.522984][ T4478] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
> [   95.532898][ T4478] Workqueue: netns cleanup_net
> [   95.537134][ T4478] Call Trace:
> [   95.539751][ T4478]  dump_stack+0xaa/0xd8
> [   95.543642][ T4478]  rt_flush_dev+0x177/0x1b0
> [   95.546835][ T4478]  fib_netdev_event+0x150/0x1b0
> [   95.550609][ T4478]  notifier_call_chain+0x47/0xd0
> [   95.557990][ T4478]  raw_notifier_call_chain+0x2d/0x40
> [   95.563900][ T4478]  call_netdevice_notifiers_info+0x32/0x70
> [   95.568655][ T4478]  netdev_run_todo+0x197/0x410
> [   95.572554][ T4478]  rtnl_unlock+0xe/0x10
> [   95.576836][ T4478]  default_device_exit_batch+0x1ab/0x1d0
> [   95.579650][ T4478]  ? do_wait_intr_irq+0xb0/0xb0
> [   95.582236][ T4478]  ? unregister_netdevice_many+0x30/0x30
> [   95.584766][ T4478]  ? dev_change_net_namespace+0x4e0/0x4e0
> [   95.587397][ T4478]  ops_exit_list.isra.6+0x75/0x90
> [   95.590063][ T4478]  cleanup_net+0x20d/0x380
> [   95.592373][ T4478]  process_one_work+0x202/0x4f0
> [   95.595017][ T4478]  worker_thread+0x3c/0x4b0
> [   95.597520][ T4478]  kthread+0x139/0x160
> [   95.599822][ T4478]  ? process_one_work+0x4f0/0x4f0
> [   95.602351][ T4478]  ? kthread_destroy_worker+0x70/0x70
> [   95.604901][ T4478]  ret_from_fork+0x35/0x40
> [   95.607249][ T4478] dev_put(00000000d9f4ea20): 29->28
> [   95.609935][ T4478] CPU: 5 PID: 4478 Comm: kworker/u128:28 Not tainted 5.1.0-rc5+ #177
> [   95.613282][ T4478] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
> [   95.618699][ T4478] Workqueue: netns cleanup_net
> [   95.621345][ T4478] Call Trace:
> [   95.623381][ T4478]  dump_stack+0xaa/0xd8
> [   95.625787][ T4478]  rt_flush_dev+0x19f/0x1b0
> [   95.628284][ T4478]  fib_netdev_event+0x150/0x1b0
> [   95.630827][ T4478]  notifier_call_chain+0x47/0xd0
> [   95.633153][ T4478]  raw_notifier_call_chain+0x2d/0x40
> [   95.635702][ T4478]  call_netdevice_notifiers_info+0x32/0x70
> [   95.638372][ T4478]  netdev_run_todo+0x197/0x410
> [   95.640641][ T4478]  rtnl_unlock+0xe/0x10
> [   95.642828][ T4478]  default_device_exit_batch+0x1ab/0x1d0
> [   95.645230][ T4478]  ? do_wait_intr_irq+0xb0/0xb0
> [   95.647613][ T4478]  ? unregister_netdevice_many+0x30/0x30
> [   95.650148][ T4478]  ? dev_change_net_namespace+0x4e0/0x4e0
> [   95.652594][ T4478]  ops_exit_list.isra.6+0x75/0x90
> [   95.654975][ T4478]  cleanup_net+0x20d/0x380
> [   95.657140][ T4478]  process_one_work+0x202/0x4f0
> [   95.659829][ T4478]  worker_thread+0x3c/0x4b0
> [   95.662098][ T4478]  kthread+0x139/0x160
> [   95.664119][ T4478]  ? process_one_work+0x4f0/0x4f0
> [   95.666467][ T4478]  ? kthread_destroy_worker+0x70/0x70
> [   95.668916][ T4478]  ret_from_fork+0x35/0x40
> 
> If we do something like
> 
>  	list_for_each_entry(rt, &ul->head, rt_uncached) {
>  		if (rt->dst.dev != dev)
>  			continue;
> -                       rt->dst.dev = net->loopback_dev;
> +                       if (dev == net->loopback_dev)
> +                               rt->dst.dev = init_net.loopback_dev;
> +                       else
> +                               rt->dst.dev = net->loopback_dev;
>  		dev_hold(rt->dst.dev);
>  		dev_put(dev);
>  	}
> 
> at rt_flush_dev(), I guess that this problem will go away. I don't
> know which device should be used instead of init_net.loopback_dev .
> But I guess that we need to somehow avoid getting usage count on
> a loopback device (by e.g. using a dummy device which is not under
> unregistration procedure) when we want to unregister that loopback
> device.
> 

