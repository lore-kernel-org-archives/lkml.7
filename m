Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170A8C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7A420835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCxbrCuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbfDXUWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:22:45 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51354 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbfDXUWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:22:45 -0400
Received: by mail-it1-f195.google.com with SMTP id s3so8699729itk.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltHpCvaDH0MdzUIEDOiPJEYuRRXip5WNmUSOIBLj3WA=;
        b=aCxbrCuWdkFAWtU99D3beSVgZBV29+mudc9bxwax85StrwLHtx55VSBHYXXmBRJPvp
         BcLXAO3KZFy33jffdX9Cc+LE7ErYbxncG/8rBWa60u0AMk5bZKzuauGJ/utyDSrRW3qK
         Mu2thUGdiMQa/Ce8UMZnyuiLjOYqjQXVEaap7N8+l2b2Oz0ZoRHz9qwLWYDHeyYLbKt9
         4GUTxtvIcufJcNSRvN2Gre+MCRlYbOPXIZLjXCsM2obfXFag/8G26D9Shh6jXcZlO+UC
         sOsd86pg294hODTTnP8ehCR4AuGMhgyIa74nNJ9Txy9KTu2PFcDvPgeSF0QHBmRMCHIM
         Sbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltHpCvaDH0MdzUIEDOiPJEYuRRXip5WNmUSOIBLj3WA=;
        b=CwRE3xVxIgaqD74We0rkYAyBWFQNHAXPIGf8yUTpZ4NhdrhI0C3QGk7mhYPa1x0/Yg
         JvQOvl6hxgJ4JsuFuE5eeOiGAtg5VEmT3haPERVx2dhFReJRDZc/Li4wNhrNVNrEZnok
         QZvkPf6wLxwjmV2+3BVurryST4b2LE/9iVQqFiLtaiRyqj/ukPPGXqemwE/ls0ZhRdpm
         Nx0uD98vuHMXqR/lZKzKTS/RWts6n4m/mJ74MJ4syqDNlOV+Z/jH6ptfZ+98hBQIShrU
         xeZPAAExwA4A+EKNceaE1kgsDYO348ZBvrUvbM8HI84+ZXkzOfpB3NbUb9Zb/hW+uWWw
         SRlA==
X-Gm-Message-State: APjAAAXLuH+ntnWMOXV2TdWsV1K6bCnGMpwMYnZApc7AV8wrh0Z4Exin
        BnAmCdQ0mG2PfYyz2FEChEb/+TNtVg46ndqqkGC4uw==
X-Google-Smtp-Source: APXvYqwDIHdpqJZWC9/1e1j8c7MN7Q7ec24v/q7WYdAsy47RoI6XXcs7tJMSLCseUO1rJ0xxq4Gwz7aOUUkKd0Z3OJ0=
X-Received: by 2002:a02:ad07:: with SMTP id s7mr14136376jan.103.1556137363865;
 Wed, 24 Apr 2019 13:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190424191440.170422-1-matthewgarrett@google.com>
 <20190424192812.GG19031@bombadil.infradead.org> <CACdnJutj4K1kQj7yXcCNVWM_hmrUwMfZ-JBi=FHkBvYFfbJNZA@mail.gmail.com>
 <20190424202006.GH19031@bombadil.infradead.org>
In-Reply-To: <20190424202006.GH19031@bombadil.infradead.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 24 Apr 2019 13:22:32 -0700
Message-ID: <CACdnJuup-y1xAO93wr+nr6ARacxJ9YXgaceQK9TLktE7shab1w@mail.gmail.com>
Subject: Re: [PATCH] mm: Allow userland to request that the kernel clear
 memory on release
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 1:20 PM Matthew Wilcox <willy@infradead.org> wrote:
> It depends on the semantics you want.  There's no legacy code to
> worry about here.  I was seeing this as the equivalent of an atexit()
> handler; userspace is saying "When this page is unmapped, zero it".
> So it doesn't matter that somebody else might be able to reference it --
> userspace could have zeroed it themselves.

Mm ok that seems reasonable. I'll rework with that in mind.
