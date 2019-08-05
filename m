Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5F5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F41E216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwhbFavl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfHEPPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:15:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37492 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbfHEPPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:15:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so73367628wme.2;
        Mon, 05 Aug 2019 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nmuGUOIC28IxEYrbOHuA1ZD4ArXBBH9hmSjl0u0BjJw=;
        b=DwhbFavlVDBiK/sGIzwfOk+FllytIeFVeNsZQvlOk+xWQd7VMPa7suuV3G5hemtWbJ
         hbglmY1keLXMA13hyeJ1xyHkExQDgM+7iWqOB4NevHexnVT5VFl8F93Lg4MTxjI6+sQy
         0r1xZEvxoMgkKt2pizYZBT5SY6f+AffJu7beT5Utq6jQQUAUw2nasAwj1OIIf8atBWXS
         51ras62sPGbmqYoBxKh7/C59zeYtHGohX1SU0lRsLVahfTeQPJQVjFkBOojhPal99poh
         YCh+U+xTc+JjE19iwnXi8/K2eBgw267M+xrjIJZoJMvV5/LF9bJJeNHN02quphhyODbu
         utVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nmuGUOIC28IxEYrbOHuA1ZD4ArXBBH9hmSjl0u0BjJw=;
        b=ZPaxHUYymAcwQ6WkvriAU5eYnXkVKRR8yJH0La0tZZn2XeTsdGBi2HsL74vh+PZEFr
         wecqOUpTwYr/gUJX4OAZG0xOrHNbsszaWrjmG1e0W0Dnh2aNjG51LQEPf54he6i1200C
         kB3O7QTfb1Yv0h8afilH2ebnubUnqHSqMQVD4apUt9fycrB/J5ZuKV8d3y7mc2t7v53B
         HnHVxBrDzQ9dEh+Mzdb47SY1TP7j9oytJrzOq6HpqoIjOiPoqTrAtS5iCeWnhNbc6+QA
         WP7j00monHPTQZaApW9nM2pj6PQnJlEQuEMbD9Ci0k4NFXdg0uAriEIpm+vhwj2TC7FP
         vNmA==
X-Gm-Message-State: APjAAAVmZwSMGvPTMPbayTFfHeiHVq/yHUqSsSgTHg/6+wm1FV1q3ulF
        icV6L1RMkQqzMIi3V1iKiHM=
X-Google-Smtp-Source: APXvYqy2NxRrZIQUfQf/Nyr7ODMb2/r7hZ0f43T303tx5WG3atkoeQoZvslKcc6jMfcSBAFU3sSqCA==
X-Received: by 2002:a7b:cb94:: with SMTP id m20mr18403581wmi.144.1565018152907;
        Mon, 05 Aug 2019 08:15:52 -0700 (PDT)
Received: from aparri ([167.220.196.45])
        by smtp.gmail.com with ESMTPSA id v204sm102007076wma.20.2019.08.05.08.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 08:15:52 -0700 (PDT)
Date:   Mon, 5 Aug 2019 17:15:45 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [PATCH] MAINTAINERS: Update e-mail address for Andrea Parri
Message-ID: <20190805151545.GA1615@aparri>
References: <20190805121517.4734-1-parri.andrea@gmail.com>
 <76010b66-a662-5b07-a21d-ed074d7d2194@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76010b66-a662-5b07-a21d-ed074d7d2194@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why don't you also add an entry in .mailmap as Will did in commit
> c584b1202f2d ("MAINTAINERS: Update my email address to use @kernel.org")?

I considered it but could not understand its purpose...  Maybe you can
explain it to me?  ;-) (can resend with this change if needed/desired).

Thanks,
  Andrea
