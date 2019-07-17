Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F7BC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AEB21743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563381739;
	bh=0P0h2eaJN6DvOlKrrqSZQgu/ILW+P+1x78k7tkMWYOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zPUKk0k1Nz/V9iWGd6/T78NKXiLvpYN+sOYNLuAuXmGzxBF+gmKQiGBUmOwDAVFyT
	 cKLDBPqR/Jbc/7AGCVmbmDInVvs4fwIozlA4uL6EK3vl2gK4rL9q8eAsVQA6Mnxgse
	 hXOYJqPs1qH9K2b8WM8DqT5+nWeAOH/q/opfPFag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfGQQmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 12:42:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36876 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQQmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:42:18 -0400
Received: by mail-io1-f66.google.com with SMTP id q22so46787133iog.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 09:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MEk0Eu2nCv7ODpQXfa3RYlGX5rYs9SEdcQrSe6XXqk=;
        b=B3mG3LUlbSYHSOgC7XNu2pZlrZ7ePegASDphXdzO294KIOq1wXXWSGU/CkSrlt8zqC
         OsdUm+qjRNROMQJ5gcyQtpTbtUjCXo0kvjyqxj4XPRyiolAKqsiatIpC94zOpxxeIecV
         F5K0zXPcY0D1VT0KJ77DaZ3UmbR4xMFfKGMPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MEk0Eu2nCv7ODpQXfa3RYlGX5rYs9SEdcQrSe6XXqk=;
        b=Kx3TsvZx5YBQkCbfG8UluuLonszn3aqDhdKynoA7XS+HRFmUfvi9v3AE5BkSyDRDRG
         wcAPiyb5vNpGzIVSDlMvnU5kA/BW9jix0DIoDURen7mfATUg/PIG4SOe4BYkmkKnT+YX
         6rBWEEGedlTsZQqnrgzBcd5XmXZJ7aPtetbDcTKGzPNFvRVuhoXTxjr7Q4mt26F03S3Q
         QZ904bTivGl7kSOrnMWIBdYhlrmvet/VZiftt27f0OQy+oKzmTNcaOiCBHMO7q1PTtHn
         L3/jyy64RdsRujbygz8N/ufP/yMSJHuVRug/ir08CKFmzt72drWKNz2p6L6O+Yv4GDeD
         j7xg==
X-Gm-Message-State: APjAAAWoo4zI1d/YKp6ZyUgkUquSlcgd4cHa6UWWAzb1CEI6r5gWLsZM
        8Fw0OlQNoitMnfrpL2AqrP0WOiEjDts=
X-Google-Smtp-Source: APXvYqzZarQt7HREs6TYAxB/hl8B9qha/4y9Dzc6Ve8yHh35LKgtnduqq3I615pgFtrXjLFAiawSqA==
X-Received: by 2002:a02:1a86:: with SMTP id 128mr43111196jai.95.1563381729062;
        Wed, 17 Jul 2019 09:42:09 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id 8sm20718695ion.26.2019.07.17.09.42.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 09:42:08 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id h6so46751659iom.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 09:42:08 -0700 (PDT)
X-Received: by 2002:a6b:bbc1:: with SMTP id l184mr39875052iof.232.1563381728230;
 Wed, 17 Jul 2019 09:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190717152545.bhdnhjdf2tlhuv3o@pburton-laptop>
In-Reply-To: <20190717152545.bhdnhjdf2tlhuv3o@pburton-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Jul 2019 09:41:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipjStEwJj2_iWxBdVC4oV8rY5NjrRb1tmWLUa0VrS_Eg@mail.gmail.com>
Message-ID: <CAHk-=wipjStEwJj2_iWxBdVC4oV8rY5NjrRb1tmWLUa0VrS_Eg@mail.gmail.com>
Subject: Re: [GIT PULL] MIPS changes
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 8:25 AM Paul Burton <paul.burton@mips.com> wrote:
>
> Documentation/process/license-rules.rst suggests to me that the version
> in the MIPS tree is correct in terms of license name ("GPL-2.0" without
> the "-only" suffix) whilst the version in master is correct in terms of
> comment style ("/* */" rather than "//").

It's actually license-rules.rst that just hasn't been updated. The
"GPL-.2.0" and "GPL-2.0+" naming was considered too terse, so the
modern spdx tag suggestions are "GPL-2.0-only" and "GPL-2.0-or-later".

The full list of all spdx license tags (many of which aren't relevant
for the kernel, of course) can be found at

    https://spdx.org/licenses/

in case you care.

             Linus
