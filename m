Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB6BC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448CA20645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxF6qb/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbfFXRGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 13:06:20 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:32814 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbfFXRGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:06:19 -0400
Received: by mail-io1-f49.google.com with SMTP id u13so2082521iop.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 10:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iIXdeX2JiRmx4C9yHa4fiJw6+gLhZXZOz5wFmnOuZdE=;
        b=jxF6qb/sV7LdwL/M+hfpYLQ7N5FXZV6n9NR3jTyAGA+GplqKPu7nlY6GaDSV5WogpJ
         x5eIKLRlaYb94Or4C1um7mn7WyMOo4dBdef5p/nzVyUgjbyXrx8JH7EhAEca6FLfEfje
         nyB4Moc3cuXQ0mGOOtjDIj4Yowe3z2ODg6M4k2rpxg1D/1N9whY5BWQw6//5kdkEdi++
         Omw24Pvpq26FKnGtYJzLgnIvZHvyge1Woqy//RM3pArEUqeRr720cxBaRtcWL83at+Fi
         iFRy/xrZO9pexKsKLe8Zyr1lGXPKKen7I1pj+mLedfcptv9lvd/L17l65g1nM3cIwimg
         3tOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iIXdeX2JiRmx4C9yHa4fiJw6+gLhZXZOz5wFmnOuZdE=;
        b=mImseNspFBgxJyWL+zF6vt1G2g7AZ0L2Gy/PbmbMUjHk+YMq4egsvxveSK1rn8tncB
         3yGDEGkJMEvR9SFtomOnaY4lHkqXA8VkZ/J9QtIJnyrllPNWCWNqyV0R69oD83lFuKhG
         MNoGH4mF6bMx8/iZVxhMXaZ4iJFMmQcQAPmgamUF2M3hgmH+/T4achtnNh9P9UTFjHoO
         nn+PsRJjIRL+NxEVAOKYTAED6+8dsHPJ5b14duO7WugYvpZKH9xLCeJViKPb1LVBNDd8
         /JDnNYTbkUd17UYTra2CnTlHqF9hcaSNbO6usQ2KaxtdfaPFhH2/1YXsbJ1l8IEjiBMB
         0T3g==
X-Gm-Message-State: APjAAAUDSjkENq8AmrmQEB620QWUx+XqRfUDH+5IFYDbt+394fi2sVNq
        56HXj6ov2Cb1FhLhS/diHREuaw==
X-Google-Smtp-Source: APXvYqzVK8rqKQbqdwhHrTlxmKezzfLMdoJwvbpSG0OfjEOVBy5BTJ9p5dUhS23rTre1cQZCfpntYA==
X-Received: by 2002:a6b:8bce:: with SMTP id n197mr18564360iod.299.1561395978680;
        Mon, 24 Jun 2019 10:06:18 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id z1sm24593121ioh.52.2019.06.24.10.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 10:06:18 -0700 (PDT)
Subject: Re: WWAN Controller Framework (was IPA [PATCH v2 00/17])
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org, Dan Williams <dcbw@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        cpratapa@codeaurora.org, syadagir@codeaurora.org,
        subashab@codeaurora.org, abhishek.esse@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20190531035348.7194-1-elder@linaro.org>
 <23ff4cce-1fee-98ab-3608-1fd09c2d97f1@linaro.org>
Message-ID: <6dae9d1c-ceae-7e88-fe61-f4cda82820ea@linaro.org>
Date:   Mon, 24 Jun 2019 12:06:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <23ff4cce-1fee-98ab-3608-1fd09c2d97f1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I neglected to add Dan and Johannes--who have been
primary contributors in this discussion--to this.  Adding now.

					-Alex

On 6/24/19 11:30 AM, Alex Elder wrote:
> OK I want to try to organize a little more concisely some of the
> discussion on this, because there is a very large amount of volume
> to date and I think we need to try to narrow the focus back down
> again.
> 
> I'm going to use a few terms here.  Some of these I really don't
> like, but I want to be unambiguous *and* (at least for now) I want
> to avoid the very overloaded term "device".
> 
> I have lots more to say, but let's start with a top-level picture,
> to make sure we're all on the same page.
> 
>          WWAN Communication
>          Channel (Physical)
>                  |     ------------------------
> ------------     v     |           :+ Control |  \
> |          |-----------|           :+ Data    |  |
> |    AP    |           | WWAN unit :+ Voice   |   > Functions
> |          |===========|           :+ GPS     |  |
> ------------     ^     |           :+ ...     |  /
>                  |     -------------------------
>           Multiplexed WWAN
>            Communication
>          Channel (Physical)
> 
> - The *AP* is the main CPU complex that's running Linux on one or
>   more CPU cores.
> - A *WWAN unit* is an entity that shares one or more physical
>   *WWAN communication channels* with the AP.
> - A *WWAN communication channel* is a bidirectional means of
>   carrying data between the AP and WWAN unit.
> - A WWAN communication channel carries data using a *WWAN protocol*.
> - A WWAN unit implements one or more *WWAN functions*, such as
>   5G data, LTE voice, GPS, and so on.
> - A WWAN unit shall implement a *WWAN control function*, used to
>   manage the use of other WWAN functions, as well as the WWAN unit
>   itself.
> - The AP communicates with a WWAN function using a WWAN protocol.
> - A WWAN physical channel can be *multiplexed*, in which case it
>   carries the data for one or more *WWAN logical channels*.
> - A multiplexed WWAN communication channel uses a *WWAN wultiplexing
>   protocol*, which is used to separate independent data streams
>   carrying other WWAN protocols.
> - A WWAN logical channel carries a bidirectional stream of WWAN
>   protocol data between an entity on the AP and a WWAN function.
> 
> Does that adequately represent a very high-level picture of what
> we're trying to manage?
> 
> And if I understand it right, the purpose of the generic framework
> being discussed is to define a common mechanism for managing (i.e.,
> discovering, creating, destroying, querying, configuring, enabling,
> disabling, etc.) WWAN units and the functions they implement, along
> with the communication and logical channels used to communicate with
> them.
> 
> Comments?
> 
> 					-Alex
> 

