Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278D9C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBB0217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Pyk1xJYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390066AbfDRSod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:44:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36537 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389836AbfDRSod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:44:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so3283074qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 11:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=bB0iaIZk82+RTVqAjY3+9LVUW5C7BuZN2sORFJHBfmk=;
        b=Pyk1xJYXOnbQyWMfox+I9zm7S+yFE/nCPtpFspUrktj48yGIg6FVjuq+bxJUPIpkmU
         wSXnuq9kDJ4iRtIzCRM9+T/21+GYjI0H9F9lFeUO40uge0NKR9FHsvWbtIP4MHIRJEdb
         Zx4nuGjZzs/ChtH9j0Rn2iiH3OTjgHtwWd+4svgdNZ4ozdbRv/LxJI2qiHEOBT8yLxV6
         pQS7A8wxgPeFzS/XlM4/RRqroBqqk/lcwfPOWkUaMWcGRUu9VJZVMCk7ovHtlW4j0kn+
         kliUTLKUbfP8NSNbosTKgBBFJ2ATmGXG1fTE5RqNEslvi+u5gg72ibkxVkXpKou6D4/y
         RQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=bB0iaIZk82+RTVqAjY3+9LVUW5C7BuZN2sORFJHBfmk=;
        b=quDzQTi8p1s3iqTr6zLt8p8o26ZYkT+GH6WqLSghc6UUmm4kkHh9lRpeQ9b1ZPaItL
         dWoJZLDrPeesJ4ZidomWeHR4le+orrqkF1pCfNuKcwOukkCspSiUHTBTqd3C/fYzEdjn
         GLDbchD38vq9eDLazl/wVqpoUqDNXAKT1B4c2tWKT4GGZvq19j6X7CtIY/EzE9VKhojU
         JYlZ90r4RSNltESlDNAS4UEt7LDMBLHkm32wffKDiOPBW/hZUoCGfeE9x0WWjwKb82km
         m93ufgz6jGlWSMRTkYewyc/OJWhkdhHhbg52VaLpgWSWs3fS2a1bSgHW5nB6s+LVqhLX
         3NBg==
X-Gm-Message-State: APjAAAUGsY8I/GKOmhGabMAicrTf8UpoDpJleXamIoWP3d+1EfBSfJKp
        PHzUAMiq/ePocCrjJissaJHkpw==
X-Google-Smtp-Source: APXvYqwchkiBC4ywpoewBR25dhNx4oTKhDAz5+jVyA6922CM0vI/ILRT7DpSTrCzxkAhBHsYNZHVtA==
X-Received: by 2002:a0c:b012:: with SMTP id k18mr5675619qvc.243.1555613072357;
        Thu, 18 Apr 2019 11:44:32 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id x15sm1183441qkh.13.2019.04.18.11.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 11:44:32 -0700 (PDT)
Date:   Thu, 18 Apr 2019 11:44:26 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc:     grygorii.strashko@ti.com, linux-omap@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        ilias.apalodimas@linaro.org, hawk@kernel.org,
        xdp-newbies@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        aniel@iogearbox.net, John Fastabend <john.fastabend@gmail.com>
Subject: Re: [RFC PATCH 3/3] net: ethernet: ti: cpsw: add XDP support
Message-ID: <20190418114426.0a0b26f9@cakuba.netronome.com>
In-Reply-To: <20190418183043.GD27879@khorivan>
References: <20190417174942.11811-1-ivan.khoronzhuk@linaro.org>
        <20190417174942.11811-4-ivan.khoronzhuk@linaro.org>
        <CAJpBn1y0odvL97-kP5yzKC+tN=fx178nxigfBfDwXhRhPRvDuQ@mail.gmail.com>
        <20190418094008.GB27879@khorivan>
        <20190418104111.559a0e74@cakuba.netronome.com>
        <20190418183043.GD27879@khorivan>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019 21:30:44 +0300, Ivan Khoronzhuk wrote:
> >> Here another thing bothering me, I send it to queue 0 always, instead of
> >> taking cpu num. Not sure about this, but I expect to have some tx queue
> >> not bind to cpu and didn't find a way it can be changed dynamically in
> >> redirect.  
> >
> >Not sure I understand :)  
> 
> I mean, is there a capability to choose tx queue while XDP_REDIRECT or XDP_TX.
> 
> From what I've seen it's taken by:
> qidx = smp_processor_id();
> 
> What if I need to send classified traffic to hw queue 4 for instance...

I see, no we don't have any API for that, yet.  I think all NICs which
implement XDP REDIRECT today will allocate a single normal prio queue
per CPU..
