Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037DAC3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EFF216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2IxfN0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfHVCAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 22:00:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54791 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfHVCAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 22:00:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so3980232wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 19:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Neq8F2IE+loetfqWGr83u3Nb5gDziGO0YW8bGklpRSk=;
        b=Q2IxfN0VJN1WKzqCJO8A+tVfpipjHvq7TiINzkF6NaD4G9YZHjQPL0L0h8Rab6pCRW
         WZdZBZmFXj7fldbE6UBZtcztEj5oTFHQRcr8FHGsULKGryFWVdWBbne0XITHZI970kc5
         gZeEUgyMpHMja7zWk0Nq/RQSolXM+kDzO0YTJ82tQxH9jIolrh5dQdhZxpojhOtuLLi3
         0l3Js9/98LOtiVRLyp2Fg/Ji4d+RLjOmy7FKT219bPNUDAPkmXbl8KMmZyLv0VyUFqDP
         ggssq5sPkIevsf5gQywEu/+rSJlOIsiXSvzzCUewTY6bA8+UBh/ZZZZqnY9S1GXkIs01
         vWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Neq8F2IE+loetfqWGr83u3Nb5gDziGO0YW8bGklpRSk=;
        b=i0eFWVEXE0I/URWDO+ndBlLiDYo7C+MgKSLXQ61anEPdP4iu8tmKb6rYT0aB1k6y1m
         vLsJC7vOGQInULGfRnmVMweeVXVBhlWeSCgpgcf3nkSnpWCz5jXONQTeFWtACP1ff0Og
         u/6IQl7Wkjw+TsWxH572AJd6i7r5Qs5vrDtx/jQH5JnfII4VKO5ucBDQM0kIOkaiSBWO
         gTHd6RN0EM1hhQRDPKy9VqaNZCugsCz4kgSR65+gutbaKJWAtD9gqvIab367zkFKpA7z
         vIB7grathXWWQtrCdrE2+myQbf590HM6sQvP/yzMgVG9LaKZPFtNxHzpGC64kQFE+ISL
         07nw==
X-Gm-Message-State: APjAAAVnrKtqUYsfnJLL84+LaHYwp2R2n49icZ7APPnrN596QVc3o3DG
        aPlPzEUFyskBkYCbn360Xnx4hhdnY2KzUnOUduY=
X-Google-Smtp-Source: APXvYqy2TY4yKAOPZzmAyczoa1p/ljS85yIuswYubQkIMpHB2+IdLq5lLqeffJ3j0gpokORD0HIUQZ9hCfgez8U4nDk=
X-Received: by 2002:a1c:c584:: with SMTP id v126mr3073188wmf.27.1566439244116;
 Wed, 21 Aug 2019 19:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
 <CACVXFVPCiTU0mtXKS0fyMccPXN6hAdZNHv6y-f8-tz=FE=BV=g@mail.gmail.com>
 <fd7d6101-37f4-2d34-f2f7-cfeade610278@huawei.com> <CY4PR21MB0741D1CD295AD572548E61D1CEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
 <20190821094406.GA28391@ming.t460p> <CY4PR21MB07410E84C8C7C1D64BD7BF41CEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
 <20190822013356.GC28635@ming.t460p>
In-Reply-To: <20190822013356.GC28635@ming.t460p>
From:   Keith Busch <keith.busch@gmail.com>
Date:   Wed, 21 Aug 2019 20:00:33 -0600
Message-ID: <CAOSXXT7LVjBqVW14y-pZyUCat3PBPd_nVd_uDahBdhyW+eHmcg@mail.gmail.com>
Subject: Re: [PATCH 0/3] fix interrupt swamp in NVMe
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Long Li <longli@microsoft.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        chenxiang <chenxiang66@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 7:34 PM Ming Lei <ming.lei@redhat.com> wrote:
> On Wed, Aug 21, 2019 at 04:27:00PM +0000, Long Li wrote:
> > Here is the command to benchmark it:
> >
> > fio --bs=3D4k --ioengine=3Dlibaio --iodepth=3D128 --filename=3D/dev/nvm=
e0n1:/dev/nvme1n1:/dev/nvme2n1:/dev/nvme3n1:/dev/nvme4n1:/dev/nvme5n1:/dev/=
nvme6n1:/dev/nvme7n1:/dev/nvme8n1:/dev/nvme9n1 --direct=3D1 --runtime=3D120=
 --numjobs=3D80 --rw=3Drandread --name=3Dtest --group_reporting --gtod_redu=
ce=3D1
> >
>
> I can reproduce the issue on one machine(96 cores) with 4 NVMes(32 queues=
), so
> each queue is served on 3 CPUs.
>
> IOPS drops > 20% when 'use_threaded_interrupts' is enabled. From fio log,=
 CPU
> context switch is increased a lot.

Interestingly use_threaded_interrupts shows a marginal improvement on
my machine with the same fio profile. It was only 5 NVMes, but they've
one queue per-cpu on 112 cores.
