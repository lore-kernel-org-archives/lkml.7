Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94512C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F00B21019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kopismobile-com.20150623.gappssmtp.com header.i=@kopismobile-com.20150623.gappssmtp.com header.b="iZAiJZ0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfFLR7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:59:38 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:43365 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfFLR7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:59:37 -0400
Received: by mail-vs1-f41.google.com with SMTP id d128so10840921vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kopismobile-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YzqXHzdQwMKc415W78NML2bt0j+Q8pFJtrBVAjWLbv4=;
        b=iZAiJZ0ACPJztu0mTLjLoz0Xhl8YQrjm5SHlRLujSupYD0RL9EVOTi8HIpk1fVRhjX
         ZZUX0z4UpDq+Emh5M81olit7qbWS6xlhrsyrBXQP0odZj6qHAnXeeVkVnnTQoZaixD1x
         MKwOENF8S30ILbO9eMd1FbS+r0lBqBZUhO2O90yMYG0MGASsQnTGsAeB2E0umnjIwGiB
         cFWVhhDW5fgGJBrISy6awQOArXDNdUiDpEKhY/aRW8Cx9100fBApZMGUsR29uRrV4kXr
         BjjctP0PL5Lr0lSRjFyVZGsr5FcGxBzjAPsB3UJLzxXvrVCqKQ6PELFR7S4aXSd18HeO
         U1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YzqXHzdQwMKc415W78NML2bt0j+Q8pFJtrBVAjWLbv4=;
        b=HIoHeq+eAANdPjsu9unIyn3yCyZKspibBXTHyg8m17CzIk4mxMEyS8iC9vp3IM8R0C
         K5gqzG0tfzDVR3Wvq+1xfmuZTlF58ssU8BF5A6xcR0BHUYWDPWYptFCceXBf5Ftozzy5
         azkm2Ttx2yEGxLLKB7WO0dyNp6a0XUuUUBjwZB11aXkx0/A3aRK8/bBCkRXFKJqiL5Jt
         cNGq9zfE5Dm5K6Ca0ZQd+BDoBC7exWsjv1CWswkW7uPQ8JHC9rVIYMMrAEtxSysuzOr3
         NtXK0SY1m5XW+cy7Uklcwb44iZKV52cdAo7ryXUkl1gR3WsTW/CLjD4SAGEVhnbDIoGv
         XI0Q==
X-Gm-Message-State: APjAAAUE1lzqzdlb3l4wpp1ZHPFkCSV0vHdaH1qRPT5lMyLlTdTda8ik
        rGIqXcRzHxybqHNvB1rnoA5WoBhqd+SBBHNL+W8yfg==
X-Google-Smtp-Source: APXvYqymSpjrAO4UUWJrAbncqyttjU8c09+U6ivX/IPRADtsYnUEUAs5gu6077xpUxJOA1nUocO4G6ZFlxgoLglD6X4=
X-Received: by 2002:a67:c84:: with SMTP id 126mr37085501vsm.178.1560362376214;
 Wed, 12 Jun 2019 10:59:36 -0700 (PDT)
MIME-Version: 1.0
From:   George Hilliard <ghilliard@kopismobile.com>
Date:   Wed, 12 Jun 2019 12:59:25 -0500
Message-ID: <CALM8J=fc78yP8OdLHziEWjxidAtv5xPxOx=fLKXhUTfFrrzkKg@mail.gmail.com>
Subject: Pointers on using the extcon-adc-jack driver
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have question about using the extcon-adc-jack code, which uses an
ADC to provide an extcon device.  This is exactly what I need for my
hardware.

Currently it seems like it's set up to only be called from other C
"platform" code, although I can't find any examples of such code on
the internet at all, never mind in the kernel tree.  I am interested
in putting this driver in the device tree for my board.  Would you be
amenable to patches adding device tree support for this driver (and
maybe other related extcon drivers)?  Or have I overlooked the
"correct" way to use this module?

Thanks!
--George Hilliard
