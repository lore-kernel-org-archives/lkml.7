Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8A4C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0799222DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfHTPWL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:22:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfHTPWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:22:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6AD204DB1F;
        Tue, 20 Aug 2019 15:22:10 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E37711EC;
        Tue, 20 Aug 2019 15:22:09 +0000 (UTC)
Date:   Tue, 20 Aug 2019 09:22:09 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     luoben <luoben@linux.alibaba.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tao.ma@linux.alibaba.com, gerry@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com, linyunsheng@huawei.com
Subject: Re: [PATCH v3 0/3] genirq/vfio: Introduce update_irq_devid and
 optimize VFIO irq ops
Message-ID: <20190820092209.0c89effd@x1.home>
In-Reply-To: <a1a8f8bc-07c0-2304-8550-7c302704fa4e@linux.alibaba.com>
References: <cover.1565857737.git.luoben@linux.alibaba.com>
        <20190819145150.2d30669b@x1.home>
        <a1a8f8bc-07c0-2304-8550-7c302704fa4e@linux.alibaba.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 20 Aug 2019 15:22:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019 12:03:50 +0800
luoben <luoben@linux.alibaba.com> wrote:

> 在 2019/8/20 上午4:51, Alex Williamson 写道:
> > On Thu, 15 Aug 2019 21:02:58 +0800
> > Ben Luo <luoben@linux.alibaba.com> wrote:
> >  
> >> Currently, VFIO takes a lot of free-then-request-irq actions whenever
> >> a VM (with device passthru via VFIO) sets irq affinity or mask/unmask
> >> irq. Those actions only change the cookie data of irqaction or even
> >> change nothing. The free-then-request-irq not only adds more latency,
> >> but also increases the risk of losing interrupt, which may lead to a
> >> VM hung forever in waiting for IO completion  
> > What guest environment is generating this?  Typically I don't see that
> > Windows or Linux guests bounce the interrupt configuration much.
> > Thanks,
> >
> > Alex  
> 
> By tracing centos5u8 on host, I found it keep masking and unmasking 
> interrupt like this:
> 
> [1566032533709879] index:28 irte_hi:000000010004a601 
> irte_lo:adb54bc000b98001
> [1566032533711242] index:28 irte_hi:0000000000000000 
> irte_lo:0000000000000000
> [1566032533711258] index:28 irte_hi:000000000004a601 
> irte_lo:00003fff00ac002d
> [1566032533711269] index:28 irte_hi:000000000004a601 
> irte_lo:00003fff00ac002d
[snip] 
> "[1566032533720007]" is timestamp in μs, so centos5u8 tiggers 30+ irte 
> modification within 10ms

Ok, that matches my understanding that only very old guests behave in
this manner.  It's a curious case to optimize as RHEL5 is in extended
life-cycle support, with regular maintenance releases ending 2+ years
ago.  Thanks,

Alex
