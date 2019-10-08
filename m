Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB179ECE58D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 03:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C56217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 03:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LU2lPXf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfJHD3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 23:29:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33733 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbfJHD3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 23:29:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so10000062pfl.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 20:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r5rY61uv0TbBekYVBoIpJ8HVOvZlHLYXTkq5V4p7fCg=;
        b=LU2lPXf7sxL6J2e6wTkTDrQeeog+JxhAgKTIIWv9q8Ytt3/107/c6qbGeoWBEeZZ+v
         oMvYZZqJ9ypOk6rnaKnklRhw9WIiEdocCp7ve4tdUyTn3MccriyPQb088k0B4sz/9/nd
         3Sm1OrcB/h1SFsHtrmMFmoGKHGTtj2uYb6kkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r5rY61uv0TbBekYVBoIpJ8HVOvZlHLYXTkq5V4p7fCg=;
        b=ROQ+zCSxLdS9qHDCXp8wbRVl4mHETbREeyzwU8p4XyKHOW5BvUENY09iFxFxV9w321
         01GO/VjVNSz7UsXuAbfXPJP3DB929kG3420XecWuaY0ww8ZosGRAJpI/B9uqEBLC75AC
         9qQUg7Y1MQj7tPkiheHP9nrJ/OsP56LZHuaaSI3KqDxmnvsUkW/J0WafVL9dPzP4LN4A
         IJhpLEcVTgMkKegYx2sArbkwVgsNlXntDVR9oLAnb1ABF/LZYNnwtNS6DfCM5DcAB4YS
         qIglY5E5AC1vk5Zcp/M9wQVf+fSrzY6bPRKDQbRj1c6LpqDyuDZ3GdypdIVG7docae6n
         j0GQ==
X-Gm-Message-State: APjAAAVS3ieOeoXl0d0EhrWceHSx+VCQXC0nrgmwykonfT6wWjTEYWrx
        84unmif84wqGrKywdHvNLZakcA==
X-Google-Smtp-Source: APXvYqxbDbVLe1YIwV3eUnWXg4A3HRU9Iqjt0HY6IkSzyLI4VO66EII/A2LwB+c7qQL01M6ejs5ucA==
X-Received: by 2002:a17:90a:db47:: with SMTP id u7mr2947520pjx.40.1570505378971;
        Mon, 07 Oct 2019 20:29:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r24sm15647308pfh.69.2019.10.07.20.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 20:29:38 -0700 (PDT)
Date:   Mon, 7 Oct 2019 20:29:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, brendanhiggins@google.com,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/list-test: add a test for the 'list' doubly linked
 list
Message-ID: <201910072028.C7AB93651@keescook>
References: <20191007213633.92565-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007213633.92565-1-davidgow@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 02:36:33PM -0700, David Gow wrote:
> +config LIST_TEST
> +	bool "KUnit Test for Kernel Linked-list stuctures"

I missed this the first time through: typo of "structures"

-- 
Kees Cook
