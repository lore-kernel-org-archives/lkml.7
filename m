Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2784BC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F110C2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YxplCJLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408871AbfFLQMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:12:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37089 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405740AbfFLQMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:12:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so9109362pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 09:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ofOjnQO6wMRVhMaUq5s5XBY0W/Gr9lBkHwBz+qOWpPM=;
        b=YxplCJLkptJjdPNVhI7idLGcCZQdb66rR7Tcxoj5L7eeemO7dRE60CK/PUbJSDLhno
         RwfUUKPEmkdkQ8VCo67I6kOSNkPvLyMYgiGMh1unSkGcDHEDVsHYJjNXFHoUeWK/Fl+V
         DxyqmY2vir8siz0HSUki1QVc5sjDgDKy0MdTDk6pf6GztSiRRtjjlwSwtvIcSAMtltG7
         1l0yh86/x3si+9Zg6oITa1qnpOWcgxQCrt+yN+N3uDprSDCipjYmqEpTr9t05FYx0WwY
         i//i+EUihPjhegUtMqXLX0z4pkmoe3GnXDQAifT7jMykqJnudFp0xrvbuLzC2cVsfNcf
         65sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ofOjnQO6wMRVhMaUq5s5XBY0W/Gr9lBkHwBz+qOWpPM=;
        b=j5z5BHzeQjYlBPW5H6ma9AWcDtb8iMZeTm6hi244lGG8K8ZCK0G216rNcRTuFNF6In
         JZQ9/laSSrvgkMFjHsV09Yrq2zQXp8kLD9choexFO0uCD5kKuTAlPCVJgfAf3WUuUkc2
         zK6AAC27tlNH2rYLeLLcvDN1qv8EkZUEb0QWxVJUuh74/Bl51a35rUGBaY9ga+ZjaZD1
         kv92eNt4nFmgbGvwWBu2vmbjvq7HficxXVpDMfKRTUjRU3IkM4wIJx8G4S2ZpL/a/dfH
         XvGps8GHcCT6ovKhLpeOeds/z5httkbPRAjCHB8VrkOEByZHuVxk+fiRXjDF8Lkn0NFe
         W1JA==
X-Gm-Message-State: APjAAAWmCvuVTJxweCTfRGwbhVURWfM/QrynJWHgbq1G6yt9pcY3Lspf
        SuQDC2ON0mT3siQWZ1IPv7Zmjw==
X-Google-Smtp-Source: APXvYqzIewVEMZ44U/OEIOqM3RrSgyFo9R1pMdl8Nl71Jbc+tC5GZhhJw9OW2DquOv7T/biJ3LqgLQ==
X-Received: by 2002:a63:a02:: with SMTP id 2mr1665934pgk.315.1560355963056;
        Wed, 12 Jun 2019 09:12:43 -0700 (PDT)
Received: from davidb.org (cn-co-b07400e8c3-142422-1.tingfiber.com. [64.98.48.55])
        by smtp.gmail.com with ESMTPSA id m96sm566195pjb.1.2019.06.12.09.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 09:12:42 -0700 (PDT)
Date:   Wed, 12 Jun 2019 10:12:39 -0600
From:   David Brown <david.brown@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove myself as qcom maintainer
Message-ID: <20190612161239.GA9155@davidb.org>
References: <20190612155411.GA28186@davidb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612155411.GA28186@davidb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I no longer regularly work on this platform, and only have a few
increasingly outdated boards.  Andy has primarily been doing the
maintenance.

Signed-off-by: David Brown <david.brown@linaro.org>
---
Resending this, hopefully with text=flowed not set in the email
headers.

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496cff999..27df8f46a283 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2050,7 +2050,6 @@ S:	Maintained
 
 ARM/QUALCOMM SUPPORT
 M:	Andy Gross <agross@kernel.org>
-M:	David Brown <david.brown@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/soc/qcom/
-- 
2.21.0

