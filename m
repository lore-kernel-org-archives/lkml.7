Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FB6C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8D92053B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTU9DhhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502950AbfIWVNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 17:13:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35321 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388807AbfIWVNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 17:13:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so9931222pfw.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 14:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+nwuC/x0W/vRuXJZDpyCBfwIDzszuyoHEHIS0SrkfVY=;
        b=vTU9DhhGN1pmi8Kl+I+Mh/RaRDp3FDHyObR1orwd/yRr5pHbrDYRnWF+6k99m9K5DN
         jqeA32xdPT7QUn0BG69QJF0A5PPUgyY+8vcoVrwMk8wwc0uTnLvaUhmJ4YI1C8TxblKR
         WRIl1aQbHqKXbjMEQR3aXBYcQT/Qx2gszYx0SWOr1NYRTL/Dndh+t1+iOBidsu5Kfd7b
         zB6tzyYDoWoCpNTKCHaUMhAUJfT9JD4j5E21gUrLjQdpqaRpMoWY8TXgbYbZVZGp+mjz
         gx8+Hxf32NvNWswYalQVuk05kjdApOKLG3cVaZRktRA6d5JLNcbTgbXyP3PrOX7EArDY
         8kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+nwuC/x0W/vRuXJZDpyCBfwIDzszuyoHEHIS0SrkfVY=;
        b=A/iK+/5bIXRLJ5iWRE7anUEUDV//77HxDOnjqPvKeum+t/R/bZQNGkeoF21TpP642K
         oMn0LLzSWOB+BSjyO1uPOLWYQx1e1cA/bF2QW3dtr+uPoeoBFSCkH4f69DczaQiHVmWe
         SWiOQDED4RaCnvfweKy6Mup8xxuinrmsD7noIPn8vdunF+nBGMX0DYBmov1Bd7wCJOaR
         N/H84zgGNSOiMIGYFP0BAXsSpTMDaXiqIEEkDazWm0P3zH/x7wJo8AdvFEUzvCqd0mWc
         c/yDxrTOxoHhA2QJS9ihaEGQTP3RxX6hw5hnyKPVmL0rDKls3yXwjYcPceGlW98fq/xY
         Gc7w==
X-Gm-Message-State: APjAAAW+wJ8a4PZ3iZB+92lHtMFT0XkMlpOFClvII9qNO6ri5eYBAhdR
        UUQchAbtKEQ9kHNdZQKXuiGkJNqSxM0ZgzY3N9SjPg==
X-Google-Smtp-Source: APXvYqzH64iS8Rjft0Y/aSmpWwtbZvB9ljb9ONrXBoo6fxAAcAV2MjFL0L2lopYflnbTRqXKiO3wk0XCq7rvAM0l5uc=
X-Received: by 2002:a65:404b:: with SMTP id h11mr1878320pgp.237.1569273228652;
 Mon, 23 Sep 2019 14:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190904211456.31204-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20190904211456.31204-1-xiyou.wangcong@gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 23 Sep 2019 14:13:37 -0700
Message-ID: <CAM_iQpUiOi8JDBqAtMHii5UHK3D6WQkk_G5DriJ9Y0yTYbWf3Q@mail.gmail.com>
Subject: Re: [PATCH v3] tracing: Introduce trace event injection
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Steven

Any reviews for V3? I've addressed your concern about Kconfig.

Thanks.
