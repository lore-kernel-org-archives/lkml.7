Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD9EC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5F820854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jqzwCNFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfCMUba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:31:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45299 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCMUb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:31:29 -0400
Received: by mail-io1-f65.google.com with SMTP id x9so2904690iog.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9Gh+QeTa7YT8CNtbPYte6IOKqPwEGtOwA3aYp3OSRHY=;
        b=jqzwCNFHe59vnBP7X5tMr2Vg2jc1A5dg66VTPO9/Dcg0hCYJvcIJ61rXVfsUM4f8x+
         ewCQD4Pa5ybTCv0ohC9JqAxDwDwEWnUrnneCw8w1H7Bl9sxBns9m+A4G5+DMlDXAjhtJ
         JT4s2rTYckFcQm5RGfgtXPvPLSSDsUZ+iD1TFDF75Ot8SwI+tA1oiLXiEDUpX/NqNlm9
         AWTxgZO1NKsYJRbBM/kMdPhh+xmhaixdl4RVPfp88R+qvoJTDPDaKdq1mzo92j3Lt1KM
         +79BZGytgZqAc+RbPF3M7YPL3EijfS2oj1s9SGlg+giVetl+1ht5YYaThOCji/UqJUYC
         ECfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9Gh+QeTa7YT8CNtbPYte6IOKqPwEGtOwA3aYp3OSRHY=;
        b=WvGbvXuY0HFJdcZm1akzQPt6U7fiNs9gNX7Ipute+NSjVlZVBhpaXCGNtiBkgTqyx4
         GPDZRsO29FaixibruzRbsoTKiaEssKbhV/oaWYZsOp/RN17WvehXDVQb2lkCe54jXEO7
         oL+YNaFWBgwxlYihlfxo2K2rIwujEe9/t3C0Eno9bV8kwseSMiB5B9CDv2e3acFqPzh4
         Pvdgf5Df3nhXW4800TgdvAtC19FUi3lG8puqFfs5WhVXCms3m15tqL+3+VQzQz8zZtF8
         e3hhEtPUVDFUdGYhXYpM8bKLJsGWqU1Pi2aQbstVCFPprMYWxrcyi0VNp+1B9QqdNHyS
         jalg==
X-Gm-Message-State: APjAAAVk1YZhZke3JY/xprR3LG64N+Vh+QG7EZTFVMLAhiCYKTN8//c9
        m3FI4BE91CtdqZPW0VvN1BNNJCXWDSmekQ==
X-Google-Smtp-Source: APXvYqwQXXuOqn05dtkey+iiO6JmOG4NTj8Hn1X7iR15nke6UNT/7Q/rbulumaSrA+kldjMLO9Ilug==
X-Received: by 2002:a6b:e202:: with SMTP id z2mr1601943ioc.6.1552509088092;
        Wed, 13 Mar 2019 13:31:28 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y24sm4873242iol.8.2019.03.13.13.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 13:31:27 -0700 (PDT)
Subject: Re: [PATCH] blkcg: annotate implicit fall through
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190114203113.16832-1-malat@debian.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f3d51852-0cab-b6d9-90fe-0834a4219539@kernel.dk>
Date:   Wed, 13 Mar 2019 14:31:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190114203113.16832-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/19 1:31 PM, Mathieu Malaterre wrote:
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> this place in the code produced a warning (W=1).
> 
> This commit remove the following warning:
> 
>   kernel/trace/blktrace.c:725:9: warning: this statement may fall through [-Wimplicit-fallthrough=]

Applied, thanks.

-- 
Jens Axboe

