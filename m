Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FEBC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC05E2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565871740;
	bh=fNj1YCczBv1MQeZBa3RGTiPm9rVd91SUuKH32NTZyHw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G26kEIEy30rmFP7h0UtTqsQqsYAKbHdPkgVaYzWpfJvtBDV8tsARzi7jJghX1rjiz
	 X37fW+Mp8cldNynq6NUf5VKuMVd0zLP19+2ghcdng0HVPZLTVvxn++l3jr4o8d0Dd7
	 4T9ejInErlwFXcx6CER0ljmYoADdk2dzkTKbeN84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbfHOMWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 08:22:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730490AbfHOMWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:22:19 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BBB7208C2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 12:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565871738;
        bh=fNj1YCczBv1MQeZBa3RGTiPm9rVd91SUuKH32NTZyHw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gyb44c7lrHsEimFznCppDSYvNcEvmp0o76lOGa8B6jWWtl5IyOUBbITRcHY9Gsmt7
         KW39vFOeskO7y2jQ0Cn9KiJnjAN8cCPcREmy+/HLuZDwGt8A7PuSsFHCTDDkp8l9eu
         hNOStskumfOFHiN/UefRK+BTkUTViSW9EU53ncH4=
Received: by mail-qk1-f178.google.com with SMTP id r21so1683470qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 05:22:18 -0700 (PDT)
X-Gm-Message-State: APjAAAXkzSBaF8mULnhI/I6yHm9CGbG31d0zvxYnHyv8eCOjiOiTmJkJ
        fze4lhvwcQnFshE150EPcFMXouI7SeJ350MLRtE=
X-Google-Smtp-Source: APXvYqx+ZTsWD5+7FN1Kt49TeG7yB3dmND1aFh26ISuMcKGMZFcOn47k+HdrA45W2ocvBzTsaLLdjgrZI5r47y1RlIM=
X-Received: by 2002:ae9:f404:: with SMTP id y4mr3735253qkl.112.1565871737783;
 Thu, 15 Aug 2019 05:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190731161744.3612-1-tiwai@suse.de>
In-Reply-To: <20190731161744.3612-1-tiwai@suse.de>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Thu, 15 Aug 2019 08:22:06 -0400
X-Gmail-Original-Message-ID: <CA+5PVA51LCABdPp=J3_8wx=c_zaTjsg6pUXYofCixO_TkpJOeQ@mail.gmail.com>
Message-ID: <CA+5PVA51LCABdPp=J3_8wx=c_zaTjsg6pUXYofCixO_TkpJOeQ@mail.gmail.com>
Subject: Re: [PATCH linux-firmware] Install only listed firmware files
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 12:17 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> The current make-install procedure leaves lots of garbage files that
> aren't really firmware files in /lib/firmware.
>
> Instead of copy-all-and-prune approach, copy only the listed files and
> links in WHENCE by make-install for assuring only the proper firmware
> files.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Thanks!  Applied and pushed out.

josh
