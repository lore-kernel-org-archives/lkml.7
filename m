Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32C4C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6F4218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/9AaR+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfGCLqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:46:33 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39691 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfGCLqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:46:33 -0400
Received: by mail-oi1-f195.google.com with SMTP id m202so1797891oig.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 04:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mYCFppVyTLYn4jIWsRodglihiRKb1A76Dy+J8v19wzc=;
        b=D/9AaR+4ugUBBoe5/1T1+ZEwBrg3e3P4WhtXCOVCc7lRsXoCa76A7XhNR0j7h1SCJU
         ZhQ8En4MthdgoIQtVTcxsKV/bApkPtLlwcJ7GYSPzh9P2IRq9NzjA7PEu9sC7TNSCddQ
         FVvPmsxBtpYPwOsdA74BIXEpzq0OmWT1vx6C7YBcT8fF7hzaXA0Evginy/jJI1uJ9zbC
         zL14fynQYfCMydKMRLXIb73eCcvdkGE1i8pa7xeIfaAn1Do9Z6Lx7tGQms0O637oz/Ix
         yU+KnN7NhgWUn+dUA/5/VSg5HNp4LXLUkLG4jEQupWEZuDvgWX9pjdSSX8PdvbNW8/Hq
         xwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mYCFppVyTLYn4jIWsRodglihiRKb1A76Dy+J8v19wzc=;
        b=ml49HlF5sCdwUBuXHEpAUZgoLylyB5xfH/Cp1NmfZmeRWRcQ/PLKJlfDdsj5/ubJfW
         soo7gjBSjdXq88SjpOT+wMQf4jdL9IHF1MxwVw5SbRZXdJ9QlU5KdnWwIKnqHP/SD1VR
         ngrverAAM2WYNbqp0/Ocv2EkTGXViO0t8lWw4YuKXTTfQrNZgGhV3kqfLyi+w60+SUEy
         tuzwS43gXWgaEdi+QawGJWwLXM3MlZt0neeJcsBLzH12gp+H6Kw0+ZxTBU1/CCSJoNVE
         GH5PYTPcYThn28EqykY4+NvHfRyivUEXZACbK8BrFyEOvEw/+Bg3IVjw0FuXAh6UF6u/
         PzSQ==
X-Gm-Message-State: APjAAAVanB+VYHblnZoyT3RBHBxaVLPTFPdpbmL1E9VbSD6t9RfQl7Ek
        yilwe1MB8CtVncWb1iJ3xz7PaBnWQy/Q0w==
X-Google-Smtp-Source: APXvYqwX7as5iFvdGwU6iDuxDN356j60jVpv0gxRnDRYGhYLxaoZipVDwgA728jdYwbcktjADrrxZw==
X-Received: by 2002:aca:c715:: with SMTP id x21mr3307037oif.142.1562154392368;
        Wed, 03 Jul 2019 04:46:32 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id 198sm692180oie.13.2019.07.03.04.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 04:46:31 -0700 (PDT)
Date:   Wed, 3 Jul 2019 19:46:25 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] bpf, libbpf: Smatch: Fix potential NULL pointer
 dereference
Message-ID: <20190703114625.GG6852@leoy-ThinkPad-X240s>
References: <20190702102531.23512-1-leo.yan@linaro.org>
 <b834fba1-5b2c-4406-8275-1cf8383655e3@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b834fba1-5b2c-4406-8275-1cf8383655e3@iogearbox.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 12:23:05PM +0200, Daniel Borkmann wrote:
> On 07/02/2019 12:25 PM, Leo Yan wrote:
> > Based on the following report from Smatch, fix the potential
> > NULL pointer dereference check.
> > 
> >   tools/lib/bpf/libbpf.c:3493
> >   bpf_prog_load_xattr() warn: variable dereferenced before check 'attr'
> >   (see line 3483)
> > 
> > 3479 int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
> > 3480                         struct bpf_object **pobj, int *prog_fd)
> > 3481 {
> > 3482         struct bpf_object_open_attr open_attr = {
> > 3483                 .file           = attr->file,
> > 3484                 .prog_type      = attr->prog_type,
> >                                        ^^^^^^
> > 3485         };
> > 
> > At the head of function, it directly access 'attr' without checking if
> > it's NULL pointer.  This patch moves the values assignment after
> > validating 'attr' and 'attr->file'.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 197b574406b3..809b633fa3d9 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -3479,10 +3479,7 @@ int bpf_prog_load(const char *file, enum bpf_prog_type type,
> >  int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
> >  			struct bpf_object **pobj, int *prog_fd)
> >  {
> > -	struct bpf_object_open_attr open_attr = {
> > -		.file		= attr->file,
> > -		.prog_type	= attr->prog_type,
> > -	};
> 
> Applied, thanks! Fyi, I retained the zeroing of open_attr as otherwise if we ever
> extend struct bpf_object_open_attr in future, we'll easily miss this and pass in
> garbage to bpf_object__open_xattr().

Thanks for the info, Daniel.

I checked the link [1] and thanks for the improvement when applied this
patch.

Thanks,
Leo Yan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=33bae185f74d49a0d7b1bfaafb8e959efce0f243
