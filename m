Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934EEC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776CF208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbfFSMY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:24:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40778 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfFSMY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:24:28 -0400
Received: from laptop-1.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 87E5E260701;
        Wed, 19 Jun 2019 13:24:26 +0100 (BST)
Message-ID: <55fe8db5c6bcc7e7736a099ce7d923b7752acb74.camel@collabora.com>
Subject: Re: [PATCH v3 0/8] Expose cros_ec_sensors frequency range via iio
 sysfs
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
To:     kernel@collabora.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Jun 2019 14:24:23 +0200
In-Reply-To: <cover.1560848479.git.fabien.lahoudere@collabora.com>
References: <cover.1560848479.git.fabien.lahoudere@collabora.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 18 juin 2019 à 11:06 +0200, Fabien Lahoudere a écrit :
> Chromebooks EC sensors must expose a range of frequencies for each
> sensors using
> the standard ABI sampling_frquency_available.
> 
> Changes since v2:
> 
> - use read_avail callback
> - rework core functions to avoid code duplication

- now sample-frequency-available sysfs return a list of known
frequencies instead of a range, because the step depend on sensors
(fast vs slow) and is hidden by EC.
See https://patchwork.kernel.org/patch/10957141/#22662201

> 
> Changes since v1:
> - Add a cover letter
> - Add Nick Vaccaro SoB to patch 1
> - Drop fifo size related code
> 
> Fabien Lahoudere (8):
>   iio: common: cros_ec_sensors: move iio_info management to core
>   iio: common: cros_ec_sensors: move channels to core structure
>   iio: common: cros_ec_sensors: move registration to core
>   iio: common: cros_ec_sensors: clean code
>   iio: common: cros_ec_sensors: use core structure
>   iio: common: cros_ec_sensors: support protocol v3 message
>   iio: common: cros_ec_sensors: add sysfs attribute for frequencies
>   docs: iio: add precision about sampling_frequency_available
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |   7 +-
>  .../common/cros_ec_sensors/cros_ec_sensors.c  | 148 +++++------
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 230 +++++++++++++++-
> --
>  drivers/iio/light/cros_ec_light_prox.c        | 124 ++++------
>  drivers/iio/pressure/cros_ec_baro.c           | 101 +++-----
>  .../linux/iio/common/cros_ec_sensors_core.h   |  43 +++-
>  6 files changed, 357 insertions(+), 296 deletions(-)
> 

