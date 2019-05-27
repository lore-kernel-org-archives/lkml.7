Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4E3C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F5621726
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pE0CcdpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfE0G27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:28:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35240 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE0G27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:28:59 -0400
Received: by mail-lf1-f67.google.com with SMTP id a25so1308138lfg.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 23:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fhnrVHSqGHbJn50Q25d4WsQAAx6rVOjhczZqwBqVKog=;
        b=pE0CcdpSiWxDa4r3DIH1/vqQglpPwJ4pwb9GFET5EkR/KlJXyf/IoRFTicPVJDMs6a
         MOZRO9IkJJKeRRusALXnXtB6JGhKfyjcldxrBKSBzaemGgCMT1FUUdH1M9AIFjHACNEa
         CiGET7Vp8JlUTBFo5aOGzbMWEuOK/VxS5Aes3gOBbl+DxSjk2W1mH3w8r200WDnN0LJ2
         2TTKa5l1w+q6I1KDTZtsuDAd2LGl/h62PhoRaNlCngasFv+71BL0VurTmke/TzUZRj2X
         ti4KO2Tgl2CfkzGjfv1vz8CBmLhKQIQ43k3qr4pcZT/JvUgLHljmzRosYxrnX0LYfl/w
         1+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fhnrVHSqGHbJn50Q25d4WsQAAx6rVOjhczZqwBqVKog=;
        b=ZQlLshkxRPXr2+gzP5mMSDCM+DCFf8adtgZDzzLxQeFgn23woXpU1GQRl9OOiyY4jN
         40FaXR73yDGWLe3B99PX5g5oOc64EApcE+1vIiGTLWFZ1jnr6ekS8D+uh6JcTbwYnW5+
         1Zrc/f5zGSA8/gbRouGNDl2D2CYqAwHYTstwlz59Tp6QMQcTLGxVHz3eASl4kH1EG47R
         kirZbKEZQaAumAxNCgEsXWwkH4w/gMqmIYzLxv+zPFtKQkvFa8skhrROhxRnyPQaZHOT
         YNHeV8b+FS/aQI2y13Jgrx39X7t0PKh5A5FxO+O1WDIO+2o2MtFjT9mo3k5/QOcol5eC
         XEcQ==
X-Gm-Message-State: APjAAAVVTkBVhiQ5SIC1y/KWfTzRkyTxs9IiQ+U9JVdAbuSjVDxMbGxN
        bQvaQjtogzy5bKQ+lN+dYTxTH4t+J2Lsvg==
X-Google-Smtp-Source: APXvYqy2MmlEnre6mpKekjSY8Fh16CLcW6dC3x/vyPe0vo1WwpVUbX5rYj8iUtYqgZ8IXXSGrxPGFA==
X-Received: by 2002:a19:740e:: with SMTP id v14mr52733363lfe.144.1558938537287;
        Sun, 26 May 2019 23:28:57 -0700 (PDT)
Received: from jax (h-84-105.A175.priv.bahnhof.se. [79.136.84.105])
        by smtp.gmail.com with ESMTPSA id q124sm2040047ljq.75.2019.05.26.23.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 May 2019 23:28:56 -0700 (PDT)
Date:   Mon, 27 May 2019 08:28:54 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm-soc <arm@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: [GIT PULL] tee subsys for v5.3
Message-ID: <20190527062854.GA19419@jax>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this update of MAINTAINERS with a mailing list for TEE subsystem.

Thanks,
Jens

The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-maint-for-5.3

for you to fetch changes up to d7f3f7d847044a111d4abadf9c69aa54d0d05167:

  MAINTAINERS: Add mailing list for the TEE subsystem (2019-05-27 07:59:03 +0200)

----------------------------------------------------------------
Adding mailing list for TEE subsystem

----------------------------------------------------------------
Sumit Garg (1):
      MAINTAINERS: Add mailing list for the TEE subsystem

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)
