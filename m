Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883D9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F2020657
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="TNVtqdyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfCYSX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:23:59 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:43453 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYSX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:23:59 -0400
Received: by mail-io1-f53.google.com with SMTP id x3so8472839iol.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Fuerf2bI9t70P5LEgrUpoOfBjM1rTYvk8dbzFX1K27M=;
        b=TNVtqdyhoYvyciWJujGPznE0tDkGTaw3rzj6pOY9cyuYEhZBSxx9ctDl2IwJbhKaxQ
         HI9qsGKNLwC2FxJeUgSqjlCJTJihzUhLCTP+MVbxXPeHJUDf7v325aYJrssrDB6rm7vD
         gCD1xS9crtbHGkPPsQdEcNIton7+4LhbUhQuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Fuerf2bI9t70P5LEgrUpoOfBjM1rTYvk8dbzFX1K27M=;
        b=Jymc58asxmVfJ7AUCHhR4OWnpBpG1Y4nOkzsBJzFVAmpSpr7ucLUAW6dMNT96pPF0R
         Y7Cb8CsdpeWE2N15bPqih3L7YIhRGX99JyCdZnSb1jJU1deU0XR/40CP2sO4rxxCfNY1
         74mYETg0FhoV4wzxMXIsL/S/fqATJPU/J3S4p2qOghWygVtXFJjLA+JXc9Y+22AmYjLJ
         lWoa3zzcLCd1YAxW31ZSaPP93t7DqLhphXQoUMHcGWwYATn6z4Xd5uJ+Nn7bZ4jCZoey
         JuNOljZFJS9AXO72RnKHs/2zadOfBVXHlsgIwX6Vgxji9FHH2U5V8zJJlG0xK36FDk6d
         BvRA==
X-Gm-Message-State: APjAAAUKPlJTwkHLLhzMfPK8R5f+W/D4nmXwGTIkDhH9eEDkgMLPMxVk
        lHkXUlDwVGXLzu90UUL2ND1G1g==
X-Google-Smtp-Source: APXvYqyQIVkrRx1DBCMvLwUL5RGKAsmyS94+vb250ND/sGuK12xz1CR30ZXYwPeIaohGESFwTdoAWw==
X-Received: by 2002:a5d:8918:: with SMTP id b24mr19078073ion.241.1553538238599;
        Mon, 25 Mar 2019 11:23:58 -0700 (PDT)
Received: from [10.10.7.164] ([50.73.98.161])
        by smtp.googlemail.com with ESMTPSA id v133sm385601ita.2.2019.03.25.11.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:23:58 -0700 (PDT)
Subject: Re: Possible UDF locking error?
To:     Jan Kara <jack@suse.cz>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <224e1613-b080-bd64-ef88-badcb755a233@digidescorp.com>
 <20190325164211.GF8308@quack2.suse.cz>
From:   Steve Magnani <steve.magnani@digidescorp.com>
Message-ID: <35961291-197a-0557-ff81-dc8686dd8661@digidescorp.com>
Date:   Mon, 25 Mar 2019 13:23:57 -0500
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

On 3/25/19 11:42 AM, Jan Kara wrote:
> Hi!
>
> On Sat 23-03-19 15:14:05, Steve Magnani wrote:
>> ...
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
>
> 								Honza


Sure. There's at least one other place where it looked like there might 
be a similar issue.

Steve


