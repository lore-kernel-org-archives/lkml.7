Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6415C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC0F21473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFwBKChN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfDIJp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:45:57 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33204 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIJp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:45:56 -0400
Received: by mail-yw1-f65.google.com with SMTP id l5so6019507ywa.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 02:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R/XsV/8Ukf+RUb49ThZY9ILm7j6ClSjMvZz7QocK+HA=;
        b=YFwBKChNbe2wytzY/L8eWK4QM5OTjdY+L4TgcIt1zqs62ELypAhX0hrGMYQL7rTIhv
         APlq1ddNN60yokmEYfGZ2qpyRY0pUSJJTzK7hnpojESQcDJfyDJWOvCM/Tey2NUFFfh2
         DcM6XMhF+ERgV1CixQfLDY+5Xg39IksSeAZuxJVLG/DrhCoBurdhUF6t9SbopOa1l/iO
         KwweQEoDHT9hRuoLUOheexXmyHdIzG/7HZJhPElSJzCWaSb6XcnL5Y2lVRY3Ol5G8YDA
         vV4Yk/Qese19NNqyAi8/PN5bVvssulEL3PdPxJ8AR6NlV6mPyaoZUmC+cqFOYnU5LPvx
         p/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R/XsV/8Ukf+RUb49ThZY9ILm7j6ClSjMvZz7QocK+HA=;
        b=kv0VffXx+5f9N0Qa41m0PGw4xxLssqguuVtFllpQslLPZb/uQlnnxd1lr2WBFtGR8/
         3VHYY+wwIGGKIiabILEG9qjsdMxuHcvxV4G4NBQb63QFvSosgOtPaa+zKpWN6uYkaDov
         TWx9gn5L73476/fig9VKBnZrmRWMpJSR74DmxF2SGLH2KKx5+iX0m3an/LemO71QI1uf
         mUTeSucBDR6/7xe3eFH03S9DutsUKtJvcztpCwRyzYfrGF5CRVaF7gjwae5+x607xWhY
         w9JQy3BbQfNInWZ8lGlEX31pObiJVtTv89Y10HaBRx0BxHqIKYH6bzUkDu/1DmkdMjqL
         Ht7g==
X-Gm-Message-State: APjAAAVBhriLvJII1CM6zCWC2+dWKpg/CfyAzz0ziJ9QPlNPkV2F3O1W
        hIPSOujVUkv5BI+T+hUvV2DMHO48+HS3ovqzmEjxQg4kHdU=
X-Google-Smtp-Source: APXvYqyYiaKcnKgqhX+qkMz4o1eVUn7fFoT5hup3soRtdbX+cnIwOC5hTX3zXmfMPpAWheWNjA58ueRCLXSP5kW7aKk=
X-Received: by 2002:a81:4fd5:: with SMTP id d204mr27576554ywb.186.1554803155937;
 Tue, 09 Apr 2019 02:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190406183508.25273-1-urezki@gmail.com> <20190406183508.25273-2-urezki@gmail.com>
 <20190408231905.GA31139@tower.DHCP.thefacebook.com>
In-Reply-To: <20190408231905.GA31139@tower.DHCP.thefacebook.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Tue, 9 Apr 2019 11:45:45 +0200
Message-ID: <CA+KHdyVRL7hWw8mLvpHj46NCnZ_Cttkw1+ycjR-XP=ohEAnJuQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm/vmap: keep track of free blocks for vmap allocation
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Roman.

>
> Reviewed-by: Roman Gushchin <guro@fb.com>
>
> Thanks!
I appreciate your effort in reviewing to make it better.

Thank you!

-- 
Uladzislau Rezki
