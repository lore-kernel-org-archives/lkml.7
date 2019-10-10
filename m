Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729EFC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 04:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407F92086D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 04:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CwECIOKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfJJENA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 00:13:00 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39929 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfJJEM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 00:12:59 -0400
Received: by mail-yb1-f194.google.com with SMTP id v37so1496843ybi.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 21:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qEPtjPzuGjvOl9Qgb3Ue32NDgtmQlr5z0USmUCvMf2I=;
        b=CwECIOKuXMrMo1bMsiN/eiNxrU9knsTsmCRbc6gpRI0B28U8ASS4oX6VX/4tgUoKNK
         4eLEclcWJwhYFVgVPvXGbXy6b/k6uA8j+i6erNp+Fzef3NJs3Jn5935k6gvRrvWPUTN1
         S45aWKRHs+cR3MMr0/0V8Xbvck4kqke22iUZ/j6NAoJtBNHDo6JzFzRqHqekEJ4QjBJ9
         r2gyHp+vzMvJMBQyDkznCisJ6Zjjl3zMGh+zIk4OJP/O+SmtK7h9056ZkT7G80jj5kPN
         Dkt+vjE/6LnD8UvudwscHX18bE20TkibN77zqMIQZpaXvJCPqcqr/a5jYSP6Mj1TSY9E
         9mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEPtjPzuGjvOl9Qgb3Ue32NDgtmQlr5z0USmUCvMf2I=;
        b=RskxygEpsiF/3ucqst5jhuPKTNvEIHEUKOWTqioKREmoMtFVmp93M2Ozs7e0VnKY5G
         OGx33/P+7j0uHKbhxLdcHCQrgOEiWAvydhcyImbEi+KrXkAoEebV7i0tR/vZbuvfNWLo
         oc9oJsk+Mnf0r16OW4NXuXgmLmgmISthEDMa7QF7Ao+n+6nJRy+aaomggrjEq+5tiCvQ
         ZEHra4BPQIkshsE0XocIULFvyBMuhaiqqrCR+2defWQ5Op+g7SLzyrVbGZi2bVMsetW1
         ZMOBEvJy5k9QwqyDkc6yFcYFdVIcO/d3Neh7nApjvoopXL23QRPY7ACBV8jQ+YEuFof0
         gu8w==
X-Gm-Message-State: APjAAAXHP6AdRMQwTjLXWhCP3hmS/kw9tkFN0rTGoJ1x0lmU2hqfR/fT
        WD+CY+N37YJ0b6Og9LTQPXxk8eeMkC0XbVeAX13TQg==
X-Google-Smtp-Source: APXvYqwPrtsR2DFxSFUwuFLpzykWCmz43ojKF9EwwqqPGBhlU/YIzPD8OtLx3Qk3TThhU0GHePpTNtVvGJSG+d5fWxs=
X-Received: by 2002:a25:26c9:: with SMTP id m192mr4979554ybm.274.1570680778434;
 Wed, 09 Oct 2019 21:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191009212154.24709-1-edumazet@google.com> <20191010031820.GD2689@paulmck-ThinkPad-P72>
In-Reply-To: <20191010031820.GD2689@paulmck-ThinkPad-P72>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 9 Oct 2019 21:12:46 -0700
Message-ID: <CANn89iLLXZkGqXVjmAByNyixA4zxQYA__rFOF9Gn202yC+0L1Q@mail.gmail.com>
Subject: Re: [PATCH] rcu: avoid data-race in rcu_gp_fqs_check_wake()
To:     paulmck@kernel.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 8:18 PM Paul E. McKenney <paulmck@kernel.org> wrote:

> Again, good catch, applied for review and testing, thank you!
>
> I added another READ_ONCE() to dump_blkd_tasks(), which is not exercised
> unless you get an RCU CPU stall warning or some such.  The updated patch
> is below, please let me know if I messed anything up.
>
>                                                         Thanx, Paul

This looks good to me, thanks Paul.
