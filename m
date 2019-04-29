Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F995C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1789321655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AF2He1xZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfD2W45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 18:56:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37263 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729620AbfD2W45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:56:57 -0400
Received: by mail-io1-f68.google.com with SMTP id a23so10537037iot.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gygjGy0Tx6m/3bovClGd2rLBa0pi6fNkHAIxfSZ8kUM=;
        b=AF2He1xZrzkq68YRqvXpoaCfGbxnrVNa2SJu9UdF1Z6AYKHNfcloWp1li3hqdeB8Yw
         MMLLDS6kIn076fI1Wk86rvhdrAp3CTIc33eVG/u/H06seb031gy2PyWw/pSUSCpXqcs4
         QHWbCKbbkFGOAuP4i2ubnx/2+0b5W+Z3rkMYDMSUq1gvH1tfWVKTYKsR2k7Kmc91wGlR
         P5edMWkg5ant75Z611KNqa0EZJGvVW9z+435VcX94/x/UQIxv6XKzHiP+mMarsqSwTVQ
         le5Aa1ygiTZrQTZWiRMmP7I+cjqXXVUxk9fgBwc7Mmcgsum9SlhUFBYDXshYBzqR4xyK
         569A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gygjGy0Tx6m/3bovClGd2rLBa0pi6fNkHAIxfSZ8kUM=;
        b=BaHYBwtiKPJubEvF+yoDcdDcgQW5kNmBqw+0rQ7+QRTE/2+MrivT6u7Xl09F8l1yvH
         dMgIqvpzj5DOuEk8ZkcuPzDpEnKHuJWh7dyHKnTPrSDWM1q5JxmLU4imKKYVoeT7WKrT
         QrQOlNXEbzTaC2d8WIMTN59f7EgJ7kAX48jEG+9qqmQ0kGovCMpuYpuM3VTI0RVc0HwP
         RIiK+cAZYsVVUbLqtXA/HxfeN6fgTWDIZi8yomU6uYmA0U2ZUqGcvw46W3jsqjL67nfM
         YJTlwCWOrJNLtvj4jy7GicEXjV4U/YBebfIo1/a60GEg2wulgPBEM2NPTem1NG2JNwnA
         n5Hg==
X-Gm-Message-State: APjAAAU5jIVugEur+LESTkXHdCZyH0b0gIjlYVqBNUlQ/9uU9VT8qnmF
        pTtVnItnVqYazd46hMgeWX28u54jqkemSMHitcSZ/tN1lIY=
X-Google-Smtp-Source: APXvYqwELCQYSYxRolEnxOwvku+vu6EGCFx5Boay6oC9nRGmg6H97OlakZWLGo8xgn/GBDkG5aLRGbOMS5HGrk//aDw=
X-Received: by 2002:a6b:e20e:: with SMTP id z14mr6314345ioc.169.1556578615904;
 Mon, 29 Apr 2019 15:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com> <20190404003249.14356-2-matthewgarrett@google.com>
In-Reply-To: <20190404003249.14356-2-matthewgarrett@google.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 29 Apr 2019 15:56:44 -0700
Message-ID: <CACdnJus-+VTy0uOWg982SgZr55Lp7Xot653dJb_tO5T=J6D8nw@mail.gmail.com>
Subject: Re: [PATCH V32 01/27] Add the ability to lock down access to the
 running kernel image
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

What's the best way forward with this? I'm still not entirely clear on
how it can be implemented purely as an LSM, but if you have ideas on
what sort of implementation you'd prefer I'm happy to work on that.
