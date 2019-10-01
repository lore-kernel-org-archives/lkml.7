Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43615C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C35D20815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g5QA2RQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbfJAS0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:26:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37066 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731034AbfJAS0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:26:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id c17so10262859pgg.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zqsAipJBT/+l6hHcipqnKpFpMM4A80W4tvsIakuG5CE=;
        b=g5QA2RQoe+ZqGhmmwzTRV8KB6BVTAuTsSyf3gaXExsBraZ1sXNs+w6QTQFAeTULPBP
         PaoUbh+njFeHRfH8CiwTrxIdbQPqR7Sm1kxQgXUltqo/Oa61SemzAOELrxcRBHfJ6cvi
         fWpNairMz6FZah2H/4t2m/96PvOOjygR4rPyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zqsAipJBT/+l6hHcipqnKpFpMM4A80W4tvsIakuG5CE=;
        b=dPEf5B7CAmoqmIbZKRiBfhBH4Eong8OneFsnhMrbRe+mwceReROoVGmqk93OIQgg1l
         alQzmmn9VNJM9590Ht2w++zJwPC+RPsbtcI3Sf3CoJhFGU+iCGZKWu6ZJPRtoiIRaa1C
         Q99YVoYs7D+SrX5k0FEI7P7bM1yCbF5Us4M6iWzarfeECtVyKtrM9KBAcwdh6/N0rEbL
         zwi77EE0vSZ6C7hWPygiUq5tFzHAGIpAoqa65pOfXepqIBNAY3/UiXxBqPC3WpJ++rV4
         yXNL/eN6LhknFtf8ZByhRUjnaG68lg5s9ieBMwMWeOyE1oHU36AtFL5aQPz6qi9xlcVo
         VQrw==
X-Gm-Message-State: APjAAAVohQ9PeGJbj9TXXpcXrVRjwfBZ2yY+DLxG+SWlPJj8CMX8scJa
        am/pC6d8IemyPGTRJlrFclM4Ug==
X-Google-Smtp-Source: APXvYqyIpgN6OMZZun5BSeRfWkyvMJAYXr0Kg9rgz1eEcJUaLgX3ig+qYOn4DUrT3tL82rBWIejrOg==
X-Received: by 2002:a17:90a:28c5:: with SMTP id f63mr7051535pjd.67.1569954366452;
        Tue, 01 Oct 2019 11:26:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c8sm16082912pfi.117.2019.10.01.11.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 11:26:05 -0700 (PDT)
Date:   Tue, 1 Oct 2019 11:26:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] docs: Programmatically render MAINTAINERS into ReST
Message-ID: <201910011125.AF5245230@keescook>
References: <20190924230208.12414-1-keescook@chromium.org>
 <20191001083147.3a1b513f@lwn.net>
 <20191001120930.5d388839@coco.lan>
 <20191001113506.12720205@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001113506.12720205@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 11:35:06AM -0600, Jonathan Corbet wrote:
>          for line in open(path):
> +            if sys.version_info.major == 2:
> +                line = unicode(line, 'utf-8')

Ah-ha! Thanks. I've sent v2 now. :)

-- 
Kees Cook
