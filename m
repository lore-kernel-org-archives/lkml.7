Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6572EC5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E6620869
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbfKFImE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:42:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:51316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729881AbfKFImE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:42:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F6E3ACA4;
        Wed,  6 Nov 2019 08:42:02 +0000 (UTC)
Subject: Re: [RFC 05/11] dt-bindings: soc: realtek: rtd1195-chip: Extend reg
 property
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org
References: <20191103013645.9856-1-afaerber@suse.de>
 <20191103013645.9856-6-afaerber@suse.de> <20191106044605.GA28959@bogus>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <202d501d-f548-24c6-b99c-652a59a9e255@suse.de>
Date:   Wed, 6 Nov 2019 09:42:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106044605.GA28959@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.11.19 um 05:46 schrieb Rob Herring:
> On Sun, Nov 03, 2019 at 02:36:39AM +0100, Andreas Färber wrote:
>> Allow to optionally specify a second register to identify the chip.
>> Whether needed and which register to specify depends on the family;
>> RTD1295 family will want the CHIP_INFO1 register.
>>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> ---
>>  A SoC specific binding would defeat the purpose of the generic Linux driver;
> 
> Why? You can map any number of compatibles to a generic driver.

Because the purpose of the driver is to read from the registers which
chip it is. If we tell it via the compatible what it is supposed to be,
1) only the revision would need to be read, and 2) how should it react
if the compatible tells it one thing and the register value another.

Also it doesn't solve the problem that we may need to extend the binding
as new models emerge, or instead of just rtd1195, rtd1295, rtd1395, etc.
we'd also need one for each chip, i.e., rtd1296, cf. 1) above.

>>  is it possible to check the root node's compatible in an if: expression
>>  to prohibit using more than one reg on "realtek,rtd1195"?
> 
> The "rule" is different programming model, different compatible string 
> for the block.

Agreed in general.

> But this looks simple enough, I don't really care.

Hope you also read the cover letter wrt syscon? That would probably
obsolete this binding then and require to move the driver's logic into a
module init instead for lack of dedicated compatible to bind against,
like Meson does.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
