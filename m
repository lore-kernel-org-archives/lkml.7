Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9A4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3DC20882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554193538;
	bh=0CVnNz0TxltwNganlwo7xSXMVAzV2F9a5jxczwcjKS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mcghEWBfR2+yNJlwaBLGmJSvrNsROKS1YTOh5z3tQfmtZOi4BqdocMH+Fp0od/LPT
	 7IaP6Puo2bBcKCIN+tR+ewRKQi+WFgYZwJnlLykuRTwy+v1VgNE3cHpKpP6egCRMSn
	 jxOomeXsxq5FtaFNl4x6zyXkZnqjZWnA/OK7afVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfDBIZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:25:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36425 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbfDBIZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:25:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id l203so9088982oia.3;
        Tue, 02 Apr 2019 01:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6H8/I1ZKoxKEsfmiH5FBekkBm0KXC4ZiPp0uzUOIAiM=;
        b=fECQNKg7/1/IeuRnR5DyxcF/aT0QP11sTPzHtXAsiOWWJnsXH6BthF5Pgm0b4y0gBf
         G2xC6NFNh2XFUBc4JSQSicn0Pbzbf8YOdBzzx0xVmEvR68NcVs0qlLTFgmR2VlCCj4Gq
         /HUZ3+r4L48qI9aSSdRS0mcfXHsQ+C02AXGNGDV42mtNsdGWb7vqrSlfOKp1ExEjtEdT
         B9tuzsWXUOF8BEDlCo4wQqTm60LsCtnOQUBGZ7qvoECZKcOE9zfRZgPt2L6IAhUWszep
         wFpB20mFZMmfldDWDGaQUr6s9AVrAQ/4OBbdSV0+pCf0kQqzxrCowMea2nhTnWlfnGNJ
         zUNQ==
X-Gm-Message-State: APjAAAURuFWagfHJYHGC6fENQUePSQl+/yZQxMbXWUPlpNFWhIRy1DvL
        /nGyJFOo/xfFWDd1TqPln/qYHpbN/nFmw/BSK4I=
X-Google-Smtp-Source: APXvYqz5APC6QnaijFYWKC4UgE3bG1NyA7ukdGqIBUTEoiPypS/Sz/Qltv8DCZemp7JVZYCjEO/gKp/7cizfyLsLa1o=
X-Received: by 2002:aca:6289:: with SMTP id w131mr3519121oib.84.1554193535958;
 Tue, 02 Apr 2019 01:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190329001135.15847-1-changbin.du@gmail.com> <CAJZ5v0gKX9E+U_9eKfTr7pWGH=jxMLz_Jr850-6BcbG3xBz5qg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gKX9E+U_9eKfTr7pWGH=jxMLz_Jr850-6BcbG3xBz5qg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Apr 2019 10:25:23 +0200
Message-ID: <CAJZ5v0jbCi3Jgn5YXPCP+zgs-O7z-9_3p3XZGvm40_6RDsJqkQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] Include linux ACPI docs into Sphinx TOC tree
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Changbin Du <changbin.du@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 10:41 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Mar 29, 2019 at 1:11 AM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > Hi Corbet and All,
> > The kernel now uses Sphinx to generate intelligent and beautiful documentation
> > from reStructuredText files. I converted most of the Linux ACPI docs to rst
> > format in this serias.
>
> First, I appreciated the effort, thanks for your work!
>
> > For you to preview, please visit below url:
> > http://104.238.181.70:8080/kernel-doc/acpi/index.html
>
> So currently all of this appears under Kernel API documentation, but
> the majority of it is not about kernel API.
>
> At least some of it could go under admin-guide IMO.

Jon,

There are ACPI-related documents currently in Documentation/acpi/ that
don't clearly fall under either driver-api or admin-guide.  For
example, some of them describe various aspects of the ACPI support
subsystem operation and some document expectations with respect to the
ACPI tables provided by the firmware etc.

Where would you recommend to put them after converting to .rst?

Cheers,
Rafael
