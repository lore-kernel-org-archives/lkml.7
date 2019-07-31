Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AB0C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F88D208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcSnA+bD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfGaNSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:18:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37105 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfGaNSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:18:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so30513742plr.4;
        Wed, 31 Jul 2019 06:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uhwL5piXx8aF6MDFp0KeoIkRi/tSrSG0FpkMUYDNB8w=;
        b=lcSnA+bD0JH+vYNptcNwz2JYiVL9882K4fhLYaWfPqIYBST1F2NzD6gs1cJENFdz+i
         tYhHVFQH2NEBddswHK9G4eFvyiLsGC32lc2RG4TXAouKmV89kOvASrORmM8XJieNc275
         /v2b7vF250RvyD0dCj51TGnx/xFCE2ElcJaZdYrMjVaGs7EuBZhGijPNH2na1G6BLStX
         mTDy0B9ZvRL36WeT7uxQ1+/jJ+kqqDg8xnhHqWu3WkuEELj9f43TPLGc2RxrLrOt3tv1
         ZzQVI5KLkntvFqmTYPqcoGEA8/bO2+9gXs26yS7m3h9whENc8MocFmZ2YAjwGi4dW2/k
         Bkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uhwL5piXx8aF6MDFp0KeoIkRi/tSrSG0FpkMUYDNB8w=;
        b=kWLLX7TpKHzlPtt5CQr10JG8JIWjrk/XRRPeVfxstMAUrsb5eURw8hVorRE6RGawON
         9J6e1eihnL9BiDPxgXc97nAvuOP4EvQok6PwswLVKgz+DXAqSjcdbhopDoKTgSQBW5kS
         F6TbUFGLkPwOlMgR37xKVM8lIEbthxMt/IpsREk1ola/8zTOGHXLbuB7YPRxhTkw1WsH
         wG8nW3q/dygnfAM98bFkchopePowLD1CIgu16V6GgkNr+Dp1VgxCQx8tx3seu7QdcjWz
         lysHtXsoTobafey7+Nh+FL1s0UBxQCg5Czc3hVKpSLqrIvnoe7FxZOvFIa8aFXOj7e/b
         50+w==
X-Gm-Message-State: APjAAAWE4XVFSAHNyv+5tXH/tVJycXU2KxIK2vfwXGWVyjMcAeorUaNS
        +BWPiIltFT2gcCsnKIP7XCAwepUB
X-Google-Smtp-Source: APXvYqyZxm7zrncvEbqxeQgNtgZ976e1XdkioNQZ1x05Rs55Sl8buDxbyID8dK3I1aVQSIiGFy7Qgg==
X-Received: by 2002:a17:902:8ec3:: with SMTP id x3mr9148169plo.313.1564579092111;
        Wed, 31 Jul 2019 06:18:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h6sm65868832pfb.20.2019.07.31.06.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 06:18:11 -0700 (PDT)
Subject: Re: [PATCH] watchdog: pc87413: Rewriting of pc87413_wdt driver to use
 watchdog subsystem
To:     Mark Balantzyan <mbalant3@gmail.com>
Cc:     wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, andrianov@ispras.ru
References: <20190731032204.78951-1-mbalant3@gmail.com>
 <59b298ec-028b-7585-3477-ff4eabb27b80@roeck-us.net>
 <alpine.DEB.2.21.1907302202420.106416@mbalantz-desktop>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ca05eb5a-a3b9-419c-22ff-d4f722e1f08c@roeck-us.net>
Date:   Wed, 31 Jul 2019 06:18:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907302202420.106416@mbalantz-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/19 10:06 PM, Mark Balantzyan wrote:
> Hi all, Guenter,
> 
> Thank you for your email. Unfortunately, on my end, the indentation is
> straight and perhaps through protocol transfer there was stray
> modification.
> 

checkpatch --strict says:

total: 13 errors, 13 warnings, 4 checks, 439 lines checked

Please fix all those, including the checks, before you resubmit.

Thanks,
Guenter
