Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1ABC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A1F20857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=epicgames-com.20150623.gappssmtp.com header.i=@epicgames-com.20150623.gappssmtp.com header.b="yQ3oxLWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbfCZJd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:33:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46956 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCZJd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:33:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id d1so10088750edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 02:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=epicgames-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1xSRUEM1UhnUDL7ifjfi8Jjv8fd2PXOQZ0AyKG0addE=;
        b=yQ3oxLWALiJCipF0GvP1A3v301Cr5cKfVnOHiU9bCcm55l70sPFpkkiuSesAaRDlD7
         +v1SrrZ3nZJAg4tfjgo0mWhvwlQD9QEY+KjGqgA+0TrgIKuSQndIA1I6P2S/ivlQIH4A
         TsaKqNtVBSo7TDc5hDyIyVYEzlQesoMXBC3Br0L9TlHPnvH6jWU83PPll+RsvH0KZf+l
         MctCPK91vV1J89TtnbowgT5w1RyFthj3VEMq9qJ0auxi6jyWGNREis3kxK1ldSHYyVQt
         HIkhmAchZXzZ7SooGsyRZdA6hgDgPF/JTR8NuYHKeEjvDg5i7aPT1rWCXqX1gZx+Atqe
         gMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1xSRUEM1UhnUDL7ifjfi8Jjv8fd2PXOQZ0AyKG0addE=;
        b=qat3ynSzWSdleRkxr/7Ee+yAc6cbyCEd3IC95uKxldUdDqTw2YnPcVnyAHD6XZp5iM
         fW2Q82YplX6pkExoOb38iKrTyM86jqze9qQdryDkldRPPSwwK3y0mAw11Fj8TGkGmEm6
         CS7vaAOawCb1OPYM4gkH5iVtzO/+rqCDafGF8GIfvgUxhrVcdwfbzlTI2/wT1jxygskI
         2tb9AlLmdFa/LyQoltZXzlukv3NzX4O5vN8duQlIsYojVIUxxppVq67gN8af+h/wiBDc
         7WtzslWrvmbyOsfAXtE1iQ0g0VjxEAO7YSn3FjvtRpeWDKRDgIZJ6hZ5D44PGqKyXU5d
         FYNA==
X-Gm-Message-State: APjAAAWzp28qufBKL94q00NhjswFUfs5yxgnrt1TIDu8/qo3Z8bSWDs3
        7hlZHEegd+kNEP2XXZNB5c/M5xbAGRcp8a7Fk+pC1QXWbSQ=
X-Google-Smtp-Source: APXvYqyyC9FrUhRbvI2hf6pjbBPurhgQcXAwHEXTklcsk1i66PJDL96Ag6Sq29fpllknZQ19O3k6SS0AC1xMoOSqIpU=
X-Received: by 2002:a17:906:68c2:: with SMTP id y2mr1923027ejr.30.1553592806281;
 Tue, 26 Mar 2019 02:33:26 -0700 (PDT)
MIME-Version: 1.0
From:   Gavin Will <gavin.will@epicgames.com>
Date:   Tue, 26 Mar 2019 09:33:15 +0000
Message-ID: <CAHgt1ikzuxR3yVU_gpAvO44fR=04AaNn3h4FGeLA+Hin9OnZRA@mail.gmail.com>
Subject: Re: [PATCH] writeback: fix range_cyclic writeback vs writepages deadlock
To:     david@fromorbit.com
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

We believe we have seen this deadlock issue on our XFS system and
currently are trying the patch (aware of the disclaimer that it may
not be production ready). However trying to repo this issue is very
hard. I was interested in Dave Chinner saying that he had seen a
repeatable deadlock and hoped that meant that there was either a
process or method that could provoke this situation from happening.
Currently we see this deadlock happen about once every 1-2 months and
hence trying to speed the iteration up.

Regards
Gavin Will
