Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46838C48BE8
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 19:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D8E2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 19:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxdConYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfFVTiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 15:38:51 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:32824 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfFVTiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 15:38:51 -0400
Received: by mail-wr1-f41.google.com with SMTP id n9so9769199wru.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ANjjY8Rh0UaBi+L+QlwWhKYsKX4sBFreV6BGed2sdaU=;
        b=xxdConYxKchtiLYDpULGAnYoE5TK4G4PboR7+Ad8BFltYnf5fKPG4ysWyaqQ53nVO+
         jOzgAyBMqQC+juY/uHlrBd00jUe1vDjQ0aCuWmE2rUsjS39j3ia+0mVSrHTUa6mVo/rc
         ViE3Zm5meCnt61DXudthAcjdAL1hsMmyogC1hbdJXy+KJxI2RKkAMbL5KZ8zZF0fc8PQ
         L6LHP8e/h5RMnR8Y2DrTJnZCzUuoUme1kTnCud7Tubp61L2CgtmawLvwJSxPAn9VKhSe
         9/R8zZusXA1hZeFQTOSdb6LVn8DzaTjm0P4/qko13DHYfu2apHI78VasQwYxp8l8+kPf
         8cvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ANjjY8Rh0UaBi+L+QlwWhKYsKX4sBFreV6BGed2sdaU=;
        b=Y4Rou7qzX+w+jPvdcXqYbQ6o1qdR/plhWtRzSGODPPh7snptItDYWxKuSilYtBie9G
         cgKGR2TSPDvQ7FM3ShalswPTeJKj+OpzCnzBEesDEN1wEB1A3kY8o3YycvRRPlVXmWaS
         OisWDuJxR+F9ovOQBd3PobwpU/krY1NZVYc+7sF6Vk+2gJNWb0YmiifSi2e4xNfFpBnZ
         OSb5JLq4RWNQrqaAgWQl+RVmcLllAz9OVn2bpkcq3P1BsiFkxdpwYbCzjmRUTrwFn8c6
         /jZmD2E1wdA7XHNzRia4LSiHYbu0v+AQNwYWMdnNvtN+BV1Sa+azlHNHHKR9ygofGMYg
         TkGA==
X-Gm-Message-State: APjAAAX2Za4T/a5gt8X4MnZSsxj5pm6IYjdv3aEv1B9+2kqNEdw7R6AR
        KkPGydjslwi00YC6DrAksCgdVg==
X-Google-Smtp-Source: APXvYqwDeDcUMfnA7RD01Pvi1I42PUeo6nS2ejuf5kqS0AzelwZ1EFQ2DYHtWXjIafsW6/L2dW5gXg==
X-Received: by 2002:adf:b643:: with SMTP id i3mr11745951wre.284.1561232328886;
        Sat, 22 Jun 2019 12:38:48 -0700 (PDT)
Received: from localhost.localdomain (88-147-39-13.dyn.eolo.it. [88.147.39.13])
        by smtp.gmail.com with ESMTPSA id h90sm7506441wrh.15.2019.06.22.12.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 12:38:48 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/1] block, bfq: fix mistake causing violation of service guarantees
Date:   Sat, 22 Jun 2019 21:38:02 +0200
Message-Id: <20190622193803.33044-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
any chance this trivial, but rather critical fix makes it into 5.2?

Thanks,
Paolo

Paolo Valente (1):
  block, bfq: fix operator in BFQQ_TOTALLY_SEEKY

 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
2.20.1
