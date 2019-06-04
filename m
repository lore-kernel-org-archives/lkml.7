Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4588BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D9D2484F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfFDNMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:12:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbfFDNMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:12:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 754E12F86D1;
        Tue,  4 Jun 2019 13:12:09 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E362620C5;
        Tue,  4 Jun 2019 13:11:58 +0000 (UTC)
Date:   Tue, 4 Jun 2019 21:11:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: Re: [block] 47cdee29ef: BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20190604131152.GA17248@ming.t460p>
References: <20190604020956.GC6576@shao2-debian>
 <20190604040343.GB7208@ming.t460p>
 <de04afaf-5e17-7999-0f10-3da466c66310@intel.com>
 <20190604104326.GA22492@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604104326.GA22492@ming.t460p>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 04 Jun 2019 13:12:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 06:43:27PM +0800, Ming Lei wrote:
> On Tue, Jun 04, 2019 at 05:06:44PM +0800, Rong Chen wrote:
> > Hi,
> > 
> > On 6/4/19 12:03 PM, Ming Lei wrote:
> > > Hi Rong Chen,
> > > 
> > > Thanks for your test & report!
> > > 
> > > On Tue, Jun 04, 2019 at 10:09:56AM +0800, kernel test robot wrote:
> > > > FYI, we noticed the following commit (built with gcc-7):
> > > > 
> > > > commit: 47cdee29ef9d94e485eb08f962c74943023a5271 ("block: move blk_exit_queue into __blk_release_queue")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > 
> > > > in testcase: trinity
> > > > with following parameters:
> > > > 
> > > > 	runtime: 300s
> > > > 
> > > > test-description: Trinity is a linux system call fuzz tester.
> > > > test-url: http://codemonkey.org.uk/projects/trinity/
> > > > 
> > > > 
> > > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 2G
> > > > 
> > > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > > 
> > > > 
> > > > +-------------------------------------------------+------------+------------+
> > > > |                                                 | 31cb1d64da | 47cdee29ef |
> > > > +-------------------------------------------------+------------+------------+
> > > > | boot_successes                                  | 3          | 0          |
> > > > | boot_failures                                   | 13         | 8          |
> > > > | BUG:kernel_reboot-without-warning_in_test_stage | 13         |            |
> > > > | BUG:kernel_NULL_pointer_dereference,address     | 0          | 8          |
> > > > | Oops:#[##]                                      | 0          | 8          |
> > > > | RIP:blk_mq_free_rqs                             | 0          | 8          |
> > > > | Kernel_panic-not_syncing:Fatal_exception        | 0          | 8          |
> > > > +-------------------------------------------------+------------+------------+
> > > > 
> > > > 
> > > > If you fix the issue, kindly add following tag
> > > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > > 
> > > > 
> > > > [    6.560544] BUG: kernel NULL pointer dereference, address: 0000000000000020
> > > > [    6.561658] #PF: supervisor read access in kernel mode
> > > > [    6.562495] #PF: error_code(0x0000) - not-present page
> > > > [    6.563277] PGD 0 P4D 0
> > > > [    6.563277] Oops: 0000 [#1] PTI
> > > > [    6.563277] CPU: 0 PID: 147 Comm: kworker/0:2 Tainted: G                T 5.2.0-rc1-00387-g47cdee29 #1
> > > > [    6.563277] Workqueue: events __blk_release_queue
> > > > [    6.563277] RIP: 0010:blk_mq_free_rqs+0x2c/0xaf
> > > 
> > > Looks there is race between removing queue and switching elevator, and
> > > which should be done by Trinity.
> > > 
> > > I guess that commit 47cdee29ef9d94e485eb08f962c74943023a5271 just
> > > changes the timing and makes it easy to trigger.
> > > 
> > > Please test the following patch and see if difference can be made.
> > > If the patch can't fix the issue, please enable KASAN and reproduce,
> > > then more useful log may be got.
> > 
> > The patch doesn't work, Attached please find the dmesg file with KASAN
> > enabled.
> 
> 
> Thanks for your test.
> 
> I think I can understand the issue now, it is because blk_mq_free_rqs()
> needs tag_set, however tag_set may have been freed.
> 
> In theory, we don't need tagset for freeing scheduler tags which is
> per-request-queue, not like driver tags.
> 
> However, the big trouble is that .exit_request() needs tagset, and this
> one is a generic issue, not limited to ide.
> 
> Give me a little time, I will investigate and see if good solution can be
> figured out. Otherwise, we may have to revert that commit.

Patch has been posted out:

https://lore.kernel.org/linux-block/20190604130802.17076-1-ming.lei@redhat.com/T/#u


Thanks,
Ming
