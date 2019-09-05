Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585F8C00306
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDED2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="G6D6hbs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbfIETRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 15:17:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37756 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730921AbfIETRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:17:32 -0400
Received: by mail-io1-f66.google.com with SMTP id r4so7325174iop.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 12:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=07l5/Jsc4rfr7mEknFKWMgXZVVL/gt11eZpE2uqlnWI=;
        b=G6D6hbs3OQCyBGac4MAnfNpozwHAPKW4Ng4nKHnqWVQpDlgoQnUNXDdJI2S6oQDv5T
         7pTWFGykQ3c5pWUA281I2jvFTgK5O0gCgG+sdjS/6Kjh/xpHNMn3rnHKxwTyqsZ7sO0w
         aahz8fVhvCckzdkQmg/d/bQA4SZ+IaoL8u6EC5CbSR7HZozoNL1BbQVUx8+3wpvNjbUg
         7jODd0oF4UIHu8nTaqMgyDmDIHMfO2obBB3Ecas1V2FEovopNENBCr+V5EmL2m03kjtk
         ZE7SoW3/SInhBd3AVcYbSS5uAbuhdL4dbSOE5Xk2YdELyeeGI4wIoONC1wDxKUe/4vgY
         9oFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=07l5/Jsc4rfr7mEknFKWMgXZVVL/gt11eZpE2uqlnWI=;
        b=V0CtR1xdNvEonx/mFVLYB5G0S98jqOK82BIOmpFuR2sD9tElxN2fO2uPxfNnnhTzOU
         PEG6f4AUS2f5Z6KQB7HaUfEumRzMZtF/JFjX6jI0h2e3F4Bky103RNNyXkRNBuNMDEC+
         fvWvKolD2EaCF96lXpcvwddk7htyIJaTXBWzCmtqKM4GNwswxKEmNYjf3lfL4HeBRvTh
         Z7Mw+x1Wl3Sl4v0P5xhlptFq7Z7Y686LqHmMp6vBvspJx7mYheFEYaCl5XgyCZwpLFEH
         D8608MW/Vy3Gishyawb7HcesZHXXjnzPpqK6136tMoSnQy9ODIsVbPl2qS1G0LRRp+5z
         1Cyw==
X-Gm-Message-State: APjAAAV5GHxvtmhzAVDBS0u6ff/pchOh+2bAhNeIq/788p23AwSRsIfL
        qpqo+YeU/NTMXMX7LT9DrTXp0Hp3ttUapw==
X-Google-Smtp-Source: APXvYqwcWd4GiAMfp6QCg6xW1thuGLMjfSkv3UpdNbv3CnPE/bFg3mZZ/plXxVEZRAtGfVTrIi1tdw==
X-Received: by 2002:a5d:8502:: with SMTP id q2mr5926036ion.287.1567711050783;
        Thu, 05 Sep 2019 12:17:30 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u3sm2537795iog.36.2019.09.05.12.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 12:17:29 -0700 (PDT)
Subject: Re: [GIT PULL 0/2] lightnvm updates for 5.4
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190905190433.8247-1-mb@lightnvm.io>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2138dd03-4969-4e02-b1dc-d8209a835a22@kernel.dk>
Date:   Thu, 5 Sep 2019 13:17:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905190433.8247-1-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/19 1:04 PM, Matias Bjørling wrote:
> Hi Jens,
> 
> Two small patches for the 5.4 window. Can you please pick them up?
> 
> Thank you,
> Matias
> 
> Minwoo Im (2):
>    lightnvm: introduce pr_fmt for the prefix nvm
>    lightnvm: print error when target is not found
> 
>   drivers/lightnvm/core.c | 54 ++++++++++++++++++++++-------------------
>   1 file changed, 29 insertions(+), 25 deletions(-)

Applied, thanks.

-- 
Jens Axboe

