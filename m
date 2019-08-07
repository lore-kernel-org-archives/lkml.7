Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8CDC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF1A21993
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVGu/UBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfHGRVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:21:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33842 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbfHGRVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:21:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so92198965wrm.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 10:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vuolA915AcWvE5yagNyuds+oSo4r9HGACr7hD1WRCQE=;
        b=aVGu/UBmLHA3dykO7e+4EmsQhRJOA0iTHk9Hv8b1/TkhzjY2XnXdPVGN5sh9fbFjiS
         Bbyqfc7wyg+5ijHYZ0MTMDxhuPymR44xiG5WiLbRa4O130QapZvSJEJlA1eu9N6hQzjH
         Tpt8YbpS/RjiP+FV+83WVVugq7v18Ra0kXQwUFqJeaSw4/gOhhS4qWkzncLMHJQPxDFZ
         OrfoL9ElwkluaiYnL8hoxCB87+xPKQgQu8kBiSkGhTojnAeuNnpddmCret/l28K9sLIg
         37e8/nR8RH3+Df6QbB7Kqpm22JerKCGAB+gm8EY1VCW1SK2f5xM5cK3KY5zoYfhU1FpF
         xOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vuolA915AcWvE5yagNyuds+oSo4r9HGACr7hD1WRCQE=;
        b=uIU3vapzGdrXvHhKyxqvUTtWEHzQxrO7+OzwLvemRPVb8gtVDwXxKds3hsm+GnEGVA
         ncT7G8uJOVIO+L9Gv4sQCPEbJ27YQ7JH8WIBsIYMLmrpGa1ozPsPBRDMzWNSB3id3KLo
         YbNTnNLvwjm8xzzH3oPwWHM9W9EmfYscAHnpDy3D48gBUM3B9hffpzUT+5bSsPKTHOmt
         2N4Kv/hH39A6aCKCT8NSa0iaSUgogflqbpD8B1tNA9zgdEPO2PtkG/eNTMZkS6NUroxF
         seUqMI13xTSz5ujc8y0snUqD2g2hMAyaGC/1MgoZYDWoHeKK81qCdUBZdt6QBtYf7LFt
         XeAw==
X-Gm-Message-State: APjAAAWcSX19xFngxIsSupnojAtUKRrzg5Bn57LerS8/WZprJZuCkxrk
        mQbU1Xirke+2ZW84TjTfSmJKew==
X-Google-Smtp-Source: APXvYqyzz1HmlUtRP/Bh8rrN0mY5HRxqSiSfvLupSZHWT8aG4tT1Ffd0nky4DLmmqD6ZHXnJtRAwSw==
X-Received: by 2002:a5d:6911:: with SMTP id t17mr11676892wru.268.1565198483442;
        Wed, 07 Aug 2019 10:21:23 -0700 (PDT)
Received: from localhost.localdomain (88-147-66-140.dyn.eolo.it. [88.147.66.140])
        by smtp.gmail.com with ESMTPSA id q193sm586773wme.8.2019.08.07.10.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 10:21:22 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>, linux@roeck-us.net
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [BUGFIX 0/1] handle NULL return value by bfq_init_rq()
Date:   Wed,  7 Aug 2019 19:21:10 +0200
Message-Id: <20190807172111.4718-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
this is a hopefully complete version of the fix proposed by Guenter [1].

Thanks,
Paolo

[1] https://lkml.org/lkml/2019/7/22/824

Paolo Valente (1):
  block, bfq: handle NULL return value by bfq_init_rq()

 block/bfq-iosched.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--
2.20.1
