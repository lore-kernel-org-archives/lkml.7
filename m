Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6825FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C732084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552354803;
	bh=t5ZjrsxzbZlhS6O5yeRqWloP9Tk3sS1M3pP0PdibQYU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RQ/9bCp+XCLhkGc0660bVpgtYr3hsOz5c7Vm/qkWkEnMB6hSyaKUVDn8CDUUsVW/Z
	 vf6FCL/iNpd5QwhkcRgIXKSOJn0UNNJfdfOk50xlebqJc248MKp6gVTPby1kvapjjg
	 BBvPPizrqwnAjsvJRErXGHcwEGuUzDTCMRLnSzXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfCLBkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:40:01 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42208 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfCLBkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 21:40:01 -0400
Received: by mail-lf1-f68.google.com with SMTP id p1so756092lfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 18:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yx4U7RtqFLC0kTAym7BWOYVF533Vz5w77qBpj1RTfjQ=;
        b=HJWQ7Qp9OGxO349aX3yWPC4Tj6ebKWqdAy2jriyPXPQ8LalpIFhW3IYSxyh2WxWsd+
         ty9ygY96SfDRy3O7oYmC0Wy2gptxTdLSRzqTtFrafos+zupCksex4UXBMs7CmjJB5/mu
         9V7095XFPNeVanQPqO8D7EZJGH9jbtVWNck7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yx4U7RtqFLC0kTAym7BWOYVF533Vz5w77qBpj1RTfjQ=;
        b=pKkGvQOgj+Rr3xh2F3TmiLFpTg9Gp31S1kDOUTc97NEQO4Ct5pjyVw8jRIRlaf1Mhh
         7nvW6MS8MkU7ugbGjekOy5N3rEZfrl2GHrdvvbQ5Lvw7LuZny3XkbIKnqvB4EeZWWDSU
         L9EbjI6OhuIndUc0JNVvv1eYUL6s+jedGA3AOH+5y/PLSJHd/+NyNt5bVsgNY/ugVOEo
         NUpDVCrEhjN8ydSO7qSex+xC+qfnGAVGmlkZH4APkT6BSJFTMzvQyoCW6NQl4h0VvZDo
         TYAIMJuM98j/Bm4/CV1b4f/0mjQCMdFG6KwDlk4/2UDWb68Ex8ZRNYzZG35wy8rifXcw
         MnAQ==
X-Gm-Message-State: APjAAAV3b/mdtuBjpDWoorA0+v12ceSdDhfOw8TbaltXsRk5NuEPGTSH
        /+byUdUlw5Gf85p1t7r7iJLRswhuQqI=
X-Google-Smtp-Source: APXvYqzE3oia7WEHMgMGM58bIYXaLQimvl/zeXTjtDoGX2MZJL5/MLhLaBiVWcjLbxdwMADCycV+8A==
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr18517521lfc.124.1552354798513;
        Mon, 11 Mar 2019 18:39:58 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id m21sm1137714ljc.11.2019.03.11.18.39.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 18:39:57 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id p1so756051lfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 18:39:57 -0700 (PDT)
X-Received: by 2002:ac2:424c:: with SMTP id m12mr20329166lfl.62.1552354797147;
 Mon, 11 Mar 2019 18:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190311182829.GE19508@bombadil.infradead.org>
In-Reply-To: <20190311182829.GE19508@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Mar 2019 18:39:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1hqVm0rxF66MU2NkWGD8qPLmbebHV1pFNjhNuCGaGnA@mail.gmail.com>
Message-ID: <CAHk-=wg1hqVm0rxF66MU2NkWGD8qPLmbebHV1pFNjhNuCGaGnA@mail.gmail.com>
Subject: Re: [GIT PULL] XArray updates for 5.1-rc1
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 11:28 AM Matthew Wilcox <willy@infradead.org> wrote:
>
>   git://git.infradead.org/users/willy/linux-dax.git xarray

You forgot to tag it, and I don't pull from external untrusted sites
without signed tags..

Please? I know you can do it, because you've done it successfully in the past...

                 Linus
