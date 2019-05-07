Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73306C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412F32054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="TDEjJvzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfEGF5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:57:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43390 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfEGF5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:57:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id z5so8033172lji.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 22:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C7TwO1vjbNHfMqbAxi9vlDVvmDYxhZ6ib+epFPKTheM=;
        b=TDEjJvzcgnurW1FPZtCH9rYP2rDymIZeqdMqRdGI15WUsXRAn3v7+lnmyZ0fdZGIeF
         Pc5D+zhVmkFbz3l3w4gfKZ2EnMZd+l84USSuNcl+9kMp8kUMYmIHDBt8nJJyKVkqp9N6
         bfTxje9VGE12bymK8hn65n+jfWRpU1o46JJJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C7TwO1vjbNHfMqbAxi9vlDVvmDYxhZ6ib+epFPKTheM=;
        b=Z0gsu2fcxjADZJ0+LfUkysv+/18/YYAIll+1hEjZsw6PeuBxgH3QYJD663eJbYYfA8
         rtyrdTzJK53NSduHHwtS8XjfxFSpWbFA8JyAilAPeY8n21PZU8eYD0DUPEjlhdYOTBRH
         MaYfniGgQuSEVRibO1bnfaYMNzFIQGBjNHNTNoAIn46ydFYkluntED0buC9ScXPqWQR3
         UDSUdcUbGU+/8L99UTQuDw0SyL7xiAZz//H1o60XNgxWDev78eW1FMO8kfJrXbhuO3cO
         sFajMsWyyt9JA4sJgKLwGvk3XC1jWiDbwkTxqxYgzO2hPrXxOK3lK2v/PbgUkF5Dkhj3
         uFCw==
X-Gm-Message-State: APjAAAXOQvJNAPJ/KTlWOdd9D2+IWik0aGb8+CVNI8tiGkAuys62VlYH
        UWzoKvXvPmKxE8GZXOeYznnNZQ==
X-Google-Smtp-Source: APXvYqwERnjT55opTEsv307+a6frciS871V94u2tJ9NDGTgJXKuYC1Zj43Kpzyifcos6RVOT/S+r2A==
X-Received: by 2002:a2e:84ca:: with SMTP id q10mr2535264ljh.117.1557208623493;
        Mon, 06 May 2019 22:57:03 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s17sm1889372lfb.66.2019.05.06.22.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 22:57:02 -0700 (PDT)
Subject: Re: [PATCH AUTOSEL 4.14 79/95] x86/asm: Remove dead __GNUC__
 conditionals
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20190507053826.31622-1-sashal@kernel.org>
 <20190507053826.31622-79-sashal@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d18bba8c-0d2c-03bd-0098-5f39ad726b01@rasmusvillemoes.dk>
Date:   Tue, 7 May 2019 07:57:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507053826.31622-79-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2019 07.38, Sasha Levin wrote:
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> [ Upstream commit 88ca66d8540ca26119b1428cddb96b37925bdf01 ]
> 
> The minimum supported gcc version is >= 4.6, so these can be removed.

Eh, that bump happened for the 4.19 kernel, so this is not true for the
4.14 branch. Has cafa0010cd51fb711fdcb50fc55f394c5f167a0a been applied
to 4.14.y? Otherwise I don't think this is appropriate.

Rasmus
