Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2059AC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F2E2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l24ivE8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfHPR3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:29:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33592 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfHPR3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:29:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so3280101pgn.0;
        Fri, 16 Aug 2019 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BLj0UmKgEjnMR5Que7EoNtpK1q1GQyD9/2Whzb2zoXg=;
        b=l24ivE8bMrI39k5UDv9sE0SMI7kWqFZThOunQbFZsphlfOwPBr9/NoKjIhVqiVvTMv
         QM4ArIyhtRMBM2AFfxudalHtX9xBhmUJDsyCiRT4fRjya6MFWQb0ti3rXsONQYxY7V6L
         mJz7C+aMoG0hJJt+hH33XOXoUxIxhFRre1g/t0jtnHv4FEPdUxYNLxdjupePNt6MreAR
         Y97Jjwa2Hba4oVnYSBBbXpTer8SgH7TD3Z/zGV1AnrVSILPttc3In/ekKO8Bp2PRzvAd
         qGODCpyDIlSET72qVAooq5xOB+8Tw1QiydHkk8Y/BcIAAf9gy17323+4wwY+qdVZNqzA
         7naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BLj0UmKgEjnMR5Que7EoNtpK1q1GQyD9/2Whzb2zoXg=;
        b=bBWZxYjYHVUD/STxBqSGjsBXZ3eiJtP/YV9qCftWyk/+LEvTTO9pIyM941juRiNiNQ
         BriuekWortybUQ8MliDh2OGWgu5F+q6b5cqmWSaagCqwi/U9yxNzpUyANiDRaDP3pQsM
         nT24hLzKXFIIWOjqpGDTOaNuEcRZhi/VM5sNd3jzMRh8mHmMxOlIvP7rCe3QbgySeid8
         ShlM/+Yw/n/QF/Ct4PEsGbUIPa8WuDem7syCFBxjP825l881eatbzVaoWvAwcqRYuYE+
         p45kcv+OH7oI6e+8pSr0H4+KSjMzxPkAMXGU2PboG4W37DmRVTCY59X02nuWLESmRDgd
         rmAg==
X-Gm-Message-State: APjAAAVTFcnbBmUagbf1GkEfsqLyI1NLhML9oYhtB0dKrXlqbN0fsO2y
        D92YmL6N768w3UD4ydEJFtw=
X-Google-Smtp-Source: APXvYqxmvnjQGUnc6RLxKLe/Q61GrWCcv3Y2CqcWeSj8G3BIryez2BM7IHaf/8Te2x0O03l1gMPxYA==
X-Received: by 2002:a62:be02:: with SMTP id l2mr12141910pff.63.1565976563572;
        Fri, 16 Aug 2019 10:29:23 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id z6sm7404017pgk.18.2019.08.16.10.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 10:29:22 -0700 (PDT)
Date:   Fri, 16 Aug 2019 10:29:20 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiada Wang <jiada_wang@mentor.com>
Cc:     nick@shmanahar.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, george_davis@mentor.com
Subject: Re: [PATCH v1 31/63] Input: atmel_mxt_ts - add memory access
 interface via sysfs
Message-ID: <20190816172920.GK121898@dtor-ws>
References: <20190816083451.18947-1-jiada_wang@mentor.com>
 <20190816083451.18947-2-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816083451.18947-2-jiada_wang@mentor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 05:34:19PM +0900, Jiada Wang wrote:
> From: Nick Dyer <nick.dyer@itdev.co.uk>
> 
> Atmel maXTouch chips can be addressed via an "Object Based Protocol" which
> defines how i2c registers are mapped to different functions within the
> chips. This interface exposes the register map and allows user-space
> utilities to inspect and alter object configuration, and to view diagnostic
> data, while the device is running.

I'd say if we want this we should look into write support in regmap and
switching the driver over.

Thanks.

-- 
Dmitry
