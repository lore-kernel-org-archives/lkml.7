Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F562FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61985222CE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P1AoNst6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390970AbfKHLsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:48:23 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:45284 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391690AbfKHLry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:47:54 -0500
Received: by mail-ed1-f51.google.com with SMTP id b5so4744310eds.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 03:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oY/F4aCQPNritClWghNhqRasDlL6kzVrQ49vfqs/kgo=;
        b=P1AoNst6/QnM6aZ+1U3JcDhkhsGKnN4O2DjeH2XwsPMR+PEo9zhpzrKYiocxUgtkUV
         WpzpqqU4NbIW8YP5XSa4nHDtqP1/hHN1xSyTwCNCNh0F3eeoqXo1ROMP42E/2rx1m9AD
         S/poVcWJT6QSJ68VU7++RUEigPBre3g5hMKeMcDxefQ2OUZb4W7kOXcl28ZYnrF+QjZA
         NOsJJ7ncpSATNoUcaWvc7GJr17RwNiQV5sJREKaLzkgbaPivfRx9BI/hto9XoA5XpAMa
         FXM0L6brvhqjc126lFwsytqrJxLoJaAMRnODQcO2MpFXzNPJKkDVl65kWQO4qO4FHlFB
         XKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oY/F4aCQPNritClWghNhqRasDlL6kzVrQ49vfqs/kgo=;
        b=eAWOpsTOl8Vl9EudZjHIPQSo3LAISRiN3jZj/IBm4wF/gjCXqBWxJ1SvdlrancAOHx
         mV5nOpZI5Gs1owtcq2hEnO0Cvl7P9lFixwjUdkSuLdSHGZ2Ww/6uOreI1f1+kpmUbJxh
         yyLUEQQRcI6LfVZ79z5yaug/xhVYX2kn1m8eCNOiKXIfyetCvWWw2LcyeKn4RIICiW5X
         VJ/pif7IzNMrnQGNx40BUh6sk87Oiu9aigbMN/SdlG6aZQEPCwyBuMYsO7UmtSdN+erY
         ddGRSjyrZniphQ1RIVEXdScyURafVkJftzUKDtrCql4xVb6uE0HwwaHuFUVmDr6ffQgz
         +1yQ==
X-Gm-Message-State: APjAAAVNeLSTNbhw3w9n3syiTbwgIAiuqnKgdH0WgrIZEaySnpYzD6aT
        jLFMPuCg1ro/ImfGor255/CTnvut84o=
X-Google-Smtp-Source: APXvYqzLrDi/mv8FQaOLOdAFUt6G7ZCSbAL+w6PPGtjzjtYo86C6GzLWtJtnDtF+FR2zuhGY69FVbQ==
X-Received: by 2002:a17:906:6d84:: with SMTP id h4mr8355811ejt.262.1573213672321;
        Fri, 08 Nov 2019 03:47:52 -0800 (PST)
Received: from [192.168.27.135] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id b4sm123369edy.36.2019.11.08.03.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 03:47:51 -0800 (PST)
Subject: Re: [GIT PULL v2] interconnect changes for 5.5
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <dd4ff7e3-920d-979b-c29b-7535d84d360f@linaro.org>
 <20191108105355.GA683899@kroah.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <25808ada-dbe6-db38-c68d-26a263942a28@linaro.org>
Date:   Fri, 8 Nov 2019 13:47:51 +0200
MIME-Version: 1.0
In-Reply-To: <20191108105355.GA683899@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.11.19 г. 12:53 ч., Greg Kroah-Hartman wrote:
> On Fri, Nov 08, 2019 at 10:59:11AM +0200, Georgi Djakov wrote:
>> Hi Greg,
>>
>> This is the updated pull request with interconnect patches for the 5.5 merge
>> window. The details are in the signed tag. Please pull into char-misc-next.
> 
> Ugh, ok, can we just go back to sending patches instead?
> 
> The first two patches have "Fixes:" tags for older kernels, yet no
> stable tags.  That's not ok.

These two patches are for the current 5.4 release and you have them in your
char-misc-linus branch already. I assume that you will get them in -next later
via back merge anyway, so will drop them.
Should we use Fixes and stable tags always together and only when we fix
something in older kernels and not in the current one?

> For patch 5, you are playing "chicken" with what module gets loaded
> first, and in the end you're not going to win, only delay the
> inevitable.  We now have the driver core framework to support
> dependencies like this, please use that instead.

Yes, i keep an eye on this and am currently testing it.

> So, can you drop patch 5, fix up patches 1 and 2, and go back to sending
> patches instead of pull requests as if these were patches, I could have
> fixed up 1 and 2 myself.

Will do it!

Thanks,
Georgi
