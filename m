Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC095C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC4C21871
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552757072;
	bh=8to/P3PsLhQReCP0d6TVof3iBe/fXTx0wSvTMdC9WQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U0mwPDvqzEOh79TdD0rmCaQyjBmCWuFrJBQUsZuyw5UamPnoFr2bjmtRM4Vvf714I
	 nIPjNBNoXMPuBfQL5ghgR4TgpiPS4r1EkClxdqNIXTvpMcguxk5yNGoVR2mDNzKIko
	 QnM1plq0m0Ky/xXbj9/2uDg0/8ykdie6J3KY3Pd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfCPRYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:24:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34460 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfCPRYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 13:24:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id j25so4141462lji.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HU0TPlqyFJBx/remsyCVpTwJHhHOt/JtHhUjMDUl0gw=;
        b=QweJcVpa5lsLq/Nlg1EtR6DOyxjGM5yXX89kuGbH/xTxvLp499X39O8h0cEPqLoY20
         2fwd0St3HzYk0p2QBb/RLNedSsz9USvZr9qj1JdlHcIjWh1VW4fIGyXr0H5ML52lVmCt
         e6sYw/U1qb59OOiqbML4W+uI6/9fIk8T+9Bqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HU0TPlqyFJBx/remsyCVpTwJHhHOt/JtHhUjMDUl0gw=;
        b=pVegybilptxRacdiOA41wAn0KDpFVpgAgIoCJCRneQes7T5KLLJ3CFwdBD7WH1/lVA
         IhXDFxjQXz8srIhgquLIQY1B0sQrGa8mpWWBIHcDTQzq84CYCVBgunN+rLxw5dxnCknZ
         hbbGcFDLD8h8kpvuUfIN8pFBTyUQCcrgTSG3NZPxhIZlrdSMjLep8Y30Au+n7MbBKOk4
         UEiG4DSJvDeatdwpy1wHS9plh4xWJVBB+PyCLk1Rp/H41iw9G95PuwKjkrhFpFtTjQ+M
         KerDvLW/DcVCtgeAoZrP42/81Yl00RQVHLpEeSy/gRMMx5exbwj8QWdgr9TARGcOC2/Z
         XnSQ==
X-Gm-Message-State: APjAAAXseSYhH2y2QHbUdQUC/P05HtcH99/pFa8xNQdeM7dYoVMl7HyF
        J8m5yi2foJZ1YE8yGbytE38ABgLnaoI=
X-Google-Smtp-Source: APXvYqx/1iTTEkyHIaF+JQH9A7ulA/NS/rYLfUnx8uB8+FZYqAv97XNgEtD8MAfihYk0a1+siC7qqQ==
X-Received: by 2002:a2e:6e0f:: with SMTP id j15mr5333247ljc.120.1552757067517;
        Sat, 16 Mar 2019 10:24:27 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id k21sm1123951lfg.90.2019.03.16.10.24.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 10:24:26 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id z20so10566270ljj.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 10:24:26 -0700 (PDT)
X-Received: by 2002:a2e:94ca:: with SMTP id r10mr4780377ljh.118.1552757065934;
 Sat, 16 Mar 2019 10:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000675cea057e201cbb@google.com>
In-Reply-To: <000000000000675cea057e201cbb@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Mar 2019 10:24:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjAD7oaENrHCcFQ5=h4xd6zMbMmLb2=TKMDxWEA_7XrjA@mail.gmail.com>
Message-ID: <CAHk-=wjAD7oaENrHCcFQ5=h4xd6zMbMmLb2=TKMDxWEA_7XrjA@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in slhc_free
To:     syzbot <syzbot+6c5d567447bfa30f78e2@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        tejaswit@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 6:41 PM syzbot
<syzbot+6c5d567447bfa30f78e2@syzkaller.appspotmail.com> wrote:
>
> Reported-by: syzbot+6c5d567447bfa30f78e2@syzkaller.appspotmail.com
>
> BUG: unable to handle kernel paging request at fffffffffffffff4
> RIP: slhc_free+0x30/0xb0 drivers/net/slip/slhc.c:159
> Call Trace:
>   sl_alloc_bufs drivers/net/slip/slip.c:196 [inline]
>   slip_open+0xdee/0x1107 drivers/net/slip/slip.c:821

The error handling in sl_alloc_bufs() is broken.

It does

        slcomp = slhc_init(16, 16);
        if (IS_ERR(slcomp))
                goto err_exit;

and knows that the error case returns an error pointer, but then the
'err_exit:' code just does

        slhc_free(slcomp);

which doesn't handle error pointers.

The slhc code in general is pretty odd, presumably for some legacy
reason. It does things like

        if ( comp == NULLSLCOMPR )
                return;

to compare against NULL. That's some crazy stuff.

I don't think anybody really wants to bother with slip any more, and
the simplest fix seems to just be to let slhc_free() handle all the
error pointers that slhc_init() can return, and do something  like
this:

   drivers/net/slip/slhc.c | 2 +-
   1 file changed, 1 insertion(+), 1 deletion(-)

  diff --git a/drivers/net/slip/slhc.c b/drivers/net/slip/slhc.c
  index f4e93f5fc204..3ee19a5b03a1 100644
  --- a/drivers/net/slip/slhc.c
  +++ b/drivers/net/slip/slhc.c
  @@ -153,7 +153,7 @@ slhc_init(int rslots, int tslots)
   void
   slhc_free(struct slcompress *comp)
   {
  -       if ( comp == NULLSLCOMPR )
  +       if (IS_ERR_OR_NULL(comp))
                  return;

          if ( comp->tstate != NULLSLSTATE )

which is obviously and intentionally whitespace-damaged, but you get the idea.

David?

                  Linus
