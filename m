Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A89CC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F23F21670
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Y/D9VWUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfFYMFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:05:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34379 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfFYMFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:05:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so16025761ljg.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 05:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qxqCorAGy2MAZQkuKJiyGeZj1RhrCJf1RH+LL3myVCQ=;
        b=Y/D9VWUOPy2ux7lYcCLTrBdCtUsgdrOSNJVrmxTtEVY+zFPNI5hIxYiTXc32XzvPXk
         UYy/LUJQwOuo4BxifzkYthYi4t72FWLzfRADlj5QKdV0yxNoZe+RashX7edY0qtPU/KB
         KgF0lckeVvTDgmbBduixuFX/44dhFRslylx66OA1udRchf87GII2vku0DmKyb4R6xWZa
         thBDs3BxA+ixP6NpIpAFWymW1vFvyZ1BzXuaj9/Wx09jWNOTYXGLquZJI9GcSjH0kNL/
         sasdo4BVUXdpVpZ5qPWIz+YF0A0/rtTSW9Ac7PYCQj8nsGQPaEwyWOJ2rIKMs77s/sVW
         hngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qxqCorAGy2MAZQkuKJiyGeZj1RhrCJf1RH+LL3myVCQ=;
        b=GGccKK8QwLZmU4jU1uKlymRCG8Ex0cvIrayvhiAP7iePcG539ewyHBoTeGiNjJaTsT
         ZBD21uce9hJTzDunjAnBeCm+xIPcq9AEacJZS1m5xB+1weJg/GzfLrE9vvU9pOJXuwG0
         jc6b0j32Ns9zzynzfawFRt7B3K16CAS1Mvpo6KSxMWuoBnTgCJAObLb+JP9F5E8r0o6Z
         9FmvL5Q2qbK+LJY3h8TPS7lYrjY/XlCl3QUZiRtQHL+OvcgyjFwZoaUcVlt3Yxio7B0e
         wuyYGk9fkk+kGdKFvjW04lGxGZN6KDpEcz9bGDFuSjtawaIxq/WilONLJWQDJmHarz0S
         HrUQ==
X-Gm-Message-State: APjAAAUH/x0F/9+Go6t26lYRJSJrM51ZsK0t/m3IC/qErgCeqotOh/6+
        1F109TLCpddWYNVYtRZ26SRK7g==
X-Google-Smtp-Source: APXvYqx/DfSTspXsgLNKDQN1Bg+yw1ClAxWIVQMzZAtoBqE8/QLkbwzE6qtwYd4+GmtO+VOpu3BhOA==
X-Received: by 2002:a2e:9ac6:: with SMTP id p6mr3074324ljj.100.1561464310105;
        Tue, 25 Jun 2019 05:05:10 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id j11sm1935335lfm.29.2019.06.25.05.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Jun 2019 05:05:08 -0700 (PDT)
Date:   Tue, 25 Jun 2019 04:49:56 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: at91: DT for 5.3
Message-ID: <20190625114956.y6nrvfiuwm5duitz@localhost>
References: <20190621212246.GA30172@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621212246.GA30172@piout.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 11:22:46PM +0200, Alexandre Belloni wrote:
> Arnd, Olof,
> 
> Still very few updates. It is mostly about removing DTC warnings by
> switching the sckc to the proper bindings and converting the atmel
> bindings to json-schema.
> 
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> 
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-5.3-dt
> 
> for you to fetch changes up to 271839b0a819cbb76ef3ce5c7237d6cb624b3eba:
> 
>   dt-bindings: arm: Convert Atmel board/soc bindings to json-schema (2019-06-20 11:13:52 +0200)

Merged, thanks!


-Olof
