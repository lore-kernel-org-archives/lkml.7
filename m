Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEEEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC55E2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDQJ7V/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfCKNGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:06:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41504 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKNGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:06:55 -0400
Received: by mail-io1-f65.google.com with SMTP id v10so2578354iom.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CwESnDc/hIoUpicbwWt0hWKwXZiLW4n83UTux0FIXhc=;
        b=pDQJ7V/RL9ALCsJSLC+ZVKD3636b8mwwFf/bEkCgh/q7VhhA/dnUUdTEfXre6z68W2
         d0JOci2yjltnzZePGyIgxILW7BMQ7ZXsIK6wcU5OTF1WrmlZarbhccEMkV1qlfgqeLnf
         Gzgxx5QDN0Ji++lWvaOr66kD8Uz1JzvdfxLoSotO235CexFt5FM6BPiHsTaBlVi9VQRs
         bmDgYo0zf4+bORVHhZZeeuq0wHNFVvUZJX0SGjwpkU4GM8R2W60N1R5DYf3i2ZsiDJHi
         aTZq+3sLl25QveOLe6qdNm6oPmmrB5PIkTUNebjMkVNTL8Mm80JZvKB1QkpJjwN7TVdD
         2P+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CwESnDc/hIoUpicbwWt0hWKwXZiLW4n83UTux0FIXhc=;
        b=K6YkjcD0vRcDLK0WdRvq6zzQyqmfDFTy0uZ33Z6fb2O7vKCqZQtEhpRLIU+63wM5wf
         zS66Yn2Tgn8LZTsuSW8yq6HKmA8INU8d2iJYnVYyqgnVG9qN9bKx2DL9w5Je5eJtefh+
         wW3D/k1zgU3fQH/jvQFt+5DsGYjkixi7rTA8mTYhyi/0WVnbAefxfb6NeCmHsmNrfT1p
         s3fFZ7FxLb9rs4YfOLMzE50j8Fo897j0EXvLlnynwz9KtOhauOiW3khWgTVYSO1DmGn1
         cFHOulhSOiC661MmQG8wllkywRT1ebnWWp2DvQnvR3TEy+J2c8sthpgMheaz294dMz9B
         JwCw==
X-Gm-Message-State: APjAAAVixs1uxYEK5QvzISprZr5+bSzes5IVpxTFZ/UVa2wMLdLZChaZ
        Dm5NymvorP4AhbXizP5Iw86dBqPsxNOosO5wrXkhbg==
X-Google-Smtp-Source: APXvYqw1rxYrzxphgSoPEhfC2nJIvUQSyGhbD9xsOH7VSZPoKubv/9MLRw9f3Md2AoafkE7CzN6vhzStzvbfOhOrDYE=
X-Received: by 2002:a5d:834a:: with SMTP id q10mr15786580ior.271.1552309613871;
 Mon, 11 Mar 2019 06:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000011f13c0583d0b48c@google.com>
In-Reply-To: <00000000000011f13c0583d0b48c@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 Mar 2019 14:06:42 +0100
Message-ID: <CACT4Y+aw4wMD=GavraSLxN+P+dvXhc940BJKSqGRnw5krqtNDA@mail.gmail.com>
Subject: Re: WARNING in vkms_vblank_simulate
To:     syzbot <syzbot+0871b14ca2e2fb64f6e3@syzkaller.appspotmail.com>,
        shayenneluzmoura@gmail.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        mahesh1.kumar@intel.com,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Haneen Mohammed <hamohammed.sa@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        DRI <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 1:28 PM syzbot
<syzbot+0871b14ca2e2fb64f6e3@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 09ef09b4ab95dc405ad4171ec2cd8a4ff5227108
> Author: Shayenne Moura <shayenneluzmoura@gmail.com>
> Date:   Wed Feb 6 20:08:13 2019 +0000
>
>      drm/vkms: WARN when hrtimer_forward_now fails

+Shayenne

This should have been included the author email when mailed by the
bot. This should be fixed now, tests added. Sorry for the churn.


> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=128448cf200000
> start commit:   09ef09b4 drm/vkms: WARN when hrtimer_forward_now fails
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=118448cf200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=168448cf200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c1e0e0ec44d1e5ff
> dashboard link: https://syzkaller.appspot.com/bug?extid=0871b14ca2e2fb64f6e3
> userspace arch: amd64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1787db8d200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fc9883200000
>
> Reported-by: syzbot+0871b14ca2e2fb64f6e3@syzkaller.appspotmail.com
> Fixes: 09ef09b4 ("drm/vkms: WARN when hrtimer_forward_now fails")
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000011f13c0583d0b48c%40google.com.
> For more options, visit https://groups.google.com/d/optout.
