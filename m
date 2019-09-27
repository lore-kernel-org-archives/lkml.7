Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E87C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BCC21848
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="yDe5MTtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfI0MRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:17:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43053 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfI0MRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:17:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id r9so2115487edl.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 05:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zCiD3TkmkX3XcFX04Lf0rUa1Py59Hl7dbwV8vnS+nx4=;
        b=yDe5MTtY8Qrujp2zCelibfB/Ag25mYxKxY2uPMP1hitaI7IgiQ9rREkUyCW4wjVBwi
         99q/NqenKNcoyT6mSmQzKGfzUogxfbJ1FTM41FiO3wJKi/PHmD5EODBVanDBPfYoDekO
         Ss5Q37xyH4SmU/9+z4EkXuqhFO2yc0I8YvUGpaFGjt72YjJz8b//uyaW9bwMtiit4E5L
         2cZYQset3YJ8ja5+8hKqjI4c4hyqbWLQBcw108T1HOBpGkOfHlDGih7OHJObjRki284N
         ThKmD2Vmtfo3li+XFIlDBghUyC+Y8E2KQHpQAM7icIJ118ql+QWzvYugd7LeZt5SRcYT
         QLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zCiD3TkmkX3XcFX04Lf0rUa1Py59Hl7dbwV8vnS+nx4=;
        b=N1/vUi3FacOhCet65gepeTvafTuairmCdMtmtREwpeH4YYWHd7z/4I8vsSJD7jtMfH
         5oeIUmbiwKxiEEazo8NWAf8ok8R6N/ZW3h8O+mMguuEkPmRnvON7RTOpbXT5hAyMrdVg
         WnFQnBpFHZiuAUu23b91ksPmgT0Lhfg05TeChDBo7I6niA7K6bUT0VtCrDEgvULq+1K3
         OeMFTqFv1eQWtB/JJwMdZirLVcX67iIiaJl+x4QtdC04LeGsvZtgVsc8DLWi4qhq3F19
         cZvSJbSN/WgpKGUWrNrTrqnb4iyTPeZBRF1KXh3tK3oJ2cpE2jDTW13aJ2rTxFNW1NmU
         r9tw==
X-Gm-Message-State: APjAAAWB29HjFJPXp86y8Kw5w4NtyDDG1mX8KwKp0ckVR53sYOFxVmbn
        6QuV07pWAJp293J8sbH/JVp+eA==
X-Google-Smtp-Source: APXvYqzDqxxVYTiADi5x5I86mOGr2mlaIGwZzHeIBO80YOSWqGJpba79qB+UWXl+lD8oNUZcMGCMZA==
X-Received: by 2002:a17:906:699:: with SMTP id u25mr7229807ejb.250.1569586671584;
        Fri, 27 Sep 2019 05:17:51 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u27sm497064edb.48.2019.09.27.05.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 05:17:50 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 9F6F8101F61; Fri, 27 Sep 2019 15:17:54 +0300 (+03)
Date:   Fri, 27 Sep 2019 15:17:54 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: Ack to merge through DRM? WAS Re: [PATCH v2 1/5] mm: Add
 write-protect and clean utilities for address space ranges
Message-ID: <20190927121754.kn46qh2crvsnw5z2@box>
References: <20190926115548.44000-1-thomas_os@shipmail.org>
 <20190926115548.44000-2-thomas_os@shipmail.org>
 <85e31bcf-d3c8-2fcf-e659-2c9f82ebedc7@shipmail.org>
 <CAHk-=wifjLeeMEtMPytiMAKiWkqPorjf1P4PbB3dj17Y3Jcqag@mail.gmail.com>
 <a48a93d2-03e9-40d3-3b4c-a301632d3121@shipmail.org>
 <CAHk-=whwN+CvaorsmczZRwFhSV+1x98xg-zajVD1qKmN=9JhBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whwN+CvaorsmczZRwFhSV+1x98xg-zajVD1qKmN=9JhBQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 01:16:55PM -0700, Linus Torvalds wrote:
> On Thu, Sep 26, 2019 at 1:09 PM Thomas Hellström (VMware)
> <thomas_os@shipmail.org> wrote:
> >
> > That said, if people are OK with me modifying the assert in
> > pud_trans_huge_lock() and make __walk_page_range non-static, it should
> > probably be possible to make it work, yes.
> 
> I don't think you need to modify that assert at all.
> 
> That thing only exists when there's a "pud_entry" op in the walker,
> and then you absolutely need to have that mmap_lock.
> 
> As far as I can tell, you fundamentally only ever work on a pte level
> in your address space walker already and actually have a WARN_ON() on
> the pud_huge thing, so no pud entry can possibly apply.
> 
> So no, the assert in pud_trans_huge_lock() does not seem to be a
> reason not to just use the existing page table walkers.
> 
> And once you get rid of the walking, what is left? Just the "iterate
> over the inode mappings" part. Which could just be done in
> mm/pagewalk.c, and then you don't even need to remove the static.
> 
> So making it be just another walking in pagewalk.c would seem to be
> the simplest model.
> 
> Call it "walk_page_mapping()". And talk extensively about how the
> locking differs a lot from the usual "walk_page_vma()" things.

Walking mappings of a page is what rmap does. This code thas to be
integrated there.

-- 
 Kirill A. Shutemov
