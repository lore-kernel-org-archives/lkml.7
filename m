Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28FAC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4FE20857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bkpeecAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfDHQBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:01:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37141 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfDHQBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:01:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so17085934wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 09:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fnQ9ep8ZjHl0Gts8g7ewutoemUGbpOF05W1ijO3/8Z8=;
        b=bkpeecAwsGok80iu3HUgTnB1jhHdaDexQndgVxu4wzqM/9hK1edrxcR9X0Ee1y+zVq
         fGpfG0Sn5GG8ibA68dV5O45F+YCLixHJ/lqZ/gPSG9W/PTuYqNrB7vy+Gg0LjYRnNDZw
         3Ctv6N2LMaxoxZkZ9leNd9dUbM0XY6AqHJyuLK1bdqYQArYJNHWEOTgHPPiicslOiHE8
         ssGVYktZ9uuv9ccmIOOM1dvONrG5Aeu8IpfM9BAIDT+tC3DUipfdlCYFXAhmKRIlJAZ1
         jU+XlENhI4Enfl8gkciZzo+MMgEbqrz7rNhAe/7y9gNkrjE17tzclZJ9N3YAhlY1dmwb
         EOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fnQ9ep8ZjHl0Gts8g7ewutoemUGbpOF05W1ijO3/8Z8=;
        b=AAUd7/bT0pU8w2oUqY6rmpSELOtakqup80N2pAXzfWPWn0iFBYhfM4RasmR2cL2eZZ
         lgC/QqMKSTtZd4VtGEI1asrD04k/7Qgz/40VDxnzonF3l8YZHo/7hMPts52utYdrCQ9m
         YnrUzLmguplah3lGMYo82II6Rcx38OAudDzbMrP/aA1Dggszut+rdu9+7sPl0czsdq+K
         a/P0lNlz1u9xWKoGl+Q9bnRQty5jfLSfKrCKsntzDmdH3HrwORkxof8xFFJSTTXCsqz/
         gbHkCMdznLv+YEyWUgXDyXh7tk8shRbME5rHxSdJXr1hSYIAzHHnHP1AUftbsiSSeJAX
         e+rw==
X-Gm-Message-State: APjAAAW443MoNYf9v4tf5O1k9Ru1F7Byb4NDVLDrGPwRWiSqdxF6Q+J9
        cUSuadvmPMUMyjfQy5LUToVptxUvBN0=
X-Google-Smtp-Source: APXvYqz4U8yyCyEPPJ98ztZ1/DW/dzRyrNsiFxJMB9UsNNIGXbjlOQ9nw1M/V92MX1NEeWr1Ui0QPA==
X-Received: by 2002:adf:f110:: with SMTP id r16mr18533806wro.153.1554739272798;
        Mon, 08 Apr 2019 09:01:12 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 7sm103571165wrc.81.2019.04.08.09.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 09:01:12 -0700 (PDT)
Subject: Re: [PATCH v2] Add COMPILE_TEST to CONFIG_ARM_TIMER_SP804
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
References: <20190408080745.22012-1-david.abdurachmanov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c2d5551a-e593-4a26-6c3d-f4cbf6c45dcd@linaro.org>
Date:   Mon, 8 Apr 2019 18:01:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408080745.22012-1-david.abdurachmanov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2019 10:07, David Abdurachmanov wrote:
> This is only used on arm and arm64 platforms. Add COMPILE_TEST option.
> 
> Tested with 5.1-rc3+ on Fedora/RISCV. CONFIG_ARM_TIMER_SP804 no more shows
> up in riscv config.
> 
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>

Applied for 5.2

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

