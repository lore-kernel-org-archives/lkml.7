Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93914C072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 02:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617F1217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 02:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeD1Z+S9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfEVCHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 22:07:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33324 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfEVCHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 22:07:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so455181pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 19:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XjZv8VPZY5yPAJVnzsgKE93tbIf6Kof6QehNERCMUpk=;
        b=qeD1Z+S9sMyldLc0e+aThRlLF6yqkIOo93DnE2pVcJU94KsMO7MhNKx8mSOFJKxROY
         UwDTwt2OG/V3JEa3YqiiPCyeSUy+KtvcqGP7/k+1EHV2Rq2EvoiVvZ14A/DGlhTNo2qX
         3ExDvDLENmnwHWwpdMQ3GckBO4MB0xOCj3aXgjao2KZqjKs7PlYa6zcozWJ4EcYSWbDP
         Qt55kDO9gN0mV/oaWo3oci9uC6GAyqh+fcfglxH4oc8gGp5g4VnYwCC25mHlGl+u7rYj
         qQBoDrrBVR7/nkrhxSBh70FzO9CM5RmTWJnD6ObvlypDOr827SyEMS4y73EKK0GFWofS
         8Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XjZv8VPZY5yPAJVnzsgKE93tbIf6Kof6QehNERCMUpk=;
        b=izUoY8/TOZCbK+Ijo/nPEtzyhomBN7dK98Qa86u4a3p40I81JDxX7A8Qkm4+p5FQfI
         TeSQUmCtbUDxzlIu2n7sfRr7Glnhibc5Nav5sPUfViaoQmMvsQQ1jRBwLZRZBl/PrAFP
         L+NFE43Avhi9zflknPGniT2DgCa/ltSxlKYPmfj7WcGJDJHVztb6Gir88vvDrzmDFKJn
         W8ZkO5c+OvyyZrzaFXNOfg9jOpQyCejAnaKtKkQB34ydfff+fLvqibzaRi4I0BPGj0ZX
         fnvEQFVyKm6H94Hqd2724c7rO7y3WuPK/rPbKzV7nd32QuGe/QAqv4awLOkbEDJWXHwN
         qkpQ==
X-Gm-Message-State: APjAAAVBkgy/KqFREv//DBwjyweFWakPp3nNRlNm+fztXrtkBYrBhxfk
        DbHgCTw9SBQj/leUZXXiMzdJ8Z/6anE=
X-Google-Smtp-Source: APXvYqzfgLBunWyLsQElxtkwqOcLss9PkcnCTe4Jf2aIamDd3gse5p+E+Obiu1hU/CIygMErM98YgA==
X-Received: by 2002:a63:7146:: with SMTP id b6mr82676079pgn.426.1558490855602;
        Tue, 21 May 2019 19:07:35 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id y10sm33534653pff.4.2019.05.21.19.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 19:07:35 -0700 (PDT)
Date:   Wed, 22 May 2019 10:07:23 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initramfs: Fix a missing-check bug in init/initramfs.c
Message-ID: <20190522020723.GA5753@zhanggen-UX430UQ>
References: <20190522010455.GA4093@zhanggen-UX430UQ>
 <2c246472-bb1c-1063-1370-33da04af27d0@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c246472-bb1c-1063-1370-33da04af27d0@cn.fujitsu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 10:00:37AM +0800, Li Zhijian wrote:
> 
> On 5/22/19 09:04, Gen Zhang wrote:
> >In dir_add(), de and de->name are allocated by kmalloc() and kstrdup().
> >And de->name is dereferenced in the following codes. However, memory
> >allocation functions such as kmalloc() and kstrdup() may fail.
> >Dereferencing this de->name null pointer may cause the kernel go wrong.
> >Thus we should check this allocation.
> >Further, if kstrdup() returns NULL, we should free de and panic().
> >
> >Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> >
> >---
> >diff --git a/init/initramfs.c b/init/initramfs.c
> >index 178130f..dc8063f 100644
> >--- a/init/initramfs.c
> >+++ b/init/initramfs.c
> >@@ -125,6 +125,10 @@ static void __init dir_add(const char *name, time64_t mtime)
> >  		panic("can't allocate dir_entry buffer");
> >  	INIT_LIST_HEAD(&de->list);
> >  	de->name = kstrdup(name, GFP_KERNEL);
> >+	if (!de->name) {
> >+		kfree(de);
> >+		panic("can't allocate dir_entry name buffer");
> >+	}
> 
> Looks good
> 
> but the following place should be considered as well i think
> 342                                 vcollected = kstrdup(collected, GFP_KERNEL);
> 343                                 state = CopyFile;
> 
> 
> Thanks
> Zhijian
Thanks for your comments, Zhijian!
I thinks you are correct that vcollected should also be checked.
I will work on this patch and resubmit it.
Thank
Gen
