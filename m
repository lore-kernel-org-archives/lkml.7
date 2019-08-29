Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01C2C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0DD2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfH2RNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:13:08 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:41621 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfH2RNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:13:08 -0400
Received: by mail-ed1-f46.google.com with SMTP id w5so4840811edl.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 10:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=di8LUDxG63XQ7Xvb3E8hcpbi4JeDENkx37r4x30557s=;
        b=TvajHxpM4pEHZp1Al7YdL8SwjMfU8qeKP1V7BmwYWDzNRpEsTwhRLTAXcS4kqdZ3dG
         Agenlv0QJuMOKOYP1ywuwFFkPH0neIE0Yz5khkTodGG83MnkLK9vGgEKvj8grsohRZJR
         QxTefSlE9XsICKR110Ob4n9HEqEH6G7PkGXe1rF5T2mr5F4RgWEK0qtDtInstazCG6uc
         UYYo2/vKjHOVGdET/j6bw9SE9FIha7b/JuiCHGzkoeEzEFNy9mFl0xC/H8fve99jxm7b
         pPm7qbNu8W8GqiQ2+MXt1nHI3HqH9na3gHfiU1/r+L0f9V1OYNMmLrHi5Okj7cPxzreb
         ZZYA==
X-Gm-Message-State: APjAAAVs80ERP2zINlA2mu4ySTbWIp5rhoHIXkztZF1GGHqDfJF62azh
        L+z1+XyVHbNEDYMMW/gxCKE=
X-Google-Smtp-Source: APXvYqwNWp4EWWbghrJtatqWl4coi2+CPdJUHxDSmAc80Ju3nrSZBpwoFL+mCJQa4/IaQSXm2ndmSQ==
X-Received: by 2002:aa7:c498:: with SMTP id m24mr11109283edq.277.1567098786810;
        Thu, 29 Aug 2019 10:13:06 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id l9sm534513eds.96.2019.08.29.10.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 10:13:06 -0700 (PDT)
Reply-To: efremov@linux.com
Subject: Re: [PATCH v2] scripts: coccinelle: check for !(un)?likely usage
To:     linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Markus Elfring <Markus.Elfring@web.de>,
        Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20190825130536.14683-1-efremov@linux.com>
 <20190829171013.22956-1-efremov@linux.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <d2f8cd31-f317-1b28-fb0a-bfb2cf689181@linux.com>
Date:   Thu, 29 Aug 2019 20:13:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829171013.22956-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/19 8:10 PM, Denis Efremov wrote:
> This patch adds coccinelle script for detecting !likely and
> !unlikely usage. These notations are confusing. It's better
> to replace !likely(x) with unlikely(!x) and !unlikely(x) with
> likely(!x) for readability.

I'm not sure that this rule deserves the acceptance.
Just to want to be sure that "!unlikely(x)" and "!likely(x)"
are hard-readable is not only my perception and that they
become more clear in form "likely(!x)" and "unlikely(!x)" too.

Thanks,
Denis
