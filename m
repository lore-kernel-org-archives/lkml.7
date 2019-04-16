Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88940C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB6B2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aTG7g5Ov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbfDPRnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:43:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34638 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfDPRnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:43:00 -0400
Received: from zn.tnic (p200300EC2F0D69007D63E3F8FEB0C818.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6900:7d63:e3f8:feb0:c818])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 725A51EC013F;
        Tue, 16 Apr 2019 19:42:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555436579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=piRcqDsXit6RX2mOm+UqwZdg7tVVMYbv1+su5eaXx74=;
        b=aTG7g5OvQtHVi2VTNvzC3xSo0BxhNJfBYA+yLXqjbzeWSEE6aPGeqXoTr7VNih7AqLyYpm
        JtJjCNpbGhGI0yUovbWtk1GwIW9/+hWeJbzlBejQmJ3VkEIErKT1nOvNOCw77BByp7I28L
        SyGxmlQbdIVW//Y+g99igQKtt6VGJY4=
Date:   Tue, 16 Apr 2019 19:42:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] ras: close the race condition with timer
Message-ID: <20190416174259.GK31772@zn.tnic>
References: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
 <20190416012001.5338-2-xiyou.wangcong@gmail.com>
 <20190416095852.GA31772@zn.tnic>
 <CAM_iQpU6+xD+LmVtd=GPVp2zXgmLjT8tstRa7ia0pNgO0AcaPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM_iQpU6+xD+LmVtd=GPVp2zXgmLjT8tstRa7ia0pNgO0AcaPA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:09:49AM -0700, Cong Wang wrote:
> They are just locks requiring different contexts, I don't see how one is
> simpler than the other. Do you mind to be more specific?

Yes, I'd like for this whole CEC code to be lazy and preemptible as it
is not at all important when it does its work, as long as it gets it
done eventually.

Can't be preemptible with spinlocks.

> By workqueue, you must mean to say delayed work, right?
>
> But the global workqueue is not serialized either,

Serialized with what? Insertions?

That's what the mutex is for and the insertions happen in process
context.

So yeah, delayed_work sounds like what it should do. I.e.,
queue_delayed_work() and decay_interval_set() should do
mod_delayed_work(). Something along those lines, anyways.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
