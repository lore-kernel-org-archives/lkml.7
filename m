Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D253ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E3B2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfJOLte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:49:34 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:35751 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728327AbfJOLte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:49:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Tf82XPD_1571140170;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Tf82XPD_1571140170)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Oct 2019 19:49:31 +0800
Subject: Re: [PATCH] ocfs2: fix panic due to ocfs2_wq is null
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     Yi Li <yili@winhong.com>, linux-kernel@vger.kernel.org
Cc:     Yi Li <yilikernel@gmail.com>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
References: <1571130330-3944-1-git-send-email-yili@winhong.com>
 <b934372f-2769-0ae3-910f-9e65c3614d30@linux.alibaba.com>
Message-ID: <e1337f34-c807-4b59-6f90-63e18f42ef3f@linux.alibaba.com>
Date:   Tue, 15 Oct 2019 19:49:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b934372f-2769-0ae3-910f-9e65c3614d30@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc ocfs2-devel

On 19/10/15 19:03, Joseph Qi wrote:
> 
> 
> On 19/10/15 17:05, Yi Li wrote:
>> mount.ocfs2 failed when read ocfs2 filesystem super error.
>> the func ocfs2_initialize_super will return before allocate ocfs2_wq.
>> ocfs2_dismount_volume will flush the ocfs2_wq, that triggered the following panic.
>>
>> Oct 15 16:09:27 cnwarekv-205120 kernel: OCFS2: ERROR (device dm-34): ocfs2_validate_inode_block: Invalid dinode #513: fs_generation is 1837764116
>> Oct 15 16:09:27 cnwarekv-205120 kernel: On-disk corruption discovered. Please run fsck.ocfs2 once the filesystem is unmounted.
>> Oct 15 16:09:27 cnwarekv-205120 kernel: OCFS2: File system is now read-only.
>> Oct 15 16:09:27 cnwarekv-205120 kernel: (mount.ocfs2,22804,44):ocfs2_read_locked_inode:537 ERROR: status = -30
>> Oct 15 16:09:27 cnwarekv-205120 kernel: (mount.ocfs2,22804,44):ocfs2_init_global_system_inodes:458 ERROR: status = -30
>> Oct 15 16:09:27 cnwarekv-205120 kernel: (mount.ocfs2,22804,44):ocfs2_init_global_system_inodes:491 ERROR: status = -30
>> Oct 15 16:09:27 cnwarekv-205120 kernel: (mount.ocfs2,22804,44):ocfs2_initialize_super:2313 ERROR: status = -30
>> Oct 15 16:09:27 cnwarekv-205120 kernel: (mount.ocfs2,22804,44):ocfs2_fill_super:1033 ERROR: status = -30
>> ------------[ cut here ]------------
>> Oops: 0002 [#1] SMP NOPTI
>> Modules linked in: ocfs2 rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs fscache lockd grace ocfs2_dlmfs ocfs2_stack_o2cb ocfs2_dlm ocfs2_nodemanager ocfs2_stackglue configfs sunrpc ipt_REJECT nf_reject_ipv4 nf_conntrack_ipv4 nf_defrag_ipv4 iptable_filter ip_tables ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables ib_ipoib rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_cm ib_sa ib_mad ib_core ib_addr ipv6 ovmapi ppdev parport_pc parport xen_netfront fb_sys_fops sysimgblt sysfillrect syscopyarea acpi_cpufreq pcspkr i2c_piix4 i2c_core sg ext4 jbd2 mbcache2 sr_mod cdrom xen_blkfront pata_acpi ata_generic ata_piix floppy dm_mirror dm_region_hash dm_log dm_mod
>> CPU: 1 PID: 11753 Comm: mount.ocfs2 Tainted: G  E	4.14.148-200.ckv.x86_64 #1
>> Hardware name: Sugon H320-G30/35N16-US, BIOS 0SSDX017 12/21/2018
>> task: ffff967af0520000 task.stack: ffffa5f05484000
>> RIP: 0010:mutex_lock+0x19/0x20
>> Call Trace:
>>   flush_workqueue+0x81/0x460
>>   ocfs2_shutdown_local_alloc+0x47/0x440 [ocfs2]
>>   ocfs2_dismount_volume+0x84/0x400 [ocfs2]
>>   ocfs2_fill_super+0xa4/0x1270 [ocfs2]
>>   ? ocfs2_initialize_super.isa.211+0xf20/0xf20 [ocfs2]
>>   mount_bdev+0x17f/0x1c0
>>   mount_fs+0x3a/0x160
>>
>> Signed-off-by: Yi Li <yilikernel@gmail.com>
>> ---
>>  fs/ocfs2/localalloc.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
>> index 158e5af..943e5c3 100644
>> --- a/fs/ocfs2/localalloc.c
>> +++ b/fs/ocfs2/localalloc.c
>> @@ -377,7 +377,9 @@ void ocfs2_shutdown_local_alloc(struct ocfs2_super *osb)
>>  	struct ocfs2_dinode *alloc = NULL;
>>  
>>  	cancel_delayed_work(&osb->la_enable_wq);
>> -	flush_workqueue(osb->ocfs2_wq);
>> +	if (osb->ocfs2_wq) {
>> +	    flush_workqueue(osb->ocfs2_wq);
>> +	}
> 
> No need braces here.
> I think this fix is not enough since ocfs2_recovery_exit() will also
> do flush_workqueue().
> 
> Thanks,
> Joseph
> 
>>  
>>  	if (osb->local_alloc_state == OCFS2_LA_UNUSED)
>>  		goto out;
>>
