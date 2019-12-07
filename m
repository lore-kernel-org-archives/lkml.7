Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FD2C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 22:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06579206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 22:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlO3aG3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfLGWD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 17:03:27 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:41430 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfLGWD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 17:03:27 -0500
Received: by mail-il1-f194.google.com with SMTP id z90so9406716ilc.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 14:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5nppC0dn8qY+mD1E09P6PznSd/Bh4xxBWze2A2WO09Q=;
        b=IlO3aG3FRZD0xu9tViplgiGfRS37CuKkEj2ScqdH3KZ2Bzcf4tsYAuLrY+OW7xfQnQ
         Y4MC304D5enhqMluX9wGOBUfm37Pl9zvBr+WVyglzg9SPMpmkcYgp2SnFHdUYwLnO4cX
         DS7ikHBIbZzG3fH1dX50B8kyiQCeWdjPlBaZc032SH4U7bI5SbHRtXnuR3W2li8k287E
         9BVwgTzbdRsqz6dzswTUZXsU4WAFUT+LTebfprvvvhUrJFfFfQsRE55FtVj8K0xhgEeP
         9HGnDHVOEBAVzlqhNR8XCTnBLiIIAkwxbeJqD85vR86m07DIl75XL3s1my1wr54vmExX
         F6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5nppC0dn8qY+mD1E09P6PznSd/Bh4xxBWze2A2WO09Q=;
        b=RgxmTPE9CR1sEPxJf6i5k/lZdHk0+W8hcN03sXwanRMtnx1mJnI1Glvrwa1/EotkCP
         Qm1Fq/mZ4GiRNu08R2ZH5pCGXFFhTIFGXsHDgaXtVpk6zpstVNZLXNbQcxyGAnF6x1gT
         lIlqKo67j4R4Pji3PHlMlBPOVDEetCichYAqJxbDuGsvhxlfC83y7ZNYmsSOsXDNcdXV
         bcXUt3Nz9R/ru+sMt4SvTWRnAv446zN1WsbXPv+mo5qI5VmDp0CiqJ4x1TYNwfIXWSW1
         TizcXcxUXqWvP0u6udKHNfk9LyZ/QG66xf6R5jmOEC4lN9dyA1osZ4Ls18z7TVZmxPZY
         pTmQ==
X-Gm-Message-State: APjAAAUGz0GJR+cVvdP3VINb7jJfEqxUO0IRn/1vZ+GPI+OFDWKvBgUB
        JxmlMTo4fzYNm2Qixv2voyLdng==
X-Google-Smtp-Source: APXvYqzL+apasGgFI7oEJW3eyBLX0JaAv4j90jb1OtOqnumSkM2Y/9UGCPlGMll2foI6bqYKtJ2v1Q==
X-Received: by 2002:a92:5805:: with SMTP id m5mr20220506ilb.59.1575756206331;
        Sat, 07 Dec 2019 14:03:26 -0800 (PST)
Received: from google.com ([2620:15c:183:0:209:9736:c663:27c3])
        by smtp.gmail.com with ESMTPSA id y11sm5243668ilp.46.2019.12.07.14.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 14:03:25 -0800 (PST)
Date:   Sat, 7 Dec 2019 15:03:20 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [FIX] slub: Remove kmalloc under list_lock from
 list_slab_objects() V2
Message-ID: <20191207220320.GA67512@google.com>
References: <20191108193958.205102-1-yuzhao@google.com>
 <20191108193958.205102-2-yuzhao@google.com>
 <alpine.DEB.2.21.1911092024560.9034@www.lameter.com>
 <20191109230147.GA75074@google.com>
 <alpine.DEB.2.21.1911092313460.32415@www.lameter.com>
 <20191110184721.GA171640@google.com>
 <alpine.DEB.2.21.1911111543420.10669@www.lameter.com>
 <alpine.DEB.2.21.1911111553020.15366@www.lameter.com>
 <20191130150908.06b2646edfa7bdc12a943c25@linux-foundation.org>
 <alpine.DEB.2.21.1912021511250.15780@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1912021511250.15780@www.lameter.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 03:12:20PM +0000, Christopher Lameter wrote:
> On Sat, 30 Nov 2019, Andrew Morton wrote:
> 
> > > Perform the allocation in free_partial() before the list_lock is taken.
> >
> > No response here?  It looks a lot simpler than the originally proposed
> > patch?
> 
> Yup. I prefer this one but its my own patch so I cannot Ack this.

Hi, there is a pending question from Tetsuo-san. I'd be happy to ack
once it's address.
