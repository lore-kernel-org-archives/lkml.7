Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E892C32751
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F32206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bujwWf5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfG3WeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:34:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44687 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfG3WeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:34:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id r15so28929830lfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 15:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W9OGjlOiuGBttY9lHWx9LPxLd92PhSuHcIdfhpDpvoE=;
        b=bujwWf5JLRuD+uv5Vrf6d7xtiko4y6kxVh+VdzTzfqqt+SpAWjyUJCBjcOb2/0YUhT
         mtAWzoMhWMY5VROhMuCppQSSfaS05+Tl5kLPPrrWb4TrtPSMiGS8mLATh0hjQFkTYBPL
         IjyMsioCx8axzjOVtU00KN38V+wSg+lHhEbWgHiqSn/OwYRZSY+PieKWShFOOmps33ie
         cWMNRxIzZ7FX+rqRhqtIP7gIy4/YLO8q1jIyJvVAWoD4aosRFdFHuia/fAIx4NEibCFU
         rF8A9HhEKJkPTx0fQb9KudSvs8iSSyxmfEkqBMtVzYg4HhSqUTNHwwHUmoetDzxi7o3R
         vEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W9OGjlOiuGBttY9lHWx9LPxLd92PhSuHcIdfhpDpvoE=;
        b=U3Tc3jLkXHlm1n8WxnrqX8LU3blAZ+wXQIkZPL/+F4HYoOpEoRfleIQ6irKf8doobb
         rXEV2acgC2EcbP5Vtj4QXVhT6jfERexR176z7KggC71wJcStnRqMXVb1QvV8a0kR3gMw
         +MwPti3+tz+lbYaUdgCwOVMDNbVf7PCSke4hFkTlpiMgPX/HMp+Vvg3euT6UbGT6uua7
         YLZt+wATRnUab9WkjOcpF6cT5tUH1BP2K18aSVQnMmQKF7nMyHIY9K4xO+Z2ZKjvy654
         +oLFpMRyy3ue83ebnsO0LDFSyaBd+Vl6wVC78ZLz4Wtw93nRbqRB4kK2/8tiq6EuuK2d
         ndIw==
X-Gm-Message-State: APjAAAW/Az6AgO3r99EBCqxXI96zVtMeQNvzP0N21cCodYVVbLN5Xbm6
        i1OxT5nZmFvGpJAhSA1Qng4=
X-Google-Smtp-Source: APXvYqylT1lor/fMtz/TfmJWdVozDsoadnNBs90hKZzNMn/xJ08p79neC6t1NdK546O9Gk3EmXgArA==
X-Received: by 2002:a19:f711:: with SMTP id z17mr55960460lfe.4.1564526051873;
        Tue, 30 Jul 2019 15:34:11 -0700 (PDT)
Received: from pc636 ([37.212.215.48])
        by smtp.gmail.com with ESMTPSA id v4sm13656948lji.103.2019.07.30.15.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jul 2019 15:34:10 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 31 Jul 2019 00:34:00 +0200
To:     sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Uladzislau Rezki <urezki@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mm/vmalloc.c: Fix percpu free VM area search
 criteria
Message-ID: <20190730223400.hzsyjrxng2s5gk4u@pc636>
References: <20190729232139.91131-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190730204643.tsxgc3n4adb63rlc@pc636>
 <d121eb22-01fd-c549-a6e8-9459c54d7ead@intel.com>
 <9fdd44c2-a10e-23f0-a71c-bf8f3e6fc384@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fdd44c2-a10e-23f0-a71c-bf8f3e6fc384@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Sathyanarayanan.

> 
> I agree with Dave. I don't think this issue is related to NUMA. The problem
> here is about the logic we use to find appropriate vm_area that satisfies
> the offset and size requirements of pcpu memory allocator.
> 
> In my test case, I can reproduce this issue if we make request with offset
> (ffff000000) and size (600000).
> 
Just to clarify, does it mean that on your setup you have only one area with the
600000 size and 0xffff000000 offset?

Thank you.

--
Vlad Rezki
