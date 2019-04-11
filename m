Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE34C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B102133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg3oDEgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfDKFia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:38:30 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:35566 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKFia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:38:30 -0400
Received: by mail-wr1-f52.google.com with SMTP id w1so5542438wrp.2;
        Wed, 10 Apr 2019 22:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=a6iAW4fu03vxxZViJv6KG/IAzyitZ4PLAoE6o4ueqfk=;
        b=Rg3oDEggoStK8n2F02bg3Um1sqmsRb9PjJY7SxLfQ8UaRziMsCMEKQwM+AJZvmpJsM
         q0V+OhQBhvU7BTxlDA8RrjTNoukMiq8mQ3rfqPkhtI+QI9cazCBj7lgy/9rctxvlbb4f
         A7tIIK3cBP59vsX1nY759zXflbBn/TSytVxOHQ+0e0OaVxXyzhAJOG2kre4d+4Ehakqn
         tBOoj7dpCwycWiRRxjkL7rAr+ZgqiRyG2TjFQhTt+GwN72zST7ba1GQZJVG6IhMjI8gp
         4o5AwqD1+Nr1OuvmaAacw8beFBrYJIsLV6vahjVsxPb7drSY9F0zteI/k/rleqs58KHe
         fsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a6iAW4fu03vxxZViJv6KG/IAzyitZ4PLAoE6o4ueqfk=;
        b=XnjZ5yO8g67ZBYnGutlgYFWr4LSJOS+STvfhuGlY2KetUwlOiBm1s6/LawNAAXCFX1
         e5exWZbHjY6bL5y9lhxYNwzb6BTEAW0kKq40k37EOLm4h8IT8HxZX9+coMzEzOSHYG3d
         OFFaqw+kJDQQuu5pBEj3v3LVkqxePfuMxeOeqrX7K50bO/ZfKD5iyAnxdSCfm6fwJCIw
         CV94l7BsSYMsGn0UdZhB9Hrc9M7O4Pp6MXLyV962xGwwQrdM0SQGY0h/YTSLDKEBEvl0
         wFZLBVu/8B3seR4/tDkkVGW12foMUmwCTFGzuxlik6hWzkJP0IOp3TJblhroko478ro6
         w7Sg==
X-Gm-Message-State: APjAAAWltIXlpVQfrRlSGSeENCGK0ZQPvAsBzhkWx7P2idWT+FsIcQBk
        Nt2p9cDoee0FYNmVRI4trm74EY2BbdI=
X-Google-Smtp-Source: APXvYqw16XNRyuJsdj7COv+fgsJstVE+mYLH7G+vQt3T1vyuA4jb+qRBMlD0SOiw64TF1pThUG7BbQ==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr28627874wrq.218.1554961108262;
        Wed, 10 Apr 2019 22:38:28 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id j7sm53776587wrt.96.2019.04.10.22.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 22:38:27 -0700 (PDT)
Subject: Re: [PATCH 00/11] asus-wmi: Support of ASUS TUF Gaming series laptops
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
Message-ID: <2b33e02e-539e-f311-43b9-85a68a9309da@gmail.com>
Date:   Thu, 11 Apr 2019 07:38:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry, just realized, I've broken the logging. I will re-post patches 04 to 11 as replies to original ones, 1 to 3 were ok.
