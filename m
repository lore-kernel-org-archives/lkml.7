Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD9BC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 20:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCA32464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 20:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FI3uXTGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLFUn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 15:43:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39069 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfLFUn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 15:43:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id e10so9043172ljj.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 12:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oF+xlo1sx9gytHOVJmZzD5EHDYm2UDoLMUn75V8RhEs=;
        b=FI3uXTGCTF/CsvRtjzUm5SGnAxOj8iYUwPwy84nNUJAQJIy5Z6jDPZ43JCM/HizVKg
         wjalGmSGIL0vznEvGNI1fgY2QOncXYDyRCXqkbhLZL8a9TB613Tjf+UBXDFFD4K0KOTd
         X/6uFMhEOqGq73YaEAyW74x0y8WYPWnVAscv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oF+xlo1sx9gytHOVJmZzD5EHDYm2UDoLMUn75V8RhEs=;
        b=jIsb8cSQUFacCNsPJ/drrrAcDspiEkHownmVQPsT1yLXTezwIC7C1AieYkr0ToRHrG
         /hq1RKQxfznjTt7hQAMnSqjqvDL5yeBcQeh/75Qh5yop97Q83fkfPdSIUGO+vP+HYCCe
         ph1m+LNtadRRoy/Bi9+L7WHiqV6IPQzwj8piEePZz5zPSJnH0B2DXMYPq8ovr3yc+yb2
         mvdkm1peX8fht/7G5KQPugvobXxVxvxbDVL4tpXLGyZ95aYJb3jmtqIMZLBCXtB/OHGH
         F0QU01qP3hnhFzYIx1XL0a4qgR6jwCx8JOMoD4T0aCkYHHyVtuXXuDIT3n9JOMZscxva
         iS8w==
X-Gm-Message-State: APjAAAVmmuIvg1yJE7Om9gRBnbKDSW79AakWgCuxnHLLxwDjktdT1MMp
        QJwTyFa27xSIOpe7d3L6fiYWDKZSpTI=
X-Google-Smtp-Source: APXvYqyLzYrfiF8hqBNBQsX3ZlL0rrT4ZQudDFkqfMZzoLDYJJkJwznKJbTPQp2hNmDXhWSqcz+Ibw==
X-Received: by 2002:a2e:9942:: with SMTP id r2mr10085754ljj.182.1575665034801;
        Fri, 06 Dec 2019 12:43:54 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id b22sm7422812lji.66.2019.12.06.12.43.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 12:43:53 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id c19so8994625lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 12:43:53 -0800 (PST)
X-Received: by 2002:a05:651c:285:: with SMTP id b5mr9852969ljo.14.1575665033279;
 Fri, 06 Dec 2019 12:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20191128134839.27606-1-georgi.djakov@linaro.org>
In-Reply-To: <20191128134839.27606-1-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 6 Dec 2019 12:43:17 -0800
X-Gmail-Original-Message-ID: <CAE=gft6YoDyOFvYLh-zOmpbNJwfgB0OGugeZKCORz0euMJyS0w@mail.gmail.com>
Message-ID: <CAE=gft6YoDyOFvYLh-zOmpbNJwfgB0OGugeZKCORz0euMJyS0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] interconnect: Add a common standard aggregate function
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        David Dai <daidavid1@codeaurora.org>, masneyb@onstation.org,
        Sibi Sankar <sibis@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 5:48 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Currently there is one very standard aggregation method that is used by
> several drivers. Let's add this as a common function, so that drivers
> could just point to it, instead of copy/pasting code.
>
> Suggested-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
