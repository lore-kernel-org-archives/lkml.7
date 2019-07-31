Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF48DC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F912089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnzJ0F54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfGaMEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:04:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33643 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfGaMEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:04:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so65341287ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s4RPoNoetmDdSgwfGZ08wLtjU3Rl2zWouKkOWjbjMWg=;
        b=EnzJ0F54oAi0OX+GtgM+IK9898w+b4lTzvMaBjNRZOpQlW9SkJivV9CBK1He263F6C
         jVoK4t4SXObHIgZip1vxRSrvXk8iYH+MTUjZtp0yv8FnExJpGXN2FqaLWp+tay1BMfcR
         8MK7A2NfHrWBGRef9o1PnSD60zsjds10zk9lHfq6JROdLYdV70ulaBShPF7yGSrFln8S
         psto8j4HAmlFX6/aZe0qyt/GiphT0hnvT6dwGqRCKu4vh5GYuYrifqydVApYDnWBhDzu
         3Pfcks4w7GZ8yIXqlHZY+wTUJMTRqp2P6ysueSLTjlTFu8UEzESnRaE/vvkJMtDQYCyu
         fySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s4RPoNoetmDdSgwfGZ08wLtjU3Rl2zWouKkOWjbjMWg=;
        b=pRHOq8Gg6CR1aus96uCsftHYVDk3HLu6CfezOdim9qfowpUzv+uUEoU8uWKNy7urTV
         rWUxZz6NgezFLhMXRCxtm/QbEPizNaJl7DKngoUfZysuKB/6PYug2990bHZMpNNDlIkp
         CItuM0j3pj7XVhjDBzRANVdJwkmL5aa5iYBLWDyqKYvukiTm7/i+GpPepQUxG8rSGW55
         DzK875exMdZpRxUSwSQ7vdXRDJcRE3ksJUSME2faKQFVSyoOeG4UJEmfU0NCHO7Cy8A+
         M4DQnJr+DwgCHBaG9zqQzShjLTFYEs9WHi5aRmzWbdANZ5yk4lI4gIg/N4ltYzSMxYDc
         8LIA==
X-Gm-Message-State: APjAAAUYwhfuzxgCvKyxNcUxqxNXaWG0s7DYz/oHLRMwZOodsB6GTTLn
        eONi9sl9bPxzlavMNRyZu+8=
X-Google-Smtp-Source: APXvYqzgMT2CPwJhuWzBpzLlg593pYgFccVPfTw85ro1+tK0oXAgWGp8XZ9qfVgWf8Lfeky8MTLVUA==
X-Received: by 2002:a2e:9c19:: with SMTP id s25mr41423681lji.188.1564574661794;
        Wed, 31 Jul 2019 05:04:21 -0700 (PDT)
Received: from pc636 ([37.212.215.48])
        by smtp.gmail.com with ESMTPSA id q2sm11607080lfj.25.2019.07.31.05.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 05:04:19 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 31 Jul 2019 14:04:11 +0200
To:     sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mm/vmalloc.c: Fix percpu free VM area search
 criteria
Message-ID: <20190731120411.42ij4che425a5x3w@pc636>
References: <20190729232139.91131-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190730204643.tsxgc3n4adb63rlc@pc636>
 <d121eb22-01fd-c549-a6e8-9459c54d7ead@intel.com>
 <9fdd44c2-a10e-23f0-a71c-bf8f3e6fc384@linux.intel.com>
 <20190730223400.hzsyjrxng2s5gk4u@pc636>
 <63e48375-afa4-4ab6-240d-1633d7cc9ea4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e48375-afa4-4ab6-240d-1633d7cc9ea4@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Sathyanarayanan.

> > Just to clarify, does it mean that on your setup you have only one area with the
> > 600000 size and 0xffff000000 offset?
> No, its 2 areas. with offset (0, ffff000000) and size (a00000, 600000).
> > 
Thank you for clarification, that makes sense to me. I also can reproduce
that issue, so i agree with your patch. Basically we can skip free VA
block(that can fit) examining previous one(my fault), instead of moving
base downwards and recheck an area that did not fit.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Appreciate you for fixing it!

--
Vlad Rezki
