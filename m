Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C8ECA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9518621E6F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbfJ1JqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:46:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:40908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730038AbfJ1JqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:46:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5B172B239;
        Mon, 28 Oct 2019 09:46:21 +0000 (UTC)
Date:   Mon, 28 Oct 2019 10:46:18 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Rain Wang <Rain_Wang@Jabil.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] lm75: add lm75b detection
Message-ID: <20191028104618.5f21af38@endymion>
In-Reply-To: <7a2ddf42-8bbe-59e0-dae8-85b184ea0da0@roeck-us.net>
References: <20191026081049.GA16839@rainw-fedora28-jabil.corp.JABIL.ORG>
        <7a2ddf42-8bbe-59e0-dae8-85b184ea0da0@roeck-us.net>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Oct 2019 16:03:39 -0700, Guenter Roeck wrote:
> On 10/26/19 1:10 AM, Rain Wang wrote:
> > The National Semiconductor LM75B is very similar as the
> > LM75A, but it has no ID byte register 7, and unused registers
> > return 0xff rather than the last read value like LM75A.

Please send hwmon-related patches to the linux-hwmon list.

> > Signed-off-by: Rain Wang <rain_wang@jabil.com>
> 
> I am quite hesitant to touch the detect function for this chip.
> Each addition increases the risk for false positives. What is the
> use case ?

I'm positively certain I don't want this. Ideally there should be no
detection at all for device without ID registers. The only reason there
are some occurrences of that is because there were no way to explicitly
instantiate I2C devices back then, and we have left the detection in
place to avoid perceived regressions. But today there are plenty of
ways to explicitly instantiate your I2C devices so there are no excuses
for more crappy detect functions. Ideally we would even get rid of
existing ones at some point in the future.

This patch is bad anyway as it only changes the device name without
implementing proper support for the LM75B.

-- 
Jean Delvare
SUSE L3 Support
