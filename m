Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3264C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDF72081C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="itxzsdnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfDYOjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:39:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfDYOjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ox/A/M9f/YJNR/OkLo5ELVLHceNW1+cEY/T228JWq9Y=; b=itxzsdncAJJfxbIzDH3h8NzPR
        fTlTV7kliuirFPDQxRXM985hM+at1g/HkjfahIi1OLeEUCaf+KAVX02YgICFj+UNhHIUOpgPaLsiS
        YDBAzty13rzlzEOKjNy1EHM2hkjZdYRCcGSpDlJCNEuwVZ6WzpEzAlD/KBV01xSyj5Y9GaUoPJT01
        +8xZAcOHZeFmcoDdzYD72TonxajqOfTLu4zinLJg/XzJawVjhnIszArCawp7iPVn0SZFHPQXnGAGE
        mmcsE7ie4qmHCf49khEqFd98M1+pdz+T1HqLHtxcT92hPPHgy3Q9wpUaP4GyY39eOrbBXwXxqz5Fe
        WZQDNK7ig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJfWg-0000sH-RV; Thu, 25 Apr 2019 14:39:02 +0000
Date:   Thu, 25 Apr 2019 07:39:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     Keith Busch <kbusch@kernel.org>, keith.busch@intel.com,
        axboe@fb.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH] nvme: determine the number of IO queues
Message-ID: <20190425143902.GA30715@infradead.org>
References: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
 <a2f0a97e14b884dc1183db9cbdd6f4b520000ce3.camel@redhat.com>
 <096935354b16662eb481aeda1f48001ba489463c.camel@redhat.com>
 <e79703d5-3502-6519-a497-71b2b2a8768f@canonical.com>
 <20190418134820.GA7589@localhost.localdomain>
 <ddabda2a-b30d-77cc-7b2e-05a6b599cae7@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddabda2a-b30d-77cc-7b2e-05a6b599cae7@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 10:21:03PM +0800, Aaron Ma wrote:
> 
> 
> On 4/18/19 9:48 PM, Keith Busch wrote:
> > It does change the default behavior. If I have a degraded controller that
> > can't do IO in a machine with 1000's of CPUs, I have to iterate this
> > non-standard behavior 1000's of times before the drive is servicable
> > again. We currenlty figure that out in just a single try.
> > 
> > At least the quirks document *why* the driver is doing non-standard
> > behavior. We do the IO queue quirks for Macbooks, for example.
> > 
> > But why don't you file a bug report with the device vendor instead? Surely
> > a firmware fix provides the best possible outcome, and would make this
> > device work not only in all versions of Linux, but also every standard
> > compliant driver for any OS.
> 
> I will do it, no v2 for now.

Honestly, unless this is a device shiping in a max market consumer
product already I don't think we should work around this crap at all,
given that this device has obviously never been tested at all.  It
really needs a firmware fix instead of a host workaround.
