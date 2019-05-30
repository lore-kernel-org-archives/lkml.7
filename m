Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F14C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254DD26032
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfE3Szv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:55:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57602 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfE3Szu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:55:50 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D87A914D9DD5B;
        Thu, 30 May 2019 11:55:49 -0700 (PDT)
Date:   Thu, 30 May 2019 11:55:49 -0700 (PDT)
Message-Id: <20190530.115549.1509561180724590494.davem@davemloft.net>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        James.Bottomley@hansenpartnership.com, hch@infradead.org,
        jglisse@redhat.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        christophe.de.dinechin@gmail.com, jrdr.linux@gmail.com
Subject: Re: [PATCH net-next 0/6] vhost: accelerate metadata access
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190530141243-mutt-send-email-mst@kernel.org>
References: <20190524081218.2502-1-jasowang@redhat.com>
        <20190530.110730.2064393163616673523.davem@davemloft.net>
        <20190530141243-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 May 2019 11:55:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 30 May 2019 14:13:28 -0400

> On Thu, May 30, 2019 at 11:07:30AM -0700, David Miller wrote:
>> From: Jason Wang <jasowang@redhat.com>
>> Date: Fri, 24 May 2019 04:12:12 -0400
>> 
>> > This series tries to access virtqueue metadata through kernel virtual
>> > address instead of copy_user() friends since they had too much
>> > overheads like checks, spec barriers or even hardware feature
>> > toggling like SMAP. This is done through setup kernel address through
>> > direct mapping and co-opreate VM management with MMU notifiers.
>> > 
>> > Test shows about 23% improvement on TX PPS. TCP_STREAM doesn't see
>> > obvious improvement.
>> 
>> I'm still waiting for some review from mst.
>> 
>> If I don't see any review soon I will just wipe these changes from
>> patchwork as it serves no purpose to just let them rot there.
>> 
>> Thank you.
> 
> I thought we agreed I'm merging this through my tree, not net-next.
> So you can safely wipe it.

Aha, I didn't catch that, thanks!
