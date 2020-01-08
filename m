Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071C4C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41C12070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bdoq5YxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgAHSBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:01:09 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36913 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgAHSBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 13:01:08 -0500
Received: by mail-pj1-f65.google.com with SMTP id m13so1407809pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 10:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XR36J4mDpO4U+TRkIgyEQycFtRJlUupvMB+eBkNGJTE=;
        b=Bdoq5YxMvQOdYiIJhMG/ucGPOj3k1HoZkdOzfa+bHUJY5Zh4vUvC+BSAk/4sG6X+1P
         lSYDFD1vuyO+jt4fEyhq6lnafPHwPjzqLRLzyMhe9Cwczepfe82gE/GKmy+cge/wzG7K
         47sx3BWKj/njxj+qt0AzxrkIWZVKmWuqyYsEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XR36J4mDpO4U+TRkIgyEQycFtRJlUupvMB+eBkNGJTE=;
        b=WI+uA2ZOWsVMl6cGsfVKpdth5M1euq6yHVJJfr0VIfFeunxJ5C/a+5RfDEogOWV2EV
         7Hap11idBVaV2ilcp1wT5DXvbrRujcapq+7Qsown1Acfq7B/aGjdsIY2Gdar1ggDs7Nr
         o7u88UjVjcGtcczpGImQ1ZtMhsVYhJ7spQoganjvixfvRMn2oSgdMaFHMHQflw38kAn6
         kUweSFsKxp+OyRurPuYg3rSS5PIMeVf3K/xUmLxSpaKgSIwC9G0iN5km5/kwMjvD1d/m
         5yAe/XxcQGRI4bPRx56pt+xt/YlOyK4U9anv+F8DbSLHu214bslhK3Wjs/lZJ3rhlwQQ
         HUPg==
X-Gm-Message-State: APjAAAUEiIAqQvuGWOHADpLWcPAHMo+jd8JTtjrQC0N3FZ8h/LDXD9df
        pc8Zu8EhOioQxiFaNjwIjLmEtQ==
X-Google-Smtp-Source: APXvYqwKSWlu5mH9ElQnrpkjL0cO3VWs76Yg6ELlKBevw+5BCPhWN+PvaWNC/uBNsTJ6R4nmrn/U4g==
X-Received: by 2002:a17:90a:d582:: with SMTP id v2mr5761263pju.59.1578506466462;
        Wed, 08 Jan 2020 10:01:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 20sm4386671pfn.175.2020.01.08.10.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 10:01:05 -0800 (PST)
Date:   Wed, 8 Jan 2020 10:01:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] fs: pstore: fix double-free on ramoops_init_przs
Message-ID: <202001081000.88F20E5@keescook>
References: <20200107110445.162404-1-cengiz@kernel.wtf>
 <202001071002.A236EBCA0@keescook>
 <d4ec59002ede4aaf9928c7f7526da87c@kernel.wtf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4ec59002ede4aaf9928c7f7526da87c@kernel.wtf>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:40:58PM +0300, Cengiz Can wrote:
> Hello Kees!
> 
> It's a pleasure to hear from you!
> 
> On 2020-01-07 21:05, Kees Cook wrote:
> > 
> > I think this is a false positive (have you actually hit the
> > double-free?). The logic in this area is:
> 
> No I did not actually hit the double-free. I'm just following
> the indicators from static analyzer.
> 
> > nothing was freeing the label on the failed prz, but all the other prz
> > labels were free (i.e. there is a "i--" that skips the failed prz
> > alloc).
> 
> I have noticed that. Thanks for clearing it up though.
> 
> The `kfree` I was referring to is in `err:` label of function
> `persistent_ram_new` in `ram_core.c#595` of `for-next/pstore` tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/tree/fs/pstore/ram_core.c?h=for-next/pstore#n595
> 
> Here are the relevant bits:
> 
> ```
> struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t
> size,
> 			u32 sig, struct persistent_ram_ecc_info *ecc_info,
> 			unsigned int memtype, u32 flags, char *label)
> {
> 	/* ... */
> 	/* ... */
> 	/* ... */
> 	return prz;
> err:
> 	persistent_ram_free(prz); /* <----- */
> 	return ERR_PTR(ret);
> }
> ```
> 
> So, to my understanding, if our `persistent_ram_new` call in `ram.c#583`
> fails, it already does clean up the `label` pointer in itself and returns
> an ERR_PTR back to us and our skipping logic does its job.
> 
> I might be missing something but it seems so.
> 
> Thank you for looking into this.

Ah-ha! Yes, I see it now. We have multiple paths to the err: label, and
I was focused on the kzalloc() failure path. I will get this fixed
better. Thanks!

-- 
Kees Cook
