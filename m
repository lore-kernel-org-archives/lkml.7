Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3221C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC5322362
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="us8sMchD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfKSPmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 10:42:22 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34362 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfKSPmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:42:22 -0500
Received: by mail-qk1-f194.google.com with SMTP id 205so18218228qkk.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 07:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nWs/1bjDvNuzUJtmMQammwiguABeAIM4rx8Ev82Odj4=;
        b=us8sMchDRqbzZLY+8PM7/pe8WsLDZaohdyGl7R3EeSoWSvgvizJcLMF0BSaCEqsdy4
         NSYDM17Ete2jESTbIDna9vtA0dUXsmg6bBXQOCH48RDKNzLBxQ6mlp7dlkil/PAQ5hl4
         kxrZ3bqxv5B9F8bKvIHUq5QUdUopVtt0xgGF3OfR4oa410peA1MSURbcEDbJvRagtXXW
         +SqQC2r8fKOXJEA7CxMEGgKlIO7ejUpU40J+VxnUNJ6vEHK8//vMrnAp2qoHjQxavaiI
         vz7OWx7ODCOY89S+kEdO/+LJrWWnNLTcSyv0Maq4YAOgtfhCfquKCCUXG3oySb+mCvBb
         38tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nWs/1bjDvNuzUJtmMQammwiguABeAIM4rx8Ev82Odj4=;
        b=MkmElEoeV/r2P6toq5wCa+7090xixOyfg63d6ybpuYuDjrrzjwS5RdFmtCUseXH1wC
         DxRHiRIDbNYbjZvP08yGGtqX81aB/2eyLIlm0LOwtpnvwNZM0oA/hsDmJeDzRTx9VRuJ
         D1/x5alC6Xm43xYB/vY/s+0ut6uzdsAkA0ee/rl7t3pia7Wpvo+396HGeYfPrzR1tlOm
         MGzTfoFItBTL1SqZKCdlLQRpFUp40rEVkI2XhiY3bRQJvu+jOqlTRSAOg5R1v6fO2B7J
         Auy4Of2FL6jtMmdFQziCUzfsdNDb9l+PzKbOC7tKw0dsFXGALwmXsiVgArSKcMBNaGB6
         SV/g==
X-Gm-Message-State: APjAAAXtvsppph2f/73ttl4FrejJisEy3wy0Ava37cOgsPFeXF9jygu/
        orZKeI52HbZUjpBLt3A1FlLwRA==
X-Google-Smtp-Source: APXvYqw/NhSrzyPWPQbLnED7yGzQyzSTdlwC0odTzaM2yCGhnhMYRRPM2hqTvbDK1lg4A0bgszuNRw==
X-Received: by 2002:a05:620a:13c4:: with SMTP id g4mr30230662qkl.391.1574178139850;
        Tue, 19 Nov 2019 07:42:19 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::c7ac])
        by smtp.gmail.com with ESMTPSA id i17sm7188612qtm.53.2019.11.19.07.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 07:42:19 -0800 (PST)
Date:   Tue, 19 Nov 2019 10:42:17 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com
Subject: Re: [PATCH v4 2/9] mm/huge_memory: fix uninitialized compiler warning
Message-ID: <20191119154217.GC382712@cmpxchg.org>
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
 <1574166203-151975-3-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1574166203-151975-3-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 08:23:16PM +0800, Alex Shi wrote:
> ../mm/huge_memory.c: In function ‘split_huge_page_to_list’:
> ../mm/huge_memory.c:2766:9: warning: ‘flags’ may be used uninitialized
> in this function [-Wmaybe-uninitialized]
>   lruvec = lock_page_lruvec_irqsave(head, pgdata, flags);
>   ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Like with the previous patch, there is no lock_page_lruvec_irqsave()
at this point in the series.
