Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA35C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F4621841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVKbo80S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfCTUHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:07:07 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:38757 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfCTUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:07:07 -0400
Received: by mail-wm1-f51.google.com with SMTP id a188so477257wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=i2CZ2h17IUTfC8WxVSpqJhUQ56dM9AQtPWmIlXcrDl0=;
        b=FVKbo80SI+42LmCHZJvOHvWzk7+b+wBTJiKEPa48rO5HujMlpo8/QojQ9YJP+FxMI3
         B+pstJUepqfPEIF1YmgWFtMh+Zpumje1ueefKQcVSoZyETP2Un19mhENRFGcHpFQz9AN
         vwbJIc34yf9eIYdFWHN4A+9IPuEQAyH37Lz5+PkeibNaAW1FpVxCSxtCyaTjlKjHOkZP
         3ODi9QP6wlC5m+dDpSNnBd7z1hPXL5maAayR7pq9fkvr1m3wqOkJnC1+V4SCjP5dhNCm
         LARIurLqd0rhV2Wfmb/I7Sw6Tu6m83NBQdAaL2iXqKXQBuX63Cl49/X9aMwq68QTJtAy
         cJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=i2CZ2h17IUTfC8WxVSpqJhUQ56dM9AQtPWmIlXcrDl0=;
        b=BAHaayWDkW3MCgDFwx4EqCKO6nzv1Nd3KdjWixyHlne8UkB3L57HTZwjHpWDemvxDv
         8llY7tKbO+SSJmTwiSovQcNvYcv6jhXBnKSUc7Uxyr+APuBoBQZjf1Or4X2RC1VM0zsF
         Ar+1qlPaolB5z4mnuB0YiWcMijS72GNBPQ1Af6o/nT0j5wr5VbIl0v/zKkPTZKY0pFYt
         E2oLcAd+smlSu55SXB8wZyaz2cDsffofvwYu46ikeYyLD6WOYsguaTOigyNWpyzisF/r
         bJ9mqZpLSKocoztasyQJxZyotL0Mnl2IYJu/K+EYefIbw6jTJPrQHvtkI1iKmSzBM8SN
         hGHQ==
X-Gm-Message-State: APjAAAXc7HSpjmSkBeATTz+0dYfxeY1PGYtftu7UOCjSBmlACXuTX/UU
        l0NpL2G6qXXRrcBk0cfDZw==
X-Google-Smtp-Source: APXvYqzTXph3URt/BZzlcgWs8a2s/GSn/LjXj6+fgVo/FylUSSi2NBrXK8ee2H8Q7du6WthYmKtdlg==
X-Received: by 2002:a1c:66c2:: with SMTP id a185mr64553wmc.139.1553112425351;
        Wed, 20 Mar 2019 13:07:05 -0700 (PDT)
Received: from avx2 ([46.53.240.229])
        by smtp.gmail.com with ESMTPSA id f20sm6715964wrg.91.2019.03.20.13.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:07:04 -0700 (PDT)
Date:   Wed, 20 Mar 2019 23:07:02 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     christian@brauner.io
Cc:     linux-kernel@vger.kernel.org, dancol@google.com,
        joel@joelfernandes.org, luto@kernel.org
Subject: Re: pidfd design
Message-ID: <20190320200702.GA27111@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What would be your opinion to having a
> /proc/<pid>/handle
> file instead of having a dirfd.

This is even worse than depending on PROC_FS. Just for the dependency
pidfd code should be backed out immediately. Forget about /proc.
