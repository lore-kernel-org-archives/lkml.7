Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5A5C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A90F205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576170593;
	bh=66+JdRK3MHSvSFGBy74pY66a28t1UPHfvPBHNumTkEw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZW3iui1BJiTaJPKwBi/8rdXrwdIBUaReFnnCt5Or0fwpQcdXFDN3SHE3+KB+yxFQb
	 OdSDIuKyoEaoSRf6wK/Gi46i7goU46yLxacrLH6ahC6ORsMR+IHI7BDjeXcNnNcWeE
	 0E0ldJfW2Rmswwwxi8GiFLXdFDbCZC4lWWog59VQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfLLRJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:09:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41849 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbfLLRJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:09:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so3115123ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcBK2OXBUdCz5AXrgTLD+qna9CmZkEmzcIDc1qfE9ns=;
        b=O5eviaFh4+3bEsZKbmmNcaSSZ7g4oowOSXJET8bW1/aq/wTG3y5ZUARw84j0sfi2qn
         9GQ1P7LwixSAiPal3ouF9HF9OJ/nu908lnrHCP93/vFahvnnkIU04D6Hbcmj+wuvSTvN
         47I1bwhdj4OPhqRte7eBZ5c4h5NrYB7eS4f30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcBK2OXBUdCz5AXrgTLD+qna9CmZkEmzcIDc1qfE9ns=;
        b=TPU5HZIasRFGwS4CpDPm72sU1wOO6QUEbHWF2c6bCxzMHqWGYDZVvyV73Gwcv/7t9z
         a0PvM3Pnv5nTkY022DuQS+3ocKkv+kMlV1u8PS4D2KFzggIbRAVO+lntfpSgB0gGRULf
         VzSXrAjmbF21P+UBQI5gAHeCKlvaa5ALy3fumBCNy4FGAaC9pcXzR/4wO2EwlmQOVhqd
         4APaCQ4EorBoLFHW1agw03t290u9CbhcS4rztoMxU5AU6RTHJj6K5vQrk5nHZ8ZoN2e1
         IjGqdT//0k/ZRROLxRlnbTFJ0W0BSfL3szbSuc51K0H36Y3wXwZbpuiBFxw8qI1i7sQi
         qr4g==
X-Gm-Message-State: APjAAAU787T3dSjjUcHU2esoqgu7Wtn1rg1C9aedog/JLAXG4TgcRNXx
        5v4mFFiMgMYL30CW61PzQZVDxTtrIBw=
X-Google-Smtp-Source: APXvYqwGRW8bszjr7PWKdmhQ77cfX/cG7jIcE2OwuK/WwJOSkGo+V+FkEKwLptrKkc3GdOEw/TFtJA==
X-Received: by 2002:a2e:9687:: with SMTP id q7mr6716662lji.80.1576170589631;
        Thu, 12 Dec 2019 09:09:49 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id x23sm3233383lff.24.2019.12.12.09.09.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 09:09:48 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id 15so2278004lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:09:48 -0800 (PST)
X-Received: by 2002:ac2:50cc:: with SMTP id h12mr6251627lfm.29.1576170588425;
 Thu, 12 Dec 2019 09:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20191212140752.347520-1-linux@dominikbrodowski.net> <20191212140752.347520-3-linux@dominikbrodowski.net>
In-Reply-To: <20191212140752.347520-3-linux@dominikbrodowski.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Dec 2019 09:09:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjFZQRdzVqAzrYTw2C1BnoSoO8J5Jw0QTRa-UzLd1HYBA@mail.gmail.com>
Message-ID: <CAHk-=wjFZQRdzVqAzrYTw2C1BnoSoO8J5Jw0QTRa-UzLd1HYBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs: remove ksys_dup()
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 6:08 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> -       if (ksys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
> +       file = filp_open((const char *) "/dev/console", O_RDWR, 0);

You need to remove the now pointless cast too.

                        Linus
