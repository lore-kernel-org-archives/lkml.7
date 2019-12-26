Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73438C2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 15:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3727B206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 15:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="d53lPBKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfLZPuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 10:50:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39806 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfLZPuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 10:50:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so23925731wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 07:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B+YxLCGodTg0pZLH/iyQhlCV+Idq1A1pe4ky0dTnDHU=;
        b=d53lPBKHHBng1voKPzjngOLFmAJJQh3c2d1sgQtlfgDFOYAOdd8y8l59DnO4hoKod/
         2rAI2hG0OnzCjgG7M6EA1jBJRd5B/rIKcNC5ghE7r/lA7qiQYtaMMDLSR2lNEjPql8W0
         umcWcHJtYpjVC8c59GVbVwkVb/TwdZeLEjRzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B+YxLCGodTg0pZLH/iyQhlCV+Idq1A1pe4ky0dTnDHU=;
        b=YPeIV4MjSrNJeW54RIK11LuD2nQB8hZetBB8h50sgZkO7MO4xKRBS2Hit83a9PabZK
         ZxbPs7EK4TZWPhS0ohJAGV97VgR2vCL4ZXVgSilzBtdpCl8KfWpTbFe2GtMl2BPxS99A
         NdT7kmzdhPZT+1Dnzj6G/LSzNRcdlPxyK605kke/N/z8ayD9vWoJ+G5sc+hYZ8ROo4uq
         QWzCRK+nZNjE1DGeEijrYmB3IMU7TzLyLUQH4U6H0mR8YruCwxdGzEUPE7BVx8eid4Xx
         YypYVbIxdrHzcwKJNBLJE2/uJ3pq3VnNL7dQGI+euzTa8KsO8rOJW7PViK7UgvxxZJTE
         vz3A==
X-Gm-Message-State: APjAAAVpCK+rtcy6GHU85kPoLWdipdCGsRJaawmZ2sBh696HVjnHdwok
        R4fvoRdQ18OjaEQt9D79UNNDtQ==
X-Google-Smtp-Source: APXvYqzchPQmPXlFgJXGNqs147QRCD5hSoOSZszH8wzmHTWm2VQDnSvjW2TEqMNsj0Hj52zjNmBBMg==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr45575737wrn.384.1577375408814;
        Thu, 26 Dec 2019 07:50:08 -0800 (PST)
Received: from localhost ([85.255.234.78])
        by smtp.gmail.com with ESMTPSA id u8sm8525746wmm.15.2019.12.26.07.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 07:50:08 -0800 (PST)
Date:   Thu, 26 Dec 2019 15:50:07 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, "zhengbin (A)" <zhengbin13@huawei.com>
Subject: Re: [PATCH] fs: inode: Recycle inodenum from volatile inode slabs
Message-ID: <20191226155007.GA416212@chrisdown.name>
References: <20191226154808.GA418948@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191226154808.GA418948@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Down writes:
>diff --git a/fs/inode.c b/fs/inode.c
>index aff2b5831168..0df68367587b 100644
>--- a/fs/inode.c
>+++ b/fs/inode.c
>@@ -7,6 +7,7 @@
> #include <linux/fs.h>
> #include <linux/mm.h>
> #include <linux/backing-dev.h>
>+#include <linux/random.h>
> #include <linux/hash.h>
> #include <linux/swap.h>
> #include <linux/security.h>

Er, whoops. This was there for testing and somehow I missed it, I'll send v2 
without now.
