Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98409C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B93206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDBAVMTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfFEPzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:55:14 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:35696 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfFEPzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:55:14 -0400
Received: by mail-pf1-f173.google.com with SMTP id d126so15098726pfd.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 08:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2DfKoTbUkHhuP2+XX+gOP/GXMo98uk4f8Hq+Sd8x/uU=;
        b=HDBAVMTypXAZfR0duFmc4K1/93WlRwCVC+qISQ4GY2eJDWVecH5SDn/57rnesLcZRd
         Kqg4hHsMQ3VWgqL7eKCXp1f6Akskuui4UhGUmL9tRGFdrc25dsbksl+JTm2B9lOesyAZ
         mc0UmHCtbrTRjiGsHNbLd7G04dYKCZ0VfBxdUcUjAeDB4WxhGWhvdxdF2shqaZSXZ/B6
         T3+GcnMHZvdxzpXxVR330vE5tpbSk4bNXFlPssK/g+tlmA1+itYttxcOQVxVPk4NOEXh
         PQF8Auo4KoPHyHQFTNRt840Hu6I6IhGjHYNzi53ce+MZPmvKE94Vt0mIYhDwBQUdbw3V
         0UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2DfKoTbUkHhuP2+XX+gOP/GXMo98uk4f8Hq+Sd8x/uU=;
        b=DKOa1bzmZjS4BEFFOQRVHvHkbch7woNeJSyYKQLjUTVcnXGbvqL1KNfU0AgF9GA3Vw
         W01t8119ZhyL95xaBDgghf7U7RcZrYEQgOox+dAMAY7n4M+WE1ixwLgJZs2F1teHlXe3
         1gnB2u4fCgtQ0cd/wXURQkG6pus6iN0Q4sPKGGCsOk/FJjOr8Q9ZZPH5RjiJxjuxqDBt
         9bMLLui3vmhkdR14HGti/p7QVFLVz8MH5xW3b7ItOukOZLG+bUrMKENbEHvkEN5sWVUO
         S5J5aRmWbENNdGz5XVC2JYX9WwKU2fkv9SG04ZTk+PV6lar4C2xxV4rPiT6NrwsL2d8j
         fkSg==
X-Gm-Message-State: APjAAAW6q5Z01lJO4X3OZ7CcZmrg9GmK0dvejvjnHduOnOOp/lXLVMqU
        fvjJjZpxPaYwQBJhc2EM+8k=
X-Google-Smtp-Source: APXvYqxpR5cEgDtmltAvYZ9AqYKidTDaDzzZM1TzdDM3zyq2rPE0LI3y59r5zJCpopq1OyFELGS5xw==
X-Received: by 2002:a17:90a:338e:: with SMTP id n14mr43932679pjb.35.1559750113484;
        Wed, 05 Jun 2019 08:55:13 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([2401:4900:2714:c5a9:f4d2:57f9:5d08:5667])
        by smtp.gmail.com with ESMTPSA id 26sm4625351pfi.147.2019.06.05.08.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 08:55:12 -0700 (PDT)
Date:   Wed, 5 Jun 2019 21:25:01 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, rientjes@google.com,
        khalid.aziz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove VM_BUG_ON in __alloc_pages_node
Message-ID: <20190605155501.GA5786@bharath12345-Inspiron-5559>
References: <20190605060229.GA9468@bharath12345-Inspiron-5559>
 <20190605070312.GB15685@dhcp22.suse.cz>
 <20190605130727.GA25529@bharath12345-Inspiron-5559>
 <20190605142246.GH15685@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605142246.GH15685@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMO the reason why a lot of failures must not have occured in the past
might be because the programs which use it use stuff like cpu_to_node or
have checks for nid.
If one day we do get a program which passes an invalid node id without
VM_BUG_ON enabled, it might get weird.

