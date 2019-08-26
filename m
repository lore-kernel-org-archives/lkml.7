Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E21C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651F02070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bfmZE7Uf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbfHZSwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 14:52:11 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:40427 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfHZSwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 14:52:11 -0400
Received: by mail-pl1-f202.google.com with SMTP id k7so1097154plt.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 11:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f13wn2v3HTWLW79B2qFqNfxBA9vXXjNlnyblgswdq/E=;
        b=bfmZE7Uf1xNK78UufCnnG87LZS9m7cHd1LRQUTgSX4t1YttJJSQNzi3p93vCxe06t6
         l00juMEHKARjQyGo2vyvuxvJHkds8eC5FP5YGXqW+64X4/T/kfzRqfH+u77bxE0WVg0Y
         MozDokfGxp/B7yoUO6goIxvixoWQYk6g/nYYbuEeu82L+uJnPGRT+0i28/YCQAQyXuzW
         CNSZMPeDkigzmEfwJfNqaMAbCATcFEDvzQnonAmyAstW1Jo09TS7feX8QuZ0rwtPxAWz
         Ex6y5/XLNKFp2sCQWqiT0Ain+OGSZccgXThs0vaj7qMLKj0vN9EU+Ij2d5H7GLbHGPT3
         sHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f13wn2v3HTWLW79B2qFqNfxBA9vXXjNlnyblgswdq/E=;
        b=GQ0+xiSDvVPnybM8u/cvj/Km7+24g7UsEqpf8aEP56wPrTtirxH9sKq4fwOB7iFI/4
         OKCs+FZkpJUpAtkkNW7ytHJtqklPRREhj7SF9x6q2Tp7qM4SpInHVAZ74G2SxemyBuOV
         4uE7Sb3IBr/aQoFJiF+2ulo5sLi/75/smIbG3aTtonLhWoVtd4G2yGY9Wu9lKyrgMEmm
         9qOQ3iY96W2TOkDY5ZVIgj9cA5Aghei1rshpQzH0zxA2E0JgROdkhe0s4WDloLqnQVyx
         5Zx7zbI7t1dIVLodzN1L1SrDjcJHYZfeLJv+gKA9K/wCqHdwqH/9Ehq5sewVgvWrL2N3
         SN6A==
X-Gm-Message-State: APjAAAXwynvEqRafWp9paRFc53FOhM4dXB4CUJ39a5lGSmpMUdUr/SIB
        0pfn+SN/Td5ynimJFSsesr6HU+alpQ==
X-Google-Smtp-Source: APXvYqxofBxaAILlefFytt3O0sJSZvx4y5z2QEpvVJn6P3QTOD4bxfISMK9z35l56sFzEoUKmV+9pyuRX0U=
X-Received: by 2002:a63:e213:: with SMTP id q19mr17542135pgh.180.1566845529981;
 Mon, 26 Aug 2019 11:52:09 -0700 (PDT)
Date:   Mon, 26 Aug 2019 11:52:06 -0700
In-Reply-To: <CANLsYkxC-4UZcVKoTQiJ2PsDxwuriFoAwqdbM39EC1G3nwwAHg@mail.gmail.com>
Message-Id: <20190826185206.105863-1-yabinc@google.com>
Mime-Version: 1.0
References: <CANLsYkxC-4UZcVKoTQiJ2PsDxwuriFoAwqdbM39EC1G3nwwAHg@mail.gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: Re: [PATCH 0/2] coresight: Add barrier packet when moving offset forward
From:   Yabin Cui <yabinc@google.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>, leo.yan@linaro.org
Cc:     mike.leach@arm.com, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Can I add your Tested-by ?

Yes. I just sent a tested-by reply, but not sure if it works. I am not very familar
with linux kernel review system.
