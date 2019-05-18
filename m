Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118C2C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 06:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73A62166E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 06:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ySHFdMXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfERGil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 02:38:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56120 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfERGij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 02:38:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id x64so8720090wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 23:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UjvV69Pw38TY+UWCm958W3BhSAELE7Lrbyek85Eb+1Q=;
        b=ySHFdMXrg33fBSHehaQMTmzJVaqwtm+OJZocGViEljI8nlSfI28hu0S4MMER2QcMZK
         vk5yH/MYOXm5qtMxKvtGUORTVQx90c/v9BAksqNfMJe8tqNDsQ5wKV2BO1vJ4fY97Ntr
         Kwut1D0y0jHyK1mdhN7xpam0WMKzVFLvwSMAlXydRFkD0MMzCihW72p4fEMRE/p9Psc3
         nm0D6NPG1oU0S9fVYGvRdA6/TfmcJ8zp6DgkF5kJOZGv/WWJYtIRQPIAlL9b/ObdeZLE
         jrtZewLcINorntjfth3JxuckQcPW8F/qjJt6cc95bcdmokb+V3PIOwNdq5uFiF3R2x8E
         0cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UjvV69Pw38TY+UWCm958W3BhSAELE7Lrbyek85Eb+1Q=;
        b=n9/OY/36BZBIUeUZpYJAcy52Yn7Qd4MjdJO9n31pVSi0Dp0tmTqatK1i9fEMrv4cCd
         AFtjJQhWHw31h1uCyqNC4TlBR9IX921RrH612qoqyji/R4Wa0ckLLTv0T4mJm6ZY6Y4x
         S23mizXaLn+4jvuxyHSkvr2vlY5JQJJ192NAVwQfFeduilAOmQbGwJ3EYj50DwKP4Bwu
         vY49ux7TVxEsDVafMax6DzUT29Et2Qan2nU7ZPkuqUOhSekH/SsXoYj38aUoVaDqlGzW
         NEVMUCIcw/Gd2SQyt+j+STb43LTv4TDAgRf5VYi2mNBbTB+TqWKIvUfTHM8gP8d6ocn6
         1YBw==
X-Gm-Message-State: APjAAAUly4TpwcHDPGMn/1FLnhRXeKIFnKbKDjaMU7fpU3Ey+zC6b2h3
        At9Oiu0PUxttCGl2E4YDDKzccw==
X-Google-Smtp-Source: APXvYqwNDJIp4PvB+a8yC5VIFYDeUcjM+xuvOJLOkzug9UL4qIro5CmakUjLQd5a+rNQaZRi8yCwEQ==
X-Received: by 2002:a1c:48d7:: with SMTP id v206mr35374564wma.38.1558161517515;
        Fri, 17 May 2019 23:38:37 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id m206sm12881593wmf.21.2019.05.17.23.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 23:38:36 -0700 (PDT)
Date:   Sat, 18 May 2019 07:38:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: Variable to signed to check return code
Message-ID: <20190518063834.GX4319@dell>
References: <AM0PR07MB4417C1C3A4E55EFE47027CA2FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
 <20190517102506.GU4319@dell>
 <20190517202810.GA21961@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190517202810.GA21961@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019, Theodore Ts'o wrote:

> On Fri, May 17, 2019 at 11:25:06AM +0100, Lee Jones wrote:
> > On Fri, 17 May 2019, Philippe Mazenauer wrote:
> > 
> > > Variables 'n' and 'err' are both used for less-than-zero error checking,
> > > however both are declared as unsigned. Ensure ext4_map_blocks() and
> > > add_system_zone() are able to have their return values propagated
> > > correctly by redefining them both as signed integers.
> 
> This is already fixed in the ext4.git tree; it will be pushed to Linus
> shortly.  (Thanks to Colin Ian King from Canonical for sending the
> patch.)
> 
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> Lee, techncially this should have been Reviewed-by.  Acked-by is used
> by the maintainer when a patch is going in via some other tree other
> than the Maintainer's (it means the Maintainer has acked the patch).
> If you are reviewing a patch, the tag you should be adding is
> Reviewed-by.

Actually, that's not technically correct.

  "- Acked-by: indicates an agreement by another developer (often a
     maintainer of the relevant code) that the patch is appropriate for
     inclusion into the kernel."

And I, as a developer (and not a Maintainer in this case) do indicate
that this patch is appropriate for inclusion into the kernel.

Reviewed-by has stronger connotations and implies I have in-depth
knowledge of the subsystem/driver AND agree to the Reviewer's
Statement.  I use Acked-by in this case as a weaker agreement after a
shallow review of the patch based on its merits alone.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
