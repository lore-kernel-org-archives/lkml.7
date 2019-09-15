Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDB8C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDAA21479
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568567270;
	bh=zzyU43caDLW1gD3q/Yav2ZB+uuqqywjdczSibRhF5CY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=T4oTlcI3PNh3SfrGWirX6am79Mbl1TIKT/CO09tLj656g0rUO45MV1KbCeRFu4QxV
	 EOQSj8801UCQasbCoDb/AE0zD8dnRoHJ9FUs3kGsb/oH16VEtcwMyuzstJe0DsuYf1
	 lLt3NFi+Eusg1lEfv+GOJYLMKfnp0aNCwoANl0cY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfIORHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 13:07:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40419 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfIORHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 13:07:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id 7so31530284ljw.7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XYNQ6+oH7Nk5c/Kknc3fsafALGxCA6iGb9vLHUrg13w=;
        b=Nhx4j06XDJpPMr71hJJe1AwkYJZOTKt6p3dUiWQllso6OHtzqUzkAGcZ1O91DzVlA/
         +rPxzlZsQM+iF0cW83zrhk5u183LTFqjbtRdWdQw40BK9/IaT6mpO9HGrfu82LAmGaCA
         n3y4YF33JtxpieJgydFwb/HM2AcJdcpbDVElo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYNQ6+oH7Nk5c/Kknc3fsafALGxCA6iGb9vLHUrg13w=;
        b=aQeNsY2rtNKuPrzAP32qjA/12prWD3JJkhfyXCmaFnzz3wXd9g94dzK75TTkdRrs6D
         c/f6bUpgYq74UDRkj9a67SXHjn74b0xzbvV5SaXdmMyxGQjJUTPbu0GF36ssHml5MsqZ
         IUSMnk8OSe4r03VUVJt30kf5yl0qAUQtr8R8hNx9pIkjD502UxDh4AwH8PgW4m1TcuYa
         e/oK8lCREGt6YGdnbIbLBOlbtAbFxARRMTl7BrgT5SJaPdNPz8nAvEEESCRzxKcflDh6
         8/cmsOr3PBK4N6EiQ5uHwkmghOS7s+U/qYFrZHoFUl5w+yyCm2nE+uZE00GG2MRJqHyk
         Jr0w==
X-Gm-Message-State: APjAAAV7/xS/Edo1qsdnjMhsIY9Yy6TtEI9O47xbTtJx7c7xAAPd7NRH
        fjfEk/EsSRim6Tq6AfHvKnN7oSK8y4Q=
X-Google-Smtp-Source: APXvYqx7FHYYjExRSJMyr51AriHSxzfLiMX8IDUByZdUGnn5II2FrFnmXIT78wWF9qOwYlZ3A6t6fg==
X-Received: by 2002:a2e:8649:: with SMTP id i9mr12886206ljj.97.1568567265482;
        Sun, 15 Sep 2019 10:07:45 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id g13sm7743182ljj.73.2019.09.15.10.07.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 10:07:44 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id x80so25637082lff.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 10:07:44 -0700 (PDT)
X-Received: by 2002:a19:7d55:: with SMTP id y82mr36147714lfc.106.1568567263803;
 Sun, 15 Sep 2019 10:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com> <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org> <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org> <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org> <87muf7f4bf.fsf_-_@x220.int.ebiederm.org>
 <87lfurdpk9.fsf_-_@x220.int.ebiederm.org> <20190915143212.GK30224@paulmck-ThinkPad-P72>
In-Reply-To: <20190915143212.GK30224@paulmck-ThinkPad-P72>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 10:07:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjT6LG6sDaZtfeT80B9RaMP-y7RNRM4F5CX2v2Z=o8e=A@mail.gmail.com>
Message-ID: <CAHk-=wjT6LG6sDaZtfeT80B9RaMP-y7RNRM4F5CX2v2Z=o8e=A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] task: With a grace period after
 finish_task_switch, remove unnecessary code
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 7:32 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> First, what am I looking for?
>
> I am looking for something that prevents the following:
>
> o       Task A acquires a reference to Task B's task_struct while
>         protected only by RCU, and is just about to increment ->rcu_users
>         when it is delayed.  Maybe its vCPU is preempted or something.

Where exactly do you see "increment ->rcu_users"

There are _no_ users that can increment rcu_users. The thing is
initialized to '2' when the process is created, and nobody ever
increments it. EVER.

It's only ever decremented, and when it hits zero we know that both
users are gone, and we start the rcu-delayed free.

            Linus
