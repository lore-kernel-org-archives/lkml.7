Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D2BC282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AEB20645
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1rw7AVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390252AbfEXJjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 05:39:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46785 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389841AbfEXJjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 05:39:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id m15so8035372ljg.13;
        Fri, 24 May 2019 02:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pLG4HwSPDeFqFoO0sL50L7Vp6hlITsqcMm3GOLkhZSg=;
        b=S1rw7AVxIco9LK6fEnDYEhZWjhsLjsaf0KZWWwQgI2dj/4gnOotXrrFy63e0XqGHZU
         /r6jKDGcZcYZY2VXAc7UxTXaHrk/LwFPWNGlp51jgXUsH6MLebUBW482GONEdj2G0PIW
         63ROnxduLs5ZSa6Uf3++Chm8Clp9XI9YOnpkjBMM4tTuZAt5a2nA2iQix2e5mU2rLjkc
         FTjyhptESjaXpN0JlWkaOEDjzdAcplXds5nEWT7PN9k4qq/3hr8F0AelWMFcE9x4SM9l
         G9lJqE10DJcWmq8IIsLRiC7sB6TUh8nHgId65ZBTVjfxAl/OpJ5Ow3F7fjIdY+qvFEy4
         XpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pLG4HwSPDeFqFoO0sL50L7Vp6hlITsqcMm3GOLkhZSg=;
        b=sb2yVv23p6ymlu9NbcyXk0u5WgkuJYJz21nh7ZCkdw1PGyGEPMZuju8cWOuN0zgKts
         q1hlG7X7iz2/bTv2jUAbJ30r3zwAREpNM5JpqX90tRPvjbpWA1eDjTWJp6tFPAjPtkOQ
         MLIXC9a4A/bXk7UTcDpuE0cIGiwd0pvP+qpg7Y2YF7zpqnXlLg9GP7zL9ZNNEDbFUTTA
         9bbJgbUHRekjom0UKwOl5r7/U3y0bzPEfR2x83xhUPqWNcmZT1fp+1dljbiwnH5R1wcm
         dwJR++W3nyi+Jt18AQVFbkNjjYLWFEmpAtIK8jpAqyR4iz7NOmy7VZQpNf17aAUBNj++
         X4iw==
X-Gm-Message-State: APjAAAVhaU2Whpjzevai+vXwIWMuQXV6Gz7Su3o0Zvy/smMlIg4EU+T5
        ikrFN45+qOHqGloh+vXcyBs=
X-Google-Smtp-Source: APXvYqyIjCahILMqH7knW6yLej57c4Hug7DNGZ788l61rXSXB7+g5mLd36evjocxtJLNdYcZLGOzjQ==
X-Received: by 2002:a2e:9b46:: with SMTP id o6mr14898732ljj.76.1558690782127;
        Fri, 24 May 2019 02:39:42 -0700 (PDT)
Received: from [10.17.182.120] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id f189sm497368lfe.66.2019.05.24.02.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 02:39:41 -0700 (PDT)
Subject: Re: [PATCH V5] ARM: mach-shmobile: Don't init CNTVOFF/counter if PSCI
 is available
From:   Oleksandr <olekstysh@gmail.com>
To:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     julien.grall@arm.com, horms@verge.net.au, magnus.damm@gmail.com,
        linux@armlinux.org.uk, geert@linux-m68k.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <1558087093-22113-1-git-send-email-olekstysh@gmail.com>
Message-ID: <b51b7d40-0023-0ddb-c00c-02ad8c5a0529@gmail.com>
Date:   Fri, 24 May 2019 12:39:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558087093-22113-1-git-send-email-olekstysh@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, all


Gentle reminder...

-- 
Regards,

Oleksandr Tyshchenko

