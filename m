Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09047C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E9E21D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570190327;
	bh=h3nDtFSFPGubCmxYCYIQZk23q7m6iNvYVirVhDa5gwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CCyesCLpCDqhj+Md2Sq0MOFujvZErU3Ov8eAsWK+J2Qc5/S9coIPDNDincj9n9a5M
	 ohn6M58q0v5YcLseduXyAwD89wKofiBV0I0Y4+6yZ5rPR6L7R5MqsoKSnY1WbLQBtD
	 imhgm7x6EcjsIVLXNluldHbAhBHQc8Umqy6xPF8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfJDL6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 07:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfJDL6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 07:58:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 958E320862;
        Fri,  4 Oct 2019 11:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570190326;
        bh=h3nDtFSFPGubCmxYCYIQZk23q7m6iNvYVirVhDa5gwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y+cSVO/oWtjl7vKnvb6bfyYDIeBE2Ro2fFi3jbnJmbWIr9blZc9478o1udziH/KP5
         ibvdwnnVzHsuoW8mkb62MVGaZDrMZIGgGEwtdzMf9TP2UYs+sUe9U8F/gwKUTqYthw
         s0OwDGGnNWDTjUomFkPAd4ARIo+gYfVTYRBooBRE=
Date:   Fri, 4 Oct 2019 13:58:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
        dianders@chromium.org, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hui Peng <benquike@gmail.com>, linux-pm@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Mans Rullgard <mans@mansr.com>, Pavel Machek <pavel@ucw.cz>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH 1/2] usb: support suspend_noirq
Message-ID: <20191004115843.GA339043@kroah.com>
References: <20190917212702.35747-1-abhishekpandit@chromium.org>
 <20190917212702.35747-2-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917212702.35747-2-abhishekpandit@chromium.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 02:27:01PM -0700, Abhishek Pandit-Subedi wrote:
> If we put a usb device into reset in the suspend callback, it will
> disconnect and the resume will not be called. In order to support
> turning off the device on suspend and restoring it on resume, we must do
> the reset action in suspend_noirq.

That's a bit odd given that USB drivers/devices _require_ irqs to be
enabled in order to talk to them and work properly.

So I don't see how this works at all, nor how any USB driver could even
use this.

greg k-h
