Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD7FC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5862020881
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UyHPsmHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfEQKue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 06:50:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42330 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfEQKud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:50:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so6597864wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 03:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fy6ato0mdZ+343xSDfiKvFVjKi7omzZdGMuv/1R61jE=;
        b=UyHPsmHCDoLhomdBbMfbRg5J1rPMpuyjchhnP1zKjvFfywm0yvRihlRohB5oD+Dfea
         S2ixIhoIfAKakOEFgVn/bR76iznUWQ7FdLlnI8HqZuQ3amK/6pS1XhkJ29hQF2R4IStR
         zepElaDIAMiFHfAEM2QvHgd9L+ADuIiepypLXmD5bMLHnAFxsx9axQCB1cabimwTKhQT
         iB+Wat5KoDy1NLOvU+MskFh5zn2/e2LpZRW622VacW7T4Mg4vNtZQeh06ufD6+wLAJ9B
         Eem6DWGWow6S9fdQ5B2efbFRxlWPcQi6ZAwc+RjlcAztHmroeZ2ZPcbE0MPYIQdYWozs
         +okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fy6ato0mdZ+343xSDfiKvFVjKi7omzZdGMuv/1R61jE=;
        b=Czj8agVDkttFUN19U/oVH5WG4uFVScBTcMRYsXvcnAMPodvmFnLkASe6UfYmc2FIS3
         ktzeQvwhEshVzuaSz6uJfhMnmhw5GrxbpwqHXec0/f5ce7GJMWMf3tdt+M0+jwwzidL7
         pbF+dFW7oS55ptEUS/4DYGir+6fbRahPnTj0o09eYbIU78pJnZ6xIOnTB+z9JZtzUgzm
         PP8JD8inmVlJhWqJWai/Ye0R6cilM28YRPCuQNFWwC+zXp5XGoXyN79p65S7js67kasO
         sgnODfKJ4SjT67+xFDKnfmjOS9yYwajsgIRbcH2loYRpPHBUP0Bc3wCO+QzsnFr9+2bz
         NoIA==
X-Gm-Message-State: APjAAAU+TdH80/J9/A4A+ak2sUnQM8N/JUyFlNPD7jyZJ9HvhE5k7ZU4
        pqJ3NUqr7noJ4o8CGt58TWmWXg==
X-Google-Smtp-Source: APXvYqyqtAU6a63fClrYVQgQgQYERgFK4EvgGfWGRJC5cl2XmpSYtf5nveRsqu1iBqskymWNQq1IIA==
X-Received: by 2002:a5d:6610:: with SMTP id n16mr25864841wru.250.1558090232250;
        Fri, 17 May 2019 03:50:32 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id y184sm9227716wmg.7.2019.05.17.03.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 03:50:31 -0700 (PDT)
Date:   Fri, 17 May 2019 11:50:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Philippe Mazenauer <philippe.mazenauer@outlook.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib: Correct comment of prandom_seed
Message-ID: <20190517105030.GV4319@dell>
References: <AM0PR07MB44176BAB0BA6ACAAA8C6DC88FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR07MB44176BAB0BA6ACAAA8C6DC88FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019, Philippe Mazenauer wrote:

> Variable 'entropy' was wrongly documented as 'seed', changed comment to
> reflect actual variable name.
> 
> ../lib/random32.c:179: warning: Function parameter or member 'entropy' not described in 'prandom_seed'
> ../lib/random32.c:179: warning: Excess function parameter 'seed' description in 'prandom_seed'
> 
> Signed-off-by: Philippe Mazenauer <philippe.mazenauer@outlook.de>
> ---
>  lib/random32.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks reasonable:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
