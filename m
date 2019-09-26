Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DF0C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EFC21D80
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfIZPBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 11:01:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36316 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfIZPBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:01:24 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <connor.kuehl@canonical.com>)
        id 1iDVGk-0007Pv-1P
        for linux-kernel@vger.kernel.org; Thu, 26 Sep 2019 15:01:22 +0000
Received: by mail-pl1-f200.google.com with SMTP id p8so1650228plo.16
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 08:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xtkPkpjPrpLQmsDNk7AeQ5yhyxjhIB2F104oGv/w96M=;
        b=N9dQ0UqCmLJ4ZlYM3vA/y1waFN0ymtO0z82a3KVRkpGC+RFkaDQN2g7OR5t7jTbRss
         Nj7hXgSIEpDYL89Kid1veQLwzoXM3aJwWmiV7BRQLACf9SRWw5V9TNBpZaVZasOcfJ9t
         HVV6xl8vIk+fY+8knMwfl6UNc9JCGzVQxJrLp1Jd+cZOps/3Btw77mlr9Xf6MRmuwJHs
         Vzo2dweyjz6AXEKvJKr3dvN7kCynA72Br/uL/gkjKYnuktA4/gv3Da4L/dtSXQhZZDyg
         u5zR5j3gWPS2KemcuX54DyDhQgb+sWLsoiyhZrf5k/Ddwb8Fx6a5Znre3kbU3pK2Uktw
         AikA==
X-Gm-Message-State: APjAAAUpALxt7PNhPDZdNqeBxFhjPWSZKMV6XM7ad4eGqJBYL05nFGl4
        exyrtsnIwA9AAEKjWhYvYeV10nuBsb2s2aJ+vHB6wM5/NwHCaggfl5kf18vam6Z2fTOE0Vhtxh2
        UokRZXikosbKEsOOuEuv01wxUH2agJvYBQ5TXpQOjPQ==
X-Received: by 2002:a63:cf0a:: with SMTP id j10mr3759963pgg.388.1569510080736;
        Thu, 26 Sep 2019 08:01:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy+KG/m+nUPYl05tzsMpdfhCOOO+3WkdwpahkeH8luyF61fGMjp2KK5Rg8NNxKKg+mI1gcMgw==
X-Received: by 2002:a63:cf0a:: with SMTP id j10mr3759931pgg.388.1569510080411;
        Thu, 26 Sep 2019 08:01:20 -0700 (PDT)
Received: from [192.168.0.179] (c-24-20-45-88.hsd1.or.comcast.net. [24.20.45.88])
        by smtp.gmail.com with ESMTPSA id q3sm2650205pgj.54.2019.09.26.08.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 08:01:19 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8188eu: fix possible null dereference
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190925213215.25082-1-connor.kuehl@canonical.com>
 <b725820f-525c-519b-4474-476abf004985@lwfinger.net>
From:   Connor Kuehl <connor.kuehl@canonical.com>
Message-ID: <2f07d7cb-23a1-f5c0-af9f-1c3e19a7082c@canonical.com>
Date:   Thu, 26 Sep 2019 08:01:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b725820f-525c-519b-4474-476abf004985@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/19 5:05 PM, Larry Finger wrote:
> This change is a good one, but why not get the same fix at line 779?

Ah yes! Thanks for pointing that out. I missed that. I will send a V2 
shortly.

Thank you,

Connor

> 
> Larry
> 

