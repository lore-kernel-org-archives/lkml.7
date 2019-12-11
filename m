Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D29C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285D4206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="JtcCZOdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbfLKSSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:18:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39150 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbfLKSSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:18:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so2196383pfx.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tPPeeVDeYDqJ3/BkDOHHqJmeQk2RFS5XEnjcxyWStHk=;
        b=JtcCZOdbZR8PvoN5+zpqDevpmQX8mn/wjqVymTZNjvRG2R3gH+KMAmI1tsgUoaEn0d
         +Fmhha5vnwjhxmMZiyf1HWMUpB0kuoJFNNyL28RRSlL2Zxpm0Tl6AEtvGIHT3XSIGKPv
         8xbbRb7kPcjao4YeZtCkalMoIxz/SqZFBwNzXBn3AO4pfEywAdYsHgw9onPkuNAneu2w
         29BqS33e7MkozfghztMFnkQi7Am04h4ZcXqYMFLKYaXd7FJEYYfqS1ZtIjkU3IyxMEEh
         ZIx+Fo+7ODJnLjnSVVsD1VrKB99YPuflcS5JXuFnGakwnDxDmAMB0BojWo7FxAJlHid9
         jiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tPPeeVDeYDqJ3/BkDOHHqJmeQk2RFS5XEnjcxyWStHk=;
        b=FA2e3GFjiFTbR5vUsuszkMkRwYFQ9iBTcL+UMTaGvDCeGcHB1/vSGKIvKrlzmtBEXV
         y/S3QfFQy6L1F4K6skRC+c+YrDsVQHGOAdmlgxM2lxANh71tDJ4rVhEzDjmJezjOCEFa
         4+hQ8KMYeGKc9Ydz4YWbUrAyD6xZC37nj3Y6hCFsLN2wwMeg2UGp/totH76+lWJuZNS+
         dGvqO5lLCY/h4V7/W/BKJGczJ6Gv7moZnOr6t4IiI/EqZ2eQaK1Bn0yQbCwLndFfEFhc
         D8TFsVLpK6A923gcyaNeb/rHigyv00fBHSvJDB64sh8LLSl2sIIk5+1OsRRT2mKjzHYi
         88zg==
X-Gm-Message-State: APjAAAWo+0rzUqR4NE9Vf/JIVIQj7WH0f9buc28YU+BZ9CuuY7XOStv0
        l3jrgEoFyBVrJzE55tGeN/ILBQ==
X-Google-Smtp-Source: APXvYqybTyPeIsHQTSfJ39+zPwF7Awi2StSmIK5YsDEej2sjXZRE90XZupRWhjMpYCh+OuD4UJC6uw==
X-Received: by 2002:a63:2355:: with SMTP id u21mr5522479pgm.179.1576088311800;
        Wed, 11 Dec 2019 10:18:31 -0800 (PST)
Received: from debian ([122.164.82.31])
        by smtp.gmail.com with ESMTPSA id t8sm4136330pfq.92.2019.12.11.10.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 10:18:30 -0800 (PST)
Date:   Wed, 11 Dec 2019 23:48:24 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Will Deacon <will@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PROBLEM]:  WARNING: lock held when returning to user space!
 (5.4.1 #16 Tainted: G )
Message-ID: <20191211181824.GA13799@debian>
References: <20191207173420.GA5280@debian>
 <20191209103432.GC3306@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209103432.GC3306@willie-the-truck>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 10:34:32AM +0000, Will Deacon wrote: 
> Can you reproduce this failure on v5.5-rc1?

i compiled and tested v5.5-rc1 . Yes the failure was there

--
software engineer
rajagiri school of engineering and technology
