Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C0EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B5A20693
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfC1QbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:31:07 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:32977 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726322AbfC1QbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:31:07 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 9XvchJGCFUjKf9XvfhtWH8; Thu, 28 Mar 2019 17:31:04 +0100
Subject: Re: [PATCH v3 1/2] media: atmel: atmel-isc: reworked driver and
 formats
To:     Eugen.Hristev@microchip.com, linux-media@vger.kernel.org,
        Nicolas.Ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org
Cc:     ksloat@aampglobal.com
References: <1553786825-16942-1-git-send-email-eugen.hristev@microchip.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <da4dce14-b100-90a6-2d3e-86072a5119f0@xs4all.nl>
Date:   Thu, 28 Mar 2019 17:30:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1553786825-16942-1-git-send-email-eugen.hristev@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCBYL4dumaM0XN6AwgS1+hUWELhSCXx/+haLvJmh8HKtbxPFfj4OWSKspkF1wlu/Q0G9FBPCAU4ejfDKVG+YCG64vl9zTbXV88MaApV/xfoJlCTZGtlU
 WXBlx284/Bv7EghxJGUFAgrEZ7f7MwrczM3gCeYqfdWFlZfxaR27rtAkJb1tnWn+ysUzNoN2dDlXnqiKqpQTR6Rc1zTBT2SbAFDHGqK19eZYpMeTj3t0Ff6M
 hsrWLbNCuXGem2OGSfeTn6BtnvTf8HjtTC/LDh9giEeUNB+76CrVj86wN8dBTCNjZf6ov7GIn6epetVY+j7vfu66RarlwrO47AgILbaU7Z8iVWBkPpm8II7v
 NcPbti5pDQ2WzfLY6wWoPmx+RepRPJ/F/WIkTCof+K87LeKCrvOc7BT+h4GpUEjn0R8k0YWK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen,

On 3/28/19 4:32 PM, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> This change is a redesign in the formats and the way the ISC is
> configured w.r.t. sensor format and the output format from the ISC.
> I have changed the splitting between sensor output (which is also ISC input)
> and ISC output.
> The sensor format represents the way the sensor is configured, and what ISC
> is receiving.
> The format configuration represents the way ISC is interpreting the data and
> formatting the output to the subsystem.
> Now it's much easier to figure out what is the ISC configuration for input, and
> what is the configuration for output.
> The non-raw format can be obtained directly from sensor or it can be done
> inside the ISC. The controller format list will include a configuration for
> each format.
> The old supported formats are still in place, if we want to dump the sensor
> format directly to the output, the try format routine will detect and
> configure the pipeline accordingly.
> This also fixes the previous issues when the raw format was NULL which
> resulted in many crashes for sensors which did not have the expected/tested
> formats.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

I'm getting a few smatch warnings/errors:

drivers/media/platform/atmel/atmel-isc.c:1368 isc_try_fmt() error: we previously assumed 'sd_fmt' could be null (see line 1343)
drivers/media/platform/atmel/atmel-isc.c:1078:35: warning: variable 'rgb' set but not used [-Wunused-but-set-variable]
drivers/media/platform/atmel/atmel-isc.c:1078:22: warning: variable 'yuv' set but not used [-Wunused-but-set-variable]

Can you take a look?

Thanks!

	Hans
