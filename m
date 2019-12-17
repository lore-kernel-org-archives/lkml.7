Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6D9C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18A32146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfLQTgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:36:43 -0500
Received: from mail.bugwerft.de ([46.23.86.59]:41634 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfLQTgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:36:43 -0500
Received: from [192.168.178.106] (pD95EF574.dip0.t-ipconnect.de [217.94.245.116])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 2FC83281AEB;
        Tue, 17 Dec 2019 19:30:17 +0000 (UTC)
Subject: Re: [PATCH 06/10] mfd: Add core driver for AD242x A2B transceivers
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        broonie@kernel.org, lars@metafoo.de, pascal.huerst@gmail.com
References: <20191209183511.3576038-1-daniel@zonque.org>
 <20191209183511.3576038-8-daniel@zonque.org> <20191217133952.GJ18955@dell>
 <20191217134617.GK18955@dell>
From:   Daniel Mack <daniel@zonque.org>
Message-ID: <ff062a37-e07d-3d6c-7fa5-9e6dc74b1aa9@zonque.org>
Date:   Tue, 17 Dec 2019 20:36:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217134617.GK18955@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 12/17/19 2:46 PM, Lee Jones wrote:
> One thing I should mention upfront; there is too much code "doing
> things" in here for it to be an MFD.  MFDs don't care about; syncs,
> slots, TDM, inverting lines, upstreams, downstreams, etc etc etc.
> Anything remotely technical or functional, the code that "does things"
> should be moved out to the relevant areas.  In the case of this
> device, that's looking like one of the Audio related subsystems.

Okay, that's good to know.

I in fact considered that when I started working on it; after all, A2B 
stands for "automotive audio bus". The reason why I didn't do it was the 
fact that these devices certainly do have multiple functions, where 
audio is just one of them, and there needs to be a 'top-level' layer 
that enables all these functions and does the node discovery etc. Hence 
I thought it's cleaner to separate things that way.

I can move things over to the ASoC layer for the next iteration, and 
then maybe also merge the codec driver with the baseline drivers. Let's 
see how this looks like then.


Thanks,
Daniel
