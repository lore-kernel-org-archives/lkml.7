Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E19AC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB15214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bobcopeland-com.20150623.gappssmtp.com header.i=@bobcopeland-com.20150623.gappssmtp.com header.b="Kfnla0tv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbfHTOS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:18:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46439 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbfHTOSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:18:25 -0400
Received: by mail-io1-f65.google.com with SMTP id x4so12455058iog.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 07:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=838NPqta13bqgyCrYK41UyrEU6mGcDEerMp5IHrJ4wM=;
        b=Kfnla0tviD817tYZdPwb2uA2HDNSUtBR12ZbWHcHId5JmtFmbvh8/eGNzF8lr/hr9z
         v6m3JN+x+i1whykrYHmo3SDPcCeo+TPtpbrUTjsz7UK9NBYN9D/LvEAEGNkZ9rNKVDqs
         v3bNnyXRY8FlQJtnaBRrJ0CsspH9HuFr3leEIwWOihS+KZU/v+p885SCP2Zb/tiSfAL/
         UKL4ubb9UNcx8g2dXij6VbAX/IQDJyjiIFvUJWlMiNITg9yPWFz4kwaVlcaW/FHxFqj2
         mz74NRc9FCLqh/UlYlCOwg8ESbDRfUxKFJTk74LRwbe2wVTn8i9eiF0Kit7hST/BEfq6
         HuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=838NPqta13bqgyCrYK41UyrEU6mGcDEerMp5IHrJ4wM=;
        b=Or9thGdRWiSYE86bQArKwynXVZfy8tOou7S+F196l9SuEVbfZyv0FsqluwmizOj0TB
         vH96I8LiNLZbPi2yGoGyiIEiCMkTc6/dX/IyxJ9YqQEM3mIPKWiSmFmTOiw4X6RN05gR
         fhlLzmYfrdONyyhF3t2e/CbsBZnCuxw90CKLoTLN6DH0YFiDyIfwCTEdmzCvmk3729Eq
         yqAygjd5i3Z+ufo6VbTbTMSnu3GeJi9uSGwfWSD+otUdrdpd5erWLUo/++F+7+d7f5DG
         A1HFvsWM0yyGHZW5ewe0A9BEenEFogVef7bZmbHTaMB8aPMmK4FLP72OdHm45WrOYVi3
         NE7w==
X-Gm-Message-State: APjAAAVnWPyUSpTCZJrohgPiabQ79oU3uqDSzpbYpAwoI1OLCpLg8wQe
        +z8qW3XTneO7BsucaOfDsfJiMA==
X-Google-Smtp-Source: APXvYqxMn8dXUKQs4Sy3kFJi0bntqJbH+OO4y772O0IkJ6aywEqL+s/qAIjPcNlCJoZsqvDtbu/dsQ==
X-Received: by 2002:a02:8409:: with SMTP id k9mr4036631jah.122.1566310704798;
        Tue, 20 Aug 2019 07:18:24 -0700 (PDT)
Received: from hash (CPE30b5c2fb365b-CMa456cc3dfbbf.cpe.net.cable.rogers.com. [99.232.51.173])
        by smtp.gmail.com with ESMTPSA id m10sm14241474ioj.75.2019.08.20.07.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 07:18:24 -0700 (PDT)
Received: from bob by hash with local (Exim 4.92)
        (envelope-from <me@bobcopeland.com>)
        id 1i04vl-0001YN-Fd; Tue, 20 Aug 2019 10:16:13 -0400
Date:   Tue, 20 Aug 2019 10:16:13 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     "open list:OMFS FILESYSTEM" <linux-karma-devel@lists.sourceforge.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] omfs: Fix a memory leak bug
Message-ID: <20190820141613.GA5634@localhost>
References: <1566282180-10485-1-git-send-email-wenwen@cs.uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566282180-10485-1-git-send-email-wenwen@cs.uga.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 01:22:59AM -0500, Wenwen Wang wrote:
> In omfs_get_imap(), 'sbi->s_imap' is allocated through kcalloc(). However,
> it is not deallocated in the following execution if 'block' is not less
> than 'sbi->s_num_blocks', leading to a memory leak bug. To fix this issue,
> go to the 'nomem_free' label to free 'sbi->s_imap'.

Nice catch, thanks.

Acked-by: Bob Copeland <me@bobcopeland.com>

-- 
Bob Copeland %% https://bobcopeland.com/
