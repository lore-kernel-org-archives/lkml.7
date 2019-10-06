Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BD0ECE58B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 01:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEAA222CC
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 01:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="VKMUSr+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfJFBKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 21:10:14 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37444 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfJFBKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 21:10:14 -0400
Received: by mail-qk1-f194.google.com with SMTP id u184so9421605qkd.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 18:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=xfdmA8M/W1YMg/+4itYVhj2XcgD+xfvYoNOBbsbab/Y=;
        b=VKMUSr+sK6+fISi1oTMW5IHAlJYEon8XgvGKfjZMqnSFFY/Vxxs8xyZtneluNlaV2t
         i5PyaUKOaNAFeP6vjagfN35Gs6uwiNpOMNZHmjwilWhXlHrVvvToj28TbcID3qllmtZG
         ga9AZnEIeKLOBTHzGhGKmPMpkzkpTuDI+7vSN8YVSEHRU+46WSFIiY5mV6dftqvZH4Rb
         TMAuLFtSU8yUlbvrw+YhtC2T1mySbACrBSW+nM4n3t0OZz+VUpnV57iajqAKAZQm97+u
         JTIwuWVUbW09ZmejLy/8l5Gs+H5RuBHA5nN3bCNwDoJktpQ3aMt88/Bvucb9BO2rPb2G
         W6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=xfdmA8M/W1YMg/+4itYVhj2XcgD+xfvYoNOBbsbab/Y=;
        b=OheRiS8tg7gZMUeR3qXevTuomVlXFyqq1h7GxIt1DUWnIGV1nZsdg4TD+/Ljkk4rc/
         IQ8kVXhZv9imUPxIY/zonY2ttLhT4ItaQxvJ2jhaninuRj9nl5ZVJIXeoXc6BCGnNlEi
         JrdwoBUaSOJipTSIIGfUMjxjMAnLgY6gsqjmq5teYdzgNMfdzQiEco7se0UF72Y9/j4B
         8LNdh25crHCi/+1j9DIjRgKieUlH0U93742fNpaXFTx3TwBsdPaSoqthnATposuHmKwN
         alVxxqR0pmjcbT+zrJgoCbbmRNi8JTBM2mUSmezHuYanSKDtGg6fBB0WxP6tUUq4gZHn
         vCMQ==
X-Gm-Message-State: APjAAAWh56nefUhNymGrH271xuD29vrkV4prWmnzQIZycAA7omFyeLRT
        lBkCBu6hY+LKKkdWsRujrdnZieFVmGOYrA==
X-Google-Smtp-Source: APXvYqzj54VW6CXx8kFyyfS5D9deMTfRs4//fdbmEc7+jmnN+uMfbUBUkhWmEgRNgroxK80NpYV3qA==
X-Received: by 2002:a05:620a:659:: with SMTP id a25mr17120595qka.151.1570324212802;
        Sat, 05 Oct 2019 18:10:12 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 29sm5601981qkp.86.2019.10.05.18.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2019 18:10:12 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_isolation: fix a deadlock with printk()
Date:   Sat, 5 Oct 2019 21:10:11 -0400
Message-Id: <D1060F1F-0D5F-4687-AD89-64A5025897FB@lca.pw>
References: <20191005174423.23f2db80872a9365009f398a@linux-foundation.org>
Cc:     mhocko@kernel.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20191005174423.23f2db80872a9365009f398a@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (17A860)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 5, 2019, at 8:44 PM, Andrew Morton <akpm@linux-foundation.org> wrot=
e:
>=20
> There is no "console_lock".  Please be much more specific.
>=20
>> It is easier to avoid,
>>=20
>> zone_lock -> console_lock
>>=20
>> rather than fixing the opposite.
>=20
> "ease" isn't the main objective.  A more important question is "what
> makes sense".  We should be able to call printk() from anywhere, any
> time under any conditions.  That can't be done 100% but it is the
> objective.  printk() should be robust and not being able to call
> printk() while holding zone->lock isn't robust!
>=20
> btw, this:
>=20
> : It is unsafe to call printk() while zone->lock was held, i.e.,
> :
> :    zone->lock --> console_sem
>=20
> doesn't make a lot of sense.  console_sem is a sleeping lock so
> attempting to acquire it (with down()!) under spinlock is a huge bug.=20
> Again, please be careful with the descriptions.

Sorry, It is console_owner_lock.=
