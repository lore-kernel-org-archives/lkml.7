Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8E6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 09:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B059222A6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 09:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQlLLYE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfCXJhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 05:37:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36178 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfCXJhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 05:37:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id r124so4415600pgr.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 02:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4E3hap8jTrhe48Pv7xE0DiX++dwzhzZUKk7qD/F4x1w=;
        b=XQlLLYE1A9rt+r2hldltdlvG7tvuEDbtZCyU0jcaF2IO09qZJ7tnqHx4VEqSTU2acn
         UfD+JEQu+3OJ1Clevbg+LSzPCxecNwNOLbn1sfQrJ4fPzx2+wL9ThVHorgligO3vpfuG
         4iq5Vv+I6rM2BmdUdkjeit7Z+lEazZocbxyR//KNbMChMcLauQnbHMDCBWQaJoR7D2B9
         5S9CcAR5K5aDubMOgIPTXsgv98CFSlYcoUK1upHz/vaUOMjKXz/hHw20U0R5AYuiAIwa
         tDn2z6V30COq4RJhN9AEDlWLr6hlofMz8d/Kc/eAJjqAN4lefms8UrgBpSN2Ez+HTktG
         b5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4E3hap8jTrhe48Pv7xE0DiX++dwzhzZUKk7qD/F4x1w=;
        b=cwzH0SQNWYUfByEBUu86j1RdI6Z3A5NRZkCAgiVEtUFK2MUxok0vF3fiHCSZGlLSC6
         lOxIwK4donHOiaokTKq/2UJ9IGTGgwT4G4T9ZJ2TlM4SrxYSW0ewG0edM7KNAjA8Vju/
         Q9yuL/6xM3mtYLSCn/efQ7W7z/NW77UkbYhCev9waLwuB9CDgOs99mGNIvSNk5opU9rj
         MDMf5b/zigyAOg+wcgFpvB7C0ihM0mAvR/IrPBqZDpTLMpzcG8VPoG/de+JA/GcHhd3j
         15p3pyqPhG7hozkC3YTv2eSwhwEUWGMKYJTAuZkgz8xNzeqHFX/0Wz3ER/Feuc/G/00V
         YAiA==
X-Gm-Message-State: APjAAAVolLcFWobnN6vwRhyZYwOYLMIKVZQI4Q01fgL/i5iOfJDsFMj3
        jnj37pEmPvKVHVhZFphKYPQ=
X-Google-Smtp-Source: APXvYqw0xBShMhxwrvY9IM8EQqUDGrB1JB2DQJaI6KEOKExzZzx9tVE/srwg0wLfcHZ6IaeeAoK/5g==
X-Received: by 2002:a17:902:6b8c:: with SMTP id p12mr19490114plk.282.1553420274232;
        Sun, 24 Mar 2019 02:37:54 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id a65sm16988608pgc.72.2019.03.24.02.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 02:37:53 -0700 (PDT)
Date:   Sun, 24 Mar 2019 15:07:48 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     christian@lkamp.de, neil@brown.name, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ralink-gdma: Convert unsigned to unsigned int
Message-ID: <20190324093748.GA15691@bharath12345-Inspiron-5559>
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

I have been working on linus's branch and not the staging branch. I
thought that linus's branch would have the latest updates and would be
the latest branch :( . Is it a problem if I use linus's branch for
staging drivers?
