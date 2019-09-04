Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2ABC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6082C2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387932AbfIDS6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:58:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387849AbfIDS6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:58:48 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC6AC11A19
        for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2019 18:58:47 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id z2so24234680qkf.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 11:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/t5VuocUMBlzPtybo/yvo5LJ1+xZJB/CRL/KCkZ7mqs=;
        b=hVbmnQ+bMfUuq5eDC5kW7FqXK/v54AyEbN8AnbIaFVvH/LjfhB778WyipYjXzak9kl
         UP9WtoRzYiypel8AGY4T1Tq+HqDH0ps8lykgFcHgVSYV/0gKnG7Q33FQMiz6Z10vpuNE
         cSjznGSuL1Ry9ZX39PEFan3Dea7xUOabx9ZEVMxUzKIfpWB79hXqRsgn2y/klIZRjG0q
         tXOlYmjmIvy1mOZD2EdfH15EH2VI6LU989VVfaKOCDclhC+RYGJnRi6oenU2VuNRT0nc
         31u1yY/mAbBWpLzIzfl1hefkRB5tqzhUCKil69L/yiVYKmGrGONu1veCaEqGX1xqTLE9
         wIWg==
X-Gm-Message-State: APjAAAWKjQvH7Sam84D6wp6UCoJPFtwi7OQz5gsKZcjuKEVm5rv2Isud
        XVzeHEfUrzNCTRSSnHM5SI59sTGFxOvkuztBVM/5R9fedDYJ2CneM0ZNTql+3StIDNhwDOHobT1
        x0sazvoa+pV8w+YM5JosZAmjU
X-Received: by 2002:aed:2538:: with SMTP id v53mr15724665qtc.383.1567623527125;
        Wed, 04 Sep 2019 11:58:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzxNgEnlGe+yk/4flae5AGAQL9JYjycpkVNDhpjV1tHwEkw6zA96VtT4UHpBEbs9AvgdMwM/Q==
X-Received: by 2002:aed:2538:: with SMTP id v53mr15724648qtc.383.1567623526926;
        Wed, 04 Sep 2019 11:58:46 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id b1sm9712741qkk.8.2019.09.04.11.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 11:58:45 -0700 (PDT)
Date:   Wed, 4 Sep 2019 14:58:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v4 15/16] virtio-fs: add virtiofs filesystem
Message-ID: <20190904145656-mutt-send-email-mst@kernel.org>
References: <20190903113640.7984-1-mszeredi@redhat.com>
 <20190903114203.8278-10-mszeredi@redhat.com>
 <20190903092222-mutt-send-email-mst@kernel.org>
 <20190904181630.GB26826@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904181630.GB26826@stefanha-x1.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 07:16:30PM +0100, Stefan Hajnoczi wrote:
> On Tue, Sep 03, 2019 at 09:55:49AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Sep 03, 2019 at 01:42:02PM +0200, Miklos Szeredi wrote:
> > Endian-ness for fuse header also looks wrong.
> [...]
> > > +struct virtio_fs_forget {
> > > +	struct fuse_in_header ih;
> > > +	struct fuse_forget_in arg;
> > 
> > These structures are all native endian.
> > 
> > Passing them to host will make cross-endian setups painful to support,
> > and hardware implementations impossible.
> > 
> > How about converting everything to LE?
> 
> The driver dictates the endianness of the FUSE protocol session.  The
> virtio-fs device specification states that the device looks at the first
> request's fuse_in_header::opcode field to detect the guest endianness.
> 
> If it sees FUSE_INIT in its native endianness then no byte-swapping is
> necessary.  If it sees FUSE_INIT in the opposite endianness then
> byte-swapping is necessary on the device side.


You are right.  Pls ignore the comment.  We need to reserve the
byte-swapped FUSE_INIT to make sure future versions of fuse don't try to
send that though.  I sent a patch to that effect, let's see whether it
gets accepted.


-- 
MST
