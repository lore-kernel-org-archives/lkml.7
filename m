Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0385AC4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E921206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pP5EQZ+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfFXX4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 19:56:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45213 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbfFXX4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:56:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id a14so24183829edv.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 16:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJB0CFLYwTIUULDoeP21WrS2Yg7QC8IxRDJ2iUsn4AI=;
        b=pP5EQZ+oW3XstA7p2mr1uQyDkp74c9m7haJVL5BKgdFCQdkM4v1CZeppMNpJEWD4zw
         5e4MyNVL/PmaHVGuOZEDUZDUJ2V56e2iePORcy4BKQC/yQzVzTErTBstR3Fl6iI3yTsQ
         Ro1vvAdspGw9Uwg603Al1dRYMoE3fUma8YJ7iIiQwPCPnBIh94DuyGlWBmp9LKWUiN4H
         0eQk9/r5FeHZE4x+58qTbcyCoQ/WD0fkrUmGwiUj6wHakQQ3aGf8vaDbUiMFAN28J6bL
         iXCbtEYXZgQXWMe67RM92ZqTb44sSKxVGiggZQe9lzhdEH2ITcXxPixLXYJW3S0vbzD1
         Q6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJB0CFLYwTIUULDoeP21WrS2Yg7QC8IxRDJ2iUsn4AI=;
        b=HRitBnQhioN0qPh2NRRUj10TAJq1/ddru5LFD3YNm5KFGYI1vajOfv7XrBeA0mMBVm
         XVQA2Ey1fER//xxJoewHTGlItQm+waIF6iqP4PhIgc4bjcGe40LXW0h2SWuyZAlmGBeY
         pTGnawS87rtQb+XfTe3xFmm2Q7oGoXDjs83FSiy9U2hT154MRr08sqWRNMYEXipd6Mt1
         bsmH4AQZBsnwU3+xwcCh79ltA9hcw1MQelwcdEWUIFPvgmlqBc0jKzbzsqM93wJol0VC
         ReDniBd0qxbdkj2ht32Pb5F9nF3jtuBQD6DepRLcGPWX8n8DycBopJCnVr+T9F+qnRJr
         UPRw==
X-Gm-Message-State: APjAAAVi1Rho5FijWFnHZr/AADKx/5E1lE1BcjQNB+fwaAwdmRyFPG84
        xcILYLMrda4gQtLMF50aIVjpw5i4xYuU8xKK0aSBiQ==
X-Google-Smtp-Source: APXvYqyFUhz6SPn4aBkx0KWHeoOdAa3ZkXgYUoR/wiTHnbC7xEPggCjNIsFAY+G/btOFIm6lrDc35PuG6eeixGJpptM=
X-Received: by 2002:a17:906:470a:: with SMTP id y10mr76707823ejq.115.1561420612583;
 Mon, 24 Jun 2019 16:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAOyeoRWfPNmaWY6Lifdkdj3KPPM654vzDO+s3oduEMCJP+Asow@mail.gmail.com>
 <877e9g9lpu.fsf@firstfloor.org>
In-Reply-To: <877e9g9lpu.fsf@firstfloor.org>
From:   Eric Hankland <ehankland@google.com>
Date:   Mon, 24 Jun 2019 16:56:41 -0700
Message-ID: <CAOyeoRVncfuFjrseenE5c2qw3hBT_TM+YeQK-ZN=y-WE=gkc3Q@mail.gmail.com>
Subject: Re: [PATCH v1] KVM: x86: PMU Whitelist
To:     Andi Kleen <andi@firstfloor.org>
Cc:     linux-kernel@vger.kernel.org, linux-kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Consider what happens when tmp.num_events is large enough to wrap size.
> I suspect that's a kernel exploit as written.

Thanks for pointing this out - I'll fix it in the next iteration.

> Also don't you need to copy tmp to new?
Yep - somehow I accidentally deleted the lines that did this before I
sent out the patch. I'll also fix this.
