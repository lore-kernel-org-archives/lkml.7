Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6980FC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 15:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9EB20843
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 15:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNUkjuTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfGFPNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 11:13:19 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:34700 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfGFPNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 11:13:19 -0400
Received: by mail-wr1-f43.google.com with SMTP id u18so12678863wru.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ur4ztwPQe5Umx3dhtwQJew8AOvqXSgHTLXTzmJRpKQA=;
        b=eNUkjuTZeOBLqgnsz07CuRaCapfhcVjSxkSxS2zi+3QzRPO1dxScWhmzXaEdSJOu3P
         V41xxa/Mlupk86yArBzjiNtWOvwsgOUN32gjR5R0WQxyU6FkjmqvSulN0mZQbsAHhtW1
         d6pKCFnBCmMsenThD9SnbME6Pfv4MUjOMMEowItW9hwUucsoIHzpErUG4Y0uOkurfbuj
         0kSHYAF/ia9XEInURX1QpqpSlQuiCqlk0npg3zJHn1uBRCiETl8dpcRBHJw04zaNIwz2
         HNWm7GlX+k673nbWUabt8prPggAoUqT+oDXRFGEPyJZarlHohwTLKV+FfxV1R4kmN0E5
         MoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ur4ztwPQe5Umx3dhtwQJew8AOvqXSgHTLXTzmJRpKQA=;
        b=RXtZWsRmJwH1D7RpKxzJS3N3rEx0l2bMpEDeWLMcUavyVSgQZ7/lhxgm9A9ly6w00t
         LyO/+/81wuDjx0K+N4dc3+7ooJSepXujc1ODbxu2KeYpcYzLgvungZYt3a+PRj3yVK6Q
         CHRVEW2m78J5cScu3k/9dI/x85nmmICsIe3nBYyVHBupWsDzXFrd3Ju6uyiVFDLsUso8
         wm+fPBdnpE461EIVSlfXGDcErpPwnDvhpWLQ9yqEid/zzUHAgrk1pEuSpPCYj9+4wKRw
         MCdv8LFefYe5bMgwa0u4Tu5mOkps8EJNLOtk+3Oz8f9k9FIHeDzksIoP6nW9iUUDlVG8
         XNUQ==
X-Gm-Message-State: APjAAAVmTmeZmFawJ8+xgAGZqPZNUvyVj1duLOWaRELq3KT9po3rE9xg
        xL4kWpe/QMav+SKXa+/sAjzL7t/VDyc=
X-Google-Smtp-Source: APXvYqypBWAcJpzWv8UV5HK4h1gwCMVCM6bSeoJzpPOlEUHQ7u6pxppHG4eyMLF4mofJFD53gNK9Tw==
X-Received: by 2002:adf:f64a:: with SMTP id x10mr9231612wrp.287.1562425996553;
        Sat, 06 Jul 2019 08:13:16 -0700 (PDT)
Received: from d-allen.localnet ([2a02:8010:606b:0:7825:ae18:f382:7014])
        by smtp.gmail.com with ESMTPSA id x6sm6801204wrt.63.2019.07.06.08.13.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 08:13:15 -0700 (PDT)
From:   Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mariusz.dabrowski@intel.com, jsorensen@fb.com
Subject: Regression in mdadm breaks assembling of array
Date:   Sat, 06 Jul 2019 16:13:14 +0100
Message-ID: <2504385.aUmv4P13uU@d-allen>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Off list, please keep me in CC, thx!)
Hi there,

TL;DR:
https://github.com/neilbrown/mdadm/commit611d95290dd41d73bd8f9cc06f7ec293a40b819e
regresses mdadm and does not let me assemble my main drive due to kernel
error

md: invalid array_size 125035870 > default size 125035776

caused by changed reservation size in mdadm, and thus reduced "Usable
Size" being reduced too much (smaller than 0.5 * Array Size).

Full write-up with logs etc here: https://forum.manjaro.org/t/mdadm-issues-live-cd-works-existing-install-breaks-fakeraid-imsm/93613

I chased through both 4.0 mdadm (which works, e.g., from a Live image),
and the new 4.1 version (from Manjaro update), and the same disk in the
same machine works with the older, and refuses to work with the newer
mdadm.

The kernel message suggests that the kernel refuses to assemble the
array, and tracing the computation back through both versions (4.0 and
GIT head 3c9b46cf9ae15a9be98fc47e2080bd9494496246 ) reveals that both
versions end up using the default for reserved space, which is
MPB_SECTOR_CNT + IMSM_RESERVED_SECTORS (the other difference between the
versions is the size computed, but that is hopefully intentional due to
444909385fdaccf961308c4319d7029b82bf8bb1 ).

I understand too little to propose a fix or know why the defaults were
changed, but this is clearly a regression, and the disk works in the
same machine in Windows, and with older Live images.

More log output in the Manjaro forum thread, and I have some more log
output with printf's sprinkled around if necessary.

Happy to help fix this, please have a look :)

Thanks,
  Stephan



