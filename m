Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637C3C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37909253B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LzGFxQZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfFCWJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:09:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45354 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfFCWJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:09:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so11371787pfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=jDdg1OwF0FAhl89N9DnPSHZNHtzrEJIzfPoyVuGv+78=;
        b=LzGFxQZ0HmsQrlNUSQTMFV923mwkZPYwGjfWrL8bk6Qf75flD9EWeDTDtnlRYNUeSX
         Z6g/fAiv//bzpgk278/+RMf6+0sie1PDBOJDC0NrwjM55QOJBK2hL2XCflc2vZQGv6Zw
         Jt00ADsRrcrZH4s4HaaGYWtM0Z+5eRuramr2PeArPDnHHWMxxgHM6chzVAzG4iybTVet
         GcU4AXW65i1dwoBVxDNf1e0OAvSKOmUq5/CU2oKa7Ldmk+/UCFVWFgdD99gJLOt6BW77
         oXj6E96l0DF1oFOKkz8oPIx2KVMi+1yzMdfGMpVRo6dCXidZbLV4zHvrwhiTpJ80onOb
         q39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jDdg1OwF0FAhl89N9DnPSHZNHtzrEJIzfPoyVuGv+78=;
        b=Wg461Osf5/9SW7bWgNY55GR8NfMzcOevqD2MOvdKWjBjaYq1c05tWlXHaVjsPZ2+Oe
         XgAhNuVoQ/sV8P3M/QM3RGSL9jo/QKWx330AI4dLfoiM9730dupE5bxueUWUtANYKesH
         WBMKiqqB9oIYtRrDurFavB/L+QkKPCLvXUsHADyYj3XsHo0GPKDtj/chatNg9XBvA05U
         9bw6Mf2Lhjum0WlnJbMLsRw7tIySG1j6wMSukLEeBuyZ9rgG447tSr+j/z+M4oXzTnnP
         pTO3zK+42rKMKwfwepYT+9XPRyvK7KOpqZzXH+VRcbfTtMSD8P4zEJndvCMOPLRht0Mu
         IjhA==
X-Gm-Message-State: APjAAAVahfECM3s0sYSj6A3S1wtiJFR7yAiw7jeLsnwm2Px7hll1UqS3
        OaufxP2aqY/XY7VL6AWSgTCCJQ==
X-Google-Smtp-Source: APXvYqxg8k7T+sG/qb4J+4RL4O/uO7OVHc+0v4sMYS2wFnS6GZbj06GAxSZ4+jmaEw+VTfJLuCeQSQ==
X-Received: by 2002:a17:90a:30a1:: with SMTP id h30mr33597503pjb.14.1559599768218;
        Mon, 03 Jun 2019 15:09:28 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id t7sm13213708pjq.20.2019.06.03.15.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 15:09:27 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: add dwmac-3.70a to ethmac compatible list
In-Reply-To: <CAFBinCCKA-15sFwyXpoxmqw5b4=6j1t-fdrHM7CoAojqN+ZGzQ@mail.gmail.com>
References: <20190524130817.18920-1-jbrunet@baylibre.com> <CAFBinCCKA-15sFwyXpoxmqw5b4=6j1t-fdrHM7CoAojqN+ZGzQ@mail.gmail.com>
Date:   Mon, 03 Jun 2019 15:09:27 -0700
Message-ID: <7h4l56jp7s.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Jerome,
>
> On Fri, May 24, 2019 at 3:08 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>> After discussing with Amlogic, the Synopsys GMAC version used by
>> the gx and axg family is the 3.70a. Set this is in DT
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Queued for v5.3, w/Martin's tag,

Thanks,

Kevin
