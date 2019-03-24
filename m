Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B8EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 09:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D107222B8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 09:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLrbbg74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfCXJth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 05:49:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44520 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfCXJtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 05:49:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id a3so4346652pff.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 02:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PkrNR3pqN8plTlbIcVEOMJODvO81Sf2Iu4fpjMf+Qlw=;
        b=HLrbbg748wyphDl+QN8GekVS5pPtdniqbRN1ga92i6ACrL89zAlJl67EF61rHUlatR
         ruRfKb+zCJSGxkAjho2Nh0wAAP8gkLqu5sAHtqNINtIovu0C2YcDFQyO7sq63KH9MuCc
         jKYbtzXC43AKPGF1/g7+zLOFBrAa2s5Ykng/kDJc8mjEPm29kJmwU4eHQ92UTw2eKUCg
         0BzLEDr2Rp6S/xUjUcwDS42uv6Wp5LFUqABA4FhGw0sotCqsSoC9ACOtZeplSd//7OZB
         CTYZa6BHHFkg2bpfPSaUQhLZq5x1J4IgJiNepQiu3iPbTOydR2fsbB3rtc2mcwWpXPn2
         neKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PkrNR3pqN8plTlbIcVEOMJODvO81Sf2Iu4fpjMf+Qlw=;
        b=G7l53XDaB3JRwSixOKfqeFzw0MgagcPyGRAe9WCHAEUKCYNJ3PM7++nQLYlv8KNE8K
         /M6oy7iPCv0EpIDgnnQGJSwv7gFWDUQLibBKDC+dy54M2tNQ/szwbb3GvC3uf+qfV2dM
         +X43Bw5Ib+JULnAn6lo7X5sbMhTy6JBulGzrYEbBP8lpByW0PIuKikv5rmOzWrMH6By8
         22Yh5VjEUkipcJe6kqsZwbgNJYi4/4MinfJmjEc6hKILbh5KM41hWMsN19mFgJTDGcDz
         xSzTdU45lgB5QjKe8+WusxiFIIhfI/8qn9JK1MNkRzjNkePrIg/s4AsmfkeI8YvhRPM+
         8ibA==
X-Gm-Message-State: APjAAAXnomCEFZpfUNhyl2KNZA9QhLfV6AErnfxNGspTNsf1RcYNvf/l
        cJIKrfP1FPGTReOKjekV60I=
X-Google-Smtp-Source: APXvYqzxtcFZtNXbKnRnh0kxp3tpuOV3VJ3h9NIskUj9aqKfxbcT9t2pdfRRPMGJRbPlVSfuH8mOUg==
X-Received: by 2002:a63:f850:: with SMTP id v16mr17584803pgj.448.1553420976288;
        Sun, 24 Mar 2019 02:49:36 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id e123sm17786052pfe.35.2019.03.24.02.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 02:49:35 -0700 (PDT)
Date:   Sun, 24 Mar 2019 15:19:25 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     christian@lkamp.de, neil@brown.name, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ralink-gdma: Convert unsigned to unsigned int
Message-ID: <20190324094925.GA16238@bharath12345-Inspiron-5559>
References: <20190323113444.GA9329@bharath12345-Inspiron-5559>
 <20190324085842.GB21912@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324085842.GB21912@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 09:58:42AM +0100, Greg KH wrote:
> On Sat, Mar 23, 2019 at 05:04:44PM +0530, Bharath Vedartham wrote:
> > Fix the checkpatch.pl warning: "Use unsigned int instead of unsigned".
> > 
> > Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> > ---
> >  drivers/staging/ralink-gdma/ralink-gdma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This patch also does not apply at all :(
I have sent version 2 based of the latest staging branch.
