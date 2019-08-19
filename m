Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_HDRS_LCASE,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81612C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDA12086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfHSISr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 04:18:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46140 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfHSISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 04:18:47 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzcsF-00072C-Is; Mon, 19 Aug 2019 10:18:43 +0200
Date:   Mon, 19 Aug 2019 10:18:42 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     luoben <luoben@linux.alibaba.com>
cc:     alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        tao.ma@linux.alibaba.com, gerry@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com, linyunsheng@huawei.com
Subject: Re: [PATCH v3 2/3] genirq: introduce update_irq_devid()
In-Reply-To: <8161633d-638d-f4b2-f225-462f711c1212@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1908191005530.1923@nanos.tec.linutronix.de>
References: <cover.1565857737.git.luoben@linux.alibaba.com> <6343a7e34ffdd0ddcd730996fc5dad3024e42251.1565857737.git.luoben@linux.alibaba.com> <alpine.DEB.2.21.1908151622410.1908@nanos.tec.linutronix.de>
 <8161633d-638d-f4b2-f225-462f711c1212@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-553920558-1566202723=:1923"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-553920558-1566202723=:1923
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Ben,

On Mon, 19 Aug 2019, luoben wrote:
> 在 2019/8/15 下午10:58, Thomas Gleixner 写道:
> > > This narrows the gap for setting up new irq (and irte, if has)
> > What does that mean: "narrows the gap"
> > 
> > What's the gap and why is it only made smaller and not closed?
> 
> Sorry for confusing. The so called 'gap' is a time window between free_irq()
> and request_irq().

And exactly this information wants to be in the changelog.
 
> > function please. Also it does not matter whether the time is short or
> > not. The point is:
> > 
> >       	 Ensure that an interrupt in flight on another CPU which uses
> > the
> >       	 old 'dev_id' has completed because the caller can free the
> > memory
> > 	 to which it points after this function returns.
> > 
> > But this has another twist:
> > 
> >      CPU0				CPU1
> > 
> >      interrupt
> >      	primary_handler(old_dev_id)
> > 	   do_stuff_on(old_dev_id)
> > 	   return WAKE_THREAD;		update_dev_id()
> >          wakeup_thread();
> > 					  action->dev_id = new_dev_id;
> >      irq_thread()
> >          secondary_handler(new_dev_id)
> > 	
> > That's broken and synchronize_irq() does not protect against it.
> 
> Thanks to point it out, I will change to the following in next version, is
> that ok?
> 
> ...
> 
>     /*

  ^^^
Please use a mail client which does not insert random wierd characters.

>      * Ensure that an interrupt in flight on another CPU which uses the
>      * old 'dev_id' has completed because the caller can free the memory
>      * to which it points after this function returns. And also void to

s/void/avoid/

>      * update 'dev_id' in the middle of a threaded interrupt process, it
>      * can lead to a twist that primary handler uses old 'dev_id' but new
>      * 'dev_id' is used by secondary handler.
>      */
>     disable_irq(irq);

Yes, that works.

Thanks,

	tglx
--8323329-553920558-1566202723=:1923--
