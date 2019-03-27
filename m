Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728FFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362B82075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="Rtju3mcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfC0NJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:09:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40448 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbfC0NJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:09:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so13508764wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DRjjDh/ejcnrWrPjTEeAJpgIEUYEzP36fYpol4RiuY8=;
        b=Rtju3mcCwrQ9wHWx8LuUobMyJPjnTZrjHSbpv6HkTevskFHlu90FzOY8/aIIzMPMt+
         8xjceW0wAxdsqPTsuJuUqR7Xy8O/2SrPSJFIEGPfJ0wUU2fiOx8dLaVAR3S2BjNkEu26
         /toFoyWTBGh1AuMjVM1hvaQjoSkQ0M4YrfrH2JA1ZSEGAzAOcCH69KZqO952Tf4bIdrb
         m8+eRGt1TAefOvdAgz7HJLpQrSGIHhV3FLh8QsH5KCViu7zMVNMbyXPXfBfyb6ukyVRR
         Hjo7K3owlJWNdxB3NagI6SX2C/kQghodE+vodgGY2NVsYzBYRq8UA1GHsTIQXMgdvkX/
         9BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DRjjDh/ejcnrWrPjTEeAJpgIEUYEzP36fYpol4RiuY8=;
        b=GfbbPb3Yb3Y3QO5O4GcJStOkGOGX2ndybGXHCOw7kUFK5Ma5vPpAbqVqh6Hou7twN6
         gJzRULT35LCcxJq8mrp6luRCE+PAf8o867HsrwciCEjm/M3dnc/MeLr4C+Q1m4GtINeL
         q8OA2oJmEhGpnoULJ8gQY7aZD2HGe6/sqmxQfDnioA7jMOmcswIXvId5fxHK7yJNBBfn
         V7w3ndukMevgQxHoGeRNBlJn1MfwOvTYwlWKykGKKv+U7Fc2xPWfJ6EDnn6ccIyg1izC
         CFnbJlnEhHqFuCXJJ9K+DrtP/jNf8OLRZ6PqKVNQVUNSK7fzvEptqDwSQ1aepHXZZLlI
         sz4Q==
X-Gm-Message-State: APjAAAXfVUVozNeUCdcoBPi6ExgCZwHFLVb2Dp32sqftVbo122nVFazW
        3hRU/+YOvZ+Niz1yiJdlG5ab6g==
X-Google-Smtp-Source: APXvYqzi0PtpSe5jWqtQlXJJg4JKjPUrPttE2oyp+ojyjiJK5ZXjE2M/BOhHP4nu2qHTMmLG2+8HEw==
X-Received: by 2002:a1c:55c3:: with SMTP id j186mr19562030wmb.5.1553692169746;
        Wed, 27 Mar 2019 06:09:29 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id s10sm3298433wmh.0.2019.03.27.06.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 06:09:29 -0700 (PDT)
Date:   Wed, 27 Mar 2019 14:09:28 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/22] ethtool netlink interface, part 1
Message-ID: <20190327130928.GC14297@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553532199.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could you please perhaps split the patchset so it contains max ~15 patches?
