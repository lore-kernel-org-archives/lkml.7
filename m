Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEC7C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F89320835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eJw0klfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436831AbfIWLTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 07:19:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387657AbfIWLTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 07:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dLuDUQ/NDyEM5X4r4w1bfcQ9G8WLEJqV5t9yVHG08lI=; b=eJw0klfM4+vQl5Cr0fR4SPiMB
        oSMai5fIJYoYQcwD7OyaYpl43j5BsIyKb4pouVSklalGnwt1DM7fa4bN8fZ03aydu4WySTM0JOl+P
        mrVbEX/SCvhlozvd8e7VzI49v0ZHIT5hEY5zjqQSGfW3I6LepM7n5eSfWtdS2Hr29W+C1cvH5VNWB
        PDgKg0VxVm1xhGhm0TM4jzwvyZXlnOze3PhQz0ofJXL0vW6+a08GCc42ziINnk35mNyw0epBh98V7
        y2/V5vUN9/RA02A5DXN9Jj4NDNU5zIdQB3klxxPxpb0vs9+KTFYDFqdf4jaXjeWytxSwumBLpoPI9
        tCL4QvXJw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCMMu-0002R7-Mn; Mon, 23 Sep 2019 11:19:00 +0000
Date:   Mon, 23 Sep 2019 04:19:00 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Lin Feng <linf@wangsu.com>
Cc:     Michal Hocko <mhocko@kernel.org>, corbet@lwn.net,
        mcgrof@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        keescook@chromium.org, mchehab+samsung@kernel.org,
        mgorman@techsingularity.net, vbabka@suse.cz, ktkhai@virtuozzo.com,
        hannes@cmpxchg.org, Jens Axboe <axboe@kernel.dk>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: Is congestion broken?
Message-ID: <20190923111900.GH15392@bombadil.infradead.org>
References: <20190917115824.16990-1-linf@wangsu.com>
 <20190917120646.GT29434@bombadil.infradead.org>
 <20190918123342.GF12770@dhcp22.suse.cz>
 <6ae57d3e-a3f4-a3db-5654-4ec6001941a9@wangsu.com>
 <20190919034949.GF9880@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919034949.GF9880@bombadil.infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ping Jens?

On Wed, Sep 18, 2019 at 08:49:49PM -0700, Matthew Wilcox wrote:
> On Thu, Sep 19, 2019 at 10:33:10AM +0800, Lin Feng wrote:
> > On 9/18/19 20:33, Michal Hocko wrote:
> > > I absolutely agree here. From you changelog it is also not clear what is
> > > the underlying problem. Both congestion_wait and wait_iff_congested
> > > should wake up early if the congestion is handled. Is this not the case?
> > 
> > For now I don't know why, codes seem should work as you said, maybe I need to
> > trace more of the internals.
> > But weird thing is that once I set the people-disliked-tunable iowait
> > drop down instantly, this is contradictory to the code design.
> 
> Yes, this is quite strange.  If setting a smaller timeout makes a
> difference, that indicates we're not waking up soon enough.  I see
> two possibilities; one is that a wakeup is missing somewhere -- ie the
> conditions under which we call clear_wb_congested() are wrong.  Or we
> need to wake up sooner.
> 
> Umm.  We have clear_wb_congested() called from exactly one spot --
> clear_bdi_congested().  That is only called from:
> 
> drivers/block/pktcdvd.c
> fs/ceph/addr.c
> fs/fuse/control.c
> fs/fuse/dev.c
> fs/nfs/write.c
> 
> Jens, is something supposed to be calling clear_bdi_congested() in the
> block layer?  blk_clear_congested() used to exist until October 29th
> last year.  Or is something else supposed to be waking up tasks that
> are sleeping on congestion?
> 
> 
