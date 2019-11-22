Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80C2C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25652067D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlBo6dnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKVSOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:14:12 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39555 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfKVSOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 13:14:11 -0500
Received: by mail-ot1-f65.google.com with SMTP id w24so6975473otk.6;
        Fri, 22 Nov 2019 10:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=++X7xvmmEbbGpJA2CoHFS/wR4H0lmv9UHljrPukoLCs=;
        b=LlBo6dnE/SBL3UjtBXI1U0LRnf2iqF2u+GwbIu02rlOZ264GmQRucdnvKstLp+OXaQ
         lvvqkcrZ7rHaOcVfq6vDu6kQZyDZvYtOFstccNuWdlmpIbJHE466KhgVI4jczfopaRfD
         7xeEqenQjKrsuT0X9C0QMcjlTRY4mMfm4bC03Mi37Ow8VpxK887gc3PnR/VaZr8FPuQA
         2X5iyGu2kPXkq9/kgxtNmLy9MYcLrKY189DKHQZmvv8VymkqbfQNZhILjnJShjH0uCqo
         Zz49UCFmrwmg3FhM0723V4F6avaTdX6Tp98G84OOvrLPQkXEoWEAsDyH+pKgJVyL6I3s
         gIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=++X7xvmmEbbGpJA2CoHFS/wR4H0lmv9UHljrPukoLCs=;
        b=FUkdHvWj68FMZs3ZtDP4M2W798EviADMLYgHfIs05fOk92kC3Z1UfKs0A3BTyVsxH2
         pNhc3VqtnViImaZCwQ8choQ+ju5QqwcVljSxYiG1tiXDF69IP9p1TtTAHPvaxbbGR3Bc
         y11Fo/89PJFDzLS/efq8pPqaIvvQhZd1yaBnzqoyL2iUkOH54rryEHGe+DDSd1PwfG4s
         q5RK1PsKALlmnW5r4G0JXY5/cevMRHc5tP1B+EmOwcPyi8QuIEO3cKiB2ejdHIuzczrk
         ZEyRXQ0Ir1jv6+555hjpbZMGpaYqnE4C4KL16BbVPOsMrgUmhiwO5OsADjKFobNudb+e
         U2Yw==
X-Gm-Message-State: APjAAAV+AmOoCXa/l9AScOQQbvsMfwIGozS5fsycQkRYacYqUFUSffJs
        AzFGd1cHvXNnlR131mwan2A=
X-Google-Smtp-Source: APXvYqyFZ8+Mx5tmiub/FoI97kwONWv6XJKNoA1R3cCR6avi/awBqTpTmb57QPfJ2h3aE0sOfG1mQA==
X-Received: by 2002:a05:6830:1152:: with SMTP id x18mr1316947otq.87.1574446449056;
        Fri, 22 Nov 2019 10:14:09 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j80sm2266842oih.49.2019.11.22.10.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Nov 2019 10:14:08 -0800 (PST)
Date:   Fri, 22 Nov 2019 10:14:07 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.3 0/6] 5.3.13-stable review
Message-ID: <20191122181407.GE13514@roeck-us.net>
References: <20191122100320.878809004@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122100320.878809004@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 11:30:02AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.3.13 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 24 Nov 2019 09:59:19 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 390 pass: 390 fail: 0

Guenter
