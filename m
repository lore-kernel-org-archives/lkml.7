Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0DDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFC8206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPduABOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDDFDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:03:23 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34766 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfDDFDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:03:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id k2so1835521qtm.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 22:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tBEXosrcvpGtRUaF1KwHY9bzibXQf+KNKFtwMzZlr0=;
        b=GPduABOZqaHKGD3PKF1ewSBgPwjUG75OUiCi4YyR6w6JdzOqEb0bW/n1H9k7yDAska
         RDugi4My1V5eBUk5KhBEPDP3v4mk8Da0LmrLcXGPJUsciGLxOUyEqR3T62Fv0Jn5NNeI
         DQYU7xMdKBd6aIxwHRVMMkNkDLUR0ncEkOHo0hxy3xluWYXixpeb3PL+t/ZAaMboyE42
         6sQMOhvHr1A4SR30Cs1sJdRUDbXBiOD2VPxAD4i/InoLFcgCH+VsiT+qJPelgwoj2eh/
         JLDeOUDygbrjM1mzNuR/Z5KKlp9Pk0GyDoTgxOoqSWrOVZDJqg69rVtnG3zz3aukq+zc
         fJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tBEXosrcvpGtRUaF1KwHY9bzibXQf+KNKFtwMzZlr0=;
        b=G3uqBFuZackt7P8Ud0l81JJmhjTI+Z5L2tCD095tm15JYKbrNPGW+b6CZCuVDLZSb1
         dY2qMT0yen9O+7w9vgFuaoNIzhxV+i2bcmPFAW5aS3g1HfPacVSfvYPFPfAwHY8CkRC/
         Kt31kW2GqWhDrlFXnnpVRZE20RA4MrrI/klE4kw7f3htPu3CMIHOpy3tgiMSs3awYJw7
         kaE9u2wGi/7/QKALRFXZKnusyrMlvyXJXuHCxLpwOqdREgloFBKmDd73MAswb75gM9xS
         1L3CenvIaL1ffmNA86TUqXPbqU/FKgiCko8owTzk/R3X8HKF0Q6wyf57N7DoQPbGSxS3
         2+uw==
X-Gm-Message-State: APjAAAUB/4SqXVwGsMx9eRSq/KfVTfPapizlNAnUl1Y3NCE4CmfNJqn/
        apmHqe6DDDR5ehtFu1TThnbWrl5ssdQEsgfrIH8=
X-Google-Smtp-Source: APXvYqxDkjxy/YALYUqnJjSW3g6ZqvNbDu76PKp77sNtbAm90OXwyQtsHGF5pFDcEUwh0YDWATH/CzvMyLoIkHXCIPA=
X-Received: by 2002:a0c:ba99:: with SMTP id x25mr3014018qvf.212.1554354202149;
 Wed, 03 Apr 2019 22:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190321075725.14054-1-duyuyang@gmail.com> <20190321075725.14054-19-duyuyang@gmail.com>
In-Reply-To: <20190321075725.14054-19-duyuyang@gmail.com>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Thu, 4 Apr 2019 13:03:10 +0800
Message-ID: <CAHttsrZ0JgWvwtcaR-qbV8dANhXyOkNypw=GjfPhh1P8J4T1Aw@mail.gmail.com>
Subject: Question on a lockdep test case about mixed read-write ABBA
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I observed this test case you wrote in Commit: e9149858974606
("locking/lockdep/selftests: Add mixed read-write ABBA").

static void rwsem_ABBA2(void)
{
       RSL(X1);
       ML(Y1);
       MU(Y1);
       RSU(X1);

       ML(Y1);
       RSL(X1);
       RSU(X1);
       MU(Y1); // should fail
}

Why should it fail? This is not a deadlock, right? The depencencies
would be built by lockdep though; that results in a false positive.

Thanks,
Yuyang
