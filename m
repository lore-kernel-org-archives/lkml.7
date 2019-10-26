Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEF6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 01:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDB321D7B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 01:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o11PcGm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfJZBJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 21:09:11 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42459 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfJZBJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 21:09:11 -0400
Received: by mail-qk1-f193.google.com with SMTP id m4so3471003qke.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 18:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SVVhqSZ+WUIIVID3TK3wMJn2IF/IhlQmlPLvMcYQ4Ik=;
        b=o11PcGm++xdhOJeo2IK9sFzGF7n9ywWXbuKSI39nD9RPFjlq90E240GgzjJSkrGYpE
         9Ka4GK/WywwswEA0J3auRvZglTDfv53rMPpys8LmvEZ3t0yTRQsICftSkxYyVfs5TNiV
         gFX3Yo6pxm5r/h5KP72nMj0YfchbtsBWKgHq+57nkjbzkMw+ZGl/nHNsPlg13CFlphB0
         tusRYdAH0HxptzGIOf7ANNPJJtfQ+BgZ47ca5QL0Jk8vj5SxbQ8lpnYTgTeeJNMsHcY8
         rp8BAafrE8txpVvWFxXbyVFBU0O4Q8ikOECBb4XbO3952tkfv/mHiqeyTUJzVIkQC1Tz
         EOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SVVhqSZ+WUIIVID3TK3wMJn2IF/IhlQmlPLvMcYQ4Ik=;
        b=nzTHv1Rc9CnAHzMXv6tWDWwUzFD/of5k1h1H6lz3yo8e8uJ0dYI/uhsNjpsw1hZPIv
         OgXGxgwtuZMtC6f+uiv9oNHy0+ySA8xNWqDkT3OTwNMQCz8kK6qriJGTwITIJCEByH4i
         spC2zNKvZu2fR70gtoC9qQ3a/xd97Tc+B+9zEHNY8UW+Chv8MCculHACCiMIeWTzI5kl
         wcCrl57C/I7k+va9kJy4MIqW5A4m1SS86vyM0nlj+zsbKng9R1O8jKSMLahoEq5yyTIP
         unf8UNRTjd6a20EaZLbGGMGxpzT6ahcisPAUu209yznizVyxZ4K2+skBiwl3flCjl17S
         oCcA==
X-Gm-Message-State: APjAAAXqHk24jVqEQ8E6JxmddI+kecp2CEwuixY7Wsx1/jYtN0q7AgP7
        +P3xq+T3OrKFA5C+KiAqT5uVq7rPsaa2Hw==
X-Google-Smtp-Source: APXvYqziEgRTRrtd9Yeos6xrvRuhxjwS1tLC4dGxfrGi1JC+yWRlaW4XPsi0QljKUfGOaNPnqfoVZw==
X-Received: by 2002:ae9:e8c3:: with SMTP id a186mr5484714qkg.97.1572052150047;
        Fri, 25 Oct 2019 18:09:10 -0700 (PDT)
Received: from cristiane-Inspiron-5420 ([131.100.148.220])
        by smtp.gmail.com with ESMTPSA id y10sm2555234qkb.55.2019.10.25.18.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 18:09:09 -0700 (PDT)
Date:   Fri, 25 Oct 2019 22:09:05 -0300
From:   Cristiane Naves <cristianenavescardoso09@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 0/2] Cleanup in rtl8712
Message-ID: <cover.1572051351.git.cristianenavescardoso09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup in rtl8712

Cristiane Naves (2):
  staging: rtl8712: Fix Alignment of open parenthesis
  staging: rtl8712: Remove lines before a close brace

 drivers/staging/rtl8712/rtl8712_recv.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

-- 
2.7.4

