Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0DAC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B5A20856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfGYGCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:02:53 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38199 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfGYGCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:02:52 -0400
Received: by mail-qk1-f196.google.com with SMTP id a27so35611323qkk.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 23:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zOvrC4jRrz0ugoagicTAba2I/X1iVC+b4ZZraA+kmso=;
        b=ZzWI7O/fN98tTQkI3qHL6OagWDYbr9Ft4HU+TDYKP5+jeZg8SZjNWZ+gmufBXeY15m
         7sN3V+SnaFhEHHl1YxswC7bQi/qrwcKbiGsSqmCXATMFE3W5J8D1c2Pk7k6ljjib70V1
         3crSxUwo+r4ouCnKSJnuoImhat/voniA+LkQ/lop0BP4g4Y5UuZG3obWDmrjF2fat9JO
         vyRCLoy15wmI+j2NTNkiRe8n6S5zXZHxqBdbvPs0JqXA9XI5PjPPSJl3mv8bR0jelSJv
         bfR66k76cFYMWiOZU4DZ4OEAksHhNRqWYb/wlE/Uiyqg5XCRB5Zpa/l1EcqqgfSsm1V5
         WEsw==
X-Gm-Message-State: APjAAAX0lATPQ9D/Nm8L7zS70IQRPUMdQuwHwcH0icpY+dclyQr71YBh
        hVxjg4oDELwHk8aeopCYq1fa0g==
X-Google-Smtp-Source: APXvYqwbxlaMB/Ups0MK5ym5+FoeShoFD8maMViZfmHscXpKdz4RszQUYRwaBR+eewotyh05tZCO4w==
X-Received: by 2002:a37:aa04:: with SMTP id t4mr57308995qke.359.1564034571775;
        Wed, 24 Jul 2019 23:02:51 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id i62sm22519634qke.52.2019.07.24.23.02.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 23:02:50 -0700 (PDT)
Date:   Thu, 25 Jul 2019 02:02:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     syzbot <syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jasowang@redhat.com,
        jglisse@redhat.com, keescook@chromium.org, ldv@altlinux.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
Subject: Re: WARNING in __mmdrop
Message-ID: <20190725015402-mutt-send-email-mst@kernel.org>
References: <0000000000008dd6bb058e006938@google.com>
 <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
 <20190722141152.GA13711@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722141152.GA13711@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:11:52AM -0300, Jason Gunthorpe wrote:
> On Sun, Jul 21, 2019 at 06:02:52AM -0400, Michael S. Tsirkin wrote:
> > On Sat, Jul 20, 2019 at 03:08:00AM -0700, syzbot wrote:
> > > syzbot has bisected this bug to:
> > > 
> > > commit 7f466032dc9e5a61217f22ea34b2df932786bbfc
> > > Author: Jason Wang <jasowang@redhat.com>
> > > Date:   Fri May 24 08:12:18 2019 +0000
> > > 
> > >     vhost: access vq metadata through kernel virtual address
> > > 
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149a8a20600000
> > > start commit:   6d21a41b Add linux-next specific files for 20190718
> > > git tree:       linux-next
> > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=169a8a20600000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=129a8a20600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=e58112d71f77113ddb7b
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10139e68600000
> > > 
> > > Reported-by: syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com
> > > Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual
> > > address")
> > > 
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > 
> > 
> > OK I poked at this for a bit, I see several things that
> > we need to fix, though I'm not yet sure it's the reason for
> > the failures:
> 
> This stuff looks quite similar to the hmm_mirror use model and other
> places in the kernel. I'm still hoping we can share this code a bit more.

Right. I think hmm is something we should look at.

-- 
MST
