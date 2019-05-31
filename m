Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6FAC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E499026E90
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559332169;
	bh=RbycsEKXVAr4qB6yzVnIcGcjIXX/sGQ4zZz07dqX2RE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ymI9yfpqD4X64MlizD8anLkx7b+53hfmu1+hECPmGfevW1+lgWP81aoxMb78mkI4U
	 SDYwOP8c8a3WoD5Ln1Rh/mpHXioCorsLasnrlm66wN/TNOxkZFaro/famVO0hu2z2j
	 4gJ5KPZVGZvRGp/1orPijmiepWj+M4QHSg2olNX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfEaTt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 15:49:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43152 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfEaTt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 15:49:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id z5so10712775lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 12:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4XJKszXT9nzmab/n0OLDhIOStZBWGsk7FbZlCagWz2Q=;
        b=fJc0fkmlN3PrvuO2sTLNlFimmBlSGtrm6X8n93j7QiUf3mTbBaoJQr7T/zjlJBSihF
         OFsuvdgNOTf63LLkk2Hv2QfXRI/ytz4gQmNu48KLfEJkcYYE5Gq5Z1Y9XLTYSKCLjGMu
         LyVgz2/ct6QMalCWwO6SL+2BGu2p3DVnwSO3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XJKszXT9nzmab/n0OLDhIOStZBWGsk7FbZlCagWz2Q=;
        b=SK/YnmsoJY7JpsQesP/31KU2RE84FmQbiLYSmBF2fJVbFyLpRA6sF3XPNXcQZEkkoO
         Mwhdd2Znv1YuFvYOL6pnGH892mp15mINH5cm4lIiCvOCB43p8DUYcMWLOJvOQR4aZVKr
         E7sCAaSm5SczHA1MYc6hcDjnwyV+UBSJK7hXB5EDcc1o7ctDLDV05GV/3yTM0noPi5sY
         3uIfOsSsyctrziou16f/eeRIcDrX9IughEnm+m3a77ai5SHpTqAksAmzqO7CQJgeQbqp
         nZfYxO0OC742rH+5IJfvDczLDlhjk/G7R7tgqidEp7VsW+qYMYFweCUR46mGc4jKUjNU
         i7lA==
X-Gm-Message-State: APjAAAXFIuNGF91RRYclWNm00x6v73o5asd/m/4v5isUAYqS7rlHuufm
        QbirxN+LJX+LvOvprmMhcPavlxwLdFs=
X-Google-Smtp-Source: APXvYqweYfvPPtiF8sexdFzTH9BvvbzZhklBIypkbn4X/ubzIiE53TOpO0XO+G/7ibqFbwpXeEZPwA==
X-Received: by 2002:a2e:9259:: with SMTP id v25mr4322500ljg.46.1559332165062;
        Fri, 31 May 2019 12:49:25 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id m63sm1402518lje.44.2019.05.31.12.49.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 12:49:24 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id v29so889893ljv.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 12:49:23 -0700 (PDT)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr7042553ljj.147.1559332163658;
 Fri, 31 May 2019 12:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190530135317.3c8d0d7b@lwn.net>
In-Reply-To: <20190530135317.3c8d0d7b@lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 May 2019 12:49:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjP3Ch2Lp-RzVZFsMRgzbVbY1ttVJQ-ds-gJcnpm3paag@mail.gmail.com>
Message-ID: <CAHk-=wjP3Ch2Lp-RzVZFsMRgzbVbY1ttVJQ-ds-gJcnpm3paag@mail.gmail.com>
Subject: Re: [PATCH RFC] Rough draft document on merging and rebasing
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 12:53 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> This is a first attempt at following through on last month's discussion
> about common merging and rebasing errors.

Looks good to me,

                Linus
