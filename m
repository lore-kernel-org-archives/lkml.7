Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA04C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 06:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A215E2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 06:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1AnsEeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbfHOG5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 02:57:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46220 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfHOG5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 02:57:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id n19so973737lfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 23:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hgJrNRBNHtDq7sAYiX+DZ8YnHpU34hU1rQmq3ot6dZw=;
        b=j1AnsEePN/KW0HMmaePlAW+4s11k/qV+uDHpT6ndW/2EcKgcI+1xAwgnAGE+sGMsi0
         PYS0ALOF7iV7uqeiZjb3x1be7nTY9RBZ97TC7N5123EIoK0ckxfYcXV5vKd4B47jzDHq
         ra0el1qXOaVWgxtWxtAVJLH5T7cUjpbgvaecqcP/oRpdMAmDDKu0kK+8faTx47F7E50d
         ZL2gybENJ+Zi037ynuCYC4g6uo/QNwDg4+8fByK31BEc+Uux0pO0NHrezjRDjvob8zvS
         s5r1mhvB0xQgT/Aww9Q60RZHy98c4UxiXYrFuRG5k2KUE+u8e3V/4pBtBjU9LsMbOZor
         SIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hgJrNRBNHtDq7sAYiX+DZ8YnHpU34hU1rQmq3ot6dZw=;
        b=jHMS55azlHiKjh3ItjNKg7lIzUzDt/ABr9EKuRN5u7oZcy7DxBI0Pw4PAmobB2a+TH
         IayMoZzN6aJ6i8HzyMoRQ0ftTSjHZ9Frn1v9AlUkO2KM17WYor3DObKQog+tI/ci7got
         T80ZD4SzjirZ9SU79rkagLsAarnWFTKjyYcTX3KlFjvGorgRz+OVY9CyoBzDjm1W/6dU
         8j97IkEy0QQow+aRJ0I0DwF6seO584z2iYhnPKMNbEPgQuZnv8GZIPyId3eJuWi7XhJP
         GCvqDN4neypOy5Rl2ix9SxOZJHj0KFVGEa8MCrutrM7a//c+yGrA1axQTMxIK6XXpGrd
         Dpdg==
X-Gm-Message-State: APjAAAVjfbcBCx0bV4UUqlgJqE7Orit5y/ZDrwcxtK2C8Fq1O7U/t1Hd
        zSDIoK0nt3qS5LogorERDvbcyQ==
X-Google-Smtp-Source: APXvYqzfCzhF11z2F4XsMUzO2mumPQq0sKbZSqSSnFlIg89QB+a7wZox9HdKZUoyffMFbn6H6j1c3A==
X-Received: by 2002:ac2:44ce:: with SMTP id d14mr1626809lfm.143.1565852222061;
        Wed, 14 Aug 2019 23:57:02 -0700 (PDT)
Received: from jax (h-84-105.A175.priv.bahnhof.se. [79.136.84.105])
        by smtp.gmail.com with ESMTPSA id i17sm303452lfp.94.2019.08.14.23.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 23:57:01 -0700 (PDT)
Date:   Thu, 15 Aug 2019 08:56:59 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm-soc <arm@kernel.org>, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: [GIT PULL] tee subsys for v5.4
Message-ID: <20190815065659.GA13498@jax>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this OP-TEE driver patch. It adds a call to might_sleep()
during RPC in the OP-TEE driver in order to be more friendly with
CONFIG_PREEMPT_VOLUNTARY.

Thanks,
Jens

The following changes since commit 0ecfebd2b52404ae0c54a878c872bb93363ada36:

  Linux 5.2 (2019-07-07 15:41:56 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-optee-for-5.4

for you to fetch changes up to 9f02b8f61f29f4518581770d57bfffe99b1ea599:

  tee: optee: add might_sleep for RPC requests (2019-07-08 22:38:56 +0200)

----------------------------------------------------------------
Add might_sleep() in OP-TEE RPC requests

----------------------------------------------------------------
Rouven Czerwinski (1):
      tee: optee: add might_sleep for RPC requests

 drivers/tee/optee/call.c | 1 +
 1 file changed, 1 insertion(+)
