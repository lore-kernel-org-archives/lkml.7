Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA54C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 21:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B6420672
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 21:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsxZo7DH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfKWV0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 16:26:06 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38192 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWV0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 16:26:06 -0500
Received: by mail-qk1-f196.google.com with SMTP id e2so9449016qkn.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 13:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zw0DnjbSUiHO4CtkLBErDojQYl2nS7Oy3HZbKf7gLks=;
        b=ZsxZo7DHjv7labO7xzS1GWfJV1NGCKQFngNlUrTjCGl+QrZMnW8T9ED2/nzmLNFyN5
         AsJnoIGsY/xg2jk6Mbixe2wC9EJNju7pmCU4FF4qqvqEMuqega80o3OZPxgsY9GGxxOD
         FBB2np8mMSFW+D6abpX0SBlKy6j8poRvVkQoPCQ8GWiDai9ADLXLb/F4CYXzhgq7+kqy
         pYGq18XoaYj4bfTsR2vPIljnST0/RdFVB0t7I/TI2E0C+O9U5dKCG5U9Zz484YL2CIyO
         EkVHjkzUd4Fpp8KLufSWyrTNMc/uDpKbFCM4LQ7EBQE+W0XWB8icnkaWmAUHCoiA9/x0
         MOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zw0DnjbSUiHO4CtkLBErDojQYl2nS7Oy3HZbKf7gLks=;
        b=WcSnffZBsT4mMI/N6mhUcpq9C6aesS2XJP7jfbT7g2e1JnJkzcIq6lVjr0mquJ8VBk
         5wwLe4ulKy3h+3kwIY9RwqCyiuqIgT+WOfUTUexUZnxTrdXd+5fkpw9wBagTG8mF6g97
         2rj/30Zi/j5790z65CbVuoKQxSnrmG9wc5az/q+alXZSBUczXQD6huaWThMREg1WY139
         bpc0F/uce1WH8riHGLYDtWRwurEqOL7EmwV1Z8oG3UxizX/FM41vG/goHvZa+MxZh63O
         R5z2UaQgyTsQlG6CGoYQ5FpZ6DcbVwLlbs0vG1duF27ZKqb6irjLH/PCkz/LIRbQuL6X
         jp4w==
X-Gm-Message-State: APjAAAXeG4lysPqqC5U6BMeFMn0jK2vaUOXrA6G7icd1TaSVSzvS3/PE
        4AbAPTSqGcdO/xiBGFhhTgaTFLGiA5k=
X-Google-Smtp-Source: APXvYqwYdCYWJ5q9OM0AjtZwjDjkn7o4ecfX7mZA4oKcKQv2aNJu2Ltcm2/hm8LOQtzAyQ5Nw609aA==
X-Received: by 2002:a37:bf07:: with SMTP id p7mr16462362qkf.164.1574544365119;
        Sat, 23 Nov 2019 13:26:05 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c184sm914508qke.118.2019.11.23.13.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 13:26:05 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 23 Nov 2019 16:26:03 -0500
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] init/main.c: minor cleanup/bugfix of envvar handling
Message-ID: <20191123212603.GA131323@rani.riverdale.lan>
References: <20191123210808.107904-1-nivedita@alum.mit.edu>
 <c209b9af-2352-f476-d32a-ae761d8f709a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c209b9af-2352-f476-d32a-ae761d8f709a@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 01:20:07PM -0800, Randy Dunlap wrote:
> On 11/23/19 1:08 PM, Arvind Sankar wrote:
> > unknown_bootoption passes unrecognized command line arguments to init as
> > either environment variables or arguments. Some of the logic in the
> > function is broken for quoted command line arguments.
> > 
> 
> Hi,
> 
> You will need to send your patches to some maintainer who could merge them.
> Nobody browses LKML to pick up patches (other than bots).
> 
> See Documentation/process/submitting-patches.rst: section 5:
> 5) Select the recipients for your patch
> ---------------------------------------
> 
> for more info.
> 
> -- 
> ~Randy
> 

init/ didn't seem to have anyone in MAINTAINERS, I see that Andrew
Morton is referenced in that doc as maintainer of last resort, I'll send
them to him.

Thanks.
