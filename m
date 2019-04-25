Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD08C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18950217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IS2uIls8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfDYIMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:12:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42437 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfDYIMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:12:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so28957125wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 01:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uJmeP7Qea/a4ET79JBxaJojgiU5pl2yNMY8bcsoS78A=;
        b=IS2uIls8SPZOBU/Ks8Pk0WHVMSrAR1NL/NM7Gl8rkyK8JOowxUKuHkmQ4bJL75eyyL
         OaONLthX42eLiDb+AASy0Zs0AWlLebFp9zCiVMMGiAoq1/ioGtMUJ2bVfIvix3fhdKAX
         QVhttA9KJi7w9zO59hl2xWkeauk8Nw6jJBefnaX1r7sb7dcGbZoj8im5phl3kn7oNRPW
         JsAqsMG9OYyjrYsdDsqr7fZMWqrrXo8Bbbv92Can8d0IuloVxZxlnB1sHE68C+r7VU33
         cCo9UtYBPfmB8Y9cbM8YXy30KICPAZhp08Zi4MdaugqPmxN3Gr0IL3V1DbosKFe0uP4E
         5EbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uJmeP7Qea/a4ET79JBxaJojgiU5pl2yNMY8bcsoS78A=;
        b=ionZMalA1lknqtPekzT2VTG5iGaeTGeKlO/lt7pDPnMfY2t144hZLVrof6+4zKx9Il
         GCSt/AFIz8/H3owUxh0ujtyrEohKuTvKNpLNMPgojTae56v9R5B8xtUh8oJR296cERuy
         qbPp37Iq/Bw/rzxbv1f81Is9APiZbgrooEF7jx5hMWlMjfW84xshS4ILRo+iqRgL3pEb
         hmk8yuvtEHqeXKzqC0j2wVRqKCNiiWAYYeEdSnBmW5CFCCU0OFt+BuSKZeJrMVuOnSPK
         jMJ8VGrxaR+xpRdJkbLXm59kiw2DqA9NdhD8nUbQPQbQW98I2qdXwf2nLB1Y3VKEFOvb
         RwzA==
X-Gm-Message-State: APjAAAW2UPzp98qhX7+xkOsHyXniRdXHjMpV37VkurfAG/aiK+1cWoaD
        pTtKsh0CrHBXjvvZyh8ihMZI3Q==
X-Google-Smtp-Source: APXvYqx77kz2hmAuc/xPY3cuzW5hKt6zJ/DBFTCMU7tR66QBrYt0ks8bqDlpPFjQPwD14h7gub2ymA==
X-Received: by 2002:adf:8062:: with SMTP id 89mr25345223wrk.107.1556179954511;
        Thu, 25 Apr 2019 01:12:34 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id s4sm7080387wrt.94.2019.04.25.01.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 01:12:33 -0700 (PDT)
Date:   Thu, 25 Apr 2019 09:12:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/30] Update cros_ec_commands.h
Message-ID: <20190425081232.GA14758@dell>
References: <20190424232918.243308-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190424232918.243308-1-gwendal@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019, Gwendal Grignou wrote:

> The interface between CrosEC embedded controller and the host,
> described by cros_ec_commands.h, as diverged from what the embedded
> controller really support.
> 
> The source of thruth is at
> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> 
> That include file is converted to remove ACPI and Embedded only code.
> 
> From now on, cros_ec_commands.h will be automatically generated from
> the file above, do not modify directly.
> 
> Fell free to squash the commits below.

This is going to need a bunch of Chromium reviews (and testing
ideally) before I can take this set.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
