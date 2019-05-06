Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2415DC004C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 00:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60BE2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 00:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulnKpUjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfEFAGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 20:06:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35958 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfEFAGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 20:06:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85so5559325pgc.3;
        Sun, 05 May 2019 17:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lPj1huXJr/S2Uba/xzc3MwDOA+d1UVBD7EVoVCzxZ3s=;
        b=ulnKpUjZ2DYGF4G0QwuKvKlOCJBi+CayvUEKyxqdgsSGIhvTdFFhZfBItg+uipBZrh
         MreexvWAtzWdWP60o8sBRt3aXMIV/fPFVA+2csjz21hM/DwmB/7k8IEZHHSNRb2/jnsG
         LrwC2KVO72wlNtaBlpNdKFw5tjrmIYBRFEBQmH1j2prdewGMOzr1WFMMMWUzqqf5FX6C
         5gayLXTu3RsoRU9+xoJ9KE7z2ozIAsonpKn/wrSKFTWwUcIfZfqUbMdGDSsdaM5mvx5s
         1l+XkmLOoz/9xjrYfLPF4GgnEl9zlfnbLM6naducweIT90q6B0bJLxX5sZu7g/G5fnxM
         baTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lPj1huXJr/S2Uba/xzc3MwDOA+d1UVBD7EVoVCzxZ3s=;
        b=k8pR+lgjs+TmOvXuKeQKl1Z9ZKyHCVxJDcMP22qR1vVxtRWDvULGKq9P+9SQirx9wC
         2kb0YnsihUsJj3rcUwV2xTQGsSA+Bw/JI3U4DywqrSi7XS6ZW+MHBhmFnPwtC03/eeEb
         BDdWW4wVhtL9ZSaQY4/QCsRHtOYGyuAEMmCO2wn4FTgp6yR+tMrAADyr5leSTF0XsbaD
         Y4x0c6dCvDRYZwJGPOxOaIgH7zWRITt+q90G/0Y2NZyQfV8zYvsvhx3JKw6ReNNX2Uyb
         LrlRHbwQXCeftqDI+fmtUr/pBx87aO2nu4cUzhBHEypKAyDbCOm+eigE80AlRQ/UPabR
         TsNQ==
X-Gm-Message-State: APjAAAXdL1HYWD1Y77vtXklfbfTFiTUveqOgvwCHxj+9/9y9FwynmBUR
        uzqUHTk6f9KsOWWeqcTed2Y=
X-Google-Smtp-Source: APXvYqxY6R4fB1OBBDhpylDlbMrGQxT3o/02yuDwNMawkM9CJ79F/Zdx+6NGjxJ/5TDU88l80sJHbA==
X-Received: by 2002:a65:5241:: with SMTP id q1mr7514612pgp.298.1557101205306;
        Sun, 05 May 2019 17:06:45 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id e23sm10415448pfi.159.2019.05.05.17.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 May 2019 17:06:44 -0700 (PDT)
Date:   Mon, 6 May 2019 00:06:42 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Changbin Du <changbin.du@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/27] Include linux x86 docs into Sphinx TOC tree
Message-ID: <20190506000641.vno4r4ky7azd2ldl@mail.google.com>
References: <20190502070633.9809-1-changbin.du@gmail.com>
 <20190505130219.29bd72f8@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505130219.29bd72f8@lwn.net>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 05, 2019 at 01:02:19PM -0600, Jonathan Corbet wrote:
> On Thu,  2 May 2019 15:06:06 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > The kernel now uses Sphinx to generate intelligent and beautiful documentation
> > from reStructuredText files. I converted all of the Linux x86 docs to rst
> > format in this serias.
> > 
> > For you to preview, please visit below url:
> > http://www.bytemem.com:8080/kernel-doc/index.html
> > 
> > Thank you!
> 
> So which tree was this generated against?  I was gearing up to try it
> out, but it doesn't really want to apply to docs-next...
>
This is against the mainline. Let me rebase to your tree so you can
apply them clearly.

> Thanks,
> 
> jon

-- 
Cheers,
Changbin Du
