Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64292CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389EF20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c6tp1tUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfJ3Sk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:40:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45712 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfJ3Sk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:40:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so2023408pgj.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E8M0IBPAlArHejJ6XX5v1UXLa8xJSiGac1Gi+50KpEI=;
        b=c6tp1tUG97B4a72rCmJWqDKe8kmL3UB2Gn1FDiNWEJ0RmGsMkSC6xlsr0PnyhhwOEH
         e9cZ0uoEuyuBOEKRXr6tk8+1ispEFqO3YXv2dFt53NVdkJ9XTUqOQGU2VluOYQd9vdi0
         VNsh5bQtM8TtusDnKFXJt4oW0vvVnyzNHQmfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E8M0IBPAlArHejJ6XX5v1UXLa8xJSiGac1Gi+50KpEI=;
        b=mqHPktY8of4+UDbHP5SFHNNUEGvFP/8aOqS9PzK/+ukVa2XfErWzXiYwZNOhLi2t+c
         yL7xMv+ujLzldzOCie5rTuNhbuHFoZzzxinSUOf2A7XHlWHHj94Ws54R7KGnHF+kw4mD
         RMZ3fW+7lp+Q/2docKbkput3gN3lPF7ucDJuBGcwFPAhyJ+eyt2wLmrXPMmdxKdPu1bx
         vr3WBMxhNbWIhNY304IWE0dD2xii1nvdL2wtN1FMV+5u9+KLhWraWZHvCjpZqw7owO6n
         kcqgc/5AVBGSWBQ0Jir7Q8+OZ+5E9jW9n0xFPTgDMQWxWTm220r5oHedRNAE/ONrh3tM
         i4AQ==
X-Gm-Message-State: APjAAAXfSrgyHEt2i1Cpk8S3qbXSWlhZHQMh/qZHzo/s8pAIBcnj4fAA
        ejeKNiEEum/i/BS6Xp74yoR3BA==
X-Google-Smtp-Source: APXvYqzsFhpuN5aYsddgDew/DaWnX2jBkg+SM2Kj/SEkrhulU+ZQUCz2zeLNJHoTZKNR5ecrYz5tpg==
X-Received: by 2002:a17:90a:ac02:: with SMTP id o2mr801751pjq.83.1572460857822;
        Wed, 30 Oct 2019 11:40:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c128sm628241pfc.166.2019.10.30.11.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 11:40:56 -0700 (PDT)
Date:   Wed, 30 Oct 2019 11:40:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v4 00/10] Rework REFCOUNT_FULL using atomic_fetch_*
 operations
Message-ID: <201910301139.ED3551BB14@keescook>
References: <20191030143035.19440-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030143035.19440-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 02:30:25PM +0000, Will Deacon wrote:
> Hi all,
> 
> This is version four of the patches I previously posted here:
> 
>   v1: https://lkml.kernel.org/r/20190802101000.12958-1-will@kernel.org
>   v2: https://lkml.kernel.org/r/20190827163204.29903-1-will@kernel.org
>   v3: https://lkml.kernel.org/r/20191007154703.5574-1-will@kernel.org
> 
> Changes since v3 include:
> 
>   - Add description of racy behaviour include/linux/refcount.h
>   - Fix saturation behaviour in refcount_sub_and_test()
>   - Added Acks and Tested-bys

Thanks again for this! I think this series is in good shape; I'm glad we
can sanely expand these protections.

-- 
Kees Cook
