Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA7CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5A622CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfICIsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:48:47 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:46233 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726557AbfICIsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:48:46 -0400
Received: from [109.168.11.45] (port=41926 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1i54UU-002hxn-8d; Tue, 03 Sep 2019 10:48:42 +0200
Subject: Re: [RFC,v2 2/6] i2c: add I2C Address Translator (ATR) support
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-media@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Peter Rosin <peda@axentia.se>
References: <20190723203723.11730-1-luca@lucaceresoli.net>
 <20190723203723.11730-3-luca@lucaceresoli.net> <20190902204208.GA7253@kunai>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <8482d1e2-b1d9-3da5-5b1f-b7e492a87368@lucaceresoli.net>
Date:   Tue, 3 Sep 2019 10:48:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902204208.GA7253@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On 02/09/19 22:42, Wolfram Sang wrote:
> Hi Luca,
> 
>> + * Topology:
>> + *
>> + *                       Slave X @ 0x10
>> + *               .-----.   |
>> + *   .-----.     |     |---+---- B
>> + *   | CPU |--A--| ATR |
>> + *   `-----'     |     |---+---- C
>> + *               `-----'   |
>> + *                       Slave Y @ 0x10
>> + *
>> + * Alias table:
>> + *
>> + *   Client  Alias
>> + *   -------------
>> + *      X    0x20
>> + *      Y    0x30
> 
> Great that you already provided docs for this driver!
> 
> One huge drawback for me is the attach/detach callbacks. One year ago, I
> removed a similar callback from the I2C core ("[PATCH 0/2] i2c: remove
> deprecated attach_adapter callback") because some drivers did a lot of
> crazy things there. It took years to remove all that.

Oh dear, I was completely unaware, apologies! :-)

> What I could imagine here: the adapter (B and C each in the picture
> above) gets a flag like NEEDS_ATR before registering to the core. The
> flag means all clients on that bus will have their address translated.
> The core will figure out a free alias when a device is registered. We
> can then have an ATR specific callback with the original and translated
> address as arguments, so one can setup the HW as needed.

Do you mean moving the alias selection code from i2c-atr.c to the i2c
core? And the rest of the ATR core too?

> Do you think that would work?

Yes.

-- 
Luca
