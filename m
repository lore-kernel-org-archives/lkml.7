Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F32C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D709F2084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXA16xY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDNP6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 11:58:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44479 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDNP6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 11:58:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so18475366wrn.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1w7KNJbv0LPCTsOiaYch44OQ9X5ymVJXr/rgfrYRT0M=;
        b=gXA16xY07XgeawbqLbYKyvw6tDuV8Q/Lns4kuCMFuXaxXGhPP0rwZ025Tl+LWUSZBe
         3V2G4QIlEGzRQgaUNIwToGZd9B9IBXISjsomSM0oZBq+0ZVrGKY+vRlNA5K8/p05gIdC
         XoppSmG0Cx+Jqp1GjENVO7PIKOyPrBAJQ/22VsJYpespAedAWEiAKcGIzzfS7irF5HCL
         WYRd4/NtID8xQ9psPx6jHpFqezRj52O7jdkvVY2rKt6tbA8jbPcAzLwfwNHHUbVmQ92Y
         FuEtoT6JUPsck+thgXwev9nNr8k176Bmb+tvaQaMh0oPIs/VoHsk+CK8gx4dm6BMFfpS
         WTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1w7KNJbv0LPCTsOiaYch44OQ9X5ymVJXr/rgfrYRT0M=;
        b=En6FqFJbg5uxiTuYe/x/CCLV9wMiwCJW8qgzYd1nRhcANG2jb55kWGhW6yjFgKphdK
         7s3lJj9vbRDBxr0AJ4orvZxpU+KI+/U8SjyuGS1o8mguHtBp4yIo7d+HGvfCq7loCGZK
         PBlYUSbmLRBkCvHPMe+6Jail963DC5iBYwWdggEydq4eOpWpQOy6RHn5OFQ5NWyQMyO3
         hdJ1Myg0lFPP2CBYusgnxl6UaKyANwzbFu0GyF29de2CjuKszFOooTZKjMUcfxhhHOKY
         KbAA6HNF9MTacj1AKGpI4SI7K+rPpG2TxsVc2iQRRYccYmyxCSAEPXVfGAzzVW7FE0dg
         d/xw==
X-Gm-Message-State: APjAAAWOc41kdzlhFNnQKz9lFSDEgU9NuyQ2fYB02mWjof2lrOlsZ54O
        3dME8AIPgqiTjcCUXd+PjQs2I1M=
X-Google-Smtp-Source: APXvYqyFUo93nJ3VayEXUIno3pYe/9OR4LaOhEBESY0pw0vrmFpgKjhSNChIzVc/DCQsD+MmFEcc5g==
X-Received: by 2002:a5d:6681:: with SMTP id l1mr13486589wru.186.1555257531465;
        Sun, 14 Apr 2019 08:58:51 -0700 (PDT)
Received: from avx2 ([46.53.240.140])
        by smtp.gmail.com with ESMTPSA id f10sm57964902wrs.17.2019.04.14.08.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 08:58:50 -0700 (PDT)
Date:   Sun, 14 Apr 2019 18:58:48 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: fix map_files test on F29
Message-ID: <20190414155848.GA23418@avx2>
References: <20190414123612.GB12971@avx2>
 <bb2991f8-323a-c835-0b04-ff8d565df0fa@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb2991f8-323a-c835-0b04-ff8d565df0fa@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 08:24:53AM -0700, Randy Dunlap wrote:
> On 4/14/19 5:36 AM, Alexey Dobriyan wrote:
> > F29 bans mapping first 64KB even for root making test fail.
> 
> so there is an F29-only patch that prevents that?
> something that is not in mainline?

Ehh, no. F29 ships stable kernels actually.

Test assumes mmap(0, MAP_FIXED) succeeds as root. F29 uses SELinux
to ban that.
