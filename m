Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADDFC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 11:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DDE2683F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 11:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/aKUHij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfEaLby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 07:31:54 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55208 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaLbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 07:31:53 -0400
Received: by mail-it1-f194.google.com with SMTP id h20so15103621itk.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 04:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0wEV/ipC4bfJW9xp4vHq9B9GgjH4aRfvN7qnURusXlw=;
        b=d/aKUHijM4vj2nDYQ+dFb9FmAjLWqYwI6OG29UrSYBta4iBZj6KjcNTZ/5MFWDloKF
         jvlELMkk7EEAgV4JfTdRz1IHXpfjX0NffLmwakziIL3ZIvaR4IQfE4s2eGsdttTcSql7
         5MbirqQyG61d0m/gGfbnJxz+gjzknLM7c/w9/tNnnSDNIECtYnOwzH362cWHUhI7/GWS
         9S9ic3mPgCXbqwcsSFAdnbhlqk7e9FNrTP1XckRlKdKvSlA/n4VkvZyJNNQMlqqeRYFA
         ijILLjDQlNzgtNUfXWP3HZpUbeEpTVl0M7Lv2hE2kEjzAN3dQImJlqzl04iFAdWvV/Zs
         GVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0wEV/ipC4bfJW9xp4vHq9B9GgjH4aRfvN7qnURusXlw=;
        b=aMSQ5IQ4tE5lMvkDMQIVjvvTxdLDgVxAQWHP9UBqc+zDGSjSuruq0xaPR1qTWekXiG
         Qb5vQFzgGtwzuqw4NdPjB7ggK9YCSIn+4kCPOFoRvwzZ0qTm/W9gERD3hzXACg1TWWsL
         7hNsCRrIG79ij9Cupun1MbglVUhqZD7x+dhvqmlAqItGsXcQl3f5yh4j0JYxHQw1YRIi
         PWmJQVI3XUeD1td+0aHjg2GELU6bhCzm7Vvs3Vp+HUHmEzPpDvoXWmQ4Cyi37cssr2+v
         ig6ku0RCm68Nngjgb2VWre3f9nCWLSm7mzgSQ/1k1pWTt+ubACG29jrZsxWYB6y/JPue
         NdhQ==
X-Gm-Message-State: APjAAAUSxa0saS/g0A2UMBtm07RSz2+U/3tWCoCfHNFtReUuR/XRER6l
        KJAVFso5JZ6LZ5A+IOZsVLmtghc2jvoJJ2lJCKDUhQ==
X-Google-Smtp-Source: APXvYqy25JhsFajdbbUQcnpPIRyun+M9i83fifYyDtoLZOREKdu8EOsZc8bTapG5AGQfVHr/QxlZh8GuT23zewr80hU=
X-Received: by 2002:a24:91d2:: with SMTP id i201mr6975414ite.88.1559302312320;
 Fri, 31 May 2019 04:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000862b160580765e94@google.com> <3c44c1ff-2790-ec06-35c6-3572b92170c7@cumulusnetworks.com>
 <CACT4Y+ZA8gBURbeZaDtrt5NoqFy8a8W3jyaWbs34Qjic4Bu+DA@mail.gmail.com>
 <20190220102327.lq2zyqups2fso75z@gondor.apana.org.au> <CACT4Y+bUTWcvqEebNjoagw0JtM77NXwVu+i3cYmhgnntZRWyfg@mail.gmail.com>
 <20190529145845.bcvuc5ows4dedqh3@gondor.apana.org.au> <CACT4Y+bWyNawZBQkV3TyyFF0tyHnJ9UPsCW-EzmC7rwwh3yk2g@mail.gmail.com>
 <20190529152650.mjzyd6evzmonymj6@gondor.apana.org.au>
In-Reply-To: <20190529152650.mjzyd6evzmonymj6@gondor.apana.org.au>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 31 May 2019 13:31:41 +0200
Message-ID: <CACT4Y+YEajNeYRvbVvddC0=mYKviPAyX_1C+mPn_DcWWFcwr8w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in br_mdb_ip_get
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Thomas Graf <tgraf@suug.ch>,
        syzbot <syzbot+bc5ab0af2dbf3b0ae897@syzkaller.appspotmail.com>,
        bridge@lists.linux-foundation.org,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 5:27 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Wed, May 29, 2019 at 05:14:17PM +0200, Dmitry Vyukov wrote:
> >
> > > It looks like
> > >
> > > ommit 1515a63fc413f160d20574ab0894e7f1020c7be2
> > > Author: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> > > Date:   Wed Apr 3 23:27:24 2019 +0300
> > >
> > >     net: bridge: always clear mcast matching struct on reports and leaves
> > >
> > > may have at least fixed the uninitialised value error.
> >
> >
> > The most up-to-date info is always available here:
> >
> > >> dashboard link: https://syzkaller.appspot.com/bug?extid=bc5ab0af2dbf3b0ae897
> >
> > It says no new crashes happened besides the original one.
> >
> > We now have the following choices:
> >
> > 1. Invalidate with "#syz invalid"
> > 2. Mark as tentatively fixed by that commit (could it fix it?) with
> > "#syz fix: net: bridge: always clear mcast matching struct on reports
> > and leaves"
> > 3. Do nothing, then syzbot will auto-close it soon (bugs without
> > reproducers that did not happen in the past 180 days)
>
> I'm still not quite sure how this could cause the use-after-free,
> but it certainly seems to be the cause for the second issue of
> uninit-value:
>
> https://syzkaller.appspot.com/bug?extid=8dfe5ee27aa6d2e396c2
>
> And this one does seem to have occured again recently (two months
> ago).

I've closed the KMSAN bug report with this commit.

And since the uninit value was used inside of the rhashtable (as
hash?) it could lead to any kind of inconsistencies, I guess we can
do:

#syz fix:
net: bridge: always clear mcast matching struct on reports and leaves

here too.

Thanks for bringing this up!
