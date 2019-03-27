Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AA1C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E522082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfC0IQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:16:29 -0400
Received: from verein.lst.de ([213.95.11.211]:40421 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfC0IQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:16:29 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 48B1568B05; Wed, 27 Mar 2019 09:16:19 +0100 (CET)
Date:   Wed, 27 Mar 2019 09:16:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     luferry <luferry@163.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make blk_mq_map_queues more friendly for cpu topology
Message-ID: <20190327081619.GG20525@lst.de>
References: <20190325152640.48120-1-luferry@163.com> <20190326073954.GD21617@lst.de> <48ca2186.fc76.169b8fef63a.Coremail.luferry@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48ca2186.fc76.169b8fef63a.Coremail.luferry@163.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 03:55:10PM +0800, luferry wrote:
> 
> 
> 
> At 2019-03-26 15:39:54, "Christoph Hellwig" <hch@lst.de> wrote:
> >Why isn't this using the automatic PCI-level affinity assignment to
> >start with?
> 
> When enable virtio-blk with multi queues but with only 2 msix-vector.
> vp_dev->per_vq_vectors will be false, vp_get_vq_affintity will return NULL directly
> so blk_mq_virtio_map_queues will fallback to blk_mq_map_queues.

What is the point of the multiqueue mode if you don't have enough
(virtual) MSI-X vectors?
