Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1A8CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC232084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HEKT0OaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389344AbfJWGtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:49:24 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34940 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfJWGtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:49:24 -0400
Received: by mail-il1-f195.google.com with SMTP id p8so8168243ilp.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 23:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=uTV1lJCzWFvRXETtO2mm+8BlPiNvkSuuO+tB+dJpstk=;
        b=HEKT0OaDe7wVp2IwPmhzg9oS8ASUNGE+l9sM6GGHumKXoFvztLhKcnEVebUveLk0lE
         ddKc0iy+VAZL/gJ/+f7zIa2P1Z+WXZxHxxuB9fDWExD3LUKHVFM50NgVxxiou+AI0T5A
         8Ond0kBE1Gbyptmyau6lVQk4kvxX0TooS1qkOnwxOvRKgnBxK/RVX+AGJe3u+7lWC3Xn
         63ox0czq78T1jQompfU6mCBzNTOvR+bR77CkQGS5x1k+W6EzFnbZPkXBybyd74hvg5jn
         8mkq8ZzYphYqQSDtI2zTISRY9cYM6OZ+GszrN9jUGUy3dLW/UuY0NJkpQudBJOk35Axo
         gHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=uTV1lJCzWFvRXETtO2mm+8BlPiNvkSuuO+tB+dJpstk=;
        b=Vvow2/xDWAL4BeBZf8XCGbRcHGfyDF5ssS1y9wJ8xFhajezFkPl1X62otBzad+rxyN
         oujadN0kttz32vBNFXZlHBdHv9mMuLdER03R+3ardMfhR2I9ICsSZVtunW4cONxARrLb
         GIxXqmgfGvbVXHcwaPOzPtJT/18OUSVLTWcOQYR4x6KJ3pGTKKGcNlAJrun47A8GxRDo
         gQguHCiGhJvSwG7REGBTUrRVXFYaasEukAYXDKFKVRie5NSrMrDWek70TSYVxiyDUnOj
         RaTrtzH+sas1hMit0RZzsWkgw8ULUZmLTqLYUBa69qM/MiaABo9apN5hsWOiGUmSXUXK
         ZOMw==
X-Gm-Message-State: APjAAAXQDZIEgkktkx1mShaNXckcZkwH9sFDuNCIGt776/Wcix6vc7eo
        LOpE61Fes8Erz19uAM5ktbxPaw==
X-Google-Smtp-Source: APXvYqxCUm6SxWWwGkCNKzk9zup/53mgmApuSF4MbnOGNYdFzDacNqMKt1Jgi61RPE/SKfD2UthTWA==
X-Received: by 2002:a92:3b52:: with SMTP id i79mr18330339ila.19.1571813363853;
        Tue, 22 Oct 2019 23:49:23 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id o25sm1577662ili.51.2019.10.22.23.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 23:49:23 -0700 (PDT)
Date:   Tue, 22 Oct 2019 23:49:17 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <anup@brainfault.org>
cc:     Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rkir@google.com" <rkir@google.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] RISC-V: defconfig: Enable Goldfish RTC driver
In-Reply-To: <CAAhSdy00_snfqstOg1KVookNm8kG9gW=S-7fugzv+awtk+HBmQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1910222348260.12442@viisi.sifive.com>
References: <20190925063706.56175-3-anup.patel@wdc.com> <mhng-edb410db-fdd1-46f6-84c3-ae3b843f7e3a@palmer-si-x1c4> <MN2PR04MB606160F5306A5F3C5D97FB788D900@MN2PR04MB6061.namprd04.prod.outlook.com> <alpine.DEB.2.21.9999.1910221213490.28831@viisi.sifive.com>
 <17db4a6244d09abf867daf2a6c10de6a5cd58c89.camel@wdc.com> <alpine.DEB.2.21.9999.1910221751500.25457@viisi.sifive.com> <CAAhSdy3KccuzC0pV6Jy_diLwkdgb=SdHBQnsSoGrgpu6g7TCQA@mail.gmail.com> <alpine.DEB.2.21.9999.1910222250490.5600@viisi.sifive.com>
 <CAAhSdy00_snfqstOg1KVookNm8kG9gW=S-7fugzv+awtk+HBmQ@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019, Anup Patel wrote:

> On Wed, Oct 23, 2019 at 11:30 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> > Is drivers/platform/goldfish/goldfish_pipe.c required for the Goldfish RTC
> > driver or not?
> 
> No, it's not required.
> 
> > If not, then the first patch that was sent isn't the right fix.  It would
> > be better to remove the Kbuild dependency between the code in
> > drivers/platform/goldfish and the Goldfish RTC.
> 
> The common GOLDFISH kconfig option is there to specify the
> common expectations of all GOLDFISH drivers from Linux ARCH
> support.

OK, then in that case the Goldfish RTC sounds reasonable to me.


- Paul
