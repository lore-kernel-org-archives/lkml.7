Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D4FC47404
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 00:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B5A222C8
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 00:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570321106;
	bh=jicYEzNGTUAwIo8QVXeU4x/JzMvL+QpqmFLNRdV6obQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=E5m/By5y2ON1Mvty6NHDcLP3jUABrYNaspnRLDeHYigL3+Vlovq9yG7gcfP6yh0Jw
	 wPzX2tJZlMATsMvGSzCzjdTsIIbRNuug5y+K1tS3ebE5N1dC786v05bu3dPa2FBtWT
	 yFHLpTuw8hOob5ovvbInAhRGptkqmqB+rgfW2KMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfJFASZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 20:18:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46145 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfJFASZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 20:18:25 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so6831651lfc.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 17:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UreOxprw0L5jzezKy4n2+46u4wVXQnYF5JGMttCrTko=;
        b=I6Y4dZ+y+T9nD9uRykuqzD0d1iczRw+MQh37NzJ4ydIIIx+m7Bi33rSKxn5ldajK36
         ejECvzZGoHtKwGfWvDVWyvk+59t+7v3Tgq4K708HHHo2rz3FoXCBAjvKW9HG1LiSmeT3
         cTUSzb5lN8pHanEtbu4p8H0sC2nx2/+pFC4Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UreOxprw0L5jzezKy4n2+46u4wVXQnYF5JGMttCrTko=;
        b=aQamuwdPNdmHnZrsLadgEdHssuCRRWMTmuwaDE4Rsknou0jkK0bptGw2KN7FCaY7Fq
         23Zr8UP2XzClfo40hWWHfg0MdpALd2NmtW5kvQWG1NjvwdXUuF54dgl8IZHUj3Y4H2WK
         2e1X0Clw0ZTR2mV9lK1pcV4CX2kTYarYpB6UQCRwNKRzpolxb4ma8z+uBJSRWQP3zoQR
         0vKYCgZhUr7lk8O9fykdqLsLPXlREabqAMDuOh/xkTKtMl0JZImdIOSO+1pUYhOGp/u8
         FzBrnjVLoEzOjkNSCpCgzYO3e9eh8qVRHxAnU8dlvaCuZfiqEVdwhF7QvcC+qTo1OBuI
         KZTg==
X-Gm-Message-State: APjAAAU340osCIzHWAUh+oSPVdB64JBNquQXJhjUTsEM3tyA/Wk/zG58
        Nno3w31Gm2OIdFy1m8f5fcpvisynvyU=
X-Google-Smtp-Source: APXvYqxKPr7FB63X1oWHoE+OBg59/MR6qurf7J06MfVWvUosQ4g9iXaJgr/TkZaYx1Q080GBRDV5IA==
X-Received: by 2002:a05:6512:419:: with SMTP id u25mr12327227lfk.165.1570321103057;
        Sat, 05 Oct 2019 17:18:23 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id g3sm2031592lja.61.2019.10.05.17.18.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2019 17:18:22 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id t8so6831630lfc.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 17:18:21 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr12672652lfh.29.1570321101557;
 Sat, 05 Oct 2019 17:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191005233227.GB25745@shell.armlinux.org.uk>
In-Reply-To: <20191005233227.GB25745@shell.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Oct 2019 17:18:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiy9MWteoaoV15FJ7QJeRhBtCVgo6ECiLb4khuc5PxHUg@mail.gmail.com>
Message-ID: <CAHk-=wiy9MWteoaoV15FJ7QJeRhBtCVgo6ECiLb4khuc5PxHUg@mail.gmail.com>
Subject: Re: MAP_FIXED_NOREPLACE appears to break older i386 binaries
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Duh.

I only looked at recent issues in this area, and overlooked your
sentence in between the two ELF section dumps, and it appears that you
have already biseced it to something else:

On Sat, Oct 5, 2019 at 4:32 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> Seems we've broken older i386 binaries with commit ad55eac74f20
> ("elf: enforce MAP_FIXED on overlaying elf segments").  Maybe the
> MAP_FIXED_NOREPLACE stuff needs to have an on/off switch?

I guess the "can you send people binaries for testing" ends up being
the right thing to do, and Michal can figure it out.

Sorry for the noise.

              Linus
