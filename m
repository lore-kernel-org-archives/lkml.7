Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F581CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29FF20873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XrTv78wy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbfJ1TQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 15:16:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39072 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729844AbfJ1TQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 15:16:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id v4so7547757pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 12:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YSPXSTOSpxv1yaxuQaT5Z/snamQ3UPLVpR/GNVKZyJ4=;
        b=XrTv78wyxB+WL7DgcrU4qTx3rFmHfHORq5Wqvb0WLcOcIiyByiqbN4iVjr/pxBZOEN
         8UOLHHaCR1/GJk4yaW7aiaO5Si99pLRaACCwi1TwmINLCdhuXzNF5Q0ZGSdvy9Gnf7ms
         4eR1Oz1GCo7NVruxXZIt4pdJyHB862qthHSQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YSPXSTOSpxv1yaxuQaT5Z/snamQ3UPLVpR/GNVKZyJ4=;
        b=BX40WLpq+EDtsTaZ83qk8OHS/cvruqFLpyN6GFiipNLdl3Ep70Pg+VUSDhyC2KDHGQ
         ZEnz1vSnWmlzJJMDIBCT3CVXUTyxoTnrmNMjc7wJO9msbzW+Iq7EBAGAbQCs1voOyocO
         5+0c8+sNwvJ5sTygN7aLX6uAyW2VyaP+WsOP6S784GFdN4WmlQrYIpwCbC/6Bjnyn9gq
         kNlKCj8vVvGfRcTywWYhW8wpdJZkff1qoRqIQD6Un6E051UbYaqADEWlgyGN3TYn8ue6
         cNp8c+uiCE73KzEUS1fWTDObPEqy1VOFMJwk1peLPNpWwyfQbVTLSLTfcrzI+NYn9ch8
         xpIg==
X-Gm-Message-State: APjAAAXbYZLIyTmG+fbeE3h4iSInk8GDOQD7E71uB9pYKk+K2TNln4Lr
        r0Bb/XMa/v8fOdZ6ETie7Ek9Zw==
X-Google-Smtp-Source: APXvYqxLxVbOUNa3GZm81iUKQIbZeEyOTiZp0ezG3Uxy5NobwJg3BuOADNWx4XHj497rUqhm5a91rA==
X-Received: by 2002:a62:31c2:: with SMTP id x185mr22301320pfx.199.1572290199146;
        Mon, 28 Oct 2019 12:16:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9sm11206677pgs.46.2019.10.28.12.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 12:16:37 -0700 (PDT)
Date:   Mon, 28 Oct 2019 12:16:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     zhanglin <zhang.lin16@zte.com.cn>, dan.j.williams@intel.com,
        jgg@ziepe.ca, mingo@kernel.org, dave.hansen@linux.intel.com,
        namit@vmware.com, bp@suse.de, christophe.leroy@c-s.fr,
        rdunlap@infradead.org, osalvador@suse.de,
        richardw.yang@linux.intel.com, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        jiang.xuexin@zte.com.cn
Subject: Re: [PATCH] kernel: Restrict permissions of /proc/iomem.
Message-ID: <201910281213.720C0DB89@keescook>
References: <1571993801-12665-1-git-send-email-zhang.lin16@zte.com.cn>
 <20191025143220.cb15a90fe95a4ebdda70f89c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025143220.cb15a90fe95a4ebdda70f89c@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 02:32:20PM -0700, Andrew Morton wrote:
> On Fri, 25 Oct 2019 16:56:41 +0800 zhanglin <zhang.lin16@zte.com.cn> wrote:
> 
> > The permissions of /proc/iomem currently are -r--r--r--. Everyone can
> > see its content. As iomem contains information about the physical memory
> > content of the device, restrict the information only to root.
> > 
> > ...
> >
> > --- a/kernel/resource.c
> > +++ b/kernel/resource.c
> > @@ -139,7 +139,8 @@ static int __init ioresources_init(void)
> >  {
> >  	proc_create_seq_data("ioports", 0, NULL, &resource_op,
> >  			&ioport_resource);
> > -	proc_create_seq_data("iomem", 0, NULL, &resource_op, &iomem_resource);
> > +	proc_create_seq_data("iomem", S_IRUSR, NULL, &resource_op,
> > +			&iomem_resource);
> >  	return 0;
> >  }
> >  __initcall(ioresources_init);
> 
> It's risky to change things like this - heaven knows which userspace
> applications might break.
> 
> Possibly we could obfuscate the information if that is considered
> desirable.  Why is this a problem anyway?  What are the possible
> exploit scenarios?

This is already done: kptr_restrict sysctl already zeros these values
if it is set. e.g.:

00000000-00000000 : System RAM
  00000000-00000000 : Kernel code
  00000000-00000000 : Kernel data
  00000000-00000000 : Kernel bss

> Can't the same info be obtained by running dmesg and looking at the
> startup info?

Both virtual and physical address dumps in dmesg are considered "bad
form" these days and most have been removed.

> Can't the user who is concerned about this run chmod 0400 /proc/iomem
> at boot?

That is also possible.

> Maybe Kees has an opinion?

I do! :) System owners should either set kptr_restrict (or the CONFIG),
or do a chmod.

-- 
Kees Cook
