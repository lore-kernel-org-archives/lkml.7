Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FAFC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71FC208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfHJTMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 15:12:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40687 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfHJTMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 15:12:19 -0400
Received: by mail-qk1-f196.google.com with SMTP id s145so74260519qke.7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 12:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tOm/MfXC722ZZDGZkYyy/bxra5b24Gt/HS1+G7EfviI=;
        b=f4zl79Zp4spgUyGPm5iFNc6foD7c6hiliH2mhoW34cwipgZEUXAGPvYl8u3IwHfaql
         +PBdrfb0sNgOc/gqY7VbgopOXHtH/qxkl1FcObwVVPGPdf6LFIHhgI9ppAsvo7Kiamwn
         GpDG94ijIKGmRhOmYKXZYkOIV0Y//r+Q6KIdO197l+oAUSxg/zUpG2jNJhMU/7UGgzzL
         IHUJij3UR1f05gG6rR1bORTrnPFrzG0ExucMESwWxW5cv9uTkPljPnEdc1EA68cuAXEM
         7hrQW/hLc1pLSdOE48QQOBUl9/mRB3BgeLArMpl24hIU0QNwUFrFNI9lVqHxnCTk9XFE
         ZBFQ==
X-Gm-Message-State: APjAAAUDND6eeh+Gca9g+VSsnxGP96Ly7Gy5VMFZ8Ktu4C8kEFyxAYbF
        mA9xnGn+n/nJnC02xhN8yXaRyA==
X-Google-Smtp-Source: APXvYqy9zmxhh9QafC0RnwL+m0pBIJpGi6lXzl9adS3Ij5sGenWXNRYs/XzZWBUSfehxs1JFSId7lA==
X-Received: by 2002:a37:516:: with SMTP id 22mr23794866qkf.308.1565464338086;
        Sat, 10 Aug 2019 12:12:18 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id q17sm40074395qtl.13.2019.08.10.12.12.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 12:12:16 -0700 (PDT)
Date:   Sat, 10 Aug 2019 15:12:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V5 0/9] Fixes for vhost metadata acceleration
Message-ID: <20190810150611-mutt-send-email-mst@kernel.org>
References: <20190807070617.23716-1-jasowang@redhat.com>
 <20190807070617.23716-8-jasowang@redhat.com>
 <20190807120738.GB1557@ziepe.ca>
 <ba5f375f-435a-91fd-7fca-bfab0915594b@redhat.com>
 <1000f8a3-19a9-0383-61e5-ba08ddc9fcba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1000f8a3-19a9-0383-61e5-ba08ddc9fcba@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 08:54:54PM +0800, Jason Wang wrote:
> I don't have any objection to convert  to spinlock() but just want to
> know if any case that the above smp_mb() + counter looks good to you?

So how about we try this:
- revert the original patch for this release
- new safe patch with a spinlock for the next release
- whatever improvements we can come up with on top

Thoughts?

Because I think this needs much more scrutiny than we can
give an incremental patch.

-- 
MST
