Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3FEC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 14:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF901206A2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 14:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjbuSqAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfF2OFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 10:05:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34820 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfF2OFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 10:05:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id c27so1392286wrb.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JPFYVQWwGg49fkmrAI7foocwRAtkZJt9UyxT8KXUpe0=;
        b=qjbuSqAMWefNZE1/7mb5nTAQw9SYJoICPg3pdP4nqysB364eZp/hoQtWcovcNP8UeD
         yGpIix0yKrWmMbOGht4gwNMSy+7huPyCPfygCsgrNOLTy7u08cvop8a6BiHmK/SuZTSm
         XLCNgQ3C6AyvrR4EIXI3lwnPlOV3jNt+8ZXi63nLpR6zD1gYZOKVdx4DJqpCWFgkJHun
         Q31Hvp0s4Jdh+ZeuWE68Mdnwya3Ark91MsaP3D3pTCF/KBU2szn6KoM9HnOdp2uKdqZy
         FBJyNf1N9BQlp4cOuqhfiwTBp0vq4dRYejSDrXLd3DfC0X29xzIrdBnyVs2uQXN0JiIW
         ThCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JPFYVQWwGg49fkmrAI7foocwRAtkZJt9UyxT8KXUpe0=;
        b=PsAmILmQ9m2cenYQYz8ojcxtnN+R0qbR0zTDU5aPFaqjmlXsAKFhI1iMJttDSRxtWk
         KMFARlQGCEYb8ELSgXoBlqm19FeAF6zacXrHrNNoXfXhiFMGNh3ZBGMPO1UgLYTuDGNJ
         V0ZwYZzhBY4V19Prm/H5UZ/41qoSI2Ojph8QoK50mEB3ziEpLybIEMsVASzze0qa3LoA
         /T72v6DflwKD8NBWZTyeHsGdu/H+pqgNYzBfQZABRlZSKaIHh0ic9xeUPo70O9Zp3mIb
         pozZQ2/+HqEpc/sNWpGpvwr8qMJncXYVo7RdOg3f509nokEouTXNTe4O+xrwzcQPd2ys
         e8iw==
X-Gm-Message-State: APjAAAW+LrLpKWuvicwCAXOwPRgrasRacnJAayMdXRj6BwVWgWiGt9A3
        MSjb5R+gCIq6XZ4lBMra7g==
X-Google-Smtp-Source: APXvYqyPhfWWnCA4PpT263vwfxc2EgqtPb4vCs0Zyr8JDa2eNKvAYyttKg9BD+1UVrb+TOZ45QZ/Sw==
X-Received: by 2002:adf:fe4e:: with SMTP id m14mr12768468wrs.21.1561817151177;
        Sat, 29 Jun 2019 07:05:51 -0700 (PDT)
Received: from avx2 ([46.53.248.49])
        by smtp.gmail.com with ESMTPSA id k82sm4751686wma.15.2019.06.29.07.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 07:05:50 -0700 (PDT)
Date:   Sat, 29 Jun 2019 17:05:33 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, shakeelb@google.com,
        dave.hansen@intel.com, rientjes@google.com, mhocko@suse.com
Subject: Re: slub: don't panic for memcg kmem cache creation failure
Message-ID: <20190629140533.GA10164@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -       if (flags & SLAB_PANIC)
> -               panic("Cannot create slab %s size=%u realsize=%u order=%u offset=%u flags=%lx\n",
> -                     s->name, s->size, s->size,
> -                     oo_order(s->oo), s->offset, (unsigned long)flags);

This is wrong. Without SLAB_PANIC people will start to implement error
checking out of habit and add all slightly different error messages.
This simply increases text and rodata size.

If memcg kmem caches creation failure is OK, then SLAB_PANIC should not
be passed.

The fact that SLAB doesn't implement SLAB_PANIC is SLAB bug.
