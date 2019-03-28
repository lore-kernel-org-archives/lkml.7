Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F36C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74906206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3SFpH4kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfC1RNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:13:41 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50868 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfC1RNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:13:40 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2SH97g6014008;
        Thu, 28 Mar 2019 17:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Cd6tPSqmcPy/gFLKcl+pwJ2+zHZkJoQpThAnx1E6OXg=;
 b=3SFpH4kdGqmG9ACWL2lBwmSIUHC6RUiz9sxqySzlFKzAswzmGDIi9jx6zA6W4g+nUafU
 dWz54BjKYYX0gxbORmFnyCWZywCmYSbGnc7BNpfiw5JywDyv6/UL+dhaYK/PtuKGXmsv
 wLVCKzbXbdrfx9YGOiLM3FIy3YAwmds2nXHP8EKTPpWdhikNghAtxrUlpa5G7zauXlpf
 AGSrIKrJ3R/4kYqVnQmTiOOwmEw+vtDWe+HYIDClCA5D4dPXyRjilpXLvqV9BX9Sesd0
 Lx1T29zVoRBV4jfIo64ZCrjBewFWcwCqDEZebcMm6duYthxU4WptmLL/haKpXYqKE1Yj rA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2re6g181b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 17:13:06 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2SHCsph017943
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 17:12:54 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2SHCsc5020545;
        Thu, 28 Mar 2019 17:12:54 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Mar 2019 10:12:53 -0700
Subject: Re: [PATCH net] net: rds: force to destroy connection if t_sock is
 NULL in rds_tcp_kill_sock().
To:     Mao Wenan <maowenan@huawei.com>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20190328091056.186547-1-maowenan@huawei.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <8cd0e24f-9609-1126-50b1-71ef35ae6c66@oracle.com>
Date:   Thu, 28 Mar 2019 10:14:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190328091056.186547-1-maowenan@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9209 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903280114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 2:10 AM, Mao Wenan wrote:
> When it is to cleanup net namespace, rds_tcp_exit_net() will call
> rds_tcp_kill_sock(), if t_sock is NULL, it will not call
> rds_conn_destroy(), rds_conn_path_destroy() and rds_tcp_conn_free() to free
> connection, and the worker cp_conn_w is not stopped, afterwards the net is freed in
> net_drop_ns(); While cp_conn_w rds_connect_worker() will call rds_tcp_conn_path_connect()
> and reference 'net' which has already been freed.
> 
> In rds_tcp_conn_path_connect(), rds_tcp_set_callbacks() will set t_sock = sock before
> sock->ops->connect, but if connect() is failed, it will call
> rds_tcp_restore_callbacks() and set t_sock = NULL, if connect is always
> failed, rds_connect_worker() will try to reconnect all the time, so
> rds_tcp_kill_sock() will never to cancel worker cp_conn_w and free the
> connections.
> 
> Therefore, the condition !tc->t_sock is not needed if it is going to do
> cleanup_net->rds_tcp_exit_net->rds_tcp_kill_sock, because tc->t_sock is always
> NULL, and there is on other path to cancel cp_conn_w and free
> connection. So this patch is to fix this.
> 
> rds_tcp_kill_sock():
> ...
> if (net != c_net || !tc->t_sock)
> ...
> ==================================================================
> BUG: KASAN: use-after-free in inet_create+0xbcc/0xd28
> net/ipv4/af_inet.c:340
> Read of size 4 at addr ffff8003496a4684 by task kworker/u8:4/3721
> 
> CPU: 3 PID: 3721 Comm: kworker/u8:4 Not tainted 5.1.0 #11
> Hardware name: linux,dummy-virt (DT)
> Workqueue: krdsd rds_connect_worker
> Call trace:
>   dump_backtrace+0x0/0x3c0 arch/arm64/kernel/time.c:53
>   show_stack+0x28/0x38 arch/arm64/kernel/traps.c:152
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x120/0x188 lib/dump_stack.c:113
>   print_address_description+0x68/0x278 mm/kasan/report.c:253
>   kasan_report_error mm/kasan/report.c:351 [inline]
>   kasan_report+0x21c/0x348 mm/kasan/report.c:409
>   __asan_report_load4_noabort+0x30/0x40 mm/kasan/report.c:429
>   inet_create+0xbcc/0xd28 net/ipv4/af_inet.c:340
>   __sock_create+0x4f8/0x770 net/socket.c:1276
>   sock_create_kern+0x50/0x68 net/socket.c:1322
>   rds_tcp_conn_path_connect+0x2b4/0x690 net/rds/tcp_connect.c:114
>   rds_connect_worker+0x108/0x1d0 net/rds/threads.c:175
>   process_one_work+0x6e8/0x1700 kernel/workqueue.c:2153
>   worker_thread+0x3b0/0xdd0 kernel/workqueue.c:2296
>   kthread+0x2f0/0x378 kernel/kthread.c:255
>   ret_from_fork+0x10/0x18 arch/arm64/kernel/entry.S:1117
> 
> Allocated by task 687:
>   save_stack mm/kasan/kasan.c:448 [inline]
>   set_track mm/kasan/kasan.c:460 [inline]
>   kasan_kmalloc+0xd4/0x180 mm/kasan/kasan.c:553
>   kasan_slab_alloc+0x14/0x20 mm/kasan/kasan.c:490
>   slab_post_alloc_hook mm/slab.h:444 [inline]
>   slab_alloc_node mm/slub.c:2705 [inline]
>   slab_alloc mm/slub.c:2713 [inline]
>   kmem_cache_alloc+0x14c/0x388 mm/slub.c:2718
>   kmem_cache_zalloc include/linux/slab.h:697 [inline]
>   net_alloc net/core/net_namespace.c:384 [inline]
>   copy_net_ns+0xc4/0x2d0 net/core/net_namespace.c:424
>   create_new_namespaces+0x300/0x658 kernel/nsproxy.c:107
>   unshare_nsproxy_namespaces+0xa0/0x198 kernel/nsproxy.c:206
>   ksys_unshare+0x340/0x628 kernel/fork.c:2577
>   __do_sys_unshare kernel/fork.c:2645 [inline]
>   __se_sys_unshare kernel/fork.c:2643 [inline]
>   __arm64_sys_unshare+0x38/0x58 kernel/fork.c:2643
>   __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>   invoke_syscall arch/arm64/kernel/syscall.c:47 [inline]
>   el0_svc_common+0x168/0x390 arch/arm64/kernel/syscall.c:83
>   el0_svc_handler+0x60/0xd0 arch/arm64/kernel/syscall.c:129
>   el0_svc+0x8/0xc arch/arm64/kernel/entry.S:960
> 
> Freed by task 264:
>   save_stack mm/kasan/kasan.c:448 [inline]
>   set_track mm/kasan/kasan.c:460 [inline]
>   __kasan_slab_free+0x114/0x220 mm/kasan/kasan.c:521
>   kasan_slab_free+0x10/0x18 mm/kasan/kasan.c:528
>   slab_free_hook mm/slub.c:1370 [inline]
>   slab_free_freelist_hook mm/slub.c:1397 [inline]
>   slab_free mm/slub.c:2952 [inline]
>   kmem_cache_free+0xb8/0x3a8 mm/slub.c:2968
>   net_free net/core/net_namespace.c:400 [inline]
>   net_drop_ns.part.6+0x78/0x90 net/core/net_namespace.c:407
>   net_drop_ns net/core/net_namespace.c:406 [inline]
>   cleanup_net+0x53c/0x6d8 net/core/net_namespace.c:569
>   process_one_work+0x6e8/0x1700 kernel/workqueue.c:2153
>   worker_thread+0x3b0/0xdd0 kernel/workqueue.c:2296
>   kthread+0x2f0/0x378 kernel/kthread.c:255
>   ret_from_fork+0x10/0x18 arch/arm64/kernel/entry.S:1117
> 
> The buggy address belongs to the object at ffff8003496a3f80
>   which belongs to the cache net_namespace of size 7872
> The buggy address is located 1796 bytes inside of
>   7872-byte region [ffff8003496a3f80, ffff8003496a5e40)
> The buggy address belongs to the page:
> page:ffff7e000d25a800 count:1 mapcount:0 mapping:ffff80036ce4b000
> index:0x0 compound_mapcount: 0
> flags: 0xffffe0000008100(slab|head)
> raw: 0ffffe0000008100 dead000000000100 dead000000000200 ffff80036ce4b000
> raw: 0000000000000000 0000000080040004 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>   ffff8003496a4580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8003496a4600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff8003496a4680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                     ^
>   ffff8003496a4700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8003496a4780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> Fixes: 467fa15356ac("RDS-TCP: Support multiple RDS-TCP listen endpoints, one per netns.")
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
Looks reasonable fix to me. Thanks !!

Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
