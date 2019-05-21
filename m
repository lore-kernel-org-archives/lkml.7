Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F240C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0492173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfEUQ5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:57:16 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:35217 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUQ5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:57:16 -0400
Received: by mail-wm1-f46.google.com with SMTP id q15so3636375wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 09:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XTdOu4nTOIaGJrQvdIq30fU33+PO+XLG2cxp+DkWGwM=;
        b=ajdZc76E1Z//l0eTtNPJxsV2L1LgyuaT/hfTL0bFSlKThhoKV95nZgIODrrhenu1we
         n+9gHDTTyAHyDnE8onh4V/o3Q0mDLUxf8bxPbnhOWcAuTq+OBN17mB0hjcbfXP7z9Hya
         EjzkC94eW9QIhG/ceoeaovv9grJ/JaxDj+8h3j9AlM/lohNXW25pzJmLZI1mn7c1EcpE
         5zaD/EA6eB13il2S6G/KPZpYFWwE7ii4TRNBsSeWT2gqGqZu9C4WKHqBZqj1LY1miyKm
         X6sdqj4S3ooFfVwJL3J7IRFAd3c9dbKxIBF9anceACMQUgGnt/wwxDv5Mwjin5PtkwdE
         vp1A==
X-Gm-Message-State: APjAAAX8UdA8wBsuCqsiC31Q/wuq6bgvt5taT6qwEFy5yhsltrnQTDRY
        rbh5GlJnG+jv9sWk2qq8plC5GP77fNs=
X-Google-Smtp-Source: APXvYqye+AWXb5HCFzKAmuUc2hl5iceM97h0XJnX91W66r4leZp33RloUJinRkTaK/kyq8GRl79IjQ==
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr4020134wmc.129.1558457834031;
        Tue, 21 May 2019 09:57:14 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id g11sm6944142wrq.89.2019.05.21.09.57.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 09:57:13 -0700 (PDT)
Subject: Re: staging: Add rtl8723bs sdio wifi driver
To:     Colin Ian King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <9c766350-db9b-7a88-5655-54d03c8d2703@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4ef8b4e0-9e70-d800-2a68-cb539995d41f@redhat.com>
Date:   Tue, 21 May 2019 18:57:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9c766350-db9b-7a88-5655-54d03c8d2703@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/21/19 3:49 PM, Colin Ian King wrote:
> Hi,
> 
> static analysis with Coverity has detected an issues in the rtl8723bs
> wifi driver:
> 
> File: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c in function
> rtw_dbg_port():
> 
> CID 18480: Operands don't affect result (CONSTANT_EXPRESSION_RESULT)
> dead_error_condition: The condition (extra_arg & 7U) > 7U cannot be true.
> 
>          if ((extra_arg & 0x07) > 0x07)
>                  padapter->driver_ampdu_spacing = 0xFF;
>          else
>                  padapter->driver_ampdu_spacing = extra_arg;
> 
> 
> I'm not sure if the mask is (in)correct or the value it is being
> compared to 0x07 is (in)correct (or both!)

Hmm, after looking at the rest of the code, it is clear that valid
values for driver_ampdu_spacing or 0 - 7, otherwise it should
be set to 0xff which means use the driver default.

I will send a patch fixing this.

Regards,

Hans

