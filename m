Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,SUBJ_ALL_CAPS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E84C10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657BB21902
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vg9k1Bos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfCWMx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 08:53:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35830 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfCWMx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 08:53:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so4605768wmd.0;
        Sat, 23 Mar 2019 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Xe6d9EacMoA+npBm1RhQGo2nhEmLZyt4ho1kgPzTOe8=;
        b=Vg9k1BoszVBedYwDOzjIiDcaiQgKwaypQ/L0RFUM5JWgDHepWbZKFy4sbam9Yth9rT
         zCTqdEGUM43VVVgXqTYvLFK3cK0hdVjvMifTiH8DueDKEMBknrmrE31iwAIeek5MKtCJ
         72IAoIH1wrA+HLWd87JkminyyKczUI8CIqX2+aV6rJltS5dwK6fL3dvDFoLOZZINiF5X
         FSLcQc7hbfXt1J7FcVgz/iR5OMgCBfzBEi1evgeGBkxNiW7yrYhp2woqNdvcqnDbG0yl
         PwSop1RiKbWsv1yA3sIgz/R/t1XdIK0inkHj2Q5hqxRynxymbA6E95T+8m5nVYn5tKvQ
         2Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Xe6d9EacMoA+npBm1RhQGo2nhEmLZyt4ho1kgPzTOe8=;
        b=sBscyTCwgGzd3PFVRKBriaKiT8dszMWl3fPjajiTZoZ2lK+p4mtr6ctFevPo6rzU9n
         o9y1PFKmpgzh8T+HQiW+48HYm1LpRa9H/sf/R4DaWWIoF+ZHKoZrycQQwRunH/dPvHcv
         lwOqOJtUEFjy2CdlQbQzqJyFYIjUEdH/loxpUMubL21AgyOerrQxlOQAT2JZbO5Lz7zW
         aptn3Ao7MWvTtgr2PBRtoCmA/+Hjpvc1vddQdvOoN8qKzadYFcHzrB0XdcJsClOamiNG
         zJPgzcVtxsZxSBB3J7UvL9I/4fPFEs7EYHrZyMt7paSy634PlykPn6cwZyxwh8IoUwJl
         lDEw==
X-Gm-Message-State: APjAAAWAI3yPgq3IzJRPtdTM3HP2OfT2nSwee7nfSRsVOjLxLyq6KDFP
        V+a4BWo5J5Zee+92PfbCJrI=
X-Google-Smtp-Source: APXvYqz3g5MPmT1Od1He9Ok39u8TnIOLXH2Ci6MS+3t+9q1grSNMLCgClRXkrLK+Qzi/8kEJTtYbLQ==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr5854543wmc.76.1553345633763;
        Sat, 23 Mar 2019 05:53:53 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id 132sm18762507wmd.30.2019.03.23.05.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 05:53:52 -0700 (PDT)
Date:   Sat, 23 Mar 2019 13:53:51 +0100
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
Subject: [PATCH 0/5] *** SUBJECT HERE ***
Message-ID: <cover.1553335775.git.sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some source refactoring, parameters aligment and camel case clearing.

Replacement of bool to bitfield in a struct, but not found
the population to check if it is done correctly.

Cristian Sicilia (5):
  staging: iio: adc: Tab alignment
  staging: iio: adc: Converted bool to bitfield format
  staging: iio: adc: Avoid precedence issues in macro
  staging: iio: adc: Adding temp var to improve readability
  staging: iio: adc: Remove CamelCase notation

 drivers/staging/iio/adc/ad7192.h  |  16 +++---
 drivers/staging/iio/adc/ad7280a.c | 109 ++++++++++++++++++--------------------
 2 files changed, 60 insertions(+), 65 deletions(-)

-- 
2.7.4

