Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B440C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCE3217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lgxd4mD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfEIRhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:37:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39104 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfEIRhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:37:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so4170546wmk.4;
        Thu, 09 May 2019 10:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QvLnzxjMY+c9tJc5WpZYCSDDpAWjs4cZZaO4mXG/cHk=;
        b=Lgxd4mD0rK22HIWdGOpYPOqv3wqbZ+/hPlQulzYFI5f3R9UD7reWQeOHn1R5kDxo+Z
         kMZfiYm5rGgU7H+LUVym7L8GLAfK0/g8Dag2KwrAWhm4Z4EV8jc6e7rjzAIIQTmQyIUQ
         EP9WVdrWM7vJS9ieLOchG7EaCJZ5W2Q1GTESc0MZswD52mxl6414BB5Tmmru8rbd/3wv
         1FPwfI+sCHsVM8RKn1ATnPRVOZS95kc83XVoIyekWV/xxns57cZVlH8Ly4WXRsFzYZyb
         Xx6A5HEEAAH9c0zNYkKPVJsfBOyTREN08mj04ZGpg0uekoWBBCbBH9WOPiwXdr6llvqt
         rzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QvLnzxjMY+c9tJc5WpZYCSDDpAWjs4cZZaO4mXG/cHk=;
        b=MS8fpxj1qou5uYMqe1mpV7d3HoR+wv36GuCzly9hq13jAi1CT/xZ4FL6EtifHa22Wb
         K40KoyPm2PoLrrYOCo+STS6oIeXMZxWTxQlEZp0jD2J7Iva/iRTsIRl095uBS0kTqX4w
         Lp4U+wxY6DlHXhAQ18Fv9eyDqkHdhQh9dy/1gAZxHot4sqVEyiyFGW/f6bAmjC/KM/M4
         iww8aBzMmmK+8BSMlo14YOKeH9rarvyu09q1kFs0OCywFwrZm+mYjJA4ZC4HBCKSrMPr
         SMcNka0p4M7O0i/PZu+SGeCXiolQVOBZ1GsOgxQN5zTvId+M76/LpDHOTF8LbY0CrYe1
         ttyw==
X-Gm-Message-State: APjAAAW/NxBa45dJhNWP4KRsMqQGXzGF8UNPdpkTlt8FrLz2kidNnvMC
        RfGEnF70pHUr8mJ3c8LmejAqZPq3
X-Google-Smtp-Source: APXvYqxtBMhBX6aUynTnfhg8mPMQfK/Hehu0bNq8mD0TyENMZHjkpFXjYCsG38NN8wN0D3qkRitUNQ==
X-Received: by 2002:a1c:14e:: with SMTP id 75mr4071677wmb.100.1557423422996;
        Thu, 09 May 2019 10:37:02 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id k206sm6498440wmk.16.2019.05.09.10.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 10:37:02 -0700 (PDT)
Subject: Re: [PATCH v3 05/11] platform/x86: asus-wmi: Support WMI event queue
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
 <22dc9bfe-af2f-7ea9-e5bc-95647d5411a8@gmail.com>
 <CAHp75VdRE8C=ZODLuKC0JktKv4rbw_Y4fOA4J5wBYKPU+URK+A@mail.gmail.com>
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Message-ID: <5968d688-dc40-acad-bd73-8fe26cf14979@gmail.com>
Date:   Thu, 9 May 2019 19:36:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VdRE8C=ZODLuKC0JktKv4rbw_Y4fOA4J5wBYKPU+URK+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.05.19 15:47, Andy Shevchenko wrote:
> On Fri, Apr 19, 2019 at 1:10 PM Yurii Pavlovskyi
> <yurii.pavlovskyi@gmail.com> wrote:
> 
> It's rather a big change. Can it be split to smaller pieces?
> 
I will then split this into refactoring event code handling in separate
methods and actual event queue support patches.
