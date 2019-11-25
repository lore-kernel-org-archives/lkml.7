Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FB3C43141
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A9420409
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="15Bpu0X6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfKYSdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:33:45 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41680 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729360AbfKYSdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 13:33:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id m4so17071871ljj.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 10:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kPjtxI/TrF4UnMikjlggsxMbTRpW7xiQMfu1Q1pQSto=;
        b=15Bpu0X6m1bgIwc9pGxLJZIxvfZTaxrG3jlKJDzx9i0BU/czx4OvuotVSORu/UJMHA
         5xAzIKc+sBj6fQJq7T5O+9lHX1m2VhKwfkd0yD8vRmCSzrz2q3HitQYPUdT/0O5TqWNW
         lWITqzgChNWXPkzX5ejQHEnESq/ytb4CupHwGgWuqWuzEz2CIZfIbGGXxW49d02VEAaJ
         ajqTbNbaTb3Q7BjdqUbyjB12Qx9qfQUbA0u7ndYqDInYEz75ynlU29iGTUEonXISUMRf
         y1zDm0i3Wt4IK0Ndyr337xWNITXajNPS9NHKNamlJbrqEiUGGwadbe4Yf5ktuPmKK6iA
         XFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kPjtxI/TrF4UnMikjlggsxMbTRpW7xiQMfu1Q1pQSto=;
        b=h/qSp8CfdWaVkzgPqzHDS75NgDGWQd0lzyQJxcAxckt+dmUV3mYr47hzBUTZVUNW7g
         58vBLNS0z9Bk3rSL4z1gBJnTF3b+cXeBct5K2ED6aTJ2cjXr3IyKLoYr4T0Q/i411vlh
         cDibFmMEOWPPi4blRh6wjfuzhSC1s7Wn1qx3YsafK7XLU9aoeMCXlA+rMuK/xkWkZrwJ
         vg06QL5NqiQ+UTYZxOs/gROwavnDzJkKTOHXKhjZTkNlaDptCncZusWB4A3Bx6ruilfC
         nRXL/3TTBiaD7yEVLs8bWQJO+cj7+uvqWx4VPpgMUUvEj53dteT6vHYgR0C+/6M3WZQU
         D3Ng==
X-Gm-Message-State: APjAAAXq3xlhVadTlX7A1FDqMns5PoVWUrBoDfl+GHHWtIlsIBgsBGQ1
        q1jVHRQ9Ss85QE1Fdm4+zgw0ZQ==
X-Google-Smtp-Source: APXvYqytq8uQHbgkfOudQHi3MYcOIVXdIxAHGRYx6WisuZYKhE/mnmwsQkgLfFth9cwc6u+RUlHkjw==
X-Received: by 2002:a2e:9f4d:: with SMTP id v13mr23663505ljk.78.1574706822066;
        Mon, 25 Nov 2019 10:33:42 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n19sm4019290lfl.85.2019.11.25.10.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 10:33:41 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id B23951032C4; Mon, 25 Nov 2019 21:33:50 +0300 (+03)
Date:   Mon, 25 Nov 2019 21:33:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hughd@google.com, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: shmem: allow split THP when truncating THP
 partially
Message-ID: <20191125183350.5gmcln6t3ofszbsy@box>
References: <1574471132-55639-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191125093611.hlamtyo4hvefwibi@box>
 <3a35da3a-dff0-a8ca-8269-3018fff8f21b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a35da3a-dff0-a8ca-8269-3018fff8f21b@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 10:24:38AM -0800, Yang Shi wrote:
> 
> 
> On 11/25/19 1:36 AM, Kirill A. Shutemov wrote:
> > On Sat, Nov 23, 2019 at 09:05:32AM +0800, Yang Shi wrote:
> > > Currently when truncating shmem file, if the range is partial of THP
> > > (start or end is in the middle of THP), the pages actually will just get
> > > cleared rather than being freed unless the range cover the whole THP.
> > > Even though all the subpages are truncated (randomly or sequentially),
> > > the THP may still be kept in page cache.  This might be fine for some
> > > usecases which prefer preserving THP.
> > > 
> > > But, when doing balloon inflation in QEMU, QEMU actually does hole punch
> > > or MADV_DONTNEED in base page size granulairty if hugetlbfs is not used.
> > > So, when using shmem THP as memory backend QEMU inflation actually doesn't
> > > work as expected since it doesn't free memory.  But, the inflation
> > > usecase really needs get the memory freed.  Anonymous THP will not get
> > > freed right away too but it will be freed eventually when all subpages are
> > > unmapped, but shmem THP would still stay in page cache.
> > > 
> > > To protect the usecases which may prefer preserving THP, introduce a
> > > new fallocate mode: FALLOC_FL_SPLIT_HPAGE, which means spltting THP is
> > > preferred behavior if truncating partial THP.  This mode just makes
> > > sense to tmpfs for the time being.
> > We need to clarify interaction with khugepaged. This implementation
> > doesn't do anything to prevent khugepaged from collapsing the range back
> > to THP just after the split.
> 
> Yes, it doesn't. Will clarify this in the commit log.

Okay, but I'm not sure that documention alone will be enough. We need
proper design.

> > > @@ -976,8 +1022,31 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
> > >   			}
> > >   			unlock_page(page);
> > >   		}
> > > +rescan_split:
> > >   		pagevec_remove_exceptionals(&pvec);
> > >   		pagevec_release(&pvec);
> > > +
> > > +		if (split && PageTransCompound(page)) {
> > > +			/* The THP may get freed under us */
> > > +			if (!get_page_unless_zero(compound_head(page)))
> > > +				goto rescan_out;
> > > +
> > > +			lock_page(page);
> > > +
> > > +			/*
> > > +			 * The extra pins from page cache lookup have been
> > > +			 * released by pagevec_release().
> > > +			 */
> > > +			if (!split_huge_page(page)) {
> > > +				unlock_page(page);
> > > +				put_page(page);
> > > +				/* Re-look up page cache from current index */
> > > +				goto again;
> > > +			}
> > > +			unlock_page(page);
> > > +			put_page(page);
> > > +		}
> > > +rescan_out:
> > >   		index++;
> > >   	}
> > Doing get_page_unless_zero() just after you've dropped the pin for the
> > page looks very suboptimal.
> 
> If I don't drop the pins the THP can't be split. And, there might be more
> than one pins from find_get_entries() if I read the code correctly. For
> example, truncate 8K length in the middle of THP, the THP's refcount would
> get bumpped twice since  two sub pages would be returned.

Pin the page before pagevec_release() and avoid get_page_unless_zero().

Current code is buggy. You need to check that the page is still belong to
the file after speculative lookup.

-- 
 Kirill A. Shutemov
