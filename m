Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEF8C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA571208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vLiFvqL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfDAOg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:36:57 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33390 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfDAOg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:36:57 -0400
Received: by mail-qt1-f193.google.com with SMTP id k14so11110946qtb.0;
        Mon, 01 Apr 2019 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IF0XOwmvHNNJvMEJtCeh5DYVAySmuNq1CYP+Se6slEo=;
        b=vLiFvqL7hBdHpqUCM1i/thQWztlsD1E3oOjKK24GoqPRoF69AeaHPU+0PY103eooV1
         /AHqi3tdOiV8b7fFfwvygD/3xwrS3PwGLpNxfW8n5Dkt6LRWVfAhAsX8NUuDCQrnkOVv
         lJVYAA1QW7+mB7nSWSXzMf4Cu03rd7jeLAAa/syzdJtd+gYMs1FITe8YU/yUD7XCgXSd
         uGs93xGMI3D62RF9036hR+JjJeI/hVcVrdsFpNjHBHEBS/KDQ1aVUkEZxaF3Vt9euBYs
         6zkoTfrOLe+0ssmuW03MC46zn1sl2sVI4cuX1980Sc4YpSKn5d3QYRgYAQjj+9DHH3LC
         cMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IF0XOwmvHNNJvMEJtCeh5DYVAySmuNq1CYP+Se6slEo=;
        b=gMrJ18drcBTphHR49hTVRYn+qwwVNkF8KeH9FiwVPa/MzNfF5h4Ml5obrVqgxikvM8
         EO4Y2ToJOvrR+3ahewRIewmKbzHXzXlWRKihS6OGmdmAL2noawR1zrcba7f3j3lxRiir
         N/uaKFrFKODwERXIuUCM5CkyTQap0JMy3sqmULC7NGfRT31ttBqSXQMmvlM2hhNRvAiu
         4Qeciy3WSy5fzEP4ZdofhfKqHViLeUlSCVLXjUjECw6gp94W7np9mvcdUDa/Zd3eThxa
         13dE/jQa6h91mU+dzAgasMDIn7f2jNCpWFA6ViYlP9+Tix4IAlPA7hIGMY7YoYTTa8Q/
         vIJQ==
X-Gm-Message-State: APjAAAW+wjLnaiRTpMInYGcVYBS6WhFFyR/KZj+L/rftkSwh/BJJugRn
        kFE0OFw2iy4LYrWWWdcSyAu/gZlmfUw=
X-Google-Smtp-Source: APXvYqw6s33b2GZhmHVQ/DC+X0lXR3WJYvbcu/YWgdqyCMkZlX9sza0pKJGLO1z+7sQ9GUm4BLn/Ng==
X-Received: by 2002:ac8:6b98:: with SMTP id z24mr29978511qts.248.1554129415989;
        Mon, 01 Apr 2019 07:36:55 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id n41sm6404155qtf.63.2019.04.01.07.36.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Apr 2019 07:36:55 -0700 (PDT)
Date:   Mon, 1 Apr 2019 11:36:51 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 0/4] staging: iio: ad9832: use clock framework
Message-ID: <20190401143651.ywnnnxblqj7r67xj@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches do minor codestyle ajusts, set SPDX licence
identifier, set use of linux's clock framework to handle external
clock, and add a devicetree documentation.

Marcelo Schmitt (4):
  staging: iio: ad9832: organize includes
  staging: iio: ad9832: add SPDX identifier
  staging: iio: ad9832: use clock framework for clock reference
  staging: iio: ad9832: add devicetree documentation

 .../bindings/iio/frequency/ad9832.txt         | 26 +++++++++
 drivers/staging/iio/frequency/ad9832.c        | 54 ++++++++++++-------
 drivers/staging/iio/frequency/ad9832.h        |  1 -
 3 files changed, 60 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/ad9832.txt

-- 
2.20.1

