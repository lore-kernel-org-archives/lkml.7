Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F4DC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023882168B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mb62EaGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfEQR1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 13:27:17 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50601 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfEQR1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 13:27:16 -0400
Received: by mail-it1-f196.google.com with SMTP id i10so13225133ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 10:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M48MIzsMtIW3RacnfhHRKOC/99zIJyrXj5URZcQXnyI=;
        b=Mb62EaGBDi+zgq4OJCbYqI25W1D+k8N/zl8pupco6beQ9tQWnRV6zIlDgixtlToUsK
         TZXhkUfnxXnXBvG8byqgWgfM6NhlkuKufSiSII4bUNikq0weX+Jo8tORoTEl2npkAbBm
         UuIJFpp44i0wyTMihH744Hr9aofWl4gHu1MNTw8g0dD7/RhkgBRynmBVmBNHaxHpNqYV
         PeM/yc0skXicDgZ3pL9F4FtoTW7HfydSdMLaGzbww1GS4DpGFdbNXWvCmk1Xe1KVIq5/
         rjEpSkjIS0Aie3xqRrn2DWc3bjNTW9CbhJ9QKR+NHkTaYYNvqY5xp7ah6HYW+1+N9q73
         3jHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M48MIzsMtIW3RacnfhHRKOC/99zIJyrXj5URZcQXnyI=;
        b=md1FkLi+A+3MUr8KRFFUZMc1IZoyf3og90yj7zDLuo/vE88ZLCQOKNhdNP0rINmzzn
         TEOqTTlxuwcOkIyYxMUCyUj2REJiTHU4s5Pi5GY/ff/yztE4Uq9XBn5pMeU+0wEMwTbc
         +LDDIKNpf5O9ZGm6JuKiJ9lVDyNDqWXDWoPIWuxoS3YoCFQOVOn7gUrIF1GqlcZ316z8
         2eEdTiyvpBztLMLROPa0i62NxtybPMWA42vwnMt75AqtnisgqLS5jLU4HHLShYkSOBpL
         V7yT1lbYigkEf6YjUsjPoNblExCG15xY3fU7I0dTw2fS9B9DmG8cS8WZXqWvAEhvS93X
         SC2Q==
X-Gm-Message-State: APjAAAW7sYjlNxEY7vg9aM5E1x6RoznQScR0/D9etZ0xa5L6pQckTW8i
        fcNsImf5GHcE2jwnLKPdO1jmNiF4FD8=
X-Google-Smtp-Source: APXvYqwo8SJb/axA1pQtMm5VqXyN9K90ok/ZPdTR78ey1GZqc6MTdnRryPfuQHrwA06lDZ9cL5NFRg==
X-Received: by 2002:a24:f946:: with SMTP id l67mr3525196ith.43.1558114035406;
        Fri, 17 May 2019 10:27:15 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id v134sm505362ita.16.2019.05.17.10.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 10:27:14 -0700 (PDT)
Subject: Re: [PATCH 02/18] soc: qcom: create "include/soc/qcom/rmnet.h"
To:     Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        stranche@codeaurora.org, YueHaibing <yuehaibing@huawei.com>,
        Joe Perches <joe@perches.com>, syadagir@codeaurora.org,
        mjavid@codeaurora.org, evgreen@chromium.org, benchan@google.com,
        ejcaruso@google.com, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-3-elder@linaro.org>
 <CAK8P3a16HpKEUB7_6G_W_RKkyVeVBW_rofLbdhC2QmWjVOAHMg@mail.gmail.com>
 <9cae00c4-29ab-6c3e-7437-6ed878a3061f@linaro.org>
 <005ae8fb4ea9ba86fd0924b1719f1753@codeaurora.org>
From:   Alex Elder <elder@linaro.org>
Message-ID: <eca367f2-e019-f785-509d-5662ed7b7398@linaro.org>
Date:   Fri, 17 May 2019 12:27:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <005ae8fb4ea9ba86fd0924b1719f1753@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/19 8:09 PM, Subash Abhinov Kasiviswanathan wrote:
. . .
> Hi Alex
> 
> Could we instead have the rmnet header definition in
> include/linux/if_rmnet.h

I have no objection to that, but I don't actually know what
the criteria are for putting a file in that directory.

Glancing at other "if_*" files there it seems sensible, but
because I don't know, I'd like to have a little better
justification.

Can you provide a good explanation about why these
definitions belong in "include/linux/if_rmnet.h" instead
of "include/soc/qcom/rmnet.h"?

Thanks.

					-Alex
