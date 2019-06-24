Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA460C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948DD204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBXS7Cm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfFXE5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 00:57:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37138 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfFXE53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 00:57:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh12so6167400plb.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 21:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LzcRJpigxT5MGuTpMW9ctxhMBXABXFzOsOqSmkIMVZs=;
        b=aBXS7Cm1olXy+laKPXiQxa30hxieGkALh5+gO8nLnUI5lyVhz/oD2UTscaPgIbqFbp
         Y7Ffvd1JPoITsXzJqRKAFI9deCx9SlqjJH+MgVXINt0u76Dnpkk3bIR4gVcUYRMeqfpw
         g03GE6AV2zMpAZB+sHIwbfg4fiqUHiOUgjOLrox+NP9N/MiP75LS0ZCpbFopzYWhYRvH
         MfTajMnZITjGnwnXVe0GYFcym5RV7BZQ30gdEnWlwi+CZDHw7YrnieGZifKQ/QjA4z8v
         6x4EfX9eX8E9HjA4hWkNEj+hEZxEXuxc8U4m+mx8ObPMA3OcHmiML+w2tLH6csDuTE25
         qpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LzcRJpigxT5MGuTpMW9ctxhMBXABXFzOsOqSmkIMVZs=;
        b=SYc7D0GdFuRwdp09zkNZD7G1SK1hklYIeH8kSVw57tTHcw9WiQS7L9md7KydMMJOxg
         g8T+KbHk3XbzPqzcuDi4h6n7CN5NMRCRnnOEth4MvVsRYrn47kuzmfx4tyxI4Drl7cdT
         /7/Xbks2M3a2iUQ/fRT3RbH+j4Ozzsyp9I6Uq++eVcO5AFNWOFBIbMgL1/y534t0cXxK
         XoCw80rnkZDkHHmf+ln+6CpCnvaWxyK6v1hxoNjznvZw+msqAIg120rU610x5pc0r/e9
         /4P4EbJckrTp1F2wYFryqfN9vkgOwllV50xRCouH/mRtAVXLBwWYXX+xE5w8JXLVY1vc
         fe/Q==
X-Gm-Message-State: APjAAAUFNcFIe+N75KokhhmKd+8ePZImSqqW0q7cuPw3ttednUVjlqV6
        CiJ1eVPQitYyNTynUShY58AnYA==
X-Google-Smtp-Source: APXvYqwpkNtle9sTLmOxKKkYez6T2CQpCkhZX9e/+Shu8srXtG6COfcrFldWGtjRJbLpIz5bAo1G8g==
X-Received: by 2002:a17:902:e287:: with SMTP id cf7mr54710956plb.32.1561352249158;
        Sun, 23 Jun 2019 21:57:29 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id q4sm10420766pjq.27.2019.06.23.21.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 21:57:27 -0700 (PDT)
Date:   Mon, 24 Jun 2019 10:27:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, krzk@kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND,v2] cpufreq: s5pv210: Don't flood kernel log after
 cpufreq change
Message-ID: <20190624045725.mckcpb5kvkug33p6@vireshk-i7>
References: <20190621101043.10549-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190621101043.10549-1-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-19, 12:10, Paweł Chmiel wrote:
> This commit replaces printk with pr_debug, so we don't flood kernel log.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> Changes from v1:
>   - Added Acked-by
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh
