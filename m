Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95129C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1A724CD0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="W98FsN7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbfE3EC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:02:29 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:6226 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388150AbfE3ECW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 00:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559188941; x=1590724941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UkRYNR5hm0gc7X8fxqjNJQmr3n5Ab3tDm3l1W9pl4Bw=;
  b=W98FsN7u+uCMaZmEJeuY//BVPO9DY4FRBfJ3Hx77kb2QEbdgKN1rMghY
   bHjOg+WrOT69K23mYXqkh65CIom9I5wWqzYQpxoZW/kp8gxE+vEliyxBl
   2zXW/jStey7QStRjvDC5ytNo2ft00BJDDHBZTYYDeA02PU9uV/hmO8wMz
   s=;
X-IronPort-AV: E=Sophos;i="5.60,529,1549929600"; 
   d="scan'208";a="768214243"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 30 May 2019 04:02:19 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id 0630FA2204;
        Thu, 30 May 2019 04:02:18 +0000 (UTC)
Received: from EX13D05UWB002.ant.amazon.com (10.43.161.50) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 30 May 2019 04:02:18 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D05UWB002.ant.amazon.com (10.43.161.50) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 30 May 2019 04:02:18 +0000
Received: from localhost (10.94.220.85) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 30 May 2019 04:02:17 +0000
Date:   Wed, 29 May 2019 21:02:17 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     "Wang, Haiyue" <haiyue.wang@linux.intel.com>
CC:     Eduardo Valentin <eduval@amazon.com>, <wsa@the-dreams.de>,
        <brendanhiggins@google.com>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
        <jarkko.nikula@linux.intel.com>, <andriy.shevchenko@intel.com>,
        <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH i2c/slave-mqueue v5] i2c: slave-mqueue: add a slave
 backend to receive and queue messages
Message-ID: <20190530040217.GB17772@u40b0340c692b58f6553c.ant.amazon.com>
References: <1524503192-4176-1-git-send-email-haiyue.wang@linux.intel.com>
 <20190523220345.GA3417@u40b0340c692b58f6553c.ant.amazon.com>
 <35a9d066-c732-cb00-04a5-438c948915ae@linux.intel.com>
 <20190524173353.GA6428@u40b0340c692b58f6553c.ant.amazon.com>
 <bf1e8f0b-5bd0-fb43-c19b-9487603b9ee3@linux.intel.com>
 <20190529231100.GA18339@u40b0340c692b58f6553c.ant.amazon.com>
 <75cb9514-bb3a-9c3b-05df-0c3517bd775a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75cb9514-bb3a-9c3b-05df-0c3517bd775a@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 09:33:34AM +0800, Wang, Haiyue wrote:
> 
> 在 2019-05-30 07:11, Eduardo Valentin 写道:
> >>>>>>+
> >>>>>>+	case I2C_SLAVE_WRITE_RECEIVED:
> >>>>>>+		if (msg->len < MQ_MSGBUF_SIZE) {
> >>>>>>+			msg->buf[msg->len++] = *val;
> >>>>>Do we need to lock the accesses to msg->buf? how about to msg->len?
> >>>this code goes access and modify data here, e.g. msg->len and msg->buf.
> >>>
> >>>On this case (I2C_SLAVE_WRITE_RECEIVED), this code wont protect access.
> >>>
> >>>This can cause concurrence issues if you receive an IRQ when the user
> >>>is on your bin_read().
> >>User will not touch 'msg = mq->curr;', just touch 'msg =
> >>&mq->queue[mq->out];'
> >What happens if mq->curr == mq->queue[mq->out]?
> >
> 1. The Read will check.
> 
> +	spin_lock_irqsave(&mq->lock, flags);
> +	if (mq->out != mq->in) {
> +		msg = &mq->queue[mq->out];
> 
> 2. Flush the oldeast message. ^_^
> 
> +	case I2C_SLAVE_STOP:
> +		if (unlikely(mq->truncated || msg->len < 2))
> +			break;
> +
> +		spin_lock(&mq->lock);
> +		mq->in = MQ_QUEUE_NEXT(mq->in);
> +		mq->curr = &mq->queue[mq->in];
> +		mq->curr->len = 0;
> +
> +		/* Flush the oldest message */
> +		if (mq->out == mq->in)
> +			mq->out = MQ_QUEUE_NEXT(mq->out);

Yeah, I see. We keep on dropping messages (old ones) when the queue is full...

> +		spin_unlock(&mq->lock);
> 

-- 
All the best,
Eduardo Valentin
