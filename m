Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97305C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DF1218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567948240;
	bh=NAYPLVEs3d8lTLN9vlUsX64BY8z0IkvyD0HZkOy7nTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ne+FA+W8bKZnLfM0rOntLedosZGfz8ySK9yVrkPX61iFptVqSryH/J0Y0Mfj9Lz0A
	 x7hbEU8Oayt8x+/NnxqO5NWin8NZ7ZC/ycJT3nnsEikHW9X9bxPmF+1uAwjbnd/5cf
	 XvJsqZJ5v5Dnx0kKyD/U6oQ4x8xXbIyJQrrJTZIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfIHNKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 09:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfIHNKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:10:39 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F41C218AC;
        Sun,  8 Sep 2019 13:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567948237;
        bh=NAYPLVEs3d8lTLN9vlUsX64BY8z0IkvyD0HZkOy7nTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pyX+djyfoDDzzPGeGRLbB7tpnqTGC3oTmYjxc7i9puMcifiJx9hFqbSbIM6q99oe+
         GQhZ3r+iZGyJcdy45fXbfD3Nn9razRH6zbesuEdwZ8DvK2lx6aLWn5r6PEic7Gih5V
         62ff8zHh6ViKCxyi5TaTrtDDmBZyanYXZhD/laqE=
Date:   Sun, 8 Sep 2019 14:10:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 1/5] leds: remove PAGE_SIZE limit of
 /sys/class/leds/<led>/trigger
Message-ID: <20190908131034.GD9466@kroah.com>
References: <1567946472-10075-1-git-send-email-akinobu.mita@gmail.com>
 <1567946472-10075-2-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567946472-10075-2-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 09:41:08PM +0900, Akinobu Mita wrote:
> Reading /sys/class/leds/<led>/trigger returns all available LED triggers.
> However, the size of this file is limited to PAGE_SIZE because of the
> limitation for sysfs attribute.
> 
> Enabling LED CPU trigger on systems with thousands of CPUs easily hits
> PAGE_SIZE limit, and makes it impossible to see all available LED triggers
> and which trigger is currently activated.
> 
> This converts /sys/class/leds/<led>/trigger to bin attribute and removes
> the PAGE_SIZE limitation.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Dan Murphy <dmurphy@ti.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  drivers/leds/led-class.c    |  8 ++--
>  drivers/leds/led-triggers.c | 90 ++++++++++++++++++++++++++++++++++-----------
>  drivers/leds/leds.h         |  6 +++
>  include/linux/leds.h        |  5 ---
>  4 files changed, 79 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index 4793e77..8b5a1d1 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -73,13 +73,13 @@ static ssize_t max_brightness_show(struct device *dev,
>  static DEVICE_ATTR_RO(max_brightness);
>  
>  #ifdef CONFIG_LEDS_TRIGGERS
> -static DEVICE_ATTR(trigger, 0644, led_trigger_show, led_trigger_store);
> -static struct attribute *led_trigger_attrs[] = {
> -	&dev_attr_trigger.attr,
> +static BIN_ATTR(trigger, 0644, led_trigger_read, led_trigger_write, 0);

BIN_ATTR_RW()?

