Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F632C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67417227B6
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbfGWHZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:25:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46568 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbfGWHZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:25:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so41921992wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 00:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sHDKTXWU/xgPgNMn/V0t0D27DplpYbCWQ39JljnO3KE=;
        b=od96aWqokQMPI5ndGL9pN/155MhED+GqUSvVLxh+vLZuSgZThJjAulFW52IXfPo9vG
         6QUD6vPqSPPzJ6hAAJmeGSufEWss5uQVxeklACOl0in7wnEuBJwWlp2c8je8QMye1RTV
         IonAzysL+08TWljV04BlJmUkFYyZ6eQzC7zL89KQvR+ihPneqXn5jJ9fDKgGizyG0OxI
         7t2chL3B2XripFn7iW14liceDfm3V76lZ4+UIH+Vr/kSKkhiEa104zL0lEAzd1MbtYrM
         F1XlNvdKCZlX2eX7p1Ux7B0yCjrgR0CPFR9a4GGamXY2r3o7TXsV3La/NhXlrBymVhtS
         hP3A==
X-Gm-Message-State: APjAAAVfjLmHENtrIKbGAoACnqXkRefLizq3CRW7wmQtPQoj5Tpkebja
        ytQCnYOp9KDrgd7yraH/06M60w==
X-Google-Smtp-Source: APXvYqz0SPP0qiQDLODbbW9L0gpUYgqPP98ti5rIHlXdUIG862jf2lYb199jfwAb8HW5mBizFMj7ug==
X-Received: by 2002:adf:dd03:: with SMTP id a3mr33103542wrm.87.1563866717486;
        Tue, 23 Jul 2019 00:25:17 -0700 (PDT)
Received: from redhat.com ([185.120.125.30])
        by smtp.gmail.com with ESMTPSA id o7sm36354317wmf.43.2019.07.23.00.25.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 00:25:16 -0700 (PDT)
Date:   Tue, 23 Jul 2019 03:25:11 -0400
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
Message-ID: <20190723032346-mutt-send-email-mst@kernel.org>
References: <0000000000008dd6bb058e006938@google.com>
 <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
 <75c43998-3a1c-676f-99ff-3d04663c3fcc@redhat.com>
 <20190722035657-mutt-send-email-mst@kernel.org>
 <cfcd330d-5f4a-835a-69f7-c342d5d0d52d@redhat.com>
 <20190723010156-mutt-send-email-mst@kernel.org>
 <124be1a2-1c53-8e65-0f06-ee2294710822@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <124be1a2-1c53-8e65-0f06-ee2294710822@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 01:48:52PM +0800, Jason Wang wrote:
> 
> On 2019/7/23 下午1:02, Michael S. Tsirkin wrote:
> > On Tue, Jul 23, 2019 at 11:55:28AM +0800, Jason Wang wrote:
> > > On 2019/7/22 下午4:02, Michael S. Tsirkin wrote:
> > > > On Mon, Jul 22, 2019 at 01:21:59PM +0800, Jason Wang wrote:
> > > > > On 2019/7/21 下午6:02, Michael S. Tsirkin wrote:
> > > > > > On Sat, Jul 20, 2019 at 03:08:00AM -0700, syzbot wrote:
> > > > > > > syzbot has bisected this bug to:
> > > > > > > 
> > > > > > > commit 7f466032dc9e5a61217f22ea34b2df932786bbfc
> > > > > > > Author: Jason Wang <jasowang@redhat.com>
> > > > > > > Date:   Fri May 24 08:12:18 2019 +0000
> > > > > > > 
> > > > > > >        vhost: access vq metadata through kernel virtual address
> > > > > > > 
> > > > > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149a8a20600000
> > > > > > > start commit:   6d21a41b Add linux-next specific files for 20190718
> > > > > > > git tree:       linux-next
> > > > > > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=169a8a20600000
> > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=129a8a20600000
> > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
> > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=e58112d71f77113ddb7b
> > > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10139e68600000
> > > > > > > 
> > > > > > > Reported-by: syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com
> > > > > > > Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual
> > > > > > > address")
> > > > > > > 
> > > > > > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > > > > > OK I poked at this for a bit, I see several things that
> > > > > > we need to fix, though I'm not yet sure it's the reason for
> > > > > > the failures:
> > > > > > 
> > > > > > 
> > > > > > 1. mmu_notifier_register shouldn't be called from vhost_vring_set_num_addr
> > > > > >       That's just a bad hack,
> > > > > This is used to avoid holding lock when checking whether the addresses are
> > > > > overlapped. Otherwise we need to take spinlock for each invalidation request
> > > > > even if it was the va range that is not interested for us. This will be very
> > > > > slow e.g during guest boot.
> > > > KVM seems to do exactly that.
> > > > I tried and guest does not seem to boot any slower.
> > > > Do you observe any slowdown?
> > > 
> > > Yes I do.
> > > 
> > > 
> > > > Now I took a hard look at the uaddr hackery it really makes
> > > > me nervious. So I think for this release we want something
> > > > safe, and optimizations on top. As an alternative revert the
> > > > optimization and try again for next merge window.
> > > 
> > > Will post a series of fixes, let me know if you're ok with that.
> > > 
> > > Thanks
> > I'd prefer you to take a hard look at the patch I posted
> > which makes code cleaner,
> 
> 
> I did. But it looks to me a series that is only about 60 lines of code can
> fix all the issues we found without reverting the uaddr optimization.
> 
> 
> >   and ad optimizations on top.
> > But other ways could be ok too.
> 
> 
> I'm waiting for the test result from syzbot and will post. Let's see if you
> are OK with that.
> 
> Thanks

Oh I didn't know one can push a test to syzbot and get back
a result. How does one do that?


> 
> > > > 
