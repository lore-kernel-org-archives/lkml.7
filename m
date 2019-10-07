Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F6BC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEFC206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmUuP12g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfJGUZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:25:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40367 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfJGUZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:25:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so8090091wrv.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 13:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=j38m7Add2KbD5J4ODINJZZqe9yiJYPvqTx67RyFNngM=;
        b=OmUuP12ghIGPePIpfIea8N/KC9MdIOEcsF5hzsflWfQRAKkn4gtmB8F+iBLQL/W5Pj
         o6BpTCQIugBq764fFgNq2eylNoDrZhcXcW1A/GYNDwC9lSUBJMzgIHyMxBjMXc3coDmz
         JKcEktMHjwwxDUiaH84S1ojwUQqVVtUSuVmJxckm19jBjykPJ4wsHlHBybzgZVoeDCxd
         ic51O5OsFyr8qgr9ueOqXA5DYyuQTEzypg/5q3BRZTc8fXX3kQAHQbG+ZgJYQDp6syEF
         SS7/aNT9rMn/h/pWTeUpPeSz4ZVvoMQoryiCcP69VWokbnnPyZX1QbexK7iV0ThmLQVa
         3uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=j38m7Add2KbD5J4ODINJZZqe9yiJYPvqTx67RyFNngM=;
        b=qGxu8ZBZcgp0M8GwKOJ1d6XPBBdFbymc5xKCILYLKaquCXZQhkgFtWwk7aZIHZUnIO
         iFzPGwCOMXgCX7MJc6NP/hCOsd8Cyalk5RwNPw5FL/WxVa5lUn52GBmDe45DRVnaZHot
         FjVMHushe6p1rpqyLxWPFUumDuo/njgRGeUP9qNN76tcaWdYgzbH1BkS6Mk71O2poZd7
         NJ6SCuu04sbBG+0h63SDBUzECsCXsixmKeyeZOB+Q7EHyg09g5ZDV3CYAmPl9G5bM+Z2
         6C/EAlOpP7NFENY32z65MwD9nS4Of0SfQr34S9oUgQLNrT3MHGcxOZJ2eeC3rb+KtQcS
         dbLw==
X-Gm-Message-State: APjAAAUHIyY3c8hYYIewcttLEQ4FUV7MgkfYNHCqK3ymSS779pJyj6X7
        dlK3al7Qqe27xJ7IK50LbJeXhAz1prE15drtnAWbtmmOuus=
X-Google-Smtp-Source: APXvYqx1wwJ3WL4Mdk1PE5j/sXHlDnXgkxj97/5ydggGCxN5aH6xv9sdDS2EUFmlVRK1VOK5OJ52tj2vC52ZiY6ag0M=
X-Received: by 2002:adf:97cb:: with SMTP id t11mr18129726wrb.312.1570479957034;
 Mon, 07 Oct 2019 13:25:57 -0700 (PDT)
MIME-Version: 1.0
From:   Guy Crazy <superymk.adv@gmail.com>
Date:   Mon, 7 Oct 2019 16:25:49 -0400
Message-ID: <CAPPcaqPhQ2jJ=wRHf5_hVQAT-9gtn7EZv4y+68dEzgsZv7pTMw@mail.gmail.com>
Subject: A Question about the patch "[PATCH v8 3/4] PCI: Introduce
 disable_acs_redir quirk"
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question about this patch from the web link
(https://lwn.net/ml/linux-kernel/20180730161840.13733-4-logang@deltatee.com/).
According to the PCIe spec (PCIe 3.0), ACS Upstream Forwarding (UF)
seems quite similar with Request Redirect (RR). Why
pci_quirk_disable_intel_spt_pch_acs_redir in this patch seems disable
RR but not UF?

One related question in further: what's the difference between UF and
RR (examples preferred)? Both seems redirect traffics originated from
downstreams. Especially I feel confused about UF in the PCIe spec:
PCIe switches must always route upstream requests towards RC because
they target upstream destinations, why these switches need UF config?

Thanks!
