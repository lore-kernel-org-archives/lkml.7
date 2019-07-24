Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA934C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD29227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxgiEAG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfGXIuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:50:04 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:37141 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXIuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:50:03 -0400
Received: by mail-pg1-f180.google.com with SMTP id i70so10127847pgd.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 01:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=rN+948Su3EXVIwlWiX6QSbAmB2jjxztNI2MmhRW+gZo=;
        b=RxgiEAG2xV3+3v5ltN1ukOKKVHulDr35PZCXEI4mINwh5Ew50bPQhDb/WCJb4hflk3
         sGoD6XGaCcoJdYl9OUvIp0NCwFMWvUUgEel5OYs8495RSbYqX8LVJ9d4zOPHN+BxSpWP
         NROcC11G0gWUwMFRfZYuJoVxdspu/kl5jog+IxRl9R6YOkv3TCMxav0/T104E2XG3hg+
         GJpWwaHVBjE00dM3Rj7nDhyVuGHWLJkzStvP8e6UjLgGZq7W8EfiVwLNfxpE4J9VSOk1
         z+NnZpt2LoS3W8ksc7gEyMaJOLw921IMS3CF5feq3ktXRv0SEwzRcYvAqRgkQj0Abtg0
         k0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=rN+948Su3EXVIwlWiX6QSbAmB2jjxztNI2MmhRW+gZo=;
        b=NnTh3jgqn1SKpN2wPvu3IFnyyPQ9MqF040K03bigIWAn6kBP5sW2KM5vBocJ4VNhYh
         ZXPdnSm434fQwZI75YgORmXYzDyc2CYb9o987l9ItmmLFb8W9PuFsQaGJ9WkLzYbB/o4
         6h9Gq0n6ng9tycKhCPM4ZLkf4ky2TpE2E86Bog/ULP3nZRCS6a5kJBnjzr4RoOolDtt+
         8vofhpMWEgHUhxzXxfRdWf4gi7OpkV79irp0CI3fCrmvcBL2coi0L+vgCeEWgU17oUDF
         mfzh95WCtsN2QYTeKgSpzYVu+oud7VJ5ikA9vz0dH4ewNFAhqeFaj7vWkbNtKOgqH3Vi
         QQ1w==
X-Gm-Message-State: APjAAAUpoPK/ZTfhm9BUkQD4ApyaKuq8r50KMoWHdOy7cvC2jWneeBOD
        2bR1EaQC/Ryvzoa0GW1nhTsScfT3y8Y=
X-Google-Smtp-Source: APXvYqzeCNO9lcvlPHi+hU5vR51IR2zY1n9lFHNsjQTiduxJ1SbBU4qV4MOx3q8STOLsEIwm4UOQZA==
X-Received: by 2002:a65:4808:: with SMTP id h8mr79526364pgs.22.1563958202860;
        Wed, 24 Jul 2019 01:50:02 -0700 (PDT)
Received: from ?IPv6:2402:f000:4:72:808::177e? ([2402:f000:4:72:808::177e])
        by smtp.gmail.com with ESMTPSA id 85sm47011924pfv.130.2019.07.24.01.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 01:50:02 -0700 (PDT)
To:     rpeterso@redhat.com, agruenba@redhat.com
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] fs: gfs2: possible null-pointer dereferences in
 gfs2_rgrp_bh_get()
Message-ID: <8d270882-54da-365e-1be7-a291a5178b1e@gmail.com>
Date:   Wed, 24 Jul 2019 16:50:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gfs2_rgrp_bh_get, there is an if statement on line 1191 to check 
whether "rgd->rd_bits[0].bi_bh" is NULL.
When "rgd->rd_bits[0].bi_bh" is NULL, it is used on line 1216:
     gfs2_rgrp_in(rgd, (rgd->rd_bits[0].bi_bh)->b_data);
and on line 1225:
     gfs2_rgrp_ondisk2lvb(..., rgd->rd_bits[0].bi_bh->b_data);
and on line 1228:
     if (!gfs2_rgrp_lvb_valid(rgd))

Note that in gfs2_rgrp_lvb_valid(rgd), there is a statement on line 1114:
     struct gfs2_rgrp *str = (struct gfs2_rgrp 
*)rgd->rd_bits[0].bi_bh->b_data;

Thus, possible null-pointer dereferences may occur.

These bugs are found by a static analysis tool STCheck written by us.
I do not know how to correctly fix these bugs, so I only report bugs.


Best wishes,
Jia-Ju Bai
