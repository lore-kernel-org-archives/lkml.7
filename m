Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A5CC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689172147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hMN6CoeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfD3Agy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 20:36:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45490 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfD3Agy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 20:36:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so6158741pfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 17:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=GbaCh6NhvaphvajOZaGIcMKIlJS94Qzf/VlSIykaLPU=;
        b=hMN6CoeYmgoCw44mrL758sSSkEbr6V6KKiWzQhocmqfTxNVGtMqcnR/RW5Ab++FnNa
         4liF+DSBZ95xJ8oIbBfRb1mHSNy+XsdXWvsLnmD/NMVU+tKIWb31EvHvtFucIoGnOwJ0
         4Cc+2gt9S95VOhgUgt4FG7VkKwY2DS6D+vwpVl7+oZfaDEjLBbWkwqncS0PtIQPj5r+w
         iGr0rd6ssbA7mbpfLhR4E+hTs15pcCklhXkjSQOMwf84TrhK9EE+WTwbLp/ohY8zXhZq
         YyFdKFByYNdmsx2ONAqhaoo6/bhfOvXj646nxuk4rgiEnmGJKeWG1AnQx5udDWyv58IR
         yOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=GbaCh6NhvaphvajOZaGIcMKIlJS94Qzf/VlSIykaLPU=;
        b=JAzI3hAfuDYQpvtZUI5tVw7mawn9vN8OKhTM6mLJ0MMksE24s4m4xNwbbdTTttbl0u
         Zey4tadu80Su4zlw06R8YFSgaInHBH8EyXinOVEIaAAhBfqw8KdDWsrI7UyiJeNFRQOh
         fasa61ZT4Pspr1j6/gUlnXBZIvfU5SgDGVYn/ujRyXLjDKHMGkopY5ixcsDgUziwBFZ4
         Cj6i49zH7eN66hY19gvEK5Nhf/P05IoljC/quCxMochd5rRNMK1Y8i0mbjpv49Sq+g52
         FcCHbd7ea7PNF4djoEUsCWm8miCLCQXM4ai8XBFgp3AvAWra5ypVFqZuFMVbJnPAXhLv
         HEyA==
X-Gm-Message-State: APjAAAVKl6Mlly7A8UTJl3JLhgFYpLf5NpwkcEEc3DPIol0RDBcRvTE0
        xbreKDanmcqk4E2zPYCA9x1BTw==
X-Google-Smtp-Source: APXvYqyjC+rvDd8hwITIhvgqtLGWf5npvZ8mvtRVBt1bZ8i9oVfiJjH+CuEapJKP7J0YkNx7T58e8w==
X-Received: by 2002:a63:b53:: with SMTP id a19mr19302204pgl.216.1556584613110;
        Mon, 29 Apr 2019 17:36:53 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id j5sm47436174pfe.15.2019.04.29.17.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 17:36:51 -0700 (PDT)
Date:   Mon, 29 Apr 2019 17:36:51 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 16:52:40 PDT (-0700)
Subject:     Re: [PATCH v3 1/3] RISC-V: Add RISC-V specific arch_match_cpu_phys_id
In-Reply-To: <20190424062100.GB3902@infradead.org>
CC:     atish.patra@wdc.com, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, dmitriy@oss-tech.org, anup@brainfault.org,
        johan@kernel.org, Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>, schwab@suse.de,
        linux-riscv@lists.infradead.org, tglx@linutronix.de
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-42e98065-6d8f-455c-97d9-0a2dfccc731a@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 23:21:00 PDT (-0700), Christoph Hellwig wrote:
>>  }
>> +
>> +bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
>> +{
>> +	return phys_id == cpuid_to_hartid_map(cpu);
>> +}
>>  /* Unsupported */
>
> Please keep an empty line after function bodys.
>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Oh, sorry, I missed this -- I just fixed up the patch and added your tag.
