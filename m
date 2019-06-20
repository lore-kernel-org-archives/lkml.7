Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D59C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1052083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ewPUy5FG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfFTTxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 15:53:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37585 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfFTTxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 15:53:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id 145so2120809pgh.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 12:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZglmqh0J7zb7ea7Ifbgw3a2GaX0kfafkFIrEiNlS4k=;
        b=ewPUy5FGan2SrNM+CLnVhnwr5Jn1zQllcqc3c+c2RzQRCv+bNiqhsDHrEx8yju9IWx
         /nbE3RNG6SlVD/f0IXZPrn24sESNwWbpGI1aXATjusUZPrGRM2Qz/7Pq1yaIZWeqIBsl
         dka43/YuN0qh1hcxrbc5oeodyFVEKblII+8sZWmyZWmiT41A7LF+5ACCVxmQOtFqhHsc
         BBc84JENMRffE7CTa2VT2n0vTYs/MZk8Y4D+0Qem45+VCV14yh2AlfGNSJHeJPs4yXqc
         ASBzAwVfyZvmqxYBhsenfsgDQwC5bMIUvX58BPaIeFcKNNVBfPx9tWxE/OYGbLFUcwGI
         Zh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZglmqh0J7zb7ea7Ifbgw3a2GaX0kfafkFIrEiNlS4k=;
        b=CttNmTYHpaRhnSThBtXaqZek3llWhFCfSE7TOjkvck8YQJd+FHjTr/FlMtU+zvL1fC
         FlajvJG53BRTPsCHsKO9YorOgNeDYdWp+LELU0UC743rwAFvPMsHP+7CzJpCEEpJEC6p
         i/nFwJiSNrqeHBfNfCN+3L2bL6aVbZ1+0T/wre8v3P1RadxAc3lVrMozW3VfYcbrUrmF
         KFNmxxyZBWqRu2ufHxFHAoxTammwbsasbudWrCrydnNFjDlmIdgl49vdedcEnxnXujIo
         w6OGOPsrByjOTwt0fgai5OP9b7c4DjUSN4hZ5Bt3LD47MWh/oilRJYxEb7QkRP4VAdrW
         GVXg==
X-Gm-Message-State: APjAAAXH1WowqeFN/dGwsorTJlLtJ0ojVRMG3NuSYEq1WChomREJRgGH
        g/0HWenYX+FCPgPX9tWgooJL0ahpOZvquXFt0XWdHQ==
X-Google-Smtp-Source: APXvYqxoCBI/CJsRcwpyZke12I4lZckdbn8VYMM8Gayco62e8sw7fmwsrNgqVTaScgYfIHxG9CcwTvZDvaxfbukpUQU=
X-Received: by 2002:a63:52:: with SMTP id 79mr14218912pga.381.1561060413167;
 Thu, 20 Jun 2019 12:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190620184523.155756-1-mka@chromium.org>
In-Reply-To: <20190620184523.155756-1-mka@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 20 Jun 2019 12:53:22 -0700
Message-ID: <CAKwvOdn-o9UszRW+MQ9Z0Ds9B2wSVBWUsPBPSF0S2DYxVFYpqA@mail.gmail.com>
Subject: Re: [PATCH] gen_compile_command: Add support for separate
 KBUILD_OUTPUT directory
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Tom Roeder <tmroeder@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Yu Liu <yudiliu@google.com>,
        Doug Anderson <dianders@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 11:45 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> gen_compile_command.py currently assumes that the .cmd files and the
> source code live in the same directory, which is not the case when
> a separate KBUILD_OUTPUT directory is used.

Great point; android builds the kernel outside of the source dir
(`make O=/non-source/path ...`). Thanks for the patch! BTW if CrOS is
doing cool stuff with compile_commands.json; I'd like to know!
Particularly; I'm curious if it's possible to generate Ninja build
files from compile_commands.json; I do miss Doug's Kbuild caching
patches' speedup.
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
