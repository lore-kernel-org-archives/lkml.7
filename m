Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07B2C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C397E2067B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dgmHFsLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfIQQdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:33:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36351 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfIQQdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:33:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so4239050ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQDRRInEfkOmolUWUlkWs8+kiucdxwd5FC1fGShr5c4=;
        b=dgmHFsLVgUDYlzKnx2AI9EBhRyfdronIQPVc9nmshBfpBav41pgLiKHS47u1qbTMRV
         /OwRABb4gyj/8eMrwgTXTZKo1ZEr3OZ650q9RGo2V85QlQDznn7pVQpcjv7vyWQko1kV
         m46DsLgVSgceBujZfIRs97mCBeZ7wHovtGGcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQDRRInEfkOmolUWUlkWs8+kiucdxwd5FC1fGShr5c4=;
        b=pEszR0euksRdrX2AzxkVIyBjOgl44cmWy0hv7pUxBVGOUjWnA04x9ncbtOgcMkSVok
         hxJu5+YRZkV6WfZjOR1/HEKugfHJ4IicR94kWvHwwOOykk+mQklPFLkNk09+Rwhkav3F
         P4EO41BrvNnL63iqVV9mUKmssHvWw6MaLYm9L4ZRbxV9cGZumoEIMH709JVDB9dCERA+
         7rXLS0H7WX7Mm9Cz5NSf7zuXNEn2Q3YeU+bf0pOVbah2krbCtjWg3gXLsOBLPfer64A1
         qIc7BqAHanDwkLrlHlQcYZwEg9O0Tq6UXdRO/ItNixRfCWJ5FynOOenzolvykv3URqqv
         JkNA==
X-Gm-Message-State: APjAAAXGi48bSijBIxGJfKbGUUWvvE1pD1ggUT8DDCsfA1YVlhtcz/z3
        WdxQOjqKTYc9BZbG0yoGnphIY2L6/4A=
X-Google-Smtp-Source: APXvYqwsLVTEUTVJADorN7WH2RNDTzJaYlm5HyeJ8F3Mn52TKzfj3MBv4EXE8L9x3hjfYyYhhow0XQ==
X-Received: by 2002:a2e:95cf:: with SMTP id y15mr2402988ljh.27.1568737985658;
        Tue, 17 Sep 2019 09:33:05 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id w30sm511488lfn.82.2019.09.17.09.33.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 09:33:05 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id e17so4153618ljf.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 09:33:04 -0700 (PDT)
X-Received: by 2002:a2e:8592:: with SMTP id b18mr2284561lji.18.1568737984442;
 Tue, 17 Sep 2019 09:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <1534402113-14337-1-git-send-email-wgong@codeaurora.org> <20181114225910.GA220599@google.com>
In-Reply-To: <20181114225910.GA220599@google.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 17 Sep 2019 09:32:52 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMh7vdfkA5jtJqWEU-g-4Ta5Xvy046zujyASZcESCGhAQ@mail.gmail.com>
Message-ID: <CA+ASDXMh7vdfkA5jtJqWEU-g-4Ta5Xvy046zujyASZcESCGhAQ@mail.gmail.com>
Subject: Re: [PATCH v3] ath10k: support NET_DETECT WoWLAN feature
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Wen has once again suggested I use this patch in other forums,
I'll ping here to note:

On Wed, Nov 14, 2018 at 2:59 PM Brian Norris <briannorris@chromium.org> wrote:
> You've introduced a regression in 4.20-rc1:

This regression still survives in the latest tree. Is it fair to just
submit a revert?

Brian
