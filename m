Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B57C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB1D2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4rXOv/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbfJJNiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:38:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33815 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbfJJNix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:38:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id j11so7976378wrp.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dNKHo7wC/215Tc8q4IYUbrHibFKH//hrOf2lUQhIP+k=;
        b=c4rXOv/U6+AGwyzEaBsCCLbaPQ5PuswG1a6LIjyTlEvCwnrKbXZnR6+HreuUwAWKCh
         x1F92c0aWJ7Lesa1HUS/neB+6UavBIP9tDmaDAWfVQLY6ATDftbfn+eE8qUA9lSiiwb0
         gbmHF+AjOTVGA+9uhTCzakVpyAGqzygdFxKJtBqLiwwyaB8uucpBFsrG40IC5MpekjvZ
         6FJsrXQxcT0U/zEHaiJNH/f62LGjOeH4L9NzahroreQZe3JPH7nD4UqJlS6TyDZvjijF
         H76aq0v43xsWi50NHm7CBZ8HdwL+3389nJ0QzbZBKWH9vbf5cIGJcguEpIKcuvvoLz49
         x1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dNKHo7wC/215Tc8q4IYUbrHibFKH//hrOf2lUQhIP+k=;
        b=Kwlf87i0cNXOGFucEd9nY9czcPlhIT3I7cKRquCjKPXOJERs4/j2R5OKxsQH76Jwa1
         MBGz3g8zjOaAssYKZbVrARI6B32FLxP3ndWOmbHw0nQPjrvbKZkCnuyB+z2wwmgftXht
         FRJDM+bGg8ZG6NMt9ckPeUGAnslZ2QzzSJeFuSvWni3W8OzDu7uF+sncE0cbqNk5pOd+
         o/ecgBMl5ieG7cWGX2n8uCpX0fe3FK/RpDq7WSR9RpjvQCJMKPj3rkDFtNKWq32KR5dc
         eGKBpOx8K16NX9GfuWMz0jOWECFqf5efvMWyNcI9JkDEeaT3olHkADhxlUip+Dw3+XGr
         Rdxw==
X-Gm-Message-State: APjAAAWYaSD4r5ydWb0aGGSA4u9YAzNagPPABv9x+zUzezyeWgK+8Q1A
        o+Q8hokWFsFTh1uWdWo4hA1EDg==
X-Google-Smtp-Source: APXvYqztlBMqNL6y+jP0zl/tFHe7klxsBxWvq4OmxyJphjZ92KRbEFrRmvrcRFKdis6Ee/b8FEfGxw==
X-Received: by 2002:adf:ea45:: with SMTP id j5mr3800979wrn.392.1570714730051;
        Thu, 10 Oct 2019 06:38:50 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id q10sm11593228wrd.39.2019.10.10.06.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 06:38:49 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] ASoC: codecs: add wsa881x amplifier support
To:     Mark Brown <broonie@kernel.org>
Cc:     spapothi@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, vkoul@kernel.org,
        pierre-louis.bossart@linux.intel.com
References: <20191009085108.4950-1-srinivas.kandagatla@linaro.org>
 <20191009085108.4950-3-srinivas.kandagatla@linaro.org>
 <20191009163535.GK2036@sirena.org.uk>
 <95637c0a-8373-0eda-47e5-ac6e529019e5@linaro.org>
 <20191010132314.GQ2036@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <32280055-dd4a-9573-58fa-0076955e9c92@linaro.org>
Date:   Thu, 10 Oct 2019 14:38:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191010132314.GQ2036@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2019 14:23, Mark Brown wrote:
> On Thu, Oct 10, 2019 at 10:28:04AM +0100, Srinivas Kandagatla wrote:
>> On 09/10/2019 17:35, Mark Brown wrote:
>>> On Wed, Oct 09, 2019 at 09:51:08AM +0100, Srinivas Kandagatla wrote:
>>>> +static const u8 wsa881x_reg_readable[WSA881X_CACHE_SIZE] = {
> 
>>>> +static bool wsa881x_readable_register(struct device *dev, unsigned int reg)
>>>> +{
>>>> +	return wsa881x_reg_readable[reg];
> 
>>> There's no bounds check and that array size is not...
> 
>> I converted this now to a proper switch statement as other drivers do.
> 
>>>> +static struct regmap_config wsa881x_regmap_config = {
>>>> +	.reg_bits = 32,
>>>> +	.val_bits = 8,
>>>> +	.cache_type = REGCACHE_RBTREE,
>>>> +	.reg_defaults = wsa881x_defaults,
>>>> +	.num_reg_defaults = ARRAY_SIZE(wsa881x_defaults),
>>>> +	.max_register = WSA881X_MAX_REGISTER,
> 
>>> ...what regmap has as max_register.  Uusually you'd render as a
>>> switch statement (as you did for volatile) and let the compiler
>>> figure out a sensible way to do the lookup.
> 
>> Sorry, I did not get your point here.
> 
>> Are you saying that we can skip max_register in this regmap config ?
>> Then how would max_register in regmap be set?
> 
> I'm saying that you appear to be relying on max_register to
> verify that you're not overflowing the array bounds but you
> max_register is not set to the same thing as the array size.

Thanks for clarification, I have removed the readable array in new 
version, removed multiple macros for max register and fixed max_register 
to point to last register.

--srini
> 
