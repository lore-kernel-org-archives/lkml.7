Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BB2C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591B92089F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+gLEkNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfFYFWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 01:22:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44552 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfFYFWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 01:22:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id t7so8166637plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 22:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/gWuRyU/Duq5CAjVUkd2QM2Pr9Cpbj+2yc6xJIqbYg0=;
        b=h+gLEkNLHZI8vojygUc5xkXMj5Ju/qGHRsfGvpLiGP2lBjfFLyAqK+RDSp3CkKzuod
         PJgZxbWv47976szedhsoRivQbdE9jnXELNP7kYJS6JxtT9/rcHqRrlYySPF3bNPx1ilt
         oLhi6hYouYvweu0bIplQf8OSvL4sB1SypFdP6USWti5Io4JMzO6s60SUOmssi+HFNTFD
         l1ZHxwt/FT02sadDIpqaXNbhBpAmwTurb85cwUFbrW+wPmQq+crblfvoABz1tfix2O5H
         DssgQqqzklDPKS6YZI+GdLIgF0sfOnFaQvNuD9PzUqOHa8liPtc2rIcRMjIr2kLx5rlF
         aIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/gWuRyU/Duq5CAjVUkd2QM2Pr9Cpbj+2yc6xJIqbYg0=;
        b=qOTP2he5uiegcZW90OulnuJ5mVUyqHlRBJyCtS1ca/CFbPBTPH1Gt4mLPLRmYEORuJ
         krOPOc0NQ9RFPEfCAMdd3ZQwp4I7i8jTXhPiMd68FfbRu8S2soJIql5EMBoFpPVSNib+
         xPdT3yfWVVvmvhL1mOPKhHmINOIXqr3fSktDzyossUEgn67acMmO431tD6Wi4YjQn0Ji
         6ksM0uVJFCgHz/LSfiqqlAboXWCBtZgMnculOlUi0FE7AHcyfRXPNzk6LPaRI/DcDG74
         2M6YHvYXbI/+/f2Hp3U+IUao3b0arngJpsyBEEDaW2dt1KA4mfrfaqR8jlj0U+L/4dK3
         OKhQ==
X-Gm-Message-State: APjAAAW9gxK9oMTt2Xup5MsNOf3O1XsfemrcV7sPwu1AyaWxID38n98m
        QeoeWkm30nY1QzKaBBScOQpNmA==
X-Google-Smtp-Source: APXvYqx6447KBR7F9f0rnZe2hhCgdBbpaALrx7vLYLsRwlMUTihth3sIcjPTgIzTmQm89dV5ft39jw==
X-Received: by 2002:a17:902:2a29:: with SMTP id i38mr125187497plb.46.1561440150610;
        Mon, 24 Jun 2019 22:22:30 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id a22sm13653060pfn.173.2019.06.24.22.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 22:22:28 -0700 (PDT)
Date:   Tue, 25 Jun 2019 10:52:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] Add required-opps support to devfreq passive gov
Message-ID: <20190625052227.3v74l6xtrkydzx6w@vireshk-i7>
References: <20190622003449.33707-1-saravanak@google.com>
 <20190624094349.rtjb7nuv6g7zmsf2@vireshk-i7>
 <CAGETcx_ggG8oDnAVaSfuHfip1ozjQpFiGs15cz8nLQnzjTiSTg@mail.gmail.com>
 <20190625041054.2ceuvnuuebc6hsr5@vireshk-i7>
 <CAGETcx8MuXkQyD5qZBC948-hOu=kWd4hPk2Qiu-zWOcHBCc=FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8MuXkQyD5qZBC948-hOu=kWd4hPk2Qiu-zWOcHBCc=FA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-06-19, 22:00, Saravana Kannan wrote:
> All of the cases above are some real world scenarios I've come across.
> CPU and L2/L3 on ARM systems are a good example of (2) but the passive
> governor doesn't work with CPUs yet. But I plan to work on that later
> as that's not related to this patch series.

So in case of CPUs, the cache will be the parent device and CPU be the
children ? And CPUs nodes will contain the required-opps property ?

-- 
viresh
