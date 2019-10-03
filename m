Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E16EC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF8820830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XUFGIGD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390667AbfJCRoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:44:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44858 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730993AbfJCRoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:44:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id i14so2169225pgt.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 10:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=wgtFkL/FFRFrlD7W9UDHQPj6n9N+/Wo8Jj+YzpO0YxI=;
        b=XUFGIGD09TqEqmkFIqlIZjHwCq9P4g6INXCLyMVZlHNV2VUniAmRCDbm/DbO9MxJ/f
         Zz/bwzmkRc+zW9SB0447I2PEhwobtbUQljlruZs7iTfvwGn9G0XLOJCQHq9PtHqLjzQV
         LiYGvocI4OuJKqOmXEJRNnd1SSCB9WRHEG/+RTmytroyvvq0d1PB47xtO+mku1c6NtXs
         6UxLj3dEpJH74J9al6AcBlchVPJl8vzA6hoLwRR1GNycQWp6rokCBTZz6l0QKpF4W2r0
         bIQe5SvvpEP2dBxQzb1s/NlLLZ3Tpfe0WZi7YxSzIZ+9QFngdw616BopzSIICdH569jY
         R1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wgtFkL/FFRFrlD7W9UDHQPj6n9N+/Wo8Jj+YzpO0YxI=;
        b=nJMPggSvi0zSt6OnawDhz/lHPQmKX7TNxnGVZQiv7piWf32r39Kf0bIqMpfHyMudrm
         XEb4mKqvnGgnNJiLoLdSfOfIgjdIso6yFN+4K8fISq5mUTxRIaujy8+rf/JmQ4yfJJ71
         G/WJ3zkThk96BmqkswP/LiLMb1RWZd1/beZVL8zskMVf+nCqqhS6g+KLDwyR9el80n7Y
         Irc6GshiVjBKodRYIGzZ1RiIHLmuRScY5odiw+b6vkhK2Hurs1vkXK/pMbyw+fmrgf9D
         XJHMsm8V71H+oFTrDx3ACUdj6SvCduvcX5BCc4RCRDn/zeDXtbTJekvuvivunpAOTJJT
         3ODw==
X-Gm-Message-State: APjAAAXArkiZcw6I3xmRgsEm4UGaL4Td+43eCOjEouH7CZdrqfkWwwNT
        SvF2TDcICxRAZNQUkBrSH0xd1L8K9Fo=
X-Google-Smtp-Source: APXvYqy7J6/8YHbG5klC9QquF261ah07vKhRA9+K09kh9B/5jxv89MEbsHK/KpR4cl3xiNk3tmrOEQ==
X-Received: by 2002:a17:90a:30e8:: with SMTP id h95mr12035505pjb.44.1570124639543;
        Thu, 03 Oct 2019 10:43:59 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:a084:116f:9da0:2d6c])
        by smtp.gmail.com with ESMTPSA id j22sm5289821pgg.16.2019.10.03.10.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Oct 2019 10:43:58 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 RESEND-next 0/3] Odroid c2 missing regulator linking
In-Reply-To: <20191001073901.372-1-linux.amoon@gmail.com>
References: <20191001073901.372-1-linux.amoon@gmail.com>
Date:   Thu, 03 Oct 2019 10:43:58 -0700
Message-ID: <7hv9t5vi5d.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anand Moon <linux.amoon@gmail.com> writes:

> Looks like this changes got lost so resend these changes again.

Yeah, sorry about that.  Your cover letter subjects were quite similar,
and several versions of this series and the previoius series arrived
close together, so some stuff fell through the cracks.  Sorry about
that.

Queued for v5.5 now,

Thanks,

Kevin
