Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4B6C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C5A205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfDOUqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:46:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:22939 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfDOUqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:46:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 13:46:46 -0700
X-IronPort-AV: E=Sophos;i="5.60,355,1549958400"; 
   d="scan'208";a="316214763"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2019 13:46:46 -0700
Message-ID: <6171ae280e2056cf21adc4481dd9b98e47cc6a30.camel@linux.intel.com>
Subject: Re: [PATCH] kernel/workqueue: Verify alloc_workqueue() argument
 list consistency
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 15 Apr 2019 13:46:46 -0700
In-Reply-To: <1555348186.161891.104.camel@acm.org>
References: <20190319174047.89815-1-bvanassche@acm.org>
         <1555348186.161891.104.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-04-15 at 10:09 -0700, Bart Van Assche wrote:
> On Tue, 2019-03-19 at 10:40 -0700, Bart Van Assche wrote:
> > This patch avoids that gcc reports the following warning when building
> > with W=1:
> > 
> > kernel/workqueue.c:4250:2: warning: function alloc_workqueue might be a candidate for gnu_printf format attribute [-Wsuggest-attribute=format]
> >   vsnprintf(wq->name, sizeof(wq->name), fmt, args);
> > 
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Fixes: 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for workqueues")
> > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > ---
> >  include/linux/workqueue.h | 1 
> >  1 file changed, 1 insertion()
> > 
> > diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> > index d59525fca4d3..30737b5183c0 100644
> > --- a/include/linux/workqueue.h
> > ﯦﾊ眥맗뾖⧮쟼⢮䪮竧ꇣ为 ,7 @@ extern struct workqueue_struct *system_freezable_power_efficient_wq;
> >   * RETURNS:
> >   * Pointer to the allocated workqueue on success, %NULL on failure.
> >   */
> > __printf(1, 4)
> >  struct workqueue_struct *alloc_workqueue(const char *fmt,
> >  					 unsigned int flags,
> >  					 int max_active, ...);
> 
> Ping?
> 
> Bart.

I'm not sure if your Cc list is really the right people to be reviewing
the patch. Wouldn't it make more sense to Cc the people who were on the
original patch that you are now fixing?

