Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D774C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C592075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQ24olSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfFEQQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:16:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44657 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbfFEQQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:16:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id w13so20048136wru.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 09:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cVJij5px6cgbTmt5z68onmeHRyl3UNhKUu1rRuGXNYc=;
        b=OQ24olSESqI7BgEmOlAKFmqiPlICqgBBFqgQ0jeXETTAF3DSYL7T5/HU0J7Hti7y0u
         idaxbS+l9CxJ1bgmIU39ezjMW0u5TfQAEzKyQtlfR/U5whBeOxjuEjW2z2PERxjpP2UQ
         AyhYMak6vNyqjFs7tGgdnRRGd0+v0jRzgdsrrne8uk+sNF3kX6q8yu/QMJyKLX0IEiWp
         REUJCgPjCMLd/RjchG94M8JAvc8Az7pu7D2EcaU3hzbWzoWzMRkSx45OZE6lkAaLwbds
         3/xQepMv1HUAwwFLwjR16sW5HrLvp9LtO6m1sw7V9U+wZKpnlmDJHgINfueh8QNWssj5
         vmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cVJij5px6cgbTmt5z68onmeHRyl3UNhKUu1rRuGXNYc=;
        b=Ai2oi46qnRBCQoxXerfltbe1e3uEXCJmKiszG1RNzoXV2fYN6Mn7Rphqltcm7D+9dz
         mWpKdUb5J1Tpb2duAzkEbkQhyq3dxY47VxMezcx+Gvwug+v4qbGOTKdK8z+xp2oUQkOH
         ktgf8IAHJvjl1SbcSN5gmdIFs26uOxcRMuCs7gNpsJM36VMMgarZFZAuuJBlHnZBby1/
         Zk2hVC3SjQ59DQOxHxP42qXW4Bw8BtUEXVF6d8Hh6J1TOhzU46Bplnj5QKKKv2C6iSgG
         gTXRehrQI8Tof8ynP3fgpVD5ToVj1EztJCd/IO85RfgY4fv7FNkjZGTzj5tw/wk11yYQ
         i6fw==
X-Gm-Message-State: APjAAAWSlawh/Gfx6S2kTsFl7WxnvrAPs1K+EIFe/rBZ+kCUN1nLY8yT
        Ra5g9cg8Ha4xe2BZSIR7sC0=
X-Google-Smtp-Source: APXvYqz1HXlU4P5+IyhG7f8IchTpP8RCfHTm5FQSf54gF4/uP4JR53VHltZbiyQ83kGokqa54HK7ZA==
X-Received: by 2002:adf:eb43:: with SMTP id u3mr12023336wrn.342.1559751369349;
        Wed, 05 Jun 2019 09:16:09 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id c18sm20819435wrm.7.2019.06.05.09.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 09:16:08 -0700 (PDT)
Date:   Thu, 6 Jun 2019 00:16:00 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ben Hutchings <ben@decadent.org.uk>, Jiri Slaby <jslaby@suse.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "consolemap: Fix a memory leaking bug in
 drivers/tty/vt/consolemap.c"
Message-ID: <20190605161600.GA4720@zhanggen-UX430UQ>
References: <20190604180039.gai2phwdxn7ias6n@decadent.org.uk>
 <20190604190234.GA10572@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604190234.GA10572@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 09:02:34PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 04, 2019 at 07:00:39PM +0100, Ben Hutchings wrote:
> > This reverts commit 84ecc2f6eb1cb12e6d44818f94fa49b50f06e6ac.
> > 
> > con_insert_unipair() is working with a sparse 3-dimensional array:
> > 
> > - p->uni_pgdir[] is the top layer
> > - p1 points to a middle layer
> > - p2 points to a bottom layer
> > 
> > If it needs to allocate a new middle layer, and then fails to allocate
> > a new bottom layer, it would previously free only p2, and now it frees
> > both p1 and p2.  But since the new middle layer was already registered
> > in the top layer, it was not leaked.
> > 
> > However, if it looks up an *existing* middle layer and then fails to
> > allocate a bottom layer, it now frees both p1 and p2 but does *not*
> > free any other bottom layers under p1.  So it *introduces* a memory
> > leak.
> > 
> > The error path also cleared the wrong index in p->uni_pgdir[],
> > introducing a use-after-free.
> > 
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> 
> Now applied, thanks.
> 
> Gen, please be careful with these types of "fixes"...
Thanks for your comments. I will for sure. And I am always submutting 
patches and revising it according to the maintainers.

Thanks
Gen
> 
> thanks,
> 
> greg k-h
