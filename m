Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F410C04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332802173B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557431653;
	bh=gMSZvH2jlV+E3jQtFqiDNxyLY2LVd3yMAAHRjgUI8bI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qhSrsykoFKEOsjmotENnPpS4MP6M7uItpK8ssnQTaz15nLTDItxWA1n0wwbjgo0Ao
	 cE8oDqwWzkwLICDKRBgfVqf6vP1ipmGEdVaUaKWvppflW1hFhJkeIWl7rdpTGH6mym
	 Ch2VLRFRLgjOb/ulSmSym6Ss77j2SGwo1IH1+R9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfEITyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:54:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37967 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfEITyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 15:54:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id 14so3091381ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oGG06UbFIpIka8kH8mF+DXo9oIX85rLGrtvTzTqeUYQ=;
        b=Bhff/nyavJfT40PuALUNmV3NXjnHsrbN+pAjB4c+7XVvzcKW/ubj0wSd2FNv9dp01I
         PEmNRE69Gq1/nhGrWzYnZGlXBoDh5fsc7w049UJnCsXJIwhkrczb6bJT2fpYeG8x9oPA
         +f0BOPIBNwyU7J3ce6H2g/VMV1QRPpnEEQ8wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oGG06UbFIpIka8kH8mF+DXo9oIX85rLGrtvTzTqeUYQ=;
        b=OA8zgkQGWKCCwUXwoR1hF2JiRmfyDJeqGxowc5ueAGtL/OGMsFebOdoy/F2qRZ0NMQ
         Px4qu4qrEHm0nPiSSU5V4oIZ5YUB4xFrpBZzuCVC9TpnDQuwXkjIOU9i+TtMyQTxEIa4
         2NeRkBS/xw+icCER4qeBx2zTWvAe8D4Hjl83oQHLlQ2NLgepnSHHwelxujuREnU6ihAo
         Tdxe4x+x1240hEFIEXkHFfIy/yPlpKdChUtgad2QNsUCB+PzaJsWmLRTL0gYDmR3ODQr
         FLBvkjdebfFHNnKgFHjrhYwUKPZKY1/MADFxaxgAuq2+wWKeBTGvMbkzq/rNVcGYXfSj
         V3lw==
X-Gm-Message-State: APjAAAVD+cayXMlc/0i4IfiiFHLbJa+u1FEEiOVl/xBBYFWvrbj1K4YW
        h5r/EuLfjqPBCcKY/lPrYtl0rp71oX0=
X-Google-Smtp-Source: APXvYqzyNy+5VVj8CsmAR2X6geD+QdKvKCWIayORaVBC3Z7I8bCwyXOOfNm2a082i7/KBsRjeX2OyA==
X-Received: by 2002:a2e:86c5:: with SMTP id n5mr3491004ljj.184.1557431649700;
        Thu, 09 May 2019 12:54:09 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id f4sm563077ljm.80.2019.05.09.12.54.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 12:54:09 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id d15so3089567ljc.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 12:54:08 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr3140904ljj.79.1557431648546;
 Thu, 09 May 2019 12:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1905100320110.25349@namei.org>
In-Reply-To: <alpine.LRH.2.21.1905100320110.25349@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 May 2019 12:53:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqzNFfeNOouBjH2GKMVgMi22fsNOaCgbUOnCPmKmEXeQ@mail.gmail.com>
Message-ID: <CAHk-=whqzNFfeNOouBjH2GKMVgMi22fsNOaCgbUOnCPmKmEXeQ@mail.gmail.com>
Subject: Re: [GIT PULL] security subsytem: TPM changes for v5.2
To:     James Morris <jmorris@namei.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 10:23 AM James Morris <jmorris@namei.org> wrote:
>
> Bugfixes and new selftests for v5.1 features (partial reads in /dev/tpm0).

What the heck is going on?

I got all of these long ago in the "TPM fixes" branch for 5.1. One
month ago, merge commit a556810d8e06.

These are just rebased (!) copies of stuff I already have, and they should

 (a) never have been rebased in the first place

 (b) certainly not be re-sent to me as a new branch

Please throw this branch away and make sure it really is dead and
buried and never shows up again.

And take a moment to look at what happened and why this broken branch
was duplicated and sent twice!

              Linus
