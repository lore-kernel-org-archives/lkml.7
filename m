Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A34BC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63741218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ER5DZCF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733199AbfJJHiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:38:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41782 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733029AbfJJH3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:29:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id t10so2347946plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 00:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=05Mh4YPHsTH+RTt+Qtg69xp7FFLkdaUozJGhC0YlXGQ=;
        b=ER5DZCF2audQq9jfWItaA9FNvhauCu7VAINlpo+d1tC7rNqNG8NL4kwTqwRNVOoAPZ
         E2qKEmMfAZioOzAH2zZJxQf0ao/IsDfDOyyzWCQfoI4N2loqkj9bRP4jGdY0X6EXb6v3
         opzkIQIHjYXPvucQaVgIW7zn52d0NTJlYsutLWYgBzgODlh114zqrRGak703hwu7tWOI
         SQqiqcpyrr2TL6nKvCxCJ8TnWZd91jBrfZYJRj+sqIGH2H65esJz4JNKakl0pCuEsowV
         9UOqF6i7P6FFuV+zmrA58zzDnlXmM6TvF8GJYAuKSmu8xmyX4iBm0WaaeLmRe553vwo3
         HOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=05Mh4YPHsTH+RTt+Qtg69xp7FFLkdaUozJGhC0YlXGQ=;
        b=eEEgVHo8VtB004gc45vmbQj6H9mPBaY/dCkuC4WvXIkmrUn2x/qWTLOayobVXHcdY/
         wVvC1kk6NiNKb9n1+lT0dTk6knMNO79mRVLusW16iMApVm+SYWyvdasMM22HQj/00N8O
         UC6zuk+nGQvTlOVXjRAR4vbM9N7SeMMXQkxGkoQRH0PPYetEGGC887ssy7QP160fPCDX
         CpovggJgaERVtpIczQfpNgOxtL4eC59bGiiLkZsIUftEcXT0b+pisyVFL+5bw16NnuP8
         YKNzySALkhrjUYymG6M0mbSKzxBFLvoa6InY6sn7j4v9dHDWFxZH16iQiT9qcD3ddYlY
         Ul+A==
X-Gm-Message-State: APjAAAUm7VqBb/wf2MvUhTJdWKvYoDsBy3F0g24hDZIUsKpSBUQxBkUK
        We3Xk9/YWjijDzoiIhfQm+nh/g==
X-Google-Smtp-Source: APXvYqzNWwK2RGbc8g4ooHkVXyPrtB6leFym4J8u95Vna828pG9j0iBhuG3XemmKc0PtjS4L8ePu2A==
X-Received: by 2002:a17:902:d90e:: with SMTP id c14mr7904837plz.91.1570692557898;
        Thu, 10 Oct 2019 00:29:17 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id v8sm12676039pje.6.2019.10.10.00.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 00:29:16 -0700 (PDT)
Date:   Thu, 10 Oct 2019 12:59:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Kamil Konieczny <k.konieczny@samsung.com>
Subject: Re: [PATCH] regulator: core: Skip balancing of the enabled
 regulators in regulator_enable()
Message-ID: <20191010072913.jsjdl6uc4qkbmlpa@vireshk-i7>
References: <86b9b4b5-cca5-9052-7c87-c5679dfffff4@samsung.com>
 <be8d3280-9855-ed18-b2ab-d7fb28d80b82@gmail.com>
 <20191008161535.GN4382@sirena.co.uk>
 <4ad890b7-705e-94f9-2e61-1f3a60984c91@gmail.com>
 <20191008171747.GS4382@sirena.co.uk>
 <439154a4-1502-40af-7086-d4e3eb24025f@gmail.com>
 <CGME20191008180759epcas3p3c367142db499635c71d9601dd3e63956@epcas3p3.samsung.com>
 <20191008180750.GT4382@sirena.co.uk>
 <c9e3ff21-ec50-97c2-06cb-b2f44c70eac8@samsung.com>
 <20191009141352.GC3929@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009141352.GC3929@sirena.co.uk>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-10-19, 15:13, Mark Brown wrote:
> On Wed, Oct 09, 2019 at 12:29:00PM +0200, Marek Szyprowski wrote:
> 
> > Okay, then what is the conclusion, as I got lost a bit? How do you want 
> > this issue to be fixed?
> 
> We should revert the enable call, it shouldn't be required, and ideally
> the default balancer could be updated to only make configuration changes
> if they're actually required which would help avoid triggering any such
> things in future if we don't absolutely have to.

Sorry for the delay in responding, just came back after vacations.

Should the OPP change be reverted ? Someone going to send that revert to me with
the required explanation ?

-- 
viresh
