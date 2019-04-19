Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A19C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A61420645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlUJPs6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfDSS5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:57:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44199 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfDSS5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:57:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id i2so3003550pgj.11;
        Fri, 19 Apr 2019 11:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MgFyOcp2C6jgy7Lz89llahOuUjcJJYSlyTA+A/9dTPk=;
        b=JlUJPs6CqaYJa0zgvp4/ofyzJInpUBDZAl5aQhaXYDvKua79VAfhrNK+U27aaw8wDX
         sOYuQ8nfd0Gbz29ZNpZwYgXLWcDdVJRII6s8TIwgAZK7XskVp04evNXuu+yk8pUHbH4t
         S/hHvgmj+U2jd7DPnCpSibKmT09wpyzVpLv0p7ZNETVHiqpyoo8PPYPjFrQQLULH/JxG
         wcckdwA7NtxTIX5h1E4lFHoKvND1tYFoT7OldOTwReo6A1OZ6SIFjW+LmZAmGrUzCJRI
         83sxQLN0eFKGj9hsPakvHdm3QXG5gP/98IlemGzaTtPIUGaNQ3s3GbhIpck/jpx3e3W8
         h+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MgFyOcp2C6jgy7Lz89llahOuUjcJJYSlyTA+A/9dTPk=;
        b=pDf0groLvPRmRPCO7rVPFL0pi1Y0JuaBQ6XQMczKrzf9Y5kdl/hEdJaVk4QGNGtO58
         SZVPEOtHhXqhuQI++D9AeyL4nacyRKOt8rFbAmQcXES5RphR4/WgFLlU4ni4aVVeTa2i
         2WNdnzUZ83vJSYyp5mdHrSwgN+WCTYXd4O6T+jAO36eGIwjF9XMXyh9bsgoXRaMO489v
         iI+jJ1O+pR2iHJp0h13SaLNXKK0uOP30UiO1iUpUDR2WFpMtNJCYkKwLW2uyPLGCT+Av
         JFl4mQwO82CFw1fc1NBr+uInwO+5NTq/ZxX4pYnlxynkaBl+51NDwQFM0YzGItR7kocV
         COYg==
X-Gm-Message-State: APjAAAXvyXMJLlzxA6vpTxKyoy2B2nDc6tz9DCSwQHbggX6RV6adK7dM
        SQio1tkb8vCcAxHakSndUoHXBef4
X-Google-Smtp-Source: APXvYqxObkNjbZbhX4+/T/JRoevOwO8bSSkLgd7zN/+w5zZn0AXP2uQYlkPpvvKXHavvcXP64p3VzA==
X-Received: by 2002:a63:5012:: with SMTP id e18mr2058870pgb.383.1555654119128;
        Thu, 18 Apr 2019 23:08:39 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id 13sm5318861pfi.172.2019.04.18.23.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 23:08:38 -0700 (PDT)
Date:   Fri, 19 Apr 2019 11:38:33 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     jannh@google.com, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: Force type conversion in xattr_hash
Message-ID: <20190419060833.GA12013@bharath12345-Inspiron-5559>
References: <20190417115200.GA10168@bharath12345-Inspiron-5559>
 <20190418155019.ab5189e4e317df2b36861012@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418155019.ab5189e4e317df2b36861012@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 03:50:19PM -0700, Andrew Morton wrote:
> On Wed, 17 Apr 2019 17:22:00 +0530 Bharath Vedartham <linux.bhar@gmail.com> wrote:
> 
> > This patch fixes the sparse warning:
> > 
> > fs/reiserfs//xattr.c:453:28: warning: incorrect type in return
> > expression (different base types)
> > fs/reiserfs//xattr.c:453:28:    expected unsigned int
> > fs/reiserfs//xattr.c:453:28:    got restricted __wsum
> > fs/reiserfs//xattr.c:453:28: warning: incorrect type in return
> > expression (different base types)
> > fs/reiserfs//xattr.c:453:28:    expected unsigned int
> > fs/reiserfs//xattr.c:453:28:    got restricted __wsum
> > 
> > csum_partial returns restricted integer __wsum whereas xattr_hash
> > expects a return type of __u32.
> > 
> > ...
> >
> > --- a/fs/reiserfs/xattr.c
> > +++ b/fs/reiserfs/xattr.c
> > @@ -450,7 +450,7 @@ static struct page *reiserfs_get_page(struct inode *dir, size_t n)
> >  
> >  static inline __u32 xattr_hash(const char *msg, int len)
> >  {
> > -	return csum_partial(msg, len, 0);
> > +	return (__force __u32)csum_partial(msg, len, 0);
> >  }
> >  
> >  int reiserfs_commit_write(struct file *f, struct page *page,
> 
> hm.  Conversion from int to __u32 should be OK - why is sparse being so
> picky here?
> 
> Why is the __force needed, btw?
The return type of csum_partial is __wsum which is a restricted integer
type.

__wsum is defined as:
typedef __u32 __bitwise __wsum;

Being a restricted integer type, sparse will complain whenever convert
the restricted type to another type without __force.

Interestingly enough if we look at the definition of csum_partial, more
specifically the first 2 lines:

__wsum csum_partial(const void *buff, int len, __wsum sum)
{
	unsigned long result = do_csum(buff, len);

	result += (__force u32)sum;
	
	.....

sum is of type __wsum, result is of type unsigned long. __force is used
to suppress the sparse warning.

Thanks for your time!
