Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1416CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EE520709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZqlhUfsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfKOBUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 20:20:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33668 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfKOBUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:20:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id a17so8897576wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 17:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEwX/NElu56DfPKMQfMKyoNPG/hLX02d8DoFpWEMAiE=;
        b=ZqlhUfsP9aPgr23HFim5P5t64hVHA1EMHsRxuhG08IOyPdE3yFr2PkA0w2BmO7QDkw
         bh9RDQmUzbWnql4OTTBVABXQzgPYLtIAT0VWnLhXazFQv9kocraSb90IKmX93tP+ZnNV
         xE53ge2niaFyFeSIGqIB+GEIlqeisI+QP/dYgQ599Szekv/BVcWVZm/Q6LmZVbg35siy
         v92R+oCnIvwBtFAIsUlYuRC4I3As2zWuHR2hq5Nmlgg926LRfNTezOj6mCCVmjaCDEB2
         eqMMVgkk0W2FgJd1xiivobUCCJ5m8p3DBXKfo66mWTH+NJCWbHNmzgPkg1V/9/mILBo8
         1APg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEwX/NElu56DfPKMQfMKyoNPG/hLX02d8DoFpWEMAiE=;
        b=CEljqTRiDWmPJZ78UZ9Rq60Y6dIn9+KkkkzVAynYz4StKJYklG8Azv3boK9vWradmC
         qhsXPGc2ZehVlESFhCPwAbwjzA17LSEMBxuhXMiUqGEbSJy22iXyhJsngnXh5SWwzOxh
         CfMjGe3tKQ3r19ptoxMBdBFjxVj7V0t/QbQ3hpHffqZMWH+oa36PI/V9D/YqFoBzAHxi
         TjH/rOoKPX2wA5NkFROVvdDRm5/oDyXSzpy5Onc1Ba5H/bhM/RWXMnt+aRlPU8z90Gwb
         ybx39Tdwy11w9TPHUmP0zWT6Hrd0vKhkZeqkqgE69ZIc5TyRpCDl0py1x2kLbidyemNe
         J8Bg==
X-Gm-Message-State: APjAAAWmFOfdS7515k8hdefJUYrIrUso4qyqt7zNnbd3702OFu/qLuql
        MB5EeMavxkmeKl4+NeDDLUbVlz4XOH9fOyqzN/xaAN/j
X-Google-Smtp-Source: APXvYqzziONe4wwOhvtSD0x3WiCYhwyw1CfcxXZh/W4dtWQ2BaQ64YV0i2I5mMk3TQgNIwh0P4xI3PP3xdPQjvpeF1E=
X-Received: by 2002:a1c:2e8f:: with SMTP id u137mr12151626wmu.105.1573780844641;
 Thu, 14 Nov 2019 17:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20191106074238.186023-1-pliard@google.com> <20191106083423.GA10679@lst.de>
 <20191106083711.GB10679@lst.de> <CAEThQxe2sNuCHoQfa30FVmtYkQ_zJsecdW2wmVmwafvne1RXSg@mail.gmail.com>
In-Reply-To: <CAEThQxe2sNuCHoQfa30FVmtYkQ_zJsecdW2wmVmwafvne1RXSg@mail.gmail.com>
From:   Philippe Liard <pliard@google.com>
Date:   Fri, 15 Nov 2019 10:20:33 +0900
Message-ID: <CAEThQxeC2qyUr+3EO7o+2p5tziXQ621SqaaxmF3jzheCKjpEkA@mail.gmail.com>
Subject: Re: [PATCH v3] squashfs: Migrate from ll_rw_block usage to BIO
To:     Christoph Hellwig <hch@lst.de>
Cc:     phillip@squashfs.org.uk, linux-kernel@vger.kernel.org,
        groeck@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 6:28 PM Philippe Liard <pliard@google.com> wrote:
>
> On Wed, Nov 6, 2019 at 5:37 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Sorry for the empty reply.
> >
> > This was meant to say that the patch looks good to me:
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Thanks!

FYI I'm unfortunately no longer observing the 40% impact announced in the
commit description after many optimizations landed in the Chrome OS VM
infrastructure.

Hopefully moving to BIO is still desirable though. Thank you in any case for
your help/guidance and all the time you spent reviewing this.
