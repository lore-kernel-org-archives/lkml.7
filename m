Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887B5C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 05:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5789D21848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 05:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XRmo6bSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfHZF5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 01:57:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39208 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbfHZF5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 01:57:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id y200so3383561pfb.6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 22:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9xFcYbKloWUD9U0Qz6H0TveU9ug00KRHG74gi91QrvU=;
        b=XRmo6bSZpDYJflehRntZoFZ0Hrmnm6MChJl+pPSK/VdmBvIKexu7z8L23I/NuyX3zc
         oNfnckNUbH40o5fCFm8jasOpEjIWU92d7DhqQ+NFVOpavqT4d70J013UcnEn2aFHJA4R
         i7mBSxBetqP1b1HyCUt7h3WTyU9jnkHuh6l1TtSshql8cdJzWp6IgUEhJfy3vZZ/q4By
         /8DILUGBOApBBzmqBPPDMb6CeNwlgTxyupyZfI0C/k9yCgzd/Om6a7jnlyEPu2/SPVi8
         dPeUXr1rPEpgYlgvGrmAYx9GJbwf/mDd5oE9Z24atYxvbY8SgFOjfUTKzjVr4UoXUyuu
         tljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9xFcYbKloWUD9U0Qz6H0TveU9ug00KRHG74gi91QrvU=;
        b=CZy/XflbK6azQfZslcNxZHl1+rxmK67RWmJ+us5a1ZIpy4BEuJRXMiTVk01wmJO+G/
         yl8pg+EolUX8rOF7UQHxHkKj/WyQ2QwhdG80gl4xvSJuA0mdP7G4Z6GTDktKaRASjFeF
         tP/eMAs7yJBAnhKe93lEAdYO9sDNMTM2YbvXhO2LCnWLxSQezg/J7jiW+qLY8yAPnXrx
         DBWtZC+vn3MoHmDxeMhSpcQPRGWLyM4L6Xiea6/LjV/gRuFQ5BR/JO7OBpSFP9+zagir
         MZbrL1qFNDmZqgY8+T/ssM4yjtpl2iVW/v+bhE9d5JpGcePBqIzsXC8WPk5ot+Ornlxr
         jNVg==
X-Gm-Message-State: APjAAAV1fQ+79FrWItGblZ6T2RfVoK5jtX9+UK1JXCDIqkCGKb+No05q
        biJ3Qlj/BY4gaqGijlj3T6Ijgw==
X-Google-Smtp-Source: APXvYqyXdSKe10mfBX8QPJTikvSq1h+bRif33tDeEksl3VMW4Dw/Gd1yZi/jfZNNuhPVDn9ocm9muA==
X-Received: by 2002:a62:64d4:: with SMTP id y203mr18157670pfb.91.1566799039325;
        Sun, 25 Aug 2019 22:57:19 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id y188sm10528347pfy.57.2019.08.25.22.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 22:57:18 -0700 (PDT)
Date:   Mon, 26 Aug 2019 11:27:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH 3/9] staging: greybus: hd: Fix up some
 alignment checkpatch issues
Message-ID: <20190826055716.7ybngfgqvadcn4uw@vireshk-i7>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
 <20190825055429.18547-4-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825055429.18547-4-gregkh@linuxfoundation.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-08-19, 07:54, Greg Kroah-Hartman wrote:
> Some function prototypes do not match the expected alignment formatting
> so fix that up so that checkpatch is happy.
> 
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: greybus-dev@lists.linaro.org
> Cc: devel@driverdev.osuosl.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/staging/greybus/hd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
