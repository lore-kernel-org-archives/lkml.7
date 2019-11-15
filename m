Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E55C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3887020730
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pT5JWBdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfKOXKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 18:10:48 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:39484 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfKOXKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 18:10:47 -0500
Received: by mail-pg1-f172.google.com with SMTP id 29so6656240pgm.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 15:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=tQ3lvrS3blm9KMnMM0Lci3Z1sGKOamHxljOn3CuMDbY=;
        b=pT5JWBdCAjIGTWuNcLh+8kHAirWygCIcGtV+7SqbZj/KpGYc99JYbfhUZCrPPratnM
         d7NlCrAWgnZkYYPP/J9uSONJcYTmnCOGFerQFynY2FPqUP/VNw3O0Fg4aSfLaxWV7jT3
         mvNDuBPOIW1lnvAPSQCglBlVnkqnUtENac8bjo9rce6G4UdH4gZZNpP5lAjk2E5hZsD/
         hvsKERBv4q+n1jMC8yVUXJrg4yFsCy1mDlAaEJMcwH4Ifq5LblyMrENIVjNsIZc2gY4T
         ZI8FZc3Np0xPw6PHsAo9s7DE/jdxwkWaVvS8WijRM+KjiDH61HXyDJQg/n6CXZJ3CWmi
         nmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=tQ3lvrS3blm9KMnMM0Lci3Z1sGKOamHxljOn3CuMDbY=;
        b=XLiuboC6zgpGcCX7OWR/XTcRh/Wjmm5/0VkM46p8yoUf5Avr13tC9xeL26xJ4Wpavz
         ShSY0r3VarKgBjF8NtQYwv3ih1G66GaedrAB//TzvjhnUmjI50YMbOX1YqWPLcdkjb0R
         Evv8RzcUcGF+zk+QxNGN37PUSUh0Wi/AJViNr1hsRTRXg94cJ9zIeJNks1DprELiRVNf
         OkXgYRwPJB16pC5uuLnE7eSfLf6m9SVynU3qz/UzJnkZn/2TnIr9Z1KUZSQ9GwiguXgD
         k31Bi1wPzuRpVpIkKNxebOQ9na4uq16FLh81ffbuO4dB3eEkEQrfTtR76/o39axx87yG
         epwQ==
X-Gm-Message-State: APjAAAUwN0owGylRVhF8AkK+JcTxDOrST3N446Ccz75yIEklZRZSuUnb
        XVEL9vz9XWSD9AqafNsRr6NWXiQr7aE=
X-Google-Smtp-Source: APXvYqy+4lU01UeVkOSTSTAdSRd9AT8DW/Xp+4MWRX3F8hpid7A+dV0245Knc+YxZRpdcznwGa62/w==
X-Received: by 2002:aa7:8210:: with SMTP id k16mr20243455pfi.84.1573859445210;
        Fri, 15 Nov 2019 15:10:45 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1134::115d? ([2620:10d:c090:180::be7a])
        by smtp.gmail.com with ESMTPSA id b26sm11209631pfo.158.2019.11.15.15.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 15:10:44 -0800 (PST)
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: Recent slowdown in single object builds
Message-ID: <d60946a1-fde3-ee6f-683a-42a611768bbf@kernel.dk>
Date:   Fri, 15 Nov 2019 16:10:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've noticed that current -git is a lot slower at doing single object
builds than earlier kernels. Here's an example, building the exact same
file on 5.2 and -git:

$ time make fs/io_uring.o
real    0m5.953s
user    0m5.402s
sys     0m0.649s

vs 5.2 based (with all the backports, identical file):

$ time make fs/io_uring.o
real    0m3.218s
user    0m2.968s
sys     0m0.520s

Any idea what's going on here? It's almost twice as slow, which is
problematic...

-- 
Jens Axboe

