Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B2FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BA121741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYXh/YN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfK1Ikp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:40:45 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34942 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfK1Iko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:40:44 -0500
Received: by mail-qk1-f193.google.com with SMTP id v23so14240228qkg.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 00:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5C8NbXcmc1aQS22jTcSPXOSGUlWN7oELXfg5QtAuVzM=;
        b=UYXh/YN6exLANTxIPrG3gGtiatnbu0bh/kGC1PW6FqlM6fscc0zR8db0UZrtuQ59y6
         DMUVc+CWnbnzVDLFDnZN91A0af6QT5QoRflpFOUUPCtPlgIUnHYGYjN8eKvR4nu70I6+
         webO28+9bkOTJCKZP7zzfMu5CiR07YLI41peftG9RdPLOhEMjZzvzioWtO6Kj0Mz3fWD
         aPXCADHuisIvqjqY2nPI46PRUn8Vfk8AFMHAc8VKRVD8AkqqYRl8syJMApsBIwn0HViO
         irlmr7a1C8+9Sw04lbstTjm9zbtYBtejzY2mgPGy2dIgE3wBlJDIX5JNH1dTovt8Ld75
         sM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5C8NbXcmc1aQS22jTcSPXOSGUlWN7oELXfg5QtAuVzM=;
        b=HwNyApDTOJEpbIROuiYIx37pgWSGitt3DoCoJVmjKh6ZZgluL/2lBNG3npF5EoIefW
         CvAZ+Izy+75ZiNbyEzHS3fiGqmFwhMR0h1PEVrikU4FkSJFm9o+kR5860U+YgryaP1nd
         +H3jbAXMjVuqOIBGKgAOCDOcnh81kAxvV7yT/DCdYL1u3YVctTcG6fgTq48Up/MScb71
         /c74LW4XiWXGu+9DoxfBKoA24EN7wuBUEiQDL2hPqoxfW67nJnIQ70AYIYxnabulbCWt
         4LY5XnaorLnRmEJdyUCEvHa/PyfHFRhCs6myM+w9zkq+nnAsMO0IaoEnN7QDlmYZkNXL
         ELHQ==
X-Gm-Message-State: APjAAAXzzXpTJQDHlm0r6SCC5xqpWxSostNYdOxQeF9M59a68NAH6SGH
        wfPL9YFhZ5ugyn3uU5P1wcmyPJb/LO+umfe9dPpG/w==
X-Google-Smtp-Source: APXvYqwSOrs2sa+E7QbDi8H+rGvNlfN5l/NCXi93Y1fBJESRHAf13gMFAaGH1xt3XOfSvi2wrGNiBNIemXtPPjgIyrQ=
X-Received: by 2002:a37:e312:: with SMTP id y18mr5426499qki.250.1574930443688;
 Thu, 28 Nov 2019 00:40:43 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009aa32205985e78b6@google.com> <2825703.dkhYCMB3mh@sven-edge>
In-Reply-To: <2825703.dkhYCMB3mh@sven-edge>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Nov 2019 09:40:32 +0100
Message-ID: <CACT4Y+YwNGWCXBazm+7GHpSw-gXsxmA8NA-o7O7Mpj3d-dhGYA@mail.gmail.com>
Subject: Re: WARNING in mark_lock (3)
To:     Sven Eckelmann <sven@narfation.org>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     syzbot <syzbot+a229d8d995b74f8c4b6c@syzkaller.appspotmail.com>,
        a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>,
        LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch,
        netdev <netdev@vger.kernel.org>, sw@simonwunderlich.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        vinicius.gomes@intel.com, wang.yi59@zte.com.cn,
        Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 8:25 AM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Thursday, 28 November 2019 03:00:01 CET syzbot wrote:
> [...]
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132ee536e00000
> > start commit:   89d57ddd Merge tag 'media/v5.5-1' of git://git.kernel.org/..
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=10aee536e00000
>
> Can the syzbot infrastructure be told to ignore this crash in the bisect run?
> Because this should be an unrelated crash which is (hopefully) fixed in
> 40e220b4218b ("batman-adv: Avoid free/alloc race when handling OGM buffer").

+syzkaller mailing list for syzbot discussion

Hi Sven,

There is no such functionality at the moment.
What exactly do you mean? Somehow telling it interactively? Or
hardcode some set of crashes for linux? I don't see how any of these
options can really work...
