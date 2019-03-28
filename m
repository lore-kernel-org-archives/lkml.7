Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E076CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A8221773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TfWnzcWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfC1ORJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:17:09 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37033 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfC1ORH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:17:07 -0400
Received: by mail-it1-f196.google.com with SMTP id u65so6309152itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 07:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qp+Dpr5cOYlTukhG8arWCLdHau5MAb5m/3soXMgxbz0=;
        b=TfWnzcWnvBSSN1jAawy3+QJH1Nze83y3XScfpJW8edZeCWy/u8xHQa40HiEZGpdrSN
         lCzMZtdKjD/yn+tTAKoEFNe2NIWzEgZfDGurZ9fdWhJIiQBCfxpDBUdWx3WrMjR3zBMf
         1gWdIISfIfVFmgrlEr5UxN6D/OCFYahr88XqTapjbW1WMcxtY+uFr+s6bMbrGX5x2cD+
         /x33w0TJrBRxzTZV4wFPawbzuYRDCfiIxQhrxnJjcEjwTdY8FG4GJqQ96fl5Arb10FMA
         1i9rW8bS3LU28TLN29SaNj+Cnfu4h9QlqjY+i8fUd+UoPfbn0mW6uxEGDXludCJlRK/S
         OEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qp+Dpr5cOYlTukhG8arWCLdHau5MAb5m/3soXMgxbz0=;
        b=Y7aYcCr+AdNxebAkAmWRNqq2tUCbE1auxhZQq9XugKtq6qhfLoZrocpPf0zhOIM9i/
         Yy4DT0EyX4qzyqV4Lt3uDO543JgYaolgCuKT9gIcJGyVYl8EKtMDhfkwRg6zxB41SPvH
         ve2LiuUFnuHFShSni3u03/GH5r2zzxyKupYp1fUfS3rZsSAXOOpkcqDhLHmmUuDHxj7p
         5cXXFselrymHwIjCTkMtf2Z+UTEGB43XJlvR8MDANtLPH9XOuAWCC8JRhqrCvEerEDhB
         hhLiejDCVSaYqRaPlLs0xE1TwPSCuXSGZQPL59TbStZu7QCGKZ41WOgYDNNbcNQTJK6w
         fEOA==
X-Gm-Message-State: APjAAAUXqs8VZbBQM5LdpwVa1wGckujVnU8QG1wzbrBom+4gCg+Z4gXp
        tIEWd2hO33SF5jqRSn6S0qhEGxpaBk5WJA==
X-Google-Smtp-Source: APXvYqxbaOI3W2t7hwTPlynHUZHXDPAHAHqkd2rRs7evgVo7BgycY6cH2XMYMgaJXNkZfK3XBuyVFg==
X-Received: by 2002:a24:1f06:: with SMTP id d6mr180913itd.11.1553782625977;
        Thu, 28 Mar 2019 07:17:05 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id s12sm1751550itj.41.2019.03.28.07.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 07:17:05 -0700 (PDT)
Subject: Re: [PATCH] libata: fix using DMA buffers on stack
To:     raymond pang <raymondpangxd@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190328121925.15488-1-raymondpangxd@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6c7d28e9-ac56-bffe-05c0-2ca7ea6ff37f@kernel.dk>
Date:   Thu, 28 Mar 2019 08:17:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328121925.15488-1-raymondpangxd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 6:19 AM, raymond pang wrote:
> When CONFIG_VMAP_STACK=y, __pa() returns incorrect physical address for
> a stack virtual address. Stack DMA buffers must be avoided.

Thanks, applied.

-- 
Jens Axboe

