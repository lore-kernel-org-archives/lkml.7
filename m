Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD599C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734F72064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HViIoR2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfCKUyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:54:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45302 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfCKUyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:54:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id d24so318244ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 13:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U+3QcfvocSbrPnop7NmaFRUnP+hcHK+uTwNneM6FOCg=;
        b=HViIoR2WLJGnz70E6F1JywZhDiTGI8O0NG+vXtNU9g1yxaBcUCvzzG3omr5TD/6mLG
         h4zJh6QFhGtZ+zYWEPHhDMu704wEC7UJDkhwhFMX6DiaivR0sWQ90KQ1hICt6lkB2UMD
         EAZwxtAu2YFkh8/NrM+XGj+bF/Yh5Yi79Ka70HJftBq6oe+VnEFebj5K53S7vWtdqBtZ
         htjchmtGBCZlXek8qZWlsyrIsy8M6XZZ8Gbh64n/B5kD9qzotOIGVBBLCy//QQr9xzQI
         6vL/RuYMDp+Oz4a+aBRQ7X/qJKXxlXhGctgjM0cAqOZDSx+uYqwSZEbEV8HrGOIcqQre
         X6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=U+3QcfvocSbrPnop7NmaFRUnP+hcHK+uTwNneM6FOCg=;
        b=beL8Da76VfuNvlELiLeLF3zBoKX1+ex5b+pZsrUQXNQBJYyy5y0PWFSpamgeZNmKJc
         0UCPQQG/nivWpxvshXqyczBb/Ci/CvS1qrVnpTjR+hSXAcwXgpP7ub0E7d2qRwR0PUSP
         GABSVc+EHzTq/4VnnPzVky7aOq3FDNFzfcCA/JnfOlN/9JtYImgj7rNJYHCP2TGSuk5x
         quRLXTaHpkFwBQnqvyol6F6nEev+RCmSDwxrRYrpuDj1LYiUTnK27jE9F4pMNpy0816z
         2HPyT5cwr//T0tZF80mEAfxjsQEfYqJRir400F6pX7X6qM+pGku46fI9AsTiLijAwWwP
         J1WA==
X-Gm-Message-State: APjAAAXNzPgSuv3H4X5+eGt8zP0+sUdWcTPDCThGSLCX7Vu2pDk/Uy9z
        5qbcz2pOFtUE1LQc6bVp6pQ=
X-Google-Smtp-Source: APXvYqwInFzyxRmHsmvpaOZ8007EfRS/nyBxBLiKZQ8UaUL8j5yhhudMJ5l1p5acoOJXuYVN2VlJGg==
X-Received: by 2002:a2e:3316:: with SMTP id d22mr306499ljc.145.1552337650045;
        Mon, 11 Mar 2019 13:54:10 -0700 (PDT)
Received: from localhost.localdomain (89-68-132-187.dynamic.chello.pl. [89.68.132.187])
        by smtp.gmail.com with ESMTPSA id c1sm1246894lfk.79.2019.03.11.13.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 13:54:09 -0700 (PDT)
From:   Mariusz Ceier <mceier+kernel@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Ravindra Lokhande <rlokhande@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mohan Kumar D <mkumard@nvidia.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Mariusz Ceier <mceier+kernel@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] sound/hda/hdac_stream: Avoid NULL pointer dereference
Date:   Mon, 11 Mar 2019 21:53:56 +0100
Message-Id: <20190311205357.7573-1-mceier+kernel@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like commit 9b6f7e7a296e17990aae298c809b001e99ddd151 introduced
NULL pointer dereference for ca0132 codec. 
When ca0132 loads firmware, snd_hdac_stream_start is called with
azx_dev->substream being NULL.

This patch calls snd_hdac_get_stream_stripe_ctl only when
azx_dev->substream is not NULL. Even if I'm not sure if this is correct,
since it might be that ca0132 codec does something wrong, with this
change NULL pointer dereference doesn't happen and ca0132 works again on
my system with Recon3Di.


Mariusz Ceier (1):
  sound/hda/hdac_stream: Avoid NULL pointer dereference

 sound/hda/hdac_stream.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.21.0

