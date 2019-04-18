Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC600C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D27120869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Fsk23du8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390207AbfDRUWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:22:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42288 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbfDRUWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 16:22:00 -0400
Received: by mail-ot1-f68.google.com with SMTP id 103so2755915otd.9;
        Thu, 18 Apr 2019 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8NyXCn2hweEBBeqsdkxBSMnUdzojOgVlmIn8B5GHpV8=;
        b=Fsk23du8LGXuKxKuzpzfs/RhzEjsl1exJ3f5UvMYYdCy7axHPpswfW9BpYhyw6qkyO
         APgaDq9pxy4PYdGujlG/y5SWczAXvQkmHK+e9sHPJy5ieXrxI9BS+L6+dFGlAytqH+wj
         ngwhr7eRBq3cV+jMCQyOX3MbXXFryEoNSCMVwZUM7Ra5J0G9Ll96OGzte4VxaYtmvTdp
         cZ2VbG064yPCVimAsbWlCNtq/irn+9sLyzCKfHrpcFvzHenGLMOm3EvdswjRarY9aGJw
         vaDDVmi2dxBMkgiazuZjA1BvSN+3ygLScoA6IDdUWMxk7UHcpFzaGZ1WDysApcSH5rrP
         4iIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NyXCn2hweEBBeqsdkxBSMnUdzojOgVlmIn8B5GHpV8=;
        b=jr0rQ44D1y+5+m0TVwA7TFXG8uXrHU3tGAn0i3a7xw9hH8qsiTIIMsklpGkOLxx4Zx
         TTomDE4iTlqdIMWWzUjIROfxIyf7trbGtqSSgfkJHSkzgRV3lsHmhgNOfTJfS4hjX4ut
         FZXiIiv0jpwM7wqYIPNIjZrZOY/aZHjTpeCibCOctBr9cSUpETAseUYqihDEZtR09+al
         izLIWP2CgzlyZGVEpTi1RAzFxCyvJkw7dNr2UX7p3LR/N5n/w+neHJ/EEN9VyHmZO3ot
         MP+WIT3U2lq5IR8LCVBKJ+UnlnSovGJfdAuHJ8mppUWw5eYHZBGCWsfrhc1+2bJs6UPo
         RlqQ==
X-Gm-Message-State: APjAAAUHvd6W8SiCYXeP1BrSqy3zer5RUd/88awRgbgfyGU65zzhCEwQ
        lkMGYDrS1T5qO8uACwDMl4KzDGc8CmdIsf/2b0o=
X-Google-Smtp-Source: APXvYqyKXUWtb+XugPJCvDxfsYTlD809nWanYE5hfHIaOLrgXOwoyWMBhv5sIJoqF4p4B8LE0GtKKtKDefYgl3VqXlg=
X-Received: by 2002:a9d:5e90:: with SMTP id f16mr56754297otl.86.1555618919925;
 Thu, 18 Apr 2019 13:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190418122714.30805-1-jbrunet@baylibre.com> <20190418122714.30805-2-jbrunet@baylibre.com>
In-Reply-To: <20190418122714.30805-2-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 18 Apr 2019 22:21:49 +0200
Message-ID: <CAFBinCBU4hPYTXUBJwiN+mJeqrC_a8aw6kNnUBYaAkBbrC+Uiw@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm64: dts: meson: libretech-cc: set eMMC as removable
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 2:27 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> The eMMC on this board is add-on module which is not mandatory. Removing
> 'non-removable' property should prevent some errors when booting a board
> w/o an eMMC module present.
>
> Fixes: 72fb2c852188 ("ARM64: dts: meson-gxl-s905x-libretech-cc: fixup board definition")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
