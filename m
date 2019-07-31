Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3058CC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0112420449
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iYMkFxzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfGaORK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:17:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36384 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfGaORH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:17:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so32082005pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 07:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=XVFrKalXLRegBW45+spzUS0bWpMUOiP79SdvvKgnepk=;
        b=iYMkFxzSu8BzSe7iyLl3BplH8dqGn8BPphddF/VAx+cUW9kZA2uSxyTTctnwXO6Qgu
         xfqowa6cQFgp6OAzQNJAhr1aePeF+3u9xeQc+LQmNZndWZHTcwH4LHAwWumTYwVPv8hA
         LmTAADFLPQw6F8CfcaiVIKfF14a7h2kpyYfd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=XVFrKalXLRegBW45+spzUS0bWpMUOiP79SdvvKgnepk=;
        b=W2Nf9tX/eu6lTptVxd2tH1ZO2t56CJXjXYm590ZNOkyhu6vcrRTS2DWtR6aNhXthZI
         U4mkA9B9svTSRV0SwfBSiybPfD2I74EMmHnfCaWp8Fmwlz4nd3tMjXmUcKrsR2rVXay9
         jTIvjij6m/q1muMVkvlhJMuASO721PTIJTS4Ht6v6VRja4g3zO0ZLlVezOqv2VkQpgFM
         TVygxXwPjcItaVCD1LjxEoLJpTj92ADpjOncaVK+yBAA3BUy/TNGneBqRNZ3yx0catny
         sotXYDEIyegs2p1z7JZ4xNEavgOBN38DqOgVSSf6LUIExulJ31hOiSsT4jhOxKvUgIoC
         pq6Q==
X-Gm-Message-State: APjAAAUNwX3XMz8F4GwexWLPgvgCaQc8Dgqku54qfjr2/IAI3rsJFIEm
        0gIhG3rk8gnxgAqgEtOxCdx5fQ==
X-Google-Smtp-Source: APXvYqw2wiw/+RDnWb839aBeqYUakyy+ryIDb5GNRAP4xZ5xaqeatW6EHGUQXPb2eUVOlEHXP6EDaw==
X-Received: by 2002:a63:c23:: with SMTP id b35mr80255223pgl.265.1564582626723;
        Wed, 31 Jul 2019 07:17:06 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q63sm89283386pfb.81.2019.07.31.07.17.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 07:17:06 -0700 (PDT)
Message-ID: <5d41a2e2.1c69fb81.192ec.ecd4@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190730234052.148744-1-dianders@chromium.org>
References: <20190730234052.148744-1-dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Subject: Re: [PATCH] scripts/gdb: Handle split debug
User-Agent: alot/0.8.1
Date:   Wed, 31 Jul 2019 07:17:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2019-07-30 16:40:52)
> Some systems (like Chrome OS) may use "split debug" for kernel
> modules.  That means that the debug symbols are in a different file
> than the main elf file.  Let's handle that by also searching for debug
> symbols that end in ".ko.debug".
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

