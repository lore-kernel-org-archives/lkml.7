Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D3EC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE7120717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STrLaDSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfDYWB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:01:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35417 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730893AbfDYWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 18:01:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id j20so952572lfh.2;
        Thu, 25 Apr 2019 15:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RCm/SsERIu5HE9v6F9X9JLKKd3B3OYA0dhgGVRMKun0=;
        b=STrLaDSEjlNf1gehRI44rC8t9dNR+UofnOwrDv8nbs5WjN7usAS0IXkQHZ2CLb1VAA
         X6poZ7Xfvex1g8aNsRUDToc8bv+Lx6mV2qhZVRTZPvmuP3INJfxshXfrQvHsAGjsKVp9
         yIrqccjVmaYD9KrC91aQboB4ELxAd7PwYanhNiz6xNSXe2nNnICxL8ep1i/6BQnzS6iH
         zqwFcd3vWWzVz9Q3Dlp+GdrfDbYbewqOFTZ1gChv7Ko4VHvpfhrp3dNck6MvDbf534us
         u3DW2Yqb5PiAYm6kkgodvqhjSeZaXZgHCVqZmPurxsuBPOTBLZFn7I3xL+Eflg+2EHMs
         +0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RCm/SsERIu5HE9v6F9X9JLKKd3B3OYA0dhgGVRMKun0=;
        b=A6pG+VUO/zE+YTdgkaJHhd3ORXHcmljMPRaBP9IpGAILKxsthxcwtLCm9hASQT7ToH
         3kVZBL6m19RgajmcA0gjGcotmT3Gzz1OBmB3fRnWrHMvS/A9F4AB9+kAtTu4g7fci/Kx
         2Px81m5mD+ZcqY6X2lndjt334VheQzt3sewTjRL/IF8+XSltLfSjoPNHqtX8LqRNRXNs
         mVCmo81I7DiFFriQKlc5YbhWpiNMDUuyvQW5YuVyC5ahuq786J4M9hxGDNCRyIC4gJeQ
         ZtbBvpCE87+pJ4DIpJEABU9hugQRtvIqL+3IXl3U8gkF9UtaJWcyeVR2J51kdBF1edOK
         wK5w==
X-Gm-Message-State: APjAAAVYYYjWpCGZfy1lsbd8fI1HZAFJ5caG2b0o78g5q0fwSvbBF5o+
        xVe8Y3fdEDdKY1mM8gOPqA==
X-Google-Smtp-Source: APXvYqw961+c/qiDEfovvogbQq9+/6Ylcmxv0G3tsLViMsOdoh3RelgfDrwKZxZHDpWd0zT2pzbKMQ==
X-Received: by 2002:ac2:592b:: with SMTP id v11mr22567622lfi.85.1556229715155;
        Thu, 25 Apr 2019 15:01:55 -0700 (PDT)
Received: from avx2 ([46.53.240.140])
        by smtp.gmail.com with ESMTPSA id f25sm5220348lfc.46.2019.04.25.15.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 15:01:54 -0700 (PDT)
Date:   Fri, 26 Apr 2019 01:01:51 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Sandeep Patil <sspatil@android.com>,
        Rafael Aquini <aquini@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc: add VmTaskSize field to /proc/$$/status
Message-ID: <20190425220151.GA27445@avx2>
References: <1556225867-458-1-git-send-email-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1556225867-458-1-git-send-email-jsavitz@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 04:57:47PM -0400, Joel Savitz wrote:
> Currently, there is no fast mechanism to get the virtual memory size of
> the current process from userspace.

> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -74,7 +74,10 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>  	seq_put_decimal_ull_width(m,
>  		    " kB\nVmPTE:\t", mm_pgtables_bytes(mm) >> 10, 8);
>  	SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
> -	seq_puts(m, " kB\n");
> +	SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
> +	seq_put_decimal_ull_width(m,
> +		    " kB\nVmTaskSize:\t", TASK_SIZE >> 10, 8);
> +	seq_puts(m, " kB\n");

TASK_SIZE accesses "current", while this function accesses any ->mm.

Can you turn this into prctl(2) aka "current" refugee camp?
