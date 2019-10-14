Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FEDC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B3B21848
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="IKeG2jcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732533AbfJNOLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:11:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41492 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732117AbfJNOLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:11:53 -0400
Received: by mail-qt1-f195.google.com with SMTP id v52so25591238qtb.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IvIenCJzHo+g6OuA9cd9X9mP9xzIp/N5yCxiJYUBY1E=;
        b=IKeG2jczIn2/hbGefzwpalyXwOL8I+IESSyz5oZ01wurpwW2JDCrN4F/0afk8J0ICv
         x1Jln5cdJNzG+zcDKpTfDcARI48mI/w3twXA2UfxL7uboKEegSKBC8rYgI1cwq/Z9Dwj
         zeiwXie7Jk+bgfZucCxYe2J3hZwv86IqqE0v0d4lf/RnDH2MzKMKaNd57qSEuw13OV9q
         6uQUvOvuJaq1frTPCkrQSrK3+k8uePioSqhhIf5vn9rblfzNF/5TlyodPDjrSEgn8DTf
         35hWJ5qnW2h1CXcNLNDNA3elqgdoRB1BbEueSd+dLvA9/ROKf+tQ/nVzL0rjsedbjt9Y
         bTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IvIenCJzHo+g6OuA9cd9X9mP9xzIp/N5yCxiJYUBY1E=;
        b=U00SNU0DE26yJ1M531vh3QN273h6aeMpBfl31N3mmb/256IllHVlH/jBxalqHrp+Ji
         4ehSFtEUxWx4FetwVQwOHDKXNyf2cf9U3Uj4wdXbjGI7gpa22MxX1NSrpjT/sAPT3yls
         4XL/LQicXNYkfi3Hl+HryNMJzVAacR1e6Bbp0ZQeaZI60teRPArzwNf6YtVwJ5PXD2rS
         j02NGGpaXH6ZcGczZOWqA5fMXM8+QedYeHGdndJUSSBGE1iVG0m0DARao5Fq3e6WpbSG
         Gmp3NH9pWTS44byY/lMY1YDot0qQUquex0hRYXt6THVzOPDv8QYRQLvjPZ1bbttLScby
         gxbg==
X-Gm-Message-State: APjAAAWaA19bJcOsiz8O2Yw535Oojx0IehOv9GVsdI8LdqmotArZ6tWN
        EpreOjTKbH9MVRYXq1B1GlVqcG8I0vo=
X-Google-Smtp-Source: APXvYqwXMuAgZT5Grv+lwbM536hV1aSfFcio2x7Rt1wCSc7KtXRsEK1CgTF9G8o1bR+6eWoKeEuNzQ==
X-Received: by 2002:a0c:e5c1:: with SMTP id u1mr31058635qvm.206.1571062312767;
        Mon, 14 Oct 2019 07:11:52 -0700 (PDT)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id x19sm8223186qkf.26.2019.10.14.07.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:11:51 -0700 (PDT)
Date:   Mon, 14 Oct 2019 14:11:50 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     James Morse <james.morse@arm.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com
Subject: Re: [PATCH v6 02/17] arm64: hibernate: pass the allocated pgdp to
 ttbr0
Message-ID: <20191014141150.xt6z3gs3cu3rl3go@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
 <20191004185234.31471-3-pasha.tatashin@soleen.com>
 <bb937db3-f23a-809b-4ad8-ca86f689554d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb937db3-f23a-809b-4ad8-ca86f689554d@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-11 19:17:22, James Morse wrote:
> > Fixes: 0194e760f7d2 ("arm64: hibernate: avoid potential TLB conflict")
> 
> (That was a 'break before make' fix, the affected code comes from:
>  82869ac57b5d (""arm64: kernel: Add support for hibernate/suspend-to-disk))
> 
> But, it works in all one circumstances its used: we know all the top bits will be zero.
> I agree its by accident and we should fix it.
> 
> I don't think we should send it to stable.
> Please drop the fixes tag, with that:

OK

> Reviewed-by: James Morse <james.morse@arm.com>
Thank you!

Pasha
