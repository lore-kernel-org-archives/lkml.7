Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD5DC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3B22343B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BmtM9QT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfHaCEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 22:04:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44980 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfHaCEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 22:04:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so4121611plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 19:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zKp+R2++ZW7vYFmoNUR8A5wlNJqeNnULOZAUz1UqSlk=;
        b=BmtM9QT7x3OHnPhXRJ7wL/Pd4ecqOVF5NirfoHQHlQx/Elav8lNEhefX/wm8nIGJRi
         fV4EdJuRGzap2GHd+vD/ARdNuPXtQSUKYi/rMRjD8I4RwNXKBIitbpt/2IA5ZRV+Ko9K
         8iPQIPuFR4JxrYR9/L2cwkJ9bQSVdpLVG9qkf1tPfnMQWaEzLufOIu1hRoTNRD9S+2ZS
         uvu3TBGPAbSZx5reXnBSRICqXr5+WNGAhxCBAU0H4RT4l3En9iKHcZ50UFDqS5hwW96v
         WqIz5qrFt+cgvprBrRiwSnd3/WdH6T8JspMhJK4h/zEsT+dpEJywhukT0F+Y5l2We/00
         beXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zKp+R2++ZW7vYFmoNUR8A5wlNJqeNnULOZAUz1UqSlk=;
        b=MAYVG7iCbsi7R2qK6MNPZXZgU75wFCQNQ1ITZbNMOGq4YPhjlda82ZOhro4K6HjLYE
         vV+xymgLN8qOUMubiOksaPJ8yUw+zTNX80eYMUDmNFa1IdgqsnUQHgU75j+sx/U6ui8P
         8nBvKyrbtzCkMQ3PKTcYjhWxnKOjnulZDGI9AeoMe+dKIF2KXTR7aqPVXsg5CPAPly0+
         /dBNJf0hHfPQzUVdcABe+vsQrLbW/gxVq2JSGqTBsTElpR3bGuwePqawrhR8c/QcSV9F
         AX+igmzvY9g2J3ebDLSf5HrkCFRg9R4uNHR07z1wFl2DKwmJ/ApRGaUxmmiBDch1Ez1F
         Xd+Q==
X-Gm-Message-State: APjAAAVnb0FdCNLqsxm9073B0MyprVBreBC3TrkqUx/ur2n9CoprwOV3
        8PXnAYuAv4TQQg4ZWCPpmF07zA==
X-Google-Smtp-Source: APXvYqyomcceqFTqZJE7UZzkXFxj6XuIpOYDoJCJqoosAJW7N7akdJMUvYpMH+vTEGWMH6pjESCUgQ==
X-Received: by 2002:a17:902:fa5:: with SMTP id 34mr19000900plz.285.1567217071865;
        Fri, 30 Aug 2019 19:04:31 -0700 (PDT)
Received: from localhost ([216.9.110.7])
        by smtp.gmail.com with ESMTPSA id y13sm11526177pfb.48.2019.08.30.19.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 19:04:30 -0700 (PDT)
Date:   Fri, 30 Aug 2019 19:04:29 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Charles Papon <charles.papon.90@gmail.com>
cc:     Christoph Hellwig <hch@infradead.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: kbuild: drop CONFIG_RISCV_ISA_C
In-Reply-To: <CAMabmM+YX3L-J1GCvDaC9H66YMArfs6PuKCsE_dNMBtApOxZig@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1908301859230.16731@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1908061929230.19468@viisi.sifive.com> <CAEUhbmVTM2OUnX-gnBZw5oqU+1MwdYkErrOnA3NGJKh5gxULng@mail.gmail.com> <CAMabmMJ3beMcs38Boe11qcsQvqY+9u=2OqA0vCSKdL=n-cK9GQ@mail.gmail.com> <20190812150348.GH26897@infradead.org>
 <CAMabmM+YX3L-J1GCvDaC9H66YMArfs6PuKCsE_dNMBtApOxZig@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On Tue, 13 Aug 2019, Charles Papon wrote:

> > Because it it the unix platform baseline as stated in the patch.
> I know that, but i'm looking for arguments why RVC could't be kept as
> an option, especialy it is only an optimisation option without
> behavioral/code changes.
> 
> That baseline make sense for heavy linux distributions, where you
> expect everybody to compile with a baseline set of ISA extentions, to
> make binary exchanges easier.
> But for smaller systems, i do not see advantages having RVC forced.

OK - I agree with you.

Still, I think it would be good if we made this option depend on other 
more general kernel configuration parameters for smaller systems.  Will 
think about this further.

Thanks for commenting on this, and am looking forward to adding a VexRiscv 
system to our kernel tests -


- Paul
