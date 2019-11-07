Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DD7C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33C72085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDlXJhZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388224AbfKGPRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:17:24 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44308 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729800AbfKGPRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:17:24 -0500
Received: by mail-yb1-f193.google.com with SMTP id g38so1043166ybe.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 07:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eINQGFNoBj0XJl5Ezms4ve/c5goqCblPH3ci+ZKJmhE=;
        b=RDlXJhZvPW8W/m0PvOyo+HegHt81FppGi/9odDfIbOt99D3t3D4eBgmNzb9U0Lnopr
         IDcoeIZiuOXDt2a3YVDQJqatmyEl+n4h0ZatJvh1hZ/Tn6QOpnxSUcJtxQ8sas60UaEN
         V0EKVdOR/9did3BNQYhsz8QK6bGLs/GErM9X1cXXT0uLoynPqy1pBzBTlqgtR2ydbLpQ
         6Gg/ke5vnWXu6uE2MrSXpyfkUsrp19YZSK4gJR3STrLVBIIpOdBxj5E2AgOajB/xoNx5
         SraCklBeb1zdOhD9hW+go/Qz2rV5QLWFk8fI9lbbIuhZtZ8OgDEuaM7iPaQUsuI7VDXu
         F6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eINQGFNoBj0XJl5Ezms4ve/c5goqCblPH3ci+ZKJmhE=;
        b=EwadOIhO1SkxU/f+NAhmLulc+OzoM0nhVoneHRkloOK7N7Evg9wUGLNsQRMnI8y9Km
         yJMcK311DoI5QrpG2zlbM29Lpguq6LZ56tuAQ0yZQ8z4YS8aOakw1yIn+1EEa0O7FoVL
         jh8+c3wKotMVifVLeXUYZMzk37wZnv38jZUCy4fEaAuAihNqZomX2XBrfCC24GVVENTR
         8WeY8zRe/NTU3JDmSgGglM31IfCMosS/PgOR6DJw58gjRtZ9c+qbHQz0Wzbqu4jlWTTN
         EACXc5EiZ9Ntve0S7DseWPjEWAEhiRgcj1sH+wLsbQHG6ZemLlRG4jmhVa5KrU54k/AX
         N8uA==
X-Gm-Message-State: APjAAAWAfcHP3z4EgwaOYMjtEYJL4Fqldgf47qYuATVZC62CRGPC8koG
        8/miKg2/BDtRHYaV4On/EVZe52FR
X-Google-Smtp-Source: APXvYqwQxG6QfFR6KNyRmrujMwj37OmzSAvf6mD0W0pcmfoCJdWd9BEwtZl+z+ag+3wdwwqqe2PUZQ==
X-Received: by 2002:a25:c091:: with SMTP id c139mr3729994ybf.178.1573139842231;
        Thu, 07 Nov 2019 07:17:22 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id h35sm635520ywk.63.2019.11.07.07.17.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 07:17:21 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id y18so1054962ybs.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 07:17:20 -0800 (PST)
X-Received: by 2002:a25:583:: with SMTP id 125mr3500165ybf.89.1573139840266;
 Thu, 07 Nov 2019 07:17:20 -0800 (PST)
MIME-Version: 1.0
References: <0000000000008c6be40570d8a9d8@google.com> <000000000000f5a6620596c1d43e@google.com>
 <CA+FuTScESZAhoyDvD3uNq3SRC1=5dvnkONW53tZ0vj0tLnbF-A@mail.gmail.com>
In-Reply-To: <CA+FuTScESZAhoyDvD3uNq3SRC1=5dvnkONW53tZ0vj0tLnbF-A@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 7 Nov 2019 10:16:44 -0500
X-Gmail-Original-Message-ID: <CA+FuTSeRdb1xZx8HJJWtUxjsyoMPZRvUKbm+2+r_TwM5SmAXJQ@mail.gmail.com>
Message-ID: <CA+FuTSeRdb1xZx8HJJWtUxjsyoMPZRvUKbm+2+r_TwM5SmAXJQ@mail.gmail.com>
Subject: Re: general protection fault in propagate_entity_cfs_rq
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     syzbot <syzbot+2e37f794f31be5667a88@syzkaller.appspotmail.com>,
        allison@lohutok.net, andy.shevchenko@gmail.com,
        David Miller <davem@davemloft.net>, douly.fnst@cn.fujitsu.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        HPA <hpa@zytor.com>, info@metux.net,
        Jiri Benc <jbenc@redhat.com>, jgross@suse.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        ville.syrjala@linux.intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 9:58 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Thu, Nov 7, 2019 at 8:42 AM syzbot
> <syzbot+2e37f794f31be5667a88@syzkaller.appspotmail.com> wrote:
> >
> > syzbot suspects this bug was fixed by commit:
> >
> > commit bab2c80e5a6c855657482eac9e97f5f3eedb509a
> > Author: Willem de Bruijn <willemb@google.com>
> > Date:   Wed Jul 11 16:00:44 2018 +0000
> >
> >      nsh: set mac len based on inner packet
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170cc89c600000
> > start commit:   6fd06660 Merge branch 'bpf-arm-jit-improvements'
> > git tree:       bpf-next
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a501a01deaf0fe9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=2e37f794f31be5667a88
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1014db94400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f81e78400000
> >
> > If the result looks correct, please mark the bug fixed by replying with:
> >
> > #syz fix: nsh: set mac len based on inner packet
>
> #syz fix: nsh: set mac len based on inner packet

The stack traces in both the bisection log and my manual run, when
running the linked reproducer, differ from the one in the dashboard.
Those more obviously include nsh functions. The trace in the dashboard
does not and sees a GPF in propagate_entity_cfs_rq, which does not
immediately appear related. That said, it is reported only once over a
year ago, so probably still preferable to close. A new report will be
opened if incorrect.
