Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E642CCA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC77E20873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="atWtbQR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388758AbfJ1M0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:26:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37211 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfJ1M0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:26:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id l21so11113091lje.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z5AyluMv2qTfIyVRClKMssZVhcw31wtXHvj4WXII8HU=;
        b=atWtbQR8Vni3TfC0Ou+ohngYF0wSzz2oI54BLC4Rn0pqqrVdXXHERQ7J2p9qypr+XZ
         w671rRO+1w3oacaPradqsKCJKlFCWwcrTivnMSaNfwPfhoseesQb5wtHpqc4FP0FISd0
         664FGjtxUlOHAWuIOuwnJArSlmxtXFthdxka+5/ccWlD1JBBYOkECofJn0IMld3RyFlY
         1yGBplLXLudj5uorCML+YK9r7r19qeJyUdMsdgF4z/xbfdl9feVaeMHMZEnSQhV7mNPM
         613OuKvidHEzy0CXc7uILZPNmIWYvzmvaKvQDZ1wGiu4KMzl6+CIKWGBgoa2S9twYun7
         cTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z5AyluMv2qTfIyVRClKMssZVhcw31wtXHvj4WXII8HU=;
        b=CME1PV9q4ggWC29VnXg+IK7qboEzJSa7rS/0Lhp+RMBT2eb5AJcfx/xPa4K1tBXD7t
         NIzcURokt1ZtV5QdWdzTsMFQ4SQcJ1RosK+48hHsnXXeh+9HciJ2vFXMpsFCRPvjNuST
         sgPCvU1NjKJKChnyrvbKKfwxsIP5L+0g3i/XtaVQ2Exu2KwPEJy7xf5jkDgEDRQuKH9j
         jLAomDMGNrcQ7bxJkLVUcXVaGRH0mQ6xnwp5IXBzRffSgGDrid9bDEGJfu5Cu55S1kdC
         O2i6aviNlfcAUk12fZeO2rDlz1ql7Dq4V7hxsCeWVp2ymn16+wylHY0nyPchvm0L/tcB
         HwUQ==
X-Gm-Message-State: APjAAAWjGuHYqugLYoWloUXV3wwWViXFkMtfQXz0J5SS71RU9WGusNnl
        K23TLPpAMZe3OTPEJGMoG4j3/A==
X-Google-Smtp-Source: APXvYqzX/kNTOsUwdnrZG6QsXdZ+qGMpKvs2rtBhXMpIja+rf/TeDoG0fNE0SxHQ7hNz799BexRZpw==
X-Received: by 2002:a2e:2bc7:: with SMTP id r68mr12017511ljr.27.1572265568148;
        Mon, 28 Oct 2019 05:26:08 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 87sm4571309ljs.23.2019.10.28.05.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 05:26:07 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 30BA4100242; Mon, 28 Oct 2019 15:26:09 +0300 (+03)
Date:   Mon, 28 Oct 2019 15:26:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC v2] mm: add page preemption
Message-ID: <20191028122609.k5suvp7b57oxglvj@box>
References: <20191026112808.14268-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026112808.14268-1-hdanton@sina.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 07:28:08PM +0800, Hillf Danton wrote:
> @@ -218,6 +219,9 @@ struct page {
>  
>  #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
>  	int _last_cpupid;
> +#else
> +	int prio;
> +#define CONFIG_PAGE_PREEMPTION PP
>  #endif
>  } _struct_page_alignment;
>  

No.

There's a really good reason we trying hard to push the _last_cpuid into
page flags instead of growing the struct page by 4 bytes.

I don't think your feature worth 0.1% of RAM and a lot of cache misses
that this change would generate.

-- 
 Kirill A. Shutemov
