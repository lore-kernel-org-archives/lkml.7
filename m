Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF35C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 20:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1302184D
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 20:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzV1130l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfHRUMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 16:12:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34478 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfHRUMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 16:12:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so5664830pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H9uI4snIoxmqfgWlnps1QKRPMKwwDpzVdO0r8Km8fdE=;
        b=VzV1130lLKQs3xDLlPQmItAH+cmAs0ZVKI6FLRNW+n0KXgsYtvOu2a0KoNkQh1anSi
         G50u+s52lFZ+6jGoJHSttHKhI2wzgI1TtKnBu7ykS6XWLQVX3brL7pxc33I1nAy1S9pr
         mghZVMq2aJbayKzfZjRhlMHKGriusaVhMs7nQb6UdcgOnxM2MFXtjeC9JnVt0/cnyWTN
         nHWwyCLNrvTYOppvQk5TCQSTpIUmeHd3KiSyhwlFJj8ml5tum4v2QE0rvPeWetUCUrS4
         FocdtuM3t4OvWE5QC0EzHRYX1P6RJ+yVkR1d7qPjRwyjwarcLttMHB7RpP+XdZ7JQqfn
         XXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H9uI4snIoxmqfgWlnps1QKRPMKwwDpzVdO0r8Km8fdE=;
        b=OPO88IDPZssbbJZIPcXKV8syb1RHisJGsjdSNUgG8PAP+wZQO5f6uAfLHQQSHhvM2U
         6PR3eJ0hHyREpuR80xYxYvoWQUzv9d4WeVnEUrc+tR9vMZN7SEuQF4lQ3VBdp3//hvf0
         fZKllu74VpPP/zcHkCMVmCqlmvWhHki+2LHVSrk0/nIS2mwdrJpVUPp/CD8U9SDGu28v
         1+vYpOTO6SfXZjVAxXfE7PXEeTjvXBdwjT9OxY0gcakbq5+GuKZl8CKpMThHZbv0aqZX
         gMzHXGDYKFQH8NzI8/+1KK4nzwdgn5GPTvS7pCBdOGQ7MxHCsV/dcxAXRm+T3nU13eww
         L57Q==
X-Gm-Message-State: APjAAAXeKHHaW7EXgomCySq38AYQyw/0WUoZXepwo5/U23vKmN+dpzum
        P76r0AkyX0b+5Kxth5ckh7s=
X-Google-Smtp-Source: APXvYqyyAjoSYJGCk/XxUmW/VBsPw1UbaSUgui5nlHK+BgQtDHuFg6wRa/Gpd/yTBf/BVYwDWy0ccg==
X-Received: by 2002:aa7:8e17:: with SMTP id c23mr20932691pfr.227.1566157835188;
        Sun, 18 Aug 2019 12:50:35 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.36])
        by smtp.gmail.com with ESMTPSA id f26sm17707794pfq.38.2019.08.18.12.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 12:50:34 -0700 (PDT)
Date:   Mon, 19 Aug 2019 01:20:30 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     sivanich@sgi.com, jhubbard@nvidia.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees][PATCH v6 0/2] get_user_pages changes
Message-ID: <20190818195030.GA4487@bharath12345-Inspiron-5559>
References: <1566157135-9423-1-git-send-email-linux.bhar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566157135-9423-1-git-send-email-linux.bhar@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 01:08:53AM +0530, Bharath Vedartham wrote:
CC'ing lkml, the mail id was wrong.

> This version only converts put_page to put_user_page and removes
> an unecessary ifdef. 
> 
> It does not convert atomic_pte_lookup to __get_user_pages as
> gru_vtop could run in an interrupt context in which we can't assume
> current as __get_user_pages does.
> 
> Bharath Vedartham (2):
>   sgi-gru: Convert put_page() to put_user_page*()
>   sgi-gru: Remove uneccessary ifdef for CONFIG_HUGETLB_PAGE
> 
>  drivers/misc/sgi-gru/grufault.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> -- 
> 2.7.4
> 
