Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A8BC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B6621A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vS7NvV9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389391AbfJCUWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:22:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40854 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730768AbfJCUWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:22:04 -0400
Received: by mail-io1-f67.google.com with SMTP id h144so8558633iof.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 13:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7WiJ4f6SzOGtMzESiBYziKahNzjtC5eHf7/cW0u7vRo=;
        b=vS7NvV9D9OYLkuvCt7II7enEg4sGb3wAj+I3sIp5o4kFmqlWNbVU70/ysfI8h8cY3J
         qrP4SdB4ZsiAQ0xQM6mv6VyA3lq7MOyYuX5Fv0Qxr4SdpiDZTJktQXnhfYRv+03o+JV7
         7b0bTMqPO1nnWWnr+laA4xpyZ2Dk9vkuHyR69SzmtHEQes5UYEdLCl5P/Y6no9rwCQzY
         7pg/9qjUdF3ZDhshcTtbiCSK/VFKGU/drrT2Tg5vZPg3N/yd+K8JpasxHUT5rZSWwnwm
         /aqDOpNfheEA07AIBX8j3pcQtqyzEKJBymD0OPfV2W9ICaY5xSspm+G2CFyzDzK4IFap
         55qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7WiJ4f6SzOGtMzESiBYziKahNzjtC5eHf7/cW0u7vRo=;
        b=inKdxKnbRLMZ9D9nhbE3R7LEp9tVpuGgs4vEw47nZAk584qfSIU+z3WLeFUdskzTX5
         QnPoaJ8x4u//5whHvAzM4IMXI0AEwoJbF2LU6KtHJ2UEureK/8aPcAya7vAYuoc92yLu
         rdnLsiKIMXTH1G6DAm84IXkmPMx/kk5qFyjc/98mAtgGSvEb2gw7XJHwCRi06pPqYVgF
         +Y3Ge8R/p7/FxHN0uhqO8NQRb1JCK+SW4CEx+IsW68Pxxviprgxrf/VsDGjcyOEWX9T0
         cI5SaceLCftGGgeBRCWKRS/8d/RdKBJmjp2pcqUcOCdxH8YrruPse0TPELTHthhdJKMK
         KUaw==
X-Gm-Message-State: APjAAAWjCf7lrbsoUOdGSTKPbWlfVUhKLdUka72UJeXxL0h0iy1O/4LX
        hcXO0Tq/XQ0iq9Zjb17WGagezg==
X-Google-Smtp-Source: APXvYqyuZfaiEVvhudwj8fPSSMbzWnn8JOvkbO8LVY3q31G+3mNsQRcG6YIyPsQm1Vd3oK9PFrpp6w==
X-Received: by 2002:a02:cd05:: with SMTP id g5mr11297113jaq.52.1570134123075;
        Thu, 03 Oct 2019 13:22:03 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1133::1057? ([2620:10d:c090:180::832a])
        by smtp.gmail.com with ESMTPSA id f1sm1683227ile.77.2019.10.03.13.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 13:22:02 -0700 (PDT)
Subject: Re: [PATCH 1/2] block: sed-opal: fix sparse warning: obsolete array
 init.
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
References: <807d7b7f-623b-75f0-baab-13b1b0c02e9d@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f8b4652c-4169-793c-b626-6e52e1cc0693@kernel.dk>
Date:   Thu, 3 Oct 2019 14:22:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <807d7b7f-623b-75f0-baab-13b1b0c02e9d@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/19 8:23 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix sparse warning: (missing '=')
> ../block/sed-opal.c:133:17: warning: obsolete array initializer, use C99 syntax

Applied this (and 2/2, no cover letter...), thanks Randy.

-- 
Jens Axboe

