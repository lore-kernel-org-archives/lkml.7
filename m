Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DF8C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C706420685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M0ws2KqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfDVNs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:48:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35355 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfDVNsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:48:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id o12so12567138wrn.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 06:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+H0yAQfSt/OuW9uTJYdZOd3c9n6fn413lTwwjlVogI=;
        b=M0ws2KqEWS+0fQsGT2foyKEHS7JVwHRIl5yLR/aV9JQziJBu0sE/3Jm9jNQxFtjbWo
         gv1Ev/fJMu5Wz1D0OnsYeAJ6ZlDXBmKVqydR5dRec8JUvKiCuBCewGxZm9VI94ZIDVBy
         DBlT/+vhXmzyfryOGkQtd0Bzk4lHHcX4t2S2HPqXymb1kNNKeRI7q0pYnHJevLMV8dZh
         aO7ze+VRBqGEm6urA3p3+34RMHuxt+RyDD4IlESBxCxNxPjqh5YRgN17ixc60I8/QsH6
         Ouq8UTxgu3MkQMWanUcVvFjTXMaQPD8fLlD1vpajBq2Sv/J80SqTx126dMb3GdDO1JDq
         KnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+H0yAQfSt/OuW9uTJYdZOd3c9n6fn413lTwwjlVogI=;
        b=RBhtnhv36CEvn+wtrtViFVMGWo3c6pO6upa7pSDuE9De8Hq6VJJCNFolCrBrwOz6Q2
         VuAnUHldJXnpzJhTTT+SLBD3mHcIWOaLds7es4eVCvSFcXx6oWRQKojl53Gcj23Kzbyi
         2XRFWinvgBWzIAVOY3IfRfRXL3Y/iKSBBn3BsbBX39NhhTmzckM2Pk7V2T/wF33NtLPM
         LYFyvehZI1K3UAVZUDwrKTZoLmXfD0TK/pUeBhAcya7RRiuhax9vrrsl0LZewavGBqg2
         Wz6eVb5cgn9J+HO5X8O/Xk8aNDRFlFciIW/laUDLEX2d3pfShmujyzfwixLczF/v2CMf
         m6kQ==
X-Gm-Message-State: APjAAAUXjcPa9AX8yczqnDAqBAgUijt6SBd1qaQV3fBFCz71ALqXDGm0
        ++2mS5iXUgrclM/sPpQ4aDJh4Yqjlk7QtAKgn5vp
X-Google-Smtp-Source: APXvYqxFApL6Oa7QKT50fOYQKKfwDKU/AIYzkpZnb1XA/rXyh5XsOG/2YYJa+msOaVpC8SneO5b5XrHaM3YQAilmgzY=
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr14110700wru.130.1555940902197;
 Mon, 22 Apr 2019 06:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555938375.git.mchehab+samsung@kernel.org> <7adf9035ae06ecc6c7e46b51cb677f0a8f61d19a.1555938376.git.mchehab+samsung@kernel.org>
In-Reply-To: <7adf9035ae06ecc6c7e46b51cb677f0a8f61d19a.1555938376.git.mchehab+samsung@kernel.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 22 Apr 2019 08:48:10 -0500
Message-ID: <CAErSpo4FLuCVPGAZGKeBn=-oyaw6eTrseMnaHJo1TVjxnfCZrw@mail.gmail.com>
Subject: Re: [PATCH v2 25/79] docs: convert docs to ReST and rename to *.rst
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Changbin, -cc many others]

On Mon, Apr 22, 2019 at 8:28 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Convert the PM documents to ReST, in order to allow them to
> build with Sphinx.
>
> The conversion is actually:
>   - add blank lines and identation in order to identify paragraphs;

s/identation/indentation/

>   - fix tables markups;
>   - add some lists markups;
>   - mark literal blocks;
>   - adjust title markups.
>
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

The PCI part of this is fine with me but may conflict with Changbin's work:

https://lore.kernel.org/lkml/20190409155626.6049-1-changbin.du@gmail.com

Since this doesn't look like it's targeting merge via the PCI tree,
I'll let you two work out any conflicts.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Bjorn
