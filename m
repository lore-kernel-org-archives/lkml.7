Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06A3C606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D61216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcwjA0ir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfGIBWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:22:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39065 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfGIBWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:22:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so9183060pls.6;
        Mon, 08 Jul 2019 18:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=FkIRuQbZrNsm7KJsxVPrVjGVu+RAoRtGJt58KQ0F+f4=;
        b=dcwjA0irj4oApbmACQeVWnPZPu4XCtfM4YKscx61GZ4HlWfOcMV2hkmhQLS657zH/y
         hVWk7bTiHvxhkZwpBAEoFRWIKoGXmbr5NAPCUfv75cr3lFdiCcFRo2KpI/MbdtblYB4d
         h/pJW3xam2a/rNGHnF3eMYa3/SyPDTVgiw8qqRfMzlmXdGpuFKZnKzIXVvs9HDegrT30
         Rchyr0ZUH9FZJgEn4K9HX6YO88qp9x62dMvNbU/MNY4oWzMyJSCWniGmbVGdurLyeTbc
         sjQuoy0hTnjihjv9m38tHDxV0VaQYeyjY7ZOE5FnS6B2Ic65UN1X9d2o8KRZXkmQgY/k
         73EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=FkIRuQbZrNsm7KJsxVPrVjGVu+RAoRtGJt58KQ0F+f4=;
        b=hArT13oM4Acx68qE47vIIMW9pU7dtxlC7KhubwcoT0gd/XC1IZB/7zDsm5+oJF5ArT
         w5imGFXjdmrgq0ZU7npRXxU8xxgfae0tbEmgBEa5sBGBonCTAPGJ9RZhEy6SWKhzXn9h
         yGgdWTPTKE9kAAI5t6pJQoD32N3R55O7hTIzBjJwsul2oXY6IY+YKvdu5HxuoK2YBGZo
         UkR685P2KbBvt1EdugZ0ExfvCCAfrr/zpN0zfkgHqErCArlIwIIJojrjLxh39Og67/NC
         CWVtfqXa2lkwwnVJcoq9xQr4Zcoomte2rHCVswgCb1HPAZEpBDbfXbylR19urlQVc9g1
         SFuQ==
X-Gm-Message-State: APjAAAVjrzqY+KYsyOUEMpCWhl0Y/geEzjM+on7ubwvc24WwRZkWTlaO
        W0CaXDel/Fr2RrOfxLzqw8MUWnez
X-Google-Smtp-Source: APXvYqyF64OC2v7AmcoZKNj2xVVQQdi9RsHGdqyd1aV7qkua2encOhksCX7h///rp4da/HEV1ukOcg==
X-Received: by 2002:a17:902:7791:: with SMTP id o17mr12651385pll.27.1562635354573;
        Mon, 08 Jul 2019 18:22:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w12sm20672420pgp.56.2019.07.08.18.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 18:22:34 -0700 (PDT)
Date:   Mon, 8 Jul 2019 18:22:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Fabian Schindlatz <fabian.schindlatz@fau.de>
Cc:     linux-hwmon@vger.kernel.org, Len Brown <len.brown@intel.com>,
        tglx@linutronix.de, Ingo Molnar <mingo@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] hwmon: Correct struct allocation style
Message-ID: <20190709012233.GA311@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 27, 2019 at 05:27:38PM +0200, Fabian Schindlatz wrote:
> Use sizeof(*var) instead of sizeof(struct var_type) as argument to
> kalloc() and friends to comply with the kernel coding style.
> 
> Co-developed-by: Thomas Röthenbacher <thomas.roethenbacher@fau.de>
> Signed-off-by: Thomas Röthenbacher <thomas.roethenbacher@fau.de>
> Signed-off-by: Fabian Schindlatz <fabian.schindlatz@fau.de>
> [groeck: Resolved comment conflict against -next]
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

This patch causes conflicts in -next due to commit 835896a59b95
("hwmon/coretemp: Cosmetic: Rename internal variables to zones
from packages"), which is not being submitted through the hwmon
subsystem. Unfortunately, the conflicts are more substantial than
I thought and not trivial. Since I have no control over the
conflicting patch, I decided to drop this patch from the hwmon
subsystem commit queue.

Please feel free to resubmit after the commit window closes.
I would suggest to drop the coretemp driver from the patch since
I don't know if further changes outside my control will be made
to that driver.

Sorry for the trouble.

Guenter
