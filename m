Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEE0C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DB120818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BK7oLng4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732574AbfHFKDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:03:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53691 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732543AbfHFKDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:03:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so77582657wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TwOhMGhMANMXvAFZPihyePA9NbKtnOP/KgFKclRHF+k=;
        b=BK7oLng4JJpIrJecvlzh3peO1eFaLtaQYBzGrT0Z6HrqZk0GiczmRg8lC+Kagnlwkk
         YYCcEqIeJYGpnsLnS83L1/Z3M1C7BsV9/eDAY14XoGJ9o61YKfMEA6bzHxCloqZEbj2K
         P8Y+ylJ0jAQy7JiP/LFSfjH3ERxZZfl+7Lwew36294Wy8aMg6ib0NyywtP4gHSs8LsOs
         ItNGmaQHIcOmBwvUDry5Hdctrk6RyoN9fWEYwzaY6qHEwKc7Tu824SqN8a5VaBHCbssk
         JPMd+2/zJWhft4iSdD9k0ZDTZh4GtHdz+s60ShlwBCGCBXw7ra99lQ2B3YfomOQl253n
         JUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TwOhMGhMANMXvAFZPihyePA9NbKtnOP/KgFKclRHF+k=;
        b=LcXEVs6qguwdMRiC//4WfzHRHCUObs5oL7j2LVQDWAoBCnA8uyncdePk8DN/4iY/Yn
         +rcuFTjtuj6vPkOefKqdcsPHVNuqU2zBYQYdu2oknMk6q721Ex1BuomCJXuKrJUUQ8dA
         luslRSRxW3ntfBH3+vrqVNKalLbOjXKZD7zg6Zc5jB0xIcVZAXIVXoxidEpeS9W9SKYr
         4h9NemJVu2b0heyQJbj5nTLsi8QDrxUtBcgw/YhiSqzVb2epvsKBnmCeiOmL02p1gsnw
         n1VllYBe0heP9LHOaC1CwY0TQTjK4Be0k5jD+24tqk8SibuZ4/qpI+y4ZJIVl1BPTlX2
         NHlw==
X-Gm-Message-State: APjAAAULDLwNEoXFb3we8zv0at8L6YXosQQxaFpUVlL3stVkV51gjxXi
        n9p24744/d+YJsc3NDMpuF6P4YAPmgI=
X-Google-Smtp-Source: APXvYqzB5aML87ltd0qmY/t6gnJ7NTu3qhxLEDRLnwurrlBIZmzqUYS5d/zxdu59Xvw/ARwQNjzltA==
X-Received: by 2002:a1c:343:: with SMTP id 64mr4020385wmd.116.1565085820389;
        Tue, 06 Aug 2019 03:03:40 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id a67sm109887567wmh.40.2019.08.06.03.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 03:03:39 -0700 (PDT)
Subject: Re: [PATCH v2] nvmem: meson-mx-efuse: allow reading data smaller than
 word_size
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190727193414.11371-1-martin.blumenstingl@googlemail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <375179fb-7cb6-0ec0-0c1a-b894c5198e15@linaro.org>
Date:   Tue, 6 Aug 2019 11:03:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190727193414.11371-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/07/2019 20:34, Martin Blumenstingl wrote:
> Some Amlogic boards store the Ethernet MAC address inside the eFuse. The
> Ethernet MAC address uses 6 bytes. The existing logic in
> meson_mx_efuse_read() would write beyond the end of the data buffer when
> trying to read data with a size that is not aligned to word_size (4
> bytes on Meson8, Meson8b and Meson8m2).
> 
> Calculate the remaining data to copy inside meson_mx_efuse_read() so
> reading 6 bytes doesn't write beyond the end of the data buffer.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Applied Thanks,
Srini
