Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023F8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63C820651
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2D2zmIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbfG3KYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:24:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41042 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfG3KYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:24:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so19481454pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 03:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PpkuFgEpyrfTUn2xO93gAkOHvkzw/VpUAN2pijyls6U=;
        b=i2D2zmIM4ny6wmoPxR2fSSipScSI/XAkAlZZjNtJiFjveqSDh7apLS0aLxVPcO7J7F
         ftCu4WiPU41LhKu3ChkWomPRlxIa0aHVFvIGF7MilnjQAMPPNAup7H+RKw2Gc/OHXP+6
         itoTx38nN8845TcXtwB1kd/cNQzwW0zkWzMDdYpsNXsSI+kyG7Es7mABVmiOEkbIFibA
         uGO1SWOsGb5HYI0LY04jiakQA6V4UiI3+vNnZX0qHBq5SNAm21s1Lq/EUahrcYb41InY
         cPgAJHeEnO8W9ZoEPB0r/+zvdKDqqrBxETuOkK6c9R1YDjfTxM9ZDr4tczITMpdiSPfL
         b+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PpkuFgEpyrfTUn2xO93gAkOHvkzw/VpUAN2pijyls6U=;
        b=XUjf8CXKfYo4xs0LupOiZtACVxOhRHsMgrjnnT193P+s0bArHgrS9+AzSI4lGhYUZO
         LcYDc/v2eq768VH0AAo0/Cy5R+D487g7jT0vNe86Hrr/MV56tx2n2m21eZo7hIdxSwuV
         MveiEALp/HYB53pRw20EjYBSdoIwvogFn98EH5HGh5PJROhgIuwk96y97hhx00cc5gh7
         fwKmlAIDn+xCTHK9cpq09nnQwGuwat8PJ/RSbnH44V+N9pnUekFIjd5JWxXbWm+kbwgL
         L5tsfbdkk9hh8zEnEdoHg2ifJuA14zyPMh3fidXU6JwRqbq++7jhZ/JhQv3UovGOrug2
         nSUQ==
X-Gm-Message-State: APjAAAWtEfcYYkyf/qfAzmFjSnl3mKMxLjFU39doba/r8nPDaQe48zIF
        FrlJhco7I38KgzMQBGuU47o=
X-Google-Smtp-Source: APXvYqwA8gWk7GLzEOo/IlpB9GVuTNJbHsDBEkm5fOjRfwYQi/1Pa+NxWHVSXFOHqNHnEhwFE2YlXA==
X-Received: by 2002:a63:2cd1:: with SMTP id s200mr103839175pgs.10.1564482286634;
        Tue, 30 Jul 2019 03:24:46 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.31])
        by smtp.gmail.com with ESMTPSA id p27sm98530002pfq.136.2019.07.30.03.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 03:24:46 -0700 (PDT)
Date:   Tue, 30 Jul 2019 15:54:39 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Matt.Sickler@daktronics.com, devel@driverdev.osuosl.org,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees][PATCH v4] staging: kpc2000: Convert
 put_page to put_user_page*()
Message-ID: <20190730102439.GA6825@bharath12345-Inspiron-5559>
References: <20190730092843.GA5150@bharath12345-Inspiron-5559>
 <20190730093606.GA15402@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730093606.GA15402@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:36:06AM +0200, Greg KH wrote:
> On Tue, Jul 30, 2019 at 02:58:44PM +0530, Bharath Vedartham wrote:
> > put_page() to put_user_page*()
> 
> What does this mean?

That must have been a mistake! I just wanted to forward this patch to
the Linux-kernel-mentees mailing list. THis patch has already been taken
by for staging-testing. I ll forward another patch just cc'ing the
mentees mailing lists and won't disturb the other devs.

Thank you
Bharath
