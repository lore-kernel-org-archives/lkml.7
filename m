Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952BBC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64470207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JLBkYEn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfIZU5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 16:57:00 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:38317 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfIZU5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 16:57:00 -0400
Received: by mail-pg1-f174.google.com with SMTP id x10so2190982pgi.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 13:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tqUJyFYR+MClyCsKadz5ZXTJMm7LM8Rd2AfAh/NUg9c=;
        b=JLBkYEn3gTupmMGajMZySkfyndxcsQNhtiFFe6XehJOcsaZ/9r8aKnqZG+JmvqnfiD
         oQKVFcz6+nhFMUU+QKFsGy7MmxWH/qS1Sg3LRu6MaFnzj+ytDTxv/BmDRp6K7F5pE1Qo
         sfQ0BrbxxFDGGjJK3K+5Prk77bYaCwDMPKTe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tqUJyFYR+MClyCsKadz5ZXTJMm7LM8Rd2AfAh/NUg9c=;
        b=FkHibA1d8Zuy4Mg37zIMykYydscjn/fWrvwiMGXukCzGHpzO7MAWEmrvokHoD4OGx4
         RaEPtQNyIK886M62dWkFFcgIQA3In68LUMfgqGTXpHsSAm+Mr8sfv2Fa7jnWfmeiKPV9
         wxNDpav03xzdUUrQ8IcIdvQsYZxeoqnD+K3mif+C254MvKmlG2aYEsXY+aOXG5DcWANb
         4X4QykAHug2vxeySNrKIA5srg/NZk1Drb0X8pLhqq9xYfiOO8WsRpU7qT19TlDdBqcM+
         TArFK3h9sTDpxxyyTNKqm7yO1uingqfAEuc2OBRe2J8ZIHpPZ3h4K2iCUM2+F45a/ISq
         V5lA==
X-Gm-Message-State: APjAAAWaiewGXu52RZdC01dLUBX35DEE4oEHszFJ3/gJsE4e22sM2Mtn
        /ciO2+imj4AgbhS21nFTSe16/naXbNc=
X-Google-Smtp-Source: APXvYqwK7jUdBK7tKCjMiZG7L/ivCuIY2uGk8FRGvRgmFkL0mDFYA5Bven6QmEobIxDMh4Z+NKTA6w==
X-Received: by 2002:a65:404b:: with SMTP id h11mr5406413pgp.237.1569531417922;
        Thu, 26 Sep 2019 13:56:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k8sm2734650pgm.14.2019.09.26.13.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 13:56:57 -0700 (PDT)
Date:   Thu, 26 Sep 2019 13:56:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Joe Perches <joe@perches.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [GIT PULL] treewide conversion to sizeof_member() for v5.4-rc1
Message-ID: <201909261347.3F04AFA0@keescook>
References: <201909261026.6E3381876C@keescook>
 <CAHk-=wg8+eNK+SK1Ekqm0qNQHVM6e6YOdZx3yhsX6Ajo3gEupg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg8+eNK+SK1Ekqm0qNQHVM6e6YOdZx3yhsX6Ajo3gEupg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 01:06:01PM -0700, Linus Torvalds wrote:
>  (a) why didn't this use the already existing and well-named macro
> that nobody really had issues with?

That was suggested, but other folks wanted the more accurate "member"
instead of "field" since a treewide change was happening anyway:
https://www.openwall.com/lists/kernel-hardening/2019/07/02/2

At the end of the day, I really don't care -- I just want to have _one_
macro. :)

>  (b) I see no sign of the networking people having been asked about
> their preferences.

Yeah, that's entirely true. Totally my mistake; it seemed like a trivial
enough change that I didn't want to bother too many people. But let's
fix that now... Dave, do you have any concerns about this change of
FIELD_SIZEOF() to sizeof_member() (or if it prevails, sizeof_field())?

-- 
Kees Cook
