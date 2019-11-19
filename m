Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF4BC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2C0223AB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ClXF5T0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfKSQM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:12:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44466 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbfKSQM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:12:29 -0500
Received: by mail-ot1-f65.google.com with SMTP id c19so18316867otr.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 08:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=93xPAx0kr8oA76/KRE4IYmxNgzvAosH5EkrlivRRC2U=;
        b=ClXF5T0QxswAmDjTXcrbHV0f5l5bHz9bFxuqQNGTRVsW8inASFtA15n5Q0gITA42Of
         WgZN0aHjFmC6TN6uc8Gib2Pd1f01ywaANFiRL7pkzhH3jBHjqPKLbp6v+zlMlV1Ec3XN
         oRRrF7om7Wdk9uZtEojsxLcJ61ZUtzGYbriIOnJP4/9zx44D0YJ9RfxA+RjXf8MLdLDx
         yqRapjPsXz/Q+H56teNhxpYtQHXNVs2YDiNfANeT3MsEeYYBfn6Ws5BdP15QGgT5R5aT
         5ryXoz2JRGvyekdRsLNFqq7IaU0O0IUd7jjMqDgDzF9lxfNQvNOb1DzOyxZYm46JPxsZ
         r0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=93xPAx0kr8oA76/KRE4IYmxNgzvAosH5EkrlivRRC2U=;
        b=ZIPeuDMn1UmDlD+Bova19G2U1tvpvQnE+HxlfHZj5Z4mVY88YmwF2mNCzMSeil/nlO
         gvLvVIAdQADxD62dWvRW1vCY67+xIee7o94UPV+fhid+s3ATvxS/vhuEzFJqhUKMfMO/
         ehCup2HjC8zMQq8a+FF0t2XATKu/GZoumYjNs+kLEexwZnZcpeXPr4+M3cEKmzzzLzb0
         ydsxaRCz9n8ghTxcModt5OdBxnueIfe4iQwoOSvV6KPZafyYOWBQG7Jy7RCRYd3qA497
         b/S6axQFjdvCO+GGklmKc0NJnKQo24E+S6juYtmBZDIPAJ6+5s7oCWJYkoEl6l22aQOa
         7Vug==
X-Gm-Message-State: APjAAAVJljQIL63MbRkAxd2Qd4uBn2bhOwvxbrhTas/BN5cK4HSuwlsl
        lffXUgxCWsY5+aRvuFGFmdW0qPBNAZ/NzFYdKepInw==
X-Google-Smtp-Source: APXvYqyNp6UfNZXhM0FdbL81rw15qBOyGaU0VI2pZSScFreylKhSOdolblkQZ/c92fphjqt26+PkucVplQLTOd86c1c=
X-Received: by 2002:a9d:69cf:: with SMTP id v15mr4108901oto.251.1574179947889;
 Tue, 19 Nov 2019 08:12:27 -0800 (PST)
MIME-Version: 1.0
References: <20191119194658.39af50d0@canb.auug.org.au> <e75be639-110a-c615-3ec7-a107318b7746@infradead.org>
In-Reply-To: <e75be639-110a-c615-3ec7-a107318b7746@infradead.org>
From:   Marco Elver <elver@google.com>
Date:   Tue, 19 Nov 2019 17:12:16 +0100
Message-ID: <CANpmjNMpnY54kDdGwOPOD84UDf=Fzqtu62ifTds2vZn4t4YigQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Nov 19 (kcsan)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019 at 16:11, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 11/19/19 12:46 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20191118:
> >
>
> on x86_64:
>
> It seems that this function can already be known by the compiler as a
> builtin:
>
> ../kernel/kcsan/core.c:619:6: warning: conflicting types for built-in fun=
ction =E2=80=98__tsan_func_exit=E2=80=99 [-Wbuiltin-declaration-mismatch]
>  void __tsan_func_exit(void)
>       ^~~~~~~~~~~~~~~~
>
>
> $ gcc --version
> gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407]

Interesting. Could you share the .config? So far I haven't been able
to reproduce.

I can get the warning if I manually add -fsanitize=3Dthread to flags for
kcsan/core.c (but normally disabled via KCSAN_SANITIZE :=3D n). If
possible could you also share the output of `make V=3D1` for
kcsan/core.c?

Thanks,
-- Marco

> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
