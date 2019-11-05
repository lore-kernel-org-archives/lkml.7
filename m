Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E95C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46740217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="YC3ddAr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390018AbfKEP4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:56:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40687 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389032AbfKEP4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:56:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id 15so14529435pgt.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 07:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XJsNFwwu/Jlc0782LDjp8YTgvefXfXVL1aCF2AU/E8g=;
        b=YC3ddAr4UdMhHKju55t/KzWOVycmq5e0nLbh8V+2V27jOLCD1mPETt2q2qkDMtFvXk
         b9j2uAop9Xq2J/+zt+LlJ4WrHmrLjL8IUXPrTvGC2YqgjNVPVATP1yeOWf8OR5n6It1u
         iADfOJ5OXYpcDOkKEI4IHSj7dD4N4wVECKIdfev45eXq1eAR9l71SWPvaYo/sQn7tVO2
         yjXhAairdX8rx49VY1RR9SVQjOHSSyXJwKw0VIU+Z8gZgSEhmVbiA/nf+FA2Asu66oMe
         k5m3GIymIo6mP74AOUIsh6+Qd27uJz3gK32eIlcVUf210WxtTIlBoqc3pDdN82ytGfYN
         2TDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XJsNFwwu/Jlc0782LDjp8YTgvefXfXVL1aCF2AU/E8g=;
        b=aAJO0eCdywnxWVJpYhr5uYZrIhODluC+i7Vy2HG/Y+kHHoQQ5D65WqE0KNBmfhj89E
         Op3smgxgbJikNBNAnIaVn7xuS2//F/IiN1tbWU4iMPShUKYKBVLBsE8fpGWjgb8Gy9Wa
         41GVwDneIW3EkHNT7y4L0Jp9oTZQAW5lu18Kg+fJdjJW+GFL+ktJ0tW/KJctscmLtI5x
         UVHW2dq6t+NX04r5GfbIAngSf/zfkZ7WYh/kPmiJo0DCfzA4wJD5YbDQWsQdHrGgtAq5
         J4tscqeW2iS5SAuWqH6Z3cliaBTKLN/webbqFFGLDZHxOjuznMzQFejn5wNA+XFXCI/J
         +Omg==
X-Gm-Message-State: APjAAAWjxZZIK/Z1mxPKLPglq/5sdgoUqkkUtnn5nopAg4NfPro6rOby
        E2rKj0n2WLZ/BHnI6WOH0ghf7Q==
X-Google-Smtp-Source: APXvYqx865TcFioge9LAZA+i1UxRYOyJHhiIep6k07mIyKrFbOEQ1QQaUbGriZKXguMbJA39nlmSZQ==
X-Received: by 2002:a65:6482:: with SMTP id e2mr3901602pgv.20.1572969389855;
        Tue, 05 Nov 2019 07:56:29 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id x2sm7984553pfn.167.2019.11.05.07.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 07:56:29 -0800 (PST)
Subject: Re: [PATCH] afs: xattr: use scnprintf
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-afs@lists.infradead.org, Jan Kara <jack@suse.cz>
References: <20191105154850.187723-1-salyzyn@android.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <2e530f62-89bc-4314-8e78-e5cc049c5d69@android.com>
Date:   Tue, 5 Nov 2019 07:56:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105154850.187723-1-salyzyn@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/19 7:48 AM, Mark Salyzyn wrote:
> sprintf and snprintf are fragile in future maintenance, switch to
> using scnprintf to ensure no accidental Use After Free conditions
> are introduced.

Urrrk Out of band stack access ...

-- Mark

