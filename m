Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89D4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AA12089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="XKoW+37/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfJOF5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:57:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40920 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfJOF5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:57:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id v38so16800974edm.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 22:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+dEWfTewt7R9RPkQAlrQgcj1STfoqf3Bg7CtuX6pXcc=;
        b=XKoW+37/mB+Yqe8NNl4kODT5jbFVZMlxj0JzDJznPsAhffJWy3GpoXcr0hhJb5VVC3
         hCa/wNHwk/W/RE+5rjPktivUUv3rwSY11L7hH60TziQ41mg7HrWBoU8NCebmu8rJFIVr
         2atccDpovKo2liFFWRJRkexnOs/s2rRsf8MiAKMSMU+v86SO+1MvMyEQOd5ZFqVWbqn5
         e9e2ZrQeL+fK8vu69FoUV9SFPGmepwzZGvCiHqfHCKY68Io8TDsfi4t94W00aYvur9pA
         QvHiP4Whx0RfUW1ap5DrPGP/1WClPDAJpCb+OX2xHHjAISt0f6if3yBXdDsEBKM0qSgK
         +vdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+dEWfTewt7R9RPkQAlrQgcj1STfoqf3Bg7CtuX6pXcc=;
        b=Hxp//uFSRh83M6g0h2MHIPlzWOHG+k+6Ychn2oQGA7OX+wqbkMIKmeErLXMleOTbpi
         UOMyBvVI6QnhhRcRxkrIqKjzDgMseCgT4fFEgDIo9V8dXVqsD1ZfvtJDYwy0XlE93hM2
         Ge/QAeWKzNtsiBaaInaQiaCKRBHojUQQYmOtb3gfyidVd6No4/h/XS52LLKxq01aILyg
         huEPUZZe1U+31cY/s7PPWdfbGc5QV3UXy2o5MS2lO7LVdN0g6AvrslG+2M4X424uLONM
         +UQRRN84RcccJG9neREoZC4Sx1jI9D21MTIIOBNKMXkc0UkvLoKTdSlt6kuf0M3nvcjt
         nnEQ==
X-Gm-Message-State: APjAAAXeg3BvvxMww+t7+a3idAXgzuiR6Akj84tSiyrt9duXgbIdWfAA
        Tkw4Kt2Oykpw6qQBjWmAydZe0A==
X-Google-Smtp-Source: APXvYqwPP2OQtbMJgFsKI1Fn0SmCDt4h7hlgMbPCaER/eZIM88e8JB3Qs4CXw2bL9m3OA/v94kIbXA==
X-Received: by 2002:a50:f315:: with SMTP id p21mr31564386edm.83.1571119068326;
        Mon, 14 Oct 2019 22:57:48 -0700 (PDT)
Received: from netronome.com (penelope-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:c685:8ff:fe7c:9971])
        by smtp.gmail.com with ESMTPSA id c15sm3529833edl.16.2019.10.14.22.57.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Oct 2019 22:57:47 -0700 (PDT)
Date:   Tue, 15 Oct 2019 07:57:22 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Pankaj Sharma <pankj.sharma@samsung.com>, kbuild-all@lists.01.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wg@grandegger.com,
        mkl@pengutronix.de, davem@davemloft.net,
        eugen.hristev@microchip.com, ludovic.desroches@microchip.com,
        pankaj.dubey@samsung.com, rcsekar@samsung.com,
        Sriram Dash <sriram.dash@samsung.com>
Subject: Re: [PATCH] can: m_can: fix boolreturn.cocci warnings
Message-ID: <20191015055718.mypn63s2ovgwipk3@netronome.com>
References: <1571052844-22633-1-git-send-email-pankj.sharma@samsung.com>
 <20191014150428.xhhc43ovkxm6oxf2@332d0cec05f4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014150428.xhhc43ovkxm6oxf2@332d0cec05f4>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 11:04:28PM +0800, kbuild test robot wrote:
> From: kbuild test robot <lkp@intel.com>
> 
> drivers/net/can/m_can/m_can.c:783:9-10: WARNING: return of 0/1 in function 'is_protocol_err' with return type bool
> 
>  Return statements in functions returning bool should use
>  true/false instead of 1/0.
> Generated by: scripts/coccinelle/misc/boolreturn.cocci
> 
> Fixes: 46946163ac61 ("can: m_can: add support for handling arbitration error")
> CC: Pankaj Sharma <pankj.sharma@samsung.com>
> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---
> 
> url:    https://github.com/0day-ci/linux/commits/Pankaj-Sharma/can-m_can-add-support-for-handling-arbitration-error/20191014-193532
> 
>  m_can.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -780,9 +780,9 @@ static inline bool is_lec_err(u32 psr)
>  static inline bool is_protocol_err(u32 irqstatus)
>  {
>  	if (irqstatus & IR_ERR_LEC_31X)
> -		return 1;
> +		return true;
>  	else
> -		return 0;
> +		return false;
>  }
>  
>  static int m_can_handle_protocol_error(struct net_device *dev, u32 irqstatus)
> 

<2c>
Perhaps the following is a nicer way to express this (completely untested):

	return !!(irqstatus & IR_ERR_LEC_31X);
</2c>
