Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789B1C28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C43A20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfE2J3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:29:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42208 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfE2J3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:29:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id g24so2668218eds.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 02:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6F5livGj4UyxTZEUtna3VZI7Zcp0JQNFjAQCsV6Sw70=;
        b=c7Kk69aGwLlVfO/nOUlh7UzNtD7tkmgSUB8IhwdOSMW+aBYVcg/QMEmxR7Lq4tLEAV
         bHvNkoTCX+qHVbP9zsmh78moD3stPAvIF/srQK9gi0E7GrY2OJzxp2LqlAKpq7ty9Qys
         lBrsYCvlU4GemFe1c1OEIrdgbIMWS7FwrpUXbd13pgNdFdtjzmOQHZoce4tQ3SBnM5Rg
         t/L+zTcjjgUmOgHjXCwEHWt2J6peBtHM7tK2IS4ow8JTrzATjjFN7nCImUqcZNu0Chnz
         /zqZjF9INf+nWCcRzfMy1XUEi/mPh+0c8vrRlmf6oHdN6tMtpkDgdMI4CZ+sJvGgzXqt
         +UcQ==
X-Gm-Message-State: APjAAAXqfFa7L3NvZgIAV9fLrBy3kqg4WWgpp/sOTkz7m/kYHpxZcGkZ
        SYiRvIlLj2g5A08ORce8r64iYMDn4A8=
X-Google-Smtp-Source: APXvYqyx7oJt3oeytHlo4YUghphdLsZZR4EforRPatuGOa92OU8FNKgo91Kd+vmXlx22CbsU/hQZJA==
X-Received: by 2002:a17:906:a843:: with SMTP id dx3mr35633499ejb.64.1559122152841;
        Wed, 29 May 2019 02:29:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id j23sm452331ejc.21.2019.05.29.02.29.11
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 02:29:12 -0700 (PDT)
Subject: Re: [PATCH v4 00/16] Software fwnode references
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <eb63bdfe-e863-2041-9b90-81b423f92baa@redhat.com>
Date:   Wed, 29 May 2019 11:29:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/22/19 12:50 PM, Heikki Krogerus wrote:
> Hi,
> 
> I'm not splitting this series in two after all. After thinking about
> this for some time, I decided to add support for static software
> nodes. I did not want to support them because I don't want to make it
> easy to maintain board files, but in end they make the use of the
> software nodes so much more easier compared to if we always had to
> dynamically allocate them that it's a no-brainer. The references can
> now be also described statically. Actually, those can now only be
> described statically.
> 
> Hans! I applied (hopefully) all of the fixes you proposed in v3. I
> hope you have time to test these.

I've just ran various tests with the entire series applied and
everything (superspeed host, superspeed device, DP over Type-C,
PD charging) seems to work fin, so you can add my:

Tested-by: Hans de Goede <hdegoede@redhat.com>

To the entire series.

I've 2 very minor nitpicks about the intel_cht_int33fe patches,
with those fixed, you can also add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

To the intel_cht_int33fe patches. I will reply to the
2 individual patches for which I've some remarks
separately.

Regards,

Hans
