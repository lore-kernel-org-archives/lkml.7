Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11404C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46CC2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDx7L+hb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfCTNCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:02:07 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53326 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfCTNCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:02:07 -0400
Received: by mail-it1-f195.google.com with SMTP id w85so7114918itc.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Yby35yEvTmgUouFc2Pcrb7qX8wS6V6AvGKiUDWJX8w=;
        b=dDx7L+hbQpRsjqsPrPIiVV66sdTpqpHamDaUX3hGenZ9j/4vUPoQbDo3XmuUuiFm9x
         Xk+3u6FrO4CyGplYWvhZqVGjBAXqkGx3kfSFUlUkjd/tRSu8g8Lbs2YvbKj1HhaZWb+o
         mCIx1FgmyPrwGebF4r6c7XAOFwZad37Qdz9kbw5uiI1p65qW/Hcs9JHzzr3J8enMaqvp
         taDptUfEKOiXh33boC0cIrSCA/01LLVQTrj/0hjPF2BPBH/eddpqnxpPjeXNH+q1WDlQ
         N60YSTkNGM6nEd+aY1TPDsl5BiI886N52wzq87JDJMcWk8RSnfkz0iXpboSW7KLdGxhN
         M+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Yby35yEvTmgUouFc2Pcrb7qX8wS6V6AvGKiUDWJX8w=;
        b=TLyRtOb6ruswQf1X1z7dzcpytNyjszi5t/ZNgZ0JPjuybZ3AKkFKyPQNaByPokrTf9
         iapQ3dJpnawGmhnsPXE/6d+59obkiQz06xJ9hO3sNjJRu1O8gFbku472wdXJORIwkE4/
         zvZBchFL+YgKOFFfHacSwpVGe3OMrhCTkn/1qiZaXuAufLpVMKJkqtpWr87O4+tnB5rl
         bwd/Uup2heInSWX8uxMAMtSrDS5biW+Oo0Rcqy1fYlt2Frm98IXL9ASCIfO6bT4cUjdA
         3thuD0JlDvIUdVleBg0uBYyLTLzuPvIE+BMaIqx8L47P8TUohLFzOHo1ipcNlPhdKyw+
         KQ+A==
X-Gm-Message-State: APjAAAXLrdNpJJNXwY3S2z+jU0sgoGqnS6yWMNZmVQcDgU7oBV3QxHPx
        upMLCipSEg6nSEbk5Nshk7SSoHcOwsfUNGrskEm0TQ==
X-Google-Smtp-Source: APXvYqx0IDRCjZOiIX9Dzbc4hO/tF5psRAx/WcqrdT5pxZOcr7PmwMIIn63n4S5lrJkhsXyTNCUm/E1nGbXEJSObsR4=
X-Received: by 2002:a24:9a86:: with SMTP id l128mr4847287ite.12.1553086925841;
 Wed, 20 Mar 2019 06:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009ce9ee057b0be7f8@google.com> <0000000000002fbe8d0584862154@google.com>
In-Reply-To: <0000000000002fbe8d0584862154@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Mar 2019 14:01:54 +0100
Message-ID: <CACT4Y+afPZ1_hP3NUV_Mu6w-CbU50kLPdK7cNgS4Kk5-QV2k2w@mail.gmail.com>
Subject: Re: WARNING in update_load_avg
To:     syzbot <syzbot+20fddccabc274e99398e@syzkaller.appspotmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        David Miller <davem@davemloft.net>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        "H. Peter Anvin" <hpa@zytor.com>, konrad.wilk@oracle.com,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        netdev <netdev@vger.kernel.org>, puwen@hygon.cn,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 1:55 PM syzbot
<syzbot+20fddccabc274e99398e@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
> Author: Stefano Brivio <sbrivio@redhat.com>
> Date:   Thu Nov 8 11:19:23 2018 +0000
>
>      fou, fou6: ICMP error handlers for FoU and GUE
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a48993200000
> start commit:   b8a51b38 fou, fou6: ICMP error handlers for FoU and GUE
> git tree:       net-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=16a48993200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12a48993200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
> dashboard link: https://syzkaller.appspot.com/bug?extid=20fddccabc274e99398e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10272c5d400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157bd093400000
>
> Reported-by: syzbot+20fddccabc274e99398e@syzkaller.appspotmail.com
> Fixes: b8a51b38 ("fou, fou6: ICMP error handlers for FoU and GUE")


That commit caused lots of crashes that look completely differently.
Now all that is fixed. The last crash for this bugs happened 2+ months
ago. So let's just do:

#syz fix:
fou: Prevent unbounded recursion in GUE error handler also with UDP-Lite
