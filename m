Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F43C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F43020838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d2WwBkw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbfHANER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:04:17 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45972 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfHANEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:04:16 -0400
Received: by mail-oi1-f194.google.com with SMTP id m206so53861766oib.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 06:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lkb04Lb2hyfMmhLQJcqnn0KrBVCDnSac8GUeAgpzLd4=;
        b=d2WwBkw92PyxgT9fg1I91hEa5tAsL/PTIZZPPsdeBwYJF0JDeWKjCh1wsZY6ThSYuA
         yEzWruSIi40gOKTcWIqY5TaFnIx13XsSA7XtXo/7/CWdspYydZSz816drOKTQQI7jejl
         /kLCvfF5VtkQXDHSWMtXyC336Hc4LclJPkQjfjwwCRUjCWhR8VCqpUU58PM60BGaem9E
         y1V7lxfmB60CWj/0RtWWBnDMYIt+iBiY9iWVl4UUjgztrnhFEBz/i+MOUaPCCX9fIFo3
         5s6DkyWd6CHgTnNV83Rq2UC5iDotkf0asK7NmIBbRlmXtFb/Yk+oanSLIh9iXV+P+L11
         067g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lkb04Lb2hyfMmhLQJcqnn0KrBVCDnSac8GUeAgpzLd4=;
        b=QeT7SjIgAVyJO8vGwOdMWRvLWa7xcLbCH8KH3sHjYxyrIebxZhKjsHFzWOKd8k3iCb
         jAfdpBgZi5SlQgMbpk52+pDkBAwEAmlaXDbWUMvYAGcXLPSN0UWF0InDdTSnVJv3499+
         +Javu7+rGKAkpM/V6UztbcHqAiP92t5UL7ZBYNZYZa8qLHjyfXt+5TU+Cym7bRbVpqRL
         5nQ5oimuHMxYOTW3W3Lj+lW1IrBDxhMKMSFvn2QNCsXXLDSlGKRfyEMLf34JCXWxz5pW
         FsALBlWHR2S2DAMUqeoR21Pe7RqCCp+Fl5/yVsf/GR766TyPKnFaaZNVtF0aFpcQqxwX
         tMWw==
X-Gm-Message-State: APjAAAVCI7M/fEZtrCk1jmdRxBUptVFyLqKdxA1V67LQuNdg6Fd3lgSJ
        o0BJBaVutrnH3qEmGr/fbHLYIVwxyaEfqnwy9khWsw==
X-Google-Smtp-Source: APXvYqxOTd21zph/tilvtULyDs7dU2EBUn9KjGqDlf5CjyutDwWiNsAsh5pHMXpgD2IndtSx/mckH6LFg7ML8tLvrRc=
X-Received: by 2002:aca:3787:: with SMTP id e129mr66041950oia.145.1564664655442;
 Thu, 01 Aug 2019 06:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190730134704.44515-1-tzungbi@google.com> <CA+Px+wXetT1mQZW+3zc2vNDP4Jf3zKqGNz=Hq0yHn0Fvf=y-FQ@mail.gmail.com>
 <106711f8-117a-d0df-9b66-dc6be6431d07@collabora.com>
In-Reply-To: <106711f8-117a-d0df-9b66-dc6be6431d07@collabora.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Thu, 1 Aug 2019 21:04:04 +0800
Message-ID: <CA+Px+wU=V0cGZeAxoqSJeVTLcO+v9=tPQKxKBTp-npsgqXo3yQ@mail.gmail.com>
Subject: Re: [PATCH v4] platform/chrome: cros_ec_trace: update generating script
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     bleung@chromium.org, groeck@chromium.org, rrangel@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Dylan Reid <dgreid@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 6:59 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Tzung-Bi
>
> On 30/7/19 16:07, Tzung-Bi Shih wrote:
> > Hi Enric,
> >
> > I found it is error-prone to replace the EC_CMDS after updated.
> > Perhaps, we should introduce an intermediate file "cros_ec_trace.inc".
>
> I am not sure I get you here, a .inc? could you explain a bit more?
>
Manually generate .inc for all EC host commands:
sed ... include/linux/mfd/cros_ec_commands.h | awk ...
>drivers/platform/chrome/cros_ec_trace.inc

In cros_ec_trace.c:
#include "cros_ec_trace.inc"

cros_ec_trace.inc:
#ifndef EC_CMDS
#define EC_CMDS \
    ...
#endif

Override the whole file instead of replacing part of file to prevent
cut-and-paste error.
