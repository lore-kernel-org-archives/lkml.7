Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD246C04AAA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFD920B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Y2+mqpv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfECTwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 15:52:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45323 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfECTwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 15:52:11 -0400
Received: by mail-qk1-f194.google.com with SMTP id d5so99834qko.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 12:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ivgmrdOFqYbX906OA4N9N8K+zP87FPliWqhK06GaWhc=;
        b=Y2+mqpv1ToBfZomGR0KiG0kJTC7Pd0/kQpdMHTLgCyV+gSUCOY8qdd9UCYmiwv8VrP
         a0P2nQSotvfAV+CN79oMGzR3siWxg++Ro/Nh7074im6lvktjpD8hIg0qMeLNeViPAb5p
         Ak6AnFNXIYyOEpaZmHFL4DjYbaTMMsJPHWbtlDryeNYlH9CMipo59Z5bwqt6LnH+866y
         no7ekuTp5m99+xYSlNrDLBL8TWLAbgPMf3WhIiwOO3hmFCWHFVznd4vHpEhYyKrruUob
         /WctC1Yd5I8cShP8X4p/ZyVtrGhsfMRHJnAiQwD7vi7EwWffIOwvaHGiK0CMeMDge/gC
         3dTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ivgmrdOFqYbX906OA4N9N8K+zP87FPliWqhK06GaWhc=;
        b=tlfos08UnIQJExkH4a/UcFy66DDJ91Skmyl5S5WP1W/YwutM7+q4VToZGy9IzWVvD9
         RXlV98XsOWuJjVyRa5SjoeB8K5BGbO1UMKeN6/VGw7U2Ph6KKHJuIyOcbrcB2RIzqDYw
         xAwZLz/MXxL34s51wr8VU0D4c27Kl/SccQlw1f1es9UtGBTvIkeFHNeL/LHqcTFwTU8J
         UrsrJdGetO+InqwuQhni2iuzsbvqtRv/EtSDt8XzTqR/U/xzuxtDmy1xlozGVFWXL0XW
         Gad0SGeAI2e/RmDdikWx95RFpbv+v4uCZn/by43RKQYVx3fMJxDBMTzte4KdXz6SjQNz
         SuOg==
X-Gm-Message-State: APjAAAX2uAetlGXqsxCyBuIkf9G0t3CdPu16rbRdBaQihZHPTEBFddBA
        TO/qF34sKcmF55qop39zr8GPIw==
X-Google-Smtp-Source: APXvYqwhEb3DduJH9sxXZb04NbmAIe9orgplVqZkdluZyv5W3gUxH6ho/Vp1ktRhA9nOhgZWzjVhcQ==
X-Received: by 2002:a37:b802:: with SMTP id i2mr8702107qkf.343.1556913130058;
        Fri, 03 May 2019 12:52:10 -0700 (PDT)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id g55sm3082470qtk.76.2019.05.03.12.52.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 12:52:09 -0700 (PDT)
Date:   Fri, 3 May 2019 19:52:07 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jane Chu <jane.chu@oracle.com>, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, osalvador@suse.de
Subject: Re: [PATCH v7 03/12] mm/sparsemem: Add helpers track active portions
 of a section at boot
Message-ID: <20190503195207.l7jrr3z4halukycm@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <155677652226.2336373.8700273400832001094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155677653785.2336373.11131100812252340469.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155677653785.2336373.11131100812252340469.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-05-01 22:55:37, Dan Williams wrote:
> Prepare for hot{plug,remove} of sub-ranges of a section by tracking a
> section active bitmask, each bit representing 2MB (SECTION_SIZE (128M) /
> map_active bitmask length (64)). If it turns out that 2MB is too large
> of an active tracking granularity it is trivial to increase the size of
> the map_active bitmap.
> 
> The implications of a partially populated section is that pfn_valid()
> needs to go beyond a valid_section() check and read the sub-section
> active ranges from the bitmask.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Jane Chu <jane.chu@oracle.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Hi Dan,

I have sent comments to the previous version of this patch:
https://lore.kernel.org/lkml/CA+CK2bAfnCVYz956jPTNQ+AqHJs7uY1ZqWfL8fSUFWQOdKxHcg@mail.gmail.com/

I think they still apply to this one.

Thank you,
Pasha
