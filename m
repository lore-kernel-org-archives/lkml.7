Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456ABC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111B720850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6Mwh0aB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDJWPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:15:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41724 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJWPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:15:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id d1so2236937plj.8;
        Wed, 10 Apr 2019 15:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/ME8UCRPhLKhI9XNsKa0H08evJ48xzJoLZLWFynyGu0=;
        b=D6Mwh0aBjutAgUD2QUITwrHNkJkqtxoQ1HEleQv0XZQMhon+Mf9eCY7kuBrCiVkIW9
         d7WK5cS1VPY2VkualAes2LtqGALrVEMtZq9K4SpLc6VzLRA4cSev3D+UfVYFNk4JoecU
         RselPOb8n+nlbd2xvtvUcDkt1cBEf/msq5e59nunnu+y45VeXVKeUqeNXBhzAYBH9yXw
         L07nCZpBmqcozHap682ruHaPhVuYG9P7VUNeMJlD0Uv4s3uxPsWNWn0z7zPf6huT+wAy
         PtbmkozCoME3EA3SEPoCfyEiJzO0NbD2FUCp0CFhJt4m/AayqJ1scoo3NZQeUFhCsR3c
         Q5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ME8UCRPhLKhI9XNsKa0H08evJ48xzJoLZLWFynyGu0=;
        b=fAOykvH+GsfYMCF3EyLk+xXtgcysNwmw4FtVfMNL/esF2aMVJQ2nghSzccUvpVJy0p
         cPtjVFZAJIPsSrZ56rMEaWMYiU8/F0Qd/3YQyAr/ETQ/liNtBykRMGHyUWehwLUwQ/xR
         wrT3jAeoyWZfvsMPc1aUjPP+GB3qwfVOnvjsYIm4jHhgw85LSDqvjpFM76fgCt3Wy6lC
         w5eWJXGuQk+i+WR5nOsVKyOmiywBMljVXMEIzKoSS77sw7W00kIN5VS3S6wJ1O4HQ0aW
         P4pQZOoN0UA1WjH5dL7FzLaCQ0NqUYi8pRvblV72yhnur2Yqzqe2WD93zGrTjVb7cxTN
         EPfA==
X-Gm-Message-State: APjAAAWfWG54PxN3zxdsDhZSAow09nHaLyIaelq45LFkMw3zly3XHZXZ
        a3rd2ZXAqPD+oa1IqVOtxcA=
X-Google-Smtp-Source: APXvYqzYBf7usmuy3j2uN6zwXsXbAXl42EVsECaWOC0ol2VHrVndnIQuGWYNvV0sm12TkGAAKyTQhw==
X-Received: by 2002:a17:902:b602:: with SMTP id b2mr47138995pls.293.1554934516181;
        Wed, 10 Apr 2019 15:15:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2sm113952543pfi.73.2019.04.10.15.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 15:15:15 -0700 (PDT)
Date:   Wed, 10 Apr 2019 15:15:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joe Perches <joe@perches.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 18/22] watchdog: mt7621_wdt: Use 'dev' instead of
 dereferencing it repeatedly
Message-ID: <20190410221513.GA28441@roeck-us.net>
References: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
 <1554913683-25454-19-git-send-email-linux@roeck-us.net>
 <e76117d45b1b1caff6bce8d28506e683694d6a79.camel@perches.com>
 <20190410195409.GA29802@roeck-us.net>
 <e735fb3399d9fadf75216ef5cb4a7f55d1f336f3.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e735fb3399d9fadf75216ef5cb4a7f55d1f336f3.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Wed, Apr 10, 2019 at 03:10:09PM -0700, Joe Perches wrote:
> On Wed, 2019-04-10 at 12:54 -0700, Guenter Roeck wrote:
> > A checkpatch rule suggesting that multiple extension lines can be merged
> > might be useful to help finding such situations. Just a thought.
> 
> You are welcome to try to write that one.
> It's likely not a trivial task to make it sensible.
> 

No chance - if _you_ think it is difficult, it would be absolutely hopeless
for me, and I am not going to touch it.

Cheers,
Guenter
