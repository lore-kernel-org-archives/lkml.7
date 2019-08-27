Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B335C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D932173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566864901;
	bh=tSwVld8MM/cOgBLeA2MiA5uHgn0imrIC4cq8obSMK/E=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=LNsX/BFdMiVKEoDK7CIKGL5itMKu7uSy10zoJciKM0q2dQYEvJeOMHdx8C2HOAPkG
	 D1KgtTjCi9tl7Hae1ILhnmUn8xvq1X/aSxN353P9JUKNJjeOtcfDxvFFLSaZbqkoCH
	 c2yzOHBD7sZemU6vZOf289/YIC5LUs2bU5GhX8SQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfH0APA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 20:15:00 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46366 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfH0AO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 20:14:59 -0400
Received: by mail-io1-f68.google.com with SMTP id x4so41812089iog.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 17:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+QMCinwwBEDqKLCmDU4DlJ6py1ELvU6M8qGgkaHN8sw=;
        b=aCPbHhxoXL4tzq4ideSgYvCJLLRssa4FaK69iATvTb/eoxm/kuRpEGKmnnD6Odc/Mr
         LGxjHF2v//lCnJOXFnva7cWO9WtN68CNjU44RYnJAp8Ui+VpTtLqUKrpPix2zZCqoffq
         FcllTBQIKVbx4qt2+lEAud/Xw61AEt6rk9L5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+QMCinwwBEDqKLCmDU4DlJ6py1ELvU6M8qGgkaHN8sw=;
        b=mMYe77CH27r+Y1tlqqHkVR3QaPcoGlKiI75JwaP/Yi87ePO27dtuSNkyCu18ll7F1s
         T3He+xI2CMtTQl96uWDqrU0AoxajZt6e07ZnduL6D+8HOll/e19+lbOAh3sW35h9IiFn
         wODihnie4Q0zRTQ/BZuqef7F67jOeIEHCb2BM+/0K3BXKHIi1MdWB1Nv89yOPOXYP4V0
         PVZAJbYbCuFkTfPN1JneLD3hz5AcLzBfPxhqzDUm2jU4/GVTNykTnmtR6UpX+5YtTB47
         2GTDNpDvSipVGareuyeOg0FQ7/9LeAXx/kCpo5ROMPDudv8p1c1TFw7y5aBMqW/mrzvI
         AKAg==
X-Gm-Message-State: APjAAAXAMD6nIiFmnDJ1BYkgIyZDSz6VUaGzRdYIcwUzm0qVHpqXjWrs
        F6bb2xYksBziHU9f1ultfiVzOA==
X-Google-Smtp-Source: APXvYqywJ/qpqys4wO4lLVKl1zfBmSdBUgW1qHv0/O6Bbnm8djpRCLarxiWGQOeEn1FSGc8aQvL6lQ==
X-Received: by 2002:a6b:3784:: with SMTP id e126mr23249715ioa.8.1566864898909;
        Mon, 26 Aug 2019 17:14:58 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w5sm16657506iom.33.2019.08.26.17.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 17:14:58 -0700 (PDT)
Subject: Re: [PATCH] doc: kselftest: update for clarity on running kselftests
 in CI rings
To:     shuah@kernel.org, corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20190827000753.25081-1-skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <473cff26-9c01-fb72-12c5-e25535a3c129@linuxfoundation.org>
Date:   Mon, 26 Aug 2019 18:14:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827000753.25081-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/19 6:07 PM, Shuah Khan wrote:
> Update to add clarity and recommendations on running newer kselftests
> on older kernels vs. matching the kernel and kselftest revisions.
> 
> The recommendation is "Match kernel revision and kselftest."
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>   Documentation/dev-tools/kselftest.rst | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index 25604904fa6e..e55d9229fa8c 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -12,6 +12,31 @@ write new tests using the framework on Kselftest wiki:
>   
>   https://kselftest.wiki.kernel.org/
>   
> +Recommendations on running kselftests in Continuous Integration test rings
> +=========================================================================

Sorry. I missed the "WARNING: Title underline too short."

Will send v2 with this corrected.

thanks,
-- Shuah
