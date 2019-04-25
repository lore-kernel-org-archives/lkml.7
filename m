Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70029C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F17F205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDiS67+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfDYTix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:38:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41170 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfDYTiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:38:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id 188so409614pfd.8;
        Thu, 25 Apr 2019 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NhAaBoh1UOOJS2beDrhy147sMZ3ieUx2BwOnAkrOn2A=;
        b=FDiS67+nZkmt1kzlhy7ZAIuWoi0E5hOaMWc69eOAtydO0+i37DA3w+xY24bNYotj7L
         HHu73oa/y0y7i5Nlk4T5IDHATnWnDTcDUj0K7X+t/uZ81WhkVDqvshcQLzMfrstIJNjg
         7rs/wOHRPHVSB6ikcNV8qw5r6fNMH8MMotQ9aUfJyPsmZTeIZR8uDFIclmTkMiRgYipE
         cE5YhUccNaCRsuJUTLypTcjpY37Zul69oxSQHiG7yC9jmj4TWdOkQ/Qag2ZJbz0MzXeb
         EDljd7VPu2GsCupP8tP3tlz5LudY00+QO8c24h6s/yBNzoDiLBklQWLOrl2PUXNZh3LC
         F05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NhAaBoh1UOOJS2beDrhy147sMZ3ieUx2BwOnAkrOn2A=;
        b=YI5GBHA+QXM3HPi2U2q6vxMKKtgV+86FAKYWjIM3/Dcj5TaT4KTiT16JfVWqiTxkLf
         o5hi/coGM3eLHy1UeWswSfACiWOgUwAD6X3uNJIdYg4vaBTxG5XxvfRvKDejCFKnmdqr
         X2ya3GPOibtNysVBih/BoRBGvLrzCrVxP8X2/nKG/vuBxGHDiCwH8jXUCd4T44eRgnW2
         pEYj8gGwuKCTicjNghDuQvrzwLqnTwVK5ouW66LG8i64H1SR2gLZ7txPDFpiIIwnAUDw
         SyYZgCG2RPoDN0TPxFfIRYWDCRmdUEzD0V/cveVGv99uUDCASKt4maKuaJSZegFEA0LV
         +EYg==
X-Gm-Message-State: APjAAAV2utI/dyxziQkw4POr4Qo2ziL36UkX3/V+q2L/zza5oqB4Vmsf
        tysb4t69AxVJ/0+MqeUY4Zo=
X-Google-Smtp-Source: APXvYqxsutLfX4mCh4VtuTdHtCpdrQRB1c8utPQ4xGKIOWyi/rv2Vl5hS6Gu5dRb1fmET0rRSdxEsg==
X-Received: by 2002:a62:5a42:: with SMTP id o63mr43980929pfb.170.1556221132167;
        Thu, 25 Apr 2019 12:38:52 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j67sm48463732pfc.72.2019.04.25.12.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:38:51 -0700 (PDT)
Date:   Thu, 25 Apr 2019 12:38:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/96] 4.19.37-stable review
Message-ID: <20190425193850.GE13462@roeck-us.net>
References: <20190424170919.829037226@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 07:09:05PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.37 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 26 Apr 2019 05:07:35 PM UTC.
> Anything received after that time might be too late.
> 

For v4.19.36-99-gc60b2d434e04:

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 349 pass: 349 fail: 0

Guenter
