Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B52C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FCB2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554972813;
	bh=TjmBak9eIUg4Gs4XABfTfdyrm/SsN3+af+vk1upbfAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qr7+DmrPmAVhjonDpTYEUodCH8reUmmEWRN8YijMb+Hcd0GrUp0vWJLDg/UhVc+8D
	 E+7GxKaP5sN6NI/6fuA2q3iHdvyvJvd+d2r85EVQGB5bc2uL7We7OuLeyt0M7ZNA8C
	 DTWy1UqQCteXHY71U4WeZVOnLIXHIT6z+2GfrhOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfDKIxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfDKIxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:53:32 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D032184B;
        Thu, 11 Apr 2019 08:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554972811;
        bh=TjmBak9eIUg4Gs4XABfTfdyrm/SsN3+af+vk1upbfAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dvZz7i7WCm2Q8jFAHqcgXfH4IvBiglc+Wl+OnMq4BtnP/PV2yh11vDgYhOFHl8QBF
         PvyhtJP1pe+uwAo+v9fOAiaM1bc5xOtho9L3yMx62vnhplUoJlKQXOFoFQn+Kb97tL
         T+1gQpoc+/SaLw/ZxZTPEAyoZ+lnth/bpJ4HRkDo=
Date:   Thu, 11 Apr 2019 16:53:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH 12/22] watchdog: zx2967_wdt: Convert to use device
 managed functions and other improvements
Message-ID: <20190411085316.GG3050@dragon>
References: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
 <1554913683-25454-13-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554913683-25454-13-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 09:27:53AM -0700, Guenter Roeck wrote:
> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
> Other improvements as listed below.
> 
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Drop assignments to otherwise unused variables
> - Drop empty remove function
> - Use devm_add_action_or_reset() for calls to clk_disable_unprepare
> - Use local variable 'struct device *dev' consistently
> - Use devm_watchdog_register_driver() to register watchdog device
> 
> Cc: Jun Nie <jun.nie@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Shawn Guo <shawnguo@kernel.org>
