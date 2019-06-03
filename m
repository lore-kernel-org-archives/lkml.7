Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE426C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08B527C56
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QV0cPHPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfFCG4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:56:24 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50373 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfFCG4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:56:24 -0400
Received: by mail-it1-f196.google.com with SMTP id a186so25631309itg.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 23:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ooOZ8aCismIzzPcMY1VTWsTBEe7b7TcB9sjbz4A8RV4=;
        b=QV0cPHPnK3fS+9Pj30mBk3EJNolqnegqOausWsF3KeigPRW1UDHE4cDmUCt52QGaoG
         o2DfahDuF3m+7pwHDz9XHj/Yud2N0e3Dej3Yd/lFBl+2qIZEOm3C3PkkSX8NTklthRPD
         Nm5dv/tgL2lbBbBuckHd+BOS6vaGu7PnnAXIpTZ9AErLVZSB4p/sSnAfha+5YqPfmGaF
         zRKaeOWwsoRniCJL1dnwriCXZ691hVwHD6ah2afo5iTBy9mi+RQsswozPHsWNHdN/Y2g
         NIWeFZogW92q4eBLVCTnjKAyt/yOJhsZkTHCswIhaB1Lc/eooWT3G/CGghTy9JVVYpVH
         orpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ooOZ8aCismIzzPcMY1VTWsTBEe7b7TcB9sjbz4A8RV4=;
        b=Ar/ybqlnu9Z/1yEn3X0jW0byartkhLNxDpBBAoGx4W0IFof5+MyYrrpyBNCyPBu/fW
         CHMs32Ec2oGCiJmLhvvzO/L/53w+dJhchRE6NgNknliCVJ3zaUPCpFmZs6Rgl4Gjaukx
         dwlqqyZOVU7HznVTk1i1S04TXm13lea6CMxk1fUpW2zKwYa5O3MXEtZHk8gqr6LeXK3w
         vWct2wzg9E6T5rV/RJFP1m57gvQWEh//aTs8HOzhfrSUsHEFl1I3BJ//HKIyCnpVVyNA
         9t0nV6UoKg1G6UNxL8b5eW68UNZcBi25ZMV0gdfJtx0Dh2vZOdD6NvYFelCojElIILVX
         UT5w==
X-Gm-Message-State: APjAAAVzt6h/H4dmAcG9dxRDFQTTVoZjD5Fm9nNSydqytwZIcg0f4nHA
        vlDK+nC+jhUtoAPcVFnrfk22NBptufPPecc42yWVag==
X-Google-Smtp-Source: APXvYqzpGauoTJieg32wk37//cRiF4h/aqH1Z79YNWgjJysa7Is5ms6lE/NZf3cE3Fq2u4wFUatF74z5A98JGk90B7I=
X-Received: by 2002:a24:9083:: with SMTP id x125mr9442626itd.76.1559544983323;
 Sun, 02 Jun 2019 23:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a7776f058a3ce9db@google.com> <178c7ee0-46b7-8334-ef98-e530eb60a2cf@gmail.com>
In-Reply-To: <178c7ee0-46b7-8334-ef98-e530eb60a2cf@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Jun 2019 08:56:11 +0200
Message-ID: <CACT4Y+ZqM84Ny22p7=J6vVXG7XOkqVN_jjkb87DNetNCFQRFBQ@mail.gmail.com>
Subject: Re: KASAN: user-memory-access Read in ip6_hold_safe (3)
To:     David Ahern <dsahern@gmail.com>
Cc:     syzbot <syzbot+a5b6e01ec8116d046842@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 1, 2019 at 7:15 PM David Ahern <dsahern@gmail.com> wrote:
>
> On 6/1/19 12:05 AM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    dfb569f2 net: ll_temac: Fix compile error
> > git tree:       net-next
> syzbot team:
>
> Is there any way to know the history of syzbot runs to determine that
> crash X did not happen at commit Y but does happen at commit Z? That
> narrows the window when trying to find where a regression occurs.

Hi David,

All info is available on the dashboard:

> dashboard link: https://syzkaller.appspot.com/bug?extid=a5b6e01ec8116d046842

We don't keep any private info on top of that.

This crash happened 129 times in the past 9 days. This suggests this
is not a previous memory corruption, these usually happen at most few
times.
The first one was:

2019/05/24 15:33 net-next dfb569f2

Then it was joined by bpf-next:

ci-upstream-bpf-next-kasan-gce 2019/06/01 15:51 bpf-next 0462eaac

Since it happens a dozen of times per day, most likely it was
introduced into net-next around dfb569f2 (syzbot should do new builds
every ~12h, minus broken trees).
