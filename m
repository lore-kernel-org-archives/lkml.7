Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930B1C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A9420665
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439784AbfIWNgQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:36:16 -0400
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25802 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439687AbfIWNgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:36:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569245766; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=ZC3gdLc+3mh0WiUrzn/M+msLuKISRLHC/6RbdAkfNtFYWpBON2Epss8XmJFBm1izJcm+V0eA3q5twRGHFDG9CFco9+VndDqETI47eor8iHRbZfQmsf6bg8aryTQ3Aw3ZqoU40rslb/EIHpmGhX9vr/mfv9+bbYTep13Fw4qTAV0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1569245766; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=Or9lhSPRldOrRHgxvmXgv/CvuF7iRY43maV/E0M3pbg=; 
        b=e6vg/8GmohMkNShW5u/OyQ4D42EWXwXfHakRZL7WE7EUGZe29mfP8sYsGB0NGtycR96udyNq4fB4NLnhOwagqBFWKtiWjBP7xOTdpNuE3QcfxSe08Cv5zcI5wuyG+35jfCQJUH7yv/uJzvJMzIA5v/g5RGOakrdt9MZBnqE+jvE=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1569245764007604.909783495709; Mon, 23 Sep 2019 21:36:04 +0800 (CST)
Received: from  [113.116.51.134] by mail.zoho.com.cn
        with HTTP;Mon, 23 Sep 2019 21:36:04 +0800 (CST)
Date:   Mon, 23 Sep 2019 21:36:04 +0800
From:   admin <cgxu519@zoho.com.cn>
Reply-To: cgxu519@zoho.com.cn
To:     "Jan Kara" <jack@suse.cz>
Cc:     "Jan Kara" <jack@suse.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <16d5e5619a4.eae7877614758.1000116132119001499@zoho.com.cn>
In-Reply-To: <20190923100259.GD20367@quack2.suse.cz>
References: <20190921015628.54335-1-cgxu519@zoho.com.cn> <20190923100259.GD20367@quack2.suse.cz>
Subject: Re: [PATCH] quota: code cleanup for hash bits calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Priority: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 ---- 在 星期一, 2019-09-23 18:02:53 Jan Kara <jack@suse.cz> 撰写 ----
 > On Sat 21-09-19 09:56:28, Chengguang Xu wrote:
 > > Code cleanup for hash bits calculation by
 > > calling rounddown_pow_of_two() and ilog2()
 > > 
 > > Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
 > 
 > Thanks for the patch! One comment below:
 > 
 > > diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
 > > index 6e826b454082..679dd3b5db70 100644
 > > --- a/fs/quota/dquot.c
 > > +++ b/fs/quota/dquot.c
 > > @@ -2983,13 +2983,9 @@ static int __init dquot_init(void)
 > >  
 > >      /* Find power-of-two hlist_heads which can fit into allocation */
 > >      nr_hash = (1UL << order) * PAGE_SIZE / sizeof(struct hlist_head);
 > > -    dq_hash_bits = 0;
 > > -    do {
 > > -        dq_hash_bits++;
 > > -    } while (nr_hash >> dq_hash_bits);
 > > -    dq_hash_bits--;
 > > +    nr_hash = rounddown_pow_of_two(nr_hash);
 > > +    dq_hash_bits = ilog2(nr_hash);
 > >  
 > > -    nr_hash = 1UL << dq_hash_bits;
 > 
 > Why not just:
 >     dq_hash_bits = ilog2(nr_hash);
 >     nr_hash = 1UL << dq_hash_bits;
 > 
 > That way we need to compute fls() only once...
 
Yeah, you are right, I'll update in v2.

Thanks,
Chengguang

