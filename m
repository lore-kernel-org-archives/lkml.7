Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4440FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147E020651
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NFuT0AL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfG3OHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:07:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33807 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbfG3OHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:07:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id n5so66478032otk.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 07:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FSKaKWFWYYOSjkODyshCHU2usgMmzqA1Mgn9YuEoYxw=;
        b=NFuT0AL92rmq6nREyp2Avi5PAix+503qw2gjZvCs7/NGR6AcADaEXihWHG0gpaWt6r
         KYH5vRp2EQkcfzJUr1Xb1Hu0GL7AtZTlpxigp8wO+p2q/+KLOvXu0BPnxPWxkHFCmZht
         MFFxkSsC2lD9hfrF7bcEyclun4BZ7yZ+Z0RNyYKi2I8BA+E6b2HAh5tE7c58mHebH+/a
         MQT8sNxSlfVL0rOmt2xUlzb7y+2gOUOfx/+Ew3zDNmmgPMostPXkrht1vKXNDwI4e58H
         ixtTi8+KRPby2hDkmTfJO4hULYk9Ud6PcLo8MkuyuADqQRlZIFkxuLcTmWTMAwlEwwJm
         VaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FSKaKWFWYYOSjkODyshCHU2usgMmzqA1Mgn9YuEoYxw=;
        b=c5/UbN+QHODqTABZSZ53V75hI5ohhTk3PAWRGDoCMCdT+RoNghBhKGWqAU2lqXaN7P
         i5igNKvOlqexERnhUborbwCrME5xmUSvtlHQAUfJKOl6r0ow8reFKisCN9L8NugmLyeY
         gpTbvbXiLNox1RqUNPeFPgmjdkOA1q/ygIT2zU9gAQYO0ooNE41wJGrqCNhV6qAwK9By
         865o3y8WKhJmBiVoutxm4oKjHWwis0mgU/jYiNcM7vLxL24Q1xiLoNht+SiJ7oqmnlg+
         2OAvVnFO5ZV1eNeagF2E9Cg1hXapM6hN8VpXCLDeZgAZ7socYWSn8eAGGn9HAm/2tiBH
         thZQ==
X-Gm-Message-State: APjAAAWqJCmmfYBzergkiy39xglSnry6iyefNXuI0bZbzfXFOUt23qP0
        2SDFvdMS/D1Tp/dQG4Zfd+yKb1LsK0wq/RNKyQ0nJg==
X-Google-Smtp-Source: APXvYqyXIeUesTSJse/daTN45051YruafbavRxRDoWLl6h6sBrHIV5q78YvsRg7b7Qq8J212sVTnN+gCcEjtrpDX8aU=
X-Received: by 2002:a9d:4f02:: with SMTP id d2mr6107256otl.328.1564495666698;
 Tue, 30 Jul 2019 07:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190730134704.44515-1-tzungbi@google.com>
In-Reply-To: <20190730134704.44515-1-tzungbi@google.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Tue, 30 Jul 2019 22:07:35 +0800
Message-ID: <CA+Px+wXetT1mQZW+3zc2vNDP4Jf3zKqGNz=Hq0yHn0Fvf=y-FQ@mail.gmail.com>
Subject: Re: [PATCH v4] platform/chrome: cros_ec_trace: update generating script
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, rrangel@chromium.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Dylan Reid <dgreid@google.com>,
        Tzung-Bi Shih <tzungbi@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

I found it is error-prone to replace the EC_CMDS after updated.
Perhaps, we should introduce an intermediate file "cros_ec_trace.inc".
The generating script replaces whole ".inc" file every time and the
cros_ec_trace.c includes the "cros_ec_trace.inc".

If this proposal makes sense to you, I can send the patch after this
change landed for*-next.
