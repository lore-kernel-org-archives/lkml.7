Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F85C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F3B218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tR9ODxM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfCOH5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:57:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43781 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfCOH5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:57:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17so8488517wre.10;
        Fri, 15 Mar 2019 00:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FDToaXoGDM3HZpW27l4n5SxEsOzQOt6FD5PqD/o0Mu8=;
        b=tR9ODxM1Uzy7lUWblPlmK+PjJqLPegZvtFyo6b1vpYP/FIYwGwhkIbQoCAZNhI0lz/
         CcTjnKCfrAfZpAL8GKFCZ+gYBnIQL+aBzevN2+FaQgNjBmcJBmAZsM38AfyHPU74zzY3
         xfVGCALQ8Da8F0lO0sTaeDKUKkwqODvg6nCdV3hrWgwuPHmbSmyE2NPPIjFHlVV6xcvA
         ucasa7Sk7aM4TDGkIABdAse4h0EUZhepA/6ZozrVF5m2VslGTxG8gwEJJ7v3cOHxT8v6
         jbh+pcvMdOlV6//1LedpbIVYaHHdFi/98xF0EOaQQ8bEC202c0XQbzVrtfUrNVOHTWc7
         8kJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDToaXoGDM3HZpW27l4n5SxEsOzQOt6FD5PqD/o0Mu8=;
        b=e/avC5E6dsHxkX8pUT7aokD2J0uKmM5jxp0SG0XX/W0GrP9LaLvkfyC+Gb5GH4souU
         /K828wOEjoXyShKKAjgpluxqwP4UnAydX/shTlMUqBkwOOsgqMPhE3p4ylYbjWpPh7hD
         my74Fg0HJp4Oyp3jcjHyRh51/406VC2QZq5U6LTKENR8ED3QWwwpsC3/VSXpulHht6qr
         6JXvqehSRMGiI8moseuTztG7rMWKjAfROMfMlTScyneANfbp7Q5X12DDmWmCiYXXp4be
         DCdLpVxJoh7LzP6ZvvX0UEarmTbGYgJwiGcplL02Vued7WuYAe+T/OmpZMRjLr4KESZx
         Ok3w==
X-Gm-Message-State: APjAAAVA0wbHywIGvRpUnKWdhHLANJbslHRy2WoVEahkKbDBBFX3A31t
        M/lKnSAAop+Ej5sGNoHXO5FEhpFZaARPjmHDOEA=
X-Google-Smtp-Source: APXvYqzpoxMoT/Ju2INd2ZSjBzaRfiB7dzdm6gvcPCR/R8t1lhzWjsib7geq5yqTJH3X1x8GHVqw0CfOf1XskszZrxs=
X-Received: by 2002:adf:d081:: with SMTP id y1mr1332114wrh.283.1552636628689;
 Fri, 15 Mar 2019 00:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190219072743.13606-1-yanaijie@huawei.com> <1550595388.31902.133.camel@acm.org>
 <20190220151836.GA11695@infradead.org> <10ea95ec-e259-3511-44c4-58e4d255eb9f@huawei.com>
In-Reply-To: <10ea95ec-e259-3511-44c4-58e4d255eb9f@huawei.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 15 Mar 2019 15:56:56 +0800
Message-ID: <CACVXFVMWDD+8rrVh9TYnA6awLPQZNscC6OrYmpAizj9PxxuZJw@mail.gmail.com>
Subject: Re: [RFC PATCH] scsi: fix oops in scsi_uninit_cmd()
To:     Jason Yan <yanaijie@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Steffen Maier <maier@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 4:55 PM Jason Yan <yanaijie@huawei.com> wrote:
>
> Hi, Christoph
>
> On 2019/2/20 23:18, Christoph Hellwig wrote:
> > [fullquote removed, please follow proper mail etiquette]
> >
> > On Tue, Feb 19, 2019 at 08:56:28AM -0800, Bart Van Assche wrote:
> >> regression in the SCSI sd driver due to the switch from the legacy block
> >> layer to scsi-mq. The above patch introduces two atomic operations in the
> >> hot path and hence would introduce a performance regression. I think this
> >> can be avoided by making sure that sd_uninit_command() gets called before
> >> the request tag is freed. What changes would be required to make the block
> >> layer core call sd_uninit_command() before the request tag is freed? Would
> >> introducing prep_rq_fn and unprep_rq_fn callbacks in struct blk_mq_ops and
> >> making sure that the SCSI core sets these callback function pointers
> >> appropriately be sufficient? Would such a change allow to simplify the NVMe
> >> initiator driver? Are there any alternatives to this approach that are more
> >> elegant?
> >
> > Additional indirect calls in the I/O fast path is something I'd rather
> > avoid.  But I don't fully understand the problem yet - where do
> > we release a disk reference from blk_update_request?
>
> When userspace close the fd after blk_update_request() and before
> scsi_mq_uninit_cmd(), a disk reference will be released. It is not the
> blk_update_request() directly released it.
>
> close
>     ->sd_release
>        ->scsi_disk_put
>          ->scsi_disk_release
>            ->disk->private_data = NULL;
>
> The userspace can close the fd because blk_update_request() returned the
> last IO , the userspace application does not have to stuck on read() or
> write(). The window is very small, but it can be reproduce every day
> in our testcases. So I'm very curious why. One possible explanation is
> that we enabled kernel preempt(CONFIG_PREEMPT).

Another solution is to drain in-flight FS IO in scsi_disk_release(),
and one counter
is needed for tracking in-flight passthrough IO, so we can use sdev->device_busy
- sdev->passthrough_ios to drain inflight FS IO.

>
> And why can't
> > we move that release to __blk_mq_end_request?

I think it is doable, then ending bio needs to be moved out of
blk_update_request(),
such as, add one list of rq->done_bio to track completed bio, then complete all
in free request.

And for partial completion, the completed bio can be done in
blk_update_request(),
since the remained bios will cause fs to hold the disk.


Thanks,
Ming Lei
