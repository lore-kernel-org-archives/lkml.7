Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413DAC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDEF206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KXMqs1gO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKNM7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:59:53 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:44352 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfKNM7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:59:53 -0500
Received: by mail-wr1-f41.google.com with SMTP id f2so6343984wrs.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 04:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NVm1JTEP+HaSOJ0+sJvVCGbI/hoKCutUJ9lzwy/Av/A=;
        b=KXMqs1gOMDLsfzvb1GSchDLrgdDs/pGfgJpo+ObAeOa4inJ3D6uW6HGkK91pwMeLhj
         zaWhAzC3lNULuoc1YNOZ3oynVzwKHzjY/hqpS4dikozbedmHr6FVsM+RdPqzharFLE5f
         VLMzYTaPASr7ITLUIolXEeuUFogbAOAzXAvUCSK3IIdt1llU3G/n2hh0MLlJjbkCbO0y
         jm6t/4irMHkyQWw+4rA3vtjU2tOsSa8RSRbQ63l6zEzMCSaiuMd4uZX/Oa38YjrSZB8U
         OgfPIUNVI+k04+BJxV6p7sMR7/eSZdZ0OixZCIQfzvhn7R9A3llcXHV20YLBcO7g/Shb
         nXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NVm1JTEP+HaSOJ0+sJvVCGbI/hoKCutUJ9lzwy/Av/A=;
        b=FKTKNvoxCdPFzu8SbhcGxfbZGK7KAT4H1w0dnE0ZGNWVVR4dveEwh+mKO1b9/sf/DJ
         SVbnJ6ck0kft7zvZTmVEIL4rlFh1wVRZUi8MjdkqTboPXaPN1KQtdrQ20aI9LGS3AjFf
         QISdOd/0xMq/Y0yeoMGZtEnR/bVpDXGYbLdenPHhekVMKXv/ttKSmfh3vt3OMbg0FLWZ
         atJZ3A8bfLwYkq4eCpF/+ujYbcn9Lrhh9tM3IIHCthtIGagvyqDA2qhpfCMh1R+AIeos
         UdYDnodjckDs4INt38NEPac0QxhUv6QV1KbMWT/awovC71lUkCbHDVWgh8IvPLqoRZ9c
         fm1w==
X-Gm-Message-State: APjAAAUiGpFeGP2pAmlz9iiBQB3UVKKbGa9WMX9sNWPinYOgsKPVuS8K
        itjhmO0luO/mw7c1Mu/ep32XHlKk1D0=
X-Google-Smtp-Source: APXvYqyeUd8qq5xYoNEzOesUYkYRaaIjQC8+hS8pozvVKnEJ75fi+CY2+0bbx+FEZKB1Z41xbCln/A==
X-Received: by 2002:adf:f490:: with SMTP id l16mr8217353wro.77.1573736390145;
        Thu, 14 Nov 2019 04:59:50 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b1sm6611943wrs.74.2019.11.14.04.59.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 04:59:49 -0800 (PST)
Subject: Re: [GIT PULL] interconnect changes for 5.5
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <5123bf54-5d62-fc5c-8838-17bc34487d83@linaro.org>
 <20191107142111.GB109902@kroah.com>
 <0cb5a6a6-399f-99e3-dc41-50114eea4025@linaro.org>
 <20191108103917.GB683302@kroah.com>
 <CAOCOHw4d0q3uGTAh_UrNWr+Wi6ObDKUFn7M_zkD8cFTkNFEUDA@mail.gmail.com>
 <20191109084820.GC1289838@kroah.com>
 <CAOCOHw4AFz2Rj3sLTrboA0pBOkL_5MbitJnFHgBYaVBbWyYATw@mail.gmail.com>
 <20191110101647.GA1441986@kroah.com>
 <20191114084122.35myncenejt54hht@vireshk-i7>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <bf025961-5b0b-c52c-c387-62123dd4c226@linaro.org>
Date:   Thu, 14 Nov 2019 14:59:47 +0200
MIME-Version: 1.0
In-Reply-To: <20191114084122.35myncenejt54hht@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/19 10:41, Viresh Kumar wrote:
> On 10-11-19, 11:16, Greg Kroah-Hartman wrote:
>> On Sat, Nov 09, 2019 at 12:27:29PM -0800, Bjorn Andersson wrote:
>>> As your question shows, everyone gets this wrong and the build breaks
>>> all the time (it's not "depends on framework", it's "depends on
>>> framework || framework=n" - and everyone you'll talk to will be
>>> puzzled as to why this is).
>>
>> Ah, now I get it.  Yeah, that sucks.  We need a "shortcut" in Kconfig to
>> express that type of dependancy.
> 
> Maybe we can use
> 
> depends on framework != m

That won't work in the case where framework=m, provider=m and consumer=m.
Today this is supported by having each consumer to:
	depends on framework || !framework

So again, the problem is that we need to add something to Kconfig, even a
"shortcut", in order to express this dependency. If we convert the framework
from tristate to bool, there will be no need to touch Kconfig, as we have the
include stubs. Keeping the modular support comes at the cost of adding a
dependency to Kconfig for each user.

Thanks,
Georgi
