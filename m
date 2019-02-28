Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF5EC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7B6214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gRwCSl3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbfB1GvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 01:51:19 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35711 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfB1GvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 01:51:19 -0500
Received: by mail-io1-f67.google.com with SMTP id x4so15804498ion.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 22:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mNpIrDMVV6VCXM5MciohqYyD1qSVDJXm+0gVrNZiczA=;
        b=gRwCSl3H6+hvxDN+wp8sksTxqSI3HzzzS06qU4b8vDZj4A89DMPoYy91Rxxy596YUz
         56LmfW4lM9XwB6S08VthLQFaOZ0/fAQ2f2J5lVqZ9qRKKU7xbFyH/w9hhcwn9hxTlyMy
         jOFoWnz6x8cvjURyBAnl4mNVMg/F4qObGbJAHR9O6kaliLl1RFygzm18shGBryDj07Z2
         nr4pzu2+eByrSCcxjWFUbas0QyKNeQ7rwqTVaVOcqKXTAwmANMpLJQvugQkOWEOtSAV1
         Dk4+b3i82t6VoFT29OFVNBM0OfQcUzj3pAJv30PTepnfUC6BTALzKd7+smFCO82qdqNp
         J6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mNpIrDMVV6VCXM5MciohqYyD1qSVDJXm+0gVrNZiczA=;
        b=IF2yPqZGlQTFqYLOCoNlXGTPLkpC3D3veS4zImNhfy0cn6kfSt5rCxTqnLR0M0Phku
         zrK7h5bwDrvfIu0oQCy9FwXvBjBDu93vZ9KT7lCPPeKDjYvt9F8wzhlFLLw5F5Oj7041
         WpibtiHWPy4uMiBXmdiZLBiTbxPbTC6l+8uviJbD5gXX3CbOZkwfhoIgLovQjOCk4z77
         TezvMsajTRgyy+Ig8Ql3B2/RJQz7g9JXpj0oUfgpWu7B6GgodG2MnPDKy1uarWWMF6Ik
         VBgO5nZXhsc7wXpLOZeuINmKYR8HYx2laIJ8+Ra+za22GlrMsqF47yhC8JcXRYV+yS3M
         u/Vg==
X-Gm-Message-State: APjAAAVpxeqJbrLkzOeKuuKIVauLS2dnWRO5qS0aU77B/YjgUPp3su16
        oU1JLuTV898UEi0KwcxRZt5xhmimTr4l7Tv3dsu4bA==
X-Google-Smtp-Source: APXvYqzy7llLJMUvrJjkrAMx2UBpa+k+RhXI8MmdOMmfD47A+k92qdgT9mbXDxsTVr4N8kKLkhXQwTNMcpKuJ9Psfrg=
X-Received: by 2002:a5d:84c3:: with SMTP id z3mr4392528ior.11.1551336678106;
 Wed, 27 Feb 2019 22:51:18 -0800 (PST)
MIME-Version: 1.0
References: <0000000000001c63c80582e32294@google.com> <8d94063c-e10c-c470-8ce0-1f86c517b1b4@i-love.sakura.ne.jp>
In-Reply-To: <8d94063c-e10c-c470-8ce0-1f86c517b1b4@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Feb 2019 07:51:06 +0100
Message-ID: <CACT4Y+ZqjoXftDAby9s-YUrOv8txBFqKukRcxP6ty3LLKz_+Hw@mail.gmail.com>
Subject: Re: kernel panic: MAC Initialization failed.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 11:37 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/02/28 2:02, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    7b827ff9af88 Add linux-next specific files for 20190227
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15336f14c00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa6b8975759dcc5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e1b8084e532b6ee7afab
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ee708ac00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16954084c00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com
>
> Thank you. The LSM stacking seems to be working as expected.
> But this one should not be considered as a bug.
>
> If something went wrong before loading access control rules,
> it is pointless to continue. Thus, stopping with kernel panic.

Hi Tetsuo,

What misconfiguration you mean?



> If this path is trivially triggered enough to prevent testing, syzbot can
> load access control rules from /etc/tomoyo/ directory of the filesystem
> image and make tomoyo_policy_loaded = true by executing /sbin/init .
>
> Hmm, maybe we need to think about automated testing environments where
> neither built-in access control rules nor run-time access control rules
> can be provided ... ?
>
> #syz invalid
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/8d94063c-e10c-c470-8ce0-1f86c517b1b4%40i-love.sakura.ne.jp.
> For more options, visit https://groups.google.com/d/optout.
