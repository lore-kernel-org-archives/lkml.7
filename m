Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48019C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 19:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C022183F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 19:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="KlNpZMM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbfC3Ttu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 15:49:50 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:38269 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730542AbfC3Ttu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 15:49:50 -0400
Received: by mail-it1-f177.google.com with SMTP id f22so9251888ita.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 12:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cqWtuIW/mXlOPbkvx5iIMKwbk7DDkuQUqPqFfj440Yc=;
        b=KlNpZMM41lwbYOBc4BX3UwXOEsL57V8Zn+SjxDMXLiQM7UFmwNAgTppDvCu5jhxSqd
         /JCwMloZL204mROxb1/0jWxutWVms8ezNeIUOVK6JjBoLJIJfkN0z3RuogUGw0qKOgkO
         4aoKEp/HupI2P4Qg42ThMDNSb6YRT3OvwKEYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cqWtuIW/mXlOPbkvx5iIMKwbk7DDkuQUqPqFfj440Yc=;
        b=SR8OjWzuPgRWC/tsA87uRC9hlrTgIHCHnjlCbJEjwRhkV7Nj1BFxB7GGiqixvE4AwL
         6KXHKqYW20cN1AZIencT6q1OQ0tkEKBZORhqK+T2y1AvHxIOcDN6l89CH65V4pvvO6y8
         nhbq7ii8DMiVgC5gW9X62/0/Ezw+VM5uwRJ2LUWDzI98H5UhkmKLFjLXycJWEB1WsYFU
         Sa7+MWjcITmxMcFm5cvl4KLZoplePzs+ZEppjfAAM6B9dfLJ4mCYSxiXi2XlgyAVgP2p
         HwhZLxRFz03+mVbeavLYhwC0U6/0wA9zKz1REODkfX7XBqJe1iDFjFQK+BT0NVVi5GtA
         3vFA==
X-Gm-Message-State: APjAAAUKjo0R95lV9GwnSKtidd+9It798hQ6MeZNU/LCyS+TdMWeD1tA
        9nF4qPE5ZnTJmRfRJlwSv5jnzg==
X-Google-Smtp-Source: APXvYqysfJ4Zi4RDGaY+FuSOr0YhTE0l2TxPCfW70KGdMSvS+pF11/iqUDszzxw5xAxGTF4LU6lNKg==
X-Received: by 2002:a24:5a01:: with SMTP id v1mr9436471ita.0.1553975389051;
        Sat, 30 Mar 2019 12:49:49 -0700 (PDT)
Received: from ?IPv6:2600:1700:c991:2dc0::64? ([2600:1700:c991:2dc0::64])
        by smtp.googlemail.com with ESMTPSA id w6sm2348552iom.22.2019.03.30.12.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 12:49:48 -0700 (PDT)
Subject: Re: Possible UDF locking error?
To:     Jan Kara <jack@suse.cz>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <224e1613-b080-bd64-ef88-badcb755a233@digidescorp.com>
 <20190325164211.GF8308@quack2.suse.cz>
From:   Steve Magnani <steve.magnani@digidescorp.com>
Message-ID: <16a6ed55-e8c9-cc56-b675-e9a9de57ab66@digidescorp.com>
Date:   Sat, 30 Mar 2019 14:49:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325164211.GF8308@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan -

On 3/25/19 11:42 AM, Jan Kara wrote:
> Hi!
>
> On Sat 23-03-19 15:14:05, Steve Magnani wrote:
>> I have been hunting a UDF bug that occasionally results in generation
>> of an Allocation Extent Descriptor with an incorrect tagLocation. So
>> far I haven't been able to see a path through the code that could
>> cause that. But, I noticed some inconsistency in locking during
>> AED generation and wonder if it could result in random corruption.
>>
>> The function udf_update_inode() has this general pattern:
>>
>>    bh = udf_tgetblk(...);   // calls sb_getblk()
>>    lock_buffer(bh);
>>    memset(bh->b_data, 0, inode->i_sb->s_blocksize);
>>    // <snip>other code to populate FE/EFE data in the block</snip>
>>    set_buffer_uptodate(bh);
>>    unlock_buffer(bh);
>>    mark_buffer_dirty(bh);
>>
>> This I can understand - the lock is held for as long as the buffer
>> contents are being assembled.
>>
>> In contrast, udf_setup_indirect_aext(), which constructs an AED,
>> has this sequence:
>>
>>    bh = udf_tgetblk(...);   // calls sb_getblk()
>>    lock_buffer(bh);
>>    memset(bh->b_data, 0, inode->i_sb->s_blocksize);
>>
>>    set_buffer_uptodate(bh);
>>    unlock_buffer(bh);
>>    mark_buffer_dirty_inode(bh);
>>
>>    // <snip>other code to populate AED data in the block</snip>
>>
>> In this case the population of the block occurs without
>> the protection of the lock.
>>
>> Because the block has been marked dirty, does this mean that
>> writeback could occur at any point during population?
> Yes. Thanks for noticing this!
>
>> There is one path through udf_setup_indirect_aext() where
>> mark_buffer_dirty_inode() gets called again after population is
>> complete, which I suppose could heal a partial writeout, but there is
>> also another path in which the buffer does not get marked dirty again.
> Generally, we add new extents to the created indirect extent which dirties
> the buffer and that should fix the problem. But you are definitely right
> that the code is suspicious and should be fixed. Will you send a patch?

I did a little archaeology to see how the code evolved to this point. 
It's been like this a long time.

I also did some research to understand why filesystems use lock_buffer() 
sometimes but not others. For example, the FAT driver never calls it. I 
ran across this thread from 2011:

        https://lkml.org/lkml/2011/5/16/402

...from which I conclude that while it is correct in a strict sense to 
hold a lock on a buffer any time its contents are being modified, 
performance considerations make it preferable (or at least reasonable) 
to make some modifications without a lock provided it's known that a 
subsequent write-out will "fix" any potential partial write out before 
anyone else tries to read the block. I doubt that UDF sees common use 
with DIF/DIX block devices, which might make a decision in favor of 
performance a little easier. Since the FAT driver doesn't contain 
Darrick's proposed changes I assume a decision was made that performance 
was more important there.

Certainly the call to udf_setup_indirect_aext() from udf_add_aext() 
meets those criteria. But udf_table_free_blocks() may not dirty the AED 
block.

So if this looks reasonable I will resend as a formal patch:

--- a/fs/udf/inode.c	2019-03-30 11:28:38.637759458 -0500
+++ b/fs/udf/inode.c	2019-03-30 11:33:00.357761250 -0500
@@ -1873,9 +1873,6 @@ int udf_setup_indirect_aext(struct inode
  		return -EIO;
  	lock_buffer(bh);
  	memset(bh->b_data, 0x00, sb->s_blocksize);
-	set_buffer_uptodate(bh);
-	unlock_buffer(bh);
-	mark_buffer_dirty_inode(bh, inode);
  
  	aed = (struct allocExtDesc *)(bh->b_data);
  	if (!UDF_QUERY_FLAG(sb, UDF_FLAG_STRICT)) {
@@ -1890,6 +1887,9 @@ int udf_setup_indirect_aext(struct inode
  	udf_new_tag(bh->b_data, TAG_IDENT_AED, ver, 1, block,
  		    sizeof(struct tag));
  
+	set_buffer_uptodate(bh);
+	unlock_buffer(bh);
+
  	nepos.block = neloc;
  	nepos.offset = sizeof(struct allocExtDesc);
  	nepos.bh = bh;
@@ -1913,6 +1913,8 @@ int udf_setup_indirect_aext(struct inode
  	} else {
  		__udf_add_aext(inode, epos, &nepos.block,
  			       sb->s_blocksize | EXT_NEXT_EXTENT_ALLOCDECS, 0);
+		/* Make sure completed AED gets written out */
+		mark_buffer_dirty_inode(nepos.bh, inode);
  	}
  
  	brelse(epos->bh);

------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
  www.digidescorp.com               Earthling, return my space modulator!"

  #include <standard.disclaimer>

