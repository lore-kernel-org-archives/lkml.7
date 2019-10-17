Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A65CFA3728
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC8D2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYvJATFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407415AbfJQCmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 22:42:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42115 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407367AbfJQCmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 22:42:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id q12so607993pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 19:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w50KpVZhAwyoQK+bFJNDVlkqktJRIaTp8AHjS4MyY98=;
        b=wYvJATFs5UC+eRpmP71Wq2XbCsR7tcsWHcxFtdlx3c/ZSrm8bDgLAiP2yBfljypLH0
         jKTu0T9H+JxZgjiQCrFfL2ilZsRKKhNzw+ony7qUMN8c07VnWuTqlc/PHDNuRs3dKxtm
         vdkmkFyJ6LnEDEvXMJczBtvyQJ68Apm0HiZLT4Z95iPTJk2+Fu1c6qNv/mVoDZIlyhBr
         l+h9iFJyWXf+p11sj92brHslhxdk5mFiV16tMXkZVPag0e2XV57RukfnOLlyOtVK3DoM
         rnqnSE+IrVb7+KEKe9fOUzQsXPo07DOHEXynMuhZJtnw7CwNQ+XuCMCxGtOONbN2EpS2
         pNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w50KpVZhAwyoQK+bFJNDVlkqktJRIaTp8AHjS4MyY98=;
        b=dCyLMSy3Zg0gd2/ZacrMgsES7j/E4pCG67O7X8ZsFK6cRoJ62JYSlZh2MQqeZCip5G
         ODWbVhBY+rj4SsBIhR2d0TRns+hvOKiXxVa3qRk40M6Ou7mf+AP4vN2PzYR1TGpnAWc0
         1iluI1QVn2S14IFIKvvYD3ZxwNaTcmGO9V7PoGgkAR7SySMv4LM3yGHZv3Bf+nogiAP2
         jb8nrjTxqSSPFBoApHV4VJTh5UBH2TBhvkbSSTwdnFQ0dLeJRV+z6hFYJN7/wVP07V7T
         LvW18WvRk8N3F3wyJu/UaPvFPGjsnheQU1JRbwHrGnpWy8h9eNOWeU0rJl3goRKUN2gG
         f9Qw==
X-Gm-Message-State: APjAAAWwuDpX13/iMLfSmE2+IJD9EZjcuhoj/fe2H0EQHlDWLLSVyaCb
        FLA45PUpEJ/2/zPHE/qHdbvGq42C/Ho=
X-Google-Smtp-Source: APXvYqy5bLPP7KyCo0QyKqOM7/aGjivBgkppI0PnQog7qm9zHjIGh6aAtVvKURTYzLJCTCNI22l7xQ==
X-Received: by 2002:a63:4e52:: with SMTP id o18mr1453491pgl.153.1571280122797;
        Wed, 16 Oct 2019 19:42:02 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id 192sm481026pfb.110.2019.10.16.19.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 19:42:01 -0700 (PDT)
Date:   Thu, 17 Oct 2019 08:12:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cpufreq: simplify and remove lots of debug messages
Message-ID: <20191017024200.3hhak2wx7yvjifqh@vireshk-i7>
References: <20191016110344.15259-1-sudeep.holla@arm.com>
 <20191016110344.15259-4-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016110344.15259-4-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-10-19, 12:03, Sudeep Holla wrote:
> cpufreq_arm_bL_ops is no longer needed after merging the generic
> arm_big_little and vexpress-spc driver. Remove cpufreq_arm_bL_ops
> and rename all the bL_* function names to ve_spc_*.
> 
> This driver have been used for year now and the extensive debug
> messages in the driver are not really required anymore.

This does lots of cleanup in this patch and not strictly what the commit log
says. Can you please create separate patches for remove ops, debug messages and
other formatting things ?

-- 
viresh
