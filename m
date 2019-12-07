Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C1FC2D0BE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 18:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08782176D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 18:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QzCesKk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfLGSrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 13:47:46 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:44066 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfLGSrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 13:47:46 -0500
Received: by mail-pj1-f68.google.com with SMTP id w5so4100080pjh.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 10:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g+o/W2tR+ah1gbz9xvaeab3ecUOZuYjDYmgHNmd5AdE=;
        b=QzCesKk5H/QnhxdZttmRJxvB/kk5/osU5f08u62cZbz6Sxjf3Af66LOC5a+oHqhwey
         3uIDSo1Fut3CXd3pqgvuUReoF2SLaLNOwW6RG5Tx62sPg57BPpJCWbspYo5ZgDDHa0O3
         DiqZlUMOdguYLOKoQ2o8Bscf+q/Rs7+ueQ7Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g+o/W2tR+ah1gbz9xvaeab3ecUOZuYjDYmgHNmd5AdE=;
        b=VRU4+VT/nyqa0yv6pRdVNpk/FQFLw/fpQrRGFlnNwGw/tUSVOJqRY/KfFqOOR+QIKf
         n9BA5U9tHMMLsAAzfOPJ7K0tSO4kV+omcpjF3gc25K0jLxIhM+g4HkNTkA+RTamEsLQe
         8QeSVAzyWas/WmeQHmo01ml76//TH2Nb8hWkR0biqxgReg3OGTE69wdpGm3HbIi5L3CA
         +LBHFd2R9X7oPmAR2lvDA3fKsT3RLopZSUIbcjXl2Fe+X17ZPlbWDaKR9kEUvt7+Bv0/
         N2sDj9GTswIRyhuwfEwn8Ti11gRftEFpTfZwux2QFtlnc3w5kHyjl14fn0PsFXjpx/ey
         WIBA==
X-Gm-Message-State: APjAAAUxI6UFNYnDiHHFJG0xGKn4pqUEz9wkJEqCs6iRx3CEyygXAlBW
        uTbj8UtQv4cBM49/tQczb0uYXg==
X-Google-Smtp-Source: APXvYqwa3Dpc/KviQQujS/dXWsgQA88nMekSICflPCXO5hSENoJJVcES/7cGhMq4ddCjmdTCfeonoA==
X-Received: by 2002:a17:902:ba84:: with SMTP id k4mr20720961pls.141.1575744465750;
        Sat, 07 Dec 2019 10:47:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u190sm5112943pfb.60.2019.12.07.10.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 10:47:44 -0800 (PST)
Date:   Sat, 7 Dec 2019 10:47:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj38.park@gmail.com,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH 1/2] kselftest/runner: Print new line in print of timeout
 log
Message-ID: <201912071047.E373E19A97@keescook>
References: <20191202114221.827-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202114221.827-1-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 12:42:20PM +0100, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> If a timeout failure occurs, kselftest kills the test process and prints
> the timeout log.  If the test process has killed while printing a log
> that ends with new line, the timeout log can be printed in middle of the
> test process output so that it can be seems like a comment, as below:
> 
>     # test_process_log	not ok 3 selftests: timers: nsleep-lat # TIMEOUT
> 
> This commit avoids such problem by printing one more line before the
> TIMEOUT failure log.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Acked-by: Kees Cook <keescook@chromium.org>

Cool, yeah, this looks fine to me. Nice idea!

-Kees

> ---
>  tools/testing/selftests/kselftest/runner.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index 84de7bc74f2c..a8d20cbb711c 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -79,6 +79,7 @@ run_one()
>  		if [ $rc -eq $skip_rc ]; then	\
>  			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
>  		elif [ $rc -eq $timeout_rc ]; then \
> +			echo "#"
>  			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
>  		else
>  			echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"
> -- 
> 2.17.1
> 

-- 
Kees Cook
