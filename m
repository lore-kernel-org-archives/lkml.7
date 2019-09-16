Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF7DC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FF4214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LZrKxyGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfIPQMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:12:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41523 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389659AbfIPQMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 12:12:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so261365pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=AdVo7LJwpXxGdiKukHrvBHzKH1YWUhQ/gLti6NVZFSQ=;
        b=LZrKxyGH0/HV9YHUDl83G8YKQ+qL7o8gEtUrt64wIBPuQYhehi42JAaBkF1XZo6hK/
         wPRAk3O5gQ1lAV9maO77+23dkf09QyN/TSo8AQcATjF1N68GfcnTlGZepjG6oFz4yqR+
         ir67CrtZ5eUI23gYDOWL0CTWGeGEc/cE1abVKcbF/rRvdclNGrTYg0deZF3ZzcxBuSpz
         wR/uY0gWUfU3z0wANf7kGst5R2CrLh942DOoJdbhrYuBH1GwSpufkqMKKZgF9LG4yRTh
         354cKGjIHnbF31heviiPGw5Lkc4GDW/DstalSCbb8JC9m+XX/hXPsoJyfScsSVLKSOoB
         bFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=AdVo7LJwpXxGdiKukHrvBHzKH1YWUhQ/gLti6NVZFSQ=;
        b=cnr+TfB4BKRuEv1CrpLTHy51vahXbMeDwmdFyKbZCAmFU52xzOk+5HIwO2MuxvlvmH
         Oaibs2LFNJTWXHMnZd6A8sY9CKTmX/KDILDhESodIxZQ/I1joMR5FA6XZqfYeZyXiWXj
         9FPZ9Hrk0BfRX/zI8Vqh9OFsrvna17bbwO1HX/T7NSyOw+60SnSKrxRxuO3J3Zs8oi71
         iSHln+/bf45nTDEh7euaHSIwpboNMo2HNNn7iHArDcIkoJV5DcKYcREgSmDIyyWzDw4T
         2NxJ1zrmSGipjHfBfEpziM+4Yun80uhAQG1+AkOFlMmkBh9JPhJbFRzOsot1rCTiLpc/
         aqIQ==
X-Gm-Message-State: APjAAAWEmV1MVfMogHQRnAl1LTNOKtZuXnVyEWgHUVv+6itIC+aop9xz
        YZ+dPbOeZ8ZBfMBRLAs5e6hYaw==
X-Google-Smtp-Source: APXvYqy82tkkqyfVTz7Lzc3fjlQBwNpIeUPh/f1EWx9Rgi2zxlU7Xv8ESFqJq6gFk3zAewd/MJn57g==
X-Received: by 2002:a17:90a:cc13:: with SMTP id b19mr483247pju.112.1568650334279;
        Mon, 16 Sep 2019 09:12:14 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id c64sm53631983pfc.19.2019.09.16.09.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 09:12:12 -0700 (PDT)
Date:   Mon, 16 Sep 2019 09:12:12 -0700 (PDT)
X-Google-Original-Date: Mon, 16 Sep 2019 08:35:07 PDT (-0700)
Subject:     Re: [RFC PATCH 0/2] Add support for SBI version to 0.2
In-Reply-To: <20190916065446.GA6566@infradead.org>
CC:     aou@eecs.berkeley.edu, alankao@andestech.com,
        alexios.zavras@intel.com, anup@brainfault.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>, gary@garyguo.net,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org, tglx@linutronix.de
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-d7823725-b118-4588-bcec-e85354e52283@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2019 23:54:46 PDT (-0700), Christoph Hellwig wrote:
> On Fri, Sep 13, 2019 at 08:54:27AM -0700, Palmer Dabbelt wrote:
>> On Tue, Sep 3, 2019 at 12:38 AM hch@infradead.org <hch@infradead.org> wrote:
>> 
>> > On Fri, Aug 30, 2019 at 11:13:25PM +0000, Atish Patra wrote:
>> > > If I understood you clearly, you want to call it legacy in the spec and
>> > > just say v0.1 extensions.
>> > > 
>> > > The whole idea of marking them as legacy extensions to indicate that it
>> > > would be obsolete in the future.
>> > > 
>> > > But I am not too worried about the semantics here. So I am fine with
>> > > just changing the text to v0.1 if that avoids confusion.
>> >
>> > So my main problems is that we are lumping all the "legacy" extensions
>> > together.  While some of them are simply a bad idea and shouldn't
>> > really be implemented for anything new ever, others like the sfence.vma
>> > and ipi ones are needed until we have hardware support to avoid them
>> > and possibly forever for virtualization.
>> >
>> > So either we use different markers of legacy for them, or we at least
>> > define new extensions that replace them at the same time.  What I
>> > want to avoid is the possibіly of an implementation using the really
>> > legacy bits and new extensions at the same time.
>> >
>> 
>> Nominally we've got to replace these as well because we didn't include
>> the length of the hart mask. 
>
> Well, let's do that as part of definining the first real post-0.1
> SBI then, and don't bother defining the old ones as legacy at all.
>
> Just two different specs that don't interact except that we reserve
> extension space in the new one for the old one so that one SBI spec
> can implement both.

Makes sense.  We're getting finish with this "just go write everything down" 
exercise, so we can start actually doing things now :).
