Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E138C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F02F2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nttduy7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbfH0VVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:21:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39528 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0VVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:21:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so261578wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tLhcw38FuKLNsut7gUz1FietvesVxFl+vsh+ysDektI=;
        b=Nttduy7GCncxAEwTn7ROUQfvrd7gHjj+gmRcBK8NJhKmsWss+ZW5JMz+WsG3RVKWWK
         W98wigEyZsjUQuT5JcZS7emeap2xUSbSbpr+dKTOjhjj6IcgqV5Kw38yY9+MBXH89mQz
         jepDS09L0iPppjfwLMM6GElXvmlBox6z94GRZQCgQ0DPbBnYppklne7QOfYMcac/D22T
         9+RjltFJWmIZK6vOkKA8EtSruFP+O239NQRcvbWM0oMZclwW16hgZ8XPv4IPcTOcHAk0
         QtTvMsidOLa2XAXF94hKc5Oy+UroqgLZ+dNCh6zFuTlLxfrAwJ1B1kDgNCPFzqZzIdUS
         +8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tLhcw38FuKLNsut7gUz1FietvesVxFl+vsh+ysDektI=;
        b=RUx9szJ3D4R1y4SNkzYhr4EYsE7qXPI3Wth5pWx38XHmoJiqvv2ltTOg5+9dqNAw5l
         Raz+YjnJNsQMN4U4LnhTVf++C+6r4b5h1nTApRjRfMclmjXsz1q8pn0IUNcbIRdns5tP
         rQlgkjdWXzXGpx0s/LryFzHezfmWhF8kQVis07m4LtT6mHSjAE+w9Psnu3LaXkqf0tH7
         dXFEYwOR1/5A77XezsqJlmwaR0MqUjHnW93hqbza3J/8nrpOgPBerDWEx14fkg0ryI7N
         5Yo09XxAXfiHR28Fz69X1AZ9wCE8nuTkHwUBHboqCSpC0XvWDqzPQPyksYLWP/ecf+0T
         zDUg==
X-Gm-Message-State: APjAAAV+0v8RioGyhskaSJ1yyl2lP33uzWIe8KJ6yvsyb+Pyw8odPOj+
        YzfZTOC089ssqMuqju7BMQ+lUn8YJck=
X-Google-Smtp-Source: APXvYqy8AWyg2VL46hPxiroKD/nqocylXrXqvK7Uf41BSbK1KZmcquEck3Uhap2HM5cQB1Qylj3kJg==
X-Received: by 2002:a5d:4fc4:: with SMTP id h4mr272620wrw.64.1566940872977;
        Tue, 27 Aug 2019 14:21:12 -0700 (PDT)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id r17sm458558wrg.93.2019.08.27.14.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 14:21:11 -0700 (PDT)
Subject: Re: [alsa-devel] [RESEND PATCH v4 1/4] dt-bindings: soundwire: add
 slave bindings
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, spapothi@codeaurora.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
 <20190822233759.12663-2-srinivas.kandagatla@linaro.org>
 <7da8aa89-2119-21d1-0e29-8894a8d40bf0@linux.intel.com>
 <37be6b6d-7e7f-2cd6-f9e9-f0cac48791ad@linaro.org>
 <d538238d-25d8-f179-c900-90be50ce814d@linux.intel.com>
 <7ee47f26-12f8-6028-cb83-7f59e669979f@linaro.org>
 <e5b184be-02f1-faa4-94fa-79bda8936d9d@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <aaf1a8f6-9be5-2d42-9f92-4fd75986424d@linaro.org>
Date:   Tue, 27 Aug 2019 22:21:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e5b184be-02f1-faa4-94fa-79bda8936d9d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/2019 17:22, Pierre-Louis Bossart wrote:
>>>>>
>>>>>> +      description:
>>>>>> +      Is the textual representation of SoundWire Enumeration
>>>>>> +      address. compatible string should contain SoundWire Version 
>>>>>> ID,
>>>>>> +      Manufacturer ID, Part ID and Class ID in order and shall be in
>>>>>> +      lower-case hexadecimal with leading zeroes.
>>>>>> +      Valid sizes of these fields are
>>>>>> +      Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
>>>>>> +      and '0x2' represents SoundWire 1.1 and so on.
>>>>>> +      MFD is 4 nibbles
>>>>>> +      PID is 4 nibbles
>>>>>> +      CID is 2 nibbles
>>>>>> +      More Information on detail of encoding of these fields can be
>>>>>> +      found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
>>>>>> +
>>>>>> +      reg:
>>>>>> +        maxItems: 1
>>>>>> +        description:
>>>>>> +          Instance ID and Link ID of SoundWire Device Address.
> 
> maybe put link first and make it clear that both are required.
Okay, I will give that a go in next version!

thanks,
srini
