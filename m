Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68FFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1A22067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKLHSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:18:24 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:35407 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725283AbfKLHSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:18:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Thsv3KG_1573543100;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0Thsv3KG_1573543100)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Nov 2019 15:18:20 +0800
Date:   Tue, 12 Nov 2019 15:18:19 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     davem@davemloft.net, shemminger@osdl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: remove static inline from dev_put/dev_hold
Message-ID: <20191112071819.GB67139@TonyMac-Alibaba>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20191111140502.17541-1-tonylu@linux.alibaba.com>
 <20191111085632.24d88706@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111085632.24d88706@hermes.lan>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 08:56:32AM -0800, Stephen Hemminger wrote:
> On Mon, 11 Nov 2019 22:05:03 +0800
> Tony Lu <tonylu@linux.alibaba.com> wrote:
> 
> > This patch removes static inline from dev_put/dev_hold in order to help
> > trace the pcpu_refcnt leak of net_device.
> > 
> > We have sufferred this kind of issue for several times during
> > manipulating NIC between different net namespaces. It prints this
> > log in dmesg:
> > 
> >   unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > 
> > However, it is hard to find out who called and leaked refcnt in time. It
> > only left the crime scene but few evidence. Once leaked, it is not
> > safe to fix it up on the running host. We can't trace dev_put/dev_hold
> > directly, for the functions are inlined and used wildly amoung modules.
> > And this issue is common, there are tens of patches fix net_device
> > refcnt leak for various causes.
> > 
> > To trace the refcnt manipulating, this patch removes static inline from
> > dev_put/dev_hold. We can use handy tools, such as eBPF with kprobe, to
> > find out who holds but forgets to put refcnt. This will not be called
> > frequently, so the overhead is limited.
> > 
> > Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
> 
> In the past dev_hold/dev_put was in the hot path for several
> operations. What is the performance implication of doing this?

From code analysis, there should be a little performance backwards.
I don't have the benchmark data for now. I will make a kernel module to
take a series of benchmarks for dev_put/dev_hold. Actually there is a plan
to take a whole solution for this issue. The benchmarks will be done
after this.

Cheers
Tony Lu
