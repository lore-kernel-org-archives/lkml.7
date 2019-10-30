Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52D8CA9EC0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 06:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD8D20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 06:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="iLvr36c6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfJ3Gum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 02:50:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40401 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfJ3Gul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 02:50:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id u22so1345507lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 23:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OG8TB5Z3OxSF2gHsUrhZBaXhf5Zgk82Z4whv67njgvw=;
        b=iLvr36c6OKkhrzfRc9P24L3/yvyhg95cNQYYiDkqVk0XocMpM/RrtgKRStDaUTD3hy
         t2Z0iDKBFn68feV/JPUoOeIYNM+dK/jviWrlQ3W7ulycbYjsHU+hCuO79lVCfrOfbTop
         cLCG/NjL2OtAkcfDNYvkxpg6oKlzy09qag8StQ1AqeV0MbViYA6fvhdaco9LZU6ImE0Y
         67+/dTZGp153XQPFxmdJtAEHsJXq+6OL+P18Khdb4abA1itzfm8Cj7nWJrF/TKDbmpY8
         BTg7htB/XoXzxNe162ot9/hSu5WFDQkQbeF/B4vzWpL57AnMPUDdq8rbY4PXirZ9wer7
         bKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OG8TB5Z3OxSF2gHsUrhZBaXhf5Zgk82Z4whv67njgvw=;
        b=TQznQH4VZfFPCXYur6fKKmmlnF5prAZalIaMOTWV3BKRejJIQ8YC2b+CU41yLC3l9E
         cZTsUI1VKz+FZVstv4egGNxIoAm7kabNpTG5t7bVqSEA1C7nJvYlSWPlxxiLfydmL+e6
         cU4zhXZ8rRvHmst94uuMi2xzFhO0FIYZ7VgI/BX5ZuKVpyj6QNE0l/1Epo0kuf8BVISL
         TdNSGaTC8GsXs/AsH+pypIQ33qPIRsEDKPKc0Sxg34oLz1LWocGZ1eDkDCfu7Bra8MXc
         OSu5nZqqzpx+U5Tt1QaetI7MGp+5RsdiBGkz2zZ5iOb5ogtTdaGYUEuNZHVDImI3kTkp
         hQaQ==
X-Gm-Message-State: APjAAAVkn0GiQ7EVIa4TNtIgQD47JD38MTOhNZ+2eT/LNbBl8y7hhGnh
        ZNzmu1Fj8hYDDe3pqKVCkkRyEuNF1+I=
X-Google-Smtp-Source: APXvYqyogKk2T+hF/rDbEusxizB/QjtNb9b5jF9FBYmoPBYmHE2zvO/6BoiLQKZ0srYAn7ZqDqdzNA==
X-Received: by 2002:a2e:151c:: with SMTP id s28mr5291987ljd.70.1572418239710;
        Tue, 29 Oct 2019 23:50:39 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n5sm640209ljh.54.2019.10.29.23.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 23:50:38 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D87181003C9; Wed, 30 Oct 2019 09:50:37 +0300 (+03)
Date:   Wed, 30 Oct 2019 09:50:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Steven Whitehouse <swhiteho@redhat.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
Message-ID: <20191030065037.o3q6usc5vo3woif6@box>
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box>
 <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
 <20191028125702.xdfbs7rqhm3wer5t@box>
 <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
 <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 05:52:05PM +0100, Linus Torvalds wrote:
> But NFS, for example, has open/close consistency, so the metadata
> revalidation is at open() time, not at read time.

I don't know much about filesystems, but can't size of file change after
the open() under network filesystem? Revlidation on read looks like an
requirement anyway, no?

-- 
 Kirill A. Shutemov
