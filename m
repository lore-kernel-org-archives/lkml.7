Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C011C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C60F20811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552034427;
	bh=qStV+IPTjbVwCZoUC2332r8S3HijQFYtowqm9YN6fgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=spsCjbE6kE/dg/uTnCquDE4b2H5E2TT0uxgHSfTLXpfur7Lz+QIAiTvzVn5l2kNLS
	 CFhdrxBVw8k6GQlRsKvGD6cSZso1k0rrLNWdGz/neJGwr+33M0zmVKt4WYnmAtDF76
	 sVDj71431c/xph1tlc35Ycs2Ztx6OiH83h5qovWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfCHIk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:40:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfCHIkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:40:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 128B920811;
        Fri,  8 Mar 2019 08:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552034424;
        bh=qStV+IPTjbVwCZoUC2332r8S3HijQFYtowqm9YN6fgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bi3MxDCpWNY2AHEzWAryM1WaAYyiY1qoAWuEhViI8KCBOvfnyL6gSUIZPBclJdCe6
         V4JRkpmpqucsBo30JpN+gk+BFafEDHRT3x2mYS360Uc14sFHVOCZgPQsvK9F/HEpOs
         xepwxcTX6w4XE4L7sdxVQ9wZDXn8ZWZIKbQTdpvE=
Date:   Fri, 8 Mar 2019 09:40:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: -Wsometimes-uninitialized Clang warning in
 drivers/tty/serial/qcom_geni_serial.c
Message-ID: <20190308084022.GA31474@kroah.com>
References: <20190308004526.GA11580@archlinux-ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308004526.GA11580@archlinux-ryzen>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 05:45:26PM -0700, Nathan Chancellor wrote:
> Hi all,
> 
> We are trying to get Clang's -Wsometimes-uninitialized turned on for the
> kernel as it can catch some bugs that GCC can't. This warning came up:
> 
> drivers/tty/serial/qcom_geni_serial.c:1079:6: warning: variable 'baud' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>         if (options)
>             ^~~~~~~
> drivers/tty/serial/qcom_geni_serial.c:1082:37: note: uninitialized use occurs here
>         return uart_set_options(uport, co, baud, parity, bits, flow);
>                                            ^~~~
> drivers/tty/serial/qcom_geni_serial.c:1079:2: note: remove the 'if' if its condition is always true
>         if (options)
>         ^~~~~~~~~~~~
> drivers/tty/serial/qcom_geni_serial.c:1053:10: note: initialize the variable 'baud' to silence this warning
>         int baud;
>                 ^
>                  = 0
> 1 warning generated.
> 
> While this is probably not an issue in practice (I assume baud is always
> supplied as an option), we should clean up this warning. I would fix it
> myself but I have no idea what baud's initial value should be as it
> seems it is dependent on the driver. Your input would be much
> appreciated.

this function can be called with the option variable set to NULL, so
there could not be a default baud rate set, nice catch.

As for the default, let's just be sane and set it to 9600 as that's a
normal default baudrate.

Do you want to make up a patch for this, or do you need me to?

thanks,

greg k-h
