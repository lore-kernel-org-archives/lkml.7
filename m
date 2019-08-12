Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E338CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965262070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eblau.com header.i=@eblau.com header.b="CuQloUea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfHLVob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:44:31 -0400
Received: from mail-yw1-f42.google.com ([209.85.161.42]:47001 "EHLO
        mail-yw1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLVoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:44:30 -0400
Received: by mail-yw1-f42.google.com with SMTP id w10so5788577ywa.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 14:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eblau.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=sPBAFikQ5dbsHvodsfzqxy6UA1XT4ASmKblj8zTdSz4=;
        b=CuQloUeaii9+GGUM4gXc9R/lK2mADYIIJ3/EU3oYXg4ZBKK3HNFojpF8Gs3AGcxLrg
         Up3uZAkIY5IE9/R1Iu4HXhcDHNupUry09rwZsFGFsxTd0iQB0suGcCcoEXl+t3xg2cgt
         AmsqRQdke+/lBWavHda//ERoJAeoKmZ4WJ2aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sPBAFikQ5dbsHvodsfzqxy6UA1XT4ASmKblj8zTdSz4=;
        b=XxlvfofMe81ctyRGX/PmchrIn5jWVwi0T/MSy5vH583HG5y6aZKtrgsh13ewKshjMV
         dA43svc8hFodgdD/jFFgN4mqLcVqNQDNAfOj2yMzccGgcpqeiEhUb76oHawRsvNpjQk3
         dpiGFsBooKnBjD6Tt6ntoSQ13OVmrhrv/jFsn1jUSXz3OLWFx1LEJsks78n3UaSAIYUQ
         l9eVhYNaIml6YutoApuCKW7P+Z8P7Pq8DtxKaf9kEWaHL+yeGP2ye3RKe5aSre4IF/BP
         23nmadZFCg2s5CLA/0E1OhCDoRC5Wfmai39ioCV9jKgtnG0M1Z8qAa+mApJWsIzqMmAm
         CgzQ==
X-Gm-Message-State: APjAAAURVK98nUlMRqk2+KAUpdpHAtS0cm9Zg61w+u2CUFgMYq8qP1s9
        bGRWkoYwMqgZFhB1myEfKEdVEPq3lSlKUyt4WpYsLWWr
X-Google-Smtp-Source: APXvYqxCQ2DQzluxIF/Vt0jlaox0mat6nXFUSheUt2vG/bdTMsLy7gCBsEpvc4ycogn+66+UXaTDzGIpUxNtkUUzFew=
X-Received: by 2002:a81:2655:: with SMTP id m82mr6285793ywm.306.1565646269778;
 Mon, 12 Aug 2019 14:44:29 -0700 (PDT)
MIME-Version: 1.0
From:   Eric Blau <eblau@eblau.com>
Date:   Mon, 12 Aug 2019 15:44:14 -0600
Message-ID: <CADU241M42pe_vFD4QriuVm_CjnpQe0LyBUDihaDkxm5k6o7X3g@mail.gmail.com>
Subject: [Regression] MacBook Pro - suspend does not power off - reaches
 dangerously hot temps
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a MacBook Pro 12,1 model where I've hit a regression since
upgrading to 5.2.x. When I enter hybrid-sleep mode with "systemctl
hybrid-sleep", the laptop appears to enter suspend (screen turns off
and keyboard backlights go out) but actually is still on with the CPU
fan powered off.

When I first noticed this, I had put my laptop away in my bag and
noticed it got extremely hot to the point of being dangerously close
to a fire hazard. It was too hot to touch and would not resume
successfully either from suspend or, after powering off, from
hibernate.

I've had no issues on 5.1 through 5.1.16 but every version of 5.2.x
I've tried (5.2 through 5.2.8) has exhibited this problem. Is there a
known regression in suspend handling in the kernel? I noticed some
traffic about suspend and NVMe devices but I do not have an NVMe
drive.

If nobody else has reported this issue, I would be glad to do a bisect
to help resolve it.

Thanks,
Eric Blau
