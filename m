Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C98C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810BC2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzRF61IB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfDJKkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:40:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34872 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730692AbfDJKkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:40:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id g8so1332120pgf.2;
        Wed, 10 Apr 2019 03:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ifZ0vNjraMbPeFwLGwl6GzMRFqY3y4lL76+APPx5lLU=;
        b=DzRF61IBtqpn6fqCNO/ln+sWZC1ArxrzjBO4Cj1Q3hZBFDKHXR2fgMj2LGswhsNojD
         TODURjl+8L9JLL0ziA0DNCzE0pqQi3p0FF3+Fc75K26mPwC25D09i7JvKq9fUCuxnO/f
         aD/FzK8ZTLJLVc/w9l2noQnfNmi1Pmd0lRHcNeZ3V8bHk5s0oSZ8NsdnewKijbdJXoFD
         mS92vEIhDQ5NkhyeBxE3AAEeJ2d7SLOgNkELyssY9CvtRfR9RBnFn6VR+4HAQDs5Gbaw
         JpuFQBWG5xsnE6u0ffXQfErdKakl76tLl6MTFkSdzzJnM3RGA0pmBcxz7me2ACQwUePl
         H8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ifZ0vNjraMbPeFwLGwl6GzMRFqY3y4lL76+APPx5lLU=;
        b=f5fd5zfiRXdlA8Nl784Sk7olUf67SwFemhSZL8Y4Ty5hBMSnx8/W8/rcuDe71K4OLn
         pCijHroX0pttqdc22O3PrXmOU1v3Vz7mZau1v1OJEJwrievjEvrWd8t1Rfk3MnQ6dL+3
         //fbBUtc9DwUaOSialqalau9jfm66TUOsMYg6aeZaQGBKgxZ6gpSmtCDIquLJowHKIEY
         gIxl6XcVY6iUMfzF29PI0LDCw9gn80+EcQ+qM4zJL0iq5bxQFKpR+CnwQhdvJTjjMvEQ
         pgzQnsV7k6tsJ+u3Tp60KDSZ28G6CKH+Ckl8+Y5+D66AoJ/Ehp4vkYCxCdf/hV2oxbP3
         829Q==
X-Gm-Message-State: APjAAAU8NnihgXSfTyCyHunl7wr3crCY2Z59P+aZQZUgqmsC2dpO5eX2
        Sbjace6ycBFYOmQlIFug++Y=
X-Google-Smtp-Source: APXvYqzBSigtoay8DJypC5YQDyPwmQhs8PMB0mWBxm9BjDI5sEPa2ESpgrXqYCXqVaEVfwUS0suHyA==
X-Received: by 2002:a62:1197:: with SMTP id 23mr43214038pfr.210.1554892812693;
        Wed, 10 Apr 2019 03:40:12 -0700 (PDT)
Received: from [192.168.10.3] (mx-ll-180.183.74-224.dynamic.3bb.co.th. [180.183.74.224])
        by smtp.googlemail.com with ESMTPSA id p14sm28099897pfa.26.2019.04.10.03.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 03:40:12 -0700 (PDT)
Subject: Re: [PATCH v6 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
To:     Pawel Laszczak <pawell@cadence.com>, devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, felipe.balbi@linux.intel.com,
        mark.rutland@arm.com, linux-usb@vger.kernel.org,
        hdegoede@redhat.com, heikki.krogerus@linux.intel.com,
        andy.shevchenko@gmail.com, robh+dt@kernel.org, rogerq@ti.com,
        linux-kernel@vger.kernel.org, jbergsagel@ti.com, nsekhar@ti.com,
        nm@ti.com, sureshp@cadence.com, peter.chen@nxp.com,
        kurahul@cadence.com
References: <1554882504-9010-1-git-send-email-pawell@cadence.com>
 <1554882504-9010-6-git-send-email-pawell@cadence.com>
From:   Lars Melin <larsm17@gmail.com>
Message-ID: <f04e98f8-e1d4-55a7-d714-9770961e5fc9@gmail.com>
Date:   Wed, 10 Apr 2019 17:40:06 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1554882504-9010-6-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/2019 14:48, Pawel Laszczak wrote:
> The Cadence USBSS DRD Driver is a highly configurable IP Core which
> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> Host Only (XHCI)configurations.

The hardware is an IP core, the driver is not.

rgds
Lars
