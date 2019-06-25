Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DE9C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF8420883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfFYRJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:09:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58508 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfFYRJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:09:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 366BD2604D6
Subject: Re: [PATCH v3 0/2] Support accelerometers for veyron_minnie
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        bleung@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com, dianders@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190624225312.131745-1-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <5326bfb8-611f-765b-1c9c-c95032102c71@collabora.com>
Date:   Tue, 25 Jun 2019 19:09:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624225312.131745-1-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/6/19 0:53, Gwendal Grignou wrote:
> veyron_minnie - ASUS Chromebook Flip C100PA - embedded controller
> controls two accelerometers, one in the lid, one in the base.
> However, the EC firmware does not follow the new interface that
> cros_ec_accel driver use.
> Extend the legacy driver used on glimmer - Lenovo ThinkPad 11e
> Chromebook - to veyron_minnie.
> veyron_minnie being ARM based, issue command over the I2C bus to the EC
> instead of relying on the shared registers over LPC.
> 
> Gwendal Grignou (2):
>   iio: cros_ec: Add sign vector in core for backward compatibility
>   iio: cros_ec: Extend legacy support to ARM device
> 
> Changes in v3:
> - Fix commit message, add reviewed-by for first patch.
> 
> Changes in v2:
> - Readd empty line to reduce amount of change in patch.
> - Remove Keywords used by ChromeOS commit queue.
> 
>  drivers/iio/accel/Kconfig                     |   4 +-
>  drivers/iio/accel/cros_ec_accel_legacy.c      | 350 ++++--------------
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |   4 +
>  .../linux/iio/common/cros_ec_sensors_core.h   |   1 +
>  4 files changed, 84 insertions(+), 275 deletions(-)
> 

Just a side note that I think that this patch depends on [1] to have the legacy
sensors working on veyron minnie.

For the full series:

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


[1] https://lkml.org/lkml/2019/6/18/268
