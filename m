Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC03C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 12:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91642133D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 12:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oMVsLDNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfELMSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 08:18:53 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36436 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfELMSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 08:18:53 -0400
Received: by mail-it1-f195.google.com with SMTP id e184so3835567ite.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 05:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=alWOx1r6/Z9rB6PhHJXJE/9Vs78NWkWdtgi8OAKuStU=;
        b=oMVsLDNV7JrRrXgV7zMNB/Tkv3GcdtwVhUcjy+Uw0v3DU4FYiW70ltCZBRod6amr98
         a5W1/WSMaUfYd5qa5muTAhQD7yCG/T8n+gA1Bi0w4MjoJBx+PbdveT4QpdG1VW024r0S
         dmkczJFgJagkcs5kkNM8wjhwzAUlw8GBUEU9iw+hUuqnrjLvC+3x/bbysYfeWFwnl69c
         eP8iczDl0qnf+ec4XLIaZPkda1eqxYa4CVHp+UJigpJCL2j2BTR/o31m2xGZzGpiv72i
         whuy4ryTZBxHYlblbgLI7G95WoCLnATmT3dniCx1HmfoadxvmRaq4urgzd2cWBx1zDfZ
         2o7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=alWOx1r6/Z9rB6PhHJXJE/9Vs78NWkWdtgi8OAKuStU=;
        b=NXHEB6eI/wwNdpqCo3q97LRz8B8BphgRtMV74JfS9fU5gG7oHXGb0u2hvc13Rl5S86
         5uuiIHyaO+tW/UNFlnSTX/pdZ1myieJ1qd0DTBBvhr7ErNfy7XVrbJoGCp1NVLzWIYeE
         +P0SdBwWxMbkIRbR37Sn4OjFy1rxmbHV8cbQ+Br2SNFHCq9NdDZqIbqIAaHWiPYh8wWd
         l3OhgtXUOPWOMSsyBHI9Uzhjj1yzhvMeYSmwTLjliTU8Vtw7VxD0ds3Xn+lVyvE14ONC
         kNwa8+pUE0JFAdjqN0IGK3rU/wpaFn97hGTkKn+5t+g+skbNue56uSypS02VCyRIZoDR
         eo8A==
X-Gm-Message-State: APjAAAXluOgXpvvqd5ygEHsxYbYj0HFtMRfZLzuNYPa8B/EHfH6IPt+W
        8VB+4OQfSrPiFP0aB+tw2Ws74/RQ+G4=
X-Google-Smtp-Source: APXvYqxihnvC2ZjLEUeYlaZi/P7dBilIn07WBMKuDLDh/A/+sIm6p1ME1z9CsxxScalUJuYM+SCQQg==
X-Received: by 2002:a05:660c:a8e:: with SMTP id m14mr6500980itk.169.1557663532402;
        Sun, 12 May 2019 05:18:52 -0700 (PDT)
Received: from [10.21.60.184] (hampton-inn.wintek.com. [72.12.199.50])
        by smtp.googlemail.com with ESMTPSA id y18sm6278425ita.3.2019.05.12.05.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 05:18:51 -0700 (PDT)
Subject: Re: [PATCH 01/18] bitfield.h: add FIELD_MAX() and field_max()
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org, johannes@sipsolutions.net,
        andy.shevchenko@gmail.com, syadagir@codeaurora.org,
        mjavid@codeaurora.org, evgreen@chromium.org, benchan@google.com,
        ejcaruso@google.com, abhishek.esse@gmail.com,
        linux-kernel@vger.kernel.org
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-2-elder@linaro.org> <8736lkji6e.fsf@codeaurora.org>
From:   Alex Elder <elder@linaro.org>
Message-ID: <adede2d0-c271-259d-a452-39f54f4895c7@linaro.org>
Date:   Sun, 12 May 2019 07:18:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8736lkji6e.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/19 1:33 AM, Kalle Valo wrote:
> Alex Elder <elder@linaro.org> writes:
> 
>> Define FIELD_MAX(), which supplies the maximum value that can be
>> represented by a field value.  Define field_max() as well, to go
>> along with the lower-case forms of the field mask functions.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
> 
> Via which tree is this going? I assume I do not have take it unless
> someone says otherwise.

Sorry about that, perhaps I should have posted it separately.

I don't have an answer, but we could avoid having to coordinate
if it went together with the rest.

					-Alex
