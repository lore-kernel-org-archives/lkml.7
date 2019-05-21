Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAC7C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B38D20863
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1fa/TGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfEUIRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:17:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33067 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfEUIRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:17:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id d9so4496306wrx.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dm92NMg/irWYm67dt8+YBn2/6jTQ9TzkOqtUWA6VrWI=;
        b=j1fa/TGzBbqgrrCXjtZgS+zq0QNWVwbDEU5c8TPHQ1e1b3kP/JPu1UYjeVj2+LrHDz
         fdfW3UE1IRUnx7dH5zHt0LBNPH/5v2BmxQTuVLWeblOmO9mDAq+j7hMs4jOiho+KBW0X
         kbyQ5lfQxwcYaStadZkLqKyv013QlA9TRAWhGiU8Xh63I1XeX4994xv0fUVS2IC9W9zY
         YHc5o370GHLpL7uI8+p/5f4P7oK1jAVHtsvEaAhJgF8YSmDPh/noT8XEfnbcPQDks3b7
         gxNzGEYNQLLZchP3HQb12ETLXt/8dFTyCcWTppIQlF2TeQraqDw4p2L+4yZ7PDXUr6ay
         JkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dm92NMg/irWYm67dt8+YBn2/6jTQ9TzkOqtUWA6VrWI=;
        b=QhODhAw7P8PWB45Shz/FXsb2yBRGwD/JywLj4Sf3G+HKp8ugt5SMnlepDP7LmOmu0/
         3LMscd9BBgtZSpXuzEZmD8F31kclSFXH2MFdEx3dLpP2jTU0D5wpFdtg4SaI/lY9D+Ax
         h+kBza+5yhabr5c0GgQNLj2cMGk5qiEp+DPetsNUQg5YIffUbMZeVWOxP6wDuJ65eCuU
         NhSdbSOHxYaacjcMT0l31/M6F/vTdW011vgtDBo5232fZUo7dn2CQ1+u7T2F3EIlXwKw
         u0LtIoIreJ3hwYiQXhVL2j5k1CDXDu14XWv/sWUXBe1ngHfdb5Syvc1MG0++l6ZRXdWg
         bq6w==
X-Gm-Message-State: APjAAAU8L8ErRqP70/5WF4yT9oVfVG9KEME3cTPJI7X7rTgw7q8ba3J0
        vu5Ozd8aWQtlF1951qd3jFlcx6mzp1U=
X-Google-Smtp-Source: APXvYqz2SUUxfTRXqHXtROHqq1m4xLNgV7VQvQ3ExC8VNSaEKLn8PruSvg/xWzUGxMEw6RaeEAWrIg==
X-Received: by 2002:a5d:45d2:: with SMTP id b18mr14652442wrs.219.1558426626015;
        Tue, 21 May 2019 01:17:06 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id j28sm35644979wrd.64.2019.05.21.01.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 01:17:04 -0700 (PDT)
Subject: Re: [PATCH 0/2] nvmem: meson: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190520143732.2701-1-narmstrong@baylibre.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <fccd03e5-98a6-90dc-a7bc-889fb0575712@linaro.org>
Date:   Tue, 21 May 2019 09:17:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520143732.2701-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/05/2019 15:37, Neil Armstrong wrote:
> Update the SPDX Licence identifier for the Amlogic NVMEM drivers.
> 
> Neil Armstrong (2):
>    nvmem: meson-efuse: update with SPDX Licence identifier
>    nvmem: meson-mx-efuse: update with SPDX Licence identifier
> 
>   drivers/nvmem/meson-efuse.c    | 10 +---------
>   drivers/nvmem/meson-mx-efuse.c | 10 +---------
>   2 files changed, 2 insertions(+), 18 deletions(-)
> 
Applied!


Thanks,
srini
