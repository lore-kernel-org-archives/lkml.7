Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TRACKER_ID autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BA6C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1135E2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfGSLdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 07:33:07 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41397 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfGSLdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:33:07 -0400
Received: by mail-oi1-f196.google.com with SMTP id g7so24000446oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 04:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DVH71sx/KUqNMTRsOZ2/nVIJEw+oefCrzrIa/hxtMs8=;
        b=lyofpPpHpfhlbDrZBPJhqG2ftlCqHF7C53Y2OmJDW9OUofkqYC/0GdiPF6Ep1dmkMt
         MBHDQrz750m5ph+J0xoqNMnzkKJ94R0BiGLpjEe8mqtFxqwVyE1YGUg9q32LoJ5r6ub9
         qaBDCtFoWYxlysd7rSUDxHNo0WFt3SntvQOZgllR3KRaIBIg67ppFL43NU0ae30Gf/3h
         lYKaVR931bCYq/LEor9jPmzMJBvOuajzSQ1TiA7NDOqLCuWDYtk3z00NUipk2NOKI3Qv
         YGVEhoZAA6jw+RFhGGCGOYShUcUWpG2+znRjyHOB+OGTM+C/W1nxXtxhyaRzV9wjYO1x
         2/rw==
X-Gm-Message-State: APjAAAUsyUP6bsq7Lw9F+KFKOemnB9a2HGWwZiJlLocaSLamB6a/Sffm
        QOdnBX1Kr9OQMcy/qCr+xWST2M69nCu8JwG2meO6wqwy
X-Google-Smtp-Source: APXvYqz6DeDEHX82W2caPGlXlt4Xtf0e6Wrr1snsQJy7l6ruvyBiSq1k3ercbyBq/N2onnVcVW2hdGZvlE+tZBo9/Eo=
X-Received: by 2002:aca:4744:: with SMTP id u65mr25338324oia.16.1563535986289;
 Fri, 19 Jul 2019 04:33:06 -0700 (PDT)
MIME-Version: 1.0
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 19 Jul 2019 13:32:50 +0200
Message-ID: <CA+7wUszbn05nieiVsGM=MXFtf9HVks8vqtuOKw7ejTYFZhq0iQ@mail.gmail.com>
Subject: Help: Regression in v4.19 : do_IRQ: 0.37 No irq handler for vector
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc me please]

Hi there,

I recently upgraded my desktop to Debian/buster. Now when I start my
xfce session I can hear the system bell, and my dmesg is filled with
numerous:

[  920.728347] do_IRQ: 0.37 No irq handler for vector

The symptoms seems to be gone using git/master:

3a1d5384b7decbff6519daa9c65a35665e227323

Could someone suggest a method/tool to track down which commit needs
backport to v4.19 (other than a git bisect).

For reference:
* this is bug Debian #932304
* I can boot in recovery mode without any issue. It seems to be
related to an event in single mode

Thanks much,
