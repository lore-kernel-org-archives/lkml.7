Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88D8C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805DC20673
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmzY8iGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbfFKMaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:30:35 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:44376 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfFKMaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:30:35 -0400
Received: by mail-vs1-f45.google.com with SMTP id v129so7751657vsb.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 05:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gz3HqulYPvDCNfbcUEJOb/UAkc1+ZcJON/gujaAEXD0=;
        b=HmzY8iGWE4Yk2oQRLRu48hKTyF8RzCNOzW/P5czsYYSgeANwSG+7RB8x39I6COkeBo
         JcYesfnyAib72/r4g5eWMnHv+ERjOr4XUa5xuSjLNx78fao7r2xHdDmnsZxIuFEU5Arb
         hlpJV9tcKcmPHjXYIMHc4iaydhZtEr1B20FkFWf01CU4gLjCcj9VUtflJ4c4Gxq/DqK5
         oNgFcgLIEiMItMiuy9SEFaUq8VgiJuEKYouU5HrZ7Jl48rY8yjRy/6j5MwUvDveR//R1
         OT11uoUr7a1M6gPNxJpfetuKgW8J6TbkhZco124MfYsGGWu40AJjTfY+Apv5S7J4VB/d
         5Q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gz3HqulYPvDCNfbcUEJOb/UAkc1+ZcJON/gujaAEXD0=;
        b=RVKHSBicnIpKbKYxaTpd74rCCr5v95UWE2FC/Ar6dYtQfMHcvWyTeVZwAH1W+3Fh2p
         ReVA4f3ReyR50yI4FKL+LSIRvBa7ngtceLz60PkrqF/kOXawNlTv4YbR8LdTOFwSgTTW
         oOHwl/55d5Pcvfr8nfyR0N8JOxMRO0Q6CyLe1nBNwQac3FeJuS3A/S7iVzIc2Mv0x0nh
         ySNl9WUb/I8eheE+m+2C/0Lr/9xSonnT6kjlVKAyU44cBw3yUKMiVQYwZ56nVEjAL7Yg
         QOMw0ma2QHwl+CL3uZBBwigDYx3DPeykPlMtZp+pkzRvr9nSd/5Ku+asi3SmdK1/jb6X
         t6Rw==
X-Gm-Message-State: APjAAAXzzsEMO/J2TexrOPRDUfcob6b5VTi1OkQdcJhOv0ebYb55orkM
        4diLgOk1nVEmNzxv6+dApSVv5C8K7iL4z3ZXpWCVN50e1XA=
X-Google-Smtp-Source: APXvYqxI2htrUVQ9hXzBCZmaHeqhE6ujSVrkHU5bi67mzovbs8gfkWsrmJRj2Q+VZ4j3ipY/gTnP/L8YtSnmQPjiPuA=
X-Received: by 2002:a67:eada:: with SMTP id s26mr24905937vso.163.1560256234020;
 Tue, 11 Jun 2019 05:30:34 -0700 (PDT)
MIME-Version: 1.0
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 11 Jun 2019 15:30:08 +0300
Message-ID: <CAFCwf11EM9+NDML9hQmk9-rPzSmDmAyVLW+qOfs6h62dGK6H9A@mail.gmail.com>
Subject: Question - check in runtime which architecture am I running on
To:     linuxppc-dev@ozlabs.org
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello POWER developers,

I'm trying to find out if there is an internal kernel API so that a
PCI driver can call it to check if its PCI device is running inside a
POWER9 machine. Alternatively, if that's not available, if it is
running on a machine with powerpc architecture.

I need this information as my device (Goya AI accelerator)
unfortunately needs a slightly different configuration of its PCIe
controller in case of POWER9 (need to set bit 59 to be 1 in all
outbound transactions).

Currently I'm reading the PCI vendor and device ID of the parent PCI
bus device and checking if it is PHB4 but that is an ugly hack. (see
this commit - https://github.com/HabanaAI/linux/commit/1efd75ad5c9779b99a9a38c899e4e25e227626bf)

I dug through the code but didn't find anything that can help me so I
thought of asking more experienced people.

Thanks,
Oded
