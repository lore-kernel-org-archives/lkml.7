Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B8DC41514
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795E421783
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+rAYd5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406157AbfHIJpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:45:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33791 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbfHIJpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:45:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so4790071pgn.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 02:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ge9zDnKeP5Zu0nmntU1cSXLgT4EnpnKS+7IQa6koc8o=;
        b=r+rAYd5AMY5icdk4MZb2mTfCNXTc5DxqZTHJiYkRCv6khogb6xombKcpNQLr8sZkxS
         rIABZfWtmM3nuRZm9qPBOmb6LzDdi86ahUCXSA1JjScEYA638D1V2QOp4xPXZDgXZQFK
         vHiE36+IR97fV1aAfPm9vTE8VI5zWkxFalMtMoj3ZToR4qRCL4Jq/yBNzmysUyY6ovT5
         Rxy3V21jraMU24Oq/8rdc3KMP92DnWLMysM1N5RjEoDNiB0A1UNa3HBTZph2Ah4MAdSN
         wwM3NAmIR3Zr9vKpGHgBiq2W2sCerpYlL0Sq1dqBmN720+/ku3xrD8LvtFQ7NMEnIU5Z
         kqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ge9zDnKeP5Zu0nmntU1cSXLgT4EnpnKS+7IQa6koc8o=;
        b=cyANpzgTKfsxAlIYyRhFW5J/DlAxbiruUHm7YLhUvlxoDo5pibSRpZNbZyUKFu9Uut
         gf3aYoqIc+6Xk6rDMoKpWYOKZ34aRW3egJdA7gue1tB7EG4y9HIZ4nhDxWF3b+A+PGGo
         4eaLpEvXDRKFUeyGthYnDFYjiJOSG7yWGaM0UBJ05mWb4J0IgJSBZ5rYUK7EsDcSEpWN
         Sqf85dsPwqJh+rSoiTdKr0F+OSzK6F304qKgd3vWjAUuydrJwCwxpYYsuZL9wZCs4w0m
         eqBgdkwRA8vni9GqgQnhVyVQtYGlt7HxsEOckwZlAnZo9dBEvm5mZR4MmANkh03KjtDa
         Cfgw==
X-Gm-Message-State: APjAAAV8TD1LEGr1T77DRn66Kd3xr3WM204sT47s8iqEuHI+TQwBeWP6
        S6QYsBPE+WVCwbz7htp2kr8=
X-Google-Smtp-Source: APXvYqxT1PLVMyiCnMcyJVwKgIa9oFlTOOytPuC0Zu8U6Kfk//cGcEpNvnMrzMvBp3DQturQVby8YA==
X-Received: by 2002:a62:e308:: with SMTP id g8mr21369420pfh.162.1565343902160;
        Fri, 09 Aug 2019 02:45:02 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id 64sm98698155pfe.128.2019.08.09.02.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 02:45:01 -0700 (PDT)
Date:   Fri, 9 Aug 2019 15:14:51 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, sivanich@sgi.com,
        ira.weiny@intel.com, jglisse@redhat.com,
        william.kucharski@oracle.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees][PATCH v4 1/1] sgi-gru: Remove *pte_lookup
 functions
Message-ID: <20190809094451.GB22457@bharath12345-Inspiron-5559>
References: <1565290555-14126-1-git-send-email-linux.bhar@gmail.com>
 <1565290555-14126-2-git-send-email-linux.bhar@gmail.com>
 <b659042a-f2c3-df3c-4182-bb7dd5156bc1@nvidia.com>
 <97a93739-783a-cf26-8384-a87c7d8bf75e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97a93739-783a-cf26-8384-a87c7d8bf75e@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 04:30:48PM -0700, John Hubbard wrote:
> On 8/8/19 4:21 PM, John Hubbard wrote:
> > On 8/8/19 11:55 AM, Bharath Vedartham wrote:
> > ...
> >>  	if (is_gru_paddr(paddr))
> >>  		goto inval;
> >> -	paddr = paddr & ~((1UL << ps) - 1);
> >> +	paddr = paddr & ~((1UL << *pageshift) - 1);
> >>  	*gpa = uv_soc_phys_ram_to_gpa(paddr);
> >> -	*pageshift = ps;
> > 
> > Why are you no longer setting *pageshift? There are a couple of callers
> > that both use this variable.
> > 
> > 
> 
> ...and once that's figured out, I can fix it up here and send it up with 
> the next misc callsites series. I'm also inclined to make the commit
> log read more like this:
> 
> sgi-gru: Remove *pte_lookup functions, convert to put_user_page*()
> 
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page() or
> release_pages().
> 
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").
> 
> As part of this conversion, the *pte_lookup functions can be removed and
> be easily replaced with get_user_pages_fast() functions. In the case of
> atomic lookup, __get_user_pages_fast() is used, because it does not fall
> back to the slow path: get_user_pages(). get_user_pages_fast(), on the other
> hand, first calls __get_user_pages_fast(), but then falls back to the
> slow path if __get_user_pages_fast() fails.
> 
> Also: remove unnecessary CONFIG_HUGETLB ifdefs.
Sounds great! I will send the next version with an updated changelog!

Thank you
Bharath
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
