Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF983C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C243E2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X8fF3kdK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X8fF3kdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfKPBTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:19:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56578 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfKPBTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 20:19:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BE25761060; Sat, 16 Nov 2019 01:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573867153;
        bh=LFJEZ89g9PtHzr8dEUbLwSgKkc9eHaTVdtduLL6yNhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X8fF3kdKLWt5NcPJYOzjxQNs/X3VQ58qCsECnzNs853fcEHqMHkUDp8LvWRrny/Pd
         CUuiWROVGC/74NI27lvj8bhJ/TsowflobwcP0ySfuHPUgD7CniX6Vovk37HCywk3XW
         6tt65uAG2iIz6583JEZ3PnqqUaIIq2/TtAlETn28=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1D96761015;
        Sat, 16 Nov 2019 01:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573867153;
        bh=LFJEZ89g9PtHzr8dEUbLwSgKkc9eHaTVdtduLL6yNhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X8fF3kdKLWt5NcPJYOzjxQNs/X3VQ58qCsECnzNs853fcEHqMHkUDp8LvWRrny/Pd
         CUuiWROVGC/74NI27lvj8bhJ/TsowflobwcP0ySfuHPUgD7CniX6Vovk37HCywk3XW
         6tt65uAG2iIz6583JEZ3PnqqUaIIq2/TtAlETn28=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 15 Nov 2019 17:19:13 -0800
From:   eberman@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        saiprakash.ranjan@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/18] firmware: qcom_scm: Rename macros and structures
In-Reply-To: <5dcf345b.1c69fb81.df1ea.f7f6@mx.google.com>
References: <1573593774-12539-1-git-send-email-eberman@codeaurora.org>
 <1573593774-12539-2-git-send-email-eberman@codeaurora.org>
 <5dcf345b.1c69fb81.df1ea.f7f6@mx.google.com>
Message-ID: <4b63daf69f7b49ce8304b5cd85e39b22@codeaurora.org>
X-Sender: eberman@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-15 15:27, Stephen Boyd wrote:
> ... to here I don't understand why any of it needs to change. It looks
> like a bunch of churn and it conflates qcom SCM calls with SMCCC which
> is not desirable. Those two concepts are different.

I can see the confusion. The goal with this patch is to make it more 
clear which
macros and structures are for SCM interface from those which deal with 
the
implementation of how an SCM call is implemented with the smc 
instruction. It's
not presently clear that struct qcom_scm_response (for instance) is only
relevant in the context of legacy convention.

I choose the name "legacy" since only older firmwares use it and having
"scm_buffer_get_command_buffer" seems even more confusing to me! "SMCCC" 
was
chosen for lack of a better name.

Additionally, the concern with having qcom_scm_ prefix on these 
functions
(especially legacy_get_*_buffer()) is you get long function names which 
didn't
seem desirable. If the long names are preferable, I can update series 
with the
longer form of the names.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
