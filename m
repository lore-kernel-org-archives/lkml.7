Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4378BC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A92721A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbfIZLGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 07:06:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:36108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725280AbfIZLGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 07:06:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42093ADB3;
        Thu, 26 Sep 2019 11:06:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BBB33DA7D9; Thu, 26 Sep 2019 13:06:48 +0200 (CEST)
Date:   Thu, 26 Sep 2019 13:06:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     bvanassche@acm.org, bhelgaas@google.com,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        sakari.ailus@linux.intel.com,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        David Sterba <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] async: Let kfree() out of the critical area of the lock
Message-ID: <20190926110648.GM2751@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Yunfeng Ye <yeyunfeng@huawei.com>,
        bvanassche@acm.org, bhelgaas@google.com,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        sakari.ailus@linux.intel.com,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        David Sterba <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <216356b1-38c1-8477-c4e8-03f497dd6ac8@huawei.com>
 <f49df2d42d7e97b61a5e26ff4d89ede5fbe37a35.camel@linux.intel.com>
 <e59af8ae-bacb-2e7e-dd53-ea283960d40e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e59af8ae-bacb-2e7e-dd53-ea283960d40e@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 03:58:36PM +0800, Yunfeng Ye wrote:
> On 2019/9/25 23:20, Alexander Duyck wrote:
> > On Wed, 2019-09-25 at 20:52 +0800, Yunfeng Ye wrote:
> > It probably wouldn't hurt to update the patch description to mention that
> > async_schedule_node_domain does the allocation outside of the lock, then
> > takes the lock and does the list addition and entry_count increment inside
> > the critical section so this is just updating the code to match that it
> > seems.
> > 
> > Otherwise the change itself looks safe to me, though I am not sure there
> > is a performance gain to be had so this is mostly just a cosmetic patch.
> > 
> The async_lock is big global lock, I think it's good to put kfree() outside
> to keep the critical area as short as possible.

Agreed, kfree is not always cheap. We had patches in btrfs moving kfree
out of critical section(s) after causing softlockups due to increased lock
contention.
