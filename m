Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E87C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361552184E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566192279;
	bh=KnQUYsBysaPZtON49fRlPYPJ8D4Jh+VL4Lq0gz6ES5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ltOL6VioH7ZpVA4LJLd7MP2TEpbVa1pxKUXq2aeqxzEnMi1YnEySbYjTxuvAlD4Tw
	 zRsf26rvr9DjH3ffcB7NoE9j7VYTOwypV8193yCOdsBDXVWQiR1c3nXn/OoUrUcKb9
	 GJyDrOkyjFyON074dUpf7nEi4Ub+wA0szhIJ4d+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfHSFYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 01:24:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40510 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfHSFYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:24:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so488507pgj.7;
        Sun, 18 Aug 2019 22:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qsOsVTcbsaLeAXjaK1311MO5YXkzY4kusyeavtQleX8=;
        b=XYwkzW7whuL3+6k5un5KyKvGQs72ZzW20n50dtyxhXYm+FKHLugFb5c0WNBZRU7Pqf
         w7iMncsIHElNnQYw7kR70cJQpyjS6fhD7dEq0oPYR+D1ahT0dsdPvkJzZkM4Upwm+cFT
         FaJlanj0JK3Ul6iSXKPT0vKNooGLc+nyrBIJbsqawjL/R7iaq0HrG0OjfRNQ9CcOyaP5
         w8nyzMmSjXDQsbO3UkgAQm68z58FWEwC10Tztmk4BlgZWJDco6Entj/RL1EwvvqBk/hB
         xEDiMIcPV6KKT1CYs/ErEefx8/o+Jlrt/idfs/VF9I1r3WcD2+afmFXZG6aZf3aj07iK
         q1tw==
X-Gm-Message-State: APjAAAWGEyEeuPbyUbSswIK545l5VN4dRrn9gfOG4u0J6xatoDYKdb7o
        7OwxzM31p1LfBvIi4osyP/E=
X-Google-Smtp-Source: APXvYqwkbh9HqpVG8ze4MM0YPxmcbSEVBB8UcElBg30R1v+jI+Z9IZAit39AmArkQuiAxWfl80sdGw==
X-Received: by 2002:a65:6102:: with SMTP id z2mr18245403pgu.391.1566192276938;
        Sun, 18 Aug 2019 22:24:36 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id n28sm14058892pgd.64.2019.08.18.22.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 22:24:35 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 6D95F40605; Mon, 19 Aug 2019 05:24:34 +0000 (UTC)
Date:   Mon, 19 Aug 2019 05:24:34 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] test_firmware: add support for
 request_firmware_into_buf
Message-ID: <20190819052434.GP16384@42.do-not-panic.com>
References: <20190816000945.29810-1-scott.branden@broadcom.com>
 <20190816000945.29810-2-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816000945.29810-2-scott.branden@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 05:09:43PM -0700, Scott Branden wrote:
> Add test config into_buf to allow request_firmware_into_buf to be
> called instead of request_firmware/request_firmware_direct.  The number
> of parameters differ calling request_firmware_into_buf and support
> has not been added to test such api in test_firmware until now.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Thanks for the patch!

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
