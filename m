Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE64DC31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 15:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52BD21473
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 15:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="XkyL4uWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfFOP6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 11:58:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43410 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfFOP6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 11:58:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so2275924plb.10
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3UEdf7L10rlDvutzhQ5oN7IH73FXQkj8yTdma29U82E=;
        b=XkyL4uWd3z3bLemMqav9h6r4cxQjATGvT6nrLhY1yRSxw+QOo7/ixS91nRkv7T5pHZ
         ygciPYZ3p4au9mHIUYBFJFcheawDvU2ZfcbDSLexM7mBnSbvzcbm957GXSGPBODlinPN
         VzLZVxx8U7/Rur2+zKhPoPSglFf29mPLk5sdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3UEdf7L10rlDvutzhQ5oN7IH73FXQkj8yTdma29U82E=;
        b=ZK7E16KUoGkRQgDc08v0kMISDtbuOHbcdDoQeo0ZhqP18O5JrZF01jFDkGKiRq0uJV
         Yc/afweKohjf++5O/+nE/v5Rndu4e8s/JNcWM/lX/YR9fZzo9a6XmWGD622XX1j5rU57
         76pdfdsP4M9wXxOICK6QLW8JMoTUCGM3dlgsHnzg1PMJiVHc1eGfbSUXoK6dpH+kPJ2p
         of6ScKJIMxsuPTgfReSj3umKlgS+9aqMAZzPSnSgPnYv9oMCSFytzzMYrMsmUQavsHY2
         ulshVZscoCqB7YuFWTEpsntFbc4+mUQyc82wk5siPiVnqpdtOx09JDRcfVts4fIOfKl2
         ZeCw==
X-Gm-Message-State: APjAAAUBzTHeQJHYAKD/gorHjOrI12/zVvg9olKcY+g8SRr3ZEJmb/Ir
        3t4X4VWkYa0g8TYGl/Y+2VCVdw==
X-Google-Smtp-Source: APXvYqwfY314uRro4dsc54oOetfpJqc+ffBY+G0B6BoAGGAlJaMAITXdd1MDQTxvCLR47/tBL2uq+g==
X-Received: by 2002:a17:902:724:: with SMTP id 33mr96737215pli.49.1560614314543;
        Sat, 15 Jun 2019 08:58:34 -0700 (PDT)
Received: from localhost ([61.6.140.222])
        by smtp.gmail.com with ESMTPSA id p7sm14713756pfp.131.2019.06.15.08.58.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 08:58:33 -0700 (PDT)
Date:   Sat, 15 Jun 2019 23:58:31 +0800
From:   Chris Down <chris@chrisdown.name>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] psi: Don't account force reclaim as memory pressure
Message-ID: <20190615155831.GA1307@chrisdown.name>
References: <20190615120644.26743-1-xlpang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190615120644.26743-1-xlpang@linux.alibaba.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xunlei,

Xunlei Pang writes:
>There're several cases like resize and force_empty that don't
>need to account to psi, otherwise is misleading.

I'm afraid I'm quite confused by this patch. Why do you think accounting for 
force reclaim in PSI is misleading? I completely expect that force reclaim 
should still be accounted for as memory pressure, can you present some reason 
why it shouldn't be?
