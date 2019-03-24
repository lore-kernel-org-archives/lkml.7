Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863E2C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543632147A
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW6K8/Ho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfCXR14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:27:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50903 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXR1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:27:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so6643329wmi.0;
        Sun, 24 Mar 2019 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VNt7l5+VWi0XRfJBxBlcdQKQzBExlbpk0rX49ypfAus=;
        b=DW6K8/HoDgT9nu8uPVRVK37ABFUpuZzLQ2fO2uDhSMqWczhbJKI/FPkxitQNT27Ooi
         SjdOGiB6V5hpcFUXCidnnCpNn5sSDa01anKaj2qyTW+0CApd+vCVCGrdbYiWtDcL+SXW
         tTI1X4d+2MJDMUHwgQNKADg1RPgUb3ebjpZSuR/QQg/coAXogjpGwOgh9qsy1FfHW/fx
         VA4z76PGsmmgPfUheGFCtEmm83NASbf5OP8nQOH/q/JjHcS/t+JFmc5kKoMh16n49kF5
         +mnsNif95zX7R1y0a+44yvefch0rlrK3GLQf1bG7smRM+vXVPmbgyjfTCOChQr9BepZ+
         BwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VNt7l5+VWi0XRfJBxBlcdQKQzBExlbpk0rX49ypfAus=;
        b=AdA+SQdiF/AuGYgAa2g5hF0lVxEF2+ALkwVtPRIZIBdZdqPjFbasr8ss3edZ4WYYQc
         7c7Lqgm8+nuZM+Ax0PFdc3g5T962xBfTVwUid4vq9C/vdsaNDLCRfLp+ITvgCDPKUwQK
         G5e/vrOgkOKn1HLMrNhYsSoeyGUq1lTeWa2Ni3xEFN0pct7X+qyRp4F7X+b+nS3eJM3x
         mV414Cdxw3ekAlEyNgSJd1LAUVZJlSoEsMvv6+scdMfM2kfyYVb0KjiDnGfGGNbeWFfO
         Wxut+CKSM3RsLOxZh+hoNCWEVZL+uDbXRvscN8Y23ZI3C6/+VRjuKAojCv6kK91YT5RH
         w94g==
X-Gm-Message-State: APjAAAXB/+FrvfdYh0DU+cB3XdgtfAVOn5VGjGrcsSBMQBctsUjyaPX7
        pR0XylZc1MCA2lnLhyjfSDQ=
X-Google-Smtp-Source: APXvYqxVRIm8qR19JHncT/7Qe6fqhGzN0grfDmXLHbf/7ONSIkDUUEpWd90ibIzOb36QY1GkE92Nvg==
X-Received: by 2002:a1c:18d:: with SMTP id 135mr3019774wmb.12.1553448473944;
        Sun, 24 Mar 2019 10:27:53 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id z8sm13454718wrh.80.2019.03.24.10.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 10:27:53 -0700 (PDT)
Date:   Sun, 24 Mar 2019 18:27:52 +0100
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] staging: iio: adc: Code refactoring and bool to
 bitfield change
Message-ID: <cover.1553447138.git.sicilia.cristian@gmail.com>
References: <cover.1553366098.git.sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <cover.1553366098.git.sicilia.cristian@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20190324172752.x6RLmgcgswgY7RuswepD1EKLLpagpSUIJnzsK1OGrzI@z>

Some source refactoring, parameters alignment and camel case clearing.

Replacement of bool to bitfield in a struct, but not found
the population to check if it is done correctly.

Cristian Sicilia (5):
  staging: iio: adc: ad7280a: Tab alignment
  staging: iio: adc: ad7192: Converted bool to bitfield format
  staging: iio: adc: ad7280a: Avoid precedence issues in macro
  staging: iio: adc: ad7280a: Adding temp var to improve readability
  staging: iio: adc: ad7280a: Remove CamelCase notation

 drivers/staging/iio/adc/ad7192.h  |  14 ++---
 drivers/staging/iio/adc/ad7280a.c | 109 ++++++++++++++++++--------------------
 2 files changed, 59 insertions(+), 64 deletions(-)

-- 
2.7.4

