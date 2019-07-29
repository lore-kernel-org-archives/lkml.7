Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49366C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B67A2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfG2I7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:59:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42536 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfG2I7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:59:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id h18so58897820qtm.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 01:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Q68Dj7R63I2Ecvb2PPGzHjYhrCQecwVv+3ZzbHMtRrM=;
        b=qas8u396FI0+gXYAvrXIYHISyvn/1Us62eFPlofRAeluIwUYnFOcCQKaXYJbYn0+J6
         F2Xz3iNw142Xluz3SwI7R2WGVFhxfhCXOx9EOJ4iAb0BF3FEt47gCLR7zCWWaBr9FHw6
         O91wFa5hvBD4++bJlS1oHJyMWkw1wA/yOtGV8UeABwLm/FDTh3AUNYKFG5DNTXKrAYZA
         ydYONGim5rFxvsYu9iqO8ajoiYX6J1YdaFnyW2tJbnjKvAYd3BYakkhByn2QVVXVmBOZ
         ttwXLlXBPQUP4UddkjftK6DKs6tO0w++TkRjfxrZAc0E0DBkA3N7yaYuhWRpGCuNW9fh
         nzHw==
X-Gm-Message-State: APjAAAVciAo62fiK1Vg6J8tNBNq9UfPkJaqy4OLy0SiO1yvOVSc0tblo
        cBmT5OJfKf4WLkl3yrTD6jkt+Q==
X-Google-Smtp-Source: APXvYqzdpBbLibFicHdiT5TefWqFoQxYcTCr3KhKgWnun67P5z4zFpu5Vd0tQv7j2SaN95sYflY5Ng==
X-Received: by 2002:aed:39e7:: with SMTP id m94mr80555924qte.0.1564390777624;
        Mon, 29 Jul 2019 01:59:37 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id z1sm27810714qke.122.2019.07.29.01.59.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 01:59:36 -0700 (PDT)
Date:   Mon, 29 Jul 2019 04:59:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     syzbot <syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jglisse@redhat.com,
        keescook@chromium.org, ldv@altlinux.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
Subject: Re: WARNING in __mmdrop
Message-ID: <20190729045127-mutt-send-email-mst@kernel.org>
References: <84bb2e31-0606-adff-cf2a-e1878225a847@redhat.com>
 <20190725092332-mutt-send-email-mst@kernel.org>
 <11802a8a-ce41-f427-63d5-b6a4cf96bb3f@redhat.com>
 <20190726074644-mutt-send-email-mst@kernel.org>
 <5cc94f15-b229-a290-55f3-8295266edb2b@redhat.com>
 <20190726082837-mutt-send-email-mst@kernel.org>
 <ada10dc9-6cab-e189-5289-6f9d3ff8fed2@redhat.com>
 <aaefa93e-a0de-1c55-feb0-509c87aae1f3@redhat.com>
 <20190726094756-mutt-send-email-mst@kernel.org>
 <0792ee09-b4b7-673c-2251-e5e0ce0fbe32@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0792ee09-b4b7-673c-2251-e5e0ce0fbe32@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 01:54:49PM +0800, Jason Wang wrote:
> 
> On 2019/7/26 下午9:49, Michael S. Tsirkin wrote:
> > > > Ok, let me retry if necessary (but I do remember I end up with deadlocks
> > > > last try).
> > > Ok, I play a little with this. And it works so far. Will do more testing
> > > tomorrow.
> > > 
> > > One reason could be I switch to use get_user_pages_fast() to
> > > __get_user_pages_fast() which doesn't need mmap_sem.
> > > 
> > > Thanks
> > OK that sounds good. If we also set a flag to make
> > vhost_exceeds_weight exit, then I think it will be all good.
> 
> 
> After some experiments, I came up two methods:
> 
> 1) switch to use vq->mutex, then we must take the vq lock during range
> checking (but I don't see obvious slowdown for 16vcpus + 16queues). Setting
> flags during weight check should work but it still can't address the worst
> case: wait for the page to be swapped in. Is this acceptable?
> 
> 2) using current RCU but replace synchronize_rcu() with vhost_work_flush().
> The worst case is the same as 1) but we can check range without holding any
> locks.
> 
> Which one did you prefer?
> 
> Thanks

I would rather we start with 1 and switch to 2 after we
can show some gain.

But the worst case needs to be addressed.  How about sending a signal to
the vhost thread?  We will need to fix up error handling (I think that
at the moment it will error out in that case, handling this as EFAULT -
and we don't want to drop packets if we can help it, and surely not
enter any error states.  In particular it might be especially tricky if
we wrote into userspace memory and are now trying to log the write.
I guess we can disable the optimization if log is enabled?).

-- 
MST
