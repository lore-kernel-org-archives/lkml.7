Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8318CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 07:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A063F20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 07:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="lOZ9swOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfJ3HIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 03:08:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37450 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfJ3HIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 03:08:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id v2so1405883lji.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 00:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YkfgFeV4FsqY1VHKqgXeZNImOvIVbyPpJ+xeXvIsYXA=;
        b=lOZ9swOkTxzq0Xy7OhmKpjX25Jx0xlgBUxBj5a6FSJlFEhL4Io9YbZZxHcmTkj5HM5
         T6g9ScBLH1q7B+b4qUfuSWipUL6goM/wPyO4g8bLnsQ5OOOs4fDzU2NGHu8xxfCFvSx8
         DLb4aHcs2bFD1zMZNMLCD1k28sLyzGgTQMsrosXCrzCT8JaO0dR0f4Yxn0/yGGk47a/J
         N3oovJgOsiCypPD9aW5VfGk5JqrHrKcaWXlV8bLDC2xXzdwLikiGIrfe6MmsQgriPkKK
         WeODFxLW8v5o8mSlGx6HAyGs6NEScGGSI+QGWS40isZ+lpYzEqHJHm1B//wIyyJYSgnh
         kfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YkfgFeV4FsqY1VHKqgXeZNImOvIVbyPpJ+xeXvIsYXA=;
        b=KAJ9UlqNQWkkhJ2Vn/C5Z7ixConfXsp8xai4XFaQCYlnweykCYrDNxhOO2ow04nzAw
         s6olIx2PRa3BMgw7omHfE+fHOZoceS9K/PmDi8Iqk4Yr9zel4rmpmxZaozJe4VInHnpV
         4XHwlGl7/i//cQhyHbpnDPOF6Q4rw1JGWTnUnrK1vdvhTIsGbVSkyYyzhqrARBc9y3FN
         EZ4OBY3uVnfKhx+aVBVfrhZbFRiC/CeLwJgrLA3/mI79L5LGS0EjutK/0EnPqtIGnAGH
         G4qPeRF3HtLed0pDvxDME7rROWMAw1QFWSL4i1iiPYI01r+cxyYQaJvTLjQaQ2GWKlAT
         OCSA==
X-Gm-Message-State: APjAAAXsPxuJKQxgaHw5mwsTu9TQX4GitY7yPaanCa2A0eAyeLGpnsYC
        +ahiDKk86ovVyvoqKqcZ6uN1mA==
X-Google-Smtp-Source: APXvYqysVS8kahgG2FSdDRKL/fz1eoa8EMMKPRm3Jh8/IaKIVk9RLkhHTfAGnTrRvreuq8KK4j48yA==
X-Received: by 2002:a2e:3919:: with SMTP id g25mr5379568lja.162.1572419297242;
        Wed, 30 Oct 2019 00:08:17 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m3sm741816lfl.0.2019.10.30.00.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 00:08:16 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D03661003C9; Wed, 30 Oct 2019 10:08:15 +0300 (+03)
Date:   Wed, 30 Oct 2019 10:08:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ville Syrjala <ville.syrjala@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org
Subject: Re: [PATCH] mm/khugepaged: Fix might_sleep() warn with
 CONFIG_HIGHPTE=y
Message-ID: <20191030070815.y4ggbbi5bd4wksbr@box>
References: <20191029140209.e70385637d3617ad43869f31@linux-foundation.org>
 <20191029212513.23566-1-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191029212513.23566-1-ville.syrjala@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 11:25:13PM +0200, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> I got some khugepaged spew on a 32bit x86:
> 
> [  217.490026] BUG: sleeping function called from invalid context at include/linux/mmu_notifier.h:346
> [  217.492826] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 25, name: khugepaged
> [  217.495589] INFO: lockdep is turned off.
> [  217.498371] CPU: 1 PID: 25 Comm: khugepaged Not tainted 5.4.0-rc5-elk+ #206
> [  217.501233] Hardware name: System manufacturer P5Q-EM/P5Q-EM, BIOS 2203    07/08/2009
> [  217.501697] Call Trace:
> [  217.501697]  dump_stack+0x66/0x8e
> [  217.501697]  ___might_sleep.cold.96+0x95/0xa6
> [  217.501697]  __might_sleep+0x2e/0x80
> [  217.501697]  collapse_huge_page.isra.51+0x5ac/0x1360
> [  217.501697]  ? __alloc_pages_nodemask+0xec/0xf80
> [  217.501697]  ? __alloc_pages_nodemask+0x191/0xf80
> [  217.501697]  ? trace_hardirqs_on+0x4a/0xf0
> [  217.501697]  khugepaged+0x9a9/0x20f0
> [  217.501697]  ? _raw_spin_unlock+0x21/0x30
> [  217.501697]  ? trace_hardirqs_on+0x4a/0xf0
> [  217.501697]  ? wait_woken+0xa0/0xa0
> [  217.501697]  kthread+0xf5/0x110
> [  217.501697]  ? collapse_pte_mapped_thp+0x3b0/0x3b0
> [  217.501697]  ? kthread_create_worker_on_cpu+0x20/0x20
> [  217.501697]  ret_from_fork+0x2e/0x38
> 
> Looks like it's due to CONFIG_HIGHPTE=y pte_offset_map()->kmap_atomic()
> vs. mmu_notifier_invalidate_range_start(). Let's do the naive approach
> and just reorder the two operations.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-mm@kvack.org
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
