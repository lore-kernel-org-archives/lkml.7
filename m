Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E7CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A3D217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bAidTWOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfDEG0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 02:26:50 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38263 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEG0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 02:26:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id a6so3535786lfl.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 23:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nfe0JTh9kNBguIowekFTXt4dsmvKbhvvJco4xZqxgzo=;
        b=bAidTWOC7VgqKb6lpGRsTS7xB/gOr9H3fTDJgFZDy9a/rQDsOFu+CHZYk80xjQGIdb
         JShrMQhDI/yxFkQkrw+KlHcqTPnr/Dfn1ruXldq5xavO5xFGr7cV/oWVJe2mLUrdaFKT
         khabsSBcy+WbDKiOCMUT6na4ESAbNnFk93gZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nfe0JTh9kNBguIowekFTXt4dsmvKbhvvJco4xZqxgzo=;
        b=NOw3XBblkE12v9I+7xiUhSDvhFGrDPQq6uoQXX9RxAA0A50YfCQW3gjwauYy6X5677
         T4WMe/aPXcDHOB5MiXP3AxuB891AWGJu6rQRQ1D+u1Sylet2hkxSjlsvDhcHa9SvDCLm
         Uhml2Cc5Q19MWLaTa/tmu32nYLR+xOg2WN2FQnfkTwu/S9pbOhEistwsVT6J20r7kbaZ
         RJSkwk1BvkaebSXKZIG2IVpVnhZ3o6zRMmcGQ+aYAqDxYC/7aFm7+zyNIfMH+mWCy5qy
         8BWhTiqIAAzlhCa1n2dFz1W7dkFZw6PWg/yD8mt3maQOyJPV8T6kk9BFFsmoMlXKNodz
         Wh8w==
X-Gm-Message-State: APjAAAV3+BGMC4Vg4m72xYRhZVy+wae3XtyylHDAfF3eE+wPmLzH3k2e
        aqj5r6iy+H2+12z58uLdZ3TFcA==
X-Google-Smtp-Source: APXvYqzbhLHswUQGAKRuthmQH91tFBryV4Q52UX1PtW0CTADCYkfLmnECp26uiNNitBFSqejCE97Bg==
X-Received: by 2002:a19:ae11:: with SMTP id f17mr5579385lfc.12.1554445607494;
        Thu, 04 Apr 2019 23:26:47 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d1sm4078386lfa.15.2019.04.04.23.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 23:26:46 -0700 (PDT)
Subject: Re: [PATCH] overflow.h: Rename __ab_c_size() to __calc_size()
To:     Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20190405045711.30339-1-bp@alien8.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d2e7ee85-50a7-7026-82f9-2169656bd4f9@rasmusvillemoes.dk>
Date:   Fri, 5 Apr 2019 08:26:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405045711.30339-1-bp@alien8.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2019 06.57, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> ... to make its name readable to humans so that it can denote what that helper does.

I like the current color. It computes a*b+c with overflow checking at each step. calc_size is
way too generic and doesn't say anything at all about how the calc(ulation) is done.

Rasmus
