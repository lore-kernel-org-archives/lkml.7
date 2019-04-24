Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB61AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93253206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z0KgvU/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfDXGXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:23:12 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:41940 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfDXGXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:23:11 -0400
Received: by mail-ot1-f48.google.com with SMTP id g8so1164455otk.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 23:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=UHamIRZSkMrLHIXV4yMiufS4Z6cDXoVYV/L1btDQtKg=;
        b=z0KgvU/9kiPxp9UuSFx1gugPwbi9hrOPBAQPuCHu5/Qz+uAh90J1nj4HhrVN8VV+I1
         eejxlQmnPJIRgP4YwfL3A7R3QhKi3GSZoysC5xXD7LimIG17VAnhMeiVt+A7/qvrKnVu
         L8l85P2tHEaxLy854pR6su0q3FVXdAvABdtDtiCg8lrGLvQ7uy9HFa5sb/rETXKenh0+
         b4dX2oWkuOJYJ71ZQJq5cM2tSWrS4C5V24qU/rjk/Z7vqslMpbqYXQcbO80Wf9074h1U
         v/S7i/DxcvXCyUDQ/fjz8lPkEd/F86wq3l3j1Q/Jv6HJMQjyqTffDfpN5btxCDJdzMyx
         lcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UHamIRZSkMrLHIXV4yMiufS4Z6cDXoVYV/L1btDQtKg=;
        b=cmtrg9FLPDKytolVzCgEUOkFmZMxne2dPWuN7pSkFrzf3j/zt6pFU7Y6r6ocgOGPDc
         50rZYsNRuB4uuwu9kY6uGcw7UNGNGrsLZ7b4goQuLKLhLAQak7XsQCAF+y2n92Y3EYlF
         EVaniKoCgZ/Rtczs2kJi46wX9ikPo8i/Wvk62ZPaCyciI74iE1dhJ34fJ2J1Pru7t9C6
         xBNHgRjoBJqUeE3Hm+0LSnnF8KHXKOB/voKb4sVJLcv/VGRTuUvSPF7pFjvtfRoVUyNY
         mU6jWk9C2Vj3WgLjHBHT63umUykxIkDcNOXnfEGwDtALa589YPgne58jVN8HHe26QcBV
         /UGA==
X-Gm-Message-State: APjAAAUkJNN9hXUS8uovNyBqLA4d1ztTkPDC0KwjfXMX5xZrLSES+/8z
        C1YK9Siqx0ACUh4oD+aI6M7tQ9f+RBQhF0NwBh5dlA==
X-Google-Smtp-Source: APXvYqw6FE2GxL7MksnXGJk3GpH9T6+LZdFCbQ0JUOkYT74D0YfUGe4CB/PwF8OZV3ll3rPgIZuU41ufVoVTbPMf56c=
X-Received: by 2002:a9d:6191:: with SMTP id g17mr18369148otk.291.1556086991165;
 Tue, 23 Apr 2019 23:23:11 -0700 (PDT)
MIME-Version: 1.0
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Wed, 24 Apr 2019 09:23:00 +0300
Message-ID: <CAD8XO3atijveUR0irCM2z3hsr8Rm9piwTbBp0NTwvzJt9+MHdw@mail.gmail.com>
Subject: RFC: zero copy recv()
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On different conferences I see that people are trying to accelerate
network with putting packet processing with protocol level completely
to user space. It might be DPDK, ODP or AF_XDP  plus some network
stack on top of it. Then people are trying to test this solution with
some existence applications. And in better way do not modify
application binaries and just LD_PRELOAD sockets syscalls (recv(),
sendto() and etc). Current recv() expects that application allocates
memory and call will "copy" packet to that memory. Copy per packet is
slow.  Can we consider about implementing zero copy API calls
friendly? Can this change be accepted to kernel?

What are your thoughts?

Thank you,
Maxim.
