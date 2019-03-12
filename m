Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107A6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C513E2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Hta5ADB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfCLPqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:46:53 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41006 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726272AbfCLPqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:46:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6B8298EE1ED;
        Tue, 12 Mar 2019 08:46:52 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xRUipMi-5v4r; Tue, 12 Mar 2019 08:46:52 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id ACA718EE0F5;
        Tue, 12 Mar 2019 08:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1552405612;
        bh=rtBt5DLADL8t5XJ0aWEYYr4qVgiTJN0Y03AmnFBmALQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Hta5ADB6diO123b+O9GGsaD3lTLmZxm0/SklZjxqjxFxREBbKMqH2pQq9KC9TpqUY
         FtBLt58elI9vQLiHqAfSyBBJn+aScF4ecBuiM54tPSDYp7m2jwOVqEwLyHHPM9lpUr
         kiGaEaRYtHEEndxKTdxFwSggNcuYAAt4p59ArUEw=
Message-ID: <1552405610.3083.17.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
 vmap()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     David Miller <davem@davemloft.net>, hch@infradead.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, linux-mm@kvack.org, aarcange@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Date:   Tue, 12 Mar 2019 08:46:50 -0700
In-Reply-To: <20190312075033-mutt-send-email-mst@kernel.org>
References: <20190308141220.GA21082@infradead.org>
         <56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
         <20190311095405-mutt-send-email-mst@kernel.org>
         <20190311.111413.1140896328197448401.davem@davemloft.net>
         <6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
         <20190311235140-mutt-send-email-mst@kernel.org>
         <76c353ed-d6de-99a9-76f9-f258074c1462@redhat.com>
         <20190312075033-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-12 at 07:54 -0400, Michael S. Tsirkin wrote:
> On Tue, Mar 12, 2019 at 03:17:00PM +0800, Jason Wang wrote:
> > 
> > On 2019/3/12 上午11:52, Michael S. Tsirkin wrote:
> > > On Tue, Mar 12, 2019 at 10:59:09AM +0800, Jason Wang wrote:
[...]
> > At least for -stable, we need the flush?
> > 
> > 
> > > Three atomic ops per bit is way to expensive.
> > 
> > 
> > Yes.
> > 
> > Thanks
> 
> See James's reply - I stand corrected we do kunmap so no need to
> flush.

Well, I said that's what we do on Parisc.  The cachetlb document
definitely says if you alter the data between kmap and kunmap you are
responsible for the flush.  It's just that flush_dcache_page() is a no-
op on x86 so they never remember to add it and since it will crash
parisc if you get it wrong we finally gave up trying to make them.

But that's the point: it is a no-op on your favourite architecture so
it costs you nothing to add it.

James

