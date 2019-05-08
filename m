Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295DAC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD5421734
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="1621xZiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfEHRmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:42:51 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:39641 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHRmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:42:50 -0400
Received: by mail-it1-f176.google.com with SMTP id m186so5296763itd.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2IlGq+6gtguZJVOFjxQj/IggiuNDOuJd20jQKcDFRYM=;
        b=1621xZiZuThZBg+Z5gxWhbzM30zJuZJnRz0KAVksoJXBmEAj7gKSwmpLfcjNOAVm3H
         DXDIYIHREbST5hmzVUyoPeMr/wyFP4LSxO8CGpS07w07QYd5tlrhx4w+e/CsIIC/r3Vn
         SvsXZdTfOr/xunLw0wu4ExfI+txJ1eqchqbX1d1vnKG3zu0R4UhAGyfEGEIYvyNBrJOg
         ageWg274C+HTgTMJuxaCPB6Z/97Th4ARa3M0XTc0sSURjJz1xxeLg6xQRv1uwbt7EKR1
         RJpmcV0ix+FaI0kFiumLXG2Afr3YB1M0A8OgWjbogom1a405F6OJ82rv5f5T61OHXjvM
         G/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IlGq+6gtguZJVOFjxQj/IggiuNDOuJd20jQKcDFRYM=;
        b=io8Hfqy1UJUfX+SZE2HMH90+Zx5BuhJwhEQ8zHgFP8EURusiTEUXQmTwxw3Ro6UqP7
         bAeNfBHUIBr9u2HPnES1vZ992PbN1ipyIdfv0dy3Ww63ngT2MyOJ/XOtlbWxr0wkfpGl
         IsjQuIvZLwbOsOJ+tRoPnYEz4DkH2jnsDw5bgCRRs1jN6L2waGxwYlnGQNnescZ6J8rh
         9uvoW5kkB1YSRgBSH7+epzNCME6Wyw4oWr84ykbhVJW7RZIs3D4AIKY1JgTJKSDovWJG
         y1yq2dSuOK6oxAjph+yiO4S5dTohlImvJ2KyHZN5DTlUh/Mkp9BUDGgCyjBnl3TmFjLu
         9o6A==
X-Gm-Message-State: APjAAAVUUyGx1HfPuYI90hNTuWd2P7J5DUy+dua/0RdIpHXgpYrnUet/
        PpaY3jPy8S9Ag5D2+jVZ/8gOp8k7bRlch/I6fnYjRNhckcAZcA==
X-Google-Smtp-Source: APXvYqx+jsMK5tDaxKgEtyXbNr4w3JeLNuYDgOkwRW4V9J4+wBCtBzMFj5BWML3YXmErElHIl3iQasAYVjAPT45fcm4=
X-Received: by 2002:a24:9d0d:: with SMTP id f13mr4941996itd.162.1557337369811;
 Wed, 08 May 2019 10:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190409140347.GA11524@lst.de>
In-Reply-To: <20190409140347.GA11524@lst.de>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Wed, 8 May 2019 18:42:39 +0100
Message-ID: <CAPoiz9wwMCRkzM5FWm18kecC1=kt+5qPNHmQ7eUFhH=3ZNAqYw@mail.gmail.com>
Subject: Re: status of the calgary iommu driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     Muli Ben-Yehuda <mulix@mulix.org>, x86@kernel.org,
        iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 3:03 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Muli and Jon,
>
> do you know if there are user of systems with the Calgary iommu
> around still? It seems like the last non-drive by changes to it
> are from 2010 and I'm not sure how common these systems were.


These systems were plentiful for 2-4 years after the original series
made it in.  After that, the Intel and AMD IOMMUs should were shipped
and were superior to this chip.  So, even in systems where these might
be present, the AMD/Intel ones should be used (unknown if they were
shipped on the same ones, as both Muli and I have left IBM).

You thinking about removing the code?

Thanks,
Jon
