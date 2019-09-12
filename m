Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00DBC5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 07:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCEC2184D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 07:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSu/0Kv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfILHeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 03:34:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34725 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfILHeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 03:34:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id a11so17491807wrx.1;
        Thu, 12 Sep 2019 00:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DrTrC5gW++glk3rYAH0eIFlBDTa2thDxINX062QlkQ8=;
        b=VSu/0Kv4rH91mI6hUqAvDdQz0fuwNejHwRYAwp44EFelnpATJeL9lhxAb1nqdaE9N2
         CeIz5+z0m9RBRaARyvS72fS9VHK7MqyVbzhqg5I1NnS0K6NvFe+OI+nAxGX5Ml0m+1mu
         EmeMcI+22hgzF3ndtIvZmd4MuNKRfNEl8T7vamr+EzZxiOYa0iueXRwezbK3HIbJYo5O
         mZ5xOLPD2qnBDS98lbELJuf0qcyRKqsOiop6W8WIg2Eu7uTqm9NrbaRWeCfBjLQWXOh3
         NX93kGphIhFE7NV9KpJEA9LoyWvMTF5zo5CnvwTK6UZlhN2/gtbCnWwPTHTWi7L3YA6A
         koXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DrTrC5gW++glk3rYAH0eIFlBDTa2thDxINX062QlkQ8=;
        b=tMaabQsfNjrZDhek37l9CptkDo9+y8XxZ+i4ZztdGUhjkWF0gcIpAcBsP2uxPeP6LG
         lH/fbnUedbh1N+/5CUPLMrdquENVh8GOC75AqDkkRhUp50nEJw1ZBcWLQm8o6erfX9zR
         lrLF821n6twKVyMiVc5OhrNGb0d6qiiHoz/fV57+QxvzVOYZKCPAKrW7+9a1U6AQzXvd
         o7eZIuNfJR4ASeOElH//Ia/tC1PBvLKCoeXwgUIoKS5L7nv3nzSQbbwZfaGOASMDyqNQ
         XmSzA1c/tL02eaWexzs5GdWUgZWfLPBh66s4tcmp2My9N19+cp9cEUBeOOTaYvdBnXZR
         zUZw==
X-Gm-Message-State: APjAAAWSAARtYUV5cvy1oFXAfa2WvAJ8dX1Aqz0SUPnvkuopPIZ6pxik
        2EL9tX/ESmUXmzqJMV1qFo4=
X-Google-Smtp-Source: APXvYqx4PdJfOKThFwN3kCsebU/3k+8rQRRfilclB5KjqXUSPTFxJD+yPlIW7VU1sXQEpjS+Cbwsow==
X-Received: by 2002:a05:6000:105:: with SMTP id o5mr5489284wrx.51.1568273640194;
        Thu, 12 Sep 2019 00:34:00 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x6sm7830814wmf.38.2019.09.12.00.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Sep 2019 00:33:59 -0700 (PDT)
Date:   Thu, 12 Sep 2019 09:33:58 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Pacien TRAN-GIRARD <pacien.trangirard@pacien.net>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-laptop: fix phantom kbd backlight on
 Inspiron 10xx
Message-ID: <20190912073358.n5bxqosowhky5uhb@pali>
References: <156824368856.28378.14511879419677114177@WARFSTATION>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <156824368856.28378.14511879419677114177@WARFSTATION>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 September 2019 01:14:48 Pacien TRAN-GIRARD wrote:
> This patch registers a quirk disabling keyboard backlight support
> for the Dell Inspiron 1012 and 1018.
> 
> Those models wrongly report supporting the KBD_LED_OFF_TOKEN and
> KBD_LED_ON_TOKEN SMBIOS tokens, exposing keyboard brightness controls
> through sysfs which freeze the system when used.
> 
> The associated SMBIOS calls never return and cause the system to
> hang, notably at boot when systemd-backlight tries to restore
> previous brightness settings.

Hi! This sounds like a firmware bug. Have you already reported it to Dell?

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=107651
> Signed-off-by: Pacien TRAN-GIRARD <pacien.trangirard@pacien.net>

-- 
Pali Rohár
pali.rohar@gmail.com
