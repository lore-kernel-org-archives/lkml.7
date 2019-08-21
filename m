Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D482C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AB122DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="azVQoxxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfHUDsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 23:48:51 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:46833 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfHUDsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:48:51 -0400
Received: by mail-oi1-f180.google.com with SMTP id t24so541467oij.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 20:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DNeO2I5P7X1Lbvd2VIQqSVnNMPmHOfkiBxbwoy7aOis=;
        b=azVQoxxsK3C5RN9SSDKAjKCwrJ0JFXMJwQyItUs9Zy8d7o/ESF6YdgOmKmQLYJQfoM
         RKK84QFCZEtiDvhegDfz+K5VcCdHPfSJbbsrn/uYTzBivfivh2rnieZqD4+C6NFv8WuK
         hqEkJJmFhXlZJlacoTpIc1YMg7/eLH6ogRIy5nFBGMaYRTn9qKE3AlRE65skc7cy7R0Y
         R15phWfS3qXDepRKz7kscbeL3M4soYteIn3Ozk6sHIgMAUnPK010dtqpJgk0JDNtPaeS
         ahmjzFe/Ra1AERPQnu+ocANaEttZ1yfR+9uSmMnHrzq+8pMTxSM+qD8pUTdc4v2B+mvJ
         1Fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNeO2I5P7X1Lbvd2VIQqSVnNMPmHOfkiBxbwoy7aOis=;
        b=VbGZDqHn1n95/HwrqVYGUGu4IRJLUooJHFasd3IaAJRFcxnYAp4b5ldPcgvs0TDUlG
         OBoWiMqmY5SpJ7KqlTCytlaO5W2Cg2puykU310dXXEQLwjhHhrvD2Ir3p0uTALvFsyAI
         hyAnpO15nz8FTLHNsGVp1yTB2vpeariotAeZhb9BKV3Jg2sbFZWwqTNOWuAXNlvV4/v5
         MU0dEPuUTeQMI7puuxnqu8wlGEnVqeWu1SfSM0pzHzEjtZL6z00TL/bkp2wv3cDo292o
         QKVHbFKzLHuVNjZEBclXItWCbAD98brOGU9iCbrVKzl2q3UeqnaLrsjYH96RQaZF3x9+
         xQ4g==
X-Gm-Message-State: APjAAAWKTNsmA+76ZLSj+9Pw0ilqcljg1lgeqQyx1EBqNtg30AmuvgXM
        0NZVqCetSjdtg0S17k39i+Y+aZNPB+5UNPEHGzMgSg==
X-Google-Smtp-Source: APXvYqzAxxh0GTyz2p6TU6M3TxnFZxOT+XsgGtpQK1Nfz7TEWwmtVmKCu8mBDHODmhXoIT1MWpOrBWDCDod/7kCyI+k=
X-Received: by 2002:aca:d558:: with SMTP id m85mr2482178oig.0.1566359330468;
 Tue, 20 Aug 2019 20:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <72e41dc2-b4cf-a5dd-a365-d26ba1257ef9@oracle.com>
In-Reply-To: <72e41dc2-b4cf-a5dd-a365-d26ba1257ef9@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 20 Aug 2019 20:48:39 -0700
Message-ID: <CAPcyv4iPuTpk9bifyX5yQxO8gT0fRhYXPrwk-obazWA=Dou3iQ@mail.gmail.com>
Subject: Re: kernel panic in 5.3-rc5, nfsd_reply_cache_stats_show+0x11
To:     Jane Chu <jane.chu@oracle.com>
Cc:     CHUCK_LEVER <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 6:39 PM <jane.chu@oracle.com> wrote:
>
> Hi,
>
> Apology if there is a better channel reporting the issue, if so, please
> let me know.
>
> I just saw below regression in 5.3-rc5 kernel, but not in 5.2-rc7 or
> earlier kernels.

Is the error stable enough to bisect?
