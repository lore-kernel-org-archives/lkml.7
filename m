Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C6DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DF7206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="PHw+oaQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfKNKOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:14:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41073 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfKNKOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:14:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id m4so1086775ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 02:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yKV8dxOiEScgAwN6OBF9suS8/dIQha0dCo6DNyb9/qU=;
        b=PHw+oaQq3zDjRrAo5s06Wrz4lwdvT0aeeoSPWvFtEgufB6y07Xhe8J2mxSDLScPdqg
         PZ1p4LSGOOaFit6Nq46ecP8D6Gyn0H9s7xBKhI19pDLorflIFoICM1N6lyIumsepxKXY
         1SU0VOR4wUmEO5bpbCoD5K6eP2p2soD84LY1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yKV8dxOiEScgAwN6OBF9suS8/dIQha0dCo6DNyb9/qU=;
        b=Kf0f+BSuwarOANnPpukyFmAPv6QUe4kwS22VEXL/9UfTUt5Ms8jrE+hvOUAv71aX54
         XjCNYoXr91JjcmuG/ZrFHF1M31YYdwJcHSZjgYridMqvwlVndEyt7vEtFFjmnauMRhMa
         o20bYV5D/bH2jr7hUFuzw5ZsJG9lju5lLQCiroH3tC1vwYd/o5XFtOXsZkmdgSysYW1N
         gutZpyxmGS5d+Y9LiICh4xlwWJQGHskZY0y36T7FMfVtxtpOi3v+M1bb6BO5sHnSNC/7
         Vo5XjGJF3ntKc0Mo+ocpWmsdYgmf2Xfc1ertZc2btSrm0aCGGDD4QQO5V5mfOKUJB50G
         pk4A==
X-Gm-Message-State: APjAAAVHkShbTSvibrYN8bsPIUjzo6Ifofr4AVQO4Y/tje+CqNTgqbio
        3ynCvIPJqiZsnSr20HZNxpPnLQ==
X-Google-Smtp-Source: APXvYqydPgpnFrhr55Xe0j2BZelV6/8fVpMotZYa4SQhFvO/luzgFm0clsDDbvAzSpnBSbqHYzSz/Q==
X-Received: by 2002:a2e:81c6:: with SMTP id s6mr6045371ljg.61.1573726490246;
        Thu, 14 Nov 2019 02:14:50 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id j10sm2424676lfc.43.2019.11.14.02.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 02:14:49 -0800 (PST)
Subject: Re: [PATCH] checkpatch: don't warn about new vsprintf pointer
 extension '%pe'
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20191114100416.23928-1-u.kleine-koenig@pengutronix.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <7416d67e-c43a-516a-94f8-cf5d864a01f8@rasmusvillemoes.dk>
Date:   Thu, 14 Nov 2019 11:14:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114100416.23928-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2019 11.04, Uwe Kleine-König wrote:
> This extension was introduced in commit 57f5677e535b ("printf: add
> support for printing symbolic error names").
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Ack, of course. Petr, I think it makes most sense if this goes via your
tree unless there are other checkpatch patches touching the same place
(which I doubt, as I think we'd know about other new extensions).

Rasmus
