Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7ABC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781312070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYoqAQE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfJHPo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:44:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43331 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfJHPo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:44:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id j18so19183773wrq.10;
        Tue, 08 Oct 2019 08:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ik2m9FPdKX52cXvVolzlosVqGxTHfy05l65Ynginb0w=;
        b=VYoqAQE+HXYBLMAJv0D5U2+OxYW6PqQL/r+l3/Qg7vS1xpHQZKB+1VCjpdSaC3UBP6
         MZgUSKFoyyC1jrGe6gMns0JxwT78leyR84NvITDOSUZIQHwQ5bGMtiic++7OSm0DR4h1
         Bkh4CrrjNcH0LvvZ7fA1FC60nPWQ2fZwkq88QiXR1kMd2I03kwoYQ0jSd9tylguoziM3
         YJbvQMxAwKx625CTtZijSnD0XLzNjrI3Js1wOHlNPvbcUDEw5/y6yNxs1F9mUkJwyAO3
         yLtOCrpqHTXh2J68ZCBiKU4TtbQKz3+vnE8bUxn+liRGqBjOEg74xerRpibcknmDvoho
         QYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ik2m9FPdKX52cXvVolzlosVqGxTHfy05l65Ynginb0w=;
        b=DlE8XzxjkF8NYrs8En2xQiWwx3cndZJPOm1gPI+Jvd0P1dmRZTtbs4B8nA+aupGMxf
         5nTlY+6ot5z0V4vWG+MQCnMXWKpULooxQ/Kf1+PxSr77VNswSzap0DyROMuIDvA/GIki
         oX1lEiOPpAtXiAElH+5jwKJztPEiutc5Vhp/TAaUvF/hiTK79CAn+sl+4+U19aQCmVTO
         4lX/tXP/U82vPS11xWFnKGwSSuTjrI8Z8yQ61Ad1c4m6YfkifiTV1jroqqlUKHKeYWFp
         8RVDxZr5FDKn7QrVzehVP2Z3tFure+8MP0h6IhRGOWH46HAtQp8tgyDCW748y1YILkeC
         782Q==
X-Gm-Message-State: APjAAAWCjH/zNAxgRn1dKn4FIpsdoaQZa1E+vre5xkcYj3LSbx21NRsk
        aLkYECimtPjCJKmMRcjulEg=
X-Google-Smtp-Source: APXvYqxnZ+C/X/2XzY2LKLEobu8E1H0xYl1lXD1D8jwjxdUgX0UUJXiObYOMDpdP+bPWlslhs9ooBA==
X-Received: by 2002:adf:e3c8:: with SMTP id k8mr15924318wrm.268.1570549464564;
        Tue, 08 Oct 2019 08:44:24 -0700 (PDT)
Received: from andrea (userh394.uk.uudial.com. [194.69.102.21])
        by smtp.gmail.com with ESMTPSA id p5sm3342941wmi.4.2019.10.08.08.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 08:44:24 -0700 (PDT)
Date:   Tue, 8 Oct 2019 17:44:18 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, bsingharora@gmail.com,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2] taskstats: fix data-race
Message-ID: <20191008154418.GA16972@andrea>
References: <20191007104039.GA16085@andrea.guest.corp.microsoft.com>
 <20191007110117.1096-1-christian.brauner@ubuntu.com>
 <20191007131804.GA19242@andrea.guest.corp.microsoft.com>
 <CACT4Y+YG23qbL16MYH3GTK4hOPsM9tDfbLzrTZ7k_ocR2ABa6A@mail.gmail.com>
 <20191007141432.GA22083@andrea.guest.corp.microsoft.com>
 <CACT4Y+avbYvtF9mHiX=R8Y2=YsP1_QsN6i_FpjLM7UxCKv6vxA@mail.gmail.com>
 <20191008142035.GA13564@andrea.guest.corp.microsoft.com>
 <20191008142413.h5kczta7jo4ado6u@wittgenstein>
 <20191008152659.GA16065@andrea>
 <20191008153533.r43qyvasfqahmq6f@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008153533.r43qyvasfqahmq6f@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh ups, yeah of course :)
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=taskstats_syzbot

You forgot to update the commit msg.  It looks good to me modulo that.

Thanks,
  Andrea
