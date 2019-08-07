Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0E0C32757
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D78D2229C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bpH/06Bn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbfHGQUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:20:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44668 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbfHGQUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:20:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so41514918plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 09:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=zdXpc4sHpuyR/XCLCaxASYs6IQPhe894MvifJxuUKDY=;
        b=bpH/06BnzUA9+ZqA6qzS/B4qU+dimFzNTr0RlRGc0Fq5Yjf8acu9/+WDDP8WEknq/1
         7d8FDcvJxbWPzS9GkQJxNtL9hZGohCKzlYwAZ6PABsqGCJtOsIhkzzEjx8IqVoSBMj1s
         Iq7b1szOAHm4fqKd/MQBGj0vymGMzBQwYJECL66NjsHIo2sutCc+yeYAcyR7OOCzVaPR
         BW20IA1YX/K/ZokGqK+Y2AF6L8fpj4PyQBsNa1OoNEpKDi0E/cOV+/BhZ+i2LSbp9xd4
         RhfXZ/ZAKiwJBUaj1ZHqRGyiwXS+6YfGLioEg1fgRAypDF5N2KAMILLu8zDMiKoKfWnC
         7w8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=zdXpc4sHpuyR/XCLCaxASYs6IQPhe894MvifJxuUKDY=;
        b=aWFLuCPWwA2BR9x3zELv9Fpmrbum5Enj7gmdAomaleXoxRcAJmDAumBRHnfkb/4q7W
         QQsWevmsvLY6spqOnuoKRmWhSP3kI3d30WQUxJ/KTa25uw5I3JNRTneI0BZglo06RlGX
         Qam0hMY3TkQJSmC11OCYUyiY6nwHUVqlMm+9gCQonu5SGA/Udido79WxBs4CI2f2rxVC
         NC3iEHoQLn5j7rUD3fjemmskqSq6m7ObHPO+EJDZUt+fjMeAzEW+aC4zxSx1b5XWE25K
         PgZnX71yuZAP8WySOfcazX2VQVI5SB6G3Jcdy+MjVEgAXbysfIsIEdKji6jt0u0dm5Qo
         2JHA==
X-Gm-Message-State: APjAAAVX4HaqG/oNOHMVRlPtZMb/Z3Bg0QiGA2ZtppyEQgqx89gIecFE
        5ANMEW/Ul/5CdNJGP5r3oGSlJ6+8dyy+8Q==
X-Google-Smtp-Source: APXvYqyw1rQHbTCAjQdygvE0aT61eyJ0znZpiutYEO6zwfEI6liF+OCkSgzHqrTYT1bXmMChnjd6Kw==
X-Received: by 2002:a62:f202:: with SMTP id m2mr10528831pfh.6.1565194818021;
        Wed, 07 Aug 2019 09:20:18 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id g66sm90024297pfb.44.2019.08.07.09.20.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 09:20:17 -0700 (PDT)
Date:   Wed, 07 Aug 2019 09:20:17 -0700 (PDT)
X-Google-Original-Date: Wed, 07 Aug 2019 09:13:52 PDT (-0700)
Subject:     Re: [PATCH] riscv: kbuild: add virtual memory system selection
In-Reply-To: <20190807151229.GA16432@infradead.org>
CC:     alex@ghiti.fr, Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-5bc65289-4805-46a0-aa16-404b2be270fd@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Aug 2019 08:12:30 PDT (-0700), Christoph Hellwig wrote:
> On Wed, Aug 07, 2019 at 09:04:40AM +0200, Alexandre Ghiti wrote:
>> I took a look at how x86 deals with 5-level page table: it allows to handle
>> 5-level and 4-level at runtime by folding the last page table level (cf
>> Documentation/x86/x86_64/5level-paging.rst). So we might want to be able to
>> do the same and deal with that at runtime.
>
> Yes, following the X86_5LEVEL model is the right thing.

I poked around a bit with this last night, but our paging implemention is super
ugly so it'd be better to clean all that up first.  No idea when I'll have time
to do so...
