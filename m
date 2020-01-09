Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45C0C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FC220661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbgAIQGs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:06:48 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:36117 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729642AbgAIQGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:06:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=gerry@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TnGGnLn_1578585967;
Received: from 192.168.0.100(mailfrom:gerry@linux.alibaba.com fp:SMTPD_---0TnGGnLn_1578585967)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Jan 2020 00:06:07 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
From:   "Liu, Jiang" <gerry@linux.alibaba.com>
In-Reply-To: <20200105054142-mutt-send-email-mst@kernel.org>
Date:   Fri, 10 Jan 2020 00:06:06 +0800
Cc:     Jason Wang <jasowang@redhat.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, jing2.liu@intel.com,
        chao.p.peng@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <02D38CC0-8DD5-44E1-92B2-0F9E97A112CE@linux.alibaba.com>
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <229e689d-10f1-2bfb-c393-14dfa9c78971@redhat.com>
 <0460F92A-3DF6-4F7A-903B-6434555577CC@linux.alibaba.com>
 <f8b46502-a5a5-c5c6-88df-101dbfd02fda@redhat.com>
 <56703BDA-B7AE-4656-8061-85FD1A130597@linux.alibaba.com>
 <20200105054142-mutt-send-email-mst@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 5, 2020, at 6:42 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> On Thu, Dec 26, 2019 at 09:16:19PM +0800, Liu, Jiang wrote:
>>> 2) The mask and unmask control is missed
>>> 
>>> 
>>>> but the extension doesn’t support 3) because
>>>> we noticed that the Linux virtio subsystem doesn’t really make use of interrupt masking/unmasking.
> 
> Linux uses masking/unmasking in order to migrate interrupts between
> CPUs.
This is a limitation of the PCI MSI/MSIx spec.
To update the MSI/MSIx vector configuration, we need to write to msg_high/msg_low/msg_data registers.
Because write to three 32-bit registers is not an atomic operation on PCI bus, so it may cause incorrect interrupt delivery if interrupt happens after writing 1 or 2 registers.
When Intel remapping is enabled on x86 platforms, we don’t need to mask/unmask PCI MSI/MSIx interrupts when setting affinity.
For MMIO MSI extension, we have special design to solve this race window. The flow to update MMIO MSI vector configuration is:
1) write msg_high
2) write msg_low
3) write msg_data
4) write the command register to update the vector configuration.
During step 1-3, the hardware/device backend driver only caches the value written. And update the vector configuration in step 4, so it’s an atomic operation now.
So mask/unmask becomes optional for MMIO MSI interrupts.

> 
> -- 
> MST

