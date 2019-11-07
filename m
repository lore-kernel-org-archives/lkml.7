Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E828C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D1221D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtYwGqUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfKGW7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 17:59:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42192 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKGW7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:59:25 -0500
Received: by mail-pg1-f194.google.com with SMTP id q17so2883188pgt.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 14:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=37vI10OHhl6jTWakhwjHOMGsND4W8xXva1kflTIfn38=;
        b=dtYwGqUdV/ud8EBTtvRx9lACRPP1qeX43CnljOG38jYD7jROnBiWhNBRYUGY92WPP1
         6EQrU41QGMXDaeuIBkUKA2wXlNpqPSa4MVtRFIH8KmBfmmNFfm5/zLdlpkofeKwu7DJU
         /vp26rzZuLL4wIrr/G3XCGkCjQxhXMgUpKJ3Kj3ScoOSdPX2IDNQjhW+B24FrZMynEL+
         44wghqpRVhS8otrnSAO2YqA3xJfHwScHYZTmcWs7WbyIcjjVgS8H/YlG3GS97/Tm0rf2
         TWxDpTY9daAg9sMSa72Uyd9jkbEyY/QsFLITh9X6AE+rF5rv20MpOrSjRXRxDtzxhpRR
         hLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=37vI10OHhl6jTWakhwjHOMGsND4W8xXva1kflTIfn38=;
        b=iWd8zj3ZCao5f4OrMtdEagBg8viBAvUE3fH06jJrP0AfiKJVCqSHjpEndnSqjqr1vh
         4Uwie+YuMJj0Q4rtY9zRQJ44gkRBIP0Xmbc0mqGq6L02EDkZJPUX2UhdNI7gbr/Pw7nQ
         hCQnDbGR6RYa+8a6KeO9/QxzatEz0Ayh2v1hc+bRqKLtVyfhVLVEvfb4XrkwtYbVDJNM
         yJEu/OtJjY6MGgQMZ16+GvrvHmFCbl+1UhKghaD0YwRLQ8XFVG3vPl5iwcg3AM5L8iLA
         Nh1TynTZ190uUg95A5w2669jNyIIZUnL4jftPcVxfpWwllnPXRxaTRYk2cgI7UTSit/W
         3bSw==
X-Gm-Message-State: APjAAAUI6GzDkbPhQ5VYoYnEOKwa330UWs1LTqPnJ7ovGGcxe8NIotVU
        7GvpmZuHSIp6WDBHYZrDM3M3Hw==
X-Google-Smtp-Source: APXvYqwdBhLNB7nAqZ2b6oQ9nxUvxGty40ZPd02qcFSLPbedn8Ruoor2JktJvOHgCF13FuLa44wB8A==
X-Received: by 2002:a63:5749:: with SMTP id h9mr7992087pgm.12.1573167563843;
        Thu, 07 Nov 2019 14:59:23 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id p7sm3732176pjp.4.2019.11.07.14.59.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Nov 2019 14:59:23 -0800 (PST)
Date:   Thu, 7 Nov 2019 14:59:07 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: shmem: use proper gfp flags for shmem_writepage()
In-Reply-To: <a90d6ec8-1f02-36f3-6531-a44be7d1aed9@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.1911071457310.1083@eggly.anvils>
References: <1572991351-86061-1-git-send-email-yang.shi@linux.alibaba.com> <20191106151820.GB8138@dhcp22.suse.cz> <733100ea-97aa-db27-4b43-cf42317afaf8@linux.alibaba.com> <alpine.LSU.2.11.1911061039540.1357@eggly.anvils>
 <a90d6ec8-1f02-36f3-6531-a44be7d1aed9@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019, Yang Shi wrote:
> On 11/6/19 10:59 AM, Hugh Dickins wrote:
> > Yes, I don't think it fixes any actual problem: just a cleanup to
> > make the two calls look the same when they don't need to be different
> > (whereas the call from __read_swap_cache_async() rightly uses a
> > lower priority gfp).
> 
> I'm supposed it is because __read_swap_cache_async()is typically called from
> page fault context which is less crucial than reclaim.

Exactly.

> 
> Shall I consider this as an ack but with commit log rephrased to reflect the
> cleanup?

Okay,
Acked-by: Hugh Dickins <hughd@google.com>
