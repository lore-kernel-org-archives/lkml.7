Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87762C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566A92168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3TGfy7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404401AbfJPJ5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:57:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42561 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbfJPJ5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:57:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id c195so16925758lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 02:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XmkE9WlFKI8pyb3SJarkshMXBgc4RxOdMIxQgz3kh30=;
        b=E3TGfy7xP24jXUdwFV+Nil23p+/H3OaGslr52g0fdf5RJs0BFr3EBxzosDTpxlaHcJ
         gfHyVmxK8W0dmqbA+VTMhGVspJtZU+yGCqauOsxbZ9wEnp7wwNMhi1JLeSL2q/IBv0O5
         9pBm9Z7E6JX3/1ZeiST1uEPzS5BuwnNMMrpu8wsrfqLh/6iK5WScbIOOHJMtPYxtUaKU
         f5gstHFXf14SFIK2k8HCHwnZAH8QXLkwl4e8kYpGnMXtc4ue4zSawj9pAKFWtoUMp4sn
         0OpOsxH9L1PqIQY1h7f4HAOk4HkaAV9HMx2EozQaLhk9zULIhib+lMNk0aWLd8ilpJ06
         KCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XmkE9WlFKI8pyb3SJarkshMXBgc4RxOdMIxQgz3kh30=;
        b=b8GNsVmEKX+7D8qrJNTv7blddS6DMeJS8kUkdpe54LqW5DQOvZUKiXyP9pZSIXtsfp
         Go1Ows0AiI8kvNW5IVTpq0a+ctcIdnZXHAdMHus9FLH51wcF8iKWeQv4eW2qWdGIOJb7
         VkDS3Y68StW12YNBgo/6oKyEBbxAqJzp9ujYcehbgLGHBdNSxjD+WyjsOK7G6zSRSaJI
         Ze21P8dQrsF9is5D3Hh3JoxAofS2GdwmBhBnfaghhnYsX8YuGGFTY8N0KBhM5gkhQy4x
         8TIOws3k6aPOyikWLW4lE2Ardmu8XcBlFWt4jvjZ/kpwYMwxRUJJ8DciT6xA7ofDTcdw
         efqQ==
X-Gm-Message-State: APjAAAXHrqCFxL/f+3zK0SHBX4gJOo+7eayQVDOl4beUU5ybz0kG+WzB
        mPP/px0nrpGMrCRRpffLn7Yt/EF11nZBBw==
X-Google-Smtp-Source: APXvYqyByOg+IfsgQBVPxlMuMlhGelXgSpoJEbecz8DeWG44lbDSy7leAjZbMdYWT8OxVRJkL8+zWQ==
X-Received: by 2002:ac2:4830:: with SMTP id 16mr25588588lft.35.1571219869589;
        Wed, 16 Oct 2019 02:57:49 -0700 (PDT)
Received: from localhost ([78.133.233.210])
        by smtp.gmail.com with ESMTPSA id h10sm6016603ljb.14.2019.10.16.02.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 02:57:49 -0700 (PDT)
Date:   Wed, 16 Oct 2019 11:57:39 +0200
From:   Marek Bykowski <marek.bykowski@gmail.com>
To:     mark.rutland@arm.com, will.deacon@arm.com, pawel.moll@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/2] perf: arm-ccn: Enable stats for CCN-512
 interconnect
Message-ID: <20191016115739.0d5d2272@gmail.com>
In-Reply-To: <20191016110612.17381ad6@gmail.com>
References: <1570454475-2848-1-git-send-email-marek.bykowski@gmail.com>
        <20191016110612.17381ad6@gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for the ARM CCN-512 interconnect

Signed-off-by: Marek Bykowski <marek.bykowski@gmail.com>
Signed-off-by: Boleslaw Malecki <boleslaw.malecki@tieto.com>
---
Changelog v2->v3
- Correcting copy-paste typo: this commit adds compatible string for CCN-512
  and not for CCN-502 which has already a support for.
- Now *for real* change the subject to reflect where the driver got moved
  to (drivers/perf) from (drivers/bus).
Changelog v1->v2:
- Change the subject to reflect where the driver got moved to (drivers/perf)
  from (drivers/bus).
- Add credit to my work mate that helped me validate the counts from
  the interconnect.
---
 drivers/perf/arm-ccn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 7dd850e02f19..b6e00f35a448 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1545,6 +1545,7 @@ static int arm_ccn_remove(struct platform_device *pdev)
 static const struct of_device_id arm_ccn_match[] = {
        { .compatible = "arm,ccn-502", },
        { .compatible = "arm,ccn-504", },
+       { .compatible = "arm,ccn-512", },
        {},
 };
 MODULE_DEVICE_TABLE(of, arm_ccn_match);
