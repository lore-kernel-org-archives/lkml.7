Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36C2C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EC320836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="0voqs/p2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbfLKPyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:54:51 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45866 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731796AbfLKPyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:54:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so17043063lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 07:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pNpk4oXfDNHca9JX4JXRKtvQeEv6BIYEvqyTZhw9VO4=;
        b=0voqs/p2IwXU8GClGbWYDwhurKNgEFA6KIZecdCes+hnpGciBbWjIg1UwkTEJAA3Vf
         VnCSlslqpNg410p8Pupt2jJ/S6Fv8fiAsUSyMC+0yIvF1kDLeTUXrbQVhcyFogAOTtVU
         9ka3v+FIcXQ4SledqdLrVQ3yBMLBrUNo3gkCV8wImUpHJmwfnES9xmdjuMhu5LqH09S4
         Qs6JR9VRLkDmX+IELmVugpPoW5+oPH10T3cR2/qozsXkvr955YDsGhhwun8YAkCOjyju
         1L34U5u3KXLXgjKlkeH+qy+areSkxkz3yt2mfAxxGrLbGEQIOw8Qpg+mj2PLIV5Jj9YK
         ngnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pNpk4oXfDNHca9JX4JXRKtvQeEv6BIYEvqyTZhw9VO4=;
        b=LHJP6PJTHeSIGdHJI1Hx9y8SzZWRGXvM8a5XjVTUEI8F1UXO7dda7tSXP5KYbKUkFx
         jsZxuEXH/3zhwAAVKN2BzADIGOQooNaLEAdMha9OXffAfoCK+yAxSZU/qkWpCK82Nc6z
         1GKmBwwNxHWDJM/AMJiERk1PngIC62KHIOt9A7b/K01FbQDg53KxaC7yzWqLukT/E600
         iIfK7m8yshK1HIsNmRF82Mp6uufznaOtJ/lpWQ0cXZWARif0qcvU56k0mQrQd7k2LSvu
         KumtqRIPNx8z/nnARVIviz/Bp3b3hKn35HWm0OvLbtHwJSZy9HJvZcnSYP5M+PLuitgY
         5aHA==
X-Gm-Message-State: APjAAAXV5+8QR81efwvUEXp9L5C2YIEHG4jP/G2f68GaL3X+99o5uvaa
        Bn/sbYFLCtFouxbDLkxNtfoH3Q==
X-Google-Smtp-Source: APXvYqz84+KK003VsOsEluRtdv+DNGgcMmqgCuu+nFqEFdjyLl8a4FngY/HtxgoY5gucbWBBtMiNXQ==
X-Received: by 2002:a19:6455:: with SMTP id b21mr2535676lfj.45.1576079684121;
        Wed, 11 Dec 2019 07:54:44 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w17sm1398565lfn.22.2019.12.11.07.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:54:43 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 154CF101218; Wed, 11 Dec 2019 18:54:44 +0300 (+03)
Date:   Wed, 11 Dec 2019 18:54:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: Re: [RFC PATCH v1 3/4] thp: fix huge page zapping for special PMDs
Message-ID: <20191211155444.nx4o363rlskmvyhr@box>
References: <DB7PR02MB3979BC324920A783BD5BB721BB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR02MB3979BC324920A783BD5BB721BB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 09:29:20AM +0000, Mircea CIRJALIU - MELIU wrote:
> When calling zap_vma_ptes() on VM_PFNMAP VMAs involving huge mappings,

Do we have such VMAs?

-- 
 Kirill A. Shutemov
