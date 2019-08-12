Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA94C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE29C20684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oUfGTZvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfHLRG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:06:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33574 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfHLRG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:06:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id q20so8614382otl.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 10:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5CJXVGkD5gwHmhaWFfky1xzAZEEjaJsOI/bewJ/ZWQM=;
        b=oUfGTZvEThugoKFj26lfK3BkfDcGdvq6FdjxRl1rkH+FIEBE7b/aC5h1CMgDOtaieI
         L+EkOXdjf69RSW44vYTtkv3d5cDFYfMJJJFTSOzfPYUkIufSYq91RlskMh0QlhF3vJ3R
         FOZ7MyP78IV1ZMeV/SRP5cyood7FWVLhwRF/v6/9TEAN68fdaQWcbXvVM+sBssomi8t9
         ntdvAy2kolCpg2PUmATBdEtME9uN90rqh4iZ0/8yaEAJENc88sDgHvj9yVtyGMtYkmYU
         8kS2rJlc7iSA0K7X6FDEfsJX+injfIidOBPCaa4fgC4HKsxJ1cJeC9bjcu6I9qyLaBlF
         GiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5CJXVGkD5gwHmhaWFfky1xzAZEEjaJsOI/bewJ/ZWQM=;
        b=WxwNyRmpgit+/kNeS/l6rM+1cIdtnjrRBYIS9XaP5qTF1J9r6NZs+zKU8AEu83itu2
         cc0rEC+BhjnKfXk/GoBk3pePu1MF6BW0sK8xnnfG1xRAJwnBmSeQG9iK6bcfsfKWFsNN
         fPtbwo//3KAUVtZogPL9B7QLuCIWK3i2qMGzaIvB2fbrttwhXd+rjRS4NdtQozkNf06d
         /2ztPElo39MD4TX6W2+jfTTGYrIYQwMF0wiQeCju0agVJ95+022IiEtY5fkcZnUiSG4Q
         MMoLZUnJStPS1PO05lKTEwwaByJwvHhw5U4dbtxJvvBrxgw9vJmqmVIybkWr9zYaOT0j
         CjAw==
X-Gm-Message-State: APjAAAU4IDpHfthKCJYebw+d7r+uqRE8qaQ9vxNK/cUsPpEzMSLSK8v5
        bM1yNJF9xSyvFazf+8PRB5cPbZYfOAQX43iukU1NLg==
X-Google-Smtp-Source: APXvYqwr2GIcyiBsHsQTXi2n4WnrNw8lR5CUTTTQEcH8VjjHdKGIi7W65y25V1EcF9fo+pzg7yI53LA3HOxbRlnZJFo=
X-Received: by 2002:a02:a88e:: with SMTP id l14mr6960804jam.105.1565629586211;
 Mon, 12 Aug 2019 10:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com> <alpine.LRH.2.21.1908101608260.25186@namei.org>
In-Reply-To: <alpine.LRH.2.21.1908101608260.25186@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 12 Aug 2019 10:06:14 -0700
Message-ID: <CACdnJusx3N_ZoH4=+tqt85K9J5wmUnC-+bTtG_5qSD_TYu74+A@mail.gmail.com>
Subject: Re: [PATCH V38 00/29] security: Add support for locking down the kernel
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 11:08 PM James Morris <jmorris@namei.org> wrote:
> Please verify and test, as I had to make a few minor fixups for my v5.2
> base.

Thanks James - there's a few small fixups required, would you like
those as separate patches or should I just send you a fixed copy of
the original patchset?
