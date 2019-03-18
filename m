Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85A1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DA320863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nw5HVSyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfCRQM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:12:58 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51596 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfCRQM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:12:57 -0400
Received: by mail-it1-f195.google.com with SMTP id e24so21327876itl.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IraHUDTEtuXM/Ec1wSzEQgIe4yar1F8UWczeCKwsQg4=;
        b=nw5HVSyWNFxDeDlw6HKZJe0Npjv72G/WEgGt4HElzn8bUnoYiTtHLwzuArWkMoGNht
         jeAnwGk8UmUyxwO3kLlz15QsEAHVyG/VUvU2LWZNvLj3GZUUAF4GEfnlc4s53vVGnzdu
         i8oqwb6C8Xw8VYMfuJ15vjeqoSX8fuvueIb/YvBmBefM7Yc6jiGlpLwnjh2wPWB9sTy9
         Vv95Vig58teA3BwjOFtP7m7oB3jObTW+lggIakvo1qIzL9cvbQtT7SuyW8/Y0NHsipur
         fCepMQjNkDEM86BpnL7wkyjrYHtEfSasDPCL8QZhxyv8ERk1HzEB+ayG9J9MJA72HzZE
         yDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IraHUDTEtuXM/Ec1wSzEQgIe4yar1F8UWczeCKwsQg4=;
        b=laEbhv/MKjcvQamBxL0eiZ1qjeGvvImqFW+2NF1v+jY+dXIoYFWKfXpUOXjA0brhbi
         /ra/gLBvuMK1KaAGvBndn0vXGIYKJxy7A23kpXSrgVuqeEbmGAQ7xtzrGAWRZCGXNhxr
         7i5A/mm5QV+dXNzuUvq6zMj6LvrJG1VJoQzeAJNqJccAItqsZuZgmZLAk/L1jo1kXLRO
         Uy9kVl69ADbp8dALLWGF8nH2kBD91NrFvZ/j+EODDRgbJSM/4P7iuLvLHUhv/w78or6S
         0E5N6nNpLSnnOqAzw9JgmtRTrPNmho/5/hbDPRq+IiUBQRQu39ruZvMnRSfvAVCGlROz
         UGBg==
X-Gm-Message-State: APjAAAV+LFMgUAKQFVHRQAFsknIa9MQWlQvymmTGpMy9wA4Mx/Y3raKK
        wW5Yp5UEbIdCj9N49apyhO45Pg==
X-Google-Smtp-Source: APXvYqz3CBWVgcMAaq2JevnJzs33yhBPnw5bqm8+2q0HxzbNa+r16m3Z5NvkY60J1SsIEqLThJtmAQ==
X-Received: by 2002:a02:8c3:: with SMTP id 186mr11964145jac.69.1552925576491;
        Mon, 18 Mar 2019 09:12:56 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id a77sm311450itc.5.2019.03.18.09.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 09:12:55 -0700 (PDT)
Date:   Mon, 18 Mar 2019 09:12:55 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Mike Rapoport <rppt@linux.ibm.com>
cc:     Anup Patel <anup@brainfault.org>, Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] RISC-V: Allow booting kernel from any 4KB aligned
 address
In-Reply-To: <20190318071829.GF21385@rapoport-lnx>
Message-ID: <alpine.DEB.2.21.9999.1903180906560.25529@viisi.sifive.com>
References: <20190312220752.128141-1-anup.patel@wdc.com> <20190312220752.128141-4-anup.patel@wdc.com> <20190313183121.GB28630@rapoport-lnx> <CAAhSdy1mrV2CakS0cfOY8F1B7uH_yXjO3W-CiMUcYonkRnVbeQ@mail.gmail.com> <20190314065311.GC24380@rapoport-lnx>
 <CAAhSdy2uEgyvs=5NdoZ3H208qeDGJ9OrTOeaz6HQ+1va+R3dUA@mail.gmail.com> <20190315155828.GB920@rapoport-lnx> <CAAhSdy0HoTTccyy203Y9m3kdAjCOzjjMdrb670huU71pjOMw4A@mail.gmail.com> <CAAhSdy0D6JpySExCG7ziSSDmQ_88=paiMwjjXTTR1gbKCEOs3g@mail.gmail.com>
 <20190318071829.GF21385@rapoport-lnx>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019, Mike Rapoport wrote:

> On Sat, Mar 16, 2019 at 04:55:30AM +0530, Anup Patel wrote:
> 
> > We started exploring ways to re-claim memory below kernel because
> > we are trying to get Linux working on Kendryte K210 board
> > (https://kendryte.com/). This board has dual-core 64bit RISC-V but it
> > only has 8MB RAM.
> 
> Huh, 8MB of RAM is tough...
> 
> It is possible to use the memory below the kernel, e.g x86-64 does that.
> But it is definitely a separate change and with such RAM diet using 4K
> pages seems unavoidable.
> 
> I still have concern about using 4K pages whenever the load address is not
> 2M (4M) aligned. People tend to not pay enough attention to such details
> and they would load the kernel at an arbitrary address and get the
> performance hit.
> 
> I think the default should remain as is and the ability to map the kernel
> with 4K pages (and use 4K aligned load address) should be a Kconfig option.

Agreed.  That Kconfig parameter should also be default-off.
  
Only a small number of people will try to run RISC-V Linux on a Kendryte 
board.  That niche use-case shouldn't impact the much larger group of 
people who will run Linux on more reasonably-sized systems.  No one should 
need to ask people to report their kernel load address whenever someone
reports a performance regression.


- Paul
