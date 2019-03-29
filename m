Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AFAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A2B2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="h3fWBhxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfC2HI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:08:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43817 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbfC2HI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:08:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id z9so748865pgu.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 00:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=gfPi45QJJqhIIedzCy1HlV3AEmusPO9AnxU7G0DFItg=;
        b=h3fWBhxu4bWiy4yWklLvntlw4Mqi6SOUlJDQEI0d12m5cSYthJOFXxVrmus6jlRhhG
         PQh07+fVVy2bnmg5jKuL/KCjkwBK7wuuVKkItkGqyf9a7iZjjbKu7fBq4FGz0I+4sQSX
         +zsN/anlq2Vx4KntOjJC5sCfvqO74BOG47yFlggOukLekSJVZBL6hIQPUBp8WtcvvNDR
         +9DrNMTqEAftw25oeB9Hj55obvEwgbGycN5YptRiNXZpqQmZ+FHYH0zVa8VAPOsDPEL0
         rQz2WKXp67EgN8/Ini0msGOJcYKMIkF3T5w2UN/LITONwgBWuInIkFG1zZ9X6FqDJAYL
         efYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=gfPi45QJJqhIIedzCy1HlV3AEmusPO9AnxU7G0DFItg=;
        b=IfJURWByAlWagXnyTPAuZiqfx+/O44YefV7LA1hQ4KcrFbzz8smWAD7YzTbl168rU0
         p5upHLMTmTGlK730Zmm7tZvOiwcYYiko/qApi7MOxZJ3m+nPXjS11GnUyPJxGn4p0KH7
         PM0FMWWO1AL615N6GtFHaTmM+A8vPSsTDEImY6HjPLBAIhTdNnRt2jUR9wdna1BQfola
         7kX7PLMiYyUdS2zogCXvLrTUZKTSrdK/tUxzoKGQF341a5CUqG2RF6/SVkvY7pt18Y1a
         cNuOFq4dATgSiHqcNeJgHu+O5xm7oaj2SdVa/EVb2u5qlkv7NGVSZ2uvaKe1Cpw/J8Jl
         CVMQ==
X-Gm-Message-State: APjAAAVoJlpuXZ3rkeCutx1kMcFD6Hc+2jAtXzG0jc+pjGh2KkBUcwYH
        +vm7FmwR/FRmqgHEEXv4G8y2og==
X-Google-Smtp-Source: APXvYqyLjpVx2ol8AiHQuAtuxjQyU1nSiPHyDLXOeKhkW7sV6ELDQ2W3QmY62I2gspLZWnDZbgCZCw==
X-Received: by 2002:aa7:83ce:: with SMTP id j14mr17881639pfn.57.1553843308440;
        Fri, 29 Mar 2019 00:08:28 -0700 (PDT)
Received: from localhost ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id i10sm1421927pgs.26.2019.03.29.00.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 00:08:27 -0700 (PDT)
Date:   Fri, 29 Mar 2019 00:08:27 -0700 (PDT)
X-Google-Original-Date: Fri, 29 Mar 2019 00:08:19 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Fix FIXMAP_TOP to avoid overlap with VMALLOC area
In-Reply-To: <CAAhSdy2pqVS7LPfiaQzw90=kvaJDL63KbMXEiqHg_Raa_LiNxw@mail.gmail.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, rppt@linux.ibm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-e96d098b-3a74-4d5d-86f8-f46f2e81e5e2@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 23:50:09 PDT (-0700), anup@brainfault.org wrote:
> Hi Palmer,
>
> On Fri, Mar 29, 2019 at 11:48 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Fri, 22 Mar 2019 06:25:09 PDT (-0700), Christoph Hellwig wrote:
>> > Looks good,
>> >
>> > Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> Thanks.  I've added this to my fixes list for the next RC.
>
> I have another RC fix as well:
>
> "[PATCH v4] RISC-V: Always compile mm/init.c with cmodel=medany and notrace "
>
> https://patchwork.kernel.org/patch/10870605/

That one is already in:

    https://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git/log/?h=for-linus

I just didn't have time to get an actual PR together for the RC this week 
because I didn't get a chance to properly test everything.
