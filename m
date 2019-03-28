Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B479BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A582173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sns0YJNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfC1HDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:03:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46649 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfC1HDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:03:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so671785wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 00:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Z1jw8O7bagYidcrSn/bhbJgndiFK0TLqSgd35GZnOBw=;
        b=Sns0YJNvDhpgZDniGdce2pkxrafYM9Am1XoZqlq4nm5o/bQeB9EVrLJTOF25QOpttN
         qN0Ca3VPp1ph7Lxuk6VMEWw+3sTBNqgBXYD6JxSRyKkxB4pC9j2IdCbr9ABa24eQCA3I
         vJVLEBk0jMKdBABeRxIf2d39qcsR2bsOT4zQAPUiUqxMWDtHWtuhJHxH4a9eEsRRWx/P
         lYs5l2cDmZG20yUkg8lVB+RSBq1zMlYw2cLOP3n5rP56wrKInGc3v9Ry3DOkExskl9uD
         oECHyjYKAf3802bJeFTNN1TbaSQOCaSDL7UReTAKz8Rn+D0BP8CYuhywOL9WCcsY2GhC
         28xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Z1jw8O7bagYidcrSn/bhbJgndiFK0TLqSgd35GZnOBw=;
        b=GFl2HBmksZcvCVVvHzNsn3jGJHFqn9mvDKKBqphKcVFxpFT7WHimBl42SZe3xOA1fk
         UFLGIe5f0N8NSfueFVVWab4Is1IXJV9+HG6RnCXryiXzh2uu4I8txgU8C9+TqNPHxJXl
         4CdxMpB1Ascey3t/4/wo57UxXH5AWDFcLQ3KX/BqApbM9gIfTQwfNpYlh0h0xVSTslQq
         AocY62jkvd5HvvRd/OaHuyrIDPQ9cKvFEG0rVq2nLlFN/qsxUtViXyDcuRsvel/rY9aW
         mpvO6Mk2lVxaYohKM0aXpEvL3xrFpW0SAEFrtjv4WK4fv3+GseqrBgj4I/EnNV/qg7NC
         259w==
X-Gm-Message-State: APjAAAVVnhYuouqg31bENgIliO+prZV4mFuRWLtAoWepbLQyJzsTiqUN
        IQ+dwHd4PKXMpvecdXGFC2UuEw==
X-Google-Smtp-Source: APXvYqyaMc55VP7uOSrSN3s8VcM1TmrWFdGDKHAJ8vaqK+WtD9L6cZQNs6cfI2XQE6efF6GaglzXtg==
X-Received: by 2002:adf:82aa:: with SMTP id 39mr22694539wrc.305.1553756588026;
        Thu, 28 Mar 2019 00:03:08 -0700 (PDT)
Received: from holly.lan ([185.201.60.219])
        by smtp.gmail.com with ESMTPSA id 61sm49733954wre.50.2019.03.28.00.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 00:03:06 -0700 (PDT)
Date:   Thu, 28 Mar 2019 07:03:02 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     qiaochong <qiaochong@loongson.cn>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-mips <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: KGDB: fix kgdb support for SMP platforms.
Message-ID: <20190328070302.uv7r2fuyvgplcmvu@holly.lan>
References: <20190327150551.12851-1-qiaochong@loongson.cn>
 <CAD=FV=WAvzz+wXZzoLZvxBhO4P_RjV2op=uiX9dHD2dPdSCruw@mail.gmail.com>
 <727cd934.9e92.169c1422cf2.Coremail.qiaochong@loongson.cn>
 <CAD=FV=UhqQh2i1CUfgGHPdUtFWsTznCL_1tNafG+F74oHXM1Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UhqQh2i1CUfgGHPdUtFWsTznCL_1tNafG+F74oHXM1Ew@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 03:27:26PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Mar 27, 2019 at 3:25 PM qiaochong <qiaochong@loongson.cn> wrote:
> >
> >
> > My name  is QiaoChong， which is same to my username.
> > Qiao is my family name.
> > Thanks a lot.
> 
> I guess it will be up to whichever maintainer lands this (maybe
> Daniel?)

TBH this is mips specific so I'd expect this to get picked up by the
mips arch maintainers. I'll send in an ack in a moment though.


Daniel.


> on whether they want you to spin it.  I think folks expect to
> see a real name that is capitalized and usually a space between the
> family name and the given name.
> 
> -Doug
