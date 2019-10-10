Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC89C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 04:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B0E2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 04:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ruCZ2qqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfJJENm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 00:13:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32827 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfJJENl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 00:13:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so3038503pfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 21:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=vDCFCwzkObP7JGkplInNr72QnOvVnuxnRx9HfUiMirw=;
        b=ruCZ2qqxsaWGzOgPFm038Sqem5xwPrEd9zdOnEe/JFRotELEDEbAcr2x8Tt4uWdQap
         gDHi3tbS8H5au7D/TlrMI8Re2YgAAA0fKwEyqIfaAGKCb+We5SNHnHhQHWwPKHL0MRLW
         bR6jX/jDOO5cgAgwSiK0GWlbSxQPtCdXzcQzete+uQV7AODbnXbrZiJRb0R/DUti8pGH
         YjmB3mCeKZXbq//vqUSXyhWi7+i7F0/Vw/bJ/3hzeWpQnHOkqdf/WSgp5FxeA4hFv94z
         xcwmqn8CCQ0/lA4NjMZsmPnPV/AGPfdU0bu0CEmmDzqx2C0e63tLAlHMukn8WRCAkhNC
         Qdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=vDCFCwzkObP7JGkplInNr72QnOvVnuxnRx9HfUiMirw=;
        b=NH23EfIDFGZeuVdtyaLRS6rWxQAxsNwAOdvdXGMtXSTsuOznc2waF+SDHM0LUx+Zlo
         TlHgtmSOSWAbNOHrkzL96jJWsbjkcdpAIdS0h/wXw1qsQsXi1lAUxumgTwM2NIKpZNxt
         BJnT4F4CgJlGjpOXlT0K9odGiIYqPs5p2gKMfWdSc6slClGr0itlhtgWDj7IONdIVFSo
         IvIVpEaOBhoiOs6qDRmZGa2qQZfL29bAFoBzFA0nRoahcE8qDvoOyW6kH0Y0N7OGMBZi
         DiVuXn9Zk9N8P1gkI7wDvOQ3Fg4XCDkPk9AW7bpF2ayUr/JK+xf4VN+piMU7DPCquv3l
         ys9A==
X-Gm-Message-State: APjAAAXR10/jY7TSWMHxoHVs7Krj7+Zlrmw+yAD9thlB7/xRnh/h7FOR
        mi+GLYMZt5Yf3jG3dnUWE8glEg==
X-Google-Smtp-Source: APXvYqwQwDUf04LfS+9wee5xHUAyA677nCw5kRENAmP1KdsVpZKGMatz2kceYNmfogMKO1oXcUOYXw==
X-Received: by 2002:a17:90a:e652:: with SMTP id ep18mr8885568pjb.72.1570680821004;
        Wed, 09 Oct 2019 21:13:41 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id v28sm4250235pgn.17.2019.10.09.21.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 21:13:40 -0700 (PDT)
Date:   Wed, 9 Oct 2019 21:13:27 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     davem@davemloft.net, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, joabreu@synopsys.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Remove break after a return
Message-ID: <20191009211327.7e707d36@cakuba.netronome.com>
In-Reply-To: <1570631340-5467-1-git-send-email-yangtiezhu@loongson.cn>
References: <1570631340-5467-1-git-send-email-yangtiezhu@loongson.cn>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Oct 2019 22:29:00 +0800, Tiezhu Yang wrote:
> Since break is not useful after a return, remove it.
> 
> Fixes: 3b57de958e2a ("net: stmmac: Support devicetree configs for mcast and ucast filter entries")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Applied, thanks
