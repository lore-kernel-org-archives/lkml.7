Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF04C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B480820B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="tj7tFwRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbfDVSLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:11:01 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35373 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbfDVSLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 14:11:01 -0400
Received: by mail-lf1-f68.google.com with SMTP id j20so9628553lfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 11:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXcU2rwgvZNUrY/itsQwdIy2L1lPb6tI46vmzKGhR7A=;
        b=tj7tFwRHkoz7pjmoWjo3SMm0XDlteq238wWuL6ybJvcZrsL2JxJx2ZgWmSLn87CZaz
         3H9UMN9Vl+EtCEoBnHNDHmKqQu/kM+RDgBqSjUVbPiz3cRoziivzTkzgQ4yI7VxlAdEG
         z+hlqrR4xJpGsf8cLtXEHPnnOmIESFfziCIA53F9ODKsp8nKGME4m7xGR0xtaqIz5fVa
         N1r8IKclGB9PtRt2chuWfiVxo3GoN7jdHO2AXTCaAGfFL2VT6NU9NdnPVATly+Ai5x0p
         hYa0uvK6LBrsARi+w9cDmpI7t9dulKi/5unVNe4MBSDajRLPAPEKbimUzln15UcWTYGK
         GBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXcU2rwgvZNUrY/itsQwdIy2L1lPb6tI46vmzKGhR7A=;
        b=hNjKh+tGeInoaWUJP40t0ckupAbLS0GV+kfw/5J1nAVU94B7Q6u0+mKPdFcydldvku
         Q9Whdtb/FIHZ4yjMq30Dz2K/wn20yrozfZF3qzBDS/VJjDkfd0Eb4aF8tgIW9D284QkA
         ERXo5pA5hH6WJo+NjYA0WQQ/wixLzR3QhSJ9bEjqyjOGoSVPDoYLz+sHU/ihTOzWCvVu
         hvuVu0gdEjHFj+OdpiHUcE7NcxVwm5t9nRBAQlSIlmFhgw/acYWeEyWDUvW8zzfZa6zD
         29rkrhrOxskYzBYGfL/GM8FFY6rG1p8+zo0IT3Co1+b6MvHQqNFeex2DsmtB2/OYos4X
         u+xQ==
X-Gm-Message-State: APjAAAXFbZ2KYhg2319lSO7XWVqDoR5WBTJymE/Zxxlizt+NCXTceYgE
        GkgFapizTZY3ZcdYq98IyYpqtt4zknVDL3oyusfj
X-Google-Smtp-Source: APXvYqyFxh/7LRh2OUs07TaeIwkLdmUFOzPywD7hyxv8By/XR7oy9MGpTc3jNJvUlnYKg+aAZN4R8oJKU3Cyeok7DUc=
X-Received: by 2002:ac2:4119:: with SMTP id b25mr11052807lfi.72.1555956658518;
 Mon, 22 Apr 2019 11:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555938375.git.mchehab+samsung@kernel.org> <72133d276dd8cde2d1ee8528b4e87ab2a614cbd0.1555938376.git.mchehab+samsung@kernel.org>
In-Reply-To: <72133d276dd8cde2d1ee8528b4e87ab2a614cbd0.1555938376.git.mchehab+samsung@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Apr 2019 14:10:47 -0400
Message-ID: <CAHC9VhT7_vu1TeSWSFAJprf2iCgyHRYLpfpBvR48Yc40XefUcw@mail.gmail.com>
Subject: Re: [PATCH v2 23/79] docs: netlabel: convert docs to ReST and rename
 to *.rst
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 9:28 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Convert netlabel documentation to ReST.
>
> This was trivial: just add proper title markups.
>
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  .../{cipso_ipv4.txt => cipso_ipv4.rst}        | 19 +++++++++++------
>  Documentation/netlabel/draft_ietf.rst         |  5 +++++
>  Documentation/netlabel/index.rst              | 21 +++++++++++++++++++
>  .../{introduction.txt => introduction.rst}    | 16 +++++++++-----
>  .../{lsm_interface.txt => lsm_interface.rst}  | 16 +++++++++-----
>  5 files changed, 61 insertions(+), 16 deletions(-)
>  rename Documentation/netlabel/{cipso_ipv4.txt => cipso_ipv4.rst} (87%)
>  create mode 100644 Documentation/netlabel/draft_ietf.rst
>  create mode 100644 Documentation/netlabel/index.rst
>  rename Documentation/netlabel/{introduction.txt => introduction.rst} (91%)
>  rename Documentation/netlabel/{lsm_interface.txt => lsm_interface.rst} (88%)

Still looks fine to me.  I should go through these docs again to make
sure they are current (the old email address definitely is a bad
sign).

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
