Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53771C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E70A2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbfJALdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:33:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:46282 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732298AbfJALdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:33:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6ED04AF47;
        Tue,  1 Oct 2019 11:33:37 +0000 (UTC)
Subject: Re: xenbus hang after userspace ctrl-c of xenstore-rm
To:     James Dingwall <james@dingwall.me.uk>, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20191001095716.GA16951@dingwall.me.uk>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <b95d9a22-727e-f919-ae3b-6567f7ba5543@suse.com>
Date:   Tue, 1 Oct 2019 13:33:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001095716.GA16951@dingwall.me.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.19 11:57, James Dingwall wrote:
> Hi,
> 
> I have been investigating a problem where xenstore becomes unresponsive
> during domain shutdowns.  My test script seems to trigger the problem
> but without definitively being the same.  It is possible to replicate
> the issue in dom0 or a domU.  If the test script is run in dom0 it seems
> that it is possible to affect xenstore access in domUs but I have not
> observed any negative impact in dom0 or other guests when running in a
> domU.
> 
> The environment is a default Ubuntu 5.0.0-29-generic kernel, xen
> 4.11.3-pre (built from current head of staging-4.11), xenstore is
> running in a stubdom.  I did try a kernel with
> d10e0cc113c9e1b64b5c6e3db37b5c839794f3df "xenbus: Avoid deadlock during
> suspend due to open transactions" but that didn't help, this stack trace
> is with that patch applied.
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

Yes, this is a self-deadlock when cleaning up a user's file context.
Thanks for the nice debug data. :-)

I need to do the cleanup via a workqueue instead of calling it directly.

Cooking up a patch now...


Juergen
