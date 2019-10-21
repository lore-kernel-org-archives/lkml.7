Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29E6CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69098205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfJUMdc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:33:32 -0400
Received: from know-smtprelay-omc-10.server.virginmedia.net ([80.0.253.74]:50728
        "EHLO know-smtprelay-omc-10.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbfJUMdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:33:31 -0400
Received: from mail0.xen.dingwall.me.uk ([82.47.84.47])
        by cmsmtp with ESMTPA
        id MWsKi0yyFKVO9MWsKip0Cv; Mon, 21 Oct 2019 13:33:29 +0100
X-Originating-IP: [82.47.84.47]
X-Authenticated-User: james.dingwall@blueyonder.co.uk
X-Spam: 0
X-Authority: v=2.3 cv=SNZsqtnH c=1 sm=1 tr=0 a=0bfgdX8EJi0Cr9X0x0jFDA==:117
 a=0bfgdX8EJi0Cr9X0x0jFDA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=XobE76Q3jBoA:10 a=5IRWAbXhAAAA:8
 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=907pBkEe21BXfl7TWG8A:9
 a=NzyhpIbpEjKdpzvW:21 a=1Hgw8yryt1ruglim:21 a=CjuIK1q_8ugA:10
 a=xo7gz2vLY8DhO4BdlxfM:22 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
Received: from localhost (localhost [IPv6:::1])
        by mail0.xen.dingwall.me.uk (Postfix) with ESMTP id 00282120BFC;
        Mon, 21 Oct 2019 12:33:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at dingwall.me.uk
Received: from mail0.xen.dingwall.me.uk ([127.0.0.1])
        by localhost (mail0.xen.dingwall.me.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Pfs9_cuZbyTg; Mon, 21 Oct 2019 12:33:30 +0000 (UTC)
Received: from behemoth.dingwall.me.uk (behemoth.dingwall.me.uk [IPv6:2001:470:695c:302::c0a8:105])
        by dingwall.me.uk (Postfix) with ESMTP id ABAA1120BF9;
        Mon, 21 Oct 2019 12:33:30 +0000 (UTC)
Received: by behemoth.dingwall.me.uk (Postfix, from userid 1000)
        id 7E790109F29; Mon, 21 Oct 2019 12:33:30 +0000 (UTC)
Date:   Mon, 21 Oct 2019 12:33:30 +0000
From:   James Dingwall <james@dingwall.me.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH] xen/xenbus: fix self-deadlock after killing user process
Message-ID: <20191021123330.GA5706@dingwall.me.uk>
References: <20191001150355.25365-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191001150355.25365-1-jgross@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CMAE-Envelope: MS4wfMU382LZGaPL7Hs2AGds5U9IK64NwsYvJvBHHo+Q2dFg/amxtVUWWs02w8+VlVIhUiOdt60LUNhO3c/ffFoYRZ7mmuh5jEQ86vMm19r351W5SPxjoMF7
 r8O/gPNyhCldHxeItvlbpaASuqEl3nuQ5m0kF1MQ7OzxBblYoxRTwKZOCByHFVz6CNx26jwrjUpBCVs4WgKZH4qoESK/hOfZNXQIvZmcldks4G1WNVWS1bra
 +9ByZwIqaCyPV13aTsy6oGZm2i08jfDTwfNOUX/UKly6J9p7WFcyF0CGNjVlTvy1KFOkpplCiHut7SMjKk6/xEXlvGySzbDXdYk8ZZYsGXI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 05:03:55PM +0200, Juergen Gross wrote:
> In case a user process using xenbus has open transactions and is killed
> e.g. via ctrl-C the following cleanup of the allocated resources might
> result in a deadlock due to trying to end a transaction in the xenbus
> worker thread:
> 
> [ 2551.474706] INFO: task xenbus:37 blocked for more than 120 seconds.
> [ 2551.492215]       Tainted: P           OE     5.0.0-29-generic #5
> [ 2551.510263] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 2551.528585] xenbus          D    0    37      2 0x80000080
> [ 2551.528590] Call Trace:
> [ 2551.528603]  __schedule+0x2c0/0x870
> [ 2551.528606]  ? _cond_resched+0x19/0x40
> [ 2551.528632]  schedule+0x2c/0x70
> [ 2551.528637]  xs_talkv+0x1ec/0x2b0
> [ 2551.528642]  ? wait_woken+0x80/0x80
> [ 2551.528645]  xs_single+0x53/0x80
> [ 2551.528648]  xenbus_transaction_end+0x3b/0x70
> [ 2551.528651]  xenbus_file_free+0x5a/0x160
> [ 2551.528654]  xenbus_dev_queue_reply+0xc4/0x220
> [ 2551.528657]  xenbus_thread+0x7de/0x880
> [ 2551.528660]  ? wait_woken+0x80/0x80
> [ 2551.528665]  kthread+0x121/0x140
> [ 2551.528667]  ? xb_read+0x1d0/0x1d0
> [ 2551.528670]  ? kthread_park+0x90/0x90
> [ 2551.528673]  ret_from_fork+0x35/0x40
> 
> Fix this by doing the cleanup via a workqueue instead.
> 
> Reported-by: James Dingwall <james@dingwall.me.uk>
> Fixes: fd8aa9095a95c ("xen: optimize xenbus driver for multiple concurrent xenstore accesses")
> Cc: <stable@vger.kernel.org> # 4.11
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  drivers/xen/xenbus/xenbus_dev_frontend.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
> index 08adc590f631..597af455a522 100644
> --- a/drivers/xen/xenbus/xenbus_dev_frontend.c
> +++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
> @@ -55,6 +55,7 @@
>  #include <linux/string.h>
>  #include <linux/slab.h>
>  #include <linux/miscdevice.h>
> +#include <linux/workqueue.h>
>  
>  #include <xen/xenbus.h>
>  #include <xen/xen.h>
> @@ -116,6 +117,8 @@ struct xenbus_file_priv {
>  	wait_queue_head_t read_waitq;
>  
>  	struct kref kref;
> +
> +	struct work_struct wq;
>  };
>  
>  /* Read out any raw xenbus messages queued up. */
> @@ -300,14 +303,14 @@ static void watch_fired(struct xenbus_watch *watch,
>  	mutex_unlock(&adap->dev_data->reply_mutex);
>  }
>  
> -static void xenbus_file_free(struct kref *kref)
> +static void xenbus_worker(struct work_struct *wq)
>  {
>  	struct xenbus_file_priv *u;
>  	struct xenbus_transaction_holder *trans, *tmp;
>  	struct watch_adapter *watch, *tmp_watch;
>  	struct read_buffer *rb, *tmp_rb;
>  
> -	u = container_of(kref, struct xenbus_file_priv, kref);
> +	u = container_of(wq, struct xenbus_file_priv, wq);
>  
>  	/*
>  	 * No need for locking here because there are no other users,
> @@ -333,6 +336,18 @@ static void xenbus_file_free(struct kref *kref)
>  	kfree(u);
>  }
>  
> +static void xenbus_file_free(struct kref *kref)
> +{
> +	struct xenbus_file_priv *u;
> +
> +	/*
> +	 * We might be called in xenbus_thread().
> +	 * Use workqueue to avoid deadlock.
> +	 */
> +	u = container_of(kref, struct xenbus_file_priv, kref);
> +	schedule_work(&u->wq);
> +}
> +
>  static struct xenbus_transaction_holder *xenbus_get_transaction(
>  	struct xenbus_file_priv *u, uint32_t tx_id)
>  {
> @@ -650,6 +665,7 @@ static int xenbus_file_open(struct inode *inode, struct file *filp)
>  	INIT_LIST_HEAD(&u->watches);
>  	INIT_LIST_HEAD(&u->read_buffers);
>  	init_waitqueue_head(&u->read_waitq);
> +	INIT_WORK(&u->wq, xenbus_worker);
>  
>  	mutex_init(&u->reply_mutex);
>  	mutex_init(&u->msgbuffer_mutex);
> -- 
> 2.16.4
> 

We have been having some crashes with an Ubuntu 5.0.0-31 kernel with 
this patch and thanks to the pstore fix "x86/xen: Return from panic 
notifier" we caught the oops below.  It seems to be in the same area of 
code as this patch but I'm unsure if it is directly related to this 
change or a secondary issue.  From the logs collected I can see this 
happened while there were several parallel `xl create` process running 
but so I have not been able to reproduce this in a test script but 
perhaps the trace will give some clues.

Thanks,
James


<4>[53626.726580] ------------[ cut here ]------------
<2>[53626.726583] kernel BUG at /build/slowfs/ubuntu-bionic/mm/slub.c:305!
<4>[53626.739554] invalid opcode: 0000 [#1] SMP NOPTI
<4>[53626.751119] CPU: 0 PID: 38 Comm: xenwatch Tainted: P           OE     5.0.0-31-generic #33~18.04.1z1
<4>[53626.763015] Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380 Gen10, BIOS U30 02/02/2019
<4>[53626.775100] RIP: e030:__slab_free+0x188/0x330
<4>[53626.787708] Code: 90 48 89 c7 e8 89 5d da ff 66 90 f0 49 0f ba 2c 24 00 72 68 4d 3b 6c 24 20 74 11 49 0f ba 34 24 00 e8 8c 5d da ff 66 90 eb a9 <0f> 0b 49 3b 5c 24 28 75 e8 48 8b 45 88 49 89 4c 24 28 49 89 44 24
<4>[53626.813409] RSP: e02b:ffffc900463f7c80 EFLAGS: 00010246
<4>[53626.826151] RAX: ffff8881601c20a8 RBX: 00000000820001a3 RCX: ffff8881601c20a8
<4>[53626.838346] RDX: ffff8881601c20a8 RSI: ffffea0005807080 RDI: ffff888251403c80
<4>[53626.850414] RBP: ffffc900463f7d20 R08: 0000000000000001 R09: ffffffff81624f37
<4>[53626.862624] R10: 0000000000000001 R11: f000000000000000 R12: ffffea0005807080
<4>[53626.874710] R13: ffff8881601c20a8 R14: ffff888251403c80 R15: ffff8881601c20a8
<4>[53626.886608] FS:  00007f67b9858c00(0000) GS:ffff888255a00000(0000) knlGS:0000000000000000
<4>[53626.898607] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[53626.910735] CR2: 0000565111fc81a0 CR3: 0000000d5b4d2000 CR4: 0000000000040660
<4>[53626.923103] Call Trace:
<4>[53626.934868]  ? xs_talkv+0x138/0x2b0
<4>[53626.946469]  ? xenbus_transaction_start+0x47/0x50
<4>[53626.958450]  kfree+0x169/0x180
<4>[53626.969983]  ? kfree+0x169/0x180
<4>[53626.981443]  xenbus_transaction_start+0x47/0x50
<4>[53626.993042]  __xenbus_switch_state.part.2+0x33/0x120
<4>[53627.004445]  xenbus_switch_state+0x18/0x20
<4>[53627.015851]  frontend_changed+0xde/0x5b0 [xen_blkback]
<4>[53627.027411]  xenbus_otherend_changed+0x10a/0x120
<4>[53627.038657]  frontend_changed+0x10/0x20
<4>[53627.049830]  xenwatch_thread+0xc4/0x160
<4>[53627.060987]  ? wait_woken+0x80/0x80
<4>[53627.071858]  kthread+0x121/0x140
<4>[53627.082558]  ? find_watch+0x40/0x40
<4>[53627.093339]  ? kthread_park+0xb0/0xb0
<4>[53627.103779]  ret_from_fork+0x35/0x40
<4>[53627.114200] Modules linked in: bridge stp llc xt_addrtype xt_owner xt_multiport xt_hl xt_tcpudp xt_conntrack xt_NFLOG ip6table_mangle iptable_mangle ip6table_nat nf_nat_ipv6 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables iptable_filter bpfilter nfnetlink_log nfnetlink intel_rapl nfit intel_powerclamp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 crypto_simd cryptd glue_helper intel_rapl_perf ttm drm_kms_helper drm i2c_algo_bit ipmi_ssif fb_sys_fops syscopyarea sysfillrect sysimgblt hpilo lpc_ich mei_me mei ipmi_si acpi_tad ipmi_devintf ipmi_msghandler acpi_power_meter ioatdma mac_hid dca sch_fq_codel xen_pciback xen_netback xen_blkback xen_gntalloc xen_gntdev xen_evtchn drbd lru_cache xenfs xen_privcmd ip_tables x_tables autofs4 dm_mirror dm_region_hash dm_log raid10 raid1 raid0 multipath linear dm_raid raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c usbhid
  hid_generic
<4>[53627.114230]  hid zfs(POE) zunicode(PO) zavl(PO) icp(POE) zcommon(POE) znvpair(POE) spl(O) efi_pstore aufs uas usb_storage tg3 ahci libahci wmi
<4>[53627.235116] ---[ end trace 796b6d237837988d ]---

