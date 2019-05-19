Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7DCC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBC820644
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jgnsc9kZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfESRh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:37:56 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:33099 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfESRh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:37:56 -0400
Received: by mail-it1-f193.google.com with SMTP id j17so171894itk.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ELOLp820iKQ5CxVO8qWkK8zW3j9TRYamyPt2iVH39r0=;
        b=Jgnsc9kZGWDhDPJ6z1gRDUsx2t2SWq2zYDJ+pf9NHdf+w8Ot+/UXZsgNVTGuz4qczO
         /2Ztc57bOMFkiQqd4f9O8wg90j7T5IEp8qENYFywH6p/hX9QSGEC+WHflRz2AzrOx2OQ
         7Ie8nVckPH9+VWe3EWl4wAtVIkRb9hfTzE8W3ZXXT5W0DGHzGfI8c0ewIGcyaFQtoK62
         4uK0od2W4rPb4mNw+DPt82OaDG6alUXhuJ8WBafV6u4lxVRvfIP7RYnzmgXTtuXvO/WT
         0K0VcIe2CHYOTfZJ/Ye6ATsK+i5i9nHtVNrOGYksLq4/Xl7gCCOi4TBivhI09PtgIf+q
         VxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ELOLp820iKQ5CxVO8qWkK8zW3j9TRYamyPt2iVH39r0=;
        b=s78bYtORRtzm1VdOO4nZwBbqId0NnSEZAINKlhwG/9CJhF9sBafu2MK/ZRhzMFqw7O
         bwS+orZ93++/Yc84NYCloKn5fHzVssuCb9irYCR8tmQrV2mAZBOIValQ7qPwMZoPVHRY
         vowROttqDJ3WjcoQMoK9lzjUNPUYWS+RdJ3lEZyHpX32P5UXkUt2Asa0VBmwV9JXoJfv
         WoUTiP8zssNuj8ehmDjyMpQ6JIATUQ1ul3b+K2pxZaC//fk4+VzRI3yw6qmpRH1Dej1w
         LIViEw3gYa/C9zJz2cBROUw0A7yPCY/3BLJUFxC4fmfgO36AzrKRbs9JKSRgCvT1qBWc
         P+KA==
X-Gm-Message-State: APjAAAW8dW3dbHiqZrrdjRK41wl3MzuXkRQyVXqQPK70XIxYfTTBH+Eq
        Zm/IQRN36RMgQjPJ6NLkwxx5BymyHg0=
X-Google-Smtp-Source: APXvYqy44vJk5cqx0zVaJDKF11lZPmL7HwwoD6nw1Roc4owDyJ5pGSxbMAFD42egtwqA7J0bLw3NmQ==
X-Received: by 2002:a02:77d7:: with SMTP id g206mr10133834jac.97.1558287474645;
        Sun, 19 May 2019 10:37:54 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id t10sm2768517itj.15.2019.05.19.10.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 10:37:53 -0700 (PDT)
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
 <eca367f2-e019-f785-509d-5662ed7b7398@linaro.org>
 <5ea0235d9fb24322681303591450b02a@codeaurora.org>
From:   Alex Elder <elder@linaro.org>
Message-ID: <d07b5488-d7e0-1e0f-f1db-90d334e51f5b@linaro.org>
Date:   Sun, 19 May 2019 12:37:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5ea0235d9fb24322681303591450b02a@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/19 1:08 PM, Subash Abhinov Kasiviswanathan wrote:
> On 2019-05-17 11:27, Alex Elder wrote:
. . .
>> Can you provide a good explanation about why these
>> definitions belong in "include/linux/if_rmnet.h" instead
>> of "include/soc/qcom/rmnet.h"?
>>
>> Thanks.
>>
>>                     -Alex
> 
> rmnet was designed similar to vlan / macvlan / ipvlan / bridge.
> These drivers support creation of virtual netdevices,
> define custom rtnl_link_ops, expose netlink attributes to
> uapi via if_link.h and register rx_handlers.
> 
> They expose some common structs and helpers via if_vlan.h /
> if_macvlan.h / if_bridge.h. I would prefer rmnet to use if_rmnet.h
> similar to them.

OK, I will name the file "include/linux/if_rmnet.h" as you suggest.
It will still only define the three structures that I need in the
IPA driver; I won't expose anything else from the rmnet_data driver.

I will mention now that, to facilitate addressing Arnd's concerns
about the portability of using C bit-fields in these structures,
I made a set of other changes (including a bug fix in one of
the structure definitions).  As a preview, here are the subject
lines for that series:
    net: qualcomm: rmnet: fix struct rmnet_map_header
    net: qualcomm: rmnet: kill RMNET_MAP_GET_*() accessor macros
    net: qualcomm: rmnet: use field masks instead of C bit-fields
    net: qualcomm: rmnet: don't use C bit-fields in rmnet checksum header
    net: qualcomm: rmnet: don't use C bit-fields in rmnet checksum trailer
    soc: qcom: ipa: get rid of a variable in rmnet_map_ipv4_ul_csum_header()
    net: create "include/linux/if_rmnet.h"

I will be posting that as a separate series now and will have
the IPA driver series mention a dependence on that.

					-Alex
