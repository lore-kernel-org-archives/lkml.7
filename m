Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE5FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3F220700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILKGGahm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfDCKsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:48:50 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44628 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDCKst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:48:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id v71so6519158lfa.11;
        Wed, 03 Apr 2019 03:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kTFG7OY5VbEpkisSaPzwZ+He02yu88yE+HNh9/gpx6s=;
        b=ILKGGahmlZ5T17MuXj67rb4fh0xVK/cNdqMEeUwvk10xYFhKbFlhcBZlojB/3Tgb6x
         3U13USzZ8FOh99APbiIZrpHQMDCVB+NLIX/1aaJLwiD9aGDnaLYeFQb6BCFJJ+qHu8iZ
         xJiiUFAmd2/lqEYmSLFP0pGe07M2GWYkzMnSLJqcabguQAbkRPhszkSGrvMAfM748hvf
         cIl57LjRpBc6GGJen6h9ulLwtIzeEQ9Zi4wOPxaHJFu9QivZbEmUYcLTMjMDVfjX7DgT
         +skUhy/p0uPhVmDjnQU3uz+BRgyEKFncUTuuDX76qdQtl+0tT3kzv8V/cswUDcFmkD2f
         ay1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kTFG7OY5VbEpkisSaPzwZ+He02yu88yE+HNh9/gpx6s=;
        b=U9NgX/PX6puH2K98o0ST2NL9tzhIC0JguHQ5kj1vTJamrmsqe8NHVfEj5n33YV6SvC
         7uJmx64B3F3SGCHX3IUMi3v4Q2/zI7xQQd3TZqWLCGg81xv96we2mjNls9R0GIz/Hcy0
         SQPoAprgx++5mHuAuaOV4FtYUvtEf0udOYvHNT7vQjvu0BYlYvDA/+VZ96SVJISAhhVp
         wngIfOO9O6TD2JQjsbQIz5B9UywsL6XrsyhoSs36usupFKYE6rJAGORKG9OQyCkpAcWw
         aVzCXhyavZYohM9TdkiLv7VDV6xOlkhiUx4GstR91sYakEekoPsIR8FtvUEfSABeNmtT
         vUdA==
X-Gm-Message-State: APjAAAU8z1EzEUB24j4MSyAyBNrgOqVcdadUJuLvEUO4Z4dixhBqelor
        4fot1dFHZ/P9TgddqQ1d4RPsweLj
X-Google-Smtp-Source: APXvYqwXVmaMo94wYWfM5zTR8Dx5NDY+v+76XedUXzgFTupXtIZ3OriN5lx6+H0e1UufxTegMMa/5A==
X-Received: by 2002:a19:4a49:: with SMTP id x70mr6640394lfa.11.1554288527205;
        Wed, 03 Apr 2019 03:48:47 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id c7sm3464285lja.90.2019.04.03.03.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 03:48:46 -0700 (PDT)
Subject: Re: [PATCH v1] drm/tegra: plane: Remove format-modifier checking
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190224153405.8447-1-digetx@gmail.com>
 <46fb6670-59ed-0378-cd7e-aea3fd4ee890@gmail.com>
Message-ID: <cc3e1991-1990-9f8f-b36a-ff345596ec35@gmail.com>
Date:   Wed, 3 Apr 2019 13:48:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <46fb6670-59ed-0378-cd7e-aea3fd4ee890@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

27.02.2019 18:08, Dmitry Osipenko пишет:
> 24.02.2019 18:34, Dmitry Osipenko пишет:
>> Tiling modifier can't be applied to YV12 video overlay because all tiling
>> modifiers are filtered out for multi-plane formats. AFAIK, all modifiers
>> should work with all of formats, hence the checking is incorrect and
>> simply not needed.
>>
>> Fixes: e90124cb46bdb ("drm/tegra: plane: Support format modifiers")
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
> 
> For the reference.. this patch needs a stable tag, I did the same mistake in [0]. Thierry, please let me know if you're okay with the change and if you could add the tag while applying the patch, thanks.
> 
> [0] https://lkml.org/lkml/2019/2/26/277
> 

Thierry, please don't forget about this patch.
