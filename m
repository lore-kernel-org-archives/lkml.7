Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617E4C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4EC20651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfHSMqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 08:46:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbfHSMqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 08:46:36 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52FFB81F1B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:46:36 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id f11so2022701edb.16
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 05:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kCAaddVgeznK4PngVFK9zXSlJa5AIyvpQy+Wi3IZfM0=;
        b=O/I9cidcaR3jLFTEbQemzMPqcfS2+aNuWeZzCrYS/L+uBFajOPr8yiDRiNUkMQeEEp
         ZXZSgv7bBUauJqtc1UGePftryo+SczqIWDYqxUeYsIjulKav3f+iI+OMDS6an4KGoQHL
         PPzzImwqcPtwAeZ6Ru0nVSOpL811x+rmLEBHPqbjRqKPO7++gQ7iHJaW0RW5YlhSvhwn
         e//n3KhNRWM/nqD9M2KZ9PGu77m5Gb1gAGh2TEB4mPlaSfwiJKo9dc440S/NscUfjiFk
         wIJBT7FemFph06+6rN0OrLP4rwFTwgPIYhk/iioK2uSR8Ff6/npvxbdsclMybW3g3nq2
         qcPQ==
X-Gm-Message-State: APjAAAVprB4DK/vus87mcyv2/dku2aupj7JKLxdSxnhks/K9LG7RwhqY
        qQ8v4hZWiuunQLu0i1JIpU3gipHjMZIIuuznsgkGxCTr0AH9kbMPVV8RDdFl0N2m2anT3TFuy7a
        GXwTBdAjdZeBHJGhWu0TAVeWK
X-Received: by 2002:a17:906:1346:: with SMTP id x6mr18675923ejb.163.1566218794532;
        Mon, 19 Aug 2019 05:46:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyqzdv7pDK6sSo5KVRB/wsbxwR1bJ/Qc+6PJRrugooEE712ygegBWYj0RmzxI7b2CwLqx6rmw==
X-Received: by 2002:a17:906:1346:: with SMTP id x6mr18675901ejb.163.1566218794260;
        Mon, 19 Aug 2019 05:46:34 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id m17sm2072311ejc.91.2019.08.19.05.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 05:46:33 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] software node: Introduce
 software_node_find_by_name()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20190819100724.30051-1-heikki.krogerus@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5717e1e8-ffd4-e97c-0837-70b30391020a@redhat.com>
Date:   Mon, 19 Aug 2019 14:46:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819100724.30051-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19-08-19 12:07, Heikki Krogerus wrote:
> Hi,
> 
> There was still one bug spotted by Andy in v2. The role switch node
> was not removed in case of an error (patch 2/3). It is now fixed.
> 
> 
> The cover letter from v2:
> 
> This is the second version of this series where I'm introducing that
> helper.
> 
> Hans and Andy! Because of the changes I made to patch 2/3, I'm not
> carrying your reviewed-by tags in it. I would appreciate if you
> could take another look at that patch.
> 
> I added a note to the kernel-doc comment in patch 1/3 that the caller
> of the helper function needs to release the ref count after use as
> proposed by Andy.
> 
> In patch 2/3, since we have to now modify the role switch descriptor,
> I'm filling the structure in stack memory and removing the constant
> static version. The content of the descriptor is copied during switch
> registration in any case, so we don't need to store it in the driver.
> 
> I also noticed a bug in 2/3. I never properly destroyed the software
> node when the mux was removed. That leak is now also fixed.

I've just given this series a try on a device with an ACPI
INT33FE node describing its TypeC connector and the mux is still
properly found and controlled.

So from my pov this series looks ready for merging.

Regards,

Hans

