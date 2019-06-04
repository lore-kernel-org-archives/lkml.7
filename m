Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21833C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 04:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DBF24BB1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 04:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfFDEEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 00:04:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFDEET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 00:04:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69D2E7EBBD;
        Tue,  4 Jun 2019 04:04:19 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F5AE5B684;
        Tue,  4 Jun 2019 04:04:07 +0000 (UTC)
Date:   Tue, 4 Jun 2019 12:03:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: Re: [block] 47cdee29ef: BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20190604040343.GB7208@ming.t460p>
References: <20190604020956.GC6576@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604020956.GC6576@shao2-debian>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 04 Jun 2019 04:04:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rong Chen,

Thanks for your test & report!

On Tue, Jun 04, 2019 at 10:09:56AM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 47cdee29ef9d94e485eb08f962c74943023a5271 ("block: move blk_exit_queue into __blk_release_queue")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: trinity
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 2G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +-------------------------------------------------+------------+------------+
> |                                                 | 31cb1d64da | 47cdee29ef |
> +-------------------------------------------------+------------+------------+
> | boot_successes                                  | 3          | 0          |
> | boot_failures                                   | 13         | 8          |
> | BUG:kernel_reboot-without-warning_in_test_stage | 13         |            |
> | BUG:kernel_NULL_pointer_dereference,address     | 0          | 8          |
> | Oops:#[##]                                      | 0          | 8          |
> | RIP:blk_mq_free_rqs                             | 0          | 8          |
> | Kernel_panic-not_syncing:Fatal_exception        | 0          | 8          |
> +-------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> [    6.560544] BUG: kernel NULL pointer dereference, address: 0000000000000020
> [    6.561658] #PF: supervisor read access in kernel mode
> [    6.562495] #PF: error_code(0x0000) - not-present page
> [    6.563277] PGD 0 P4D 0 
> [    6.563277] Oops: 0000 [#1] PTI
> [    6.563277] CPU: 0 PID: 147 Comm: kworker/0:2 Tainted: G                T 5.2.0-rc1-00387-g47cdee29 #1
> [    6.563277] Workqueue: events __blk_release_queue
> [    6.563277] RIP: 0010:blk_mq_free_rqs+0x2c/0xaf


Looks there is race between removing queue and switching elevator, and
which should be done by Trinity.

I guess that commit 47cdee29ef9d94e485eb08f962c74943023a5271 just
changes the timing and makes it easy to trigger.

Please test the following patch and see if difference can be made.
If the patch can't fix the issue, please enable KASAN and reproduce,
then more useful log may be got.


diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 75b5281cc577..400a2102a4e4 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -848,11 +848,13 @@ static void blk_exit_queue(struct request_queue *q)
 	 * perform I/O scheduler exit before disassociating from the block
 	 * cgroup controller.
 	 */
+	mutex_lock(&q->sysfs_lock);
 	if (q->elevator) {
 		ioc_clear_queue(q);
 		elevator_exit(q, q->elevator);
 		q->elevator = NULL;
 	}
+	mutex_unlock(&q->sysfs_lock);
 
 	/*
 	 * Remove all references to @q from the block cgroup controller before

Thanks,
Ming
