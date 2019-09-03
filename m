Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B866DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DED2341F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nN8cX37p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfICNwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:52:08 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41595 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfICNwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:52:08 -0400
Received: by mail-qk1-f194.google.com with SMTP id g17so15972662qkk.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/R8RJDNpye5FLl3og5Wq9/dqGw44U2FIoixhMRWi4I=;
        b=nN8cX37pAWvMObPKDBbnrAc31TKMJQLvM5YlcbnM3/IYofmSnqlXNC8Q2sRLfdNCeh
         68CHAMLOA5FFN8NdCJGMYCo+qVTpZ75yB7dEIZxn6wmAJnXvHLRTSm+3JLHLDgUNw+Mc
         BcZQ/FO+Y+gbwOV+Jw3VCVThKOrmoRLzMf3NyqklNLg+YSKXJr26f9vZz6AmaTEhD0+A
         Pw0QVWE14ML0YqUGW6D69HBwnYcWs11NOAbFVf8g5855Cmr2bfUMqCg7GQTLm7M9D+TR
         An0sHtB4kNQ0sN82f8mELTW3M3CY9HPPxa6Agc4N+1NRHIO0v8zlCKhYt+LuSCvsvB2m
         bFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/R8RJDNpye5FLl3og5Wq9/dqGw44U2FIoixhMRWi4I=;
        b=XBLOc3Bc6CiUF9yyLwZaWOcKoz0jn7zQYQIBd7MxNkCuxpjMjA5i2Gj8ajoIU2XCEU
         5gcZDdDA+FH6wmwto2JyDlphDMLMOl0XBXnnU604I33ewkFfTtLj084VuPm3WxY42gNJ
         2BGBV6eyhTAn79Vu30xU0Er7vnLFwDkj786NsyH1osaJ3195Hc2lCJlGTGYeAqKwprEL
         nBSTP+dUXz2E0WpBdWLndYLCF06RlAY0d5uAM+z22jfdhyBO5i3GbNR/1q4j8lbiYefj
         6UC8t1vi8GJCOzaHZUJTpP0+4BtpozTqEdfepqtEIhZ5s3JWk8VLe7zfWdevajiGdWuH
         sLGg==
X-Gm-Message-State: APjAAAWNFHitAwxhQhM75IaqKONpQpSeqy+Dmm/mqu07wvxTeK0BA6Kd
        wU+z0VGEbaO1qAN9dYhNnNKVoJQ8Pzw=
X-Google-Smtp-Source: APXvYqy/OawhyqFF4oGRKBlI5kQb3e9GCFV//8yxa4FqQRP0SymEHCLOcrJMoVQsyrAZgPZHdlrLQw==
X-Received: by 2002:a37:480d:: with SMTP id v13mr33166288qka.295.1567518727565;
        Tue, 03 Sep 2019 06:52:07 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 31sm1314959qtn.52.2019.09.03.06.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 06:52:07 -0700 (PDT)
Message-ID: <1567518725.5576.48.camel@lca.pw>
Subject: Re: [PATCH] powerpc/powernv: fix a W=1 compilation warning
From:   Qian Cai <cai@lca.pw>
To:     Christoph Hellwig <hch@lst.de>
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 03 Sep 2019 09:52:05 -0400
In-Reply-To: <20190903133051.GA23985@lst.de>
References: <1558541369-8263-1-git-send-email-cai@lca.pw>
         <1567517354.5576.45.camel@lca.pw> <20190903133051.GA23985@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-03 at 15:30 +0200, Christoph Hellwig wrote:
> On Tue, Sep 03, 2019 at 09:29:14AM -0400, Qian Cai wrote:
> > I saw Christ start to remove npu-dma.c code [1]
> > 
> > [1] https://lore.kernel.org/linuxppc-dev/20190625145239.2759-4-hch@lst.de/
> > 
> > Should pnv_npu_dma_set_32() be removed too?
> > 
> > It was only called by pnv_npu_try_dma_set_bypass() but the later is not used
> > anywhere in the kernel tree. If that is a case, I don't need to bother
> > fixing
> > the warning here.
> 
> Yes, pnv_npu_try_dma_set_bypass and pnv_npu_dma_set_32 should go away
> as well as they are unused.  Do you want to send a patch or should I
> prepare one?

I would be nice that you could prepare one since it probably could be a part for
your previous attempt.
