Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8560ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C74A20815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xnt/LuGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388681AbfJANkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:40:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34657 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfJANkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:40:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id y35so9705367pgl.1;
        Tue, 01 Oct 2019 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4vOYNi5T48xwb1n2hFAYpF7E0QLiPcqC0FCJyUAyNBQ=;
        b=Xnt/LuGDQaAK+dLqW2ga47WZvlv2h7nLyYoxPC6nSSmFeMTOq9RG8hCFNc7GL5tl9e
         HgzNat/g5WB6fyJKzllB+la34cFqzBeJ9bAEcCIeunGcLZ80RCNuTMh+5Ukt08Lk1waG
         LPE37m/Zevzw6WVvXMZG00j8ICsosFSJuaie/psFekhW3u8oFUay0Wgq6IjgagvzUo6f
         Oma6PdOoFvtHWdpdKHvhhMNrTBBqzaY1rcDAQgAkgYqtm7gl70TTWGVIDwcvGR/SuXAP
         N/pzw+aw+FUEdQPUdRJMju6GajbSITrg+D+npSkgM2NRxRTUYqKH0Za/ZhWSsFvijutF
         ntrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4vOYNi5T48xwb1n2hFAYpF7E0QLiPcqC0FCJyUAyNBQ=;
        b=DfzI9uxTA8u7ADk+BusUwsO0zdE6JwZRO79vD4CQDuBnpTjUUuI+KGxluHT7FGFWqF
         e2PJfnGKQeogvMF641CL4Zv0x4yLSJa2qCjddtKKLAeWh1izLDerhYEwFt/6fPQsh1ci
         H9Mf+e1/GIEUIoPbwMf+HA7bwGCu9zBxBTBAHnCrvqj+6Xh/dvSW7Sg/eWVwzp9VZgY+
         pd0VHY7SBq6q5wGcNwNCqoa26zoErRMQsy/u2IE4DaS/TzmTtBwiWg29bpYu5L8eR5VV
         BwlTzyCIB+/8dR2h6uq1Ec5/rIEZTIuBh6vqjYonCi0KHIOxc11pduq+RZD3Ac4mTOtR
         0fdA==
X-Gm-Message-State: APjAAAVKhG3T3lVa/bYayO4TftcOzT/60VoVz0HQH9SEI7YZBpYURPVN
        jbeWJBJ3e9Xq0bNU76B33Tb4zQap
X-Google-Smtp-Source: APXvYqwRvvLnhzb7LlS95wwloBZe3MSNY48zgJ00VCMN74VaASkeqSApwY50oEKW2WSGzYgAYhSTRA==
X-Received: by 2002:a65:6709:: with SMTP id u9mr238225pgf.59.1569937245302;
        Tue, 01 Oct 2019 06:40:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ev20sm2598898pjb.19.2019.10.01.06.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 06:40:44 -0700 (PDT)
Subject: Re: [PATCH] usb: typec: tcpm: Fix a signedness bug in
 tcpm_fw_get_caps()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190925110219.GN3264@mwanda>
 <20190926125310.GA9967@roeck-us.net> <20191001115442.GB22609@kadam>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0d9ebb0e-d8b1-f963-9310-e4099dcf677a@roeck-us.net>
Date:   Tue, 1 Oct 2019 06:40:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001115442.GB22609@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/19 4:54 AM, Dan Carpenter wrote:
> On Thu, Sep 26, 2019 at 05:53:10AM -0700, Guenter Roeck wrote:
>> On Wed, Sep 25, 2019 at 02:02:19PM +0300, Dan Carpenter wrote:
>>> The "port->typec_caps.data" and "port->typec_caps.type" variables are
>>> enums and in this context GCC will treat them as an unsigned int so they
>>> can never be less than zero.
>>>
>>> Fixes: ae8a2ca8a221 ("usb: typec: Group all TCPCI/TCPM code together")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> ---
>>>   drivers/usb/typec/tcpm/tcpm.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>>> index 96562744101c..d3b63e000ae2 100644
>>> --- a/drivers/usb/typec/tcpm/tcpm.c
>>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>>> @@ -4410,7 +4410,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>>>   	ret = fwnode_property_read_string(fwnode, "data-role", &cap_str);
>>>   	if (ret == 0) {
>>>   		port->typec_caps.data = typec_find_port_data_role(cap_str);
>>> -		if (port->typec_caps.data < 0)
>>> +		if ((int)port->typec_caps.data < 0)
>>>   			return -EINVAL;
>>
>> Doesn't that also cause a warning about overwriting error return codes ?
> 
> I'm happy that you think there is a tool which generates warnings like
> that but it's just people manually complaining.  :P
> 

I am quite sure there is, or at least used to be - I have seen such warnings.
Maybe it was removed.

Guenter
