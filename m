Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C31C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0930A21871
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="02QsbCBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfF0Cdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:33:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45867 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbfF0Cdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:33:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so617691lje.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 19:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yOkS90FW9m9qlm3iIe4o+JWVUiJoQWOdV+pN3v1fwq0=;
        b=02QsbCBlA8GNeuMaJBwsbEV2R6pe97/6uMS0F3Yprjxq6bC0/OQ/JNV6Ro+POVzUQm
         QtDJvRPFy/uJtB2214wa4MRddsoIU6izreBbqNvF9gXi6vDZfGVI00oPX0iDubtdZFsK
         Z1cNUx5VbKMD6NPgJmOBzEB6u678aeNpXbIpu2IXRlUOyBkABEGIH3J5h+w3WyoA4rPy
         n5LhBkNIPHE8ls3WdyofuWR8PJyCM1lR7H2nQgYd23fj0s7omlh5FVCwp0sSbJB0VwhS
         2ItnQbm6lj5cu9esJhTcSMAtzengSHyTRq/h9676pmJfBUS/CuPwKCPnkWQQu54oEBqt
         zkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yOkS90FW9m9qlm3iIe4o+JWVUiJoQWOdV+pN3v1fwq0=;
        b=JJYLLpBd9TmoLW49s1lwt6IyiGocOXIw0rhdLnxa1hGGYwTy5NMdLvYgqiulC79ViO
         jF9z8t9EA/Np2niJ3GzwBsmy9VaEItUuGGW/yxk6pXSeUP1aVYXhov8aywKLyaKg+7O3
         yYmsT3A+/pL18d/DgC+DedYTu2vlhblhHU1XcLcU8BgRdu2JGbtMEMtSL8reuySsLaDv
         gxkmUS+rml1dsjE5dA8sOtPLn5QB8dOPUjA8+9pH9l1O8uYTHu+9h09DqCJJ2f97pZb3
         KRtun4etwwvh+TQo2VkwLzt6UDt5dMJufHggc80w09XQY8NvmsCNMursGZ8H/1GMT5u9
         rhWA==
X-Gm-Message-State: APjAAAXSAn6m5r+HKbRaQStLfStiU8CJkip9mPjQz7LIA/IRsdgyt9qe
        TUmnvaASU4ms6dnLORqEks5Jwg==
X-Google-Smtp-Source: APXvYqwZ4VGmnVUqovZXVKOQ+atp4tjYSsaXrcOjTRbWuBvLrRSQBn+AF+1AqmO9JXLGINO0/BwJWw==
X-Received: by 2002:a2e:89d0:: with SMTP id c16mr825416ljk.219.1561602832318;
        Wed, 26 Jun 2019 19:33:52 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id y5sm108248ljj.5.2019.06.26.19.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 19:33:51 -0700 (PDT)
Date:   Wed, 26 Jun 2019 19:22:36 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        masahiroy@kernel.org
Subject: Re: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates for v5.3
Message-ID: <20190627022236.qi2fp6thvkoewwir@localhost>
References: <CAK7LNAQKmSUkXtJOOcr1q8b_yTU_NRcgCvDAo8aZ+CkOXGTWNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQKmSUkXtJOOcr1q8b_yTU_NRcgCvDAo8aZ+CkOXGTWNA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 12:21:42AM +0900, Masahiro Yamada wrote:
> Hi Arnd, Olof,
> 
> Please pull UniPhier DT updates (64bit) for the v5.3 MW.
> 
> Thanks.
> 
> 
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> 
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-dt64-v5.3
> 
> for you to fetch changes up to aa38571246c6ac279ebebd141157297bcb959d76:
> 
>   arm64: dts: uniphier: add reserved-memory for secure memory
> (2019-06-26 00:08:47 +0900)
> 
> ----------------------------------------------------------------
> UniPhier ARM64 SoC DT updates for v5.3
> 
> - Migrate to the new binding for the Denali NAND controller
> 
> - Use reserved-memory node instead of /memreserve/ for the
>   secure memory area

Merged, thanks!


-Olof
