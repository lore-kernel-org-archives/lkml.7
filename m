Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB53C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401402080D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Sz+/fCjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfLISC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:02:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37135 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLISC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:02:58 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so828487plz.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 10:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0YsPAtOD2B97kYz+aPx1oxns46408201TPj5O/tIazQ=;
        b=Sz+/fCjqYOiJDd/7AcP5OSR6UajygLGcCbKT5Stg6Oz8XAY2WmjrCBd/m1SYfnEEnQ
         Luf4Qn4e2hwf+WkdL15QyOYY1iVTaWzz1KevnrW4qtzYHKf6a4LyKSwXUu4niXhRVQmh
         sjoLhkzMwb2ozNPJAIJsygJ6dLZ8T+Peg0Xb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0YsPAtOD2B97kYz+aPx1oxns46408201TPj5O/tIazQ=;
        b=GZyMevfNw0cm87D+B3yRsdDs9Gm63cbc60ORxw/aBKJAz77Iq5szVHFtUB2UZ1F7Vk
         447BqqwDtdHUKkl9BiOQpLRcJWO+fWJEk7kgQsvdQN+U9df+7RxC46kipMNDqY5zvBR5
         AqioeAiYAyNBKuD6WflHVL9rtzSwie2OUMeChy1TDEspoHezCguk25iRlcpV7/v6my5K
         dGznuXmRI/hGyrnJQo6CyNnXZv4OREjIdyfX4l2Mg75/cqLH39joR6wFQl1dslvj6Fla
         +Xa1Y0fBA52YPfnXWSrdSKpMQtjQ73ly0i/n1bP2IgU58weg32SKNVP4xnN6zDD7yYji
         n7tg==
X-Gm-Message-State: APjAAAUvbVmhYSBUUcBvMON6v5uC/Cdkx7vG1ozodiR2pXFK7nmpVN5K
        PGyaP9chl1thzz8yNQM4wFaIIQ==
X-Google-Smtp-Source: APXvYqxsvzB6CFv06nZv5X+fP4cX+FzYXhiKJAS60N31poBuk0qfyxhmyAij3weEl98sWCL57RWQFg==
X-Received: by 2002:a17:902:9f98:: with SMTP id g24mr31305945plq.325.1575914577974;
        Mon, 09 Dec 2019 10:02:57 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id h128sm114062pfe.172.2019.12.09.10.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 10:02:56 -0800 (PST)
Subject: Re: [PATCH 0/2] Add iProc IDM device support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
References: <20191202233127.31160-1-ray.jui@broadcom.com>
 <20191207173914.353f768d@why>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <bd90ba80-9aac-e406-9066-64e975e5b10b@broadcom.com>
Date:   Mon, 9 Dec 2019 10:02:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191207173914.353f768d@why>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/19 9:39 AM, Marc Zyngier wrote:
> On Mon,  2 Dec 2019 15:31:25 -0800
> Ray Jui <ray.jui@broadcom.com> wrote:
> 
>> The Broadcom iProc IDM device allows control and monitoring of ASIC internal
>> bus transactions. Most importantly, it can be configured to detect bus
>> transaction timeout. In such case, critical information such as transaction
>> address that caused the error, bus master ID of the transaction that caused
>> the error, and etc., are made available from the IDM device.
> 
> This seems to have many of the features of an EDAC device reporting
> uncorrectable errors.
> 
> Is there any reason why it is not implemented as such?
> 
> Thanks,
> 
> 	M.
> 

I thought EDAC errors (in fact, in our case, that's fatal rather than 
uncorrectable) are mostly for DDR. Is my understanding incorrect?

Thanks,

Ray
