Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7131EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36735206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NODJpOEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfK0TZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:25:14 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35264 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0TZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 14:25:13 -0500
Received: by mail-qk1-f195.google.com with SMTP id v23so12754633qkg.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 11:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kBVHw0kl4ptYAXIaSi+sN3W8duT4DdJdhE+0saCLiHU=;
        b=NODJpOEgLZ6/hu57iXnCYA+x3MmiqH6OsMcvvCfvnLhzdLMvP2BO2wMajPTb+VcYXx
         7r6wPm2S917D3XfKzxioQX6US4Rw3loqafcXT1jGebfmGu8TbMNs4f+Rf+P8oCKbKcr9
         gKLamETlxXb4+o/hmUwF+XdD5kYeQQQbw3ANjXqr52MIqtrRJnIi+e7g3FHf/Zv8sVYa
         nYaoR+TKUHvORL7dvPvSBoJjG0gX0iCh7DBgSh+vGlq+b6qTDnjwfIOl0Eb4/hM3F5gx
         BhnIY44zkTohmScXyk23BQytvmLAuqBb3yo+h6ous3GBFA/8gAvCwNKZYJZ1IXkZUQEx
         BG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kBVHw0kl4ptYAXIaSi+sN3W8duT4DdJdhE+0saCLiHU=;
        b=tRcGQ7nefkwVUgBxB0etPwdneHL1HiZcXHtKYwftNjVkDQjS5wGdS0G17FC6firrNd
         d4B7szWvLEJn6qVXU69FFQo27pjnPOJGgoU35SK3HncxhEXRNzfDuUE7Mc03TrfMks4S
         kH0s1D/fNlya5hiGvvcHVtPCXbEZ7E4WpJ5WQ5Ozv5JA/a8B0gCuHsSwZMSFVihWzD8u
         5lwrJTtvt7Z2Lz3jQ8M88qCUWMylAezZTgD+5GLNwkQKEd7GzkiciwRiVc+1dIlTqrf7
         L6HBBycXIQ8cRvDBHbaEYMlrsn+T/wygR7+TSzIB6rtmuf2HJO2wB7ATXkSNnJPzWUcg
         LkjQ==
X-Gm-Message-State: APjAAAUqpjkk8VoZn1nMFRmdIBHnbHOd8sTIGa3vjkNjk/AGD+qXAP6T
        IsZy/pFf0M8OiVJ+mRWGKvFzMbdRa2k=
X-Google-Smtp-Source: APXvYqyNjJkVxzmN6TCXRwTYugXUnJf6FP4OOiu/Yo1yUxNp8LvrrqW1IQqvt78oVPXJgibAGNmLPw==
X-Received: by 2002:ae9:e30e:: with SMTP id v14mr2697288qkf.344.1574882712617;
        Wed, 27 Nov 2019 11:25:12 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x8sm7782287qts.82.2019.11.27.11.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:25:12 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 27 Nov 2019 14:25:10 -0500
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/3] init/main.c: minor cleanup/bugfix of envvar
 handling
Message-ID: <20191127192510.GA21877@rani.riverdale.lan>
References: <20191123210808.107904-1-nivedita@alum.mit.edu>
 <20191123214039.139275-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191123214039.139275-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 04:40:36PM -0500, Arvind Sankar wrote:
> unknown_bootoption passes unrecognized command line arguments to init as
> either environment variables or arguments. Some of the logic in the
> function is broken for quoted command line arguments.
> 

Hi Andrew, will you have a chance to look at this patch? If you are not
the correct maintainer, would you be able to point me in the right
direction?

Thanks
