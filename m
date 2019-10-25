Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0766CA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 00:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15EA21928
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 00:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="caAydi5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbfJYApi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 20:45:38 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:54693 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfJYAph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 20:45:37 -0400
Received: by mail-yb1-f202.google.com with SMTP id k79so611688ybf.21
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 17:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ykFrkrtkEuTw1kHPTs7ZKgy0svb1H2iYZiKkqKmnwyo=;
        b=caAydi5ejwcAIKJB+h/wUp8YdaIkgAPPznlLGZBkHbnI6yj2GkZKxIkLsh/yxTN7xc
         VAnEO9LWW8EFcUph6sYxzx6b0gKkJlX30tmIljhyc3mTyRmEjsEpRNsvzB+71uOWCSQt
         2hw+6NiU+kX7ZDh8GtMNEUgv1mVZ7FArsc6GhCYr9IxwTx6FK3hg6e4ngvKNiVcvEy6a
         BzfEs4n3534cyL8HRkXAYSg3BfqC0q9pKHVJVF9R00Z+qvuDIZCQeeyWQocwZbuclchU
         7vvJs317Gq6UDwoBUFAMNxBYh2aI9SaRA/LHPLmc8in9XojzLpJdrXxdCdhvXMb9zjkx
         OIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ykFrkrtkEuTw1kHPTs7ZKgy0svb1H2iYZiKkqKmnwyo=;
        b=EMkkarMR6HfPhYMZKbp1fYqv8wrw/bm5z9o77THPqBbN8Yn54N8VZPDQR5kbHpId1F
         cEhot7t8F7eRETD/kJGodHwdEbaCDsBpyJmSJBS+Ip8gePcyZpBZHS6MicsH7Xkacr0d
         2wfF6WM1nsjjyo/v28FtwHWCG1DDolCQBlj7eCSjt0hq2taopleIyVSCGKaUjFil2Ug7
         uRJW8xAPFFI5ytojoqquCDsCW8iJ3LNj/MzJeJiMfAK1PhTEqX6zgitiXsZsdwrbECp+
         vfHSw4L8RfKXcImpjV2oc0K/LXkmF5PJ1Dc1UpMOl1wE2t03joFhHiipGkwdTikE99Us
         vifQ==
X-Gm-Message-State: APjAAAW/xVqtIEP/QiScRHZtnTR+bLhXTr8CHNV6y9UgROP12MUSaeZ7
        v2NpPIwNSp3nI1krkmkpy/6lBtTYQuU=
X-Google-Smtp-Source: APXvYqxGFEMFLOZigeTFDOQm5tsU7MYmQW2vciA/3Nu5rxcdD+N6iPXPa9sJ/vz/kyTh/xhzdR/xPBC3Kx0=
X-Received: by 2002:a25:afca:: with SMTP id d10mr1027880ybj.54.1571964336762;
 Thu, 24 Oct 2019 17:45:36 -0700 (PDT)
Date:   Fri, 25 Oct 2019 09:45:31 +0900
In-Reply-To: <20191018010846.186484-1-pliard@google.com>
Message-Id: <20191025004531.89978-1-pliard@google.com>
Mime-Version: 1.0
References: <20191018010846.186484-1-pliard@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: Re: [PATCH] squashfs: Migrate from ll_rw_block usage to BIO
From:   Philippe Liard <pliard@google.com>
To:     phillip@squashfs.org.uk
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        pliard@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Personally speaking, just for Android related use cases, I'd suggest
> latest EROFS if you care more about system overall performance more
> than compression ratio, even https://lkml.org/lkml/2017/9/22/814 is
> applied (you can do benchmark), we did much efforts 3 years ago.
>
> And that is not only performance but noticable memory overhead (a lot
> of extra memory allocations) and heavy page cache thrashing in low
> memory scenarios (it's very common [1].)

Thanks for the suggestion. EROFS is on our radar and we will
(re)consider it once it goes out of staging. But we will most likely
stay on squashfs until this happens.
