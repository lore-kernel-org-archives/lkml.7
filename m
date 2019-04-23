Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C982C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4035421738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEA+m+eD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfDWOwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:52:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35537 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfDWOwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:52:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so7659642plp.2;
        Tue, 23 Apr 2019 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U/yyql21eLy7U26/IRqf5+k148/d19JTlOCzUghoDx0=;
        b=XEA+m+eDGwQXkSVBerCvPPyM/qNIK56F6MO5n0ydC4Wyhqi2V7uXIqDHBLNVr8uyc+
         RQWCoe40zBVqluLjp3wS220epAtbKFrBiZL7Dyr9sxiPfBP5GmwSoAZBAbTXVUMUZrSv
         ASI7Vf9LT7xniSLtP5RGzoj35tzVyVmS2UKxAf63fX5CK3Y32aK4bqP/gVHP4/9XL47G
         zocEnbKfBnYCDoUT6FhHTmNusY0zAVdp1HK6/ed61fbdOWFfvhXJAxhGz0vLi9uhlgRB
         wGrv1s3H7PxO5MldQfWXR/K6KJWR566gVmudhG1xNHdl96iEKU7V45HiE42ALzo89pM4
         zhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U/yyql21eLy7U26/IRqf5+k148/d19JTlOCzUghoDx0=;
        b=gCoFYL1QSyb5Z7EhOM01Vkwv2VbboUKhsYQ++sD5evk+WlwlgJV2vLX+xuLRP8OGeG
         Ea1njEMg9xLN19GF8et2UM8sZ0WoiDW1+mltcDywXykr0xsvcu0ZZGJls9UviVbra8QV
         P1XhKbZdjalmr+TEXXG+rHikEWdgTuIybEI1zPH7cGeeHzmQUYJrV/UIogyIjSDrKcfe
         Xich09MYVzESi3NWLY8Najk3bGqfJ9t2Vv4CmR06UMW9E6TLBPQOwU0g/CK/BhaEVrFF
         GzTD1CJrg3kPz8vqCtF4csDcr3IA/U6p6vGaKWSkjmLY7jxXAiDQ9Bq2eRnrem5iNoH7
         yE7A==
X-Gm-Message-State: APjAAAV8tIzyhLRqbdVfCadj6WbEuY+M2NqUHV7vRWA9GOfgw+cOqKA7
        RX6OQAnnLWcye4QewZ61nMtLpdNs
X-Google-Smtp-Source: APXvYqxWbwTrIPSgpwsqp8XE6vQiK7e4mUEYrKBqyATNlGYrtpNHaQLZiMAkCkOvlrBLYL7rvAg2BA==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3mr26928274plo.283.1556031168192;
        Tue, 23 Apr 2019 07:52:48 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id b7sm29449291pfj.67.2019.04.23.07.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 07:52:47 -0700 (PDT)
Date:   Tue, 23 Apr 2019 20:22:37 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>, jannh@google.com,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: Force type conversion in xattr_hash
Message-ID: <20190423145237.GA3609@bharath12345-Inspiron-5559>
References: <20190417115200.GA10168@bharath12345-Inspiron-5559>
 <20190418155019.ab5189e4e317df2b36861012@linux-foundation.org>
 <20190421170235.GI2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421170235.GI2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 06:02:35PM +0100, Al Viro wrote:
> On Thu, Apr 18, 2019 at 03:50:19PM -0700, Andrew Morton wrote:
> > On Wed, 17 Apr 2019 17:22:00 +0530 Bharath Vedartham <linux.bhar@gmail.com> wrote:
> > 
> > > This patch fixes the sparse warning:
> > > 
> > > fs/reiserfs//xattr.c:453:28: warning: incorrect type in return
> > > expression (different base types)
> > > fs/reiserfs//xattr.c:453:28:    expected unsigned int
> > > fs/reiserfs//xattr.c:453:28:    got restricted __wsum
> > > fs/reiserfs//xattr.c:453:28: warning: incorrect type in return
> > > expression (different base types)
> > > fs/reiserfs//xattr.c:453:28:    expected unsigned int
> > > fs/reiserfs//xattr.c:453:28:    got restricted __wsum
> > > 
> > > csum_partial returns restricted integer __wsum whereas xattr_hash
> > > expects a return type of __u32.
> > > 
> > > ...
> > >
> > > --- a/fs/reiserfs/xattr.c
> > > +++ b/fs/reiserfs/xattr.c
> > > @@ -450,7 +450,7 @@ static struct page *reiserfs_get_page(struct inode *dir, size_t n)
> > >  
> > >  static inline __u32 xattr_hash(const char *msg, int len)
> > >  {
> > > -	return csum_partial(msg, len, 0);
> > > +	return (__force __u32)csum_partial(msg, len, 0);
> > >  }
> > >  
> > >  int reiserfs_commit_write(struct file *f, struct page *page,
> > 
> > hm.  Conversion from int to __u32 should be OK - why is sparse being so
> > picky here?
> 
> Because csum_partial() returns __wsum_t, not int.
> 
> > Why is the __force needed, btw?
> 
> So that accidental mixing of those csums (both 16bit and 32bit) with
> host- or net-endian would be caught.
> 
> And I'm not at all sure reiserfs xattr_hash() doesn't bugger it up, actually.
> 
> Recall that 16bit inet csum is the sum of 16bit words (treated as host-endian)
> modulo 0xffff, i.e. the entire buffer interpreted as host-endian integer
> taken modulo 0xffff.  That has a lovely property - memory representation
> of that value is the same whether we'd done calculations on b-e or l-e
> host; the reason is that modulo 65535 byteswap is the same as multiplying
> by 256, so the sum of byteswapped 16bit values modulo 65535 is byteswapped
> sum of original values.
> 
> csum_partial() is sum of 32bit words (treated as host-endian) modulo 0xffffffff,
> i.e. the entire buffer treated as host-endian number modulo 0xffffffff.
> It is convenient when we want to calculate the 16bit csum - 0xffffffff is
> a multiple of 0xffff, so residue modulo 0xffffffff determines the residue
> modulo 0xffff; that's what csum_fold() is.
> 
> However, result of csum_partial() on big- and little-endian hosts
> does *not* have the same property.  Consider e.g. an array {0, 0, 0, 128,
> 0, 0, 0, 128}.  csum_partial of that on l-e will be (2^31 + 2^31)mod(2^32 - 1),
> i.e. 1, with {1, 0, 0, 0} as memory representation.  16bit csum will
> again be 1, with {1, 0} as memory representation.  On big-endian we
> get (128 + 128)mod(2^32 - 1), i.e. 256, with {0, 0, 1, 0} as memory
> representation.  16bit csum is again 256, stored as {1, 0}, i.e.
> the same as if we'd done everything on l-e; however, raw csum_partial()
> values have different memory representations.  They certainly are
> different as host-endian (and so are 16bit csums).
> 
> Reiserfs takes csum_partial() on buffer, interprets it as host-endian
> and stores it little-endian on disk.  When fetching those it does
> the same calculation and fails on mismatch.  However, if the
> store had been done on little-endian host and load - on big-endian
> one we *will* get mismatch almost all the time.  Treating ->rx_hash
> as __wsum_t (and not doing that cpu_to_le32()) would lower the
> frequency of mismatches, but still would be broken.  Storing
> a 16bit csum (declared as __sum16_t, again, without cpu_to_le...())
> would be endian-safe, but that's not what reiserfs folks wanted
> (16 bits of csum instead of 32, for starters).
> 
> IOW, what sparse has caught here is a genuine endianness bug; images
> created on little-endian host and mounted on big-endian (or vice
> versa) will see csum mismatches when trying to fetch xattrs.
> Broken since
> commit 0b1a6a8ca8a78c2e068b04acf97479ee89a024ac
> Author: Andrew Morton <akpm@osdl.org>
> Date:   Sun May 9 23:59:13 2004 -0700
> 
>     [PATCH] reiserfs: xattr support
>     
>     From: Chris Mason <mason@suse.com>
>     
>     From: jeffm@suse.com
>     
>     reiserfs support for xattrs
> 
> ISTR some discussions of reiserfs layout endianness problems, but
> that had been many years ago and I could be wrong; I _think_
> the conclusion had been "it sucks, but we can't do anything
> without breaking existing filesystem images".  Not sure if that
> was the same bug or something different, though.

Hi Al,

Thanks for your detailed explanation. I learnt quite a bit from it. 
I agree we should not "supress" this bug.

I have noticed in the reiserfs code that, a checksum mismatch only
causes a warning? Even if there is a checksum mismatch, data still is
copied to the buffer? 

What is the point of the checksum over here? 

Thanks
