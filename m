Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA92C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543FE21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tuwdsZmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbfB1KSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:18:33 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38502 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732285AbfB1KSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:18:32 -0500
Received: by mail-it1-f194.google.com with SMTP id l66so14860096itg.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 02:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xh7kAN9fkcLMIPjSCbR27g4KapJNcAQKeEA9eOxmX9c=;
        b=tuwdsZmUZ+LYRpAy9S2exhnK5vDW13RxrkhUJ1A3XAif/SB4Stf9Fhv3L4kXTx2ElT
         AEzMEyZVM5/QQNcr6zn3PLVUnYLwePc+1efWhNqLmAseTCNLQGwGgZhhHXIQ7guALY3f
         p9Mj1gmXH9NMBbFySVKkEDknJ2LHk+6dBJjz8wPqjQE7v/JJq9Scy2wSCYM5MMrCuYmP
         RMazhQXzZaYg0EfzDW0OwKE7MwvU3VynZR922vpF3FQ2VvEeA5bkyZ1skukBK6MoLIqu
         DNhZBD/qIpwn+PLHwo0k2Oe07MdNSSjCfCAfFezTOywK+ELKgMFCDE7cbCt0aDtfb71d
         prRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xh7kAN9fkcLMIPjSCbR27g4KapJNcAQKeEA9eOxmX9c=;
        b=FoTvnln2XmxG1miW1gu0pX1VXXHuzL2HbujhT9342OUEsX8aebjXIy10UgUdmDR1vc
         kXmSidiXRgFv1h7yweI6hA/W2RgykwbAQsu8OSHBoOjPrFMPfTzHs3ndji5IlSDS7mAq
         SZsPDHP51MNd0HPZUXf9QtAPtJA7zIcdurtr4TKLMNaEm5H62kUmS5NQ39S01yPgbPYv
         kZwJfG52p02wN9xDH9jaElfW9QtKznEgttt/rsvvr6DjWrbkHoBGUFsuxmTdPR8ASZ7I
         p+VtnJ16hdKACdy6m1m17ayvXN+l2BFMpZC1+T+GZZFpADnlHZL4z++BgDdhuTEzF9RR
         CKwA==
X-Gm-Message-State: AHQUAuZMRFPVxCVNUj4/dK+u3TZEsCuShg2TtKr2+BpY0A86kLk62cjP
        qklkpMmr0Mt02o3nIRQP0SgLg+ziWOcu7S2rbBjWjQ==
X-Google-Smtp-Source: APXvYqypo93ymFCGIpi7CpjlGHl/0/oXL2Ypi7BFjxkliqWfTIz77Rm0Hywc1iYgU4CT0mpD1Bs3X8zbC62a4GdrGpA=
X-Received: by 2002:a24:c8:: with SMTP id 191mr2236862ita.166.1551349111994;
 Thu, 28 Feb 2019 02:18:31 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009c92240582ee96ce@google.com> <bd185896-d78e-ce2c-ed70-5998e05545e2@i-love.sakura.ne.jp>
In-Reply-To: <bd185896-d78e-ce2c-ed70-5998e05545e2@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Feb 2019 11:18:21 +0100
Message-ID: <CACT4Y+b4dcJzLV+yqKjHgsm89H+hj8wZOSRVkV69Vv=c+YzXxg@mail.gmail.com>
Subject: Re: kernel panic: MAC Initialization failed. (2)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+29569ed06425fcf67a95@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:11 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/02/28 15:42, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    7b827ff9af88 Add linux-next specific files for 20190227
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10f71894c00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa6b8975759dcc5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=29569ed06425fcf67a95
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113a8242c00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154d6bd0c00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+29569ed06425fcf67a95@syzkaller.appspotmail.com
> >
>
> Memory allocation failure due to fault injection before loading policy.
>
> #syz dup: kernel panic: MAC Initialization failed.

How/why is not this "user crashes system"? Kernel must not panic on
OOM. There is memcg as well.
