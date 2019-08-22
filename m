Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464EBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9BB233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566497873;
	bh=r/1VlgTTU+bbdqAYrwnFsHIzjIj0Qm+cprSwGdWYN2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NoFIuvdlMgsrLo+v2nyp0hwJTb+v9kP8vqmm2Xqbm1IDMSpVqKvr7NumyUOCFXTFL
	 uwmPjQvlOdgW6JsaYiwksduLQ9YhZvjRbCi90ElgjcGInPlQ2Gu/cBgR8gZbnO9BMu
	 QAAUCyl5b7gWRmsLO6xZVwFyOwR7aDEq+jqZnRIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390181AbfHVSRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 14:17:52 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:38107 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfHVSRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:17:50 -0400
Received: by mail-wr1-f42.google.com with SMTP id g17so6308706wrr.5;
        Thu, 22 Aug 2019 11:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1zPMvLZjjeedqtoVLYcJ8H3LXTpubsb7g+u61JjqB5E=;
        b=tGEEY7fUXQ86tpTVa8aYwPlG1uPbjmP/H9phL3cMBS34fkfozabNCwdcQlWbm1ym6q
         it/ULT+YARnQql/C5X0Ugs2lgT0P6mI8CbQFC4VNhx/XFqAUqIkB0ly6/qcPL+1J08Ls
         VVijwIhunGruVP1gyFM5dcdOauUVGy5JGGsR5MLv/xe8k/ZArIE2m5qMXIYO3HWtYl/W
         gyQoLYTUDJkv6mnhiuDkjvyOuXptYYQ3v2Q/qNeklMsDJCRkC1PYK4eewiuhcfzXqJB2
         RbpF3gpT2Aq8JzbKqgLW2N8fFAC3hF/4Mv3CmCk5QtILNtrsx/iW7sTk0VHkJ8hWaFMH
         6eqg==
X-Gm-Message-State: APjAAAXP4N6Di2U/5j0VGEOw4mDNe+o/5tnorP+1takAvUUQ6p8sRM3M
        8uozbK5e61Ezj5HhROK/Joc=
X-Google-Smtp-Source: APXvYqyDp8hB/RD73MCtKTelz5jl4AljBemJrdNs+yI1wwKK9WF0zm7Pb8XQvFkNHkgVIkqFJ6b+sQ==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr339649wrn.184.1566497868440;
        Thu, 22 Aug 2019 11:17:48 -0700 (PDT)
Received: from kozik-lap ([194.230.147.11])
        by smtp.googlemail.com with ESMTPSA id a141sm13083871wmd.0.2019.08.22.11.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Aug 2019 11:17:47 -0700 (PDT)
Date:   Thu, 22 Aug 2019 20:17:45 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     jonathanh@nvidia.com, kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
Subject: Re: [PATCH] soc: samsung: chipid: Remove the regmap lookup error log
Message-ID: <20190822181745.GB10900@kozik-lap>
References: <CGME20190821150548eucas1p15139f733b00e3a1a107efe39f6712fe9@eucas1p1.samsung.com>
 <20190821150539.31207-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190821150539.31207-1-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 05:05:39PM +0200, Sylwester Nawrocki wrote:
> In commit 40d8aff614f7 ("soc: samsung: chipid: Convert exynos-chipid
> driver to use the regmap API") of_find_compatible_node() call was
> substituted with syscon_regmap_lookup_by_compatible() but also an error
> log was added for case where lookup fails. On multiplatform the lookup
> will always fail on any non-samsung device so the log is incorrect.
> Remove the error log and just return an error code from
> syscon_regmap_lookup_by_compatible() which internally calls
> of_find_compatible_node().
> 
> Reported-by: Jon Hunter <jonathanh@nvidia.com>

Thanks, applied.

Best regards,
Krzysztof

