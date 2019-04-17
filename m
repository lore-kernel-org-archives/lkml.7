Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFB5C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07822073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6OCI8g8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbfDQIfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:35:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35010 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfDQIfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:35:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id t4so13137021ljc.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 01:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=HE9AdSyj6Xu+M4CDNxaUyXeYyEky8JqgeK1vrcackXY=;
        b=K6OCI8g8E1m2UF7ZmFB5XQHjq7lCGpCRt5EP3S/RYWBTjDZKQy+vkRJ1YLzJxdAMO2
         gFgiZwLZDo0nGfIFeLDqho1yCZok4AnOwB8xj5U+jQqzyCYIwSvCgblhUytiX7r+qzlm
         9NUw4uBpzm/BQKaupHy+yN3dPC8wcMyAu5l3UlFcKhQH306tKiICIHF+AkKmwnou09F4
         eCx2zUPWQQx0/K76ybi2GlZA7tAvQ4fEyj19duwnU7fw/WV4fDGMnskt6ttdZ9gL2n7y
         jNszH93UPC20ttfkS/w8OnUVC285KZeEef5ITr26Nu97XAyZOnkT8ifH9+FFf8mbAl4h
         Z0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=HE9AdSyj6Xu+M4CDNxaUyXeYyEky8JqgeK1vrcackXY=;
        b=ipdrUunnvPL4zkLV4mHY1hJ7hpMHj6vMlJt6D+buEcxO9hLURUcud7Hg1O5W7PP6gn
         6mUk5pKtXq1F/xobybouFe3WkgK7mZC+93c6WYXekI545Whf5hC52ceL+KASGaVs8aJ3
         Z12ri+qt+MJhsdrRRg/YpQCdqSJ/BVcsuFRThhPgc/EcpIoQIxriywql3Owr2s5tR3e2
         1YWhqoU9ru5sWaCjqFNKlvobYSVkkMqWbWX/4HjoEpuSAVU9XIJhKuT4SYts+BGmkXNN
         mIc35YsVP68xlqJF5OJPBSFe9MJpkodwErWgr2l7yXV2Sw0W5j/W1QxeLqn9bOGQhwMo
         GrvA==
X-Gm-Message-State: APjAAAXyK9LyFJ4O8q0Ngg6OBPAxEOfIiS7L25Do2XNB7GXrX9MlTLRa
        Jz5sABQEoYt44uRvpZycKdY=
X-Google-Smtp-Source: APXvYqx/1W7r5BcBsBGdz4XhIoiPlTwQRfInV4VnPM6C+id0DSBq01qwWcbQQtDXgXTEOKmRO/N7Cg==
X-Received: by 2002:a2e:9811:: with SMTP id a17mr35692132ljj.96.1555490112620;
        Wed, 17 Apr 2019 01:35:12 -0700 (PDT)
Received: from seldlx21914.corpusers.net ([37.139.156.40])
        by smtp.gmail.com with ESMTPSA id s24sm10762311ljs.30.2019.04.17.01.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 01:35:11 -0700 (PDT)
Date:   Wed, 17 Apr 2019 10:35:10 +0200
From:   Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleksiy.Avramchenko@sony.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCHv2 0/4] z3fold: support page migration
Message-Id: <20190417103510.36b055f3314e0e32b916b30a@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements page migration support and slightly better
buddy search. To implement page migration support, z3fold has to move
away from the current scheme of handle encoding. i. e. stop encoding
page address in handles. Instead, a small per-page structure is created
which will contain actual addresses for z3fold objects, while pointers
to fields of that structure will be used as handles.

Thus, it will be possible to change the underlying addresses to reflect
page migration.

To support migration itself, 3 callbacks will be implemented:
    1: isolation callback: z3fold_page_isolate(): try to isolate
the page by removing it from all lists. Pages scheduled for some
activity and mapped pages will not be isolated. Return true if
isolation was successful or false otherwise
    2: migration callback: z3fold_page_migrate(): re-check critical
conditions and migrate page contents to the new page provided by the
system. Returns 0 on success or negative error code otherwise
    3: putback callback: z3fold_page_putback(): put back the page
if z3fold_page_migrate() for it failed permanently (i. e. not with
-EAGAIN code).

To make sure an isolated page doesn't get freed, its kref is incremented
in z3fold_page_isolate() and decremented during post-migration
compaction, if migration was successful, or by z3fold_page_putback() in
the other case.

Since the new handle encoding scheme implies slight memory consumption
increase, better buddy search (which decreases memory consumption) is
included in this patchset.

Vitaly Wool (4):
  z3fold: introduce helper functions
  z3fold: improve compression by extending search
  z3fold: add structure for buddy handles
  z3fold: support page migration

 mm/z3fold.c |  638 ++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 508 insertions(+), 130 deletions(-)
