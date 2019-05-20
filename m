Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFF5C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076BB20863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FFBMXcML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfETR40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:56:26 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38131 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfETR4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:56:21 -0400
Received: by mail-oi1-f193.google.com with SMTP id u199so10672857oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rnU52g/boLPrvaC7Lk7YTaYbB64jJRa17WqE6kdu0io=;
        b=FFBMXcMLzNQ1W7XGvBM9mrCG3uVVPv93UM2jJ2cU+Gw8mB8DsEWLGIZ5crVU/MgG3q
         NBtAiyHJzyZYwwN3LuPEgk9mSfzk7vx+TK9tTUD08Jib3KeaPUiCSyHkhSQRdZ/1DLnN
         VojNvk9xjunne3HmOwSHC14iV9wXH7QkeFxPPI2KXYUpCrs2L54hgTReRWBG1+b5FGtZ
         d4G1mrXwamY9ASM9BbFsQx161dlXrNUEVTllEK26AWjR6a8r7cvgG/HttBzkUop6Wjbz
         JgKKmhFKLeHY2AJLlzf+SSS6fIEYuKRKtsIbLix6wDVcdbwrKTgOzOyeB/kKbouE5Lgx
         A+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnU52g/boLPrvaC7Lk7YTaYbB64jJRa17WqE6kdu0io=;
        b=YquCg50oDNaVDRQbPwX+UqfRP1tQ5tsQkGUBC+suYHLM9RNxoXKAsaFai4hbgb8AxA
         8IVko+L8GOOseVWqs21xmxlH233HPgErnz3i8k6NRF9poNvo3tUv/I+u2as3vbiEF5QL
         Mwv+doFJVQnKIcodB0JY6sAbBp0ejWT05xBdQwOudwdDecGkYczf0inkOsZYUNDn6PPm
         3vrLFci1hrdET5W8zpL2uPR3q0wjIZUYqV+ofFf94dZDyuHkyxThSI3E5fEhA8Df014m
         I3JBIxZTlJwY5rEIkpvA/2RJcvqDyI2itk96YE5tXJZJwjSvXLzYjUA6QM3320qX1U/V
         EJTw==
X-Gm-Message-State: APjAAAVVI92uIa0jCQ9E+gAHJ0rPvNRfikmWxlQKv8FpRvY8RnAuZyIn
        MoFGKbEBmBwVqkn/4Q5dXpl80clscK4zT+HxcA8=
X-Google-Smtp-Source: APXvYqyYH9R8huiAm/sim5hyCyxvmrJ/DVQgqqT7xw5knwKVl9Xw27/gO6Y6yWwwoU8cGGh4QN3DWSKazlrf/z3G1ig=
X-Received: by 2002:aca:ed0a:: with SMTP id l10mr303830oih.39.1558374981038;
 Mon, 20 May 2019 10:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190520143551.2330-1-narmstrong@baylibre.com> <20190520143551.2330-3-narmstrong@baylibre.com>
In-Reply-To: <20190520143551.2330-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 19:56:10 +0200
Message-ID: <CAFBinCD2zLRMJqdq=1S-i_KogpXv01eUd9gNR6RsSOggUBN_0A@mail.gmail.com>
Subject: Re: [PATCH 2/2] phy: amlogic: phy-meson8b-usb2: update with SPDX
 Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 4:36 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
