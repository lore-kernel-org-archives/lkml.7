Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01942C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 20:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56FA21873
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 20:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="GLceO8C7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfCWUOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 16:14:08 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:54160 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfCWUOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 16:14:08 -0400
Received: by mail-it1-f176.google.com with SMTP id w85so1523012itc.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 13:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=QftJ9XujrPqD27cmAQFQRYEvhMiam8l9chwl5OSpN1k=;
        b=GLceO8C7GUV6H7xdhTqPmqcyb7TgOsRCt6cxYLX2Qqq43uV8MHwAMiK0zL4inmkgNy
         dZzQfpDfGZI5Hc5xwe5jfRQup3zQNba0W9My4S3vAImrJf82Mhze2fVTgX35UUHddNY0
         GYXlTZ3QMQQHV1v4PCJXFAl2DYdmnYjT95wwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=QftJ9XujrPqD27cmAQFQRYEvhMiam8l9chwl5OSpN1k=;
        b=NR22swHThz5HnPW4VmYfeZuKLaaRj48yzRx5n1OJhKRENx2BQv483JZEDHzr0g6OAa
         KzpRuBSFG0EiGLa2kDhxAqFGXxqK79RFMpMxRomPpS8v0uMcF6SVgfc6A02tv3pcHPfp
         02c5ftOwSEhy6a/hpeMhlxZWCf2eDc0zeUwBPXlCtkAWxbthO9rcZw8dLgwolzMtpL//
         i4WV5eD7zrZJDQTS+JAlSrN0/mmAXSQ2DYdANjjEfXZhaSiN7Fa4Zjybd4nf7IHClxRQ
         ONCk0/YufW55eJ2i6NKpPZASfzMOum5EZ1MzCkgA7q/S26+Bo6AXD9cM3W0Q/1Ek4iKs
         YiCw==
X-Gm-Message-State: APjAAAXEFzKZCePsTWq6Os1BWdm5bYhacg03vsrEQHqPZPGFpT6l6VO/
        185P6IbCZutXnJUbONgqrydrmQ==
X-Google-Smtp-Source: APXvYqwN0zT8/+AtYlToZ4ZXLA8suH2UdI0rzO92DQSJ7WSl8+QrTLEfSRFLZyRWvEOLMUYwSRibaQ==
X-Received: by 2002:a05:660c:ad2:: with SMTP id k18mr2811476itl.98.1553372046607;
        Sat, 23 Mar 2019 13:14:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:c991:2dc0::64? ([2600:1700:c991:2dc0::64])
        by smtp.googlemail.com with ESMTPSA id y101sm3334630ita.25.2019.03.23.13.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 13:14:06 -0700 (PDT)
From:   Steve Magnani <steve.magnani@digidescorp.com>
Subject: Possible UDF locking error?
To:     Jan Kara <jack@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Message-ID: <224e1613-b080-bd64-ef88-badcb755a233@digidescorp.com>
Date:   Sat, 23 Mar 2019 15:14:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been hunting a UDF bug that occasionally results in generation
of an Allocation Extent Descriptor with an incorrect tagLocation. So
far I haven't been able to see a path through the code that could
cause that. But, I noticed some inconsistency in locking during
AED generation and wonder if it could result in random corruption.

The function udf_update_inode() has this general pattern:

   bh = udf_tgetblk(...);   // calls sb_getblk()
   lock_buffer(bh);
   memset(bh->b_data, 0, inode->i_sb->s_blocksize);
   
   // <snip>other code to populate FE/EFE data in the block</snip>
   
   set_buffer_uptodate(bh);
   unlock_buffer(bh);
   mark_buffer_dirty(bh);

This I can understand - the lock is held for as long as the buffer
contents are being assembled.

In contrast, udf_setup_indirect_aext(), which constructs an AED,
has this sequence:

   bh = udf_tgetblk(...);   // calls sb_getblk()
   lock_buffer(bh);
   memset(bh->b_data, 0, inode->i_sb->s_blocksize);

   set_buffer_uptodate(bh);
   unlock_buffer(bh);
   mark_buffer_dirty_inode(bh);

   // <snip>other code to populate AED data in the block</snip>

In this case the population of the block occurs without
the protection of the lock.

Because the block has been marked dirty, does this mean that
writeback could occur at any point during population?

There is one path through udf_setup_indirect_aext() where
mark_buffer_dirty_inode() gets called again after population is
complete, which I suppose could heal a partial writeout, but there is
also another path in which the buffer does not get marked dirty again.

Regards,
  ------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
  www.digidescorp.com              Earthling, return my space modulator!"

  #include <standard.disclaimer>

