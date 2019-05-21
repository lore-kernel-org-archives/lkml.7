Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B875FC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B42217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="e7lLqmGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfEUULh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:11:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39005 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfEUULh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:11:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id w22so55406pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 13:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=nSMrBlQQCNOdHw6ym1MsOYq9Zt6fXAndfJkhXIkeTfY=;
        b=e7lLqmGL/6q1XC19Pu2Ax/U8nYO6HgOcM34i3Lk6Tq8xSCi3pG3Btm/qAupy9SGITO
         PhlXnLDYS6PdXnZtmm2pjbBEWz50ShDcB9iSSs10VozP8WaB+I4uIdSBIpG9q5dAz3WI
         YgAEdRyN2VfdjIOGCNrBgtEGDEbpsEr5RW5EpUQ8PkWC4mPyiuShkB5vKwwqAjkTin6D
         uwvT4ssmU227YHH6pMdQnPKRLXTKgbLpPmrzOxA9ytRcvAqLosLq21vsenp8H2FJP52w
         75TfzHr8gm6lKBfi3ccb5yxWEWt6f+WFz9ExYdynGY+bcbOqvnZhhoRJd4Xt4M7WQ1dL
         m4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nSMrBlQQCNOdHw6ym1MsOYq9Zt6fXAndfJkhXIkeTfY=;
        b=P0ih7O6SIMmTUiyJ22KPeqmxc2G2Gb6b15HZQZbreX9UTiniYRuMBsr+XLWaBgC2U6
         f6q8oWHQX4OvMRvDjTKqMw0qsHRWJ/m/pENv/I4H4Gi9NE/r+HOO29/ELKPg6u9Rk29n
         u+8qZLK1UwanN/bA7+jun6UExgPS7OaBuVEh4dTUeooxLZm8xhj3LP+gqXFfuH9Hhc23
         pKRwiOaveoYkmgYif0n2tVKWFzhh3z3S92ZOPdQqLnKUS4+WZ/FU5Tqj3m+Zj6O+UOkc
         aybMPkQOoa5asRvfeEUAq5URqu/h9j5OierMPxU0kCuw1VLpGfH8uiWT+f5DqR65XfuR
         69/w==
X-Gm-Message-State: APjAAAXzTiIgxH3Nj0YeMQWf3qVN61wx8BgjZy2Hxl+PidXtKaDZGwmP
        mht282d4Wf5P/mPCKVsNmwaOCg==
X-Google-Smtp-Source: APXvYqxQq0PW7k4iHfJLbysFm8N/zysY7W12kduhFF17wCTuZV0Kk7FyJlPkzS8R2ktUvE4NPm+YsQ==
X-Received: by 2002:a62:5103:: with SMTP id f3mr92089248pfb.146.1558469496412;
        Tue, 21 May 2019 13:11:36 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:b1ca:3800:3284:d770])
        by smtp.googlemail.com with ESMTPSA id y10sm18575577pfm.68.2019.05.21.13.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 13:11:35 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] firmware: meson: meson_sm: update with SPDX Licence identifier
In-Reply-To: <20190520140045.29125-1-narmstrong@baylibre.com>
References: <20190520140045.29125-1-narmstrong@baylibre.com>
Date:   Tue, 21 May 2019 13:11:34 -0700
Message-ID: <7h8suz7ekp.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
