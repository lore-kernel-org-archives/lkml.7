Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26302C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AA52089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrX1QYVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfGaMBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:01:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43730 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfGaMBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:01:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id r22so4283818pgk.10;
        Wed, 31 Jul 2019 05:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mxMz9DTYTl5hcQl/IOSK5bxeHDD9Zpp9rkD02EBfWBw=;
        b=GrX1QYVpWlLNEHLqvIochVMBQ25mLyaDxVFB38BIMIhEosrKIW5g62qKrFveRgl8BH
         jIs7yhi3evsr98nbAh8KC/ZG8UJL2G2a07+jsWOdu5/9IZ4uuUJzMjESX4AhuoUnftCD
         /EYxWQqZl/FYmqhSf4ZpOJX7eyqK9i7/tV+cub8fZ+3giqD+8ff216/MPh/qhxJGY5t1
         QWTfvMgsOi0viMgbtiGivYUyhZnwaNV/SOXV9EZ1f3EZc94i44RNTPkSSLCJRwwjjgcp
         PnwuI3kdNEm9TpqxG10rrJndTSF01wfA1IWwCLTeUxU2bo6Gd5hzZSys/Ww716Sn2hlk
         deDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mxMz9DTYTl5hcQl/IOSK5bxeHDD9Zpp9rkD02EBfWBw=;
        b=bi/lo2NnIjgkAVmTjMK7ddGAKgmcWCIsItq3Pd5IreBkjkboLjH5VjgQk59+OFDtBY
         L//AyTEcN3jHAf8h24fhIQDZbtgBx7dEoUkmYfYZcsxU1rQtRnjwTlyB5OjwLwp32mTk
         Yrqu1ch1b5OEdNlY4Q/c6KMFleW4pp4FYR4Hcp1qrNUtfFjS+Y+qAGERx3Pm/QpmJFt0
         c5ZpCdnHSAp8vIeKbZdWytFCauVlAOIQR0QZEdVPaqJMb6r/Pr6l7g+CITliwh1scMWx
         EZz//MBvdITwEMr+b+eEbN6ZNYsdwulpdB8o/iTDWtTqIFoEyczcSwDxo2lLXY1Wq/8r
         /qCw==
X-Gm-Message-State: APjAAAU0sjrCcFutl6t9C9C2nJC4pZTN2C6HoatCEx6DmtfbkqOSWs7j
        HpwcFchDtBfT6YgW/JU2wO54FM+0
X-Google-Smtp-Source: APXvYqytpW1TS1jHUuiARJFaYVzq69ivzNY29VEf4QqVcLOZ95jTtJnNq60Jnoc04kQbt+HqLVO/Kw==
X-Received: by 2002:a65:5082:: with SMTP id r2mr87193169pgp.170.1564574505034;
        Wed, 31 Jul 2019 05:01:45 -0700 (PDT)
Received: from ?IPv6:2402:f000:4:72:808::177e? ([2402:f000:4:72:808::177e])
        by smtp.gmail.com with ESMTPSA id c26sm72452537pfr.172.2019.07.31.05.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 05:01:44 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20190731161629.4a20a23d@canb.auug.org.au>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <a9c66184-15b9-cd11-60b7-5a644c0521b0@gmail.com>
Date:   Wed, 31 Jul 2019 20:01:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731161629.4a20a23d@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/7/31 14:16, Stephen Rothwell wrote:
> Hi all,
>
> After merging the akpm-current tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>
> fs/ocfs2/xattr.c:1493:13: warning: 'ocfs2_xa_add_entry' defined but not used [-Wunused-function]
>   static void ocfs2_xa_add_entry(struct ocfs2_xa_loc *loc, u32 name_hash)
>               ^~~~~~~~~~~~~~~~~~
>
> Introduced by commit
>
>    45d9aa3d263d ("fs: ocfs2: fix possible null-pointer dereferences in ocfs2_xa_prepare_entry()")
>

I look at the code again.
The function ocfs2_xa_add_entry() is never called when using this patch.
Thus, I think the definition of ocfs2_xa_add_entry() could be removed.
If it is okay, I can send a new patch (v3).


Best wishes,
Jia-Ju Bai
