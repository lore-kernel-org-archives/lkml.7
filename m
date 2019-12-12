Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1244EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 23:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB27D214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 23:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uqu+7XlU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbfLLXAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 18:00:05 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35562 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731036AbfLLXAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 18:00:05 -0500
Received: by mail-pj1-f65.google.com with SMTP id w23so219275pjd.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 15:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=JN+Ktkw/NX+vtVwV9GDwICCRE7UoyIaMfXDRDUJV33s=;
        b=uqu+7XlUdx9YFY30A8AfkRlg2or1VONGseo0GnDz21Ua/gF32aAjoQ0FHqfOSd9633
         ObPSIlnCDobNZVACXDrvtVdHeUXbMbEJ7VeYmjmOmAY7RFnGxYQOpoYJvXx4FlAtZA+L
         CNgOJNexA4Yn7wSFG2hALnHv2JO4bbE+7vkuvXHGU1QY+xgaLCB78pHu5cKT/nY4qk59
         fvoNolPtMQDd0BbuWsdjlvf/2eP3npHod+B2It1a2B1t9A/crCz8NBP1zc13nsB3/2RI
         HLmXWXOB2UnT4mEQekKaRSOlI2rxMAPWBo6z+zoLhNMvMXmlcfAc0YZeBfwZEgegjmev
         vJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=JN+Ktkw/NX+vtVwV9GDwICCRE7UoyIaMfXDRDUJV33s=;
        b=KtoUe/3h7b3wzWthgv3Y8OYCteUVr3TYaNoS7xvj+o3jkodLnwnX4lZyaUFo6ifBNR
         pmAE7iuTi73uez5FqHKV9GnPHylTKR+et7Lwkb6bA3dxLZj1B44HAGWHjqXFsEXahtLk
         3SBzadjWhvNkYmPshfI/7gHiRjWDYfV8cisd4dmJuGcbMKdQ0eN5CKEx3M8vHvg5nIJw
         S6M07C+QML3HPseyNwDJzV1LJS0eC7hvpQj/sYOf8p9H8iO4xHMLp0+eu/It3wserC1z
         zv/xKjDZeQPVgIyd5t3qFQZvpLgFBsLIDmTwwKpSW2cDlZ/ep/o63KTQmEsFIcwgts7n
         2F3A==
X-Gm-Message-State: APjAAAVExvc71TVf1TiKl9dGv+zom2ywjlAcSTlGllYj+GQMsnsdJOlR
        RzG8uZ7ZerZZMr7hKs4Tqu2BOA==
X-Google-Smtp-Source: APXvYqzTTTD6A5DIIlnM5LYToFDQm+vIoDq/hBSRrVuWjmG0bXqcD6uiNLrJ2d6gAz6HsVphMCgibQ==
X-Received: by 2002:a17:90a:9bc6:: with SMTP id b6mr12933687pjw.77.1576191604684;
        Thu, 12 Dec 2019 15:00:04 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id k15sm8577813pfg.37.2019.12.12.15.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 15:00:04 -0800 (PST)
Date:   Thu, 12 Dec 2019 15:00:03 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Florian Westphal <fw@strlen.de>
cc:     linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove __krealloc
In-Reply-To: <20191212223442.22141-1-fw@strlen.de>
Message-ID: <alpine.DEB.2.21.1912121459400.121505@chino.kir.corp.google.com>
References: <20191212223442.22141-1-fw@strlen.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019, Florian Westphal wrote:

> Since 5.5-rc1 the last user of this function is gone, so remove the
> functionality.
> 
> See commit
> 2ad9d7747c10 ("netfilter: conntrack: free extension area immediately")
> for details.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

So this also means that we can fold __do_krealloc() into krealloc()?
