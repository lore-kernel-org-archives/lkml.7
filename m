Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB45C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3771233A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zWam6Whh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389528AbfHVPVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:21:01 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:54617 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfHVPVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:21:01 -0400
Received: by mail-wm1-f45.google.com with SMTP id p74so6034512wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J3YgGpXbrKQChiIbL9RIJ74I0ACDqCIQRcWEjtb7+qc=;
        b=zWam6WhhG3qEy/a1cJrD/hvQngGX/9zZNrlhYJ9WhqYxuhfSWPmNbQ5q5EzBtGGcFY
         QN9n4XFbexIC+RoTAtlz9tGs8cl1lz4tWViai/IfWdMQPEVRbBpQkt9Hnl6UefSBPodG
         eOqWZtVLUVjKMUYh4F4yolQinHvxoJuqXeO7ls065cvFf+lwHEEcl/uwQFXpdKa6uobo
         nqrgsYLvmC7+2ny7zNxO2Gs5RavMze6Qs0+gGymhyI+5fOtKXj3RmAoeswbBhq0KnLiw
         OMAIGyEXxv3GfVtOYjclGCPhDwKQlNDrop9mvrK853MEr022rRGOVJ05Kew6fTwWx91Y
         GmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J3YgGpXbrKQChiIbL9RIJ74I0ACDqCIQRcWEjtb7+qc=;
        b=pTGztESslW0I97Z97+gs0Z7xXYyxpkRmJiVj6XRjKTr4K75dAU1nKV+mDMu3t/s3/g
         nURdHedezEJtyS7Ua21cdMvA/Mv4oqY04451lMdbx//th75Ho9N/yuRrzF5g+Sn74OEy
         rDgPAvuvMnizwy2rRmQTkP1A1kNe7YbioLBHDHtBXOt9IRwiSsOz0AyL7lMykhCR6E7q
         Ra2EUmEWjGVxVUigK0gbdjJzNs3ovhjbQQzdgkiMHp83/KlAw4ERSM4MZT0L6jVlhGNG
         v/dDQCGylYyQ6GqK3djiXlJGJPGXw+bzXzKhjoFpTXZJg/o5vEN4BIEPonyQDmdeEMpf
         s6mg==
X-Gm-Message-State: APjAAAUPYv7y4os0gU75SAKhwR+J30rpVmdH6x258niuF0UC7ePQ7RSO
        +AUmrtdDtINT+D/Z41DqVUJ7KfUcUQ8=
X-Google-Smtp-Source: APXvYqwLVRiZycBwPEqUp0/01LDS0CVDmgJEvFbmSIMFi1mw9mOJLZJbESTF2oRVAQJJXeGiW4OwYA==
X-Received: by 2002:a1c:18d:: with SMTP id 135mr7066479wmb.171.1566487259187;
        Thu, 22 Aug 2019 08:20:59 -0700 (PDT)
Received: from localhost.localdomain (146-241-115-105.dyn.eolo.it. [146.241.115.105])
        by smtp.gmail.com with ESMTPSA id a19sm79833974wra.2.2019.08.22.08.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 08:20:58 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 0/4] block, bfq: series of improvements and small fixes of the injection mechanism
Date:   Thu, 22 Aug 2019 17:20:33 +0200
Message-Id: <20190822152037.15413-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
this patch series makes the injection mechanism better at preserving
control on I/O.

Thanks,
Paolo

Paolo Valente (4):
  block, bfq: update inject limit only after injection occurred
  block, bfq: reduce upper bound for inject limit to max_rq_in_driver+1
  block, bfq: increase update frequency of inject limit
  block, bfq: push up injection only after setting service time

 block/bfq-iosched.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

--
2.20.1
