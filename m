Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C11AC2D0D2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 23:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30DF2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 23:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="TZUnywbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfLWXQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 18:16:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34540 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfLWXQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 18:16:36 -0500
Received: by mail-lj1-f196.google.com with SMTP id z22so14401150ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 15:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RoE5/OcfUMqvYyq95XjCkJqhMPq46yuirP3fwbPzXkk=;
        b=TZUnywbpYpJnmNeF8wEDAA/9B1nNgbBWThg4h6zAxtn2SBwMjv4uwI2NvhzER3d0N4
         Zf8Rf7sAzbZxK0mJ5ns3hlih9b9BksluzGgOMzDPIjUnxtF2CkIBR6WQqZiVB21loCmC
         9v/sFprorJnwshRvyli8axSiw3Tq0kbVZVY0fqugSULHUt1om7ecBcaAqAaFxp/zRPKM
         tIYAYooq4XIboM3KDhHg1Rw74cIvHAEBB1X0KFEaxh9Ywjrq0sM4o9ndUHB7pn5qabM8
         hQptYbihh7t0w2kNqQlZsRhlIgodmM/1LHSSjqeWXKaOUkTRi9aXpvSl20bno16zLPCI
         gFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RoE5/OcfUMqvYyq95XjCkJqhMPq46yuirP3fwbPzXkk=;
        b=RNWUWWpt9jS5U5buKI2P6yfdqn6tGz4UyVM4AIUkRkUXY9Vmm81kuXwvs2sPHtcPtZ
         iCs3GOavQ6qo1MF4A/VLpd8yVikTOOvRMKHb0FJ658rPNOJvpvhn2dzeHYwtmGbXDAU8
         RjkrSXTOofRXuWk9c/MyrcIBM7tPAa5dKyb+B6BC6SDK4XmTjtr6KnrhiEYUlMAnHVIg
         tbxgGwuEQBgqhUMHNOmsHi7WKsrlI0Gf+U5z1XfFeQKGzqQCpyodIRYMR7KOYXS3S+Jw
         Hyc1+cch3+6f59+smdfQOhhhmFk4dRnqDln0jh+BMA92RaCT1B/fRtxOhcbAdbhsUzx8
         3ePQ==
X-Gm-Message-State: APjAAAX806A0eiVDN58jp/OvOExtr7nB+qMZLn/JklIAWpxt3YNBper6
        vWxUXOgmCepIDynX4Xd5Qd4XtA==
X-Google-Smtp-Source: APXvYqx7vQRGntrjaj/kks/rT2vwYm5pG1Bn5EiSp2noEsjO5oLj/jz1rco+Dj/Q0TzdLk25D7Y8Pg==
X-Received: by 2002:a2e:9592:: with SMTP id w18mr19004630ljh.98.1577142994369;
        Mon, 23 Dec 2019 15:16:34 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 195sm7645959ljj.55.2019.12.23.15.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 15:16:33 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 9B08C10133D; Tue, 24 Dec 2019 02:16:38 +0300 (+03)
Date:   Tue, 24 Dec 2019 02:16:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Willhalm, Thomas" <thomas.willhalm@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Bruggeman, Otto G" <otto.g.bruggeman@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 0/2] Fix two above-47bit hint address vs. THP bugs
Message-ID: <20191223231638.cbewgy7lfx74txde@box>
References: <20191220142548.7118-1-kirill.shutemov@linux.intel.com>
 <20191223142552.d9bd85e588196d17fb90ee2e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223142552.d9bd85e588196d17fb90ee2e@linux-foundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 02:25:52PM -0800, Andrew Morton wrote:
> On Fri, 20 Dec 2019 17:25:46 +0300 "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
> 
> > The two get_unmapped_area() implementations have to be fixed to provide
> > THP-friendly mappings if above-47bit hint address is specified.
> > 
> 
> Do we need a cc:stable for these?

Yes, please. Otherwise users that use above-47bit hint would regress on
number of PMD-mapped THPs.

But it's not urgent. It's okay to cook it up in linux-next for a while.

-- 
 Kirill A. Shutemov
