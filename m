Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571E5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B6820835
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfCSQ4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:56:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41526 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfCSQ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:56:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so14105345pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JbLDn38ENuwUNilFgHlGP9jX7vfJVVtIackWhCzkZUw=;
        b=fQIfUgnH4uzH65ajbnalEQQU3ZEcv+y1i79YuuYSUr7X710Oi/xjRDvj837a+xNuK2
         0UpxY9lF7ilg0J22W5mkQEM86XT59gTPWHE5mONO6shHoWFjt8aRzwnXAGJonxIndDxj
         AFs1lQrDbEx7/wKUAusmjn/UKfgwjVdwj1T/ReKhLs/GmfG/RJbX7ty0TdBuGSg74QSl
         LKysoAFGmwccyUapvRPMoq2/MjRB6wDiHQMIOVeNa+PyyUlWZQSIV1CVmkSSuynn2UmH
         JsGrFJ8T3Ewg8Cix3cEN0pR1cBqg2Zt04Tabno4edDB1UiJz2Iq0NwcL7oWGiBEAqX4O
         IYeQ==
X-Gm-Message-State: APjAAAXfccR5MWWfDNWr06ccz+Uhzc0XFx0gf5XeO2Di1oJKJnpcJh7u
        xLHqjLWNgf/ZTZ9jVZMCr3E=
X-Google-Smtp-Source: APXvYqypxYdTFUoGH8hJvlsOwEfNbowGlboGZ++5tGgRC564fNBKEgl0p4tptsgVSnl4XOP5rKs3Ag==
X-Received: by 2002:a17:902:9a02:: with SMTP id v2mr3472941plp.201.1553014611725;
        Tue, 19 Mar 2019 09:56:51 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id t129sm10776016pfb.127.2019.03.19.09.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 09:56:51 -0700 (PDT)
Message-ID: <1553014609.65329.12.camel@acm.org>
Subject: Re: [PATCH v2 16/19] locking/lockdep: Use function pointer to avoid
 constant checks
From:   Bart Van Assche <bvanassche@acm.org>
To:     Yuyang Du <duyuyang@gmail.com>, peterz@infradead.org,
        will.deacon@arm.com, mingo@kernel.org
Cc:     ming.lei@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 09:56:49 -0700
In-Reply-To: <20190318085733.3143-17-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
         <20190318085733.3143-17-duyuyang@gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-18 at 16:57 +-0800, Yuyang Du wrote:
+AD4 +-static inline struct list+AF8-head +ACo-get+AF8-forward+AF8-dep(struct lock+AF8-list +ACo lock)
+AD4 +-+AHs
+AD4 +-       return +ACY-lock-+AD4-class-+AD4-locks+AF8-after+ADs
+AD4 +-+AH0
+AD4 +-
+AD4 +-static inline struct list+AF8-head +ACo-get+AF8-backward+AF8-dep(struct lock+AF8-list +ACo lock)
+AD4 +-+AHs
+AD4 +-       return +ACY-lock-+AD4-class-+AD4-locks+AF8-before+ADs
+AD4 +-+AH0
+AD4 +-
+AD4  static int +AF8AXw-bfs(struct lock+AF8-list +ACo-source+AF8-entry,
+AD4                  void +ACo-data,
+AD4                  int (+ACo-match)(struct lock+AF8-list +ACo-entry, void +ACo-data),
+AD4                  struct lock+AF8-list +ACoAKg-target+AF8-entry,
+AD4 -                int forward)
+AD4 +-                struct list+AF8-head +ACo(+ACo-get+AF8-dep)(struct lock+AF8-list +ACo lock))
+AD4  +AHs
+AD4         struct lock+AF8-list +ACo-entry+ADs
+AD4         struct lock+AF8-list +ACo-lock+ADs
+AD4 +AEAAQA -1392,11 +-1402,7 +AEAAQA static int +AF8AXw-bfs(struct lock+AF8-list +ACo-source+AF8-entry,
+AD4                 goto exit+ADs
+AD4         +AH0
+AD4  
+AD4 -       if (forward)
+AD4 -               head +AD0 +ACY-source+AF8-entry-+AD4-class-+AD4-locks+AF8-after+ADs
+AD4 -       else
+AD4 -               head +AD0 +ACY-source+AF8-entry-+AD4-class-+AD4-locks+AF8-before+ADs
+AD4 -
+AD4 +-       head +AD0 get+AF8-dep(source+AF8-entry)+ADs
+AD4         if (list+AF8-empty(head))
+AD4                 goto exit+ADs
+AD4  
+AD4 +AEAAQA -1410,10 +-1416,7 +AEAAQA static int +AF8AXw-bfs(struct lock+AF8-list +ACo-source+AF8-entry,
+AD4                         goto exit+ADs
+AD4                 +AH0
+AD4  
+AD4 -               if (forward)
+AD4 -                       head +AD0 +ACY-lock-+AD4-class-+AD4-locks+AF8-after+ADs
+AD4 -               else
+AD4 -                       head +AD0 +ACY-lock-+AD4-class-+AD4-locks+AF8-before+ADs
+AD4 +-               head +AD0 get+AF8-dep(lock)+ADs
+AD4  
+AD4                 DEBUG+AF8-LOCKS+AF8-WARN+AF8-ON(+ACE-irqs+AF8-disabled())+ADs
+AD4  
+AD4 +AEAAQA -1445,7 +-1448,7 +AEAAQA static inline int +AF8AXw-bfs+AF8-forwards(struct lock+AF8-list +ACo-src+AF8-entry, void +ACo-data,
+AD4                                  int (+ACo-match)(struct lock+AF8-list +ACo-entry, void +ACo-data),
+AD4                                  struct lock+AF8-list +ACoAKg-target+AF8-entry)
+AD4  +AHs
+AD4 -       return +AF8AXw-bfs(src+AF8-entry, data, match, target+AF8-entry, 1)+ADs
+AD4 +-       return +AF8AXw-bfs(src+AF8-entry, data, match, target+AF8-entry, get+AF8-forward+AF8-dep)+ADs
+AD4  
+AD4  +AH0
+AD4  
+AD4 +AEAAQA -1453,7 +-1456,7 +AEAAQA static inline int +AF8AXw-bfs+AF8-backwards(struct lock+AF8-list +ACo-src+AF8-entry, void +ACo-data,
+AD4                                   int (+ACo-match)(struct lock+AF8-list +ACo-entry, void +ACo-data),
+AD4                                   struct lock+AF8-list +ACoAKg-target+AF8-entry)
+AD4  +AHs
+AD4 -       return +AF8AXw-bfs(src+AF8-entry, data, match, target+AF8-entry, 0)+ADs
+AD4 +-       return +AF8AXw-bfs(src+AF8-entry, data, match, target+AF8-entry, get+AF8-backward+AF8-dep)+ADs
+AD4  
+AD4  +AH0

I think this patch makes the code harder to read. Additionally, if the compiler doesn't
do conditional folding, this patch introduces an indirect branch and hence will make the
lockdep code slower.

Bart.
