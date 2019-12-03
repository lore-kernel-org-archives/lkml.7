Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45282C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055E920409
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jrBUX3W/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfLCSrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 13:47:45 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35229 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfLCSro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 13:47:44 -0500
Received: by mail-ot1-f67.google.com with SMTP id o9so3906847ote.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 10:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfO60WpFdVXD9ykCy83yYLYqu37ZRkpOI6iazA+g73k=;
        b=jrBUX3W/cj7i2lJk0w7h8DromxINw5Nmmr4l6t63OkmNeRwhn/r4qAb45sdstr2z26
         22Xt9iOLQcEzh0BzacyYi/P/Wps71zJ04bWGjsx6zNcvIBDhZ/fdnaZgDVSeH1oJkCyR
         ad2vhAUE/sJZYQjynBObtGlsFBmX2GAUgjKgixSfKWlJB6/3obaG9loYEGkHYl34c7RO
         UELCZelTjZVnA4oGPvddVTJAYrovnfb6R16Y4SnZzYhsHNM2Gp7iXz/k72ElCNPeRzrb
         tuWukCYh8Tgjv1jZpYFq6WxVg/TTZ2Ov34yIlI/rgl3hdD4xXJPUTJF4U8gdFeLJqF/K
         Tkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfO60WpFdVXD9ykCy83yYLYqu37ZRkpOI6iazA+g73k=;
        b=JfX+RSxkrMVp3eCmZF5AQB++Tv8DeYlUocv7SwhmsOav9E7ATRtgqH9ojt36/wPMgN
         9+IclHGwTLmnCi4GPSbyiR6p7stw97RPkVilN1zwpqt0W4hx2l3opOxpdl74FFuA+Zus
         Pw+UVihjV0LFQmiRmjM9m/9Hqfly31uin/oosle0lOMdMvppdpjOztaVppYNORcKp96k
         wm6OpUKZHmO6WmRyCeWsISlwaQleR6QXE9fIa9Igy+wP4d+pxb8LQCwvPr7LWLfILnFI
         aOK3gnYUEQcYjVpoQlZnCP4h9Skxd7UWLQtk4ZLDoOLtYxW33ttkFG2pqTlqw1WyoXTi
         +E2w==
X-Gm-Message-State: APjAAAVZ9bPwqbhc98g//S2+btTzpWExD3Vyw//l73VdxBJVox2zSZR5
        sjRQgsO3/e/OsxJpLPGxYuio4+txTgrDpvys+1qbyA==
X-Google-Smtp-Source: APXvYqwmBgkNOXdWKfFhoRJ5fYuF8t0A71o7eGmZ1W9UCAO3LKG+omVrqIoWLKPd/hqTtznUqwTF6fmD/YdQIIy+Hhg=
X-Received: by 2002:a9d:3af:: with SMTP id f44mr4143411otf.332.1575398863576;
 Tue, 03 Dec 2019 10:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20191203121013.9280-1-will@kernel.org>
In-Reply-To: <20191203121013.9280-1-will@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 3 Dec 2019 10:47:32 -0800
Message-ID: <CALAqxLWbswQmLYJa_ODUDC0XJ5u=y_Nn074qcVAh1HZiTLNy1Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: Fix initialisation of DMA zones on non-NUMA systems
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 4:10 AM Will Deacon <will@kernel.org> wrote:
>
> John reports that the recently merged commit 1a8e1cef7603 ("arm64: use
> both ZONE_DMA and ZONE_DMA32") breaks the boot on his DB845C board:

I've also tripped on the same issue with the original HiKey board, and
can validate that this patch resolves the issue there.

Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
