Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE46C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDAE2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qT4vb9DL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395249AbfHWO1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 10:27:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39763 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbfHWO1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:27:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id z3so5699069pln.6;
        Fri, 23 Aug 2019 07:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ldRxgJQS6I0QKjcD0nHWVCTjrbElRw3Yu8CRLOd8S7c=;
        b=qT4vb9DLjy7f+7+Nvo05drV8GPuG5ecVjyDI1mACH3DgxmQUq0EmQFkJEbPRezns4l
         8AX/TnukB0MUVrr6WT6qO04SRc3Oh0rLaNNubQ425EiXYLK7Ll4idUn56dh4qaXTNhgF
         OVaWuqnSh5vuyBVVEEsm+4fzFyJNTERKnjhf6WLptxskAiaJ1FQ54VK1599i9PWGC+UJ
         t1cHcqt1mbZGgZLv5lmRhTwxXVmPLqXZEHoYTujFBNANO03hE4sUzMi3uJmkfg3UVz+R
         Xw9Jk+hEXEUuLWjd9j32AJk7RQjIDSj7RUp9T4TeacvnvPImTfHxbqXJRqfBok+199LN
         MkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ldRxgJQS6I0QKjcD0nHWVCTjrbElRw3Yu8CRLOd8S7c=;
        b=rHPXv54IfTksoQs4PKqM3WCDSxwOWaDG+fS6R/tisXwJtGpbfCWKmzoCp9oOfbZBP8
         KZE0O5N0japyxuTbnoDDkU78qO50rFF04CaZB6IlsKlnctJFRr2I/G4GQ85dJCLfefZw
         PuSdMcmyUnFDrMOX81VJQfbgBM5saDl8YgrEMf95q9/ucARwkPQ67mYtbl8LAB+P1yed
         IOLXM38vTg1dBhrdwJTXFbLbNX0ShE+4a5rDJ06Pnd385Q3DKqrS0iEqMzffSHw2fCks
         xcZKhykdlPNLC2BywXWdm1+uzkM3FFqgy/eqKOabLw+bxaBE/Al39D/bz4xpM9Vz97c1
         9F+g==
X-Gm-Message-State: APjAAAVTEYeRICzym75B0Oj7Luipi8VSbemWXXcs+zK/0CbjKfwpR2jw
        cERNQxcPQxLJACY3rmg11NST1ZmW
X-Google-Smtp-Source: APXvYqyQxH+lk/mbnsMY9/gm9V+MoCrxoehW1nfBNGH5sNVwJitFkA1bDi4dWRFQN1A4qGjti1IWqA==
X-Received: by 2002:a17:902:da8:: with SMTP id 37mr5030928plv.69.1566570435596;
        Fri, 23 Aug 2019 07:27:15 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v21sm2695083pfe.131.2019.08.23.07.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 07:27:15 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/78] 4.4.190-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190822171832.012773482@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b1b51135-74d8-35ff-6921-631f8e0e09e6@roeck-us.net>
Date:   Fri, 23 Aug 2019 07:27:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822171832.012773482@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/19 10:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.190 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 24 Aug 2019 05:18:13 PM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 170 pass: 170 fail: 0
Qemu test results:
	total: 324 pass: 324 fail: 0

Guenter
