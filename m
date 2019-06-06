Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E85C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 01:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED762070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 01:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUKFcbX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfFFBM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 21:12:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33557 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfFFBM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 21:12:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id g21so219600plq.0;
        Wed, 05 Jun 2019 18:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z0rX9Yy8SpIXXwEO7W1jMdg6A2lOgGKZlQ6sV8nLlQg=;
        b=IUKFcbX8T0eoiciJhYDGFAOFYZgXGat3UtmQ8b4HRsteUkfXAMzU2RHq1iRKEJaiaW
         vYxbTV/EKtVqseAMcoH6GAIjiWnFSvAM0U95GhIttS6+9GxqZraf1gDvdPeCcMZ0uICX
         jHtpQLY8IozpJ86j7TRS01/taa7ewX/Xe2YetfsGYQ/Qv0/IJlW64EKjbTbbZw/2ZBn0
         WioXPkpzdjsu57lFTrULw/Mn5mM3w0b57ABNWFMOLjq/NPk4IWhirjodv8/3sBRhI8E8
         ipXDOvzVXyIHK4jrQAZmiTw24qFUQRLBlKjwkPu/gC1UsolUAP8vDyDpvEpI9x18Ghq5
         cRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z0rX9Yy8SpIXXwEO7W1jMdg6A2lOgGKZlQ6sV8nLlQg=;
        b=Vx3wHzatfoTptlKzEWR3WYlSeCCW0S9JV6kJ9+RxImxCnz0/g7MyJtsiziXyjG84yR
         3LZy91aR/mCwCge+2/z0brJXCKUEfxgj5o3FdWvCYBYkiwgklh9O406LTbdZFz6pIi+g
         EBb8t87HY78SH0IGJu/rTdTzGtXLWOcqgwu9hN40Cdpjw5q6AMx4CaO4CAbeR9gqAqpM
         8t6uPSM4YA9PLMwcCBkJ+5C780eECXSI3foQTAEd4EuC9IC63vmF+tQmbl6ksLKDcE74
         KzBGo6bHWoDOXps/xBFEm/GfSGbdfeJaqCxJOBjP3ceMUUDqoC28iQqCeG+gdtL/plp3
         tiGA==
X-Gm-Message-State: APjAAAUzaQ/mb9l+bcJR1AhP/7/onHCGuyKmYEQs+kAPzxPN7Qzu2fWI
        s6B1xRLR1bq+JAcYHtY3D/E=
X-Google-Smtp-Source: APXvYqwlhZqueqyvzdePCyMojtEybi5IqJJYxWmRuIhXzJwsexKmBNojw3/oYRxtuOUJb9M8hNotuQ==
X-Received: by 2002:a17:902:7591:: with SMTP id j17mr47746143pll.200.1559783547170;
        Wed, 05 Jun 2019 18:12:27 -0700 (PDT)
Received: from [192.168.1.5] ([159.192.229.236])
        by smtp.googlemail.com with ESMTPSA id h2sm129280pgs.17.2019.06.05.18.12.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 18:12:26 -0700 (PDT)
Subject: Re: [PATCH v7 0/6] Introduced new Cadence USBSS DRD Driver.
To:     Pawel Laszczak <pawell@cadence.com>, devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, felipe.balbi@linux.intel.com,
        linux-usb@vger.kernel.org, hdegoede@redhat.com,
        heikki.krogerus@linux.intel.com, robh+dt@kernel.org, rogerq@ti.com,
        linux-kernel@vger.kernel.org, jbergsagel@ti.com, nsekhar@ti.com,
        nm@ti.com, sureshp@cadence.com, peter.chen@nxp.com,
        jpawar@cadence.com, kurahul@cadence.com
References: <1559729030-16390-1-git-send-email-pawell@cadence.com>
From:   Lars Melin <larsm17@gmail.com>
Message-ID: <30b6ac49-2edc-fde0-a106-34ff94999e5a@gmail.com>
Date:   Thu, 6 Jun 2019 08:12:21 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559729030-16390-1-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/2019 17:03, Pawel Laszczak wrote:
> This patch introduces new Cadence USBSS DRD driver to Linux kernel.
> 
> The Cadence USBSS DRD Driver is a highly configurable IP Core which
> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> Host Only (XHCI)configurations.
> 
The driver is not an IP Core, the hardware device is.


/Lars


