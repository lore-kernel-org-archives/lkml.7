Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8DFC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A029A2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SwCeGizo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfLJATL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 19:19:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38921 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfLJATL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 19:19:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id s14so1204977wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 16:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7SQNMrH3FWLOHx8P5+nc/Y/vfFqnbuXwKn95w6eAgao=;
        b=SwCeGizoute6aM8WBuWO5aqLXZvlBE9LQkiA01eogphBriUxjYU5BxsC+cYroUmZE8
         tqi0jLBqvVR7I87fm/QGOxMkRFn8sICZntbBTvgffbv8ooc6M63WJ+CKxFd+/tP/SSSK
         UQucOxuaOq96ykIy8qxsmP526hqGxid+/SVSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7SQNMrH3FWLOHx8P5+nc/Y/vfFqnbuXwKn95w6eAgao=;
        b=KVseuUtte+3rCinsZZNFVnhK6g32ZSGtGC5TLhyzaIzt/KKL2U656/2uRT+SvDIRSV
         P0QmGDmIN0GkoeroiCd2Y99Bg+Q8PRoVGcoWueFxqQovz9I7tPbFxYsFC6IB6yoARKN6
         /TcIicoy5h6mYZvk1Ie2tLBxemHmDjmf5VgHw0Ls4qEPpSkCV/QedQO42oQrNCBXChUj
         a91usMWgPuTMJ8+O3c5SxrNNKJntjcgKd5Mvcw3hrBPJkJOViofXilFXdB4yH/hJ/X2X
         rfhYokntB1OUxcuks2fDFYOAM6M6VfncIfxUIlEMCceU9MjA+pEL7zN5Qe8DmaGg76T5
         yOkw==
X-Gm-Message-State: APjAAAW9DHJUxGcV5zvly3C8LlzK4JVpwGk/m2l1pOo2n0kG0W01eJQO
        k+xNUm4C1FFpivLBEUNUYEl4dCsdDYiN+g==
X-Google-Smtp-Source: APXvYqxzOk0JdZlf+46jK9Xp8GhKR0K8LVhI3QZ5He8BwBXVH+OKWm/me7LNc/zlPupDn98PkoD4/Q==
X-Received: by 2002:a1c:a750:: with SMTP id q77mr1645652wme.76.1575937149108;
        Mon, 09 Dec 2019 16:19:09 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b17sm1229259wrp.49.2019.12.09.16.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 16:19:07 -0800 (PST)
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
 <bd90ba80-9aac-e406-9066-64e975e5b10b@broadcom.com>
 <20191209183636.6d708bfd@why>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <69ff3b8a-e99e-7128-a02a-1cac1da3eb66@broadcom.com>
Date:   Mon, 9 Dec 2019 16:19:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209183636.6d708bfd@why>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/9/19 10:36 AM, Marc Zyngier wrote:
> On Mon, 9 Dec 2019 10:02:53 -0800
> Ray Jui <ray.jui@broadcom.com> wrote:
> 
>> On 12/7/19 9:39 AM, Marc Zyngier wrote:
>>> On Mon,  2 Dec 2019 15:31:25 -0800
>>> Ray Jui <ray.jui@broadcom.com> wrote:
>>>    
>>>> The Broadcom iProc IDM device allows control and monitoring of ASIC internal
>>>> bus transactions. Most importantly, it can be configured to detect bus
>>>> transaction timeout. In such case, critical information such as transaction
>>>> address that caused the error, bus master ID of the transaction that caused
>>>> the error, and etc., are made available from the IDM device.
>>>
>>> This seems to have many of the features of an EDAC device reporting
>>> uncorrectable errors.
>>>
>>> Is there any reason why it is not implemented as such?
>>>
>>> Thanks,
>>>
>>> 	M.
>>>    
>>
>> I thought EDAC errors (in fact, in our case, that's fatal rather than
>> uncorrectable) are mostly for DDR. Is my understanding incorrect?
> 
> No, they are for HW errors in general. There is no real limitation of
> scope, as far as I understand. Recently, the Annapurna guys came up
> with a similar HW block, and were convinced to make it an EDAC device.
> 
> See [1] for details.
> 
> Thanks,
> 
> 	M.
> 
> [1] https://lore.kernel.org/linux-devicetree/1570707681-865-1-git-send-email-talel@amazon.com/
> 

Ah I see. It looks like memory controllers are the primary devices 
supported by EDAC. In addition to that, EDAC also does seem to provide a 
generic data structure to support other types of HW devices and error 
events. I'll look into this and get back.

Thanks,

Ray
