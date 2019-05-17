Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22313C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85D221726
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L7IkwYQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfEQSI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:08:29 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53694 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfEQSI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:08:28 -0400
Received: by mail-it1-f193.google.com with SMTP id m141so13373639ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 11:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2aEY7eAQvZ+DH9KTif1OtLivF3PEC9S4LqizD0kDgwI=;
        b=L7IkwYQoyruj1kcToFk3llJ/wvrHsEq88TWxzTYXgo9ksbnoF12nD7eGVzZvNhOTDw
         N1HImXNNWsBw5VeJAHSGGxKl0SrQGaAZgt6tN1rX7sgl9doC1aNuxJU9oj20WCcnlurO
         Kkeqj6F20KogMHQ4BfSaw+vZqHgymnyYyWLHy2OwR3tt4edNKICT8ZGxIbdWAV/l4eW8
         UIq/TG1NNtgSHZpUGW7mBF6HNgUrN+sS5UyUMTUITLbptpUi3Un8jhX+fZbSW44yjeDY
         vCXm2xgZ8r0I6tJ4WMwb4meauwDsqU/lJBsSd0i7kXQt7sy+cY4HHXpN2+19yuBvxMSd
         9eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2aEY7eAQvZ+DH9KTif1OtLivF3PEC9S4LqizD0kDgwI=;
        b=pPLAHxud+y89Lrr1lNPsdDNxSF3XJgStC4ZaDDua/9/INfQuXaGugBdc4Cnyq8MoW7
         R1onrPyGTvYJvUnlh9Kjd7IC4hJZW2Y0PVbryFPZkGvw85OXVHZ6n2lRpKAD1hbRFfME
         Cf0Fdpn37T48IoxglcIB9L23taNXzbtyzR9DpCG7cIye1alHdXsLy5wpPnHE0E5aR4CS
         44bCxpAuhSOpVcV3lbSfxwoTb8R9zoWNWGlp3050f8F9HNZ1850sAASdAh2QulA8mnkK
         nN/5TPiSIlSlhSMONxSGmtU3qu2NnqoMtu7GEPcSgnkGz5wdsYAy67/qTdCrJbFjidrH
         CaNQ==
X-Gm-Message-State: APjAAAW/xmGdyROKRi5U7enpOCRKbsEgjrz95UP6t1rJ6s3vTODDw1yy
        xYkY163IqMoaNuNTudHT4FOthx/Jdns=
X-Google-Smtp-Source: APXvYqzozIE0JG78e7tF5FBw5vCIm6ssm1WadNcp7ER/a5vIjt1efF4c1vVyitMUHfAp8sKlL4tpXQ==
X-Received: by 2002:a02:c64a:: with SMTP id k10mr17897522jan.30.1558116507475;
        Fri, 17 May 2019 11:08:27 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id r6sm2828922iog.38.2019.05.17.11.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:08:26 -0700 (PDT)
Subject: Re: [PATCH 09/18] soc: qcom: ipa: GSI transactions
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-10-elder@linaro.org>
 <CAK8P3a0eYWN6mMwft5OSu8wQQo=kWh5safGFFNkDCELZJyiMmQ@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <14a040b6-8187-3fbc-754d-2e267d587858@linaro.org>
Date:   Fri, 17 May 2019 13:08:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0eYWN6mMwft5OSu8wQQo=kWh5safGFFNkDCELZJyiMmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/19 2:34 AM, Arnd Bergmann wrote:
>> +static void gsi_trans_tre_fill(struct gsi_tre *dest_tre, dma_addr_t addr,
>> +                              u32 len, bool last_tre, bool bei,
>> +                              enum ipa_cmd_opcode opcode)
>> +{
>> +       struct gsi_tre tre;
>> +
>> +       tre.addr = cpu_to_le64(addr);
>> +       tre.len_opcode = gsi_tre_len_opcode(opcode, len);
>> +       tre.reserved = 0;
>> +       tre.flags = gsi_tre_flags(last_tre, bei, opcode);
>> +
>> +       *dest_tre = tre;        /* Write TRE as a single (16-byte) unit */
>> +}
> Have you checked that the atomic write is actually what happens here,
> but looking at the compiler output? You might need to add a 'volatile'
> qualifier to the dest_tre argument so the temporary structure doesn't
> get optimized away here.

Currently, the assignment *does* become a "stp" instruction.
But I don't know that we can *force* the compiler to write it
as a pair of registers, so I'll soften the comment with
"Attempt to write" or something similar.

To my knowledge, adding a volatile qualifier only prevents the
compiler from performing funny optimizations, but that has no
effect on whether the 128-bit assignment is made as a single
unit.  Do you know otherwise?

					-Alex
