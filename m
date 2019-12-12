Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99500C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFF0214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="idUCuBkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfLLIMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 03:12:55 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:43254 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbfLLIMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 03:12:55 -0500
Received: by mail-pj1-f67.google.com with SMTP id g4so690974pjs.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 00:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ieuNU3BxQNBlr5wacK6RSBM8UAY3+jZD+rGJxQ2r+2w=;
        b=idUCuBklPDpVcwuCAeYiQS7bb3n6PjK0uWRYClqzf76Z98GfJCybphCzT2opcGL6S/
         3JgT9GfUZDfXUgvywaVFvgrCImPzLLV1iixkkK3wMHT+afWyPgdJVnKlnZa24DaSL5y9
         SusB4/xv7MuZxtlaOJvMflaiNZot3T7jIBcwO+iLQ9D8riIER895g7AO90MD1w6T6c2S
         Gg1z2I7DxqL+DgmEkSFityz6NE7+B7sYuB0hVhJ5AuzMqK8VVkxc86qFqUpWFPOuiS+y
         MwTa/cgfn7w32DnkWYaJxjxsy9KoSUslhLrJNy7w+pxFuGLQSIoRA6uEG1xkvy5S0Y0l
         izaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ieuNU3BxQNBlr5wacK6RSBM8UAY3+jZD+rGJxQ2r+2w=;
        b=p/WVTki8DJ3+EockSGo26f03i50kQxQjbYDeN1SMXikotCxL1GqL6WZ45fcMCBtYIc
         e/038ZKHILfrRpUCHb1ofBOVeKc5dn9rHyBqr+fdJbQADmdu8KDD1eAdjK/9uZ6Hi4Kx
         Hh/0CZIsRdOcBbEta5YX63thp60QdMfEQUTtnpa3l7f+QhxYvZ7YXeqPHijFWFjwEYYQ
         luQEzWCbX1iJicXdFbK/BtRzUsSSlOk29LlhtjJjyvrtlnCDYfyE4OkU3n4Am6D6Tnvf
         vUr7hqaCGgTFBMuZDRuJec8vnLeXmaV122YSzGVvV71FWpt0orOz/zwC1R6Yqrw7NtCX
         625A==
X-Gm-Message-State: APjAAAUNq1KZBrDSbnHxHqQT9HNk/9fCmo2mI3hsTBdM+x1Epuniwh89
        kZE9xSbk7MgWqsFLZYLmVfWTFg==
X-Google-Smtp-Source: APXvYqxb7RLa7bbmoiInTQAaQl62w7+UdiUrGstBnfUBKncodbLw2Y6ukkROPOm97s7y7P4lV0LIGQ==
X-Received: by 2002:a17:902:968b:: with SMTP id n11mr7556492plp.120.1576138374309;
        Thu, 12 Dec 2019 00:12:54 -0800 (PST)
Received: from debian ([122.174.90.102])
        by smtp.gmail.com with ESMTPSA id r66sm6260219pfc.74.2019.12.12.00.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 00:12:53 -0800 (PST)
Date:   Thu, 12 Dec 2019 13:42:42 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Will Deacon <will@kernel.org>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PROBLEM]: WARNING: lock held when returning to user space!
 (5.4.1 #16 Tainted: G )
Message-ID: <20191212081242.GB2657@debian>
References: <20191207173420.GA5280@debian>
 <20191209103432.GC3306@willie-the-truck>
 <20191209202552.GK19243@linux.intel.com>
 <34e5340f-de75-f20e-7898-6142eac45c13@intel.com>
 <20191211151701.GA3643@debian>
 <00804293-7f60-0ac1-fe01-0143eb508a2b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00804293-7f60-0ac1-fe01-0143eb508a2b@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 10:36:15AM -0800, Tadeusz Struk wrote:
> On 12/11/19 7:17 AM, Jeffrin Jose wrote:
> > above patch shows errors when i try to apply it.
> > --------------------x------------------------x------------------
> > error: git diff header lacks filename information when removing 1 leading pathname component (line 2)
> > when i did  related to this "diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c"
> > i get another error
> > error: corrupt patch at line 27
> > ----------------------x------------------------x-----------------
> > 
> > i use "git apply"
> 
> Hi,
> This was just a copy and paste that wasn't meant to be applied.
> If you want to try it please use the patch that I sent later:
> https://patchwork.kernel.org/patch/11283317/
>

i applied the patch and problem seem to be fixed.

Reported-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

